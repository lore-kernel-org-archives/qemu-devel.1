Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E55C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 22:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331EB2075A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 22:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NASQFeid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331EB2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFmQp-0004lA-0b
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 18:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFmQI-0004M1-6C
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 18:49:10 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:43388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFmQA-0000Al-Qm
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 18:49:09 -0400
Received: by mail-ej1-x636.google.com with SMTP id o8so686034ejb.10
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 15:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8+eVzwfcpbUYFVSE+MxbnKgKG7zPbk09/NY2x6qGiA0=;
 b=NASQFeidGVhAJB9zeUqI9FmpQ5upeXaQKIUUP4KjJDk0OhIDpr6NaUO1um6y+TkDA2
 i78rrl9gfbiSoR/3u69fPsxjbCMJKfw9dC6YGYt/aJHQ/GWJt/MUwtyDmMOjhMh/f2K8
 6/4TCeHzlG/1jXN/4ndC+z6Vo8LIa/yrHkQWNP1uOar8CPHVpIcEPweKJwAoItqHQ74G
 JUdEJSsVAFqY8lIlRyTp4txE6BaEZBoojxNMgHnYAdIT24BPYH6f6ZrQ5i2zMDNaCxR7
 dLWIz57JG1GOS9qYu9Se8qik2mNeDvkLxtkYA0wPzxPb9ug/3WKjkoHDlV1hycardce6
 h7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8+eVzwfcpbUYFVSE+MxbnKgKG7zPbk09/NY2x6qGiA0=;
 b=Etr9g73IBL40DKIKE7JJsNmw/h5r7VUH6IP/R2aLoKd3gk3nfohioqHkxrU31UYadZ
 gpx77ZqDYla/JZx5NQ0f+FvhPzl+WLHYucJBfiltTfEwXsWJo4Uj247YbzH3jsE2oYUv
 LYavzUoIktQ/sr9GPgsn5xQzt7ZToMO8LZRu2TH7CGPKVR74kVO23efr3ywAaYecp9+h
 jPhI5z+wkrvntEBWFcoMPnEgyLCKCLO4NN0RUlYclwORAzJ971jpqvAP6FAi+kfVnWw8
 1aMb55rZP+KJIiKFyvJgJ+Da3hZYeNEm+pt2hsD/NqA+GL+hHoYyS8ItkMd8Iv9fvdbk
 Ggmw==
X-Gm-Message-State: AOAM531HhA1v7F26qQjVNRvUetTTwZC1s/U3gmRkWCiwVS9FxSvBB3yr
 Brd4k0FLJJKAxwBo2UiHoTxwumCQQdPWRpCkRFxuBw==
X-Google-Smtp-Source: ABdhPJzTutigcBksHqBo+7/R8w2i1BqNWr1w0PsNaaCHhnZUtu9qaceS7tWOeWYOVqNnmdW5Q/wcFtpsn9Rorvkhksc=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr771827ejb.4.1599605341181; 
 Tue, 08 Sep 2020 15:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200908061046.10871-1-kraxel@redhat.com>
In-Reply-To: <20200908061046.10871-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2020 23:48:50 +0100
Message-ID: <CAFEAcA-xvS4UdNg6NmcCRHRPPhRfOCNBD8zHMGc4-AGT8ERA9w@mail.gmail.com>
Subject: Re: [PULL 0/3] Sirius/ipxe 20200908 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 07:12, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e11bd71f89649da3cff439c030d2ccac0cc914e3:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-07' into staging (2020-09-07 16:51:00 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/sirius/ipxe-20200908-pull-request
>
> for you to fetch changes up to 3e570a9ae9b966362596fd649f2cbcff0b2199c9:
>
>   ipxe: update binaries (2020-09-08 08:08:30 +0200)
>
> ----------------------------------------------------------------
> ipxe: update to aug 2020 snapshot.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (3):
>   ipxe: update submodule
>   ipxe: drop ia32 efi roms
>   ipxe: update binaries


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

