Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DFDC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 18:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87930204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 18:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87930204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57089 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMGbz-0008Ur-S0
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 14:39:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hMGb8-0008Do-JC
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hMGb7-0005FL-Ie
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:38:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hMGb7-0005F2-B7
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:38:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D42230715CA;
	Thu,  2 May 2019 18:38:20 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-207.rdu2.redhat.com
	[10.10.120.207])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6DBF4608A5;
	Thu,  2 May 2019 18:38:13 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
	<1556808723-226478-14-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <33b6a2be-fb11-58ac-812b-798267696e16@redhat.com>
Date: Thu, 2 May 2019 20:38:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1556808723-226478-14-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 02 May 2019 18:38:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 13/15] tests: acpi: add simple arm/virt
 testcase
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, linuxarm@huawei.com,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, xuwei5@huawei.com,
	xuwei5@hisilicon.com,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502183812.ONFoVdn92O3qXLTrBsbUY4MoWekv56o8TXznbWY79kU@z>

On 05/02/19 16:52, Igor Mammedov wrote:
> adds simple arm/virt test case that starts guest with
> bios-tables-test.aarch64.iso.qcow2 boot image which
> initializes UefiTestSupport* structure in RAM once
> guest is booted.
>=20
>  * see commit: tests: acpi: add acpi_find_rsdp_address_uefi() helper
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v4:
>   * force test to use TCG accelerator
> v3:
>   * use firmware blobs directly from pc-bios directory
>   * use bios-tables-test.aarch64.iso.qcow2 as test boot image
>   * drop leftover qtest-uefi-images-aarch64 iMakefile rule from
>     previos version (Laszlo)
>   * add Makefile rule to include bios-tables-test into
>     check-qtest-aarch64 target
> v2:
>   * specify in test_data where board's RAM starts and RAM size
>=20
> fixup! tests: acpi: add simple arm/virt testcase
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/Makefile.include   |  1 +
>  tests/bios-tables-test.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index e2432d5..983c8b1 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -267,6 +267,7 @@ check-qtest-arm-y +=3D tests/hexloader-test$(EXESUF=
)
>  check-qtest-aarch64-y =3D tests/numa-test$(EXESUF)
>  check-qtest-aarch64-y +=3D tests/boot-serial-test$(EXESUF)
>  check-qtest-aarch64-y +=3D tests/migration-test$(EXESUF)
> +check-qtest-aarch64-y +=3D tests/bios-tables-test$(EXESUF)
> =20
>  check-qtest-microblazeel-y +=3D $(check-qtest-microblaze-y)
> =20
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 39c1e24..eaa1b0c 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -810,6 +810,22 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
>      test_acpi_tcg_dimm_pxm(MACHINE_PC);
>  }
> =20
> +static void test_acpi_virt_tcg(void)
> +{
> +    test_data data =3D {
> +        .machine =3D "virt",
> +        .accel =3D "tcg",
> +        .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> +        .cd =3D "tests/data/uefi-boot-images/bios-tables-test.aarch64.=
iso.qcow2",
> +        .ram_start =3D 0x40000000ULL,
> +        .scan_len =3D 128ULL * 1024 * 1024,
> +    };
> +
> +    test_acpi_one("-cpu cortex-a57", &data);
> +    free_test_data(&data);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      const char *arch =3D qtest_get_arch();
> @@ -838,6 +854,8 @@ int main(int argc, char *argv[])
>          qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
>          qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_=
pxm);
>          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm)=
;
> +    } else if (strcmp(arch, "aarch64") =3D=3D 0) {
> +        qtest_add_func("acpi/virt", test_acpi_virt_tcg);
>      }
>      ret =3D g_test_run();
>      boot_sector_cleanup(disk);
>=20

my R-b stands

thanks
Laszlo

