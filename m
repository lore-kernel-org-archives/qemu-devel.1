Received: from eggs.gnu.org ([2001:4830:134:3::10]:44652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db9mV-00013A-UW
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db9mR-0002gF-V6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:14:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db9mR-0002fT-M4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:14:31 -0400
References: <20170725143923.11241-1-den@openvz.org>
	<87iniclcmr.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de43dd07-8344-cdc6-b7d6-4abd87ca5081@redhat.com>
Date: Fri, 28 Jul 2017 13:14:24 -0500
MIME-Version: 1.0
In-Reply-To: <87iniclcmr.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qm7WwSrSNXOCxTe5cf6Fdd2jDafJBJiLC"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] monitor: improve tracing in
 handle_qmp_command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qm7WwSrSNXOCxTe5cf6Fdd2jDafJBJiLC
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Llu=c3=ads_Vilanova?=
 <vilanova@ac.upc.edu>
Message-ID: <de43dd07-8344-cdc6-b7d6-4abd87ca5081@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] monitor: improve tracing in
 handle_qmp_command
References: <20170725143923.11241-1-den@openvz.org>
 <87iniclcmr.fsf@dusky.pond.sub.org>
In-Reply-To: <87iniclcmr.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 12:01 PM, Markus Armbruster wrote:
> "Denis V. Lunev" <den@openvz.org> writes:
>=20
>> Calculate req_json only if trace_handle_qmp_command enabled.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Markus Armbruster <armbru@redhat.com>
>> ---

> Conflicts with Eric's commit 8a4613a, but I can resolve that in my tree=
=2E
>=20
> The commit message is too terse.  "Improve tracing" makes me think of
> more informative traces, but that's not the case.  What exactly is
> improved here?

Reduce overhead when not tracing.  Without the patch, we are malloc'ing
a QString and spending CPU cycles on converting a QObject to string,
just for the sake of sticking the string in the trace message - if we
aren't tracing, it's wasted effort.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qm7WwSrSNXOCxTe5cf6Fdd2jDafJBJiLC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7fwAACgkQp6FrSiUn
Q2p+XQgAhpmNyDrsWicb4ESnDif8CiCktZFRTEELmPFhXBStW4/AyANJoeBokutH
8ln5uSqo+/4YQ1Wk//BAEsIX/QRSmOQoos33FSaamQlzMgICAzsXbPOBn2ONgtkq
7iO0K+I/bYWpQX2d2xWA87Yca6xZYyaLBurR9d4WDAsLE6NorgDbZU9xCMHVYv85
Qm2F1GqhHZI8LjSyGP/inOVO+VSDMtES7HymtuzmenLwkspnVQn2ImyXwnO3dSzx
0MkvFwNI0sh/6aODYftTD8G2oV8S6xkTkxU+8276E2z+mp27rQUuBUagawVAAfBT
BqQDqp6k2a0LSzqg8W/Nk3Ahf//KTA==
=b+RU
-----END PGP SIGNATURE-----

--qm7WwSrSNXOCxTe5cf6Fdd2jDafJBJiLC--
