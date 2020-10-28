Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0698C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00B9246E5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvPzTn2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00B9246E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmLX-00058o-BS
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXmIE-0001tX-B1; Wed, 28 Oct 2020 10:19:14 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:35291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXmIB-0006j9-99; Wed, 28 Oct 2020 10:19:13 -0400
Received: by mail-io1-xd43.google.com with SMTP id k6so5505421ior.2;
 Wed, 28 Oct 2020 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bSgEQ8rqHi5Q5mtm1n6ven7ZPrARrwvFnMnbHSoiGmc=;
 b=IvPzTn2gNhJ2XITZUWPZPi+kJpUgINPS1fbPc0RCBosTLCSf577pB/591R6HoSXAwv
 Fu2kO4kM7cgsSf3Ize/T5Fp7qCoCeNfxcVGHbVsl0ToO/XnDI/oUwMoHsutWCmiR8kQg
 M0sXMbTwhtALvfM8V7uSFlBsONaQfX3eBj55MmFKWHfLMZSvnCeW+CIRTyJgo9O5lebz
 V/iNBawKqfoHCKRe0apJY/73p/e+DXCh8V24wMGXXfqXbhkxtibZ7YFRopMjl6Rjmnwp
 SefKvUfoFuLd85Sg5nTlxJbGsXwhXRv/g1TdnDpcrCvuMwF519NF7KFJgiEVbpyH7VdG
 tbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bSgEQ8rqHi5Q5mtm1n6ven7ZPrARrwvFnMnbHSoiGmc=;
 b=MlBNLK9mIEJ48zA/9X3abqEKidHT6XnpwWFpDBP/qsjw8vVO3594PfGuM5WWoQpEQ3
 5AoCX8sHjL4knRAi6BvJ3mMDFLqV53s6GUVUh6dL1AynVKCMGrLlKvR2+b07F38qvAj2
 QKzewB2nEQkiBwuZSTh/DnKUYMyv2tE++3uRStiYHEn9quAJtu0nn4DJZH23eDVZ8A9Z
 lr9x2tu3gPOieExBz1tD3rD892DkwyMBzw5SU3kKXEZ6s1AT15VJ/eZoHWeZvWaOX93W
 pl01nbYZ+bt1StYFWdTmM7cfUspE5znhNph8IKcp2CHH8nu+uq6GR9fJb2JRRKEuQujh
 dIdQ==
X-Gm-Message-State: AOAM531GxQhSoQFD+ouJy4WUk5rG6zM/h75lHOnTVtzWj53zfmhsUNof
 8YE0/VPDpvomTBPgjnDy5apc0eYLwGPXSez0Wu8=
X-Google-Smtp-Source: ABdhPJzDAuFR5YC1KS/MNG/cp2gk/kiND753CrhInPIJiLUuJPw+BmBi3z1WQStemfD+ByYJQkS4MOHWv9XGWtqe8KQ=
X-Received: by 2002:a6b:8ec7:: with SMTP id q190mr6285321iod.42.1603894749376; 
 Wed, 28 Oct 2020 07:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
 <1603863010-15807-2-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1603863010-15807-2-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Oct 2020 07:07:18 -0700
Message-ID: <CAKmqyKNLThFvp8CuueC7L7bcEdN6QS62k54ZRitTrcZdpvR-9w@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] hw/riscv: microchip_pfsoc: Document where to
 look at the SoC memory maps
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <anup.patel@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Ivan Griffin <ivan.griffin@emdalo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 10:31 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> It is not easy to find out the memory map for a specific component
> in the PolarFire SoC as the information is scattered in different
> documents. Add some comments so that people can know where to get
> such information from the Microchip website.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v2:
> - new patch: Document where to look at the PolarFire SoC memory maps
>
>  hw/riscv/microchip_pfsoc.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 4627179..6aac849 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -66,6 +66,24 @@
>  /* GEM version */
>  #define GEM_REVISION    0x0107010c
>
> +/*
> + * The complete description of the whole PolarFire SoC memory map is scattered
> + * in different documents. There are several places to look at for memory maps:
> + *
> + * 1 Chapter 11 "MSS Memory Map", in the doc "UG0880: PolarFire SoC FPGA
> + *   Microprocessor Subsystem (MSS) User Guide", which can be downloaded from
> + *   https://www.microsemi.com/document-portal/doc_download/
> + *   1244570-ug0880-polarfire-soc-fpga-microprocessor-subsystem-mss-user-guide,
> + *   describes the whole picture of the PolarFire SoC memory map.
> + *
> + * 2 A zip file for PolarFire soC memory map, which can be downloaded from
> + *   https://www.microsemi.com/document-portal/doc_download/
> + *   1244581-polarfire-soc-register-map, contains the following 2 major parts:
> + *   - Register Map/PF_SoC_RegMap_V1_1/pfsoc_regmap.htm
> + *     describes the complete integrated peripherals memory map
> + *   - Register Map/PF_SoC_RegMap_V1_1/MPFS250T/mpfs250t_ioscb_memmap_dri.htm
> + *     describes the complete IOSCB modules memory maps
> + */
>  static const struct MemmapEntry {
>      hwaddr base;
>      hwaddr size;
> --
> 2.7.4
>
>

