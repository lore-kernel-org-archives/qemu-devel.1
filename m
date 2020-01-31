Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B738C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6411F20661
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT6MDQcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6411F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixK9e-00076p-M3
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 19:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixK8z-0006gm-Ph
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:26:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ixK8y-0007MB-Eh
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:26:45 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ixK8y-0007KH-8A
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:26:44 -0500
Received: by mail-ot1-x342.google.com with SMTP id r27so4950785otc.8
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=H4xpmqgFW3KkdbVZjG+NxCO22GMKd0vAGj3krkBMfXo=;
 b=WT6MDQcu0crOUWTeqdQPqqsw4repCgUEHQdUWCYg91as2oL1ytQrYSYzrgDGe4mswl
 lDwhANlrScqzGJ2xm5JRcvrndZ7jXW6LMd7lITAPYjqAWnZcEsz+EEVvt8SzLQs6VWx4
 XFyCXFauEDfN/LSXjJUXYA31+oErJJ0252ekOUA455Te4m2k8Qvt9QqSFhCssnFm3hlF
 SjWxpFtRFdwHzo24+mkkuQQXEuQQrg8CTm/g6SQ/b/lH+K9yTBkRjWL3OYXnQYU8vTlQ
 XBt9T5O7Sau1cHgsckzs338VpdGLWkQNg/mD98754hy00pmZSHjcPBRjmqrbnm0IidDm
 11bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=H4xpmqgFW3KkdbVZjG+NxCO22GMKd0vAGj3krkBMfXo=;
 b=iQ8pDHrmmRUeR6LyXm/zUGMlKMIWgTufp79+pPNp94szCPmKXl78qNRqZOMHBIkNUh
 vZSEm2kPPO4mKu9B7beSBZxim8NwBYIAeHwZS+HMo6O5y2tbeAn048u3iWrjTcP3L3BS
 kmjyWhZhJpjAu2iE7aZiD/qAe9iyt4N624p3vdgNTRayHhw1HKiXA1BT954Azuuop6wo
 8sEiV3LIlE8Hcmqd1iETUkFifMHnTAq8NJrIlEUX4aTGuwArRod4Ab1rWSMl0AwIy3OQ
 tVzpqtoVnhLHsLNy7M9pjaa/tO/9XuZXp6wM3Xf5+Ei+pNaE9mgeSrHvCTV8NBS4Hx0I
 s6kA==
X-Gm-Message-State: APjAAAWTxOjsqAT9XxqIMLSdla6zofjVbUnjxd6yMrTA5wjhOBPbi+bs
 EK/yTN6LZrDsAb9alKuooPujEnis3j/v6gVN5sM=
X-Google-Smtp-Source: APXvYqxqQ/yB+PBVJiznVOX5DNNrqxe14jejZVI7xG9J+GHZ6dVsrNakIKLqwZtkMmcOeSHeeRYDf0cefNcFi080EV0=
X-Received: by 2002:a9d:6505:: with SMTP id i5mr5332035otl.121.1580430403143; 
 Thu, 30 Jan 2020 16:26:43 -0800 (PST)
MIME-Version: 1.0
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-24-git-send-email-aleksandar.markovic@rt-rk.com>
 <7b46b2c2-b6b0-3252-fe18-c9b803823506@redhat.com>
In-Reply-To: <7b46b2c2-b6b0-3252-fe18-c9b803823506@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 31 Jan 2020 01:26:31 +0100
Message-ID: <CAL1e-=gToiXtXAVxwn-Tf6ON8_87GLw=QTe8HCRhwCSMfmkVLg@mail.gmail.com>
Subject: Re: [PATCH rc4 23/29] hw/avr: Add helper to load raw/ELF firmware
 binaries
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 1:20 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 1/31/20 1:03 AM, Aleksandar Markovic wrote:
> > From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >
> > Add avr_load_firmware() function to load firmware in ELF or
> > raw binary format.
> >
> > [AM: Corrected the type of the variable containing e_flags]
> >
> > Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> > ---
> >   hw/avr/Makefile.objs |  1 +
> >   hw/avr/boot.c        | 74 +++++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   hw/avr/boot.h        | 33 +++++++++++++++++++++++
> >   include/elf.h        |  2 ++
> >   4 files changed, 110 insertions(+)
> >   create mode 100644 hw/avr/Makefile.objs
> >   create mode 100644 hw/avr/boot.c
> >   create mode 100644 hw/avr/boot.h
> >
> > diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
> > new file mode 100644
> > index 0000000..123f174
> > --- /dev/null
> > +++ b/hw/avr/Makefile.objs
> > @@ -0,0 +1 @@
> > +obj-y +=3D boot.o
> > diff --git a/hw/avr/boot.c b/hw/avr/boot.c
> > new file mode 100644
> > index 0000000..9ac2c88
> > --- /dev/null
> > +++ b/hw/avr/boot.c
> > @@ -0,0 +1,74 @@
> > +/*
> > + * AVR loader helpers
> > + *
> > + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> > + *
> > + * This work is licensed under the terms of the GNU GPLv2 or later.
> > + * See the COPYING file in the top-level directory.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu-common.h"
> > +#include "hw/loader.h"
> > +#include "elf.h"
> > +#include "boot.h"
> > +#include "qemu/error-report.h"
> > +
> > +bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
> > +                       MemoryRegion *mr, const char *firmware)
> > +{
> > +    const char *filename;
> > +    int bytes_loaded;
> > +    uint64_t entry;
> > +    uint32_t e_flags;
> > +
> > +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
> > +    if (filename =3D=3D NULL) {
> > +        error_report("Unable to find %s", firmware);
> > +        return false;
> > +    }
> > +
> > +    bytes_loaded =3D load_elf_ram_sym(filename,
> > +                                    NULL, NULL, NULL,
> > +                                    &entry, NULL, NULL,
> > +                                    &e_flags, 0, EM_AVR, 0, 0,
> > +                                    NULL, true, NULL);
> > +    if (bytes_loaded >=3D 0) {
> > +        /* If ELF file is provided, determine CPU type reading ELF e_f=
lags. */
> > +        const char *elf_cpu =3D avr_flags_to_cpu_type(e_flags, NULL);
> > +        const char *mcu_cpu_type =3D object_get_typename(OBJECT(cpu));
> > +        int cpu_len =3D strlen(mcu_cpu_type) - strlen(AVR_CPU_TYPE_SUF=
FIX);
> > +
> > +        if (entry) {
> > +            error_report("BIOS entry_point must be 0x0000 "
> > +                         "(ELF image '%s' has entry_point 0x%04" PRIx6=
4 ")",
> > +                         firmware, entry);
> > +            return false;
> > +        }
> > +        if (!elf_cpu) {
> > +            warn_report("Could not determine CPU type for ELF image '%=
s', "
> > +                        "assuming '%.*s' CPU",
> > +                         firmware, cpu_len, mcu_cpu_type);
> > +            return true;
> > +        }
> > +        if (strcmp(elf_cpu, mcu_cpu_type)) {
> > +            error_report("Current machine: %s with '%.*s' CPU",
> > +                         MACHINE_GET_CLASS(ms)->desc, cpu_len, mcu_cpu=
_type);
> > +            error_report("ELF image '%s' is for '%.*s' CPU",
> > +                         firmware,
> > +                         (int)(strlen(elf_cpu) - strlen(AVR_CPU_TYPE_S=
UFFIX)),
> > +                         elf_cpu);
> > +            return false;
> > +        }
> > +    } else {
> > +        bytes_loaded =3D load_image_targphys(filename, OFFSET_CODE,
> > +                                           memory_region_size(mr));
> > +    }
> > +    if (bytes_loaded < 0) {
> > +        error_report("Unable to load firmware image %s as ELF or raw b=
inary",
> > +                     firmware);
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > diff --git a/hw/avr/boot.h b/hw/avr/boot.h
> > new file mode 100644
> > index 0000000..62bc10c
> > --- /dev/null
> > +++ b/hw/avr/boot.h
> > @@ -0,0 +1,33 @@
> > +/*
> > + * AVR loader helpers
> > + *
> > + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> > + *
> > + * This work is licensed under the terms of the GNU GPLv2 or later.
> > + * See the COPYING file in the top-level directory.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#ifndef HW_AVR_BOOT_H
> > +#define HW_AVR_BOOT_H
> > +
> > +#include "hw/boards.h"
> > +#include "cpu.h"
> > +
> > +/**
> > + * avr_load_firmware:   load an image into a memory region
> > + *
> > + * @cpu:        Handle a AVR CPU object
> > + * @ms:         A MachineState
> > + * @mr:         Memory Region to load into
> > + * @firmware:   Path to the firmware file (raw binary or ELF format)
> > + *
> > + * Load a firmware supplied by the machine or by the user  with the
> > + * '-bios' command line option, and put it in target memory.
> > + *
> > + * Returns: true on success, false on error.
> > + */
> > +bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
> > +                       MemoryRegion *mr, const char *firmware);
> > +
> > +#endif
> > diff --git a/include/elf.h b/include/elf.h
> > index 8fbfe60..3f08f68 100644
> > --- a/include/elf.h
> > +++ b/include/elf.h
> > @@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {
> >   #define EM_MOXIE           223     /* Moxie processor family */
> >   #define EM_MOXIE_OLD       0xFEED
> >
> > +#define EM_AVR 83 /* AVR 8-bit microcontroller */
>
> IIRC from previous version you suggested to move this, I suppose between:
>
> #define EM_CRIS         76
>
> #define EM_V850         87
>

I forgot about that, thinking about other larger changes.

> > +
> >   /* This is the info that is needed to parse the dynamic section of th=
e file */
> >   #define DT_NULL             0
> >   #define DT_NEEDED   1
> >
>

