Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005F9C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D132075A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOFXu5k2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D132075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNEcC-0007W6-T5
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNEax-00073a-6q
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:18:59 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:37764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNEav-0005ib-D7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:18:58 -0400
Received: by mail-ed1-x536.google.com with SMTP id n22so6099304edt.4
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GfhO7gXOntqWfjEyimNEV5x8TjNmt8dwRC4ngzqDlD4=;
 b=zOFXu5k2ynQfdfYVfO86EzCrflNxdHpWnkF6FZpiT1bHZeHcfX03pivI29kt1Mku1b
 RJ2H6A9ALu+NzyQzq2t+pKq2gT753HYt43Alsg+ApQSwuS4s4ign2Swb7ixdYjsZ0eBH
 DMxf62B1uY3h0/PIsnhyqx7fV8vB7zRa6nmv91gmDDCGPWX7xBS6rHwbL/QyJiuImzTL
 adh/miRd31SHRckCACFxR3g1ukPM6Yo7raEz3Yz6HDPQC2dszJhPNLnOUA0ltWLQxs5I
 xkCGBq3bAn465q7zC8hjWfTbv/EZb3Hxwmp22vxHK8Hv1NjEr7vDDLeSNCIKZzhV0LZE
 tHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GfhO7gXOntqWfjEyimNEV5x8TjNmt8dwRC4ngzqDlD4=;
 b=TqVfW74BPQgSgbHj1xe8eyKgKt7L159KbmLQGpw5sGSiQI215UZyPmsVVFttIqBb2K
 +AXgSzjNsaJRZeKJmYFa2TGnYTGPcs9dmy6vv2Z0iT/DmBVmpVq1spFF/NbX5ydVKaRV
 Jn2S/r8YTnRFYd5F8uTWNlymUEcs9caPzEb/DLLiXxFOJy83a6ZyUu+cnvtfslDGSD5K
 gumqHvPacsU1Hyq+obiu/k5mJCtGEZ2/nMuz7jMdaor8NNTx4i+ZM0h5ev3HVQtcAT0r
 0PBuUT4p/kJgCEhINViMqvxWGH2fzuxOv8dJZkt0/ScFRX+gq5SFHnX72Mo6He67CJtB
 /uBg==
X-Gm-Message-State: AOAM530YIztjEOdRNEL4G4L4Y4yj6aw/wG8w2Jqnq5KyG7QkML0lCsnE
 W7pkb6O0Up+km1I0D2zsOiPG+Daqcald/pUfuoBzxQ==
X-Google-Smtp-Source: ABdhPJwuB/tcMGGodOlZPZM/XuGkyVpdFdjdn01Afkj7nbLhPaDdP57/Y6H+FMj0RrvbutYLjuiP6pAcWUozJ63GYrs=
X-Received: by 2002:aa7:d58e:: with SMTP id r14mr3078863edq.52.1601381935666; 
 Tue, 29 Sep 2020 05:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200929095717.26745-1-kraxel@redhat.com>
In-Reply-To: <20200929095717.26745-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 13:18:44 +0100
Message-ID: <CAFEAcA9+YAmLc=ihd0Tca5Ti0rArD+H_2aH8OPxBXDMbehuamA@mail.gmail.com>
Subject: Re: [PULL 0/9] Vga 20200929 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Sep 2020 at 10:59, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 74504514b154ebebdff577d88e4bf5c13074e9ed:
>
>   Merge remote-tracking branch 'remotes/alistair/tags/pull-register-20200927'=
>  into staging (2020-09-28 16:49:10 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20200929-pull-request
>
> for you to fetch changes up to 97a0530bb71fb96468f218b622cd840e2c667bf6:
>
>   ppc/pseries: enable big-endian-framebuffer quirk for bochs-display and virt=
> io-vga (2020-09-29 10:08:25 +0200)
>
> ----------------------------------------------------------------
> virtio-vga: reset fix, bigendian fix.
> virtio-vga+spice: set monitor dimension via edid.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

