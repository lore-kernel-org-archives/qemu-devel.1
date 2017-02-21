Received: from eggs.gnu.org ([2001:4830:134:3::10]:52181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cg8AS-0001H0-6Q
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cg8AN-0006Ta-6y
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:59:36 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cg8AN-0006TN-0M
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:59:31 -0500
Received: by mail-wm0-x244.google.com with SMTP id v77so19016320wmv.0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:59:30 -0800 (PST)
Date: Tue, 21 Feb 2017 10:59:18 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170221105918.GA22731@stefanha-x1.localdomain>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
	<20170217214215.GK19045@localhost.localdomain>
	<F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
	<20170220110235.GD21255@stefanha-x1.localdomain>
	<CAAo6VWNwHbsQRxU18dNCjWaNfNrZNAV9FfOKW8=JeZCND2vHnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <CAAo6VWNwHbsQRxU18dNCjWaNfNrZNAV9FfOKW8=JeZCND2vHnQ@mail.gmail.com>
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
To: ashish mittal <ashmit602@gmail.com>
Cc: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:34:57AM -0800, ashish mittal wrote:
> On Mon, Feb 20, 2017 at 3:02 AM, Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> > On Sat, Feb 18, 2017 at 12:30:31AM +0000, Ketan Nilangekar wrote:
> >> On 2/17/17, 1:42 PM, "Jeff Cody" <jcody@redhat.com> wrote:
> >>
> >>     On Thu, Feb 16, 2017 at 02:24:19PM -0800, ashish mittal wrote:
> >>     > Hi,
> >>     >
> >>     > I am getting the following error with checkpatch.pl
> >>     >
> >>     > ERROR: externs should be avoided in .c files
> >>     > #78: FILE: block/vxhs.c:28:
> >>     > +QemuUUID qemu_uuid __attribute__ ((weak));
> >>     >
> >>     > Is there any way to get around this, or does it mean that I woul=
d have
> >>     > to add a vxhs.h just for this one entry?
> >>     >
> >>
> >>     I remain skeptical on the use of the qemu_uuid as a way to select =
the TLS
> >>     cert.
> >>
> >> [ketan]
> >> Is there another identity that can be used for uniquely identifying in=
stances?
> >> The requirement was to enforce vdisk access to owner instances.
> >
> > The qemu_uuid weak attribute looks suspect.  What is going to provide a
> > strong qemu_uuid symbol?
> >
> > Why aren't configuration parameters like the UUID coming from the QEMU
> > command-line?
> >
> > Stefan
>=20
> UUID will in fact come from the QEMU command line. VxHS is not doing
> anything special here. It will just use the value already available to
> qemu-kvm process.
>=20
> QemuUUID qemu_uuid;
> bool qemu_uuid_set;
>=20
> Both the above are defined in vl.c. vl.c will provide the strong
> symbol when available. There are certain binaries that do not get
> linked with vl.c (e.g. qemu-img). The weak symbol will come into
> affect for such binaries, and in this case, the default VXHS UUID will
> get picked up. I had, in a previous email, explained how we plan to
> use the default UUID. In the regular case, the VxHS controller will
> not allow access to the default UUID (non qemu-kvm) binaries, but it
> may choose to grant temporary access to specific vdisks for these
> binaries depending on the workflow.

That idea sounds like a security problem.  During this time window
anyone could use the default UUID to access the data?

Just make the UUID (or TLS client certificate file) a command-line
parameter that qemu-system, qemu-img, and other tools accept (e.g.
qemu-img via the --image-opts/--object syntax).

Stefan

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrB2GAAoJEJykq7OBq3PI23AH/j67yOR3nJiesWLYut1Z6tzR
gC/E7Vq95tNDbFKcF+15ugmq8a3H14RjgjfxFdefZsHn37mhJ5Kr7qOU2s1oaZhK
CPGOXeS43BPGDbPnVSqmHY6plkHvuDUKSlIS3J4dhGD0lH+UFxE4yaUAa/xCd9rK
TGdl5u9HaXxe6FV7CoFxXCUc+xM12Hn/KpixOACoe6boW5p3LC8WYF0R+6uSXSx0
TsqQXanqKGzfYRcmeuwnDYgXiL+EKg06H6E/dZDOUu4lSFqHb+66BZw+eDFg5Rhz
99Joju/QbnOBoEfY389UZBzc1lssbZoWSt/RTs9hRYP5ctP8BVUJNG/EEvSCRLg=
=nt4e
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
