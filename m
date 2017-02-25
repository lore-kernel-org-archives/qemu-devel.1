Received: from eggs.gnu.org ([2001:4830:134:3::10]:48753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chjho-0001XE-BU
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 16:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chjhl-0003nN-5j
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 16:16:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chjhk-0003n4-Tr
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 16:16:37 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66F333B707
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 21:16:36 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-18-git-send-email-armbru@redhat.com>
	<6ab9e2cd-edbe-b167-8a16-bf9c00c110ac@redhat.com>
	<87bmtraaz8.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fdf01e1e-c903-b029-8785-0c9f341d7d06@redhat.com>
Date: Sat, 25 Feb 2017 15:16:33 -0600
MIME-Version: 1.0
In-Reply-To: <87bmtraaz8.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0UUnNooEmkxTgwUfWbdsDVDX4k8mQQSKQ"
Subject: Re: [Qemu-devel] [PATCH 17/21] qapi: Drop unused non-strict qobject
 input visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0UUnNooEmkxTgwUfWbdsDVDX4k8mQQSKQ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <fdf01e1e-c903-b029-8785-0c9f341d7d06@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/21] qapi: Drop unused non-strict qobject
 input visitor
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-18-git-send-email-armbru@redhat.com>
 <6ab9e2cd-edbe-b167-8a16-bf9c00c110ac@redhat.com>
 <87bmtraaz8.fsf@dusky.pond.sub.org>
In-Reply-To: <87bmtraaz8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/24/2017 09:02 AM, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 23/02/2017 22:45, Markus Armbruster wrote:
>>> The split between tests/test-qobject-input-visitor.c and
>>> tests/test-qobject-input-strict.c now makes less sense than ever.  Th=
e
>>> next commit will take care of that.
>>
>> I'm actually adding a use for non-strict visitors (and one that makes
>> sense IMHO, with comments, testcases and all that :)).  See
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg432069.html.
>=20
> I replied.

Hmm. Right now, we implement strict checking by populating a hash table
in parallel to the QObject being visited, then checking if it gets
emptied.  I wonder if it would be any simpler to clone the QObject and
then remove keys, rather than tracking a separate hash table.  In fact,
you could then turn strict checking into an after-the-fact item:
creating the visitor passes in a QObject, then after the visit you check
whether the QObject has been emptied.  But that's not something that has
to be solved for 2.9.

>=20
>> For what it's worth, however, I believe that even non-strict visits
>> should detect unvisited list tails.
>=20
> Bit of an asymmetry.  Not sure it matters, because to not visit list
> tails, you have to put in some effort.
>=20
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0UUnNooEmkxTgwUfWbdsDVDX4k8mQQSKQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsfQxAAoJEKeha0olJ0NqLjEIAKMbp8p3LgMYWMCoBj3AueB2
7If73e/GyD/IjlQ5oLRvTEg+uTc+Aw7+wjgY/k233qw5EYOtJrPC5UheJbkAdXpd
YD63cZj2DWLFrG8usG7PD/OJS0ojcYw6ewn14//qbzaNUS0+CldpHL9RCpppdjft
/ZESI0CyEGJIyxINN0QgeWPIVWQtEb74Tx2Cs034cgyxI7hxTNBx6+W8LEq3VgmM
FvqWMqMsCKm1jMFTlzRU/eunD04pd35PsrdAFT1Tx4wBcq679S6GLfOFjBfHJHqB
bG3AJT/g8fNXcOF4wM7DPaaV+o1JD04iNcAmhPAHfcc6cDT23IU+TMq00KSB5tE=
=TRtb
-----END PGP SIGNATURE-----

--0UUnNooEmkxTgwUfWbdsDVDX4k8mQQSKQ--
