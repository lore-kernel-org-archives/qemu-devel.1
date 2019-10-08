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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D9CC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1879206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXqN+9qL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1879206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrrv-0004Ii-RO
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iHrr0-0003pc-8B
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iHrqy-0003HW-7r
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:56:50 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:37685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iHrqx-0003G7-UO
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:56:48 -0400
Received: by mail-ot1-x329.google.com with SMTP id k32so14442364otc.4
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=32uXc5NLA4Y6AwaqTRTzBMKdp/QflocvJgyfrMO81PY=;
 b=BXqN+9qL6b2i5hAuevlMXVKroePxB0XaP5JnJUwwG3EUQWND0iUYQ2hK+GhJHyeoSJ
 Wea3EKyc1XmXGtLsGrWVtznf0rkbs0OFiI8XDTsFS19wJAlZamMM86uZ+MkDl6rq3q+o
 +dlkG4E/0d1kKAcn+mVaEcZLxVn4k5nVfQE6kbFRQInk1H+EealMvz1YRJbOddeUp/Nk
 F4N9dPsbylVfW2XkrLN6WIdwyU8pPOAqyzTHoBHgLSTsXwYqfClp2GfyNXJJoJj2Juus
 krnTClknNJ0Z/xBgHcuPVgCh3PI4+0F2orikSCtf/fLmKyqoXfgx3C1aJZGbplvoWHsI
 u9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=32uXc5NLA4Y6AwaqTRTzBMKdp/QflocvJgyfrMO81PY=;
 b=mZlTV6hT3qypYz2455ny1kh0AAuYedKbo7Lx4y3Dy73lFvBiJv/oqFtMyVtGLvG6DA
 xyFaeBxKd7BT72OlI74JmLkbRAkkwH0iYVtLV4wqdO7J1jNlVkxpKnr0DesfB9e+EhgH
 oKybskiHe50S93Kmn9vmjQhzfnMH1AN5j40nFMzvQBCgmW5/jHnzz5J3ahDDBh1hR7wd
 E2iE8JpARV/U6NwAZYHWkTe3U8O0opWfFKBN2O8C3dFowCrqeZqy1t7KzzJ68lQXRjYL
 9PCMleu+Yv5kMFFTcreFZ3oH9Tuu/FdzlFtQcNMo5npf2RY+hBh0/C3ddq+pX1XPhMwq
 O99g==
X-Gm-Message-State: APjAAAWGEPdch6tvgYcQ4XxFiACjgj9piXzrCL6JTzLYheFxX/64fuaG
 LdMy+KeGPoM0VQC7eBDAOiyguOhSoZQhoMPR1pI=
X-Google-Smtp-Source: APXvYqwDACq+6PVKOMLM26kfuyF9S5c6PvraLunxbOQF7UTNxEUoyg8gRM5UYLleG9G9hI/BWR2mWa8mEdRWgQJBz74=
X-Received: by 2002:a9d:67cb:: with SMTP id c11mr14685451otn.149.1570550207265; 
 Tue, 08 Oct 2019 08:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191007151905.32766-1-philmd@redhat.com>
 <20191007151905.32766-8-philmd@redhat.com>
 <CAKXe6S+B8y5fdFowN3+40baR-b4c0RDrsi+LvuNcx1g-Mx7LpA@mail.gmail.com>
 <04036864-7839-a13f-b598-53ccc99c2d8c@redhat.com>
In-Reply-To: <04036864-7839-a13f-b598-53ccc99c2d8c@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 8 Oct 2019 23:56:10 +0800
Message-ID: <CAKXe6S+jAcUMsdftN2VzZjnDrqs8Uc_2ukJeFzqNibfyJmm7uA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] tests/fw_cfg: Run the tests on big-endian targets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000034c1b70594683720"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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

--00000000000034c1b70594683720
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:14=E5=86=99=E9=81=
=93=EF=BC=9A

> Hi Li,
>
> On 10/8/19 5:04 PM, Li Qiang wrote:
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com <mailto:philmd@redhat.co=
m>> =E4=BA=8E
> > 2019=E5=B9=B410=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=88=
11:20=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     We have been restricting our fw_cfg tests to the PC machine,
> >     which is a little-endian architecture.
> >     The fw_cfg device is also used on the SPARC and PowerPC
> >     architectures, which can run in big-endian configuration.
> >
> >     Since we want to be sure our device does not regress
> >     regardless the endianess used, enable this test one
> >     these targets.
> >
> >     The NUMA selector is X86 specific, restrict it to this arch.
> >
> >     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> >     <mailto:philmd@redhat.com>>
> >     ---
> >     v2: test ppc32 too (lvivier)
> >     ---
> >       tests/Makefile.include |  2 ++
> >       tests/fw_cfg-test.c    | 33 +++++++++++++++++++++++++++------
> >       2 files changed, 29 insertions(+), 6 deletions(-)
> >
> >     diff --git a/tests/Makefile.include b/tests/Makefile.include
> >     index 3543451ed3..4ae3d5140a 100644
> >     --- a/tests/Makefile.include
> >     +++ b/tests/Makefile.include
> >     @@ -226,6 +226,7 @@ check-qtest-ppc-y +=3D tests/prom-env-test$(EXE=
SUF)
> >       check-qtest-ppc-y +=3D tests/drive_del-test$(EXESUF)
> >       check-qtest-ppc-y +=3D tests/boot-serial-test$(EXESUF)
> >       check-qtest-ppc-$(CONFIG_M48T59) +=3D tests/m48t59-test$(EXESUF)
> >     +check-qtest-ppc-y +=3D tests/fw_cfg-test$(EXESUF)
> >
> >       check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
> >       check-qtest-ppc64-$(CONFIG_PSERIES) +=3D
> tests/device-plug-test$(EXESUF)
> >     @@ -250,6 +251,7 @@ check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D
> >     tests/endianness-test$(EXESUF)
> >       check-qtest-sparc-y +=3D tests/prom-env-test$(EXESUF)
> >       check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)
> >       check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)
> >     +check-qtest-sparc-y +=3D tests/fw_cfg-test$(EXESUF)
> >
> >       check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D
> >     tests/endianness-test$(EXESUF)
> >       check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)
> >     diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> >     index 35af0de7e6..1250e87097 100644
> >     --- a/tests/fw_cfg-test.c
> >     +++ b/tests/fw_cfg-test.c
> >     @@ -210,13 +210,30 @@ static void test_fw_cfg_splash_time(const voi=
d
> >     *opaque)
> >
> >       int main(int argc, char **argv)
> >       {
> >     -    QTestCtx ctx;
> >     -    int ret;
> >     +    const char *arch =3D qtest_get_arch();
> >     +    bool has_numa =3D false;
> >     +    QTestCtx ctx =3D {};
> >     +    int ret =3D 0;
> >
> >           g_test_init(&argc, &argv, NULL);
> >
> >     -    ctx.machine_name =3D "pc";
> >     -    ctx.fw_cfg =3D pc_fw_cfg_init();
> >     +    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) =
{
> >     +        has_numa =3D true;
> >     +        ctx.machine_name =3D "pc";
> >     +        ctx.fw_cfg =3D pc_fw_cfg_init();
> >     +    } else if (g_str_equal(arch, "sparc")) {
> >     +        ctx.machine_name =3D "SS-5";
> >     +        ctx.fw_cfg =3D mm_fw_cfg_init(0xd00000510ULL);
> >     +    } else if (g_str_equal(arch, "ppc") || g_str_equal(arch,
> >     "ppc64")) {
> >     +        /*
> >     +         * The mac99 machine is different for 32/64-bit target:
> >     +         *
> >     +         * ppc(32): the G4 which can be either little or big endia=
n,
> >     +         * ppc64:   the G5 (970FX) is only big-endian.
> >     +         */
> >     +        ctx.machine_name =3D "mac99";
> >     +        ctx.fw_cfg =3D mm_fw_cfg_init(0xf0000510);
> >     +    }
> >
> >           qtest_add_data_func("fw_cfg/signature", &ctx,
> >     test_fw_cfg_signature);
> >           qtest_add_data_func("fw_cfg/id", &ctx, test_fw_cfg_id);
> >     @@ -231,14 +248,18 @@ int main(int argc, char **argv)
> >           qtest_add_func("fw_cfg/boot_device", test_fw_cfg_boot_device)=
;
> >       #endif
> >           qtest_add_data_func("fw_cfg/max_cpus", &ctx,
> >     test_fw_cfg_max_cpus);
> >     -    qtest_add_data_func("fw_cfg/numa", &ctx, test_fw_cfg_numa);
> >           qtest_add_data_func("fw_cfg/boot_menu", &ctx,
> >     test_fw_cfg_boot_menu);
> >           qtest_add_data_func("fw_cfg/reboot_timeout", &ctx,
> >                               test_fw_cfg_reboot_timeout);
> >           qtest_add_data_func("fw_cfg/splash_time", &ctx,
> >     test_fw_cfg_splash_time);
> >
> >     -    ret =3D g_test_run();
> >     +    if (has_numa) {
> >     +        qtest_add_data_func("fw_cfg/numa", &ctx, test_fw_cfg_numa)=
;
> >     +    }
> >
> >     +    if (ctx.machine_name) {
> >     +        ret =3D g_test_run();
> >     +    }
> >
> >
> > I think we can omit this if statement. In which case the
> > ctx.machine_name will be NULL?
>
> Here I thought about the PPC64 tests inheriting the PPC32 ones, and
> maybe someone update the tests/Makefile.include and this test will run
> on unexpected architectures.


Sorry, I don't get your point here(PPC64 tests inheriting the PPC32),
could you please explain this more?



> So if the machine is NULL (another arch) we
>

IIUC the "-M" option must has an argument, maybe?

Thanks,
Li Qiang



> don't crash and return successfully, so the testsuite continue.
>
> I might add a comment such:
>
>    if (ctx.machine_name) {
>        /* Only run whitelisted architecture. */
>        ret =3D g_test_run();
>    }
>
> But maybe it is simpler to do at the beginning of main():
>
>    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
>    ...
>        ctx.fw_cfg =3D mm_fw_cfg_init(0xf0000510);
>    } else {
>        return 0;
>    }
>
> What do you think?
>
> Thanks for reviewing the whole series :)
>
> > Thanks,
> > Li Qiang
> >
> >           g_free(ctx.fw_cfg);
> >
> >           return ret;
> >     --
> >     2.21.0
> >
>

--00000000000034c1b70594683720
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:14=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hi Li,<br>
<br>
On 10/8/19 5:04 PM, Li Qiang wrote:<br>
&gt; Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" t=
arget=3D"_blank">philmd@redhat.com</a> &lt;mailto:<a href=3D"mailto:philmd@=
redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;&gt; =E4=BA=8E <br>
&gt; 2019=E5=B9=B410=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=
=8811:20=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0We have been restricting our fw_cfg tests to the PC=
 machine,<br>
&gt;=C2=A0 =C2=A0 =C2=A0which is a little-endian architecture.<br>
&gt;=C2=A0 =C2=A0 =C2=A0The fw_cfg device is also used on the SPARC and Pow=
erPC<br>
&gt;=C2=A0 =C2=A0 =C2=A0architectures, which can run in big-endian configur=
ation.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Since we want to be sure our device does not regres=
s<br>
&gt;=C2=A0 =C2=A0 =C2=A0regardless the endianess used, enable this test one=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0these targets.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The NUMA selector is X86 specific, restrict it to t=
his arch.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a><br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:philmd@redhat.com" tar=
get=3D"_blank">philmd@redhat.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0v2: test ppc32 too (lvivier)<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tests/Makefile.include |=C2=A0 2 ++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tests/fw_cfg-test.c=C2=A0 =C2=A0 | 33 ++++++=
+++++++++++++++++++++------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A02 files changed, 29 insertions(+), 6 deletio=
ns(-)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/tests/Makefile.include b/tests/Makefil=
e.include<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 3543451ed3..4ae3d5140a 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/tests/Makefile.include<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/tests/Makefile.include<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -226,6 +226,7 @@ check-qtest-ppc-y +=3D tests/pr=
om-env-test$(EXESUF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check-qtest-ppc-y +=3D tests/drive_del-test$=
(EXESUF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check-qtest-ppc-y +=3D tests/boot-serial-tes=
t$(EXESUF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check-qtest-ppc-$(CONFIG_M48T59) +=3D tests/=
m48t59-test$(EXESUF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+check-qtest-ppc-y +=3D tests/fw_cfg-test$(EXESUF)<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check-qtest-ppc64-y +=3D $(check-qtest-ppc-y=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tes=
ts/device-plug-test$(EXESUF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -250,6 +251,7 @@ check-qtest-sh4eb-$(CONFIG_ISA_=
TESTDEV) =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0tests/endianness-test$(EXESUF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check-qtest-sparc-y +=3D tests/prom-env-test=
$(EXESUF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check-qtest-sparc-y +=3D tests/m48t59-test$(=
EXESUF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check-qtest-sparc-y +=3D tests/boot-serial-t=
est$(EXESUF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+check-qtest-sparc-y +=3D tests/fw_cfg-test$(EXESUF=
)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =
=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0tests/endianness-test$(EXESUF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0check-qtest-sparc64-y +=3D tests/prom-env-te=
st$(EXESUF)<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-tes=
t.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 35af0de7e6..1250e87097 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/tests/fw_cfg-test.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/tests/fw_cfg-test.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -210,13 +210,30 @@ static void test_fw_cfg_splas=
h_time(const void<br>
&gt;=C2=A0 =C2=A0 =C2=A0*opaque)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 QTestCtx ctx;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 int ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 const char *arch =3D qtest_get_arch(=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 bool has_numa =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 QTestCtx ctx =3D {};<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 int ret =3D 0;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_test_init(&amp;argc, &amp;ar=
gv, NULL);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 ctx.machine_name =3D &quot;pc&quot;;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 ctx.fw_cfg =3D pc_fw_cfg_init();<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (g_str_equal(arch, &quot;i386&quo=
t;) || g_str_equal(arch, &quot;x86_64&quot;)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_numa =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.machine_name =3D &=
quot;pc&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.fw_cfg =3D pc_fw_c=
fg_init();<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 } else if (g_str_equal(arch, &quot;s=
parc&quot;)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.machine_name =3D &=
quot;SS-5&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.fw_cfg =3D mm_fw_c=
fg_init(0xd00000510ULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 } else if (g_str_equal(arch, &quot;p=
pc&quot;) || g_str_equal(arch,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;ppc64&quot;)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The mac99 mach=
ine is different for 32/64-bit target:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ppc(32): the G=
4 which can be either little or big endian,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ppc64:=C2=A0 =
=C2=A0the G5 (970FX) is only big-endian.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.machine_name =3D &=
quot;mac99&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.fw_cfg =3D mm_fw_c=
fg_init(0xf0000510);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_c=
fg/signature&quot;, &amp;ctx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0test_fw_cfg_signature);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_c=
fg/id&quot;, &amp;ctx, test_fw_cfg_id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -231,14 +248,18 @@ int main(int argc, char **arg=
v)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qtest_add_func(&quot;fw_cfg/bo=
ot_device&quot;, test_fw_cfg_boot_device);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_c=
fg/max_cpus&quot;, &amp;ctx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0test_fw_cfg_max_cpus);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/num=
a&quot;, &amp;ctx, test_fw_cfg_numa);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_c=
fg/boot_menu&quot;, &amp;ctx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0test_fw_cfg_boot_menu);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_c=
fg/reboot_timeout&quot;, &amp;ctx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_fw_cfg_reboot_timeout);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_c=
fg/splash_time&quot;, &amp;ctx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0test_fw_cfg_splash_time);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 ret =3D g_test_run();<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (has_numa) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qtest_add_data_func(&q=
uot;fw_cfg/numa&quot;, &amp;ctx, test_fw_cfg_numa);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (ctx.machine_name) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D g_test_run();<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; <br>
&gt; I think we can omit this if statement. In which case the <br>
&gt; ctx.machine_name will be NULL?<br>
<br>
Here I thought about the PPC64 tests inheriting the PPC32 ones, and <br>
maybe someone update the tests/Makefile.include and this test will run <br>
on unexpected architectures.</blockquote><div><br></div><div>Sorry, I don&#=
39;t get your point here(PPC64 tests inheriting the PPC32),=C2=A0</div><div=
>could you please explain this more?</div><div><br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"> So if the machine is NULL=
 (another arch) we <br></blockquote><div><br></div><div>IIUC the &quot;-M&q=
uot; option must has an argument, maybe?</div><div><br></div><div>Thanks,</=
div><div>Li Qiang</div><div><br></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
don&#39;t crash and return successfully, so the testsuite continue.<br>
<br>
I might add a comment such:<br>
<br>
=C2=A0 =C2=A0if (ctx.machine_name) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Only run whitelisted architecture. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D g_test_run();<br>
=C2=A0 =C2=A0}<br>
<br>
But maybe it is simpler to do at the beginning of main():<br>
<br>
=C2=A0 =C2=A0if (g_str_equal(arch, &quot;i386&quot;) || g_str_equal(arch, &=
quot;x86_64&quot;)) {<br>
=C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0ctx.fw_cfg =3D mm_fw_cfg_init(0xf0000510);<br>
=C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0}<br>
<br>
What do you think?<br>
<br>
Thanks for reviewing the whole series :)<br>
<br>
&gt; Thanks,<br>
&gt; Li Qiang<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(ctx.fw_cfg);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.21.0<br>
&gt; <br>
</blockquote></div></div>

--00000000000034c1b70594683720--

