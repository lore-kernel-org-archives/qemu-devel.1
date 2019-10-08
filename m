Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48A3C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 919C6206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919C6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrD8-0005e1-NB
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHrBw-0004wP-LD
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHrBt-0002dU-PG
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:14:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHrBt-0002c0-Gh
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:14:21 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 200D1796EB
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 15:14:20 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n3so9293942wrt.9
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 08:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2gJbu35QPOqiu37mKNH3JN6Roo1Vux7b+bi3dNkB8kk=;
 b=t0ayMEPocyS1A61YlhTQoJ2Eo7xa5ySMduUHNnC0c1ehM1cHFaLFCm+b1cbGNMgzfN
 YmAz0RM5BCMvdMKHdVRA+rL9vNxZl8zIsOcC8LrT9LNtNythntnLdSt8sav1oKtb8EKk
 ZURU2cjtafD15wVNpXe/kmQFOa5LSeiP/ZLgzLo/Y3bq2ki4BBMNbpzzaGy08DFPfNFe
 HA9vzUXThzSr2R2cH5q3YH7R30x4kNRHHR9gbNjgSa1DBhhxSeTsYBtNqJfhOmisjIWp
 bx3JMMdPbwsFcJ93RHGW/YCp9oAJnYVc7U5McVJKrB75oa+obNxrOR7pwoBs0/c0NaUY
 mCEg==
X-Gm-Message-State: APjAAAVC5aPrRxtpk/7nCbyLWCtImWQvE7aytaLfodmE3jKlbc7nNYVA
 CnZ9NtRpU1dewKGqAezxtYGzGUSCOHu57hif8bAMXgauMzgbH0P3DR54md9srj5eDRZUYmcenSK
 CFhos4E/AYq6xoy0=
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr4180858wmj.126.1570547658782; 
 Tue, 08 Oct 2019 08:14:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwVyeDNZxet0gWBwAm3sBn3ia4Dc3mWwUR4HUcOqeBcG3gDbCt5yX9qpg2si17Zk4/Ob5lIxw==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr4180832wmj.126.1570547658509; 
 Tue, 08 Oct 2019 08:14:18 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id m16sm3053329wml.11.2019.10.08.08.14.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 08:14:17 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] tests/fw_cfg: Run the tests on big-endian targets
To: Li Qiang <liq3ea@gmail.com>
References: <20191007151905.32766-1-philmd@redhat.com>
 <20191007151905.32766-8-philmd@redhat.com>
 <CAKXe6S+B8y5fdFowN3+40baR-b4c0RDrsi+LvuNcx1g-Mx7LpA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <04036864-7839-a13f-b598-53ccc99c2d8c@redhat.com>
Date: Tue, 8 Oct 2019 17:14:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+B8y5fdFowN3+40baR-b4c0RDrsi+LvuNcx1g-Mx7LpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

Hi Li,

On 10/8/19 5:04 PM, Li Qiang wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com <mailto:philmd@redhat.co=
m>> =E4=BA=8E=20
> 2019=E5=B9=B410=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=88=
11:20=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     We have been restricting our fw_cfg tests to the PC machine,
>     which is a little-endian architecture.
>     The fw_cfg device is also used on the SPARC and PowerPC
>     architectures, which can run in big-endian configuration.
>=20
>     Since we want to be sure our device does not regress
>     regardless the endianess used, enable this test one
>     these targets.
>=20
>     The NUMA selector is X86 specific, restrict it to this arch.
>=20
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>     v2: test ppc32 too (lvivier)
>     ---
>      =C2=A0tests/Makefile.include |=C2=A0 2 ++
>      =C2=A0tests/fw_cfg-test.c=C2=A0 =C2=A0 | 33 ++++++++++++++++++++++=
+++++------
>      =C2=A02 files changed, 29 insertions(+), 6 deletions(-)
>=20
>     diff --git a/tests/Makefile.include b/tests/Makefile.include
>     index 3543451ed3..4ae3d5140a 100644
>     --- a/tests/Makefile.include
>     +++ b/tests/Makefile.include
>     @@ -226,6 +226,7 @@ check-qtest-ppc-y +=3D tests/prom-env-test$(EXE=
SUF)
>      =C2=A0check-qtest-ppc-y +=3D tests/drive_del-test$(EXESUF)
>      =C2=A0check-qtest-ppc-y +=3D tests/boot-serial-test$(EXESUF)
>      =C2=A0check-qtest-ppc-$(CONFIG_M48T59) +=3D tests/m48t59-test$(EXE=
SUF)
>     +check-qtest-ppc-y +=3D tests/fw_cfg-test$(EXESUF)
>=20
>      =C2=A0check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
>      =C2=A0check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/device-plug-t=
est$(EXESUF)
>     @@ -250,6 +251,7 @@ check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D
>     tests/endianness-test$(EXESUF)
>      =C2=A0check-qtest-sparc-y +=3D tests/prom-env-test$(EXESUF)
>      =C2=A0check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)
>      =C2=A0check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)
>     +check-qtest-sparc-y +=3D tests/fw_cfg-test$(EXESUF)
>=20
>      =C2=A0check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D
>     tests/endianness-test$(EXESUF)
>      =C2=A0check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)
>     diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
>     index 35af0de7e6..1250e87097 100644
>     --- a/tests/fw_cfg-test.c
>     +++ b/tests/fw_cfg-test.c
>     @@ -210,13 +210,30 @@ static void test_fw_cfg_splash_time(const voi=
d
>     *opaque)
>=20
>      =C2=A0int main(int argc, char **argv)
>      =C2=A0{
>     -=C2=A0 =C2=A0 QTestCtx ctx;
>     -=C2=A0 =C2=A0 int ret;
>     +=C2=A0 =C2=A0 const char *arch =3D qtest_get_arch();
>     +=C2=A0 =C2=A0 bool has_numa =3D false;
>     +=C2=A0 =C2=A0 QTestCtx ctx =3D {};
>     +=C2=A0 =C2=A0 int ret =3D 0;
>=20
>      =C2=A0 =C2=A0 =C2=A0g_test_init(&argc, &argv, NULL);
>=20
>     -=C2=A0 =C2=A0 ctx.machine_name =3D "pc";
>     -=C2=A0 =C2=A0 ctx.fw_cfg =3D pc_fw_cfg_init();
>     +=C2=A0 =C2=A0 if (g_str_equal(arch, "i386") || g_str_equal(arch, "=
x86_64")) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 has_numa =3D true;
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.machine_name =3D "pc";
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.fw_cfg =3D pc_fw_cfg_init();
>     +=C2=A0 =C2=A0 } else if (g_str_equal(arch, "sparc")) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.machine_name =3D "SS-5";
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.fw_cfg =3D mm_fw_cfg_init(0xd00000=
510ULL);
>     +=C2=A0 =C2=A0 } else if (g_str_equal(arch, "ppc") || g_str_equal(a=
rch,
>     "ppc64")) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The mac99 machine is different=
 for 32/64-bit target:
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ppc(32): the G4 which can be e=
ither little or big endian,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ppc64:=C2=A0 =C2=A0the G5 (970=
FX) is only big-endian.
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.machine_name =3D "mac99";
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.fw_cfg =3D mm_fw_cfg_init(0xf00005=
10);
>     +=C2=A0 =C2=A0 }
>=20
>      =C2=A0 =C2=A0 =C2=A0qtest_add_data_func("fw_cfg/signature", &ctx,
>     test_fw_cfg_signature);
>      =C2=A0 =C2=A0 =C2=A0qtest_add_data_func("fw_cfg/id", &ctx, test_fw=
_cfg_id);
>     @@ -231,14 +248,18 @@ int main(int argc, char **argv)
>      =C2=A0 =C2=A0 =C2=A0qtest_add_func("fw_cfg/boot_device", test_fw_c=
fg_boot_device);
>      =C2=A0#endif
>      =C2=A0 =C2=A0 =C2=A0qtest_add_data_func("fw_cfg/max_cpus", &ctx,
>     test_fw_cfg_max_cpus);
>     -=C2=A0 =C2=A0 qtest_add_data_func("fw_cfg/numa", &ctx, test_fw_cfg=
_numa);
>      =C2=A0 =C2=A0 =C2=A0qtest_add_data_func("fw_cfg/boot_menu", &ctx,
>     test_fw_cfg_boot_menu);
>      =C2=A0 =C2=A0 =C2=A0qtest_add_data_func("fw_cfg/reboot_timeout", &=
ctx,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0test_fw_cfg_reboot_timeout);
>      =C2=A0 =C2=A0 =C2=A0qtest_add_data_func("fw_cfg/splash_time", &ctx=
,
>     test_fw_cfg_splash_time);
>=20
>     -=C2=A0 =C2=A0 ret =3D g_test_run();
>     +=C2=A0 =C2=A0 if (has_numa) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qtest_add_data_func("fw_cfg/numa", &ct=
x, test_fw_cfg_numa);
>     +=C2=A0 =C2=A0 }
>=20
>     +=C2=A0 =C2=A0 if (ctx.machine_name) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D g_test_run();
>     +=C2=A0 =C2=A0 }
>=20
>=20
> I think we can omit this if statement. In which case the=20
> ctx.machine_name will be NULL?

Here I thought about the PPC64 tests inheriting the PPC32 ones, and=20
maybe someone update the tests/Makefile.include and this test will run=20
on unexpected architectures. So if the machine is NULL (another arch) we=20
don't crash and return successfully, so the testsuite continue.

I might add a comment such:

   if (ctx.machine_name) {
       /* Only run whitelisted architecture. */
       ret =3D g_test_run();
   }

But maybe it is simpler to do at the beginning of main():

   if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
   ...
       ctx.fw_cfg =3D mm_fw_cfg_init(0xf0000510);
   } else {
       return 0;
   }

What do you think?

Thanks for reviewing the whole series :)

> Thanks,
> Li Qiang
>=20
>      =C2=A0 =C2=A0 =C2=A0g_free(ctx.fw_cfg);
>=20
>      =C2=A0 =C2=A0 =C2=A0return ret;
>     --=20
>     2.21.0
>=20

