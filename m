Received: from eggs.gnu.org ([2001:4830:134:3::10]:33143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eDC4o-0006Ia-VE
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eDC4o-0004VG-3z
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:22:42 -0500
Date: Fri, 10 Nov 2017 17:22:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171110162224.GG5466@localhost.localdomain>
References: <20171109204315.27072-1-mreitz@redhat.com>
	<20171110024557.GB4849@lemon>
	<20171110131752.GD5466@localhost.localdomain>
	<20171110133207.GA9235@lemon.Home>
	<d0e58edd-39cf-2bb5-61bd-442825b82ff9@redhat.com>
	<20171110160512.GF5466@localhost.localdomain>
	<e8ebf3e5-3f0c-1b9c-3ae4-e55c23c242a4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <e8ebf3e5-3f0c-1b9c-3ae4-e55c23c242a4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] block: Keep strong reference when
 draining all BDS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.11.2017 um 17:13 hat Max Reitz geschrieben:
> On 2017-11-10 17:05, Kevin Wolf wrote:
> > Am 10.11.2017 um 16:23 hat Max Reitz geschrieben:
> >> On 2017-11-10 14:32, Fam Zheng wrote:
> >>> On Fri, 11/10 14:17, Kevin Wolf wrote:
> >>>> Do you actually need to keep references to all BDSes in the whole li=
st
> >>>> while using the iterator or would it be enough to just keep a refere=
nce
> >>>> to the current one?
> >>>
> >>> To fix the bug we now see I think keeping the current is enough, but =
I think
> >>> implementing just like this patch is also good with some future-proof=
ing: we
> >>> cannot know what will be wedged into the nexted aio_poll()'s over tim=
e (and yes,
> >>> we should really reduce the number of them.)
> >>
> >> I don't really want to think about whether it's safe to only keep a
> >> reference to the current BDS.  I can't imagine any case where destroyi=
ng
> >> one root BDS leads to destroying another, but I'd rather be safe and n=
ot
> >> have to think about it.  (Unless there is an important reason to only
> >> keep a strong reference to the current one.)
> >=20
> > Why would it be a problem if another BDS from the list went away? If it
> > is one that was already processed, we don't care, and if it was in the
> > yet unprocessed part of the list, we'll just never return it.
>=20
> You mean from bdrv_next() in its current form?  Well, I know that when I
> just put a bdrv_ref()/bdrv_unref() pair around the drain, I got a
> segfault in blk_all_next() in bdrv_next().  I can investigate more, but
> that's pretty much what I mean by "I don't really want to think about it".

No, I mean a bdrv_next() that is modified to bdrv_ref() only what
it->blk/it->bs point to currently instead of allocating a whole list.

Kevin

> So that's why I want bdrv_next() to copy all BDS into another list
> instead of iterating through them on the fly.  And if we do that, a
> disappearing BDS of course is an issue because we don't notice until
> we're trying to iterate over it, at which point we have a use-after-free.
>=20
> Max

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaBdJAAAoJEH8JsnLIjy/W1tcQALgbBT9dz45/32VGBjSbzkQR
u1+lVlF0y9+TpjlINmeZ2J6IFuHofsLBMd+VczmGRHIVV4NfGyvchNz3vZvW6Jp7
IXCyBnfj7+hcgtpFMk9DfOUhkNlEYOq0AkQCcFPaaSCpjqIf2WvQRbcsJj3H7hHo
ShTJhvNtZrD87G7Xql5kogAoxx+QjpNAuJkYwdc16uLsmQE95UtpqvyqESm+JS/B
0qGvOKJCGSXMnNXJcnf2p498GlfikVmv0/uZp7D345Do9eFbvOnEJU+cFLEWXYXr
FoIpznt/Dg84a7svnIcVI+ySdulQWnnhMcB8aiExzmrxlRhXW4gaCLlYlaWZs6CR
dHkOd1uT4jE6dGphEQi8NcxnGT/DeI4xDogWJT4BlLQ4Ybod5CFGWIX1HVskVe9L
+ny689Fpu0KNgzoCOKaC4XNS811NVGYKu8KSjGTCD+wwGB8DeU6KXzeygZFdCEy4
b1jX71H5k067RfpUy0u5+E4Je0lE9R11w86vcVgscUJTJm2Q+50YaUUnqOy1y77Q
1EkUlFcxQEvXu2fvECu/++RJuRHpRv1AXVs7UIlui0T4td5bbAC6tKnU/aIG1Lms
YYrR8k/xZ+IhqeuHU54R4Zm+vSkf9h5b/U8OlfaRqKik8RznGIvKH4FiypTrT0jZ
2ieAVn4QaT0qlncDhDx2
=GKPJ
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
