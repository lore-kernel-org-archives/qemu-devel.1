Received: from eggs.gnu.org ([2001:4830:134:3::10]:60776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciKTy-0004JD-Ug
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciKTx-0005RX-Up
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:32:50 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-16-git-send-email-kwolf@redhat.com>
	<90ef56d8-0415-bf7d-28b0-9b80adb4622c@redhat.com>
	<20170227122842.GC6356@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <160cd761-b736-8d0f-ce6a-5b1c3d3016e4@redhat.com>
Date: Mon, 27 Feb 2017 13:32:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170227122842.GC6356@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mFQr00axteL0DMoG843ggMtpFCtbn7Vw0"
Subject: Re: [Qemu-devel] [PATCH 15/54] block: Involve block drivers in
 permission granting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mFQr00axteL0DMoG843ggMtpFCtbn7Vw0
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <160cd761-b736-8d0f-ce6a-5b1c3d3016e4@redhat.com>
Subject: Re: [PATCH 15/54] block: Involve block drivers in permission granting
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-16-git-send-email-kwolf@redhat.com>
 <90ef56d8-0415-bf7d-28b0-9b80adb4622c@redhat.com>
 <20170227122842.GC6356@noname.redhat.com>
In-Reply-To: <20170227122842.GC6356@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 27.02.2017 13:28, Kevin Wolf wrote:
> Am 22.02.2017 um 15:04 hat Max Reitz geschrieben:
>>> @@ -1390,6 +1565,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverSt=
ate *child_bs,
>>> =20
>>>      ret =3D bdrv_check_update_perm(child_bs, perm, shared_perm, NULL=
, errp);
>>>      if (ret < 0) {
>>> +        bdrv_abort_perm_update(child_bs);
>>>          return NULL;
>>>      }
>>> =20
>>
>> This function doesn't call bdrv_set_perm(). Intentional?
>=20
> Yes, intentional. It calls it indirectly via bdrv_replace_child(). I'll=

> add a comment.

Right, bdrv_replace_child() invokes bdrv_update_perm() which invokes
bdrv_set_perm(). However, that means that there shouldn't be any caller
of bdrv_replace_child() which doesn't call bdrv_check_perm() before;
some don't do that, though, e.g. change_parent_backing_link().

Max


--mFQr00axteL0DMoG843ggMtpFCtbn7Vw0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli0HGkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdFUIAK1YKSnw4zsuFdrvrqtSxhjpm6qnF8yW
0WThQEAfS8Kx5nJWmg776DTp3YAR1f9b+bunQQLMUnsNlhgPpwDYbL+ahaHKjal0
m9pKHtcptI052jEpTtRceXgLYOnByuqkuXoV7Nq51+qx/IbD5SV1R4jUq78/74yw
48aGObT0LK6ZQj5Mhcb+MA+w3zFXz9HGGVouxeQtxbTQqnhoQ2pzsZMIL3x4MtSh
RSruQpN6HviUnIus+BxPkpkOQiGb5rE4mV1zdIQlCI/Ja+kEVBROju81Y5xe6UYU
mTI3YWEcfEUZraWpRs2Gp1iW5mZP7rlKhnwhQq/maZn1o3qmVk1p468=
=21XU
-----END PGP SIGNATURE-----

--mFQr00axteL0DMoG843ggMtpFCtbn7Vw0--
