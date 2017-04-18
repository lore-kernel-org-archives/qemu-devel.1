Received: from eggs.gnu.org ([2001:4830:134:3::10]:46569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0TJ8-0004ok-3l
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0TJ5-0006vP-I0
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:36:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d0TJ5-0006v0-8n
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:36:35 -0400
References: <1492141282-28708-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1167061760.27389486.1492164610590.JavaMail.zimbra@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be3b415e-9f51-e2e1-a06e-6d44cdc3baa3@redhat.com>
Date: Tue, 18 Apr 2017 08:36:29 -0500
MIME-Version: 1.0
In-Reply-To: <1167061760.27389486.1492164610590.JavaMail.zimbra@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="72gX0IvvQFn6Ac6X85kE685nmVFmlO2hH"
Subject: Re: [Qemu-devel] [PATCH] char: Fix removing wrong GSource that be
 found by fd_in_tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, zhangchen fnst <zhangchen.fnst@cn.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--72gX0IvvQFn6Ac6X85kE685nmVFmlO2hH
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org,
 zhangchen fnst <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <be3b415e-9f51-e2e1-a06e-6d44cdc3baa3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] char: Fix removing wrong GSource that be
 found by fd_in_tag
References: <1492141282-28708-1-git-send-email-zhang.zhanghailiang@huawei.com>
 <1167061760.27389486.1492164610590.JavaMail.zimbra@redhat.com>
In-Reply-To: <1167061760.27389486.1492164610590.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/14/2017 05:10 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
>> We use fd_in_tag to find a GSource, fd_in_tag is return value of
>> g_source_attach(GSource *source, GMainContext *context), the return
>> value is unique only in the same context, so we may get the same
>> values with different 'context' parameters.
>>
>> It is no problem to find the right fd_in_tag by using
>>  g_main_context_find_source_by_id(GMainContext *context, guint source_=
id)
>> while there is only one default main context.
>>
>> But colo-compare tries to create/use its own context, and if we pass w=
rong
>> 'context' parameter with right fd_in_tag, we will find a wrong GSource=

>> to handle. We tied to fix the related codes in commit b43dec, but it d=
idn't
>=20
> tied->tried
>=20
> Please use a bit longer commit sha1, or full sha1, it will likely confl=
ict otherwise in the future.

6 chars is indeed short, 7 is git's default as usually long enough,
although I've encountered collisions that require 8 chars.  [And google
has proved that you can have a collision across the entire hash,
although that is harder to generate.] I generally use 8 or so when
writing commit messages.  Fortunately, even if a collision is introduces
later, someone that is motivated enough can still resolve the collision
by filtering out any collisions that resolve to non-commits, and among
the remaining colliding SHA1 focus on the one that has a commit date
which predates the message with the reference.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--72gX0IvvQFn6Ac6X85kE685nmVFmlO2hH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9hZdAAoJEKeha0olJ0NqcAoH+gKuGwwKECvJZe+wu9lGbok3
ssi8YQgAM7nm3sAOH0X/60yk8qO9D8n1e7v1gjvG2kghrIoTIdxUcixgNwpkO+ks
qL1hohAckyXZ3YPLof4FUb8IMXzf7jx4ewJ1aT3emV3Fl28U5Comb7N7MLxf7OEZ
v8wb2PZTyFm8A/JkgJghaJvxBfkYTq3BgHJ77cKLrzIMT+NE25G5eBBabe5a2m+k
PQ7k2UBq8JyGiMH5xvLW/2wjrmsFWo3dUDH8JwYsP7Z2pnYjVUzG1SEZao/yurtC
Ol4Wd/Fm0iVqlKq9gu4QwcSIm36cQzbnc/gk/tPwNygROKcW9NGxLLOyDnqH/Vk=
=nEUB
-----END PGP SIGNATURE-----

--72gX0IvvQFn6Ac6X85kE685nmVFmlO2hH--
