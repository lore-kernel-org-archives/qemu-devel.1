Received: from eggs.gnu.org ([2001:4830:134:3::10]:42146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dq3Hm-0001Ng-Fv
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dq3Hh-0006N2-JJ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:20:26 -0400
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-18-eblake@redhat.com>
	<96c07533-e245-ccee-9632-b80821fad9be@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86b3bc7b-03bf-cbf6-e52e-df43e04a9c28@redhat.com>
Date: Thu, 7 Sep 2017 15:19:54 -0500
MIME-Version: 1.0
In-Reply-To: <96c07533-e245-ccee-9632-b80821fad9be@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EcStPP2evuWMxeghALqXPVwXFxMPks7Ks"
Subject: Re: [Qemu-devel] [PATCH v6 17/29] ahci-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, John Snow <jsnow@redhat.com>, armbru@redhat.com, "open list:IDE" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EcStPP2evuWMxeghALqXPVwXFxMPks7Ks
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, John Snow <jsnow@redhat.com>, armbru@redhat.com,
 "open list:IDE" <qemu-block@nongnu.org>
Message-ID: <86b3bc7b-03bf-cbf6-e52e-df43e04a9c28@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 17/29] ahci-test: Drop dependence on
 global_qtest
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-18-eblake@redhat.com>
 <96c07533-e245-ccee-9632-b80821fad9be@redhat.com>
In-Reply-To: <96c07533-e245-ccee-9632-b80821fad9be@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 05:32 AM, Thomas Huth wrote:
> On 01.09.2017 20:03, Eric Blake wrote:
>> Managing parallel connections to two different monitors via
>> the implicit global_qtest makes it hard to copy-and-paste code
>> to tests that are not aware of the implicit state; the
>> management of global_qtest is even harder to follow because
>> it was masked behind set_context().
>>

>> ---
>>  tests/libqos/libqos.h    |  1 -
>>  tests/ahci-test.c        | 83 +++++++++++++++++++++++----------------=
---------
>>  tests/libqos/ahci.c      | 45 +++++++++++++-------------
>>  tests/libqos/libqos-pc.c |  2 +-
>>  tests/libqos/libqos.c    | 37 ++++++---------------
>>  5 files changed, 73 insertions(+), 95 deletions(-)
>=20
> Might be easier to review if you'd split the changes to libqos.c into a=

> separate patch. But anyway:
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>

I'll split it, even though it means dropping R-b on both halves of the
split (so you can make sure the pieces still look sane).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EcStPP2evuWMxeghALqXPVwXFxMPks7Ks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmxqesACgkQp6FrSiUn
Q2r8Pgf+Ie6865uQVDNaB+RxjKhQcXO+e9wYEOEdZeI+8uahbyS3FPyN89oMnTPQ
UmAh2myGA2MO8e6cRotNHarRHBwlyge3tVDdnW1XpYant9MLvi+5TTbRURnIF+Cq
TCUxOqBrSV7hXifP7wzKtp1es+cgSDI75MdVfxUH6CAYXjXUOQoGqLXDKgDp+OM/
ZCjm8fCmloclSc0rGuRSxz48zZvU4Kv6wp6wmejkTLaMCQiPnqU7OvEP98i851/3
BFlDFom8HrQ5tqdlhIo+9EG8jij4sLdXdf90EnyfWI5BJu/GtEuW8QMqD4qSUMdi
T/B7b0HAQ+SMQ3IjkulgzH0u836GPg==
=CdMp
-----END PGP SIGNATURE-----

--EcStPP2evuWMxeghALqXPVwXFxMPks7Ks--
