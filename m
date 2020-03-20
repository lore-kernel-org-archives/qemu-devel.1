Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7B0C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A9F20732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkadWTT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A9F20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGSH-0004XF-CX
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 08:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFGRb-0003oi-L9
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFGRZ-0001XN-Ns
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:08:07 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFGRZ-0001X6-8g
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:08:05 -0400
Received: by mail-ot1-x342.google.com with SMTP id a6so5652393otb.10
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gh3bW1J9ApWmULJ2Foue4aVHIIPc8LXbL3Bsggcekc8=;
 b=wkadWTT08oFZH2k6ux6zMFJpPIjZj8+uU7O2pPZncrRJt0got7D2SghdPHPfQcKeYm
 n2TksuXOBzI4FD2RlPsm6jaaGZK5JznIHcqaeFR1mePeAG1/nsMCtmdIh5CgrJ8EijOu
 QWe7POUqt0hrFhytUYbmXzBsMJ2YUSLtPXLF+owmpRagU42sAmRiqLLyGyLtnrrKcO0z
 qT76in8qRtBrtvxKalw21+BGZD/+AcEqCVVCS5hDmnQIWFOoYmHpk4ZWqTBcHXIHzAEU
 uY5Ahq0SSk/OHYeFiQW69kx+75YibVhq2j+Jw/3jU9EzfE9A7pgSqjZOQK4Mk1eJe9+1
 EjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gh3bW1J9ApWmULJ2Foue4aVHIIPc8LXbL3Bsggcekc8=;
 b=s1TI49B9U3xxMOcyE21tCyvxu18knoXEOFVHSo6xRjo6EKKmKAAeEjWm/IonNsf70F
 XFV+bTVoPeVGt61iKHBFjyl07qy3IxiDOSKMXGNQQ0JHi0bMEjkEXn0WAJsUeAsUhRBY
 cDwXpDRW3SyPjPba4EWgys+742ikrEjCmnC//MDzFsl/RJ1iTHJB05m4+ORJrsJEPJ71
 OapvArRL6pD4U29rZJLoyfeEtRPRcdq7BlgDRLf17qS3Wnbg7BclQw36egp4mc5xCdtv
 w3WTycyfcWIxn7r8oRZ6D7AGN0BdJlIoebBE47T5f61dyztftyeRx+ujY4LY2eQhGCFk
 XBvQ==
X-Gm-Message-State: ANhLgQ1ewHj96sXywQhJFhnHMejjoN8zKsaH2OgOv5+k6/0zOwsTJzyt
 dLIcWSDRAFIhlErO3n2K7rDqsN014ua8SxShtbqxGg==
X-Google-Smtp-Source: ADFU+vsYxWqvtBz920StPHCKdl0MiAZeAtNLiuXcS9abIYZnCx3QEwg3V4cxYipnQNfm+PXsoCkC12QdP/7+T1cCQXA=
X-Received: by 2002:a05:6830:20c8:: with SMTP id
 z8mr6344662otq.135.1584706084168; 
 Fri, 20 Mar 2020 05:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200312164459.25924-1-peter.maydell@linaro.org>
 <20200312164459.25924-22-peter.maydell@linaro.org>
In-Reply-To: <20200312164459.25924-22-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 12:07:52 +0000
Message-ID: <CAFEAcA-F85aJ4yigDdEMd4=kAEaPV+f4zn9cuyhyoO-xhEcAng@mail.gmail.com>
Subject: Re: [PULL 21/36] hw/arm/allwinner-h3: add Boot ROM support
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Thu, 12 Mar 2020 at 16:45, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> From: Niek Linnenbank <nieklinnenbank@gmail.com>
>
> A real Allwinner H3 SoC contains a Boot ROM which is the
> first code that runs right after the SoC is powered on.
> The Boot ROM is responsible for loading user code (e.g. a bootloader)
> from any of the supported external devices and writing the downloaded
> code to internal SRAM. After loading the SoC begins executing the code
> written to SRAM.
>
> This commits adds emulation of the Boot ROM firmware setup functionality
> by loading user code from SD card in the A1 SRAM. While the A1 SRAM is
> 64KiB, we limit the size to 32KiB because the real H3 Boot ROM also rejec=
ts
> sizes larger than 32KiB. For reference, this behaviour is documented
> by the Linux Sunxi project wiki at:
>
>   https://linux-sunxi.org/BROM#U-Boot_SPL_limitations
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-id: 20200311221854.30370-11-nieklinnenbank@gmail.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hi; Coverity (CID 1421882) points out a possible NULL
pointer dereference in this change:

> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index d65bbf8a2fe..b8ebcb08b76 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -97,6 +97,11 @@ static void orangepi_init(MachineState *machine)
>      memory_region_add_subregion(get_system_memory(), h3->memmap[AW_H3_SD=
RAM],
>                                  machine->ram);
>
> +    /* Load target kernel or start using BootROM */
> +    if (!machine->kernel_filename && blk_is_available(blk)) {
> +        /* Use Boot ROM to copy data from SD card to SRAM */
> +        allwinner_h3_bootrom_setup(h3, blk);
> +    }

blk_is_available() assumes its argument is non-NULL, but
earlier in the function we set up blk with:
   b=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=BF=EF=BB=BFlk =3D d=
i ? blk_by_legacy_dinfo(di) : NULL;

so it can be NULL here.

Could you send a patch to fix this, please? Probably
just adding '&& blk' in the middle of the condition
is sufficient.

thanks
-- PMM

