Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B21C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA1A20684
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA1A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHXqX-0006BQ-NB
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 14:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iHXpE-0005et-Rp
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iHXpC-0003Hz-9b
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:33:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iHXpC-0003Gu-1H
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:33:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC6C5C049E1A;
 Mon,  7 Oct 2019 18:33:36 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-11.rdu2.redhat.com
 [10.10.120.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2718D60127;
 Mon,  7 Oct 2019 18:33:26 +0000 (UTC)
Subject: Re: [PATCH v2 7/7] tests/fw_cfg: Run the tests on big-endian targets
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191007151905.32766-1-philmd@redhat.com>
 <20191007151905.32766-8-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a6e070e3-a910-5aa7-68e3-94644509cdd0@redhat.com>
Date: Mon, 7 Oct 2019 20:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191007151905.32766-8-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 07 Oct 2019 18:33:36 +0000 (UTC)
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
 Li Qiang <liq3ea@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/19 17:19, Philippe Mathieu-Daud=C3=A9 wrote:
> We have been restricting our fw_cfg tests to the PC machine,
> which is a little-endian architecture.
> The fw_cfg device is also used on the SPARC and PowerPC
> architectures, which can run in big-endian configuration.
>=20
> Since we want to be sure our device does not regress
> regardless the endianess used, enable this test one
> these targets.
>=20
> The NUMA selector is X86 specific, restrict it to this arch.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: test ppc32 too (lvivier)
> ---
>  tests/Makefile.include |  2 ++
>  tests/fw_cfg-test.c    | 33 +++++++++++++++++++++++++++------
>  2 files changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3543451ed3..4ae3d5140a 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -226,6 +226,7 @@ check-qtest-ppc-y +=3D tests/prom-env-test$(EXESUF)
>  check-qtest-ppc-y +=3D tests/drive_del-test$(EXESUF)
>  check-qtest-ppc-y +=3D tests/boot-serial-test$(EXESUF)
>  check-qtest-ppc-$(CONFIG_M48T59) +=3D tests/m48t59-test$(EXESUF)
> +check-qtest-ppc-y +=3D tests/fw_cfg-test$(EXESUF)
> =20
>  check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
>  check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/device-plug-test$(EXESU=
F)
> @@ -250,6 +251,7 @@ check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D tests/e=
ndianness-test$(EXESUF)
>  check-qtest-sparc-y +=3D tests/prom-env-test$(EXESUF)
>  check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)
>  check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)
> +check-qtest-sparc-y +=3D tests/fw_cfg-test$(EXESUF)
> =20
>  check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(E=
XESUF)
>  check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 35af0de7e6..1250e87097 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -210,13 +210,30 @@ static void test_fw_cfg_splash_time(const void *o=
paque)
> =20
>  int main(int argc, char **argv)
>  {
> -    QTestCtx ctx;
> -    int ret;
> +    const char *arch =3D qtest_get_arch();
> +    bool has_numa =3D false;
> +    QTestCtx ctx =3D {};
> +    int ret =3D 0;
> =20
>      g_test_init(&argc, &argv, NULL);
> =20
> -    ctx.machine_name =3D "pc";
> -    ctx.fw_cfg =3D pc_fw_cfg_init();
> +    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64")) {
> +        has_numa =3D true;
> +        ctx.machine_name =3D "pc";
> +        ctx.fw_cfg =3D pc_fw_cfg_init();
> +    } else if (g_str_equal(arch, "sparc")) {
> +        ctx.machine_name =3D "SS-5";
> +        ctx.fw_cfg =3D mm_fw_cfg_init(0xd00000510ULL);
> +    } else if (g_str_equal(arch, "ppc") || g_str_equal(arch, "ppc64"))=
 {
> +        /*
> +         * The mac99 machine is different for 32/64-bit target:
> +         *
> +         * ppc(32): the G4 which can be either little or big endian,
> +         * ppc64:   the G5 (970FX) is only big-endian.
> +         */
> +        ctx.machine_name =3D "mac99";
> +        ctx.fw_cfg =3D mm_fw_cfg_init(0xf0000510);
> +    }
> =20
>      qtest_add_data_func("fw_cfg/signature", &ctx, test_fw_cfg_signatur=
e);
>      qtest_add_data_func("fw_cfg/id", &ctx, test_fw_cfg_id);
> @@ -231,14 +248,18 @@ int main(int argc, char **argv)
>      qtest_add_func("fw_cfg/boot_device", test_fw_cfg_boot_device);
>  #endif
>      qtest_add_data_func("fw_cfg/max_cpus", &ctx, test_fw_cfg_max_cpus)=
;
> -    qtest_add_data_func("fw_cfg/numa", &ctx, test_fw_cfg_numa);
>      qtest_add_data_func("fw_cfg/boot_menu", &ctx, test_fw_cfg_boot_men=
u);
>      qtest_add_data_func("fw_cfg/reboot_timeout", &ctx,
>                          test_fw_cfg_reboot_timeout);
>      qtest_add_data_func("fw_cfg/splash_time", &ctx, test_fw_cfg_splash=
_time);
> =20
> -    ret =3D g_test_run();
> +    if (has_numa) {
> +        qtest_add_data_func("fw_cfg/numa", &ctx, test_fw_cfg_numa);
> +    }
> =20
> +    if (ctx.machine_name) {
> +        ret =3D g_test_run();
> +    }
>      g_free(ctx.fw_cfg);
> =20
>      return ret;
>=20

Too many foreign arch bits in this patch for me to give an R-b, but
structurally it looks OK to me.

Acked-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

