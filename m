Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20186C433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34C82080D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WejlhzTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34C82080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrTd-0002M6-46
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxrRM-0007HB-Qw
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:32:14 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:35277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxrRK-0003Tp-Sv
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:32:12 -0400
Received: by mail-ot1-x335.google.com with SMTP id d4so14929350otk.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lUjXUHcNC2RKdxH82Y7OBdBYR3gP15O5mHU3+9XCGrU=;
 b=WejlhzTB05trDUuMLlbVziubchwaApyp7Hm8Y/alst+5K56DbhLRCZUfoGNMd+86hT
 Don1oaF6E2FixroraZZAYaKlkoYfHlld6nlUC1eAK/fGYtGxKab2thhyxrr51X2uZiCp
 5NSpKHCbyiHvKh2Emkr8qBCg8IxuHUASK+btZzSACINbfgc5+WMruXA+9jPmjT7lORKw
 C/UC7S5uUuZYOwSjGR4giWEKrP6VwU1pH6/XTrAVB+v7nKS9IL9sSOPXHj+kXwhc2mZR
 x/6sDvdHnb/zN1y5+zqGBhfIe4F9Xce7q20u0MV+17DA6gf6hlTrPUT8N4lGlvXdvxp9
 LYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lUjXUHcNC2RKdxH82Y7OBdBYR3gP15O5mHU3+9XCGrU=;
 b=i1WmSyCsz/T0RoRALjwHGg2anIltmqoUloTE4GvLXiaRh+8b1cFmEKU6Fzfnu3L7Eo
 BF4koTddaKVcKFrYjXuXT9xWMUxf5IgeBePex6TsxpfTVpP8YoCTVeSz2eG0uSLpTBIj
 NSafOqKRTkQ3v6N4T74QBqj1Jihah63nF39toLE7BW0mno2cgbbpFKCVk7U6Xe+cdUwX
 HalPn/5ZBicWWtLuCNB+2xE6lr9PS5N528PHMijhhc7wrZPUmy7Y4j8wog15671VgGyz
 8Cnk+PvicbTwqoztMVwhEAGSdEUhdGLhSXnexUXjrBJfJUGQGDr/L/9nfaBtBzrlij/Y
 wJ1A==
X-Gm-Message-State: AOAM530i/TZfhb3DMpBYvrKGfjjcuDbfaJQhQGjX2yhYBlEXIRPIwoWj
 tIA/o3FKXaNh2kJEu/9gmyevd3BADxj01hzqaymWWQ==
X-Google-Smtp-Source: ABdhPJy+Q1njas1wAZ7+gF8DjWqz1hOPBACGj9Tk3udQ4kr8O+bhRP9BMcMDfFw9Ib4gvywz+VfJeT1GPLEYO8fIDGs=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr24913851oto.135.1595334729311; 
 Tue, 21 Jul 2020 05:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
 <CAKXe6S+J3nARveToQjECbwV224gs66WkqGHybUhfw35t1+V8og@mail.gmail.com>
 <2cbdf822-c74c-1af9-e5e6-7dd71412201e@redhat.com>
 <CAKXe6S+ct7D+ibGmrAMJnqKBBKyUpwVnCem8=d=jB-0tUT-N2Q@mail.gmail.com>
 <e4a34525-dbd1-1f85-475b-b5004885215b@redhat.com>
 <CAKXe6SJb=1YLLGF+TP1fMd95k_WzZd73JeUJv5Sn4EE4m2zP4w@mail.gmail.com>
 <f19f605c-9468-e7eb-f255-60766df2a50c@redhat.com>
In-Reply-To: <f19f605c-9468-e7eb-f255-60766df2a50c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 13:31:57 +0100
Message-ID: <CAFEAcA-qrpXJtzW=tigyAqQuYFNCBMQK_CZFx6zYkcJa+RuZuw@mail.gmail.com>
Subject: Re: [Bug 1886362] [NEW] Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x335.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Bug 1886362 <1886362@bugs.launchpad.net>, Li Qiang <liq3ea@gmail.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020 at 09:36, Jason Wang <jasowang@redhat.com> wrote:
> I think the point is to make DMA to MMIO work as real hardware.

I wouldn't care to give a 100% guarantee that asking a real
h/w device to DMA to itself didn't cause it to misbehave :-)
It's more likely to happen-to-work because the DMA engine bit
of a real h/w device is going to be decoupled somewhat from
the respond-to-memory-transactions-for-registers logic, but
it probably wasn't something the designers were actively
thinking about either...

> For
> e1000e and other networking devices we need make sure such DMA doesn't
> break anything.

Yeah, this is the interesting part for QEMU. How should we
structure devices that do DMA so that we can be sure that
the device emulation at least doesn't crash? We could have
a rule that all devices that do DMA must always postpone
all of that DMA to a bottom-half, but that's a lot of
refactoring of a lot of device code...

thanks
-- PMM

