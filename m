Received: from eggs.gnu.org ([2001:4830:134:3::10]:47096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cb8GQ-0000qX-DO
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cb8GL-0001Pa-FV
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:05:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cb8GL-0001Ow-Al
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:05:01 -0500
Date: Tue, 7 Feb 2017 17:04:56 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170207170456.77fd16d7@Igors-MacBook-Pro.local>
In-Reply-To: <20170207173429-mutt-send-email-mst@kernel.org>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
	<20170206170455-mutt-send-email-mst@kernel.org>
	<E609277C-1E60-48F6-B83E-2A6AEFB242F3@skyportsystems.com>
	<20170206193300-mutt-send-email-mst@kernel.org>
	<20170207150032.2807d29f@nial.brq.redhat.com>
	<20170207173429-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 05/10] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>, qemu-devel@nongnu.org, lersek@redhat.com

On Tue, 7 Feb 2017 17:35:19 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Feb 07, 2017 at 03:00:32PM +0100, Igor Mammedov wrote:
> > On Mon, 6 Feb 2017 19:41:36 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >=20
> > > On Mon, Feb 06, 2017 at 09:29:30AM -0800, Ben Warren wrote:
> > > >=20
> > > >     On Feb 6, 2017, at 8:15 AM, Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> > > >=20
> > > >     On Sun, Feb 05, 2017 at 01:12:00AM -0800, ben@skyportsystems.co=
m wrote:
> > > >=20
> > > >         From: Ben Warren <ben@skyportsystems.com>
> > > >=20
> > > >         This implements the VM Generation ID feature by passing a 1=
28-bit
> > > >         GUID to the guest via a fw_cfg blob.
> > > >         Any time the GUID changes, an ACPI notify event is sent to =
the guest
> > > >=20
> > > >         The user interface is a simple device with one parameter:
> > > >         - guid (string, must be "auto" or in UUID format
> > > >           xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
> > > >=20
> > > >         Signed-off-by: Ben Warren <ben@skyportsystems.com>
> > > >=20
> > [...]
> >=20
> > > >=20
> > > > This variable name was suggested by Laszlo.  the =E2=80=98a=E2=80=
=99 in =E2=80=98vgia=E2=80=99 refers to
> > > > address, but I=E2=80=99ll add some comments. =20
> > >=20
> > > vmgenid_addr_le?
> > >=20
> > >=20
> > > >     How about we make it 8 byte so it's future proof?
> > > >=20
> > > > I can do that, but a previous conversation we had made it clear tha=
t guests
> > > > would never allocate above 4GB so 64 bits wasn=E2=80=99t necessary.=
 =20
> > >=20
> > > Right, it's just very painful to change once we make it 32 bit.
> > I'd keep it 32 bit since it's in variable in global AML context and our
> > table revision is 1, so per spec OSPM should handle it as 32 number.
> > Chances of guest survival on boot would depend on AML interpreter toler=
ance
> > to AML errors, which for windows usually is 0 and leads to non obvious =
BSOD.
> > If we leave DWORD, even XP will be able to boot fine and only report
> > unknown device.
>=20
> AML reports 2 DWORDS per spec, no issue there. I guess it's exactly for
> XP compatibility.=20
=20
it's only ADDR method thought but we are talking about
Named DWORD vs QWORD VGIA variable which is patched by linker command=20
=20
