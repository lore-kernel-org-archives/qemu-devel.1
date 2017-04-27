Received: from eggs.gnu.org ([2001:4830:134:3::10]:51493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d3bNz-0003Jx-CX
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 00:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d3bNu-0006bF-II
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 00:50:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d3bNu-0006ae-Bx
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 00:50:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04F4C81240
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 04:50:29 +0000 (UTC)
References: <194bfbef-efad-0f2e-457c-84533e66fdb5@redhat.com>
	<1493097407-20482-1-git-send-email-thuth@redhat.com>
	<e95a7963-875b-efa8-95ee-f89bc6151bee@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <496789c6-2c3b-8430-7375-91e8aadf938c@redhat.com>
Date: Thu, 27 Apr 2017 06:50:19 +0200
MIME-Version: 1.0
In-Reply-To: <e95a7963-875b-efa8-95ee-f89bc6151bee@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="4SIxVG8RMrIGoJ0W6ps8Jxk1lcADE5Oif"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] tests: Add a tester for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4SIxVG8RMrIGoJ0W6ps8Jxk1lcADE5Oif
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.04.2017 15:22, Eric Blake wrote:
> On 04/25/2017 12:16 AM, Thomas Huth wrote:
>> HMP commands do not get any automatic testing yet, so on certain
>> QEMU machines, some HMP commands were causing crashes in the past.
>> Thus we should test HMP commands in our test suite, too, to avoid
>> that such problems creep in again in the future.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v3:
>>  - Fixed the stupid "!strcmp() =3D=3D 0" problem
>=20
> That's why libvirt prefers the use of a STREQ() macro (it's easier to
> read STREQ(a,b) than it is to remember if !strcmp(a,b) has the right
> semantics).  But switching the code base to use such a nice wrapper
> would be a task for Coccinelle, if we wanted it.

I just saw that glib seems also to have a g_str_equal() function ... I
guess we could use that in QEMU instead. I'll try to remember that for
future code that I write ...

 Thomas



--4SIxVG8RMrIGoJ0W6ps8Jxk1lcADE5Oif
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZAXiQAAoJEC7Z13T+cC21Jp8P/141RA7g4AMxPld4/emffeZR
8UGm4w++KY9veySuCWVPqd0L+Ua/yUO7NMDY3HZFCvdBDaFNIzJ7enJGahgwkqh4
GuaE9rw2EgM4uRvTWGF2j4dbHdjXCuHRWgPQFTaJ6SYUs3IIgJ2HUfTRELRKW5df
7erxaMjpsCMVSKbggcQPzzwIt0xk0j60OcakhYjLFvrSq3yLUaX98m4wl4ODGMkH
pzhj0CMUJrUEKRGoVJ4iOWlJ5PRYko6vAQPEoFBWn1Qj2+9nyYQPOszH2vmtYauM
AeTeSpDZ9XT9alwEjdUw2LfmZdzVPrhSZlBga+ZQO4UA1U3teIh6hUjjp6Lkc8Xa
8LZqbJLomtUKzWzFZN2enmgBhuv2FC9ShFSpNGWoZFz0XpYeOu9aFMW8TogIeYQr
ELcUfzPc4zEMJt/G6B/86EaPqYrSTH2EFHnOUKKkF5swcrs8lvqdC0gctDC9bqy2
XwLkZPfa0Q5Tkru1DH5W2FkNifsG5gmI32BsY6WGjXE5jNId1llGFVSQfse1sVep
l2Al2zn1oVFHVDVP8jEB/OWQQ9a3ogirWXARwLH2fCGYk3fZyTlQI+bWnpBQ0H1X
ydbZQhubj8SfpZuhy+KP2w68qzHDhwUkhc5+CvvL2AE8747C/nseNLERRqnUD0mq
aT/TgkXUu/3JhTOMi9U3
=usJs
-----END PGP SIGNATURE-----

--4SIxVG8RMrIGoJ0W6ps8Jxk1lcADE5Oif--
