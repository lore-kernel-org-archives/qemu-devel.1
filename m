Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1F6C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD58120658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZdEQioM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD58120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9lN-00046m-24
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jE9jI-0002En-PE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jE9jH-0006S2-0M
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:45:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jE9jG-0006FP-Gi; Tue, 17 Mar 2020 06:45:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id 6so24951376wre.4;
 Tue, 17 Mar 2020 03:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cG0+Tw2MoGN7C/riLxUa3AlBIsSXCDnmaYVircrkrMU=;
 b=uZdEQioMM6iN6B38QrPgpSlli5TIfy0zHxLi0SwiqWxbOtacS0+pnEqZVWx5lLmMX1
 J31kXbhKNoVn0Zc2Enc66vae9ogLrAFSAu9mWmG2H0dmw3umDxBWldj8rPs+o5MS0o5j
 Wo9vBiUNsMwczMqhYhQNWZ+TB3VWJ2l4tvr1ZlxBgKJFgJ0gmAIs00QpzauSSkhOk9m9
 UoWzQ/4UBKPQcBgO3DK8vjb5LcG+Jx4nObVRvkYpROG7RiAuqI1Kwv32o0Cx9xFOJPI1
 iHXYTIyGXy1J7BifuYYM07JHDPwcSLSnRcimEXkWgS/rLA1Uqnaa36jAU3Ztw79x6Pva
 IFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cG0+Tw2MoGN7C/riLxUa3AlBIsSXCDnmaYVircrkrMU=;
 b=hCdscMlDF8Z0BENE6KEu0g1tdMiz/9FJCPWcH3FItWMriD7r10Gf2oPIsQ55hk4k4v
 mgVNWpHlisQ+rNAtaU3bhcwwICMkl/j+/fnO458L6VXP5OdJZplC/IRGStQHhHlRBDQY
 kJ9cnstYuCvw9MxMDcFo+E9vV1POM//rxu4EEZ6hejiotPrQMTkYun1oHuh60XWMKZiJ
 B+K4tofMiX/HRo1VDa7Qj4ZafeKNmBfW0XM8/iMogvbuKQvXQX2fhMjG57gnP/OjGdzW
 gCYLNxxF8upntm4tDPJh7dsrl0iJsXwvahxyQHExXIha5BT9gVQMTaEA3QxWZjWfRNJX
 x8IA==
X-Gm-Message-State: ANhLgQ0xzZf7ApQM7Tk8AIkyV02rAQSALjcaYv5g73bdlMWS6HBTbpuu
 ZMvLGM3ZUE9dRerWZva+eH3CRu2dtus4M36ZQwc=
X-Google-Smtp-Source: ADFU+vt7Js4pgcgRflHF4Vhqrrj5CVi/f0Dws12kKSEqnKA5TR7tJGh4TrVzyF97okdHJTa0+2QOf9f/lKarM05sYXw=
X-Received: by 2002:adf:e9cc:: with SMTP id l12mr5317024wrn.420.1584441938187; 
 Tue, 17 Mar 2020 03:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-25-alex.bennee@linaro.org>
 <3d01f357-eeb6-7fd7-1895-feae05beca99@redhat.com>
In-Reply-To: <3d01f357-eeb6-7fd7-1895-feae05beca99@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 17 Mar 2020 11:45:27 +0100
Message-ID: <CAHiYmc5CtAH-zs38YmyLkrrp2DnxzLUWNKBTcL+oyFNEiCsV8A@mail.gmail.com>
Subject: Re: [PATCH v1 24/28] tests/tcg/aarch64: add SVE iotcl test
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 17. =D0=BC=D0=B0=D1=80 2020. =D1=83 11:33 Philippe Math=
ieu-Daud=C3=A9 <philmd@redhat.com>
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 3/16/20 6:21 PM, Alex Benn=C3=A9e wrote:
> > This is a fairly bare-bones test of setting the various vector sizes
> > for SVE which will only fail if the PR_SVE_SET_VL can't reduce the
> > user-space vector length by powers of 2.
> >
> > However we will also be able to use it in a future test which
> > exercises the GDB stub.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

I think it would be clearer and better if you used used the
word "prctl" rather than "ioctl" in both title/commit message
and code (including comments).

I think it is also a little problematic that tests like this reside
and belong in tests/tcg - since they deal more with elements
of kernel interface (system call prctl()), rather than TCG.
Still, I see there are many other similar cases in tests/tcg,
so probably (at this moment) one should't bother about it in
the context of this patch. However, in general, the location
/tests/tcg for all these cases seems wrong to me.

Sincerely,
Aleksandar

> >
> > ---
> > v3
> >    - use index to fill zreg
> >    - CROSS_CC_HAS_SVE
> > v5
> >    - merge conflicts
> > v6
> >    - drop id check
> > ---
> >   tests/tcg/aarch64/sve-ioctls.c    | 70 ++++++++++++++++++++++++++++++=
+
> >   tests/tcg/aarch64/Makefile.target |  4 ++
> >   2 files changed, 74 insertions(+)
> >   create mode 100644 tests/tcg/aarch64/sve-ioctls.c
> >
> > diff --git a/tests/tcg/aarch64/sve-ioctls.c b/tests/tcg/aarch64/sve-ioc=
tls.c
> > new file mode 100644
> > index 00000000000..9544dffa0ee
> > --- /dev/null
> > +++ b/tests/tcg/aarch64/sve-ioctls.c
> > @@ -0,0 +1,70 @@
> > +/*
> > + * SVE ioctls tests
> > + *
> > + * Test the SVE width setting ioctls work and provide a base for
> > + * testing the gdbstub.
> > + *
> > + * Copyright (c) 2019 Linaro Ltd
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#include <sys/prctl.h>
> > +#include <asm/hwcap.h>
> > +#include <stdio.h>
> > +#include <sys/auxv.h>
> > +#include <stdint.h>
> > +#include <stdlib.h>
> > +
> > +#ifndef HWCAP_CPUID
> > +#define HWCAP_CPUID (1 << 11)
> > +#endif
> > +
> > +#define SVE_MAX_QUADS  (2048 / 128)
> > +#define BYTES_PER_QUAD (128 / 8)
> > +
> > +#define get_cpu_reg(id) ({                                      \
> > +            unsigned long __val;                                \
> > +            asm("mrs %0, "#id : "=3Dr" (__val));                  \
> > +            __val;                                              \
> > +        })
> > +
> > +static int do_sve_ioctl_test(void)
> > +{
> > +    int i, res, init_vq;
> > +
> > +    res =3D prctl(PR_SVE_GET_VL, 0, 0, 0, 0);
> > +    if (res < 0) {
> > +        printf("FAILED to PR_SVE_GET_VL (%d)", res);
> > +        return -1;
> > +    }
> > +    init_vq =3D res & PR_SVE_VL_LEN_MASK;
> > +
> > +    for (i =3D init_vq; i > 15; i /=3D 2) {
> > +        printf("Checking PR_SVE_SET_VL=3D%d\n", i);
> > +        res =3D prctl(PR_SVE_SET_VL, i, 0, 0, 0, 0);
> > +        if (res < 0) {
> > +            printf("FAILED to PR_SVE_SET_VL (%d)", res);
> > +            return -1;
> > +        }
> > +        asm("index z0.b, #0, #1\n"
> > +            ".global __sve_ld_done\n"
> > +            "__sve_ld_done:\n"
> > +            "mov z0.b, #0\n"
> > +            : /* no outputs kept */
> > +            : /* no inputs */
> > +            : "memory", "z0");
> > +    }
> > +    printf("PASS\n");
> > +    return 0;
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    /* we also need to probe for the ioctl support */
> > +    if (getauxval(AT_HWCAP) & HWCAP_SVE) {
> > +        return do_sve_ioctl_test();
> > +    } else {
> > +        printf("SKIP: no HWCAP_SVE on this system\n");
> > +        return 0;
> > +    }
> > +}
> > diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Make=
file.target
> > index b61b53e4dd1..c879932ff6c 100644
> > --- a/tests/tcg/aarch64/Makefile.target
> > +++ b/tests/tcg/aarch64/Makefile.target
> > @@ -47,6 +47,10 @@ ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_SVE),)
> >   AARCH64_TESTS +=3D sysregs
> >   sysregs: CFLAGS+=3D-march=3Darmv8.1-a+sve
> >
> > +# SVE ioctl test
> > +AARCH64_TESTS +=3D sve-ioctls
> > +sve-ioctls: CFLAGS+=3D-march=3Darmv8.1-a+sve
> > +
> >   ifneq ($(HAVE_GDB_BIN),)
> >   GDB_SCRIPT=3D$(SRC_PATH)/tests/guest-debug/run-test.py
> >
> >
>
>

