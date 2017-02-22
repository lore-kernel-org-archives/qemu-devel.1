Received: from eggs.gnu.org ([2001:4830:134:3::10]:39125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgXrH-00079e-Ep
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgXrD-0005Ez-BA
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:25:31 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgXrD-0005En-1V
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:25:27 -0500
Received: by mail-wm0-x243.google.com with SMTP id u63so724698wmu.2
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:25:26 -0800 (PST)
Date: Wed, 22 Feb 2017 14:25:23 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170222142523.GB10201@stefanha-x1.localdomain>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
	<20170217214215.GK19045@localhost.localdomain>
	<F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
	<20170220110235.GD21255@stefanha-x1.localdomain>
	<CAAo6VWNwHbsQRxU18dNCjWaNfNrZNAV9FfOKW8=JeZCND2vHnQ@mail.gmail.com>
	<20170221105918.GA22731@stefanha-x1.localdomain>
	<A228B0EC-4D64-4174-A4FD-B3E00B836FD1@veritas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <A228B0EC-4D64-4174-A4FD-B3E00B836FD1@veritas.com>
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Cc: ashish mittal <ashmit602@gmail.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2017 at 05:21:46PM +0000, Ketan Nilangekar wrote:
>=20
>=20
> On 2/21/17, 5:59 AM, "Stefan Hajnoczi" <stefanha@gmail.com> wrote:
>=20
>     On Mon, Feb 20, 2017 at 03:34:57AM -0800, ashish mittal wrote:
>     > On Mon, Feb 20, 2017 at 3:02 AM, Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>     > > On Sat, Feb 18, 2017 at 12:30:31AM +0000, Ketan Nilangekar wrote:
>     > >> On 2/17/17, 1:42 PM, "Jeff Cody" <jcody@redhat.com> wrote:
>     > >>
>     > >>     On Thu, Feb 16, 2017 at 02:24:19PM -0800, ashish mittal wrot=
e:
>     > >>     > Hi,
>     > >>     >
>     > >>     > I am getting the following error with checkpatch.pl
>     > >>     >
>     > >>     > ERROR: externs should be avoided in .c files
>     > >>     > #78: FILE: block/vxhs.c:28:
>     > >>     > +QemuUUID qemu_uuid __attribute__ ((weak));
>     > >>     >
>     > >>     > Is there any way to get around this, or does it mean that =
I would have
>     > >>     > to add a vxhs.h just for this one entry?
>     > >>     >
>     > >>
>     > >>     I remain skeptical on the use of the qemu_uuid as a way to s=
elect the TLS
>     > >>     cert.
>     > >>
>     > >> [ketan]
>     > >> Is there another identity that can be used for uniquely identify=
ing instances?
>     > >> The requirement was to enforce vdisk access to owner instances.
>     > >
>     > > The qemu_uuid weak attribute looks suspect.  What is going to pro=
vide a
>     > > strong qemu_uuid symbol?
>     > >
>     > > Why aren't configuration parameters like the UUID coming from the=
 QEMU
>     > > command-line?
>     > >
>     > > Stefan
>     >=20
>     > UUID will in fact come from the QEMU command line. VxHS is not doing
>     > anything special here. It will just use the value already available=
 to
>     > qemu-kvm process.
>     >=20
>     > QemuUUID qemu_uuid;
>     > bool qemu_uuid_set;
>     >=20
>     > Both the above are defined in vl.c. vl.c will provide the strong
>     > symbol when available. There are certain binaries that do not get
>     > linked with vl.c (e.g. qemu-img). The weak symbol will come into
>     > affect for such binaries, and in this case, the default VXHS UUID w=
ill
>     > get picked up. I had, in a previous email, explained how we plan to
>     > use the default UUID. In the regular case, the VxHS controller will
>     > not allow access to the default UUID (non qemu-kvm) binaries, but it
>     > may choose to grant temporary access to specific vdisks for these
>     > binaries depending on the workflow.
>    =20
>     That idea sounds like a security problem.  During this time window
>     anyone could use the default UUID to access the data?
>    =20
>     Just make the UUID (or TLS client certificate file) a command-line
>     parameter that qemu-system, qemu-img, and other tools accept (e.g.
>     qemu-img via the --image-opts/--object syntax).
>    =20
> [Ketan]
> Sounds fair. Would it be ok to take this up after the driver is merged fo=
r the upcoming QEMU release?

No, because the current command-line interface isn't production-ready.
QEMU's command-line interface must stay backwards compatible forever so
merging the incomplete code now will create problems.

Start by tackling the comments that Daniel Berrange made 9 days ago
about hardcoded paths in libvxhs:
https://github.com/VeritasHyperScale/libqnio/pull/12#discussion_r100812640

As a consequence of resolving that issue, the QEMU block driver will
need new command-line parameters so it can pass in the configuration.
Then qemu_uuid will not be needed anymore because the command-line
parameters should already specify everything that libvxhs needs.

Stefan

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrZ9TAAoJEJykq7OBq3PIOYoIAJyRs7kz7QUuTkEWam8vSJ0q
r+R3T2oEV9lzQYhb0ic7ro04Kw/BOfsynGq3Sve6eZs92yynouMjssVU4gUbCsfR
/FmbqaI2Yp3ENzxg2TRMYwvNO6YMWow2vEQVn90LpQa5JXJdvw4yQ8kzNlLAxsn3
apQ5RPvArOgrtsAMjNGgTPhq3vXpEgcaSgeYdPKBBkJjri5Hec8rwOvD1tiFo/tg
h7CHy2BvOVrf8cAEmZboEHckPybT7jZB0+ecWmQM12DwYhPiKftrPY5ZBHndpnbE
w91dUSnjDNFdWgZEk+rVbYzSaOHq8SQS5lo2/sGNuvetfOTKMCibd1L6kPl4URc=
=g87/
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
