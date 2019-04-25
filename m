Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502AAC43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B8A20644
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B8A20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJf3I-0000rl-B9
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:08:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJeTb-0003Pe-A9
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJeTa-00068B-6H
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:31:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJeTZ-00067t-UP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:31:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C421308FED4;
	Thu, 25 Apr 2019 13:31:45 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C0171001DC0;
	Thu, 25 Apr 2019 13:31:38 +0000 (UTC)
Date: Thu, 25 Apr 2019 15:31:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190425153134.585b614d@redhat.com>
In-Reply-To: <1f64a17a-57e8-448f-ced2-860d137eebaa@redhat.com>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-12-git-send-email-imammedo@redhat.com>
	<1f64a17a-57e8-448f-ced2-860d137eebaa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 25 Apr 2019 13:31:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 11/13] tests: acpi: add simple arm/virt
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
	"Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425133134.XY7LUEEvtSmyk4A8Tq48CJ2h8KIBsHojrVreH4htr9w@z>

On Thu, 25 Apr 2019 14:41:28 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 4/25/19 7:34 AM, Igor Mammedov wrote:
> > adds simple arm/virt test case that starts guest with
> > bios-tables-test.aarch64.iso.qcow2 boot image which
> > initializes UefiTestSupport* structure in RAM once
> > guest is booted.
> >=20
> >  * see commit: tests: acpi: add acpi_find_rsdp_address_uefi() helper
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Laszlo Ersek <lersek@redhat.com> =20
>=20
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =20
> Please replace previous R-b by:

done

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> > ---
> > v3:
> >   * use firmware blobs directly from pc-bios directory
> >   * use bios-tables-test.aarch64.iso.qcow2 as test boot image
> >   * drop leftover qtest-uefi-images-aarch64 iMakefile rule from
> >     previos version (Laszlo)
> >   * add Makefile rule to include bios-tables-test into
> >     check-qtest-aarch64 target
> > v2:
> >   * specify in test_data where board's RAM starts and RAM size
> > ---
> >  tests/Makefile.include   |  1 +
> >  tests/bios-tables-test.c | 17 +++++++++++++++++
> >  2 files changed, 18 insertions(+)
> >=20
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index e2432d5..983c8b1 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -267,6 +267,7 @@ check-qtest-arm-y +=3D tests/hexloader-test$(EXESUF)
> >  check-qtest-aarch64-y =3D tests/numa-test$(EXESUF)
> >  check-qtest-aarch64-y +=3D tests/boot-serial-test$(EXESUF)
> >  check-qtest-aarch64-y +=3D tests/migration-test$(EXESUF)
> > +check-qtest-aarch64-y +=3D tests/bios-tables-test$(EXESUF)
> > =20
> >  check-qtest-microblazeel-y +=3D $(check-qtest-microblaze-y)
> > =20
> > diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> > index 1be55a1..f117461 100644
> > --- a/tests/bios-tables-test.c
> > +++ b/tests/bios-tables-test.c
> > @@ -812,6 +812,21 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
> >      test_acpi_tcg_dimm_pxm(MACHINE_PC);
> >  }
> > =20
> > +static void test_acpi_virt_tcg(void)
> > +{
> > +    test_data data =3D {
> > +        .machine =3D "virt",
> > +        .uefi_fl1 =3D "pc-bios/edk2-aarch64-code.fd",
> > +        .uefi_fl2 =3D "pc-bios/edk2-arm-vars.fd",
> > +        .cd =3D "tests/data/uefi-boot-images/bios-tables-test.aarch64.=
iso.qcow2",
> > +        .ram_start =3D 0x40000000ULL,
> > +        .scan_len =3D 128ULL * 1024 * 1024,
> > +    };
> > +
> > +    test_acpi_one("-cpu cortex-a57 ", &data);
> > +    free_test_data(&data);
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >      const char *arch =3D qtest_get_arch();
> > @@ -840,6 +855,8 @@ int main(int argc, char *argv[])
> >          qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
> >          qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_=
pxm);
> >          qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
> > +    } else if (strcmp(arch, "aarch64") =3D=3D 0) {
> > +        qtest_add_func("acpi/virt", test_acpi_virt_tcg);
> >      }
> >      ret =3D g_test_run();
> >      boot_sector_cleanup(disk);
> >  =20
>=20


