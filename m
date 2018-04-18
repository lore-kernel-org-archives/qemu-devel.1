Received: from eggs.gnu.org ([2001:4830:134:3::10]:55506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8q3r-0000EU-JG
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8q3o-0000NH-Hw
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:35:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8q3o-0000M3-BO
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 12:35:56 -0400
References: <20180303002504.25142-1-aik@ozlabs.ru>
	<20180303002504.25142-2-aik@ozlabs.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f3b6cbb3-4484-55cf-3529-ce1a9946904f@redhat.com>
Date: Wed, 18 Apr 2018 11:35:54 -0500
MIME-Version: 1.0
In-Reply-To: <20180303002504.25142-2-aik@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dCQmfmQlnN1A1xS1NZOG7plL9RxBVL6hg"
Subject: Re: [Qemu-devel] [PATCH qemu v4 1/2] qmp: Merge ObjectPropertyInfo
 and DevicePropertyInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dCQmfmQlnN1A1xS1NZOG7plL9RxBVL6hg
From: Eric Blake <eblake@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Andrea Bolognani <abologna@redhat.com>
Message-ID: <f3b6cbb3-4484-55cf-3529-ce1a9946904f@redhat.com>
Subject: Re: [PATCH qemu v4 1/2] qmp: Merge ObjectPropertyInfo and
 DevicePropertyInfo
References: <20180303002504.25142-1-aik@ozlabs.ru>
 <20180303002504.25142-2-aik@ozlabs.ru>
In-Reply-To: <20180303002504.25142-2-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2018 06:25 PM, Alexey Kardashevskiy wrote:
> ObjectPropertyInfo is more generic and only missing @description.
> This adds a description to ObjectPropertyInfo and removes
> DevicePropertyInfo so the resulting ObjectPropertyInfo can be used
> elsewhere.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v4:
> * added (since 2.12) to the new field

And since it missed 2.12,

> * removed wrong reindents
> ---
>  qapi-schema.json | 23 +++++------------------
>  qdev-monitor.c   |  6 +++---
>  qmp.c            | 14 +++++++-------
>  3 files changed, 15 insertions(+), 28 deletions(-)
>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 0262b9f..5cdf89a 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -1266,10 +1266,12 @@
>  #        3) A link type in the form 'link<subtype>' where subtype is a=
 qdev
>  #           device type name.  Link properties form the device model g=
raph.
>  #
> +# @description: if specified, the description of the property (since 2=
=2E12).

this should be tweaked to say since 2.13.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dCQmfmQlnN1A1xS1NZOG7plL9RxBVL6hg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrXc+oACgkQp6FrSiUn
Q2rzFAf+KZwh2XhXYO9yRpJrT9KIXHle07/Yo6RcKRw9/83ReNbgVhfm4Ejoq8gU
vby2haKT6igjoeuwNHlxTexQXlyONQxmhBBrXCE3t5BxsUC3cPmiE3+7nLWgCUul
YoyVMltEe9v9nXUnLZJgHON6TzSMRVT22tKt9vrMeGWaJ/XMLE0/FvdyieSzd6FX
/IomQrOFEU9aS/ZweetCYMRfVh2mQlTAVXq68gMLrcIW45x2AwyHcnnoJZx7XKmY
a4cGERFRlW6ggFFlpJMBTcicqZtx7ebJST97eRrJ7+xcPjidSgICCp+fskCfYt4s
XyDOdf5Ple+5Brat4J+/KzVgBGpHvw==
=zims
-----END PGP SIGNATURE-----

--dCQmfmQlnN1A1xS1NZOG7plL9RxBVL6hg--
