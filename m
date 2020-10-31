Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B73C388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 14:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A31A206C1
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 14:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pcGdEq6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A31A206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYs7D-0004hA-6I
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 10:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYs5n-0004FK-Te
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 10:42:55 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:37320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYs5m-00039T-21
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 10:42:55 -0400
Received: by mail-ej1-x62c.google.com with SMTP id p9so12591334eji.4
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qM8+keBlChR4O5a/CnKtjgBrchB/tAG30qLamM4YkE0=;
 b=pcGdEq6VaMXxlWk6z/V0ZLHOkL2Jlicf4mWEXKZuay5eNIFPceZMRQRFqgwJas29Bk
 YoI8TPNeS3DYmSubVgoGiV0zS69oGTA9hm+UUC0ELYpMy/TlLpo+6iGOQvmyPL6h0tnB
 IpIVK+sROwnv/W/c39ZHN/Bk9RFSP8WsVyq5jjrobixHD2QO0VlHmBjiXMBDp/Evbvjc
 katUvGlwRChdqOVWl0GOISecomQUO/PYqsJUTKv9+85LuNlskZDHE/nx3+D5SrXHsPiq
 QNx2PzQ2hVGH16vQBVWgJH451GwBYjNjLxLDcUSXrOPal6bloCf3MnjymK+7cDJMzO03
 NXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qM8+keBlChR4O5a/CnKtjgBrchB/tAG30qLamM4YkE0=;
 b=Tq//GwSUTJTTE5lEjdLuQlAE/RMsGSPJy0UaoiQV4wnvAWuEFWxezZs+UdFvuW3oYL
 XHhAuiDRrAQlsht7KYUybptTfMl9HLHUmitPXnk2nyrTnXSVHKJN8kXMMnnw4lnEK1nl
 TsdCB+yP9BTuExXbsRzGtpkSyBOYeVrBTHqV6+GiiWA/jvVEtnlHGIijVN23qDRPumRW
 PAlLklhg22p0pV9c89S9Nd4XFb8V5+6JBdtDYGtD/2d0u4KxvbaciGhBy/Vxh3f/M6Be
 CgAVZ9SHnytgu8rAPcDT3sOTHEok3V0wkVsOYaOmBlkG2r/K69FxiHfmunuMiaMw+ia2
 KuFQ==
X-Gm-Message-State: AOAM531hg9I1WTvZfnxEyPQ1c4zobrz65lCA9gBTI9/Q3nDXDvyy0+5R
 GwCpW2IkIAStykaQF/YTUj4Xu4I2Ckf2Q5AJxhaFaw==
X-Google-Smtp-Source: ABdhPJxQe45dI6ZaVX5WxrgmQN3dcllMSynlfG9WYR01U4keCsFJDXReIwN7lzQ/RdfkSXCM+AbNB+m+I9SHZ4Tzsx0=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr7188115ejb.85.1604155371925; 
 Sat, 31 Oct 2020 07:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201028082358.23761-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20201028082358.23761-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 31 Oct 2020 14:42:40 +0000
Message-ID: <CAFEAcA9u0Bz3sWd8vqSRkPc8pFJ8jEVSb+Sd15iR4saZEeY-uQ@mail.gmail.com>
Subject: Re: [PULL 00/10] qemu-sparc queue 20201028
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Wed, 28 Oct 2020 at 08:24, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit cfc1105649947f03134294a2448ce2b2e11745=
6f:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/acceptance-tes=
ting-20201026' into staging (2020-10-27 16:58:39 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-sparc-20201028
>
> for you to fetch changes up to 0980307e705b5677d9b4158a0a0346abf5041f33:
>
>   hw/pci-host/sabre: Simplify code initializing variable once (2020-10-28=
 07:59:26 +0000)
>
> ----------------------------------------------------------------
> qemu-sparc queue
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (6):
>       sparc32-dma: use object_initialize_child() for espdma and ledma chi=
ld objects
>       sparc32-ledma: use object_initialize_child() for lance child object
>       sparc32-espdma: use object_initialize_child() for esp child object
>       sparc32-ledma: don't reference nd_table directly within the device
>       sabre: don't call sysbus_mmio_map() in sabre_realize()
>       sabre: increase number of PCI bus IRQs from 32 to 64
>
> Philippe Mathieu-Daud=C3=A9 (4):
>       hw/display/tcx: Allow 64-bit accesses to framebuffer stippler and b=
litter
>       hw/pci-host/sabre: Update documentation link
>       hw/pci-host/sabre: Remove superfluous address range check
>       hw/pci-host/sabre: Simplify code initializing variable once


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

