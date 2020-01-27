Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3377AC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 07:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0FB20702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 07:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyp93t2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0FB20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivynH-0000sT-4F
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 02:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivymS-0000LR-N2
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ivymQ-0003Uz-8M
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:25:56 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ivymQ-0003UK-12
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 02:25:54 -0500
Received: by mail-ot1-x344.google.com with SMTP id d3so7146651otp.4
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2020 23:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ifJ+qc8puuujGB6Cvg83hZhE0hMg55OHc17ESvFBZeM=;
 b=qyp93t2QxTJ+T2ecqWl+SXFoSU8MbpWx8KQsuxxPSDjmyO1ywdQ6/b8Hj6H8ErGb+u
 dnYI9vtGfB2c9MQ0awsQQexoUlB/81WoLbHJa6vF9TP5nJsB6/M7fcRmTBNjbP7Tv1vw
 rFYRu7hhYGCYbKNOAUUlkZU56sFnXHyRjTK0TrFK5b2uV2uYnkv+9p4r6xkVqW+Z7bL1
 ugjQ98DhoI78UQ7wuNJUnJLiyk+OlqkLn0MuKVD67380w9kh9iJdbeDzDt7Vc5FgTUlk
 w6tsIOC9E23n8OV50eODyFJr5kH3WnkiQ/hVheu36zw13OkXFyQoQobEwVaJ88MqaFCd
 6VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ifJ+qc8puuujGB6Cvg83hZhE0hMg55OHc17ESvFBZeM=;
 b=WYHpvGshJmefeo8oQKQyE9ppvVUraN1s/FA7unkfqvHN0JzwfuE8LEAxnMmPT3HeWB
 d57Dw+Hq5M3GODcQvdYuNM3isBFiu1NSTG58ybLQd0gROWKxGqpbzuiXynJCVD1rvu2h
 k/84H0uqmnGU5j/XfHsFo4v1g7cra/gwvkAW2VXaY0IbTXB1oPGnWUeVWAO9yG81ZJeS
 cjlsJ7uZV3kSbB3slcXP6H0xSlZGJzDBcKUnW2zZcmQOZ8bPMI7E9ySTxWfWcmqj9g3I
 kxPkc6lYHn+gJlMs1vAKfplbgmOrhcWO2PnGKX04A7waoxAbUX1ztB1eEQjqJ1R+1Rg5
 68CA==
X-Gm-Message-State: APjAAAWHcr3sY2t7VuWKa50fT2+gRabByWMCfeH0oNuPNXrotzJrlQDV
 KbAwy5SmRegcN5jmF8RUYEkY/nWdypHiN8hW0/M=
X-Google-Smtp-Source: APXvYqwssM4GH3HFvsQzOlTYBSVwd+MKm33pkoQ/GCthKDl24l0Bq+uYDDdtzhhiB3WLyn+XPF/pYmVnEBhWYkHocSE=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr11061668otk.64.1580109952914; 
 Sun, 26 Jan 2020 23:25:52 -0800 (PST)
MIME-Version: 1.0
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-25-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1580079311-20447-25-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 27 Jan 2020 08:25:37 +0100
Message-ID: <CAL1e-=iMiByEZ9iiLtNsp9-O62GU8giXS1ScDxZMfYorr5yFJw@mail.gmail.com>
Subject: Re: [PATCH rc3 24/30] hw/avr: Add helper to load raw/ELF firmware
 binaries
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="0000000000007319a9059d1a04a9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007319a9059d1a04a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

23:56 Ned, 26.01.2020. Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Add avr_load_firmware() function to load firmware in ELF or
> raw binary format.
>
> [AM: Corrected the type of the variable containing e_flags]
>
> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> ---
>  hw/avr/Makefile.objs |  1 +
>  hw/avr/boot.c        | 74
++++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/avr/boot.h        | 33 +++++++++++++++++++++++
>  include/elf.h        |  2 ++
>  4 files changed, 110 insertions(+)
>  create mode 100644 hw/avr/Makefile.objs
>  create mode 100644 hw/avr/boot.c
>  create mode 100644 hw/avr/boot.h
>
> diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> new file mode 100644
> index 0000000..123f174
> --- /dev/null
> +++ b/hw/avr/Makefile.objs
> @@ -0,0 +1 @@
> +obj-y +=3D boot.o
> diff --git a/hw/avr/boot.c b/hw/avr/boot.c
> new file mode 100644
> index 0000000..9ac2c88
> --- /dev/null
> +++ b/hw/avr/boot.c
> @@ -0,0 +1,74 @@
> +/*
> + * AVR loader helpers
> + *
> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> + *
> + * This work is licensed under the terms of the GNU GPLv2 or later.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "hw/loader.h"
> +#include "elf.h"
> +#include "boot.h"
> +#include "qemu/error-report.h"
> +
> +bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
> +                       MemoryRegion *mr, const char *firmware)
> +{
> +    const char *filename;
> +    int bytes_loaded;
> +    uint64_t entry;
> +    uint32_t e_flags;
> +
> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
> +    if (filename =3D=3D NULL) {
> +        error_report("Unable to find %s", firmware);
> +        return false;
> +    }
> +
> +    bytes_loaded =3D load_elf_ram_sym(filename,
> +                                    NULL, NULL, NULL,
> +                                    &entry, NULL, NULL,
> +                                    &e_flags, 0, EM_AVR, 0, 0,
> +                                    NULL, true, NULL);
> +    if (bytes_loaded >=3D 0) {
> +        /* If ELF file is provided, determine CPU type reading ELF
e_flags. */
> +        const char *elf_cpu =3D avr_flags_to_cpu_type(e_flags, NULL);
> +        const char *mcu_cpu_type =3D object_get_typename(OBJECT(cpu));
> +        int cpu_len =3D strlen(mcu_cpu_type) - strlen(AVR_CPU_TYPE_SUFFI=
X);
> +
> +        if (entry) {
> +            error_report("BIOS entry_point must be 0x0000 "
> +                         "(ELF image '%s' has entry_point 0x%04" PRIx64
")",
> +                         firmware, entry);
> +            return false;
> +        }
> +        if (!elf_cpu) {
> +            warn_report("Could not determine CPU type for ELF image
'%s', "
> +                        "assuming '%.*s' CPU",
> +                         firmware, cpu_len, mcu_cpu_type);
> +            return true;
> +        }
> +        if (strcmp(elf_cpu, mcu_cpu_type)) {
> +            error_report("Current machine: %s with '%.*s' CPU",
> +                         MACHINE_GET_CLASS(ms)->desc, cpu_len,
mcu_cpu_type);
> +            error_report("ELF image '%s' is for '%.*s' CPU",
> +                         firmware,
> +                         (int)(strlen(elf_cpu) -
strlen(AVR_CPU_TYPE_SUFFIX)),
> +                         elf_cpu);
> +            return false;
> +        }
> +    } else {
> +        bytes_loaded =3D load_image_targphys(filename, OFFSET_CODE,
> +                                           memory_region_size(mr));
> +    }
> +    if (bytes_loaded < 0) {
> +        error_report("Unable to load firmware image %s as ELF or raw
binary",
> +                     firmware);
> +        return false;
> +    }
> +    return true;
> +}
> diff --git a/hw/avr/boot.h b/hw/avr/boot.h
> new file mode 100644
> index 0000000..62bc10c
> --- /dev/null
> +++ b/hw/avr/boot.h
> @@ -0,0 +1,33 @@
> +/*
> + * AVR loader helpers
> + *
> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> + *
> + * This work is licensed under the terms of the GNU GPLv2 or later.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_AVR_BOOT_H
> +#define HW_AVR_BOOT_H
> +
> +#include "hw/boards.h"
> +#include "cpu.h"
> +
> +/**
> + * avr_load_firmware:   load an image into a memory region
> + *
> + * @cpu:        Handle a AVR CPU object
> + * @ms:         A MachineState
> + * @mr:         Memory Region to load into
> + * @firmware:   Path to the firmware file (raw binary or ELF format)
> + *
> + * Load a firmware supplied by the machine or by the user  with the
> + * '-bios' command line option, and put it in target memory.
> + *
> + * Returns: true on success, false on error.
> + */
> +bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
> +                       MemoryRegion *mr, const char *firmware);
> +
> +#endif
> diff --git a/include/elf.h b/include/elf.h
> index 8fbfe60..3f08f68 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {
>  #define EM_MOXIE           223     /* Moxie processor family */
>  #define EM_MOXIE_OLD       0xFEED
>
> +#define EM_AVR 83 /* AVR 8-bit microcontroller */
> +

This line is misplaced - it should be placed earlier, to respect the order
of EM_XXX constants.

>  /* This is the info that is needed to parse the dynamic section of the
file */
>  #define DT_NULL                0
>  #define DT_NEEDED      1
> --
> 2.7.4
>

--0000000000007319a9059d1a04a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">23:56 Ned, 26.01.2020. Aleksandar Markovic &lt;<a href=3D"ma=
ilto:aleksandar.markovic@rt-rk.com">aleksandar.markovic@rt-rk.com</a>&gt; =
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.or=
g">f4bug@amsat.org</a>&gt;<br>
&gt;<br>
&gt; Add avr_load_firmware() function to load firmware in ELF or<br>
&gt; raw binary format.<br>
&gt;<br>
&gt; [AM: Corrected the type of the variable containing e_flags]<br>
&gt;<br>
&gt; Suggested-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.m=
ail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug=
@amsat.org">f4bug@amsat.org</a>&gt;<br>
&gt; Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.=
mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0hw/avr/Makefile.objs |=C2=A0 1 +<br>
&gt; =C2=A0hw/avr/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 74 ++++++++++++++++++=
++++++++++++++++++++++++++++++++++<br>
&gt; =C2=A0hw/avr/boot.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 33 ++++++++++++++++++=
+++++<br>
&gt; =C2=A0include/elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
&gt; =C2=A04 files changed, 110 insertions(+)<br>
&gt; =C2=A0create mode 100644 hw/avr/Makefile.objs<br>
&gt; =C2=A0create mode 100644 hw/avr/boot.c<br>
&gt; =C2=A0create mode 100644 hw/avr/boot.h<br>
&gt;<br>
&gt; diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs<br>
&gt; new file mode 100644<br>
&gt; index 0000000..123f174<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/avr/Makefile.objs<br>
&gt; @@ -0,0 +1 @@<br>
&gt; +obj-y +=3D boot.o<br>
&gt; diff --git a/hw/avr/boot.c b/hw/avr/boot.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..9ac2c88<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/avr/boot.c<br>
&gt; @@ -0,0 +1,74 @@<br>
&gt; +/*<br>
&gt; + * AVR loader helpers<br>
&gt; + *<br>
&gt; + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPLv2 or later.<b=
r>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu-common.h&quot;<br>
&gt; +#include &quot;hw/loader.h&quot;<br>
&gt; +#include &quot;elf.h&quot;<br>
&gt; +#include &quot;boot.h&quot;<br>
&gt; +#include &quot;qemu/error-report.h&quot;<br>
&gt; +<br>
&gt; +bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0MemoryRegion *mr, const char *firmware)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const char *filename;<br>
&gt; +=C2=A0 =C2=A0 int bytes_loaded;<br>
&gt; +=C2=A0 =C2=A0 uint64_t entry;<br>
&gt; +=C2=A0 =C2=A0 uint32_t e_flags;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmwa=
re);<br>
&gt; +=C2=A0 =C2=A0 if (filename =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Unable to find %s&quot=
;, firmware);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 bytes_loaded =3D load_elf_ram_sym(filename,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, NULL,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;entry, NULL, =
NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;e_flags, 0, E=
M_AVR, 0, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, true, NULL);=
<br>
&gt; +=C2=A0 =C2=A0 if (bytes_loaded &gt;=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If ELF file is provided, determine CPU=
 type reading ELF e_flags. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *elf_cpu =3D avr_flags_to_cpu_=
type(e_flags, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *mcu_cpu_type =3D object_get_t=
ypename(OBJECT(cpu));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int cpu_len =3D strlen(mcu_cpu_type) - st=
rlen(AVR_CPU_TYPE_SUFFIX);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (entry) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;BIOS ent=
ry_point must be 0x0000 &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;(ELF image &#39;%s&#39; has entry_point 0x%04&qu=
ot; PRIx64 &quot;)&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0firmware, entry);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!elf_cpu) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;Could not=
 determine CPU type for ELF image &#39;%s&#39;, &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;assuming &#39;%.*s&#39; CPU&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0firmware, cpu_len, mcu_cpu_type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(elf_cpu, mcu_cpu_type)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Current =
machine: %s with &#39;%.*s&#39; CPU&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0MACHINE_GET_CLASS(ms)-&gt;desc, cpu_len, mcu_cpu_type)=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;ELF imag=
e &#39;%s&#39; is for &#39;%.*s&#39; CPU&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0firmware,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(int)(strlen(elf_cpu) - strlen(AVR_CPU_TYPE_SUFFIX)),<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0elf_cpu);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bytes_loaded =3D load_image_targphys(file=
name, OFFSET_CODE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0memory_region_size(mr));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (bytes_loaded &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Unable to load firmwar=
e image %s as ELF or raw binary&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0firmware);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; diff --git a/hw/avr/boot.h b/hw/avr/boot.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..62bc10c<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/avr/boot.h<br>
&gt; @@ -0,0 +1,33 @@<br>
&gt; +/*<br>
&gt; + * AVR loader helpers<br>
&gt; + *<br>
&gt; + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPLv2 or later.<b=
r>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef HW_AVR_BOOT_H<br>
&gt; +#define HW_AVR_BOOT_H<br>
&gt; +<br>
&gt; +#include &quot;hw/boards.h&quot;<br>
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * avr_load_firmware:=C2=A0 =C2=A0load an image into a memory region<=
br>
&gt; + *<br>
&gt; + * @cpu:=C2=A0 =C2=A0 =C2=A0 =C2=A0 Handle a AVR CPU object<br>
&gt; + * @ms:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0A MachineState<br>
&gt; + * @mr:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Memory Region to load into<b=
r>
&gt; + * @firmware:=C2=A0 =C2=A0Path to the firmware file (raw binary or EL=
F format)<br>
&gt; + *<br>
&gt; + * Load a firmware supplied by the machine or by the user=C2=A0 with =
the<br>
&gt; + * &#39;-bios&#39; command line option, and put it in target memory.<=
br>
&gt; + *<br>
&gt; + * Returns: true on success, false on error.<br>
&gt; + */<br>
&gt; +bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0MemoryRegion *mr, const char *firmware);<br>
&gt; +<br>
&gt; +#endif<br>
&gt; diff --git a/include/elf.h b/include/elf.h<br>
&gt; index 8fbfe60..3f08f68 100644<br>
&gt; --- a/include/elf.h<br>
&gt; +++ b/include/elf.h<br>
&gt; @@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {<br>
&gt; =C2=A0#define EM_MOXIE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0223=C2=
=A0 =C2=A0 =C2=A0/* Moxie processor family */<br>
&gt; =C2=A0#define EM_MOXIE_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A00xFEED<br>
&gt;<br>
&gt; +#define EM_AVR 83 /* AVR 8-bit microcontroller */<br>
&gt; +</p>
<p dir=3D"ltr">This line is misplaced - it should be placed earlier, to res=
pect the order of EM_XXX constants.</p>
<p dir=3D"ltr">&gt; =C2=A0/* This is the info that is needed to parse the d=
ynamic section of the file */<br>
&gt; =C2=A0#define DT_NULL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0<br>
&gt; =C2=A0#define DT_NEEDED=C2=A0 =C2=A0 =C2=A0 1<br>
&gt; -- <br>
&gt; 2.7.4<br>
&gt;<br>
</p>

--0000000000007319a9059d1a04a9--

