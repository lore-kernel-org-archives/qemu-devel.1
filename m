Received: from eggs.gnu.org ([2001:4830:134:3::10]:46284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDDZw-0007jO-HP
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDDZt-0007P5-Cv
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDDZt-0007On-35
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:26:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2FA461B84
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 17:26:35 +0000 (UTC)
References: <20170522213636.11550-1-eblake@redhat.com>
	<87efvghsql.fsf@dusky.pond.sub.org>
	<76e4af58-9642-d1c5-39a8-f39c6c6d0240@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9cd9abf4-37a3-b0ff-f208-d911ea9ac4db@redhat.com>
Date: Tue, 23 May 2017 12:26:32 -0500
MIME-Version: 1.0
In-Reply-To: <76e4af58-9642-d1c5-39a8-f39c6c6d0240@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7uaFS31k6TFMw5NcTsP5RUG7svJSW9MBK"
Subject: Re: [Qemu-devel] [PATCH] qapi: Fix some blockdev-add documentation
 regressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7uaFS31k6TFMw5NcTsP5RUG7svJSW9MBK
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Message-ID: <9cd9abf4-37a3-b0ff-f208-d911ea9ac4db@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qapi: Fix some blockdev-add documentation
 regressions
References: <20170522213636.11550-1-eblake@redhat.com>
 <87efvghsql.fsf@dusky.pond.sub.org>
 <76e4af58-9642-d1c5-39a8-f39c6c6d0240@redhat.com>
In-Reply-To: <76e4af58-9642-d1c5-39a8-f39c6c6d0240@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 09:32 AM, Eric Blake wrote:
> On 05/23/2017 03:39 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> In the process of getting rid of docs/qmp-commands.txt, we
>>> managed to regress on any text that changed after the point
>>> where the move was first branched and when the move actually
>>> occurred.  For example, commit 3282eca for blockdev-snapshot
>>> re-added the extra "options" layer which had been cleaned up
>>> in commit 0153d2f.
>>>

>=20
> I'll post a v2, since I have another pending doc patch that hasn't been=

> reviewed yet, and since your audit means I need to update my commit
> message anyway.

Actually, it just got queued as trivial:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05323.html

although git handles things just fine if it goes in earlier through any
other tree.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7uaFS31k6TFMw5NcTsP5RUG7svJSW9MBK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJHDIAAoJEKeha0olJ0NqqkwIAJD3iZimtS28pTVbs7QnT6VR
WMPDCu1WVFAgRlo+jVREa02/GJieyom7/XSxLMXD3sTn/hENu41GERgj7NraJJ5i
jiUa/Hwmt5LfYI1YvxlHF+7y/STM6AbABxuNUgMV3XCYXKoy8/SOkaGg2twsOmDu
8HFBNZVNgUygy3Ub0xX6ECGWc9uG1yY1PhEJFm5H3o07jO6iD+nM6T3KAGb1asRQ
/wTLVIJ2pBIp0UFiM4g7Un1UA7e1EL/zauUEN+dTLi7IOXfKYz092S53pgPRV/Zi
pKvx55y6QMnXFKO4vTj/RkGZUw0hwuHsA5p2DccR5K1hHbGFD7w3voQCaALDaEQ=
=Xmzz
-----END PGP SIGNATURE-----

--7uaFS31k6TFMw5NcTsP5RUG7svJSW9MBK--
