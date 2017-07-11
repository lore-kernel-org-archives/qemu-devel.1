Received: from eggs.gnu.org ([2001:4830:134:3::10]:52335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dUwlm-0002c1-2X
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dUwli-0002fW-Tj
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:08:10 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:32913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1dUwli-0002X9-NJ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:08:06 -0400
Received: by mail-pf0-x22f.google.com with SMTP id e7so1171305pfk.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:07:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Ben Warren <ben@skyportsystems.com>
In-Reply-To: <CAFEAcA_giHFa-aw=WuuqmVFL+dr7HeD9E1o=oLszQywJbAd0wA@mail.gmail.com>
Date: Tue, 11 Jul 2017 08:07:41 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <7EC3FA95-777F-4F8F-B02D-85FA09BAFC00@skyportsystems.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
	<1499111049-13721-20-git-send-email-mst@redhat.com>
	<CAFEAcA_giHFa-aw=WuuqmVFL+dr7HeD9E1o=oLszQywJbAd0wA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 19/21] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>

Hi Peter,
> On Jul 11, 2017, at 6:32 AM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On 3 July 2017 at 20:45, Michael S. Tsirkin <mst@redhat.com> wrote:
>> From: Ben Warren <ben@skyportsystems.com>
>>=20
>> The following tests are implemented:
>> * test that a GUID passed in by command line is propagated to the =
guest.
>>  Read the GUID from guest memory
>> * test that the "auto" argument to the GUID generates a valid GUID, =
as
>>  seen by the guest.
>> * test that a GUID passed in can be queried from the monitor
>>=20
>>  This patch is loosely based on a previous patch from:
>>  Gal Hammer <ghammer@redhat.com>  and Igor Mammedov =
<imammedo@redhat.com>
>>=20
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Hi -- this test seems to intermittently fail:
>=20
> TEST: tests/vmgenid-test... (pid=3D15466)
>  /i386/vmgenid/vmgenid/set-guid:                                      =
**
> ERROR:/home/peter.maydell/qemu/tests/vmgenid-test.c:65:acpi_find_vgia:
> assertion failed (ACPI_ASSERT_CMP
> _str =3D=3D "RSDT"): ("" =3D=3D "RSDT")
> FAIL
> GTester: last random seed: R02S27021da892f2124a377287729b848ff8
> (pid=3D15470)
>  /i386/vmgenid/vmgenid/set-guid-auto:                                 =
OK
>  /i386/vmgenid/vmgenid/query-monitor:                                 =
OK
> FAIL: tests/vmgenid-test
>=20
> (that's an aarch32 build).
>=20
>=20
I=E2=80=99ll try to reproduce.  How exactly are the tests called?
> Earlier in the run I see there was also a warning from acpi-test:
>=20
>  /i386/acpi/q35/memhp:
> "kvm" accelerator not found.
>=20
> Looking for expected file 'tests/acpi-test-data/q35/DSDT.memhp'
>=20
> Using expected file 'tests/acpi-test-data/q35/DSDT.memhp'
>=20
> Looking for expected file 'tests/acpi-test-data/q35/APIC.memhp'
>=20
> Looking for expected file 'tests/acpi-test-data/q35/APIC'
>=20
> Using expected file 'tests/acpi-test-data/q35/APIC'
>=20
> Looking for expected file 'tests/acpi-test-data/q35/HPET.memhp'
>=20
> Looking for expected file 'tests/acpi-test-data/q35/HPET'
>=20
> Using expected file 'tests/acpi-test-data/q35/HPET'
>=20
> Looking for expected file 'tests/acpi-test-data/q35/SRAT.memhp'
>=20
> Using expected file 'tests/acpi-test-data/q35/SRAT.memhp'
>=20
> Looking for expected file 'tests/acpi-test-data/q35/SLIT.memhp'
>=20
> Using expected file 'tests/acpi-test-data/q35/SLIT.memhp'
>=20
> Looking for expected file 'tests/acpi-test-data/q35/MCFG.memhp'
>=20
> Looking for expected file 'tests/acpi-test-data/q35/MCFG'
>=20
> Using expected file 'tests/acpi-test-data/q35/MCFG'
> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-E3X12Y.dsl,
> aml:/tmp/aml-GIX12Y], Expected [asl:/tmp/asl-5Z502Y.dsl,
> aml:tests/acpi-test-data/q35/DSDT.memhp].
> acpi-test: Warning. not showing difference since no diff utility is
> specified. Set 'DIFF' environment variable to a preferred diff utility
> and run 'make V=3D1 check' again to see ASL difference.OK
>=20
> (Shouldn't a DSDT mismatch cause a test failure?)
>=20
>=20
> thanks
> -- PMM
