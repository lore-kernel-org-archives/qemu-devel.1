Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E4AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2C0206BE
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGtZ8vnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2C0206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrjtB-0007D9-9R
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrjmN-0000Xx-Kz
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:08:35 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:36848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrjmL-0008Mk-Mg
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:08:35 -0400
Received: by mail-ot1-x32e.google.com with SMTP id 72so28621272otc.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=twZGc8eGfvP8h1KZ48qjcFmFtuBeqcURZyHq6MQuwbw=;
 b=iGtZ8vnJU086Z2sVo/imvEFIPRp2J8lYSbz3V3zzYmg5Zg/wbXOLUYTk0/q6XwSWsC
 BK1uf5Mb56FGmRgzEOqHb6oB+L5o9ZuzG7BKjr8oDF5tra0q2XYXU0J03CrtkfUsDsa7
 byPPMWeYs9c0loyE5uemfRne/Y29ZKsTd+rni4wikVea+H81f3dTn/KPts37lhtK1Elt
 MzHFlCGO1uLvcGQlsF92T4s2T3uEZoQ1OlK0PJ+Tn6sXT7u9s8orSHaPRm5ukSu7od5+
 FDGq5hNoFDkdBqDumGY6DfWe5G2IcCeZynMY1BeiX0oHfa4mqKqywban84aSYcB0zyKJ
 XgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=twZGc8eGfvP8h1KZ48qjcFmFtuBeqcURZyHq6MQuwbw=;
 b=cdaIZdpxeLKnZLvpPJPCGv7OQMM9c6ETtPgftXKQt/0j04EiKny2afw0HwGXmJAjte
 OErJQ0yRFqGIuPve5gFoXduiXhAqPuKrusVVW4sU75yz2fVe7ffdrYEMIogpMVa8bl76
 cL50QIFOOSP3T08w6QqI/9D7ZRGN9TmmHotdCiabiwGUx9eO7oDfILDoVRRL9UtEkzcb
 cSiw4Ni7jg5Jr3sAjouYPpBtke8RrAaHs/ZrErgbD2bepZj5QMoSEaPpE+dmZCOwtYdV
 NWrHHd+dFloBa9VWG/VL1UmiV/Az1NitfswlWXgWpuVzeHX9F73EmdJzVjzpe9Bzsr1H
 1YcA==
X-Gm-Message-State: AOAM530pIlnAbG42mvgrTKABZHtAE362VXmZf4OnL+SVVNb119cdjX7X
 N1Qv59qtiJyuPbBPwwyHPduj7ujwYLo72Jbw+r/uWA==
X-Google-Smtp-Source: ABdhPJyoRbhslcYS0lK5G04KsvgQ/pJd0bsbYug9eBI2z5FGPSmMfcM55CmObWqkftoDLEplq4IyGct9Di2kT/cggGM=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr32417186ota.91.1593875312329; 
 Sat, 04 Jul 2020 08:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200703152748.277255-1-dgilbert@redhat.com>
In-Reply-To: <20200703152748.277255-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Jul 2020 16:08:21 +0100
Message-ID: <CAFEAcA-jm4Mxrac_2c9H6rJT7LWPSg3nMQ5UV1vk2g9OvRb_8w@mail.gmail.com>
Subject: Re: [PULL 0/5] migration queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Keqian Zhu <zhukeqian1@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 16:30, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 6651620b92bc08cde07cb500e9a43dba7bd9b2b7:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/seabios-20200702-pull-request' into staging (2020-07-03 09:55:35 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20200703a
>
> for you to fetch changes up to fb6135807fcab4670d69663ac88e88e124348ffd:
>
>   migration: Count new_dirty instead of real_dirty (2020-07-03 16:23:05 +0100)
>
> ----------------------------------------------------------------
> virtiofsd+migration pull 2020-07-03
>
> A couple of small migration fixes, and some capability
> rework for virtiofsd.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

