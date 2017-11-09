Received: from eggs.gnu.org ([2001:4830:134:3::10]:41518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCkqB-0005wS-Jt
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCkqA-00008B-DE
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:17:47 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:47625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eCkqA-00007z-67
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:17:46 -0500
Received: by mail-wm0-x233.google.com with SMTP id b14so1047932wme.2
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 03:17:46 -0800 (PST)
Date: Thu, 9 Nov 2017 11:17:43 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171109111743.GC17101@stefanha-x1.localdomain>
References: <20171107104653.8913-1-paul.durrant@citrix.com>
	<20171108174227.GC8403@stefanha-x1.localdomain>
	<fd24582135514408b2e25d2606a77e31@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <fd24582135514408b2e25d2606a77e31@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [PATCH v3] xen-disk: use an IOThread per instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Max Reitz <mreitz@redhat.com>


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2017 at 09:30:45AM +0000, Paul Durrant wrote:
> > -----Original Message-----
> > From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> > Sent: 08 November 2017 17:42
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Anthony
> > Perard <anthony.perard@citrix.com>; Kevin Wolf <kwolf@redhat.com>;
> > Stefano Stabellini <sstabellini@kernel.org>; Max Reitz <mreitz@redhat.c=
om>
> > Subject: Re: [Qemu-devel] [PATCH v3] xen-disk: use an IOThread per
> > instance
> >=20
> > On Tue, Nov 07, 2017 at 05:46:53AM -0500, Paul Durrant wrote:
> > > This patch allocates an IOThread object for each xen_disk instance and
> > > sets the AIO context appropriately on connect. This allows processing
> > > of I/O to proceed in parallel.
> > >
> > > The patch also adds tracepoints into xen_disk to make it possible to
> > > follow the state transtions of an instance in the log.
> >=20
> > virtio-blk and virtio-scsi allow the user to specify an IOThread object.
> > This allows users to configure the device<->IOThread mapping any way
> > they like (e.g. 1:1, M:N).  Are you sure you want to hard-code the
> > IOThread mapping?
>=20
> Stefan,
>=20
>   Realistically it's the only option at the moment. Xen PV backends are n=
ot configured bu QAPI... so no ability to control them from the command lin=
e or QMP. This is something I seriously intend to address in the near futur=
e but, for now, I simply want to unlock the performance boost that IOThread=
 can provide.

Okay.

Stefan

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBDlXAAoJEJykq7OBq3PIMcYIAKPnCNf/KBZJxmJd7SDAL8IA
1kiwr+bTeX9t0jVRFN4XN+EKDRWZOKdgyoeWiBv4S+NZnbNmv4APMf4W7/9YyBPD
p22w4mi/mj/j6gEk3ej2iHd+YAfCIS0kKh0PEqZqGMZHbx2VklVx+cBmCzzOoPXT
v/9o7vCINjoXQz8aQcj6Ce0y6qofOmUIccwte1quymw6X9HXLPrgBsOq3BLc72bX
l1eHKxXaRQBomT/Ot4iL/Kf1tHrIGRioSufckuK0pYojDYhBG9UnHLpAlDwIR5df
qulehS/Cg16YS75V79PSiAqf8UhBbRbQHdttrW7Oz1vNtkuWLVW1ZbPLIblHRhc=
=E1g5
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
