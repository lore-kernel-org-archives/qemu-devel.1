Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C807BC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818DF21823
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzdUiXcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818DF21823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrir-0005AX-ME
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icrWJ-0002Cq-SU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:50:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icrWH-0000bQ-Cj
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:50:15 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:38422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1icrWH-0000YI-3n
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:50:13 -0500
Received: by mail-ot1-x32c.google.com with SMTP id h20so2625174otn.5
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 05:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=IrQxz2m8JxWdKPL8ebkJMf1vbnZEreA2DuX/Usb5dOc=;
 b=RzdUiXclHSzx5B+zF9SA9jG4CuWQ6w/+m5cOY3Zi7DJJhBRBe6W1IcSIYExRv7fcJg
 x7Cil9eJ7+9i3+2QeVbmJN7OAPemnA++szCr+lpSn7rKOybycupOVwMKuTUnMi6xwnUO
 jz0ZUEzN5rzTp3pfOAJlA22SjPrPkXUnKqs8ZdFTdBwqDi7oEYk64o2JhqAua4ZIkI6Q
 bU916P8udaxfFX/M3rHULMS8fKYjQWf/3FAxRHdWHXKyvLZY+GOSXh69xQ5EoL2swLDu
 PXI+iZPBgbTj0wUBuRJVyB+76mv5QZhKcU3kHK9QiDHO58w7uCz5Q9gPk5ccO6cdD9lE
 hXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=IrQxz2m8JxWdKPL8ebkJMf1vbnZEreA2DuX/Usb5dOc=;
 b=edueaknEugHx8oeY3Ha0/q/RpmlIFyzs/INnQrHIUEMj7Ac/XpfF5RoMPgXu9KOB8y
 cqN4ZJkUrsFK47STbLuI4K6COrzSwZP1KPPB2J5XQSaNy+kA72jdI8sMqdry2yjjxhIg
 DD682fmQGqOEiWAwgYrp/8/hQzFIOjq9lQ3icQcFNrCqWSCtA9X0l7ILocZM0s1l+e+W
 x7BbC6CGlF2JmSM/Pu73COdgMOjSmjMY5X0gXNG3RTTzrkKUVGgcqkRMWhO04sEVD2UN
 OkS4Nz75CG2M63LVyjDfwAgflAhLtI42y46zoqt8kWXU7fzh5yd8hqP++B78I8Gtp959
 vj5A==
X-Gm-Message-State: APjAAAV+EucW7bY9l+zfF8whTnd6RErJNgvcNTbAeFS9Nt+IrUEuz9Nr
 NvtcwjWDtradyRt69Gw322fGKut0gX+wQq6TAJ7M5A==
X-Google-Smtp-Source: APXvYqyA8UE0XkdsBIwYMc3jQBhL8ZJ1elcwEE20dIM5PieryMvAhoxJNeQN2myjZrZVE2Sof4Q7PKaJyvPqBWnwk/k=
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr6040055oth.121.1575550560225; 
 Thu, 05 Dec 2019 04:56:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 5 Dec 2019 04:55:59 -0800 (PST)
In-Reply-To: <20191127175257.23480-14-mrolnik@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-14-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 5 Dec 2019 13:55:59 +0100
Message-ID: <CAL1e-=iyTfRMChGoursOihb8zQrP6A4bSLMC-EvYX6cQUyhq=A@mail.gmail.com>
Subject: Re: [PATCH v37 13/17] target/avr: Register AVR support with the rest
 of QEMU
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000077d2ef0598f473ad"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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

--00000000000077d2ef0598f473ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Add AVR related definitions into QEMU
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  qapi/machine.json          | 3 ++-
>  include/disas/dis-asm.h    | 6 ++++++
>  include/sysemu/arch_init.h | 1 +
>  arch_init.c                | 2 ++
>  tests/machine-none-test.c  | 1 +
>  5 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index ca26779f1a..8c6df54921 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -21,11 +21,12 @@
>  #        is true even for "qemu-system-x86_64".
>  #
>  # ppcemb: dropped in 3.1
> +# avr: since 5.0
>  #
>  # Since: 3.0
>  ##
>  { 'enum' : 'SysEmuTarget',
> -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386',
> 'lm32',
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index e9c7dd8eb4..8bedce17ac 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -211,6 +211,12 @@ enum bfd_architecture
>  #define bfd_mach_m32r          0  /* backwards compatibility */
>    bfd_arch_mn10200,    /* Matsushita MN10200 */
>    bfd_arch_mn10300,    /* Matsushita MN10300 */
> +  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
> +#define bfd_mach_avr1          1
> +#define bfd_mach_avr2          2
> +#define bfd_mach_avr3          3
> +#define bfd_mach_avr4          4
> +#define bfd_mach_avr5          5


Here you should cover all avr cores, as in:

https://github.com/CyberGrandChallenge/binutils/blob/master/bfd/archures.c

I don't think this segment is used at all for AVR in QEMU currently, but
complete it just in case.


>    bfd_arch_cris,       /* Axis CRIS */
>  #define bfd_mach_cris_v0_v10   255
>  #define bfd_mach_cris_v32      32
> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
> index 62c6fe4cf1..893df26ce2 100644
> --- a/include/sysemu/arch_init.h
> +++ b/include/sysemu/arch_init.h
> @@ -24,6 +24,7 @@ enum {
>      QEMU_ARCH_NIOS2 =3D (1 << 17),
>      QEMU_ARCH_HPPA =3D (1 << 18),
>      QEMU_ARCH_RISCV =3D (1 << 19),
> +    QEMU_ARCH_AVR =3D (1 << 20),
>  };
>
>  extern const uint32_t arch_type;
> diff --git a/arch_init.c b/arch_init.c
> index 705d0b94ad..6a741165b2 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -89,6 +89,8 @@ int graphic_depth =3D 32;
>  #define QEMU_ARCH QEMU_ARCH_UNICORE32
>  #elif defined(TARGET_XTENSA)
>  #define QEMU_ARCH QEMU_ARCH_XTENSA
> +#elif defined(TARGET_AVR)
> +#define QEMU_ARCH QEMU_ARCH_AVR
>  #endif
>
>  const uint32_t arch_type =3D QEMU_ARCH;
> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> index 5953d31755..3e5c74e73e 100644
> --- a/tests/machine-none-test.c
> +++ b/tests/machine-none-test.c
> @@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] =3D {
>      /* tested targets list */
>      { "arm", "cortex-a15" },
>      { "aarch64", "cortex-a57" },
> +    { "avr", "avr6-avr-cpu" },

     { "x86_64", "qemu64,apic-id=3D0" },
>      { "i386", "qemu32,apic-id=3D0" },
>      { "alpha", "ev67" },
> --


This single line should be a sepatare patch "target/avr: Add machine none
test"


> 2.17.2 (Apple Git-113)
>
>

--00000000000077d2ef0598f473ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, November 27, 2019, Michael Rolnik &lt;<a href=3D"mail=
to:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Add AVR related definitions into QEMU<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com">philmd@redhat.com</a>&gt;<br>
Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.c=
om">amarkovic@wavecomp.com</a>&gt;<br>
---<br>
=C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3 ++-<br>
=C2=A0include/disas/dis-asm.h=C2=A0 =C2=A0 | 6 ++++++<br>
=C2=A0include/sysemu/arch_init.h | 1 +<br>
=C2=A0arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
2 ++<br>
=C2=A0tests/machine-none-test.c=C2=A0 | 1 +<br>
=C2=A05 files changed, 12 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qapi/machine.json b/qapi/machine.json<br>
index ca26779f1a..8c6df54921 100644<br>
--- a/qapi/machine.json<br>
+++ b/qapi/machine.json<br>
@@ -21,11 +21,12 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 is true even for &quot;qemu-system-x86_6=
4&quot;.<br>
=C2=A0#<br>
=C2=A0# ppcemb: dropped in 3.1<br>
+# avr: since 5.0<br>
=C2=A0#<br>
=C2=A0# Since: 3.0<br>
=C2=A0##<br>
=C2=A0{ &#39;enum&#39; : &#39;SysEmuTarget&#39;,<br>
-=C2=A0 &#39;data&#39; : [ &#39;aarch64&#39;, &#39;alpha&#39;, &#39;arm&#39=
;, &#39;cris&#39;, &#39;hppa&#39;, &#39;i386&#39;, &#39;lm32&#39;,<br>
+=C2=A0 &#39;data&#39; : [ &#39;aarch64&#39;, &#39;alpha&#39;, &#39;arm&#39=
;, &#39;avr&#39;, &#39;cris&#39;, &#39;hppa&#39;, &#39;i386&#39;, &#39;lm32=
&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;m68k&#39;, &#39;micro=
blaze&#39;, &#39;microblazeel&#39;, &#39;mips&#39;, &#39;mips64&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;mips64el&#39;, &#39;m=
ipsel&#39;, &#39;moxie&#39;, &#39;nios2&#39;, &#39;or1k&#39;, &#39;ppc&#39;=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;ppc64&#39;, &#39;risc=
v32&#39;, &#39;riscv64&#39;, &#39;s390x&#39;, &#39;sh4&#39;,<br>
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h<br>
index e9c7dd8eb4..8bedce17ac 100644<br>
--- a/include/disas/dis-asm.h<br>
+++ b/include/disas/dis-asm.h<br>
@@ -211,6 +211,12 @@ enum bfd_architecture<br>
=C2=A0#define bfd_mach_m32r=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=C2=A0 /* ba=
ckwards compatibility */<br>
=C2=A0 =C2=A0bfd_arch_mn10200,=C2=A0 =C2=A0 /* Matsushita MN10200 */<br>
=C2=A0 =C2=A0bfd_arch_mn10300,=C2=A0 =C2=A0 /* Matsushita MN10300 */<br>
+=C2=A0 bfd_arch_avr,=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Atmel AVR microcontrolle=
rs.=C2=A0 */<br>
+#define bfd_mach_avr1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
+#define bfd_mach_avr2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
+#define bfd_mach_avr3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>
+#define bfd_mach_avr4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4<br>
+#define bfd_mach_avr5=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5</blockquote><div=
><br></div><div>Here you should cover all avr cores, as in:</div><div><br><=
/div><div><a href=3D"https://github.com/CyberGrandChallenge/binutils/blob/m=
aster/bfd/archures.c">https://github.com/CyberGrandChallenge/binutils/blob/=
master/bfd/archures.c</a><br></div><div><br></div><div>I don&#39;t think th=
is segment is used at all for AVR in QEMU currently, but complete it just i=
n case.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0bfd_arch_cris,=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Axis CRIS */<br>
=C2=A0#define bfd_mach_cris_v0_v10=C2=A0 =C2=A0255<br>
=C2=A0#define bfd_mach_cris_v32=C2=A0 =C2=A0 =C2=A0 32<br>
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h<br>
index 62c6fe4cf1..893df26ce2 100644<br>
--- a/include/sysemu/arch_init.h<br>
+++ b/include/sysemu/arch_init.h<br>
@@ -24,6 +24,7 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0QEMU_ARCH_NIOS2 =3D (1 &lt;&lt; 17),<br>
=C2=A0 =C2=A0 =C2=A0QEMU_ARCH_HPPA =3D (1 &lt;&lt; 18),<br>
=C2=A0 =C2=A0 =C2=A0QEMU_ARCH_RISCV =3D (1 &lt;&lt; 19),<br>
+=C2=A0 =C2=A0 QEMU_ARCH_AVR =3D (1 &lt;&lt; 20),<br>
=C2=A0};<br>
<br>
=C2=A0extern const uint32_t arch_type;<br>
diff --git a/arch_init.c b/arch_init.c<br>
index 705d0b94ad..6a741165b2 100644<br>
--- a/arch_init.c<br>
+++ b/arch_init.c<br>
@@ -89,6 +89,8 @@ int graphic_depth =3D 32;<br>
=C2=A0#define QEMU_ARCH QEMU_ARCH_UNICORE32<br>
=C2=A0#elif defined(TARGET_XTENSA)<br>
=C2=A0#define QEMU_ARCH QEMU_ARCH_XTENSA<br>
+#elif defined(TARGET_AVR)<br>
+#define QEMU_ARCH QEMU_ARCH_AVR<br>
=C2=A0#endif<br>
<br>
=C2=A0const uint32_t arch_type =3D QEMU_ARCH;<br>
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c<br>
index 5953d31755..3e5c74e73e 100644<br>
--- a/tests/machine-none-test.c<br>
+++ b/tests/machine-none-test.c<br>
@@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0/* tested targets list */<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;arm&quot;, &quot;cortex-a15&quot; },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;aarch64&quot;, &quot;cortex-a57&quot; },<br>
+=C2=A0 =C2=A0 { &quot;avr&quot;, &quot;avr6-avr-cpu&quot; },</blockquote><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0{ &quot;x86_64&quot;, &quot;qemu64,apic-id=3D0&quot; },=
<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;i386&quot;, &quot;qemu32,apic-id=3D0&quot; },<b=
r>
=C2=A0 =C2=A0 =C2=A0{ &quot;alpha&quot;, &quot;ev67&quot; },<br>
--=C2=A0</blockquote><div><br></div><div>This single line should be a sepat=
are patch &quot;target/avr: Add machine none test&quot;</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--00000000000077d2ef0598f473ad--

