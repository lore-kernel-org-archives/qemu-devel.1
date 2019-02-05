Received: from eggs.gnu.org ([209.51.188.92]:53215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gr3iK-0007ee-U2
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gr3iJ-00062z-Ac
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:36:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gr3iI-0005yV-NS
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:36:47 -0500
Date: Tue, 5 Feb 2019 11:36:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190205113147-mutt-send-email-mst@kernel.org>
References: <20190204160325.4914-1-lersek@redhat.com>
	<20190204160325.4914-5-lersek@redhat.com>
	<20190204124613-mutt-send-email-mst@kernel.org>
	<e9e9ed1d-0675-6a6e-1706-b6a23169719c@redhat.com>
	<20190204142534-mutt-send-email-mst@kernel.org>
	<d4e8a405-cfb5-a302-bc7f-34537f2d7fcf@redhat.com>
	<20190204165316-mutt-send-email-mst@kernel.org>
	<a4693593-0efe-77bf-ae68-4774d759b018@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a4693593-0efe-77bf-ae68-4774d759b018@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/5] tests/uefi-test-tools: add build
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On Tue, Feb 05, 2019 at 09:49:57AM +0100, Laszlo Ersek wrote:
> On 02/04/19 22:55, Michael S. Tsirkin wrote:
> > On Mon, Feb 04, 2019 at 08:46:33PM +0100, Philippe Mathieu-Daud=E9
> > wrote:
> >> Hi Michael,
> >>
> >> On 2/4/19 8:32 PM,  Michael S. Tsirkin wrote:
>=20
> >>> And question would be what if someone wanted a reproducible
> >>> build of QEMU, what would be the right way to do it?
> >>
> >> This question deserves his own thread :)
> >
> > Sure.
>=20
> (I don't know enough to comment on this sensibly; so I'm only following
> up to show that I'm not willfully ignoring the topic.)

Thanks!

> What constitutes a "QEMU build" in this context?
>=20
> If it means the sum of artifacts that get installed by "make install",
> then the current patch set doesn't factor into that at all.

That's true in that it's just a test.

> If it means something else, then "it depends". For example,
> "genisoimage" and "mkdosfs" place pseudo-random / timestamp-based
> identifiers into the images that they generate, and there's no way to
> prevent at least "genisoimage" from doing that. Thus, if we consider
> UEFI-bootable ISO images, rebuilt from zero, a part of a "reproducible
> build", then the answer is "there's no right way until someone extends
> genisoimage with some new cmdline options".

Yep that's true too.

> >>> Yes right now roms seems to be broken for an out of tree build but
> >>> is that by design and should we add more examples of this?
> >>
> >> IMO having these tests build out-of-tree is easier than trying to
> >> build various of the projects in roms/ out-of-tree. This would be a
> >> good effort, but I'm not sure it is worth it with this series.
> >> Eventually once we have a qtest using the bios-tables, we could spen=
d
> >> some time to make this script work out-of-tree.
> >
> > I'm not saying it's a blocker.
>=20
> Regarding roms/edk2, we have to distinguish two sets of source code,
> wrt. building out-of-tree.
>=20
> - The firmware modules build just fine outside of the tree, and this
>   patch set already puts that feature to use. (Namely, all the
>   dependencies that the
>=20
>     tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTes=
t.inf
>=20
>   application pulls in from roms/edk2 are compiled outside of
>   roms/edk2.)
>=20
> - However, the native build utilities (in the
>=20
>     roms/edk2/BaseTools
>=20
>   subdirectory) that first have to be built natively, so that they can
>   help produce the firmware executables from the firmware source, don't
>   themselves build outside of that subdirectory. This is a genuine
>   limitation of upstream edk2, as far as I can tell.
>=20
> Thanks,
> Laszlo

Interesting, thanks for sharing.

--=20
MST
