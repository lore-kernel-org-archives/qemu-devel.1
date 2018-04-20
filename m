Received: from eggs.gnu.org ([2001:4830:134:3::10]:53527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f9MJn-0000mX-Ea
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f9MJm-000505-RG
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:02:35 -0400
Date: Fri, 20 Apr 2018 11:02:21 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180420030221.GC10319@stefanha-x1.localdomain>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<20180419075232.31407-3-stefanha@redhat.com>
	<20180419090546.GA2730@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <20180419090546.GA2730@work-vm>
Subject: Re: [Qemu-devel] [RFC 2/2] block/file-posix: verify page cache is
 not used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 10:05:47AM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > This commit is for debugging only.  Do not merge it.
> >=20
> > mincore(2) checks whether pages are resident.  Use it to verify that
> > page cache has been dropped.
> >=20
> > You can trigger a verification failure by mmapping the image file from
> > another process and loading a byte from a page so that it becomes
> > resident.  bdrv_co_invalidate_cache() will fail while the process is
> > alive.
>=20
> It doesn't seem a bad diagnostic to keep in (with a switch to activate)
> for when we're faced with some weird corruption on some weird storage
> system.

Okay.  It's very slow to mmap an entire image file and query mincore(2)
so it needs to be off by default.

Stefan

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2Vg9AAoJEJykq7OBq3PIYIQH/jr7kUVMcn86LG/UPwbWthzr
7NBn1WSjgHBUXqC8PCQ6xsvqZAT4FwgJbiwYzYij80je26ASldrqnMxEEg1x7ug3
qmO8COqzFx050lIs2d+ROoK1+wMtI6DzKSpLVJq8wBa6huCbUCRg5OlORwHNW5eQ
Ilh45RqqDnslKkJJywvW/6PKl/0o5a/dpFrSIY150VjTcy6XYCVRz1XYT9IQofM7
63XtkE9ECDOQJajgDDTXwogSgyCAkqW6Uw+6zJpouWVrjNuioAvZL1ga8XbRA87k
SG89WXPQXQzBhSJD5aMZ46Y+1bKYVY0J/BzNB2b3f/xKZzNbYh442Hf9Qj8sv7E=
=buLL
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
