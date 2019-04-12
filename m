Received: from eggs.gnu.org ([209.51.188.92]:59048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEzkT-0000MM-FM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEzkS-0000b9-DV
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:13:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hEzkR-0000aX-Vl
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:13:56 -0400
References: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fff20c68-d4db-3a56-ba39-dc487d6f80e5@redhat.com>
Date: Fri, 12 Apr 2019 12:13:51 -0500
MIME-Version: 1.0
In-Reply-To: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aNGdSx2vlWp2KcadxrjHTUOQ7UHvoFIAD"
Subject: Re: [Qemu-devel] [PATCH 0/3] Add 'inline-fd:' protocol for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>, yc-core@yandex-team.ru

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aNGdSx2vlWp2KcadxrjHTUOQ7UHvoFIAD
From: Eric Blake <eblake@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru
Message-ID: <fff20c68-d4db-3a56-ba39-dc487d6f80e5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Add 'inline-fd:' protocol for migration
References: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
In-Reply-To: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/12/19 7:20 AM, Yury Kotov wrote:
> Hi,
>=20
> I've added 'inline-fd:' proto to simplify migration to/from fd.
> I thought about modifying the existing 'fd:' proto but I'm not sure it'=
s a
> good idea to change it's contract.
>=20
> Existing 'fd:' proto works with previously added fd by getfd or add-fd =
commands.
> If client doesn't want to work with this fd before or after migration t=
hen it's
> easier to send an fd with the migrate-* command. Also, client shouldn't=
 maintain
> this fd.

While the sentiment of making it easier by having fewer QMP commands
might be worthwhile, I'm worried about whether this scales. Having just
a limited set of commands that take an fd over SCM rights, and every
other command wired to automagically work with existing named fds,
scales a lot easier than having to teach individual commands how to take
an fd inline.

At the very least, if we DO decide we like this, then I'd at least hope
that you made this addition introspectible (how can management learn
whether the 'inline-fd:' protocol is supported, and even more
importantly, which commands require an inline fd via SCM rights to be a
valid command based, especially if accepting or rejecting an inline fd
is conditional on other arguments to the command).

>=20
> Usage:
> { 'execute': 'migrate', 'arguments': { 'uri': 'inline-fd:' } }
> { 'execute': 'migrate-incoming', 'arguments': { 'uri': 'inline-fd:' } }=

>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--aNGdSx2vlWp2KcadxrjHTUOQ7UHvoFIAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlywx08ACgkQp6FrSiUn
Q2odIAf/WcKPhy1fIDf2yroe9aBtCw6P0OVX96MqPlSbT+uJdoODnE+aSv7SajVY
4N5BjAf9gvHkThK9odFssaLNgipDevtM96oHk1MavoCDz3z3ItiWWVuiKFf3fVDn
Oq7Py/Nmk06RKc3s9fUxcjaMBTRK8HJLD4IpbqbHq5bpRIvIQN3t1/V9ZtwZui3D
8ozH6h1ycRsZBfSl3qZ45hKZPbnfMFW3TJv/3I+30MbMGqfhggTpTm/jDqcFkBf4
Qzzb3ROmNDJBww9yVnJTWop/a9OkG+G2eLTuALfUkUjYlWQ6f0U9ngN0jk9ijc7O
aQdBjVkOEVQLtXLI7fBYFrpr59lQlQ==
=A25u
-----END PGP SIGNATURE-----

--aNGdSx2vlWp2KcadxrjHTUOQ7UHvoFIAD--
