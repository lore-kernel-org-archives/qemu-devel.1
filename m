Received: from eggs.gnu.org ([2001:4830:134:3::10]:57553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkrKp-0008KM-2I
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkrKl-0002P2-Mr
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:34:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkrKl-0002Ol-Dd
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:34:03 -0400
Date: Thu, 24 Aug 2017 14:33:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170824143357.552a5cc0@nial.brq.redhat.com>
In-Reply-To: <033764b9-6098-1949-e4e7-a21cafcc6901@cn.fujitsu.com>
References: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1503372250-5092-3-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170823104051.36488fcb@nial.brq.redhat.com>
	<9b19623e-55e9-ebac-11d3-6ff5fff176fe@cn.fujitsu.com>
	<20170823144502.17203857@nial.brq.redhat.com>
	<f7857c7a-ff39-d8c5-284b-f24cca1bef02@cn.fujitsu.com>
	<20170823194734.518d5cb3@Igors-MacBook-Pro.local>
	<033764b9-6098-1949-e4e7-a21cafcc6901@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/2] ACPI/unit-test: Add a new testcase
 for RAM allocation in numa node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com

On Thu, 24 Aug 2017 09:42:28 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> Hi Igor,
>=20
> At 08/24/2017 01:47 AM, Igor Mammedov wrote:
> > On Wed, 23 Aug 2017 21:35:29 +0800
> > Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> > =20
> >> Hi Igor,
> >>
> >> At 08/23/2017 08:45 PM, Igor Mammedov wrote: =20
> >>> On Wed, 23 Aug 2017 20:12:51 +0800
> >>> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> >>> =20
> >>>> Hi Igor,
> >>>>
> >>>> At 08/23/2017 04:40 PM, Igor Mammedov wrote: =20
> >>>>> On Tue, 22 Aug 2017 11:24:10 +0800
> >>>>> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> >>>>> =20
> >>>>>> As QEMU supports the memory-less node, it is possible that there is
> >>>>>> no RAM in the first numa node(also be called as node0). eg:
> >>>>>>   ... \
> >>>>>>   -m 128,slots=3D3,maxmem=3D1G \
> >>>>>>   -numa node -numa node,mem=3D128M \
> >>>>>>
> >>>>>> But, this makes it hard for QEMU to build a known-to-work ACPI SRAT
> >>>>>> table. Only fixing it is not enough.
> >>>>>>
> >>>>>> Add a testcase for this situation to make sure the ACPI table is
> >>>>>> correct for guest.
> >>>>>>
> >>>>>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> >>>>>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> >>>>>> ---
> >>>>>>  tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 6463 bytes
> >>>>>>  tests/acpi-test-data/pc/SLIT.numamem  | Bin 0 -> 48 bytes
> >>>>>>  tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 264 bytes
> >>>>>>  tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 9147 bytes
> >>>>>>  tests/acpi-test-data/q35/SLIT.numamem | Bin 0 -> 48 bytes
> >>>>>>  tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 264 bytes
> >>>>>>  tests/bios-tables-test.c              |  30 +++++++++++++++++++++=
+++++++++
> >>>>>>  7 files changed, 30 insertions(+)
> >>>>>>  create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
> >>>>>>  create mode 100644 tests/acpi-test-data/pc/SLIT.numamem
> >>>>>>  create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
> >>>>>>  create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
> >>>>>>  create mode 100644 tests/acpi-test-data/q35/SLIT.numamem
> >>>>>>  create mode 100644 tests/acpi-test-data/q35/SRAT.numamem =20
> >>>>>
> >>>>>
> >>>>> considering only SRAT table has been changed and the other
> >>>>> tables match with default blobs, I'd suggest to keep only =20
> >>>>
> >>>>
> >>>> Our testcase is=EF=BC=9A
> >>>>
> >>>> +    test_acpi_one(" -m 128,slots=3D3,maxmem=3D1G"
> >>>> +                  " -numa node -numa node,mem=3D128"
> >>>> +                  " -numa dist,src=3D0,dst=3D1,val=3D21",
> >>>> +                  &data);
> >>>>
> >>>> The DSDT and SLIT don't match with default blobs. =20
> >>> do you actually need SLIT table /i.e. -numa dist/ for test at all?
> >>> it looks not relevant for the test case at the hand,
> >>> I'd suggest to drop '-numa dist' option for the test.
> >>> =20
> >>
> >> OK, Got it, will drop '-numa dist' option in next version.
> >> =20
> >>>>
> >>>> So, they can't be dropped. =20
> >>>
> >>> I wonder what's changed, could you post DSDT diff here?
> >>> =20
> >>
> >> Just like memory hot-plug cases, when we use the '-m 128
> >> 128,slots=3D3,maxmem=3D1G' option, As the ACPI spec said, There may be=
 some
> >> Memory Device in the DSDT table. =20
> > for your case '-numa node -numa node,mem=3D128', there is no need in en=
abling memory hotplug. =20
>=20
> Thank you very much for your kind explanation.
>=20
> Yes, I understood.
>=20
> > If I recall it correctly the default memory for x86 is 128Mb,
> > hence removing "-m" would probably make DSDT match default one. =20
>=20
> Yes, I removed the "-m":
>=20
> test_acpi_one(" -numa node -numa node,mem=3D128", &data);
>=20
> but, the DSDT didn't match the default one. because, if we support
> NUMA, the DSDT will give us "_PXM" to map the CPU to node.

Ok, looks like you'll have to include your variant of DSDT along with SRAT
