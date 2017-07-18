Received: from eggs.gnu.org ([2001:4830:134:3::10]:51098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXYn4-0002HW-5z
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXYn1-00072Z-TP
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:08:18 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-4-git-send-email-armbru@redhat.com>
	<e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
	<c61aee5a-a094-50c3-67c3-c39e72095710@redhat.com>
	<87y3rlrct2.fsf@dusky.pond.sub.org> <87lgnlcyz7.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c6e3d9d9-188b-6b26-3f99-a3ab5a6d6933@redhat.com>
Date: Tue, 18 Jul 2017 15:08:04 -0500
MIME-Version: 1.0
In-Reply-To: <87lgnlcyz7.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w8b0iekbJ13GT9ClM6eCioCte7WDFONF8"
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first
 class 'null' type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w8b0iekbJ13GT9ClM6eCioCte7WDFONF8
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com
Message-ID: <c6e3d9d9-188b-6b26-3f99-a3ab5a6d6933@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first class
 'null' type
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-4-git-send-email-armbru@redhat.com>
 <e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
 <c61aee5a-a094-50c3-67c3-c39e72095710@redhat.com>
 <87y3rlrct2.fsf@dusky.pond.sub.org> <87lgnlcyz7.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgnlcyz7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 02:43 PM, Markus Armbruster wrote:
> @@ -536,10 +537,11 @@ can only express a choice between types represent=
ed differently in
>  JSON.  If a branch is typed as the 'bool' built-in, the alternate
>  accepts true and false; if it is typed as any of the various numeric
>  built-ins, it accepts a JSON number; if it is typed as a 'str'
> -built-in or named enum type, it accepts a JSON string; and if it is
> -typed as a complex type (struct or union), it accepts a JSON object.
> -Two different complex types, for instance, aren't permitted, because
> -both are represented as a JSON object.
> +built-in or named enum type, it accepts a JSON string; if it is typed
> +as the 'null' built-in, it accepts JSON null, and if it is typed as a
> +complex type (struct or union), it accepts a JSON object.  Two

Grammar tweak: s/null,/null;/

In a list of phrases that all have commas, it's typical to graduate the
list separator to semicolon, so that it becomes easier to see the flow
of 'a,b; a,b; and a,b'


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--w8b0iekbJ13GT9ClM6eCioCte7WDFONF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluaqQACgkQp6FrSiUn
Q2pvFAf+JTlYV6lAJlNiQ3SgGjItAYEXPablQ33/6tehgY8s8iypsY7xFxO2c3IZ
sbfCdlZ1yeJ87RK1d69FnMOUYRXVLsKaVQryGtKwxSFGVKHC+ocU468dRdtFgBTm
p3Lt3Zr/2kGhtYer/ZdHvMX+XdeCCfxlqsVXNiGVQOBquuShklBK4RYj3q73FnR2
GNlgfKeHGHRRBA9WVaaqkiNMwYqutileasO5yC2TTO8EcC9IMU1fGXXXIMnRcBWO
FVaubilDfZW8022UA6mKT93/R1qV2QWdJUXZ5VvFaEpEXxxSnR5g2scss2TPq4Xx
uDAO5oZuJbnph3UJPdQ0jbVNLe2RxQ==
=L4tI
-----END PGP SIGNATURE-----

--w8b0iekbJ13GT9ClM6eCioCte7WDFONF8--
