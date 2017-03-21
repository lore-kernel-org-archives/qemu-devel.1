Received: from eggs.gnu.org ([2001:4830:134:3::10]:38668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqKvZ-00027F-Vl
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqKvW-0005Cu-QA
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:38:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqKvW-0005Cq-HD
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:38:22 -0400
References: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<a08674d1-0f08-b8fb-aa11-c971042ac58a@redhat.com>
	<d149478f-fb4e-6699-5508-570a5bf27869@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d21fbdc6-1eb4-27aa-1a32-a381cd9780ae@redhat.com>
Date: Tue, 21 Mar 2017 09:38:19 -0500
MIME-Version: 1.0
In-Reply-To: <d149478f-fb4e-6699-5508-570a5bf27869@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k557h2btCMB2qMF59As7qvfBTfDtcKawi"
Subject: Re: [Qemu-devel] [PATCH v0] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Alberto Garcia <berto@igalia.com>, Jani Kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k557h2btCMB2qMF59As7qvfBTfDtcKawi
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Alberto Garcia <berto@igalia.com>,
 Jani Kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
Message-ID: <d21fbdc6-1eb4-27aa-1a32-a381cd9780ae@redhat.com>
Subject: Re: [PATCH v0] fsdev: QMP interface for throttling
References: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <a08674d1-0f08-b8fb-aa11-c971042ac58a@redhat.com>
 <d149478f-fb4e-6699-5508-570a5bf27869@huawei.com>
In-Reply-To: <d149478f-fb4e-6699-5508-570a5bf27869@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2017 04:44 AM, Pradeep Jagadeesh wrote:

>>
>> You're introducing this struct in 2.10, so this member is not since 1.=
7.
>>  Either that, or you're copying-and-pasting when you should be sharing=

>> code and reusing an existing struct.
> Hmm..copied the block devices code, I will correct it.
> I thought of reusing the code, but the whole struct from block devices
> can not be used, as there is one member called "group" that is not used=

> in case of 9p.

Then make a common base type with the common fields, and have the block
devices use a subtype that reuses the base type and adds the additional
field 'group'.

> Also this needs lot of changes even in case of block
> devices. Because I may need to rename the structure as IOThrottle or
> something like that.

Yes, type names may have a ripple effect. But when done as a series,
separating the mechanical changes from the semantic changes, it's still
fairly easy to review, and worth it in the long run.

> Shall I reuse the code and avoid setting the group member in case of 9p=
?
> What do you think?

Better than avoiding the group member by avoiding it is avoiding it by
not having it in the type, by using type inheritance to your advantage.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--k557h2btCMB2qMF59As7qvfBTfDtcKawi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0TrbAAoJEKeha0olJ0NqEFMIAKSLC5QShKLF4lGWDbiioFyh
KiAIq766PiN/IYqU9S1vR4QYs1AQwp8OEgUmnFbUIAdr2RGOM4Kz83xHEHy5ovV4
ihfPlbQPLR3inWMsE7RnZWU4PJNbs4MyL4dKppq3xvy+3g4H47d7ggBMEbvdxQ4T
Z2wyyEF2SfKclts6EPYXIwEPuTQlPCgUNYmoHdiiPyUQh+eiLBZDr9phJr8lreHC
FimymokMUvz20TV8Gf+MPG5+A/mkcUBH38iRfYjBYYon3AKWZj9LAsIvNvWHmwtX
SL3QI7TtbCeb0dM5SiQxfFjyRegIeHZjoBRs9Vteli5LqOfUQsOszoUrMGI6B/U=
=qept
-----END PGP SIGNATURE-----

--k557h2btCMB2qMF59As7qvfBTfDtcKawi--
