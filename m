Received: from eggs.gnu.org ([2001:4830:134:3::10]:58050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eDBoQ-0001xP-Ai
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eDBoP-0000sn-AI
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:05:46 -0500
Date: Fri, 10 Nov 2017 17:05:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171110160512.GF5466@localhost.localdomain>
References: <20171109204315.27072-1-mreitz@redhat.com>
	<20171110024557.GB4849@lemon>
	<20171110131752.GD5466@localhost.localdomain>
	<20171110133207.GA9235@lemon.Home>
	<d0e58edd-39cf-2bb5-61bd-442825b82ff9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <d0e58edd-39cf-2bb5-61bd-442825b82ff9@redhat.com>
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


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.11.2017 um 16:23 hat Max Reitz geschrieben:
> On 2017-11-10 14:32, Fam Zheng wrote:
> > On Fri, 11/10 14:17, Kevin Wolf wrote:
> >> Do you actually need to keep references to all BDSes in the whole list
> >> while using the iterator or would it be enough to just keep a reference
> >> to the current one?
> >=20
> > To fix the bug we now see I think keeping the current is enough, but I =
think
> > implementing just like this patch is also good with some future-proofin=
g: we
> > cannot know what will be wedged into the nexted aio_poll()'s over time =
(and yes,
> > we should really reduce the number of them.)
>=20
> I don't really want to think about whether it's safe to only keep a
> reference to the current BDS.  I can't imagine any case where destroying
> one root BDS leads to destroying another, but I'd rather be safe and not
> have to think about it.  (Unless there is an important reason to only
> keep a strong reference to the current one.)

Why would it be a problem if another BDS from the list went away? If it
is one that was already processed, we don't care, and if it was in the
yet unprocessed part of the list, we'll just never return it.

Kevin

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaBc44AAoJEH8JsnLIjy/WLcgP/0SwPQB2JcfgcMy90X0ndJK9
tSOHrTDrbPFEU/pOm7EHaZGN3fVTCEJpSkgKrSrUxzpxCS2pXe4VjTh31N5tvD16
C4Q7FMmgvwCZxNwzYPKvBzEolnlL22z0rTJ0yl8Uhb5dYsszwuzViUWsxf9CV0W+
O/0rZNyqN7G5gQFoI1PAvkX4fw5viKZ3b8BjgJISuvSwBHeTFgRUvRmILlhZUKSl
UdswITBxX05BcsP61D9etrxeiUwTdLo8ByrEFp0DEIZ0UKbo84B6Lb6WQJA05WDG
5lCnEY69xevRmUqnN91R5nqPk8P1v+66rfz4cLhamrXmRStBaWcs0PFEI8otgMVL
ofMwFd4Q8jtBeJHihwKy8H/pKS0HmBvtH3ybPkFTnnBYrwnTio0m+PWhWJkvleQj
/iI/Jupsjjh2A2wV2F1kNWF4dhBRoKTMltNQAQWB65W957RCrwsahlYA7p5We6fG
aAgY1ANyC6Luf4Rz6BN9sEx9Fic1KLkbL+zt2K6JwNPo4zYzj4MbyVJZTuH7xP3W
G19O1UFIKgEWTZvM4J6M/rQnTyMylo8DX5WzOuILNypXJZRelGWbg8FjjKD4nYRp
A/6TITX0XroJKN9cFdJDZVobhQqs0SwiHwFNwNstIt0pf4M+E0EJEtyn0RPLVGQp
z42CJ6dvmEtR4yfgdYci
=cLod
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
