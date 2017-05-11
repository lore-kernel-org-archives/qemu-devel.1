Received: from eggs.gnu.org ([2001:4830:134:3::10]:50789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8pcl-000461-Td
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8pch-00022z-Ax
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:03:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8pch-00022H-21
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:03:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0390A0904
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 15:03:21 +0000 (UTC)
References: <1494505358-15287-1-git-send-email-peterx@redhat.com>
	<1494505358-15287-5-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d938d532-6d11-0ec5-a24a-0a44519bc021@redhat.com>
Date: Thu, 11 May 2017 10:03:20 -0500
MIME-Version: 1.0
In-Reply-To: <1494505358-15287-5-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="A48UJwQPv10846UVwaPtWMUruHLVmmHsk"
Subject: Re: [Qemu-devel] [PATCH v7 4/4] utils: remove assert in
 size_to_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A48UJwQPv10846UVwaPtWMUruHLVmmHsk
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <d938d532-6d11-0ec5-a24a-0a44519bc021@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/4] utils: remove assert in size_to_str()
References: <1494505358-15287-1-git-send-email-peterx@redhat.com>
 <1494505358-15287-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1494505358-15287-5-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/11/2017 07:22 AM, Peter Xu wrote:
> It's not very safe to assert in size_to_str(). Let's be inclusive.
>=20
> It naturally allows negative values. Now it won't even limit on the
> size, as long as double would allow.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  util/cutils.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Since you just introduced this in 2/4, I'd rather see the two squashed
together if we decide this is the interface we want to support.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--A48UJwQPv10846UVwaPtWMUruHLVmmHsk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFH04AAoJEKeha0olJ0NqWV8H/iw4S7O73wp8aC95SxtxBQeb
l9UozfF99cXwiO4lDsO7ATTqeqj46icCeKGYMp8VhdIMX97QH7oeAkQwd1uHXfxG
h3oNm4jAEkAP488Z1HeGaeIZ3DLeytBqVGHUhZjJ1jB+4NsvfS1DGBCi3wwfJEiA
vvxt593ZzKc+pM2UdTT2OEQcCh9dHA8zP5xXjD8c9E89OF4GVWwjS5l08RkXy2Dk
yfl8CU2L8v2sXExJRdj7Mgf4xY4/UtYNMq/c1eIXabfECwON2CTtwKCgLhdf8QJ3
kjTdJMCNIXzJLAuIHa6nrsTwmclDrjCPB1tjFaTiZOslGkISRjwkRLYNkftV2gE=
=OMan
-----END PGP SIGNATURE-----

--A48UJwQPv10846UVwaPtWMUruHLVmmHsk--
