Received: from eggs.gnu.org ([2001:4830:134:3::10]:32884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxaqd-0001HO-BD
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxaqc-0000ki-GR
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:03:19 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<20170410084250.GC4883@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <44046dd1-aaad-4f4e-5cbf-668b894dee7c@redhat.com>
Date: Mon, 10 Apr 2017 17:03:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170410084250.GC4883@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jqq48gL1gcstBXRGBidvMWfaWv0jbP5rH"
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jqq48gL1gcstBXRGBidvMWfaWv0jbP5rH
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <44046dd1-aaad-4f4e-5cbf-668b894dee7c@redhat.com>
Subject: Re: [RFC] Proposed qcow2 extension: subcluster allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
 <20170410084250.GC4883@noname.redhat.com>
In-Reply-To: <20170410084250.GC4883@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10.04.2017 10:42, Kevin Wolf wrote:
> Am 07.04.2017 um 19:10 hat Max Reitz geschrieben:
>> One case I'd be especially interested in are of course 4 kB subcluster=
s
>> for 64 kB clusters (because 4 kB is a usual page size and can be
>> configured to be the block size of a guest device; and because 64 kB
>> simply is the standard cluster size of qcow2 images nowadays[1]...).
>=20
> Why should the current default cluster size be an argument for anything=
?
> 64k is a tradeoff between small COW size and large allocation
> granularity that seemed to work well (and it used to be the maximum
> cluster size originally, so it seemed safer than 128k).
>=20
> With subclusters, we have a completely different situation and need to
> find a new default that works best. I'm relatively sure that 64k are to=
o
> small under the new conditions.
>=20
> Also, undefined reference: [1] (I was hoping to find a better argument
> there...)

I meant [1] to be basically what you just said.

Well, the thing is that 64 kB is still better than 32 kB. :-P

Max



--jqq48gL1gcstBXRGBidvMWfaWv0jbP5rH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljrnqoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AcJ0H/Re2Q4x7L/3UVqKTkUcZDE9mmKlgWws5
KclhlwO5AoZ77/mjzgl1hyZ55Hf4iEaO9cH52BUmJp5R5pJp66OHj72cTWOiH/G3
C2HPoVuAnEYPZkrGJhXK/hIDRrS7BvV7E4ivMchNuRwsh4q6Z3egwQA9qxSwbmxk
IRTTcAj1LJwxuxfcZ7MkgRCG4YPbfkXvjW4CM+pfrl6+Zl7FVPc+N+iGhAxcVtvB
EeUC2lQ0WxwMS1yPNEPJN3RNbDx14e1cskcbyzE1yqLGGOSbXrqgmcDnR8DTPv3Z
9JZNp17EpL3oUpjz8ABNytB23Sa6q5zt8WEAIabPdUrFrSDnMeGEgOY=
=HtBj
-----END PGP SIGNATURE-----

--jqq48gL1gcstBXRGBidvMWfaWv0jbP5rH--
