Received: from eggs.gnu.org ([209.51.188.92]:56557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gugRh-00072A-9Z
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gugRg-0008SX-6v
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:34:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gugRg-0008Ql-0G
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:34:36 -0500
Date: Fri, 15 Feb 2019 17:34:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190215163431.GC7941@localhost.localdomain>
References: <20181107131000.27744-1-danielhb413@gmail.com>
	<20181107131000.27744-2-danielhb413@gmail.com>
	<d8764234-8c52-a24f-c07f-da3655bf2293@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <d8764234-8c52-a24f-c07f-da3655bf2293@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 1/3] block/snapshot.c: eliminate
 use of ID input in snapshot operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.02.2019 um 17:21 hat Eric Blake geschrieben:
> On 11/7/18 7:09 AM, Daniel Henrique Barboza wrote:
> > At this moment, QEMU attempts to create/load/delete snapshots
> > by using either an ID (id_str) or a name. The problem is that the code
> > isn't consistent of whether the entered argument is an ID or a name,
> > causing unexpected behaviors.
> >=20
>=20
> >  STEXI
> > -@item savevm [@var{tag}|@var{id}]
> > +@item savevm @var{tag}
> >  @findex savevm
> >  Create a snapshot of the whole virtual machine. If @var{tag} is
> >  provided, it is used as human readable identifier. If there is already
> > -a snapshot with the same tag or ID, it is replaced. More info at
> > +a snapshot with the same tag, it is replaced. More info at
> >  @ref{vm_snapshots}.
> > +
> > +Since 3.2, savevm stopped allowing the snapshot id to be set, accepting
>=20
> s/3.2/4.0/
>=20
> > +only @var{tag} as parameter.
>=20
> > +Since 3.2, delvm stopped deleting snapshots by snapshot id, accepting
> > +only @var{tag} as parameter.
>=20
> and again

Sorry, I should have mentioned that I changed this while applying.

Kevin

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcZuoXAAoJEH8JsnLIjy/Wn2oP/jy78zh+3SfYVD5aECwQ9Bpc
CkCNzOIPdMXZRPe5iWMj1Tr6JkOQgy8iFUj+ozJvHZOT/DHQsB7lftWCN8s3QTiO
iPS20tOJy+CG+kOrI07ks2coi0Q1JZlPHY4Ycmh5tKpMwDQnCyU4Waan6/2wgVjK
PJLfRlhto/uFQJEP8FlnuiNMO5M/Ic+GAucnqmllwaVSe97QHfQyZJDrsGGrA8kt
YuuDozs/8lKgjdLVc51VFB7IqNt2JEVDCYqJ/RIR8+uNWvl4Xx3YNjL+pkq9spBJ
8WEFJqOfQnoVA+bR0XylvpGW0ijbQASH1/cq5eWfImB94w5zMIr3VACiGjRtbDfv
1LPNcTDucZVax6Uzf1c7vI/S3vXOp4ymAwx9i3cerlJB3pTAWkPPWuE3bAxKUUgW
HX7DgyxoDvumxvr48krcNBeee99DmymlWljZhaxDQF1eG00j9fZUKWJc1K+KFKiX
lx2EXJQ149N6iSOcuIVtDdZkkqIDHgxO9//PMH9jBaReNlSgYi5fj6cJA/wZO29d
ODQdTtv7HttatFGIOALpR67USN2xgi/cCTXpqkyZqeN1iU8/7wVw4HDan3DsA4xp
mGaAMPbTA9Fcfrj+tWSA9W64dbVmc2nYEagyDAIIZu1PnN4WUFdrA/xpFNTFl+hI
ilxhhzoh5BHhhNzSFCeJ
=UjtH
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
