Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8064C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AA9206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZkvTg04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AA9206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQsY-0005n5-N0
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 08:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iwQrh-0004iz-JK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:25:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iwQre-00076P-1d
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:25:13 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:37428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iwQrd-000765-S5
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:25:09 -0500
Received: by mail-qt1-x844.google.com with SMTP id w47so10207149qtk.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 05:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zJCzPy1WfKlNYgFlgLzC7PFu4OuJFHSGKe63ibXDB8w=;
 b=oZkvTg04yJhZWQGlRg0ex6btYREuZsbR6kkpJjDf8YOcSVz2T19m5b1j9wUTnfXObi
 pi10kX4dACIo4ej50j4U1Q4DAfyN85ohrfOPhzuUL58jJtbbRBffqSbEniPZAY+w9WbF
 X3K2GlgRcV21JYr1UXeycHaUVSJdH06FkXo3r1I1yogvxws78yUdt+SlBXhTSibwGeB3
 PVGWJlMwVI+bGq1FssF+IGl6QqHW9bpMQjfn7w87qe6RHRrf6KMaYWFXXsOY/s6CkPmv
 gE8cWqm+fBpNLOd11j7ib7x1qNyb1JJ0HNGGDfEzvfTkmLl7XS58MmRYeCV7M+4S+Wlo
 4cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zJCzPy1WfKlNYgFlgLzC7PFu4OuJFHSGKe63ibXDB8w=;
 b=hiVJEsf6ee89cTvX9O+VZlgd/duPU/ay1+OqmfeTAGc4n38ACu3dHfVPyaODHdMams
 AbXn8f95wTe0xztdp8UCw17YN5YA7gpDVKo193Zj5yi2HZpS1+JawEjU/VB2Dmrs9gbI
 Qzs85ML5p4k/jY3xmVRmGl4Z5pvE68VNtbfg77TIry/+AiGoZgPiPs+saZFDZENs6mxh
 p0GGXSg/N4D4sTfUbH4PicVZozDWV/TtQKgg6mGnFq7HOuoblProHYVmbt9M5rBD6r6v
 lEVuqr3IRaz4WtFDB5jQlRhkl5YcNWNklOgt/QxWXMkz0g0NhoMIQwluE/VKsgP4IkRa
 KTfA==
X-Gm-Message-State: APjAAAXvEJ3PqmbwQOFH5wDjniCW7+dgQeiJbn36+KfOP+pLUk3X+xoL
 XNTDhyu0+IqasPmUhecZPweAVcku5aZuRZpVU5w=
X-Google-Smtp-Source: APXvYqxpgAAx9sCd/bC6IPHglRiSknuXlBQfuie455sFR7D+50WbbSpHtFvJXTafDlZ9ykCAGodcJEuI4RZ4p1Vg3CI=
X-Received: by 2002:ac8:3886:: with SMTP id f6mr20800296qtc.160.1580217909162; 
 Tue, 28 Jan 2020 05:25:09 -0800 (PST)
MIME-Version: 1.0
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAK4993itnp5EyT8g-zGcMY6Oud9pC9GRv1Aa2dvofrH8mLWnOQ@mail.gmail.com>
In-Reply-To: <CAK4993itnp5EyT8g-zGcMY6Oud9pC9GRv1Aa2dvofrH8mLWnOQ@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 28 Jan 2020 15:25:02 +0200
Message-ID: <CAK4993hTqhuZArVNbNs8M8MJkdQbneq0fCsW2b2-fEKaAtCuOQ@mail.gmail.com>
Subject: Re: [PATCH rc3 01/30] target/avr: Add basic parameters for new AVR
 platform
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: multipart/alternative; boundary="00000000000024bdab059d332711"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000024bdab059d332711
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all.

I am totally lost in the email.
Are there any action items for me / someone else ?

Regards,
Michael Rolnik


On Mon, Jan 27, 2020 at 10:54 AM Michael Rolnik <mrolnik@gmail.com> wrote:

> Thanks for you help guys.
>
> On Mon, Jan 27, 2020 at 12:55 AM Aleksandar Markovic <
> aleksandar.markovic@rt-rk.com> wrote:
>
>> From: Michael Rolnik <mrolnik@gmail.com>
>>
>> This includes definitions of various basic parameters needed
>> for integration of a new platform into QEMU.
>>
>> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
>> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>> Acked-by: Igor Mammedov <imammedo@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>> ---
>>  target/avr/cpu-param.h | 37 ++++++++++++++++++++++++++
>>  target/avr/cpu.h       | 72
>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 109 insertions(+)
>>  create mode 100644 target/avr/cpu-param.h
>>  create mode 100644 target/avr/cpu.h
>>
>> diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
>> new file mode 100644
>> index 0000000..0c29ce4
>> --- /dev/null
>> +++ b/target/avr/cpu-param.h
>> @@ -0,0 +1,37 @@
>> +/*
>> + * QEMU AVR CPU
>> + *
>> + * Copyright (c) 2019 Michael Rolnik
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2.1 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see
>> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
>> + */
>> +
>> +#ifndef AVR_CPU_PARAM_H
>> +#define AVR_CPU_PARAM_H
>> +
>> +#define TARGET_LONG_BITS 32
>> +/*
>> + * TARGET_PAGE_BITS cannot be more than 8 bits because
>> + * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and th=
ey
>> + *     should be implemented as a device and not memory
>> + * 2.  SRAM starts at the address 0x0100
>> + */
>> +#define TARGET_PAGE_BITS 8
>> +#define TARGET_PHYS_ADDR_SPACE_BITS 24
>> +#define TARGET_VIRT_ADDR_SPACE_BITS 24
>> +#define NB_MMU_MODES 2
>> +
>> +
>> +#endif
>> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
>> new file mode 100644
>> index 0000000..d122611
>> --- /dev/null
>> +++ b/target/avr/cpu.h
>> @@ -0,0 +1,72 @@
>> +/*
>> + * QEMU AVR CPU
>> + *
>> + * Copyright (c) 2019 Michael Rolnik
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2.1 of the License, or (at your option) any later version.
>> + *
>> + * This library is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * Lesser General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU Lesser General Public
>> + * License along with this library; if not, see
>> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
>> + */
>> +
>> +#ifndef QEMU_AVR_CPU_H
>> +#define QEMU_AVR_CPU_H
>> +
>> +#include "cpu-qom.h"
>> +#include "exec/cpu-defs.h"
>> +
>> +#define TCG_GUEST_DEFAULT_MO 0
>> +#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
>> +#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
>> +#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
>> +
>> +/*
>> + * AVR has two memory spaces, data & code.
>> + * e.g. both have 0 address
>> + * ST/LD instructions access data space
>> + * LPM/SPM and instruction fetching access code memory space
>> + */
>> +#define MMU_CODE_IDX 0
>> +#define MMU_DATA_IDX 1
>> +
>> +#define EXCP_RESET 1
>> +#define EXCP_INT(n) (EXCP_RESET + (n) + 1)
>> +
>> +/* Number of CPU registers */
>> +#define NUMBER_OF_CPU_REGISTERS 32
>> +/* Number of IO registers accessible by ld/st/in/out */
>> +#define NUMBER_OF_IO_REGISTERS 64
>> +
>> +/*
>> + * Offsets of AVR memory regions in host memory space.
>> + *
>> + * This is needed because the AVR has separate code and data address
>> + * spaces that both have start from zero but have to go somewhere in
>> + * host memory.
>> + *
>> + * It's also useful to know where some things are, like the IO register=
s.
>> + */
>> +/* Flash program memory */
>> +#define OFFSET_CODE 0x00000000
>> +/* CPU registers, IO registers, and SRAM */
>> +#define OFFSET_DATA 0x00800000
>> +/* CPU registers specifically, these are mapped at the start of data */
>> +#define OFFSET_CPU_REGISTERS OFFSET_DATA
>> +/*
>> + * IO registers, including status register, stack pointer, and memory
>> + * mapped peripherals, mapped just after CPU registers
>> + */
>> +#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)
>> +
>> +#define EF_AVR_MACH 0x7F
>> +
>> +#endif /* !defined (QEMU_AVR_CPU_H) */
>> --
>> 2.7.4
>>
>>
>
> --
> Best Regards,
> Michael Rolnik
>


--=20
Best Regards,
Michael Rolnik

--00000000000024bdab059d332711
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all.<div><br></div><div>I am totally lost in the email.=
</div><div>Are there any action items for me / someone=C2=A0else ?</div><di=
v><br></div><div>Regards,</div><div>Michael Rolnik</div><div><br></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On M=
on, Jan 27, 2020 at 10:54 AM Michael Rolnik &lt;<a href=3D"mailto:mrolnik@g=
mail.com">mrolnik@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr">Thanks for you help guys.</div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon=
, Jan 27, 2020 at 12:55 AM Aleksandar Markovic &lt;<a href=3D"mailto:aleksa=
ndar.markovic@rt-rk.com" target=3D"_blank">aleksandar.markovic@rt-rk.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fro=
m: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank=
">mrolnik@gmail.com</a>&gt;<br>
<br>
This includes definitions of various basic parameters needed<br>
for integration of a new platform into QEMU.<br>
<br>
Co-developed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" ta=
rget=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Co-developed-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" =
target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" ta=
rget=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Acked-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" target=
=3D"_blank">imammedo@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@=
gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/avr/cpu-param.h | 37 ++++++++++++++++++++++++++<br>
=C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 72 +++++++++++++++++++++=
+++++++++++++++++++++++++++++<br>
=C2=A02 files changed, 109 insertions(+)<br>
=C2=A0create mode 100644 target/avr/cpu-param.h<br>
=C2=A0create mode 100644 target/avr/cpu.h<br>
<br>
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h<br>
new file mode 100644<br>
index 0000000..0c29ce4<br>
--- /dev/null<br>
+++ b/target/avr/cpu-param.h<br>
@@ -0,0 +1,37 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" rel=3D"norefe=
rrer" target=3D"_blank">http://www.gnu.org/licenses/lgpl-2.1.html</a>&gt;<b=
r>
+ */<br>
+<br>
+#ifndef AVR_CPU_PARAM_H<br>
+#define AVR_CPU_PARAM_H<br>
+<br>
+#define TARGET_LONG_BITS 32<br>
+/*<br>
+ * TARGET_PAGE_BITS cannot be more than 8 bits because<br>
+ * 1.=C2=A0 all IO registers occupy [0x0000 .. 0x00ff] address range, and =
they<br>
+ *=C2=A0 =C2=A0 =C2=A0should be implemented as a device and not memory<br>
+ * 2.=C2=A0 SRAM starts at the address 0x0100<br>
+ */<br>
+#define TARGET_PAGE_BITS 8<br>
+#define TARGET_PHYS_ADDR_SPACE_BITS 24<br>
+#define TARGET_VIRT_ADDR_SPACE_BITS 24<br>
+#define NB_MMU_MODES 2<br>
+<br>
+<br>
+#endif<br>
diff --git a/target/avr/cpu.h b/target/avr/cpu.h<br>
new file mode 100644<br>
index 0000000..d122611<br>
--- /dev/null<br>
+++ b/target/avr/cpu.h<br>
@@ -0,0 +1,72 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" rel=3D"norefe=
rrer" target=3D"_blank">http://www.gnu.org/licenses/lgpl-2.1.html</a>&gt;<b=
r>
+ */<br>
+<br>
+#ifndef QEMU_AVR_CPU_H<br>
+#define QEMU_AVR_CPU_H<br>
+<br>
+#include &quot;cpu-qom.h&quot;<br>
+#include &quot;exec/cpu-defs.h&quot;<br>
+<br>
+#define TCG_GUEST_DEFAULT_MO 0<br>
+#define AVR_CPU_TYPE_SUFFIX &quot;-&quot; TYPE_AVR_CPU<br>
+#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)<br>
+#define CPU_RESOLVING_TYPE TYPE_AVR_CPU<br>
+<br>
+/*<br>
+ * AVR has two memory spaces, data &amp; code.<br>
+ * e.g. both have 0 address<br>
+ * ST/LD instructions access data space<br>
+ * LPM/SPM and instruction fetching access code memory space<br>
+ */<br>
+#define MMU_CODE_IDX 0<br>
+#define MMU_DATA_IDX 1<br>
+<br>
+#define EXCP_RESET 1<br>
+#define EXCP_INT(n) (EXCP_RESET + (n) + 1)<br>
+<br>
+/* Number of CPU registers */<br>
+#define NUMBER_OF_CPU_REGISTERS 32<br>
+/* Number of IO registers accessible by ld/st/in/out */<br>
+#define NUMBER_OF_IO_REGISTERS 64<br>
+<br>
+/*<br>
+ * Offsets of AVR memory regions in host memory space.<br>
+ *<br>
+ * This is needed because the AVR has separate code and data address<br>
+ * spaces that both have start from zero but have to go somewhere in<br>
+ * host memory.<br>
+ *<br>
+ * It&#39;s also useful to know where some things are, like the IO registe=
rs.<br>
+ */<br>
+/* Flash program memory */<br>
+#define OFFSET_CODE 0x00000000<br>
+/* CPU registers, IO registers, and SRAM */<br>
+#define OFFSET_DATA 0x00800000<br>
+/* CPU registers specifically, these are mapped at the start of data */<br=
>
+#define OFFSET_CPU_REGISTERS OFFSET_DATA<br>
+/*<br>
+ * IO registers, including status register, stack pointer, and memory<br>
+ * mapped peripherals, mapped just after CPU registers<br>
+ */<br>
+#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)<br>
+<br>
+#define EF_AVR_MACH 0x7F<br>
+<br>
+#endif /* !defined (QEMU_AVR_CPU_H) */<br>
-- <br>
2.7.4<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--00000000000024bdab059d332711--

