Received: from eggs.gnu.org ([209.51.188.92]:36554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghEjp-0002ov-Ti
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:21:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghEjo-0005Ay-QS
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:21:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ghEjo-0005AO-Ia
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:21:44 -0500
Date: Wed, 9 Jan 2019 15:21:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190109142140.GC4867@localhost.localdomain>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.01.2019 um 15:10 hat Max Reitz geschrieben:
> On 06.09.18 13:11, Daniel Henrique Barboza wrote:
> > changes in v2:
> > - removed the "RFC" marker;
> > - added a new patch (patch 2) that removes
> > bdrv_snapshot_delete_by_id_or_name from the code;
> > - made changes in patch 1 as suggested by Murilo;
> > - previous patch set link:
> > https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html
> >=20
> >=20
> > It is not uncommon to see bugs being opened by testers that attempt to
> > create VM snapshots using HMP. It turns out that "0" and "1" are quite
> > common snapshot names and they trigger a lot of bugs. I gave an example
> > in the commit message of patch 1, but to sum up here: QEMU treats the
> > input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. It
> > is documented as such, but this can lead to strange situations.
> >=20
> > Given that it is strange for an API to consider a parameter to be 2 fie=
lds
> > at the same time, and inadvently treating them as one or the other, and
> > that removing the ID field is too drastic, my idea here is to keep the
> > ID field for internal control, but do not let the user set it.
> >=20
> > I guess there's room for discussion about considering this change an API
> > change or not. It doesn't affect users of HMP and it doesn't affect Lib=
virt,
> > but simplifying the meaning of the parameters of savevm/loadvm/delvm.
>=20
> (Yes, very late reply, I'm sorry...)
>=20
> I do think it affects users of HMP, because right now you can delete
> snapshots with their ID, and after this series you cannot.

Can there be snapshots that can't be identified by a snapshot name, but
only by their ID?

> I think we had a short discussion about just disallowing numeric
> snapshot names.  How bad would that be?

It would be incompatible with existing images and result in a more
complex snapshot identifier resolution. Why would it be any better?

Kevin

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcNgN0AAoJEH8JsnLIjy/W1PwP/RRlt2nIQaA2qHqNubx63++/
Fr2GsUqf6lRdNS40X3iACX3qhgzAkpgUJT8A98HxEOOU9NcboVrXi7pR9wuFmyve
bZ5+qaK0MO342iojGJqp0Su0E/YNyccbdnZfxX3Zh9QH23ZzH0YgqL8W20XU5tx7
/16s/aASBHHxe8s+2UMf2KXZ/3Z3PbD1G9j/QXQiSrREwsOpikb/8I0io/BYGnTz
CFV0pgBItdqEpyqRBpe5ax1SdLJ7gLAK7YnAqfX4/FIwR0/woPkM/TO9bI7rDycI
3zGNae22uCMGiYfNv2hdo5QCiXMm97KiPkEc6N3EOnx9yoMNt7b5lbeEUeONhZS3
tyJ7DQUuRfRXbSkLf/ZNl4aMfgiL0Byit9KTOOl3eup2YG6KoJgC1LtL/YbYD4+H
OgBbPsm7yk/+7HJvk+ZYCQC2IOOOh6JU4UtfxbqMxn5k9IF7e2+QrSDXWwwucdyi
CxCce9C8WjlDYIggVGeXc8axACPvE13euQ+8wiSq8YmZ8L/vHVLVSQCnMN6vjYHM
coYTX/jjYmXlDxTYL6J9BeItTz7hmyTfmiCIflGNyCDCTLP8BtfCm7zmC10dKA7q
TPJ4juvErXD6e1JBGM+8ohzUYr63JmW1k7RB2KL2CWKaCuZXt9jxiCuqe+YUYe+8
R/HBSq/c6mTge2Cd3Z5e
=2zPT
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
