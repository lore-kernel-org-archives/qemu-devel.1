Received: from eggs.gnu.org ([2001:4830:134:3::10]:33198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkZP7-00071j-SG
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkZP3-0002Rh-9X
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:25:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkZP3-0002RB-0N
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:25:17 -0400
Date: Wed, 23 Aug 2017 14:25:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170823172511.GR19998@localhost.localdomain>
References: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1503372250-5092-3-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170823104051.36488fcb@nial.brq.redhat.com>
	<9b19623e-55e9-ebac-11d3-6ff5fff176fe@cn.fujitsu.com>
	<20170823144502.17203857@nial.brq.redhat.com>
	<f7857c7a-ff39-d8c5-284b-f24cca1bef02@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7857c7a-ff39-d8c5-284b-f24cca1bef02@cn.fujitsu.com>
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com

On Wed, Aug 23, 2017 at 09:35:29PM +0800, Dou Liyang wrote:
> Hi Igor,
>=20
> At 08/23/2017 08:45 PM, Igor Mammedov wrote:
> > On Wed, 23 Aug 2017 20:12:51 +0800
> > Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> >=20
> > > Hi Igor,
> > >=20
> > > At 08/23/2017 04:40 PM, Igor Mammedov wrote:
> > > > On Tue, 22 Aug 2017 11:24:10 +0800
> > > > Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> > > >=20
> > > > > As QEMU supports the memory-less node, it is possible that ther=
e is
> > > > > no RAM in the first numa node(also be called as node0). eg:
> > > > >   ... \
> > > > >   -m 128,slots=3D3,maxmem=3D1G \
> > > > >   -numa node -numa node,mem=3D128M \
> > > > >=20
> > > > > But, this makes it hard for QEMU to build a known-to-work ACPI =
SRAT
> > > > > table. Only fixing it is not enough.
> > > > >=20
> > > > > Add a testcase for this situation to make sure the ACPI table i=
s
> > > > > correct for guest.
> > > > >=20
> > > > > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > > Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> > > > > ---
> > > > >  tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 6463 bytes
> > > > >  tests/acpi-test-data/pc/SLIT.numamem  | Bin 0 -> 48 bytes
> > > > >  tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 264 bytes
> > > > >  tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 9147 bytes
> > > > >  tests/acpi-test-data/q35/SLIT.numamem | Bin 0 -> 48 bytes
> > > > >  tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 264 bytes
> > > > >  tests/bios-tables-test.c              |  30 ++++++++++++++++++=
++++++++++++
> > > > >  7 files changed, 30 insertions(+)
> > > > >  create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
> > > > >  create mode 100644 tests/acpi-test-data/pc/SLIT.numamem
> > > > >  create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
> > > > >  create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
> > > > >  create mode 100644 tests/acpi-test-data/q35/SLIT.numamem
> > > > >  create mode 100644 tests/acpi-test-data/q35/SRAT.numamem
> > > >=20
> > > >=20
> > > > considering only SRAT table has been changed and the other
> > > > tables match with default blobs, I'd suggest to keep only
> > >=20
> > >=20
> > > Our testcase is=EF=BC=9A
> > >=20
> > > +    test_acpi_one(" -m 128,slots=3D3,maxmem=3D1G"
> > > +                  " -numa node -numa node,mem=3D128"
> > > +                  " -numa dist,src=3D0,dst=3D1,val=3D21",
> > > +                  &data);
> > >=20
> > > The DSDT and SLIT don't match with default blobs.
> > do you actually need SLIT table /i.e. -numa dist/ for test at all?
> > it looks not relevant for the test case at the hand,
> > I'd suggest to drop '-numa dist' option for the test.
> >=20
>=20
> OK, Got it, will drop '-numa dist' option in next version.
>=20
> > >=20
> > > So, they can't be dropped.
> >=20
> > I wonder what's changed, could you post DSDT diff here?
> >=20
>=20
> Just like memory hot-plug cases, when we use the '-m
> 128,slots=3D3,maxmem=3D1G' option, As the ACPI spec said, There may be =
some
> Memory Device in the DSDT table.

Do you really need to use -m 128,slots=3D3,maxmem=3D1G to test your
bug fix?

--=20
Eduardo
