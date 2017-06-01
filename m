Received: from eggs.gnu.org ([2001:4830:134:3::10]:43268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGOQE-0005oo-8G
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGOQ9-0000qJ-Rk
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:37:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGOQ9-0000oL-K6
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:37:41 -0400
References: <20170515194149.16288-1-eblake@redhat.com>
	<20170515194149.16288-2-eblake@redhat.com>
	<d9102dbd-9685-fffd-916f-f9bc7850b2f5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97f21cbe-2868-3a1e-b69c-745460cd67f0@redhat.com>
Date: Thu, 1 Jun 2017 06:37:38 -0500
MIME-Version: 1.0
In-Reply-To: <d9102dbd-9685-fffd-916f-f9bc7850b2f5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IpLlBnkcI7aLbPr6VDmg1ADLq34xNnBKx"
Subject: Re: [Qemu-devel] [PATCH v8 1/5] shutdown: Simplify shutdown_signal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IpLlBnkcI7aLbPr6VDmg1ADLq34xNnBKx
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, alistair.francis@xilinx.com
Message-ID: <97f21cbe-2868-3a1e-b69c-745460cd67f0@redhat.com>
Subject: Re: [PATCH v8 1/5] shutdown: Simplify shutdown_signal
References: <20170515194149.16288-1-eblake@redhat.com>
 <20170515194149.16288-2-eblake@redhat.com>
 <d9102dbd-9685-fffd-916f-f9bc7850b2f5@redhat.com>
In-Reply-To: <d9102dbd-9685-fffd-916f-f9bc7850b2f5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 04:59 AM, Paolo Bonzini wrote:
>=20
>=20
> On 15/05/2017 21:41, Eric Blake wrote:
>> There is no signal 0 (kill(pid, 0) has special semantics to probe whet=
her
>> a process is alive), rather than actually sending a signal 0).  So we
>> can use the simpler 0, instead of -1, for our sentinel of whether a
>> shutdown request due to a signal has happened.
>>

>=20
> Queued, thanks.
>=20

Huh? This is v8, but v9 already got committed in master as commit 7af8827=
9e

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IpLlBnkcI7aLbPr6VDmg1ADLq34xNnBKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZL/yCAAoJEKeha0olJ0Nqrl0IAIxBJnUJl9AlRyLxcLIJ3ThH
Fm8HrX4yvtrfXyfsqRVuPwpwIX9CwoCGIqQuIAlISmLVBxXl5qK75YmQc5YHTYmC
q0uSAs8glN7SMf7DCn/0zcbIlh8u72WoYey27KN2WWPYBngZ2pGj4jnD23iEfnAg
YuKXgZ4GK6eI6NIVSwxUtoanl8C0yj91WA6HWVxCZGWIq2Y24wk3p0Wzr1kDocUk
09UBN7Vu9xXcM4JWDMJqizgDXDAvOm1IIn0i0npOmbfOyxHPb78ieIP7VMdIKRqz
eWERABMxLy8dAdKs7Y6t14rMFRo2QTcjtwcmMpGaAi39xVU74kmwsASy9+7e6Ck=
=ZJ8s
-----END PGP SIGNATURE-----

--IpLlBnkcI7aLbPr6VDmg1ADLq34xNnBKx--
