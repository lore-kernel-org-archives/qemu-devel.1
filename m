Received: from eggs.gnu.org ([2001:4830:134:3::10]:48618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cswvp-0006F2-Oc
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cswvo-0003Rj-NU
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:37:29 -0400
References: <20170308191434.2413-1-mreitz@redhat.com>
	<20170323180523.GF5344@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7b8f71c4-9b33-a2a4-2756-3641d1149153@redhat.com>
Date: Tue, 28 Mar 2017 21:37:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170323180523.GF5344@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F6wOCammeXNiJellf1Cfpwaf4lp043VEn"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 0/4] block: Add errp to b{lk,
 drv}_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F6wOCammeXNiJellf1Cfpwaf4lp043VEn
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Message-ID: <7b8f71c4-9b33-a2a4-2756-3641d1149153@redhat.com>
Subject: Re: [PATCH v2 for-2.10 0/4] block: Add errp to b{lk,drv}_truncate()
References: <20170308191434.2413-1-mreitz@redhat.com>
 <20170323180523.GF5344@noname.redhat.com>
In-Reply-To: <20170323180523.GF5344@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23.03.2017 19:05, Kevin Wolf wrote:
> Am 08.03.2017 um 20:14 hat Max Reitz geschrieben:
>> Having an Error parameter for these functions makes sense because we
>> sometimes want a bit more information than just "Something failed". So=
me
>> drivers already use error_report() and the like to emit this additiona=
l
>> information, so it's rather obvious that we do want a real error objec=
t
>> here.
>=20
> I had only some minor comments about improving one error message or
> another, so whether you fix them or not:
>=20
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>=20
> (But if you don't fix them, you need to merge the patches yourself)

That sounds very fair, I like it. :-)

Don't worry, though, I will address them. Thanks for reviewing!

Max


--F6wOCammeXNiJellf1Cfpwaf4lp043VEn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljau3ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7ZcH/3H6rEuSV/yOruZdiw1Obam1/UmFY5i9
yi+Xv6TN1mIr23VVVXxYVb2fSqZ1L5SvB2xXZL/DluNwOVmdG57fyP81H8mKmKml
Wg2SX+VlCAsCwI7UEQBBZIvw++mvNaoRFk1vGZwFiLC/mdM8YsaDogbKk4xl/wjW
D4pGU4LV+jse6l0/6o5krtBDBQRpAdb2Ujas8W/sBRN49VJa3xjCEPgjygSCiL34
Ws52SaBOq58ZKHYJ+eIO/1VBJLF3XHCPbkHlgf6Mc5m+qOyCwLEcSZjLlBSTTL97
XFgAJvdgjDRVGn32lnv7LHKZd5o35Noyt8lkV0Y8r3PjLfP0ofNzx/A=
=V3jT
-----END PGP SIGNATURE-----

--F6wOCammeXNiJellf1Cfpwaf4lp043VEn--
