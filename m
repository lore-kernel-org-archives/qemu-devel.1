Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2032C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4A92054F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBgLVYRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4A92054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieO6Z-0008DN-I7
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ieNoE-0002SB-MM
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ieNoC-0003vK-G0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:31:02 -0500
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:41547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ieNoC-0003vE-9q
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:31:00 -0500
Received: by mail-qt1-x844.google.com with SMTP id v2so69625qtv.8
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 10:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XenP7ROi22WW3NDrEIjIYTsYhZ3TmW07YNuNND8v1uU=;
 b=FBgLVYRtKc4jQrEnT7K/QyRutasClqSURtSHve150v0GrxS1+Lu8c6QKBwAL3y5KGl
 0OmxQyaB72Z/dfjL4LKpebxuODuHhwFQ0lEQrcGs4/VfX5m6bpZiADubGsctsPbzIlh2
 rnhh3EjZk88ex+QoXwTMOiCgXYXfiTYoy5e3pqlc+6WZ8HBKbNd64f6FU40wZ5HZ1aYw
 fd+L7z5xjt4pWtZ4rCFbNCAgIHza3MuPckfkxr8U3RwCGCqgtaOSH9oviV2PGAmQ6F9h
 3PpxJUbSom33E2D+wQ+uVN4QYT+jh64kl2DYn5YCuS3ON9ZkXtx3pSaZqU38Z7oMCKqj
 ptGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XenP7ROi22WW3NDrEIjIYTsYhZ3TmW07YNuNND8v1uU=;
 b=K3qxJ354uk8HGYcdFgA6prA9e0Wbi+2MPCBI9hkZtyPKQ7ZVadyRvsoX6/x7Yi+MXy
 567+S/0j0jdAUVOrELn1g7CcEamb514Ee3FaCAo4cmVq7P63X0aaQLub4vsa9CLGAS2P
 wKOyChbMzgdLv5A6boBWHQ1trDJ7SZ4eBlcTYvYgj9Qp4h+9nhETjHLIm+vYBE7Avkno
 hR7iPcFWIqtg3W3iXqGHbHHKba7A8B8Q74WXq0qZlF5Ll561cpmZ3OJ/X1fv0GOMa0OT
 ckeNkNVAI0PDn1Z+lwj6HuAnMMi+0ftonV47vDL/GUsgFWCFdFMw+E4wUHfvwguuSh1/
 sSRg==
X-Gm-Message-State: APjAAAV3cSX77L4TYUreofATudHEeJGQ2HZqeLCAun+uE/yseCpK2Eu8
 4OU7QzeyS3ERDRmvEO3ckhlhfLBwN0wVSM4irCA=
X-Google-Smtp-Source: APXvYqx4C6xX1tZ7odRaN9xY0g23hN/2aOMq+u1hM6QyP/ZyOTtvaqchjJXLv8PjB/fs8Cg9lfopsxlfp1G/4m8D1sM=
X-Received: by 2002:ac8:4a10:: with SMTP id x16mr26406592qtq.371.1575916259693; 
 Mon, 09 Dec 2019 10:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20191208183922.13757-1-mrolnik@gmail.com>
 <20191208183922.13757-18-mrolnik@gmail.com>
 <CAL1e-=guE3xT3n2P5j0=UVoVDw8WKqbK02=otf+Pf90Mi8hfmQ@mail.gmail.com>
In-Reply-To: <CAL1e-=guE3xT3n2P5j0=UVoVDw8WKqbK02=otf+Pf90Mi8hfmQ@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 9 Dec 2019 20:30:15 +0200
Message-ID: <CAK4993i16R-HUb+cKRGhQ3NsXtWgmcbLmOLDDxT5vEkj-fehaw@mail.gmail.com>
Subject: Re: [PATCH v38 17/22] target/avr: Register AVR support with the rest
 of QEMU
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000dadb51059949986d"
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

--000000000000dadb51059949986d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I prefer to remove it, as nobody uses it. what do you think? the full list
is in target/avr/cpu.h file

On Mon, Dec 9, 2019 at 8:16 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Sunday, December 8, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>
>> Add AVR related definitions into QEMU
>>
>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> ---
>>  qapi/machine.json          | 3 ++-
>>  include/disas/dis-asm.h    | 6 ++++++
>>  include/sysemu/arch_init.h | 1 +
>>  arch_init.c                | 2 ++
>>  4 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index ca26779f1a..8c6df54921 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -21,11 +21,12 @@
>>  #        is true even for "qemu-system-x86_64".
>>  #
>>  # ppcemb: dropped in 3.1
>> +# avr: since 5.0
>>  #
>>  # Since: 3.0
>>  ##
>>  { 'enum' : 'SysEmuTarget',
>> -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386',
>> 'lm32',
>
>               'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>>               'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
>> index e9c7dd8eb4..8bedce17ac 100644
>> --- a/include/disas/dis-asm.h
>> +++ b/include/disas/dis-asm.h
>> @@ -211,6 +211,12 @@ enum bfd_architecture
>>  #define bfd_mach_m32r          0  /* backwards compatibility */
>>    bfd_arch_mn10200,    /* Matsushita MN10200 */
>>    bfd_arch_mn10300,    /* Matsushita MN10300 */
>> +  bfd_arch_avr,       /* Atmel AVR microcontrollers.  */
>> +#define bfd_mach_avr1          1
>> +#define bfd_mach_avr2          2
>> +#define bfd_mach_avr3          3
>> +#define bfd_mach_avr4          4
>> +#define bfd_mach_avr5          5
>
>
> Incomplete list. I already explained why in reply to v37.
>
>
>
>>    bfd_arch_cris,       /* Axis CRIS */
>>  #define bfd_mach_cris_v0_v10   255
>>  #define bfd_mach_cris_v32      32
>> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
>> index 62c6fe4cf1..893df26ce2 100644
>> --- a/include/sysemu/arch_init.h
>> +++ b/include/sysemu/arch_init.h
>> @@ -24,6 +24,7 @@ enum {
>>      QEMU_ARCH_NIOS2 =3D (1 << 17),
>>      QEMU_ARCH_HPPA =3D (1 << 18),
>>      QEMU_ARCH_RISCV =3D (1 << 19),
>> +    QEMU_ARCH_AVR =3D (1 << 20),
>>  };
>>
>>  extern const uint32_t arch_type;
>> diff --git a/arch_init.c b/arch_init.c
>> index 705d0b94ad..6a741165b2 100644
>> --- a/arch_init.c
>> +++ b/arch_init.c
>> @@ -89,6 +89,8 @@ int graphic_depth =3D 32;
>>  #define QEMU_ARCH QEMU_ARCH_UNICORE32
>>  #elif defined(TARGET_XTENSA)
>>  #define QEMU_ARCH QEMU_ARCH_XTENSA
>> +#elif defined(TARGET_AVR)
>> +#define QEMU_ARCH QEMU_ARCH_AVR
>>  #endif
>>
>>  const uint32_t arch_type =3D QEMU_ARCH;
>> --
>> 2.17.2 (Apple Git-113)
>>
>>

--=20
Best Regards,
Michael Rolnik

--000000000000dadb51059949986d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I prefer to remove it, as nobody uses it. what do you thin=
k? the full list is in target/avr/cpu.h file</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 9, 2019 at 8:16 PM =
Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">alek=
sandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><br><br>On Sunday, December 8, 2019, Michael Rolnik =
&lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.co=
m</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add A=
VR related definitions into QEMU<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.c=
om" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
---<br>
=C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3 ++-<br>
=C2=A0include/disas/dis-asm.h=C2=A0 =C2=A0 | 6 ++++++<br>
=C2=A0include/sysemu/arch_init.h | 1 +<br>
=C2=A0arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
2 ++<br>
=C2=A04 files changed, 11 insertions(+), 1 deletion(-)<br>
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
&#39;,</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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
><br></div><div>Incomplete list. I already explained why in reply to v37.</=
div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
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
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000dadb51059949986d--

