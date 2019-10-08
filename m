Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD83FC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BA2206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyFLXD48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BA2206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHr42-0001s0-PD
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iHr34-0001IO-MY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iHr2z-0003rN-2s
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:05:14 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:43079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iHr2y-0003qv-Q6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:05:09 -0400
Received: by mail-oi1-x22d.google.com with SMTP id t84so15024256oih.10
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LlycMkXIaWUlsGg24YfywSGu8cIWT/u8BHhT9DBDK+U=;
 b=UyFLXD48twgGp6AVTnxu3sjyj1RHVlYBOrb0hEk7sgYOwd7zLGjAJjyFWLDarYboZN
 9tfuiyKQskjkhKHVxzfjz670smL5N2Zo3yvFEiwO+LBQCe3IfptE2KrtuS2JbDUi2Jm/
 C87a5b3A0PH1zF5VSD4T25EGmqTg9ssPN/is0mFnvChdoCOIqiebSd3K403QtvfPNS4b
 hUV+oMFFAlqREpYHeU2dtU4kPSuNoKKLsW8mxpVscEd/HW2VyZlUfc0zkPzYbBpqxerz
 wQZlZwt9XmKp36g8ElEZ3PDHhzUO13186WpJXlPcrwoLjHM6QsAOyb8Fxu7GFb4xA+fp
 G/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LlycMkXIaWUlsGg24YfywSGu8cIWT/u8BHhT9DBDK+U=;
 b=GMJmW9fMfBSZbMk+XU600bXrTTuUxLytEF0NU17L3i/x7IDMsc3PHHix60n8Conozb
 iiNuIJ2JKeK0+0amVEzkeoBdYmD2UoqwezyBKlvKE8fyQeDLwneu0yD5Lkfyp1U8YtXE
 gI7Xp3nTsLF3VtmkA2GVyCtHyysrp/wpFg622WAdLEaGlgGwwP6zaRd+uDXOGocbXlYi
 U8PyQwta+eMTwl11pIexvctJSFoHjSk5kIMls7meL1YBMtqLf1qvyGY1CZIHFGeeuCa5
 8A+nRs0v10l9p3P5KXdnXzoIOhbGjjA2Y4iVcejFsoWVcacyRjUAVGyT81HbAOOlbGkY
 qx7g==
X-Gm-Message-State: APjAAAXyV7xJCAmUf0g5ieEQC6FlJi3NC1/dASgZFfMPt9l8YA73/V6Q
 eYGLq2l6yHe4AbTQnlqsEshKAXpauvgooMQ5y84o1A==
X-Google-Smtp-Source: APXvYqy5dkSomb2XEYsOfKZHIVeanHAucxQ+09QLitEaFBP3PMPkY6/uu8NAlI20t1sdvmRix8MD3aVranEXq2x+WO4=
X-Received: by 2002:aca:db03:: with SMTP id s3mr4440634oig.56.1570547107910;
 Tue, 08 Oct 2019 08:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191007151905.32766-1-philmd@redhat.com>
 <20191007151905.32766-8-philmd@redhat.com>
In-Reply-To: <20191007151905.32766-8-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 8 Oct 2019 23:04:31 +0800
Message-ID: <CAKXe6S+B8y5fdFowN3+40baR-b4c0RDrsi+LvuNcx1g-Mx7LpA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] tests/fw_cfg: Run the tests on big-endian targets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007858880594677e73"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007858880594677e73
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:20=E5=86=99=E9=81=
=93=EF=BC=9A

> We have been restricting our fw_cfg tests to the PC machine,
> which is a little-endian architecture.
> The fw_cfg device is also used on the SPARC and PowerPC
> architectures, which can run in big-endian configuration.
>
> Since we want to be sure our device does not regress
> regardless the endianess used, enable this test one
> these targets.
>
> The NUMA selector is X86 specific, restrict it to this arch.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: test ppc32 too (lvivier)
> ---
>  tests/Makefile.include |  2 ++
>  tests/fw_cfg-test.c    | 33 +++++++++++++++++++++++++++------
>  2 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3543451ed3..4ae3d5140a 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -226,6 +226,7 @@ check-qtest-ppc-y +=3D tests/prom-env-test$(EXESUF)
>  check-qtest-ppc-y +=3D tests/drive_del-test$(EXESUF)
>  check-qtest-ppc-y +=3D tests/boot-serial-test$(EXESUF)
>  check-qtest-ppc-$(CONFIG_M48T59) +=3D tests/m48t59-test$(EXESUF)
> +check-qtest-ppc-y +=3D tests/fw_cfg-test$(EXESUF)
>
>  check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
>  check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/device-plug-test$(EXESUF)
> @@ -250,6 +251,7 @@ check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D
> tests/endianness-test$(EXESUF)
>  check-qtest-sparc-y +=3D tests/prom-env-test$(EXESUF)
>  check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)
>  check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)
> +check-qtest-sparc-y +=3D tests/fw_cfg-test$(EXESUF)
>
>  check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXE=
SUF)
>  check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 35af0de7e6..1250e87097 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -210,13 +210,30 @@ static void test_fw_cfg_splash_time(const void
> *opaque)
>
>  int main(int argc, char **argv)
>  {
> -    QTestCtx ctx;
> -    int ret;
> +    const char *arch =3D qtest_get_arch();
> +    bool has_numa =3D false;
> +    QTestCtx ctx =3D {};
> +    int ret =3D 0;
>
>      g_test_init(&argc, &argv, NULL);
>
> -    ctx.machine_name =3D "pc";
> -    ctx.fw_cfg =3D pc_fw_cfg_init();
> +    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
> +        has_numa =3D true;
> +        ctx.machine_name =3D "pc";
> +        ctx.fw_cfg =3D pc_fw_cfg_init();
> +    } else if (g_str_equal(arch, "sparc")) {
> +        ctx.machine_name =3D "SS-5";
> +        ctx.fw_cfg =3D mm_fw_cfg_init(0xd00000510ULL);
> +    } else if (g_str_equal(arch, "ppc") || g_str_equal(arch, "ppc64")) {
> +        /*
> +         * The mac99 machine is different for 32/64-bit target:
> +         *
> +         * ppc(32): the G4 which can be either little or big endian,
> +         * ppc64:   the G5 (970FX) is only big-endian.
> +         */
> +        ctx.machine_name =3D "mac99";
> +        ctx.fw_cfg =3D mm_fw_cfg_init(0xf0000510);
> +    }
>
>      qtest_add_data_func("fw_cfg/signature", &ctx, test_fw_cfg_signature)=
;
>      qtest_add_data_func("fw_cfg/id", &ctx, test_fw_cfg_id);
> @@ -231,14 +248,18 @@ int main(int argc, char **argv)
>      qtest_add_func("fw_cfg/boot_device", test_fw_cfg_boot_device);
>  #endif
>      qtest_add_data_func("fw_cfg/max_cpus", &ctx, test_fw_cfg_max_cpus);
> -    qtest_add_data_func("fw_cfg/numa", &ctx, test_fw_cfg_numa);
>      qtest_add_data_func("fw_cfg/boot_menu", &ctx, test_fw_cfg_boot_menu)=
;
>      qtest_add_data_func("fw_cfg/reboot_timeout", &ctx,
>                          test_fw_cfg_reboot_timeout);
>      qtest_add_data_func("fw_cfg/splash_time", &ctx,
> test_fw_cfg_splash_time);
>
> -    ret =3D g_test_run();
> +    if (has_numa) {
> +        qtest_add_data_func("fw_cfg/numa", &ctx, test_fw_cfg_numa);
> +    }
>
> +    if (ctx.machine_name) {
> +        ret =3D g_test_run();
> +    }
>

I think we can omit this if statement. In which case the ctx.machine_name
will be NULL?

Thanks,
Li Qiang



>      g_free(ctx.fw_cfg);
>
>      return ret;
> --
> 2.21.0
>
>

--0000000000007858880594677e73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:20=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">We have been restricting our fw_cfg tests to the PC machine,<br>
which is a little-endian architecture.<br>
The fw_cfg device is also used on the SPARC and PowerPC<br>
architectures, which can run in big-endian configuration.<br>
<br>
Since we want to be sure our device does not regress<br>
regardless the endianess used, enable this test one<br>
these targets.<br>
<br>
The NUMA selector is X86 specific, restrict it to this arch.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---<br>
v2: test ppc32 too (lvivier)<br>
---<br>
=C2=A0tests/Makefile.include |=C2=A0 2 ++<br>
=C2=A0tests/fw_cfg-test.c=C2=A0 =C2=A0 | 33 +++++++++++++++++++++++++++----=
--<br>
=C2=A02 files changed, 29 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/tests/Makefile.include b/tests/Makefile.include<br>
index 3543451ed3..4ae3d5140a 100644<br>
--- a/tests/Makefile.include<br>
+++ b/tests/Makefile.include<br>
@@ -226,6 +226,7 @@ check-qtest-ppc-y +=3D tests/prom-env-test$(EXESUF)<br>
=C2=A0check-qtest-ppc-y +=3D tests/drive_del-test$(EXESUF)<br>
=C2=A0check-qtest-ppc-y +=3D tests/boot-serial-test$(EXESUF)<br>
=C2=A0check-qtest-ppc-$(CONFIG_M48T59) +=3D tests/m48t59-test$(EXESUF)<br>
+check-qtest-ppc-y +=3D tests/fw_cfg-test$(EXESUF)<br>
<br>
=C2=A0check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)<br>
=C2=A0check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/device-plug-test$(EXES=
UF)<br>
@@ -250,6 +251,7 @@ check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D tests/endia=
nness-test$(EXESUF)<br>
=C2=A0check-qtest-sparc-y +=3D tests/prom-env-test$(EXESUF)<br>
=C2=A0check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)<br>
=C2=A0check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)<br>
+check-qtest-sparc-y +=3D tests/fw_cfg-test$(EXESUF)<br>
<br>
=C2=A0check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(=
EXESUF)<br>
=C2=A0check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)<br>
diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c<br>
index 35af0de7e6..1250e87097 100644<br>
--- a/tests/fw_cfg-test.c<br>
+++ b/tests/fw_cfg-test.c<br>
@@ -210,13 +210,30 @@ static void test_fw_cfg_splash_time(const void *opaqu=
e)<br>
<br>
=C2=A0int main(int argc, char **argv)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 QTestCtx ctx;<br>
-=C2=A0 =C2=A0 int ret;<br>
+=C2=A0 =C2=A0 const char *arch =3D qtest_get_arch();<br>
+=C2=A0 =C2=A0 bool has_numa =3D false;<br>
+=C2=A0 =C2=A0 QTestCtx ctx =3D {};<br>
+=C2=A0 =C2=A0 int ret =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_test_init(&amp;argc, &amp;argv, NULL);<br>
<br>
-=C2=A0 =C2=A0 ctx.machine_name =3D &quot;pc&quot;;<br>
-=C2=A0 =C2=A0 ctx.fw_cfg =3D pc_fw_cfg_init();<br>
+=C2=A0 =C2=A0 if (g_str_equal(arch, &quot;i386&quot;) || g_str_equal(arch,=
 &quot;x86_64&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_numa =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.machine_name =3D &quot;pc&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.fw_cfg =3D pc_fw_cfg_init();<br>
+=C2=A0 =C2=A0 } else if (g_str_equal(arch, &quot;sparc&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.machine_name =3D &quot;SS-5&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.fw_cfg =3D mm_fw_cfg_init(0xd00000510ULL);=
<br>
+=C2=A0 =C2=A0 } else if (g_str_equal(arch, &quot;ppc&quot;) || g_str_equal=
(arch, &quot;ppc64&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The mac99 machine is different for 32/=
64-bit target:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ppc(32): the G4 which can be either li=
ttle or big endian,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ppc64:=C2=A0 =C2=A0the G5 (970FX) is o=
nly big-endian.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.machine_name =3D &quot;mac99&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.fw_cfg =3D mm_fw_cfg_init(0xf0000510);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_cfg/signature&quot;, &amp;=
ctx, test_fw_cfg_signature);<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_cfg/id&quot;, &amp;ctx, te=
st_fw_cfg_id);<br>
@@ -231,14 +248,18 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_func(&quot;fw_cfg/boot_device&quot;, test_fw_=
cfg_boot_device);<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_cfg/max_cpus&quot;, &amp;c=
tx, test_fw_cfg_max_cpus);<br>
-=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/numa&quot;, &amp;ctx, test_=
fw_cfg_numa);<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_cfg/boot_menu&quot;, &amp;=
ctx, test_fw_cfg_boot_menu);<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_cfg/reboot_timeout&quot;, =
&amp;ctx,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0test_fw_cfg_reboot_timeout);<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_cfg/splash_time&quot;, &am=
p;ctx, test_fw_cfg_splash_time);<br>
<br>
-=C2=A0 =C2=A0 ret =3D g_test_run();<br>
+=C2=A0 =C2=A0 if (has_numa) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/numa&quot;, &=
amp;ctx, test_fw_cfg_numa);<br>
+=C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 if (ctx.machine_name) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D g_test_run();<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>I think we can omit th=
is if statement. In which case the ctx.machine_name will be NULL?</div><div=
><br></div><div>Thanks,</div><div>Li Qiang</div><div><br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0g_free(ctx.fw_cfg);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div></div>

--0000000000007858880594677e73--

