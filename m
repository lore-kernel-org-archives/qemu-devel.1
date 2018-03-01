Received: from eggs.gnu.org ([2001:4830:134:3::10]:40220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1erPbr-0001fD-S1
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1erPbr-0006C7-4d
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:55:03 -0500
Date: Thu, 1 Mar 2018 14:54:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180301145446.GA30789@stefanha-x1.localdomain>
References: <20180228181946.22958-1-stefanha@redhat.com>
	<20180301011517.GH21336@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20180301011517.GH21336@lemon.usersys.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 09:15:17AM +0800, Fam Zheng wrote:
> On Wed, 02/28 18:19, Stefan Hajnoczi wrote:
> > v2:
> >  * Tackle the .ioeventfd_stop() vs vq handler race by removing the ioev=
entfd
> >    from a BH in the IOThread [Fam]
> >=20
> > There are several race conditions in virtio-blk/virtio-scsi dataplane c=
ode.
> > This patch series addresses them, see the commit description for detail=
s on the
> > individual cases.
>=20
> This doesn't apply to master. Which branch is it based off?

Sorry, I was going to look up the Based-on: syntax and then forgot.  I'm
not sure where it's documented, here is a guess at how it works:

Based-on: "[PATCH v3 0/5] block: fix blk_aio_*() segfault when blk->root =
=3D=3D NULL" <20180216165015.30715-1-stefanha@redhat.com>

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJamBQ2AAoJEJykq7OBq3PIhKIH/AuPng512g7l/VUnmsexLsiM
tE2rX6FqnMHH50jy4lrJ6MhreWJrLFGL7H0b9alZPVTNL9qgIMrXTcIkFFeTTyxX
Uk6Dt6m765WbMDwGg5RSilEZdqfVL2ka5xb4q6tpAmgs2ytzUsoO6SSrdenW8H8w
RgqDmGxMzTsZEF5E4SEmtuJitGhRqM6JGXy7K2sNDqnsxuZJOVCaW02ZjXl4NT1B
WW0tTnqgOAO4I4M1w8sTuYKxlPJnrZ7ujzJa6TyOWdfvIOcyFgXNqW/6oGJ+ICIK
l8FAKjY4DQ8iIqSAmwGY8yLCbepFyBJjDYT9HYntvKkVDm/2OenyBNp0Mk0opf8=
=B9HW
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
