Received: from eggs.gnu.org ([2001:4830:134:3::10]:35237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgXbn-0003AF-RC
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgXbi-0001Oc-RV
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:09:31 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgXbi-0001Nt-J5
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:09:26 -0500
Received: by mail-wr0-x242.google.com with SMTP id z61so503529wrc.3
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 06:09:23 -0800 (PST)
Date: Wed, 22 Feb 2017 14:09:20 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170222140920.GA10201@stefanha-x1.localdomain>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
	<20170217214215.GK19045@localhost.localdomain>
	<F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
	<20170220110235.GD21255@stefanha-x1.localdomain>
	<CAAo6VWNwHbsQRxU18dNCjWaNfNrZNAV9FfOKW8=JeZCND2vHnQ@mail.gmail.com>
	<20170221105918.GA22731@stefanha-x1.localdomain>
	<20170221113353.GC17041@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20170221113353.GC17041@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: ashish mittal <ashmit602@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2017 at 11:33:53AM +0000, Daniel P. Berrange wrote:
> On Tue, Feb 21, 2017 at 10:59:18AM +0000, Stefan Hajnoczi wrote:
> > On Mon, Feb 20, 2017 at 03:34:57AM -0800, ashish mittal wrote:
> > > On Mon, Feb 20, 2017 at 3:02 AM, Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
> > > > On Sat, Feb 18, 2017 at 12:30:31AM +0000, Ketan Nilangekar wrote:
> > > >> On 2/17/17, 1:42 PM, "Jeff Cody" <jcody@redhat.com> wrote:
> > > >>
> > > >>     On Thu, Feb 16, 2017 at 02:24:19PM -0800, ashish mittal wrote:
> > > >>     > Hi,
> > > >>     >
> > > >>     > I am getting the following error with checkpatch.pl
> > > >>     >
> > > >>     > ERROR: externs should be avoided in .c files
> > > >>     > #78: FILE: block/vxhs.c:28:
> > > >>     > +QemuUUID qemu_uuid __attribute__ ((weak));
> > > >>     >
> > > >>     > Is there any way to get around this, or does it mean that I =
would have
> > > >>     > to add a vxhs.h just for this one entry?
> > > >>     >
> > > >>
> > > >>     I remain skeptical on the use of the qemu_uuid as a way to sel=
ect the TLS
> > > >>     cert.
> > > >>
> > > >> [ketan]
> > > >> Is there another identity that can be used for uniquely identifyin=
g instances?
> > > >> The requirement was to enforce vdisk access to owner instances.
> > > >
> > > > The qemu_uuid weak attribute looks suspect.  What is going to provi=
de a
> > > > strong qemu_uuid symbol?
> > > >
> > > > Why aren't configuration parameters like the UUID coming from the Q=
EMU
> > > > command-line?
> > > >
> > > > Stefan
> > >=20
> > > UUID will in fact come from the QEMU command line. VxHS is not doing
> > > anything special here. It will just use the value already available to
> > > qemu-kvm process.
> > >=20
> > > QemuUUID qemu_uuid;
> > > bool qemu_uuid_set;
> > >=20
> > > Both the above are defined in vl.c. vl.c will provide the strong
> > > symbol when available. There are certain binaries that do not get
> > > linked with vl.c (e.g. qemu-img). The weak symbol will come into
> > > affect for such binaries, and in this case, the default VXHS UUID will
> > > get picked up. I had, in a previous email, explained how we plan to
> > > use the default UUID. In the regular case, the VxHS controller will
> > > not allow access to the default UUID (non qemu-kvm) binaries, but it
> > > may choose to grant temporary access to specific vdisks for these
> > > binaries depending on the workflow.
> >=20
> > That idea sounds like a security problem.  During this time window
> > anyone could use the default UUID to access the data?
>=20
> Any use of the VM UUID as a means to control authorization on the
> server side is a security flaw, as this is a public value which
> cannot be trusted on its own.
>=20
> There needs to be some kind of authentication step to verify the
> reported identity, eg a password associated with the VM UUID that
> is validated before trusting the VM UUID.
>=20
> Alternatively there needs to be a completely separate UUID, unrelated
> to the VM UUID, which is treated as a private value (eg uses the
> '-object secret' framework in QEMU)

I thought the UUID is used to select the TLS client certificate and
associated private key.  So the UUID provides authorization although
what really matters is the client certificate, not the actual value of
the UUID.

Stefan

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrZuQAAoJEJykq7OBq3PIZnMH/ii0sTqulqZsXHdmyiz9ivGa
88i9vu/uwCZpsGsgXcxags9UU7VgQDSYry59AA5OkK9YaE7ro5SuoCBszI8WcioW
M27VSgJTZYPLtKACU8x+Itlni9w9dgtXYIuK7vQKEMHJsAZ7VnsMMq4FrSEFbtb2
wDc0iDbD3UyZ4GlvuQGni1oW0Ug258y4IiJxJTogVyiQeGbIO1Du8vZDc9FCJ548
5SxZhmVS2g133U9+VmNDF8yekn+ApkhIiJj7O7Z8Cg5fSRZhsNCZf4O9+icyNadO
STTfUbQsRd/ayHq33w2borSs0+4OgecKrkp2uMuxzdBskmSqUS5T2n1WoiPxYqs=
=PzKg
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
