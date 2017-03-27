Received: from eggs.gnu.org ([2001:4830:134:3::10]:59718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXG7-0005OY-4z
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXG6-0007K6-2I
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:12:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1csXG5-0007Js-PP
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:12:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D77E6C0528D5
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:12:40 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-3-git-send-email-armbru@redhat.com>
	<ba4b08e7-7e8d-5210-be2c-545be4cdeb99@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <abc2a347-5f42-59c0-5f51-0f03bb2b3c6d@redhat.com>
Date: Mon, 27 Mar 2017 18:12:37 +0200
MIME-Version: 1.0
In-Reply-To: <ba4b08e7-7e8d-5210-be2c-545be4cdeb99@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XulBikwG5gEUGa0mPHC4Kko3weCSw1DWX"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 02/11] rbd: Fix to cleanly
 reject -drive without pool or image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XulBikwG5gEUGa0mPHC4Kko3weCSw1DWX
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com
Message-ID: <abc2a347-5f42-59c0-5f51-0f03bb2b3c6d@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 02/11] rbd: Fix to cleanly reject -drive
 without pool or image
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-3-git-send-email-armbru@redhat.com>
 <ba4b08e7-7e8d-5210-be2c-545be4cdeb99@redhat.com>
In-Reply-To: <ba4b08e7-7e8d-5210-be2c-545be4cdeb99@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 27.03.2017 18:10, Max Reitz wrote:
> On 27.03.2017 15:26, Markus Armbruster wrote:
>> qemu_rbd_open() neglects to check pool and image are present.
>> Reproducer:
>>
>>     $ qemu-system-x86_64 -nodefaults -drive if=3Dnone,driver=3Drbd,poo=
l=3Dp
>>     Segmentation fault (core dumped)
>>     $ qemu-system-x86_64 -nodefaults -drive if=3Dnone,driver=3Drbd,ima=
ge=3Di
>>     qemu-system-x86_64: -drive if=3Dnone,driver=3Drbd,image=3Di: error=
 opening pool (null)
>>
>> Doesn't affect -drive with file=3D..., because qemu_rbd_parse_filename=
()
>> always sets both pool and image.
>>
>> Doesn't affect -blockdev, because pool and image are mandatory in the
>> QAPI schema.
>>
>> Fix by adding the missing checks.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>  block/rbd.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>

That said, don't we have a similar issue with qemu_rbd_create()? It too
doesn't check whether those options are given but I guess they're just
as mandatory.

Max


--XulBikwG5gEUGa0mPHC4Kko3weCSw1DWX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZOfUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABYcIAJyja2ma/gLszHCiwvx9k2aKuEM2WIs8
NzCRsJIXTE9EP3taZXHKzFzIxw1rx8xiQMK9NVC2Um6KI6QeoqvPXfWK/yzLYQ90
5h4+W9MOg9xJW2hTOffde5qDPIRti+qMaecH4XCcw+zEP4xYaOyNkcl8z0BwdRj0
TrzGrHS1Tq3vSEurg4JghhXnsLX2gUmMU4OU5tdv/CzwtBNoRKJoNLHtzS+Oroyb
okQvqELBYaOvB9kuvWJMztgDg+zU94fWSSGHL8WL4ferP4Sb5rT8Hk7nQqty1Fga
tMoSl0zi/LI2QhvHZoAT0oCHZs1OqbecATTE5KUrm6I10f9BYmwOnUM=
=7P3P
-----END PGP SIGNATURE-----

--XulBikwG5gEUGa0mPHC4Kko3weCSw1DWX--
