Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E71ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0352720CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0352720CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7yYo-0001yc-65
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1i7y12-0005fo-Cr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1i7y10-0000Mn-SY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:30:16 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:34625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1i7y0x-00007A-In; Wed, 11 Sep 2019 04:30:11 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 3605D7456D6;
 Wed, 11 Sep 2019 10:30:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 04CEA7456CA; Wed, 11 Sep 2019 10:30:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 03AC47456D5;
 Wed, 11 Sep 2019 10:30:00 +0200 (CEST)
Date: Wed, 11 Sep 2019 10:29:59 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
In-Reply-To: <20190910193408.28917-3-alex.bennee@linaro.org>
Message-ID: <alpine.BSF.2.21.9999.1909111015260.4726@zero.eik.bme.hu>
References: <20190910193408.28917-1-alex.bennee@linaro.org>
 <20190910193408.28917-3-alex.bennee@linaro.org>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-ID: <alpine.BSF.2.21.9999.1909111026190.4726@zero.eik.bme.hu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v1 2/4] elf: move elf.h to elf/elf.h and
 split out types
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
Cc: peter.maydell@linaro.org,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, qemu-devel@nongnu.org,
 "open list:S390-ccw boot" <qemu-s390x@nongnu.org>, qemu-arm@nongnu.org,
 "open list:PReP" <qemu-ppc@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Sep 2019, Alex Benn=E9e wrote:
> diff --git a/include/elf/elf-types.inc.h b/include/elf/elf-types.inc.h
> new file mode 100644
> index 00000000000..35163adb2b5
> --- /dev/null
> +++ b/include/elf/elf-types.inc.h
> @@ -0,0 +1,63 @@
> +/*
> + * Elf Type Specialisation
> + *
> + * Copyright (c) 2019
> + * Written by Alex Benn=E9e <alex.bennee@linaro.org>
> + *
> + * This code is licensed under the GNU .

You're missing end of licence sentence here. Also original file did not=20
have copyright and licence header so you may want to fix that too or leav=
e=20
it out here as well for consistency,

> + */
> +
> +#ifndef _ELF_TYPES_INC_H_
> +#define _ELF_TYPES_INC_H_
> +
> +#ifndef ELF_CLASS
> +#error you must define ELF_CLASS before including elf-types.inc.h
> +#else
> +
> +#if ELF_CLASS =3D=3D ELFCLASS32
> +
> +#define elfhdr      elf32_hdr
> +#define elf_phdr    elf32_phdr
> +#define elf_note    elf32_note
> +#define elf_shdr    elf32_shdr
> +#define elf_sym     elf32_sym
> +#define elf_addr_t  Elf32_Off
> +#define elf_rela    elf32_rela
> +
> +#ifdef ELF_USES_RELOCA
> +# define ELF_RELOC  Elf32_Rela
> +#else
> +# define ELF_RELOC  Elf32_Rel
> +#endif
> +
> +#ifndef ElfW
> +#  define ElfW(x)   Elf32_ ## x
> +#  define ELFW(x)   ELF32_ ## x
> +#endif
> +
> +#else /* ELF_CLASS =3D=3D ELFCLASS64 */
> +
> +#define elfhdr      elf64_hdr
> +#define elf_phdr    elf64_phdr
> +#define elf_note    elf64_note
> +#define elf_shdr    elf64_shdr
> +#define elf_sym     elf64_sym
> +#define elf_addr_t  Elf64_Off
> +#define elf_rela    elf64_rela
> +
> +#ifdef ELF_USES_RELOCA
> +# define ELF_RELOC  Elf64_Rela
> +#else
> +# define ELF_RELOC  Elf64_Rel
> +#endif
> +
> +#ifndef ElfW
> +#  define ElfW(x)   Elf64_ ## x
> +#  define ELFW(x)   ELF64_ ## x
> +#endif
> +
> +#endif /* ELF_CLASS =3D=3D ELFCLASS64 */
> +#endif /* ELF_CLASS */
> +#else
> +#error elf-types.inc.h should not be included twice in one compilation=
 unit
> +#endif /* _ELF_TYPES_INC_H_ */
> diff --git a/include/elf.h b/include/elf/elf.h
> similarity index 98%
> rename from include/elf.h
> rename to include/elf/elf.h
> index 3501e0c8d03..2e264c1a7a0 100644
> --- a/include/elf.h
> +++ b/include/elf/elf.h
> @@ -1696,49 +1696,7 @@ struct elf32_fdpic_loadmap {
> };
>
> #ifdef ELF_CLASS
> -#if ELF_CLASS =3D=3D ELFCLASS32
> -
> -#define elfhdr		elf32_hdr
> -#define elf_phdr	elf32_phdr
> -#define elf_note	elf32_note
> -#define elf_shdr	elf32_shdr
> -#define elf_sym		elf32_sym
> -#define elf_addr_t	Elf32_Off
> -#define elf_rela  elf32_rela
> -
> -#ifdef ELF_USES_RELOCA
> -# define ELF_RELOC      Elf32_Rela
> -#else
> -# define ELF_RELOC      Elf32_Rel
> -#endif
> -
> -#else
> -
> -#define elfhdr		elf64_hdr
> -#define elf_phdr	elf64_phdr
> -#define elf_note	elf64_note
> -#define elf_shdr	elf64_shdr
> -#define elf_sym		elf64_sym
> -#define elf_addr_t	Elf64_Off
> -#define elf_rela  elf64_rela
> -
> -#ifdef ELF_USES_RELOCA
> -# define ELF_RELOC      Elf64_Rela
> -#else
> -# define ELF_RELOC      Elf64_Rel
> -#endif
> -
> -#endif /* ELF_CLASS */
>
> -#ifndef ElfW
> -# if ELF_CLASS =3D=3D ELFCLASS32
> -#  define ElfW(x)  Elf32_ ## x
> -#  define ELFW(x)  ELF32_ ## x
> -# else
> -#  define ElfW(x)  Elf64_ ## x
> -#  define ELFW(x)  ELF64_ ## x
> -# endif
> -#endif
>
> #endif /* ELF_CLASS */

Is there anything remaining in this #ifdef ELF_CLASS after this patch? If=
=20
not why do you keep it?

Regards,
BALATON Zoltan
