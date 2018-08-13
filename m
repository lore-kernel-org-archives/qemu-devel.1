Received: from eggs.gnu.org ([2001:4830:134:3::10]:40054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpFdv-0003DY-27
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpFdu-0003dP-15
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:24:31 -0400
Date: Mon, 13 Aug 2018 18:24:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180813162421.GN4323@localhost.localdomain>
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-7-lbloch@janustech.com>
	<w5136vm8m8u.fsf@maestria.local.igalia.com>
	<ca79bbff-163b-f50e-e17b-54d6597e6bfe@redhat.com>
	<20180813112333.GD4323@localhost.localdomain>
	<e9a77f1e-6b9e-3fea-69c9-c18638961a2e@redhat.com>
	<20180813155856.GL4323@localhost.localdomain>
	<5436d747-9cf3-50a0-6fab-537fb8cc8bae@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <5436d747-9cf3-50a0-6fab-537fb8cc8bae@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 6/9] qcow2: Increase the default upper
 limit on the L2 cache size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.08.2018 um 18:08 hat Max Reitz geschrieben:
> >>> default should reflect that, especially considering that we only use
> >>> the memory on demand. If your image is only 32 GB, you'll never use m=
ore
> >>> than 4 MB of cache.
> >>
> >> Well, OK, yes.  This is an especially important point when it really is
> >> about hosts that have limited memory.  In those cases, users probably
> >> won't run huge images anyway.
> >>
> >>>                     And if your image is huge, but only access part of
> >>> it, we also won't use the full 32 MB.
> >>
> >> On Linux. O:-)
> >=20
> > No, on any system where qemu_try_blockalign() results in a COW zero
> > page.
>=20
> OK, yes, but why would you only ever access part of it?  Then you might
> just as well have created a smaller disk from the beginning.

I always create my qcow2 images larger than I actually need them. It
costs basically nothing and avoids the need to resize my partitions
inside the guest later.

And anyway, a disk with 100% usage is not the common case, but the point
where the user will either delete stuff or resize the image. For
long-running VMs, deleting stuff doesn't get rid of the large cache on
non-Linux, but I think we agree that long-running guests aren't what we
expect on those hosts?

> > The Linux-only addition is returning memory even after an access.
> >=20
> >> So it's good that you have calmed my nerves about how this might be
> >> problematic on Linux systems (it isn't in practice, although I disagree
> >> that people will find qcow2 to be the fault when their memory runs out=
),
> >> but you haven't said anything about non-Linux systems.  I understand
> >> that you don't care, but as I said here, this was my only substantial
> >> concern anyway.
> >=20
> > I don't actually think it's so bad to keep the cache permanently
> > allocated, but I wouldn't object to a lower default for non-Linux hosts
> > either. 1 MB may still be a little too low, 4 MB (covers up to 32 GB)
> > might be more adequate. My typical desktop VMs are larger than 8 GB, but
> > smaller than 32 GB.
>=20
> Will your typical desktop VMs gain anything from the cache covering
> more than 8 GB?

Good point. Probably not.

> Anyway, I certainly won't complain about 4 MB.
>=20
> (My point here is that on non-Linux systems, qemu probably does not have
> users who have use cases where they need to access 256 GB of disk
> simultaneously.  Probably not even more than 8 GB.  If you want to
> increase the cache size there to 4 MB, fine, I think that won't hurt.
> But 32 MB might hurt, and I don't think on non-Linux systems there are
> users who would benefit from it -- specifically because your "typical
> desktop VM" wouldn't benefit from it.)

Maybe 1 MB is fine for them, after all.

Kevin

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbcbC1AAoJEH8JsnLIjy/W7L8P/3NBawJR9Xb9XWehFVxl0zSc
KSd+uKT07l30YTcdhwiT3Qqx1oh/9HB+kKM8Nt6m4xpoluGjXJOkpjS6iHoaP2tf
3FELkP22K7MxXdKjwsgl7rAqBDYKhCNhV9xrKMi3BCY+zwbOhB+S+79vKodglAhP
aNfB0OA892+YODyNGkM+KHAZr6r0Xc287zKogh2RswneYu7nVwm8kT2ofapYhW8V
MHxEju/X0rwYL2w3YJ79REI5HmL6eONusNqbJwJ1p6yq7IEdhSpUU9D7kPaLQEqM
q2WelYVn2uI1KVwdy/XKhrY8UFCuSU2famw4TOpB6rRnqodF9opIa/au/HhREMqc
gzkNSkdalr+BdEngXyK/5tqTDa18uHya/zFaNt/O7C5x6PE7rkFaUJW++NOGJx3g
npTVCP9ayit7mqfFiq9gOIvZ1Z3o6/4U/x32FO+gD8paWixQA6pHTcu8g07kTmo2
ZQu70x6VTR/LTYexn2yYjh8muKYOxSBdUoNNR99dkWYmZ0sne4D/QAJxZ4nzh6wc
8B+axJiz/iwwsstdfWomXJ2WuMj2Kg6l3/7oorc+NkW3zaE49OrAUFmYiGX5X6tV
Tq/hBXHsXDk24B4tGCxe0VXWV4KSovS5RhEmbc/JRGRElNytGx1ald9/KtCMzxD7
WZI7KCwBnPlf66YtMmRu
=3yGJ
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
