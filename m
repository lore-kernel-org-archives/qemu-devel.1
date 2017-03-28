Received: from eggs.gnu.org ([2001:4830:134:3::10]:56606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csr8o-0007Tg-Ru
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csr8l-0007IS-OH
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:26:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csr8l-0007Hq-F2
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:26:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 778924AEB1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 13:26:25 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-9-git-send-email-armbru@redhat.com>
	<88f70b55-a43b-2515-7150-d0501557256c@redhat.com>
	<8760it4xnf.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <16055e1c-4f48-2c22-bbbb-2d8ac50add65@redhat.com>
Date: Tue, 28 Mar 2017 08:26:23 -0500
MIME-Version: 1.0
In-Reply-To: <8760it4xnf.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2U2lHR3tEHiSMVJdtJNk5PdPgAHwKqtbT"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 08/11] rbd: Revert -blockdev
 and -drive parameter auth-supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2U2lHR3tEHiSMVJdtJNk5PdPgAHwKqtbT
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com,
 jcody@redhat.com, mreitz@redhat.com
Message-ID: <16055e1c-4f48-2c22-bbbb-2d8ac50add65@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 08/11] rbd: Revert -blockdev
 and -drive parameter auth-supported
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-9-git-send-email-armbru@redhat.com>
 <88f70b55-a43b-2515-7150-d0501557256c@redhat.com>
 <8760it4xnf.fsf@dusky.pond.sub.org>
In-Reply-To: <8760it4xnf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/28/2017 03:24 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 03/27/2017 08:26 AM, Markus Armbruster wrote:
>>> This reverts half of commit 0a55679.  We're having second thoughts on=

>>> the QAPI schema (and thus the external interface), and haven't reache=
d
>>> consensus, yet.  Issues include:
>>>
>>
>>> Let's avoid painting ourselves into a corner now, and revert the
>>> feature for 2.9.
>>
>> There may still be some tweaks to improve the commit message and/or co=
de
>> comments to clarify things that tripped me up until later in the
>> subthread, but now that I understand the difference between pseudo-fil=
e
>> format (where the key-value pair backdoor still works for libvirt's
>> usage of -drive file=3Drbd:...) and QemuOpts format (-drive driver=3Dr=
bd,...
>> which didn't really exist in 2.8, and where we don't want to bake in
>> something we don't like in 2.9), I agree with the move.
>=20
> I'm inserting ...
>=20
>>> Note that users can still configure authentication methods with a
>>> configuration file.  They probably do that anyway if they use Ceph
>>> outside QEMU as well.
>=20
> ... this hint right here:
>=20
>    Further note that this doesn't affect use of key "auth-supported" in=

>    -drive file=3Drbd:...:key=3Dvalue.
>=20
> Good enough?

Yes, that does the trick.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--2U2lHR3tEHiSMVJdtJNk5PdPgAHwKqtbT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2mR/AAoJEKeha0olJ0NqijMIAJWqf5A2omf2Q4U9vD+8R5p6
l9T6LPG+X3SKuYjc5vazZtCvK6yOHR4jrjFNdycjI1aOovdYQWDoD9hRDzMZ+DTa
Q1Y+QYcgkK6DQ+2CYoIARfPLJMeCUInAvLGMD/csGv7Ycj+mssdRaP3EUK39nUsF
a+89bPjZayxKDqfUVsUcoWiNxmq5AAk3fNEDbdmHNtKoRp/K99GF4kczA/+NM8E7
THn/mjXzI3oWJqdvpCeG/Ymec6xsbgKLzjHQG+vUwPyFiObjlZK9I+piPu5bWMNu
b1oR1+jJHesiVrYsS7c05buLtPMpa/+QzCt/ZS3RxQg4G3Y9k1VUaj/qdMCcidQ=
=rz58
-----END PGP SIGNATURE-----

--2U2lHR3tEHiSMVJdtJNk5PdPgAHwKqtbT--
