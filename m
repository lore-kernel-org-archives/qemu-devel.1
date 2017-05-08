Received: from eggs.gnu.org ([2001:4830:134:3::10]:40680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7ll2-0002FL-F9
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d7lkz-0004YV-86
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:43:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d7lky-0004Y5-Uq
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:43:33 -0400
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
	<87wp9r689l.fsf@dusky.pond.sub.org>
	<CADmzSShCnLNFzBAZDw8+ZG00L=Qgy7OOE7Q06-z1fHYuBJHpRQ@mail.gmail.com>
	<bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
	<CADmzSSizPt5JcWq8n-ZqnpYVB0q36x+JQYWXimyk1LciHsnkKQ@mail.gmail.com>
	<0456ed7c-c465-6e6b-77a2-8be37e0e6ae2@redhat.com>
	<CADmzSSgN6+gK2rhcpiYu7y_gG3UT7oL92Q4zG+GQVoqGbVGKXg@mail.gmail.com>
	<9cd29436-fa1e-5e44-18b3-dd65edeaff55@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fad985f4-8fa0-6457-6e63-3637fa058011@redhat.com>
Date: Mon, 8 May 2017 11:43:23 -0500
MIME-Version: 1.0
In-Reply-To: <9cd29436-fa1e-5e44-18b3-dd65edeaff55@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fC5Ev15iAXmrW6n9P5EMv8mMbR51HglU7"
Subject: Re: [Qemu-devel] format=raw,readonly errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Carl Karsten <carl@personnelware.com>
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fC5Ev15iAXmrW6n9P5EMv8mMbR51HglU7
From: Eric Blake <eblake@redhat.com>
To: Carl Karsten <carl@personnelware.com>
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <fad985f4-8fa0-6457-6e63-3637fa058011@redhat.com>
Subject: Re: [Qemu-devel] format=raw,readonly errors
References: <CADmzSSiQYXzJf0vzhyaXdncZaq9gzPrN0BRm4_OOpPv+wJ9Bjw@mail.gmail.com>
 <87wp9r689l.fsf@dusky.pond.sub.org>
 <CADmzSShCnLNFzBAZDw8+ZG00L=Qgy7OOE7Q06-z1fHYuBJHpRQ@mail.gmail.com>
 <bdb8ffb7-b9f0-242c-2bf9-3eb94530180b@redhat.com>
 <CADmzSSizPt5JcWq8n-ZqnpYVB0q36x+JQYWXimyk1LciHsnkKQ@mail.gmail.com>
 <0456ed7c-c465-6e6b-77a2-8be37e0e6ae2@redhat.com>
 <CADmzSSgN6+gK2rhcpiYu7y_gG3UT7oL92Q4zG+GQVoqGbVGKXg@mail.gmail.com>
 <9cd29436-fa1e-5e44-18b3-dd65edeaff55@redhat.com>
In-Reply-To: <9cd29436-fa1e-5e44-18b3-dd65edeaff55@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2017 11:39 AM, Eric Blake wrote:
> On 05/08/2017 11:33 AM, Carl Karsten wrote:
>> according to the warning: "Specify the 'raw' format explicitly to remo=
ve
>> the restrictions."
>>
>> I want the restriction.
>>
>> format=3Draw, (write operations on block 0)=3Drestricted
>=20
> Then omit format=3Draw.  (It's an unusual request, though).  Or, as oth=
ers
> mentioned in this thread, you can use -snapshot or any other form of
> overlay image to keep the original image read-only while still providin=
g
> a read-write image that the guest requires for faithful hardware
> emulation; and you can always check your overlay after the fact to lear=
n
> whether sector 0 was changed.

The only other solution I can think of is using the blkdebug wrapper
with a config-file that causes EIO errors on any time to write anywhere
in the range [0,511]; however, setting up blkdebug is not very-well
documented (best may be to inspect existing files in
tests/qemu-iotests/??? for usage of blkdebug).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fC5Ev15iAXmrW6n9P5EMv8mMbR51HglU7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEKArAAoJEKeha0olJ0NqV+IH/3zEjvrIyqzWHrGZYjbEOHmf
SZ3rciicx3Tn7p+AihrQ9qQbfyzNTTLUKjTgBuscGz8mm3LL8N7PVHXt/+N53rQ6
y+NPmexurRwyl7Ezn5Ku8g/AkshPnoFgvmeBESy/9wwAAsmtdk2bVMo5ItAeucRB
6psvUSA0aqzCFLYiWugD7Yy31v8Mj24TZKdBA9oQm2lesItBmc8FSsgOBTBmlLU7
gwvAMJEy9VmS7yq/izrhRQQyizanWM9eod8/4eKyLZBsCJ3lHVgSSD+DykiVyiP/
PnvvXHjfCGBBpDT8YZzBgemyO7EGRbUgmuuwJUb6ssJebF/J8ixKyLworzo7svQ=
=1zun
-----END PGP SIGNATURE-----

--fC5Ev15iAXmrW6n9P5EMv8mMbR51HglU7--
