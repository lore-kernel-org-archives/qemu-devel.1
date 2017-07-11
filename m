Received: from eggs.gnu.org ([2001:4830:134:3::10]:47817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUvHm-00089d-49
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUvHh-0001Zj-Tj
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:33:06 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUvHh-0001ZN-Ly
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:33:01 -0400
Received: by mail-wr0-x234.google.com with SMTP id c11so183856959wrc.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 06:33:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499111049-13721-20-git-send-email-mst@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
	<1499111049-13721-20-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 14:32:39 +0100
Message-ID: <CAFEAcA_giHFa-aw=WuuqmVFL+dr7HeD9E1o=oLszQywJbAd0wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ben Warren <ben@skyportsystems.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 3 July 2017 at 20:45, Michael S. Tsirkin <mst@redhat.com> wrote:
> From: Ben Warren <ben@skyportsystems.com>
>
> The following tests are implemented:
> * test that a GUID passed in by command line is propagated to the guest.
>   Read the GUID from guest memory
> * test that the "auto" argument to the GUID generates a valid GUID, as
>   seen by the guest.
> * test that a GUID passed in can be queried from the monitor
>
>   This patch is loosely based on a previous patch from:
>   Gal Hammer <ghammer@redhat.com>  and Igor Mammedov <imammedo@redhat.com=
>
>
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi -- this test seems to intermittently fail:

TEST: tests/vmgenid-test... (pid=3D15466)
  /i386/vmgenid/vmgenid/set-guid:                                      **
ERROR:/home/peter.maydell/qemu/tests/vmgenid-test.c:65:acpi_find_vgia:
assertion failed (ACPI_ASSERT_CMP
_str =3D=3D "RSDT"): ("" =3D=3D "RSDT")
FAIL
GTester: last random seed: R02S27021da892f2124a377287729b848ff8
(pid=3D15470)
  /i386/vmgenid/vmgenid/set-guid-auto:                                 OK
  /i386/vmgenid/vmgenid/query-monitor:                                 OK
FAIL: tests/vmgenid-test

(that's an aarch32 build).


Earlier in the run I see there was also a warning from acpi-test:

  /i386/acpi/q35/memhp:
"kvm" accelerator not found.

Looking for expected file 'tests/acpi-test-data/q35/DSDT.memhp'

Using expected file 'tests/acpi-test-data/q35/DSDT.memhp'

Looking for expected file 'tests/acpi-test-data/q35/APIC.memhp'

Looking for expected file 'tests/acpi-test-data/q35/APIC'

Using expected file 'tests/acpi-test-data/q35/APIC'

Looking for expected file 'tests/acpi-test-data/q35/HPET.memhp'

Looking for expected file 'tests/acpi-test-data/q35/HPET'

Using expected file 'tests/acpi-test-data/q35/HPET'

Looking for expected file 'tests/acpi-test-data/q35/SRAT.memhp'

Using expected file 'tests/acpi-test-data/q35/SRAT.memhp'

Looking for expected file 'tests/acpi-test-data/q35/SLIT.memhp'

Using expected file 'tests/acpi-test-data/q35/SLIT.memhp'

Looking for expected file 'tests/acpi-test-data/q35/MCFG.memhp'

Looking for expected file 'tests/acpi-test-data/q35/MCFG'

Using expected file 'tests/acpi-test-data/q35/MCFG'
acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-E3X12Y.dsl,
aml:/tmp/aml-GIX12Y], Expected [asl:/tmp/asl-5Z502Y.dsl,
aml:tests/acpi-test-data/q35/DSDT.memhp].
acpi-test: Warning. not showing difference since no diff utility is
specified. Set 'DIFF' environment variable to a preferred diff utility
and run 'make V=3D1 check' again to see ASL difference.OK

(Shouldn't a DSDT mismatch cause a test failure?)


thanks
-- PMM
