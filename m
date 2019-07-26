Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748CEC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DBE2086D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obJaKR9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DBE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqx5n-00006s-1J
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 06:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35348)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqx5Y-0007yI-Bv
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqx5P-0005Mf-2v
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:04:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqx5N-00057a-2W
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:04:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id 31so53851968wrm.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 03:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=A8c7FBmQXbxBQU4P/pA8IP6ZkMx8Vsd6UVTL0vHFK6c=;
 b=obJaKR9lUi46r5KstPz4huq63FxrsWJ8eYpZGjp+OikXuDX1evQLGD3TBMi1Olf8D6
 5jor4DTUn/Xy1Qiqwu2C99gmPe7mU06oOMxoj2une4mtEgPCRzR13dKG4CR5U8ESfRdG
 nVAizwVESsjzY8kDOK/NCWa5zbMTYaxYbYTH6lXWvgKOvLo0yqLl3KnWhBMg+cZIjast
 ftKb3ZZHel/bGMFfE4/6ocR4ZeN6k+fiuiGkTX/Wojjgvvb8N0Ix4qDfEY+XGs4PNzC5
 D//VBvpo9IJuWxu2+YCgOPJidAFFSFlTdI+CNlWpyEEAQc8RNF0wM4BUJtBTzyIP1XWl
 /xTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=A8c7FBmQXbxBQU4P/pA8IP6ZkMx8Vsd6UVTL0vHFK6c=;
 b=Lw3duapGfNS4fzglwuCFzU8wfQEl0HW5zwkX2gaOIMN2y1HPybptrybwaB9USda4KO
 eIlv4F2B98NRzZsYHeuMi7z0LoUMEcHlh8Uz6QCKqKEcqOihaG/AkdbhBBDXEUvwj/dd
 TuWQeY7prBIfphXE73Mu6k93+3cm6rFiGng0w0uzds9eP2iyQ04mXyf+YFIAj8m3FNbA
 9A3Ex1UZPs6/ZZQXnjUPSnoZY52UhCqP+HJUDSyAI6JkuoHa9iDlRkUBiRA8fdrJmmRe
 JOUHwyJB24v6lcxbC12lzofuPpXI4vgT+sC0FlrkPGitJ4akR3EB1dQaohy4c9D6UrFW
 kotw==
X-Gm-Message-State: APjAAAUmQQkSmHyB91vYlFOu8mGs4KWBvDvbI1KCl7NsWC4Z2Qt92WSe
 erXcX28KnjlOFhd4bat8FC4blg==
X-Google-Smtp-Source: APXvYqwQk39TqK8PmN9MbLqVYl1MrYXzDpNPGJNbyu/8qARx/7TGaOFB0c20txmCvIwDxim0FB7IpQ==
X-Received: by 2002:adf:e84a:: with SMTP id d10mr12027178wrn.316.1564135458783; 
 Fri, 26 Jul 2019 03:04:18 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z5sm36048241wmf.48.2019.07.26.03.04.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 03:04:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CC6FD1FF87;
 Fri, 26 Jul 2019 11:04:17 +0100 (BST)
References: <20190722151804.25467-1-peter.maydell@linaro.org>
 <20190722151804.25467-2-peter.maydell@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190722151804.25467-2-peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 11:04:17 +0100
Message-ID: <87zhl1gli6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-4.1? 1/2] hw/arm/boot:
 Rename elf_{low, high}_addr to image_{low, high}_addr
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Rename the elf_low_addr and elf_high_addr variables to image_low_addr
> and image_high_addr -- in the next commit we will extend them to
> be set for other kinds of image file and not just ELF files.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/arm/boot.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 1fb24fbef27..b7b31753aca 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -986,7 +986,9 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
>      int kernel_size;
>      int initrd_size;
>      int is_linux =3D 0;
> -    uint64_t elf_entry, elf_low_addr, elf_high_addr;
> +    uint64_t elf_entry;
> +    /* Addresses of first byte used and first byte not used by the image=
 */
> +    uint64_t image_low_addr, image_high_addr;
>      int elf_machine;
>      hwaddr entry;
>      static const ARMInsnFixup *primary_loader;
> @@ -1014,24 +1016,24 @@ static void arm_setup_direct_kernel_boot(ARMCPU *=
cpu,
>          info->nb_cpus =3D 1;
>
>      /* Assume that raw images are linux kernels, and ELF images are not.=
  */
> -    kernel_size =3D arm_load_elf(info, &elf_entry, &elf_low_addr,
> -                               &elf_high_addr, elf_machine, as);
> +    kernel_size =3D arm_load_elf(info, &elf_entry, &image_low_addr,
> +                               &image_high_addr, elf_machine, as);
>      if (kernel_size > 0 && have_dtb(info)) {
>          /*
>           * If there is still some room left at the base of RAM, try and =
put
>           * the DTB there like we do for images loaded with -bios or -pfl=
ash.
>           */
> -        if (elf_low_addr > info->loader_start
> -            || elf_high_addr < info->loader_start) {
> +        if (image_low_addr > info->loader_start
> +            || image_high_addr < info->loader_start) {
>              /*
> -             * Set elf_low_addr as address limit for arm_load_dtb if it =
may be
> +             * Set image_low_addr as address limit for arm_load_dtb if i=
t may be
>               * pointing into RAM, otherwise pass '0' (no limit)
>               */
> -            if (elf_low_addr < info->loader_start) {
> -                elf_low_addr =3D 0;
> +            if (image_low_addr < info->loader_start) {
> +                image_low_addr =3D 0;
>              }
>              info->dtb_start =3D info->loader_start;
> -            info->dtb_limit =3D elf_low_addr;
> +            info->dtb_limit =3D image_low_addr;
>          }
>      }
>      entry =3D elf_entry;


--
Alex Benn=C3=A9e

