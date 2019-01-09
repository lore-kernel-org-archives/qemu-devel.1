Received: from eggs.gnu.org ([209.51.188.92]:45684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghF9p-00033D-Vg
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghF9o-0006S2-55
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:48:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ghF9n-0006Fe-Rg
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:48:36 -0500
Date: Wed, 9 Jan 2019 15:48:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190109144818.GE4867@localhost.localdomain>
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<20190109142140.GC4867@localhost.localdomain>
	<095e7b09-5d84-3437-782d-97fa6ca372ee@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <095e7b09-5d84-3437-782d-97fa6ca372ee@redhat.com>
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


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.01.2019 um 15:27 hat Max Reitz geschrieben:
> On 09.01.19 15:21, Kevin Wolf wrote:
> > Am 09.01.2019 um 15:10 hat Max Reitz geschrieben:
> >> On 06.09.18 13:11, Daniel Henrique Barboza wrote:
> >>> changes in v2:
> >>> - removed the "RFC" marker;
> >>> - added a new patch (patch 2) that removes
> >>> bdrv_snapshot_delete_by_id_or_name from the code;
> >>> - made changes in patch 1 as suggested by Murilo;
> >>> - previous patch set link:
> >>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html
> >>>
> >>>
> >>> It is not uncommon to see bugs being opened by testers that attempt to
> >>> create VM snapshots using HMP. It turns out that "0" and "1" are quite
> >>> common snapshot names and they trigger a lot of bugs. I gave an examp=
le
> >>> in the commit message of patch 1, but to sum up here: QEMU treats the
> >>> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. =
It
> >>> is documented as such, but this can lead to strange situations.
> >>>
> >>> Given that it is strange for an API to consider a parameter to be 2 f=
ields
> >>> at the same time, and inadvently treating them as one or the other, a=
nd
> >>> that removing the ID field is too drastic, my idea here is to keep the
> >>> ID field for internal control, but do not let the user set it.
> >>>
> >>> I guess there's room for discussion about considering this change an =
API
> >>> change or not. It doesn't affect users of HMP and it doesn't affect L=
ibvirt,
> >>> but simplifying the meaning of the parameters of savevm/loadvm/delvm.
> >>
> >> (Yes, very late reply, I'm sorry...)
> >>
> >> I do think it affects users of HMP, because right now you can delete
> >> snapshots with their ID, and after this series you cannot.
> >=20
> > Can there be snapshots that can't be identified by a snapshot name, but
> > only by their ID?
>=20
> I don't know, but what I meant is that if you have scripts to do all
> this, you might have to adjust them with this change.

That's what the H in HMP means.

> >> I think we had a short discussion about just disallowing numeric
> >> snapshot names.  How bad would that be?
> >=20
> > It would be incompatible with existing images and result in a more
> > complex snapshot identifier resolution. Why would it be any better?
>=20
> It wouldn't be incompatible with existing images if we'd just disallow
> creating such snapshots.  I don't see how the identifier resolution
> would be more complex.
>=20
> I don't know if it'd be better.  I'd just find it simpler (for us, that
> is -- for users, I'm not sure).

Identifier resolution A:
- Find a snapshot that has the given identifier as a name
- If no such snapshot exists, it is an error

Identifier resolution B:
- If the identifier is a number, find a snapshot that has the given
  identifier as its ID
- If the identifier is not a number, find a snapshot that has the given
  identifier as a name
- If no such snapshot exists, it is an error

Isn't it rather obvious that B is more complex than A?

Kevin

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcNgmyAAoJEH8JsnLIjy/WWCEQAJjB564d2JYHB8+hGSuvllud
TEXXH3xGqWhsbTFk991SvoLrFIa3jO7pO2NMZyCbIjje+aIm+PkYFNAY1rSh5I6B
Enl/fJtsyxPQCH+n9vXE212WHb5jT9R0VT7Lt+dyoRmciGQJ6y2nfWsybsuU/Ppo
Tc6/Z+aDvo8W1Vued++n49G64F2haKRtix35Dekhjx752rPku3tplDLQRg76O/X0
kKH7WsV+u3A/a8V6hPmMiQCGMMcLCRgCp4lRMbv0SppAP3zZNtWcO1aAY8q6HS5G
EdB1ZlvdWs+1SZplA3P6Z77iSNLfFBrMBGUC5J2HKdi300LzCx02z8ml7NQGrm3Z
0PV7r2Q2F+TDLRiabi9hfEc98pDH/tO/QZtQBYqY5bnvuMHHTqWcCdFX44N2MD5P
eAUn1f66BQ8sgAE2nhdTKwh2XLaMEvSqz3RiY5AjEz6UoL5iswB6uqSIXbXDH+90
qgBLAci/RkIMr/QspZHz4ez1QnPAXbnu/c+PCiiZVDUMkUPzyGGp4G1Ww3+IewQt
O3lN67PAbm6Tx4fLVDD/s2T3q5tPrFiFEvs6lJ0zASH1QEtP9PJR8x0JYS1/b4VE
j4lbi6IFyiqUZIrDw00r4h9QiFpuEwHpoOzVqJ1qusNWLXS8wPE49UA4FpznbRjW
QuyjC3LSZGHEa11aci2w
=X7Rg
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
