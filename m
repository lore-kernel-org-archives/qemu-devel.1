Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70331C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 15:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC83206D3
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 15:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmL3Cool"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC83206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ij3aB-000215-75
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 10:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ij3ZL-0001Z0-5V
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 10:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ij3ZJ-0004vn-3J
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 10:54:58 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ij3ZI-0004q9-MV
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 10:54:57 -0500
Received: by mail-ot1-x342.google.com with SMTP id 77so18750772oty.6
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 07:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=+F4DpcrcgklwsS48Czxp5CV9vW8RmiJDG3VyRExOxxo=;
 b=hmL3CoolNYxU0N4lV2zt0aZqP9Iej9MNooCgJ3g86z4cDR4Gbuef5KGtiN+aLMyNoZ
 0+Ajv1725jBOBis9BDSfctbdXofJgysWoXbNYE48eSe6Lz/QS8Gk32/o/satLofQJ8XS
 Eq+nV+Z7qNRkbQI02RuRM+9a/x5VRpAznGCyzWBG7dIcn9AlwpGM4TKTEZz4tDhRM7IU
 UlSLpGOyhSC/U0Klz9ZM5bIaK31pxwIlOh2fmH36CNJJrEQK8GYRv8IvEsTwUl61joYL
 Kv/VEZiPi9KFaJ1QOCpDKh+KJx9cshSw2Ea+/l9IY97SvcTIxGrYxevL96goxlNuWsE7
 B5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=+F4DpcrcgklwsS48Czxp5CV9vW8RmiJDG3VyRExOxxo=;
 b=TpX9H3gykdMB5VLH/F7z1K7B42bd1458gA0haJ9IEDLJxACYjl2jrAaksLG65NCsWE
 c9f6gR5F4LimJYnO8yCLHIngfhwkt3ukrLGZHhm9swxtEPoEzzuN6EYbvdz3TWwgsvLe
 s+8GdaKkieHToYROBEB+yWWkAiVp4S4qz0Ent8dgdhAbQkx8gHKUdRiuT7uKz5oNe80G
 LTA+OIXAcoYo6X0p/D5i2Kf4XV4s/cMtWv/d8y5YYdJhfPsNQY+ddfv7QEl5QQ7S+f1X
 WvTOede+Oz+KP7JynTlAqdJc9lkv0uvnU2OE0mtylWCVn9h7MxW8JXRnutMLjLLrzIeJ
 Xz6w==
X-Gm-Message-State: APjAAAVN41DK222PFYVISwxjf8HnDv3HH4nath16P8ulOyctifXetAp7
 cKTwqUGgqHOAsGh+wH2h3d3xs0Z+zhkg3iKtAHI=
X-Google-Smtp-Source: APXvYqwrraAWze/iDbmNPHjEjG0O+PAGCUXfcfapXrgfovGbVT5Ruj//hUZagoaAYdQy7q0syfrqrjAmpji6sD8nRFM=
X-Received: by 2002:a9d:4c94:: with SMTP id m20mr22955435otf.341.1577030095784; 
 Sun, 22 Dec 2019 07:54:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sun, 22 Dec 2019 07:54:55 -0800 (PST)
In-Reply-To: <20191218210329.1960-5-mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-5-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 22 Dec 2019 16:54:55 +0100
Message-ID: <CAL1e-=gJyfHZhCcVxkgBawpt-R_b4Wpvb7LNCWDLGQ2r6q2JBQ@mail.gmail.com>
Subject: Re: [PATCH v39 04/22] target/avr: Add instruction translation -
 Registers definition
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a8cdb9059a4ceebf"
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a8cdb9059a4ceebf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/avr/translate.c | 143 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 target/avr/translate.c
>
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> new file mode 100644
> index 0000000000..0139bcabb1
> --- /dev/null
> +++ b/target/avr/translate.c
> @@ -0,0 +1,143 @@
> +/*
> + * QEMU AVR CPU
> + *
> + * Copyright (c) 2019 Michael Rolnik
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/qemu-print.h"
> +#include "tcg/tcg.h"
> +#include "cpu.h"
> +#include "exec/exec-all.h"
> +#include "tcg-op.h"
> +#include "exec/cpu_ldst.h"
> +#include "exec/helper-proto.h"
> +#include "exec/helper-gen.h"
> +#include "exec/log.h"
> +#include "exec/translator.h"
> +#include "exec/gen-icount.h"
> +
> +/*
> + *  Define if you want a BREAK instruction translated to a breakpoint
> + *  Active debugging connection is assumed
> + *  This is for
> + *  https://github.com/seharris/qemu-avr-tests/tree/master/
> instruction-tests
> + *  tests
> + */
> +#undef BREAKPOINT_ON_BREAK
> +
> +static TCGv cpu_pc;
> +
> +static TCGv cpu_Cf;
> +static TCGv cpu_Zf;
> +static TCGv cpu_Nf;
> +static TCGv cpu_Vf;
> +static TCGv cpu_Sf;
> +static TCGv cpu_Hf;
> +static TCGv cpu_Tf;
> +static TCGv cpu_If;
> +
> +static TCGv cpu_rampD;
> +static TCGv cpu_rampX;
> +static TCGv cpu_rampY;
> +static TCGv cpu_rampZ;
> +
> +static TCGv cpu_r[NUMBER_OF_CPU_REGISTERS];
> +static TCGv cpu_eind;
> +static TCGv cpu_sp;
> +
> +static TCGv cpu_skip;
> +
> +static const char reg_names[NUMBER_OF_CPU_REGISTERS][8] =3D {
> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
> +};
> +#define REG(x) (cpu_r[x])
> +
> +enum {
> +    DISAS_EXIT   =3D DISAS_TARGET_0,  /* We want return to the cpu main
> loop.  */
> +    DISAS_LOOKUP =3D DISAS_TARGET_1,  /* We have a variable condition
> exit.  */
> +    DISAS_CHAIN  =3D DISAS_TARGET_2,  /* We have a single condition exit=
.
> */
> +};
> +
> +typedef struct DisasContext DisasContext;
> +
> +/* This is the state at translation time. */
> +struct DisasContext {
> +    TranslationBlock *tb;
> +
> +    CPUAVRState *env;
> +    CPUState *cs;
> +
> +    target_long npc;
> +    uint32_t opcode;
> +
> +    /* Routine used to access memory */
> +    int memidx;
> +    int bstate;
> +    int singlestep;
> +
> +    TCGv skip_var0;
> +    TCGv skip_var1;
> +    TCGCond skip_cond;
> +    bool free_skip_var0;




[PATCH v36 04/17] target/avr: Add instruction translation - Registers
definition
Inbox
M
Michael Rolnik
Signed-off-by: Michael Rolnik <mrolnik@gmail.com> ---
target/avr/translate.c | 132 +++++++++++++++++++++++++++++++++++++++++ 1
file changed, 132 in...
A
Aleksandar Markovic
to Michael, QEMU, Richard, +5
Nov 26
Details
This set of four lines are by far the hardest to connect to the
documentation.

Please add before them a sizable comment with explanations for:

- the reason these variables are introduced
- why are they here (part of DisasContext)
- what other variables elsewhere in your solutiin are closely related to
these four variables
- what they affect
- summary of the way they work

Perhaps add comments to other places where "skip"-related data fields
are introduced too.

(I believe the implementation is correct, but it is extremely hard to the
reader
to reverse-engineer the intentions)

Yours, Aleksandar
Aleksa

> +};
> +
> +static int to_regs_16_31_by_one(DisasContext *ctx, int indx)
> +{
> +    return 16 + (indx % 16);
> +}
> +
> +static int to_regs_16_23_by_one(DisasContext *ctx, int indx)
> +{
> +    return 16 + (indx % 8);
> +}
> +static int to_regs_24_30_by_two(DisasContext *ctx, int indx)
> +{
> +    return 24 + (indx % 4) * 2;
> +}
> +static int to_regs_00_30_by_two(DisasContext *ctx, int indx)
> +{
> +    return (indx % 16) * 2;
> +}
> +
> +static uint16_t next_word(DisasContext *ctx)
> +{
> +    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
> +}
> +
> +static int append_16(DisasContext *ctx, int x)
> +{
> +    return x << 16 | next_word(ctx);
> +}
> +
> +
> +static bool avr_have_feature(DisasContext *ctx, int feature)
> +{
> +    if (!avr_feature(ctx->env, feature)) {
> +        gen_helper_unsupported(cpu_env);
> +        ctx->bstate =3D DISAS_NORETURN;
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
> +#include "decode_insn.inc.c"
> +
> --
> 2.17.2 (Apple Git-113)
>
>

--000000000000a8cdb9059a4ceebf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, December 18, 2019, Michael Rolnik &lt;<a href=3D"mail=
to:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@g=
mail.com">mrolnik@gmail.com</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com">philmd@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0target/avr/translate.c | 143 ++++++++++++++++++++++++++++++<wbr>+++++=
++++++<br>
=C2=A01 file changed, 143 insertions(+)<br>
=C2=A0create mode 100644 target/avr/translate.c<br>
<br>
diff --git a/target/avr/translate.c b/target/avr/translate.c<br>
new file mode 100644<br>
index 0000000000..0139bcabb1<br>
--- /dev/null<br>
+++ b/target/avr/translate.c<br>
@@ -0,0 +1,143 @@<br>
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
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=3D"_bl=
ank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/qemu-print.h&quot;<br>
+#include &quot;tcg/tcg.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+#include &quot;exec/exec-all.h&quot;<br>
+#include &quot;tcg-op.h&quot;<br>
+#include &quot;exec/cpu_ldst.h&quot;<br>
+#include &quot;exec/helper-proto.h&quot;<br>
+#include &quot;exec/helper-gen.h&quot;<br>
+#include &quot;exec/log.h&quot;<br>
+#include &quot;exec/translator.h&quot;<br>
+#include &quot;exec/gen-icount.h&quot;<br>
+<br>
+/*<br>
+ *=C2=A0 Define if you want a BREAK instruction translated to a breakpoint=
<br>
+ *=C2=A0 Active debugging connection is assumed<br>
+ *=C2=A0 This is for<br>
+ *=C2=A0 <a href=3D"https://github.com/seharris/qemu-avr-tests/tree/master=
/instruction-tests" target=3D"_blank">https://github.com/seharris/<wbr>qemu=
-avr-tests/tree/master/<wbr>instruction-tests</a><br>
+ *=C2=A0 tests<br>
+ */<br>
+#undef BREAKPOINT_ON_BREAK<br>
+<br>
+static TCGv cpu_pc;<br>
+<br>
+static TCGv cpu_Cf;<br>
+static TCGv cpu_Zf;<br>
+static TCGv cpu_Nf;<br>
+static TCGv cpu_Vf;<br>
+static TCGv cpu_Sf;<br>
+static TCGv cpu_Hf;<br>
+static TCGv cpu_Tf;<br>
+static TCGv cpu_If;<br>
+<br>
+static TCGv cpu_rampD;<br>
+static TCGv cpu_rampX;<br>
+static TCGv cpu_rampY;<br>
+static TCGv cpu_rampZ;<br>
+<br>
+static TCGv cpu_r[NUMBER_OF_CPU_REGISTERS]<wbr>;<br>
+static TCGv cpu_eind;<br>
+static TCGv cpu_sp;<br>
+<br>
+static TCGv cpu_skip;<br>
+<br>
+static const char reg_names[NUMBER_OF_CPU_<wbr>REGISTERS][8] =3D {<br>
+=C2=A0 =C2=A0 &quot;r0&quot;,=C2=A0 &quot;r1&quot;,=C2=A0 &quot;r2&quot;,=
=C2=A0 &quot;r3&quot;,=C2=A0 &quot;r4&quot;,=C2=A0 &quot;r5&quot;,=C2=A0 &q=
uot;r6&quot;,=C2=A0 &quot;r7&quot;,<br>
+=C2=A0 =C2=A0 &quot;r8&quot;,=C2=A0 &quot;r9&quot;,=C2=A0 &quot;r10&quot;,=
 &quot;r11&quot;, &quot;r12&quot;, &quot;r13&quot;, &quot;r14&quot;, &quot;=
r15&quot;,<br>
+=C2=A0 =C2=A0 &quot;r16&quot;, &quot;r17&quot;, &quot;r18&quot;, &quot;r19=
&quot;, &quot;r20&quot;, &quot;r21&quot;, &quot;r22&quot;, &quot;r23&quot;,=
<br>
+=C2=A0 =C2=A0 &quot;r24&quot;, &quot;r25&quot;, &quot;r26&quot;, &quot;r27=
&quot;, &quot;r28&quot;, &quot;r29&quot;, &quot;r30&quot;, &quot;r31&quot;,=
<br>
+};<br>
+#define REG(x) (cpu_r[x])<br>
+<br>
+enum {<br>
+=C2=A0 =C2=A0 DISAS_EXIT=C2=A0 =C2=A0=3D DISAS_TARGET_0,=C2=A0 /* We want =
return to the cpu main loop.=C2=A0 */<br>
+=C2=A0 =C2=A0 DISAS_LOOKUP =3D DISAS_TARGET_1,=C2=A0 /* We have a variable=
 condition exit.=C2=A0 */<br>
+=C2=A0 =C2=A0 DISAS_CHAIN=C2=A0 =3D DISAS_TARGET_2,=C2=A0 /* We have a sin=
gle condition exit.=C2=A0 */<br>
+};<br>
+<br>
+typedef struct DisasContext DisasContext;<br>
+<br>
+/* This is the state at translation time. */<br>
+struct DisasContext {<br>
+=C2=A0 =C2=A0 TranslationBlock *tb;<br>
+<br>
+=C2=A0 =C2=A0 CPUAVRState *env;<br>
+=C2=A0 =C2=A0 CPUState *cs;<br>
+<br>
+=C2=A0 =C2=A0 target_long npc;<br>
+=C2=A0 =C2=A0 uint32_t opcode;<br>
+<br>
+=C2=A0 =C2=A0 /* Routine used to access memory */<br>
+=C2=A0 =C2=A0 int memidx;<br>
+=C2=A0 =C2=A0 int bstate;<br>
+=C2=A0 =C2=A0 int singlestep;<br>
+<br>
+=C2=A0 =C2=A0 TCGv skip_var0;<br>
+=C2=A0 =C2=A0 TCGv skip_var1;<br>
+=C2=A0 =C2=A0 TCGCond skip_cond;<br>
+=C2=A0 =C2=A0 bool free_skip_var0;</blockquote><div><br></div><div><br></d=
iv><div><br></div><div class=3D"Ls" style=3D"display:block;font-size:13px">=
<div class=3D"As"><div class=3D"Cs"></div></div></div><div id=3D"cv_" class=
=3D" Xg  " style=3D"width:320px;height:auto;font-size:13px"><div class=3D"Z=
g" style=3D"width:320px;overflow-y:auto"><div class=3D"Rg"><div class=3D"Li=
"><div class=3D"yj"><div class=3D"Ah oj"><div class=3D"sj"><div id=3D"cvcst=
ar" class=3D"M j b" tabindex=3D"0"><div class=3D"V j tm tj b"></div></div><=
/div><div class=3D"rj"><span class=3D"qj pj">[PATCH v36 04/17] target/avr: =
Add instruction translation - Registers definition</span><span class=3D"uj"=
><div class=3D"xj"><span class=3D"Qg vj">Inbox</span></div></span></div></d=
iv><div class=3D"Ph"><div id=3D"cvcmsg_16e9bcab45c9f332" class=3D"yh wj" st=
yle=3D"height:70px;margin-bottom:0px;overflow:hidden"><div class=3D"Vh" id=
=3D"cvcfullmsg_16e9bcab45c9f332"><div class=3D"M j Zi Mi" tabindex=3D"0"><d=
iv class=3D"Zh"></div><div class=3D"Xh"><div class=3D"Qi"><div class=3D"rh =
Ri " style=3D"background-color:rgb(200,137,0)">M</div><img class=3D"qh Gh R=
i" src=3D"https://mail.google.com/mail/u/1/photos/mrolnik%40gmail.com?at=3D=
AF6bupMk_KRg3h0mm6f9E2_ZdoTrs5NoyQ&amp;sz=3D100&amp;pld=3D1"></div><div cla=
ss=3D"bj Pg">Michael Rolnik</div><div class=3D"cj"><div id=3D"cvcstsnip_16e=
9bcab45c9f332" class=3D"Ui Bh"><div class=3D"Vi">Signed-off-by: Michael Rol=
nik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; --- =
target/avr/translate.c | 132 +++++++++++++++++++++++++++++++++++++++++ 1 fi=
le changed, 132 in...</div><div class=3D"Wi"></div></div></div></div></div>=
<div id=3D"cvcmsgbod_16e9bcab45c9f332" class=3D"aj"></div></div></div><div =
id=3D"cvcmsg_16ea9422d240e840" class=3D"yh  " style=3D"margin-bottom:11px;o=
verflow:visible"><div class=3D"Vh" id=3D"cvcfullmsg_16ea9422d240e840"><div =
class=3D"M j Zi Mi  " tabindex=3D"0"><div id=3D"cvcreply_16ea9422d240e840" =
class=3D"M j T b hc xh S  " tabindex=3D"0"><div class=3D"V j td"></div></di=
v><div class=3D"Zh"></div><div class=3D"Xh"><div class=3D"Qi"><div class=3D=
"rh Ri " style=3D"background-color:rgb(91,16,148)">A</div><img class=3D"qh =
Gh Ri" src=3D"https://mail.google.com/mail/u/1/photos/me?at=3DAF6bupMk_KRg3=
h0mm6f9E2_ZdoTrs5NoyQ&amp;sz=3D100&amp;pld=3D1"></div><div class=3D"bj Pg">=
Aleksandar Markovic</div><div class=3D"cj"><div id=3D"cvcstrecip_16ea9422d2=
40e840" class=3D"kj Pg Bh  ">to=C2=A0Michael,=C2=A0QEMU,=C2=A0Richard, +5<b=
r>Nov 26<div id=3D"cvcshowdet_16ea9422d240e840" class=3D"M j lj h" tabindex=
=3D"0"><div class=3D"V j nj">Details</div></div></div></div></div></div><di=
v id=3D"cvcmsgbod_16ea9422d240e840" class=3D"aj"><div class=3D"Ni"><div><di=
v class=3D"M j T b hc Aj S" tabindex=3D"0"><div class=3D"V j hf"></div></di=
v></div><div style=3D"clear:both"></div><div class=3D"ni pi " dir=3D"ltr">T=
his set of four lines are by far the hardest to connect to the documentatio=
n.<br><br>Please add before them a sizable comment with explanations for:<b=
r><br>- the reason these variables are introduced<br>- why are they here (p=
art of DisasContext)</div><div class=3D"ni pi " dir=3D"ltr">- what other va=
riables elsewhere in your solutiin are closely related to these four variab=
les<br>- what they affect<br>- summary of the way they work<br><br>Perhaps =
add comments to other places where &quot;skip&quot;-related data fields<br>=
are introduced too.<br><br>(I believe the implementation is correct, but it=
 is extremely hard to the reader<br>to reverse-engineer the intentions)<br>=
<br>Yours, Aleksandar<br></div></div></div></div></div></div></div></div></=
div></div></div><div><span style=3D"font-size:14px;line-height:1.58;color:r=
gb(34,34,34);background-color:initial">Aleksa</span>=C2=A0<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
+};<br>
+<br>
+static int to_regs_16_31_by_one(<wbr>DisasContext *ctx, int indx)<br>
+{<br>
+=C2=A0 =C2=A0 return 16 + (indx % 16);<br>
+}<br>
+<br>
+static int to_regs_16_23_by_one(<wbr>DisasContext *ctx, int indx)<br>
+{<br>
+=C2=A0 =C2=A0 return 16 + (indx % 8);<br>
+}<br>
+static int to_regs_24_30_by_two(<wbr>DisasContext *ctx, int indx)<br>
+{<br>
+=C2=A0 =C2=A0 return 24 + (indx % 4) * 2;<br>
+}<br>
+static int to_regs_00_30_by_two(<wbr>DisasContext *ctx, int indx)<br>
+{<br>
+=C2=A0 =C2=A0 return (indx % 16) * 2;<br>
+}<br>
+<br>
+static uint16_t next_word(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 return cpu_lduw_code(ctx-&gt;env, ctx-&gt;npc++ * 2);<br>
+}<br>
+<br>
+static int append_16(DisasContext *ctx, int x)<br>
+{<br>
+=C2=A0 =C2=A0 return x &lt;&lt; 16 | next_word(ctx);<br>
+}<br>
+<br>
+<br>
+static bool avr_have_feature(DisasContext *ctx, int feature)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_feature(ctx-&gt;env, feature)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_unsupported(cpu_<wbr>env);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;bstate =3D DISAS_NORETURN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool decode_insn(DisasContext *ctx, uint16_t insn);<br>
+#include &quot;decode_insn.inc.c&quot;<br>
+<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--000000000000a8cdb9059a4ceebf--

