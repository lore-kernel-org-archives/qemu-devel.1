Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45509C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 00:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F217220859
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 00:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtgACec2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F217220859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHzyG-0000Po-3X
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 20:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iHzxW-0008Px-4E
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 20:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iHzxU-0003yp-77
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 20:36:06 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:40534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iHzxT-0003yK-VW
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 20:36:04 -0400
Received: by mail-oi1-x236.google.com with SMTP id k9so307765oib.7
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 17:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AjEulyD4ZkM84HKsE9NgT7bGopNovtzDRZfXITxK8Aw=;
 b=VtgACec20J2YRlWly6sI+DKf6MjFQv0/21JTRfCRvC6ObKpX9WSZ++dsIUbKCfdaMU
 GI5qFyccKmtjMo4cgNx34tih/PrpU1cHoIkMWCNBfGQciGOeIotjF/ghXPgCoA3z21v0
 NhzwUzpGwP4IUTGWyHlXhOUSFFBB7t1PmIp6tCZcYlwr1oYFRaVYZcpvitdjoDDUMjSd
 VzcQVgocF8jet5fvebdlFFdBrQQhyLnn4lODlTPganWzmoRxvhshOSwF9z+7xYEjxswh
 e2SE/RjkZovue5cnWnvCsrQOqOO04CUOuNKt9pLI08Xqmi/2KTZEblswPSuzQjTg4htK
 yHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AjEulyD4ZkM84HKsE9NgT7bGopNovtzDRZfXITxK8Aw=;
 b=oskf47KNzZzSh292BvedDXz+cXeNl7IVTVxXL3CdxT5fU7taq7dGA7Rhhn1Z0/+euf
 SGuIojO/o22yBpeLh+JJoInMlUOpnPUwPXDX2mH6bbEnebwxvAXzMNXhBimAvXr2uoE3
 hUD90MHIHmut2wCnm/5Y7CLLBhQRTrBhoMhvFkjnU/vzQ+0CmzO2xchj4RNkR67DR6IS
 d5SJ5E4S13y4nlcRoxUw++q6Tu0zpLlv7oiIN8p603wD5BzLJWuGTIDLRPn0otwUxW1r
 2AjkFLfTASjzjDWDW74F6C5ydvER2cgHeo5fgD9za2T+O8oWB2BCqW/bAcQt1VjQN6PB
 RIyw==
X-Gm-Message-State: APjAAAWY6x2aoGwbBCqn5dBaTG8yOZt8ompNIdC1sAT7+Py3aS7lxkjS
 hmxiweiWEHX3zIU3oNvw3MTlvA1riNjVklfkh5Y=
X-Google-Smtp-Source: APXvYqxeLh+31/r30nbMwDYC5cfVCaECazvzNQjeLbuWX5tTI7FPBIOJAptVPMQVP30c6VnagYmr+OkZavgmZF5y2g0=
X-Received: by 2002:aca:cd4d:: with SMTP id d74mr286043oig.157.1570581363264; 
 Tue, 08 Oct 2019 17:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191007151905.32766-1-philmd@redhat.com>
 <20191007151905.32766-8-philmd@redhat.com>
 <CAKXe6S+B8y5fdFowN3+40baR-b4c0RDrsi+LvuNcx1g-Mx7LpA@mail.gmail.com>
 <f0178880-2526-c3ee-6ad5-1d66f2e23fd9@redhat.com>
In-Reply-To: <f0178880-2526-c3ee-6ad5-1d66f2e23fd9@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 9 Oct 2019 08:35:26 +0800
Message-ID: <CAKXe6SKSRLXVAi+k8MqjYx=GQoZYy0odMQEKZaMSx1vfDtWDhQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] tests/fw_cfg: Run the tests on big-endian targets
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003f941b05946f78c0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003f941b05946f78c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Laszlo Ersek <lersek@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=884:27=E5=86=99=E9=81=93=EF=BC=9A

> On 10/08/19 17:04, Li Qiang wrote:
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B41=
0=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:20=E5=86=99=E9=
=81=93=EF=BC=9A
> >
> >> We have been restricting our fw_cfg tests to the PC machine,
> >> which is a little-endian architecture.
> >> The fw_cfg device is also used on the SPARC and PowerPC
> >> architectures, which can run in big-endian configuration.
> >>
> >> Since we want to be sure our device does not regress
> >> regardless the endianess used, enable this test one
> >> these targets.
> >>
> >> The NUMA selector is X86 specific, restrict it to this arch.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> ---
> >> v2: test ppc32 too (lvivier)
> >> ---
> >>  tests/Makefile.include |  2 ++
> >>  tests/fw_cfg-test.c    | 33 +++++++++++++++++++++++++++------
> >>  2 files changed, 29 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tests/Makefile.include b/tests/Makefile.include
> >> index 3543451ed3..4ae3d5140a 100644
> >> --- a/tests/Makefile.include
> >> +++ b/tests/Makefile.include
> >> @@ -226,6 +226,7 @@ check-qtest-ppc-y +=3D tests/prom-env-test$(EXESUF=
)
> >>  check-qtest-ppc-y +=3D tests/drive_del-test$(EXESUF)
> >>  check-qtest-ppc-y +=3D tests/boot-serial-test$(EXESUF)
> >>  check-qtest-ppc-$(CONFIG_M48T59) +=3D tests/m48t59-test$(EXESUF)
> >> +check-qtest-ppc-y +=3D tests/fw_cfg-test$(EXESUF)
> >>
> >>  check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
> >>  check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/device-plug-test$(EXES=
UF)
> >> @@ -250,6 +251,7 @@ check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D
> >> tests/endianness-test$(EXESUF)
> >>  check-qtest-sparc-y +=3D tests/prom-env-test$(EXESUF)
> >>  check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)
> >>  check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)
> >> +check-qtest-sparc-y +=3D tests/fw_cfg-test$(EXESUF)
> >>
> >>  check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D
> tests/endianness-test$(EXESUF)
> >>  check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)
> >> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> >> index 35af0de7e6..1250e87097 100644
> >> --- a/tests/fw_cfg-test.c
> >> +++ b/tests/fw_cfg-test.c
> >> @@ -210,13 +210,30 @@ static void test_fw_cfg_splash_time(const void
> >> *opaque)
> >>
> >>  int main(int argc, char **argv)
> >>  {
> >> -    QTestCtx ctx;
> >> -    int ret;
> >> +    const char *arch =3D qtest_get_arch();
> >> +    bool has_numa =3D false;
> >> +    QTestCtx ctx =3D {};
> >> +    int ret =3D 0;
> >>
> >>      g_test_init(&argc, &argv, NULL);
> >>
> >> -    ctx.machine_name =3D "pc";
> >> -    ctx.fw_cfg =3D pc_fw_cfg_init();
> >> +    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
> >> +        has_numa =3D true;
> >> +        ctx.machine_name =3D "pc";
> >> +        ctx.fw_cfg =3D pc_fw_cfg_init();
> >> +    } else if (g_str_equal(arch, "sparc")) {
> >> +        ctx.machine_name =3D "SS-5";
> >> +        ctx.fw_cfg =3D mm_fw_cfg_init(0xd00000510ULL);
> >> +    } else if (g_str_equal(arch, "ppc") || g_str_equal(arch, "ppc64")=
)
> {
> >> +        /*
> >> +         * The mac99 machine is different for 32/64-bit target:
> >> +         *
> >> +         * ppc(32): the G4 which can be either little or big endian,
> >> +         * ppc64:   the G5 (970FX) is only big-endian.
> >> +         */
> >> +        ctx.machine_name =3D "mac99";
> >> +        ctx.fw_cfg =3D mm_fw_cfg_init(0xf0000510);
> >> +    }
> >>
> >>      qtest_add_data_func("fw_cfg/signature", &ctx,
> test_fw_cfg_signature);
> >>      qtest_add_data_func("fw_cfg/id", &ctx, test_fw_cfg_id);
> >> @@ -231,14 +248,18 @@ int main(int argc, char **argv)
> >>      qtest_add_func("fw_cfg/boot_device", test_fw_cfg_boot_device);
> >>  #endif
> >>      qtest_add_data_func("fw_cfg/max_cpus", &ctx, test_fw_cfg_max_cpus=
);
> >> -    qtest_add_data_func("fw_cfg/numa", &ctx, test_fw_cfg_numa);
> >>      qtest_add_data_func("fw_cfg/boot_menu", &ctx,
> test_fw_cfg_boot_menu);
> >>      qtest_add_data_func("fw_cfg/reboot_timeout", &ctx,
> >>                          test_fw_cfg_reboot_timeout);
> >>      qtest_add_data_func("fw_cfg/splash_time", &ctx,
> >> test_fw_cfg_splash_time);
> >>
> >> -    ret =3D g_test_run();
> >> +    if (has_numa) {
> >> +        qtest_add_data_func("fw_cfg/numa", &ctx, test_fw_cfg_numa);
> >> +    }
> >>
> >> +    if (ctx.machine_name) {
> >> +        ret =3D g_test_run();
> >> +    }
> >>
> >
> > I think we can omit this if statement. In which case the ctx.machine_na=
me
> > will be NULL?
>
> When "arch" differs from all of i386, x86_64, sparc, ppc, ppc64.
>

Yes, I just found the setting 'arch' lost 'else' branch.
Then in this case, I prefer 'just return'.  There is no need do other
things for non-support arch.
This is just like some other case, such as usb-hcd-ehci-test.c and
ahci-test.c.
Also, I don't find any conditional 'g_test_run' calling.

Thanks,
Li Qiang



>
> In that case, the original initializer will remain in effect, from:
>
>   QTestCtx ctx =3D {};
>
> (Admittedly, this is an ugly GNU-ism; for standard C, it should be
>
>   QTestCtx ctx =3D { 0 };
>
> but the GNU-ism is used quite frequently in QEMU elsewhere, so meh :) )
>
> Thanks
> Laszlo
>

--0000000000003f941b05946f78c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Laszlo Ersek &lt;<a href=3D"mailto:le=
rsek@redhat.com">lersek@redhat.com</a>&gt; =E4=BA=8E2019=E5=B9=B410=E6=9C=
=889=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=884:27=E5=86=99=E9=81=93=EF=
=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 10/08/=
19 17:04, Li Qiang wrote:<br>
&gt; Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" t=
arget=3D"_blank">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=B9=B410=E6=9C=
=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:20=E5=86=99=E9=81=93=
=EF=BC=9A<br>
&gt; <br>
&gt;&gt; We have been restricting our fw_cfg tests to the PC machine,<br>
&gt;&gt; which is a little-endian architecture.<br>
&gt;&gt; The fw_cfg device is also used on the SPARC and PowerPC<br>
&gt;&gt; architectures, which can run in big-endian configuration.<br>
&gt;&gt;<br>
&gt;&gt; Since we want to be sure our device does not regress<br>
&gt;&gt; regardless the endianess used, enable this test one<br>
&gt;&gt; these targets.<br>
&gt;&gt;<br>
&gt;&gt; The NUMA selector is X86 specific, restrict it to this arch.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:p=
hilmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; v2: test ppc32 too (lvivier)<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 tests/Makefile.include |=C2=A0 2 ++<br>
&gt;&gt;=C2=A0 tests/fw_cfg-test.c=C2=A0 =C2=A0 | 33 ++++++++++++++++++++++=
+++++------<br>
&gt;&gt;=C2=A0 2 files changed, 29 insertions(+), 6 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/tests/Makefile.include b/tests/Makefile.include<br>
&gt;&gt; index 3543451ed3..4ae3d5140a 100644<br>
&gt;&gt; --- a/tests/Makefile.include<br>
&gt;&gt; +++ b/tests/Makefile.include<br>
&gt;&gt; @@ -226,6 +226,7 @@ check-qtest-ppc-y +=3D tests/prom-env-test$(EX=
ESUF)<br>
&gt;&gt;=C2=A0 check-qtest-ppc-y +=3D tests/drive_del-test$(EXESUF)<br>
&gt;&gt;=C2=A0 check-qtest-ppc-y +=3D tests/boot-serial-test$(EXESUF)<br>
&gt;&gt;=C2=A0 check-qtest-ppc-$(CONFIG_M48T59) +=3D tests/m48t59-test$(EXE=
SUF)<br>
&gt;&gt; +check-qtest-ppc-y +=3D tests/fw_cfg-test$(EXESUF)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)<br>
&gt;&gt;=C2=A0 check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/device-plug-t=
est$(EXESUF)<br>
&gt;&gt; @@ -250,6 +251,7 @@ check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D<br=
>
&gt;&gt; tests/endianness-test$(EXESUF)<br>
&gt;&gt;=C2=A0 check-qtest-sparc-y +=3D tests/prom-env-test$(EXESUF)<br>
&gt;&gt;=C2=A0 check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)<br>
&gt;&gt;=C2=A0 check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)<br>
&gt;&gt; +check-qtest-sparc-y +=3D tests/fw_cfg-test$(EXESUF)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D tests/endianne=
ss-test$(EXESUF)<br>
&gt;&gt;=C2=A0 check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)<br>
&gt;&gt; diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c<br>
&gt;&gt; index 35af0de7e6..1250e87097 100644<br>
&gt;&gt; --- a/tests/fw_cfg-test.c<br>
&gt;&gt; +++ b/tests/fw_cfg-test.c<br>
&gt;&gt; @@ -210,13 +210,30 @@ static void test_fw_cfg_splash_time(const vo=
id<br>
&gt;&gt; *opaque)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 int main(int argc, char **argv)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt; -=C2=A0 =C2=A0 QTestCtx ctx;<br>
&gt;&gt; -=C2=A0 =C2=A0 int ret;<br>
&gt;&gt; +=C2=A0 =C2=A0 const char *arch =3D qtest_get_arch();<br>
&gt;&gt; +=C2=A0 =C2=A0 bool has_numa =3D false;<br>
&gt;&gt; +=C2=A0 =C2=A0 QTestCtx ctx =3D {};<br>
&gt;&gt; +=C2=A0 =C2=A0 int ret =3D 0;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 g_test_init(&amp;argc, &amp;argv, NULL);<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 ctx.machine_name =3D &quot;pc&quot;;<br>
&gt;&gt; -=C2=A0 =C2=A0 ctx.fw_cfg =3D pc_fw_cfg_init();<br>
&gt;&gt; +=C2=A0 =C2=A0 if (g_str_equal(arch, &quot;i386&quot;) || g_str_eq=
ual(arch, &quot;x86_64&quot;)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_numa =3D true;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.machine_name =3D &quot;pc&quot;;<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.fw_cfg =3D pc_fw_cfg_init();<br>
&gt;&gt; +=C2=A0 =C2=A0 } else if (g_str_equal(arch, &quot;sparc&quot;)) {<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.machine_name =3D &quot;SS-5&quot;=
;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.fw_cfg =3D mm_fw_cfg_init(0xd0000=
0510ULL);<br>
&gt;&gt; +=C2=A0 =C2=A0 } else if (g_str_equal(arch, &quot;ppc&quot;) || g_=
str_equal(arch, &quot;ppc64&quot;)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The mac99 machine is differen=
t for 32/64-bit target:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ppc(32): the G4 which can be =
either little or big endian,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ppc64:=C2=A0 =C2=A0the G5 (97=
0FX) is only big-endian.<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.machine_name =3D &quot;mac99&quot=
;;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.fw_cfg =3D mm_fw_cfg_init(0xf0000=
510);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/signature&quo=
t;, &amp;ctx, test_fw_cfg_signature);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/id&quot;, &am=
p;ctx, test_fw_cfg_id);<br>
&gt;&gt; @@ -231,14 +248,18 @@ int main(int argc, char **argv)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 qtest_add_func(&quot;fw_cfg/boot_device&quot;,=
 test_fw_cfg_boot_device);<br>
&gt;&gt;=C2=A0 #endif<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/max_cpus&quot=
;, &amp;ctx, test_fw_cfg_max_cpus);<br>
&gt;&gt; -=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/numa&quot;, &amp;c=
tx, test_fw_cfg_numa);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/boot_menu&quo=
t;, &amp;ctx, test_fw_cfg_boot_menu);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/reboot_timeou=
t&quot;, &amp;ctx,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 test_fw_cfg_reboot_timeout);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/splash_time&q=
uot;, &amp;ctx,<br>
&gt;&gt; test_fw_cfg_splash_time);<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 ret =3D g_test_run();<br>
&gt;&gt; +=C2=A0 =C2=A0 if (has_numa) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/numa=
&quot;, &amp;ctx, test_fw_cfg_numa);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 if (ctx.machine_name) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D g_test_run();<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;<br>
&gt; <br>
&gt; I think we can omit this if statement. In which case the ctx.machine_n=
ame<br>
&gt; will be NULL?<br>
<br>
When &quot;arch&quot; differs from all of i386, x86_64, sparc, ppc, ppc64.<=
br></blockquote><div><br></div><div>Yes, I just found the setting &#39;arch=
&#39; lost &#39;else&#39; branch.</div><div>Then in this case, I prefer &#3=
9;just return&#39;.=C2=A0 There is no need do other things for non-support =
arch.</div><div>This is just like some other case, such as usb-hcd-ehci-tes=
t.c and ahci-test.c.=C2=A0</div><div>Also, I don&#39;t find any conditional=
 &#39;g_test_run&#39; calling.</div><div><br></div><div>Thanks,</div><div>L=
i Qiang</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
In that case, the original initializer will remain in effect, from:<br>
<br>
=C2=A0 QTestCtx ctx =3D {};<br>
<br>
(Admittedly, this is an ugly GNU-ism; for standard C, it should be<br>
<br>
=C2=A0 QTestCtx ctx =3D { 0 };<br>
<br>
but the GNU-ism is used quite frequently in QEMU elsewhere, so meh :) )<br>
<br>
Thanks<br>
Laszlo<br>
</blockquote></div></div>

--0000000000003f941b05946f78c0--

