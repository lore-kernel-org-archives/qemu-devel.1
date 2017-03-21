Received: from eggs.gnu.org ([2001:4830:134:3::10]:51813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqKI4-0002FE-H1
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqKHz-0005PG-PK
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:57:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqKHz-0005Ot-Gy
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:57:31 -0400
References: <1489653504-25229-1-git-send-email-he.chen@linux.intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a10f2054-de74-b1ce-61f4-dd4516f0d42a@redhat.com>
Date: Tue, 21 Mar 2017 08:57:24 -0500
MIME-Version: 1.0
In-Reply-To: <1489653504-25229-1-git-send-email-he.chen@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vqIgKAfpdv94gIeifTHhLxHgaRAJkliTV"
Subject: Re: [Qemu-devel] [PATCH v2] x86: Allow to set NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Chen <he.chen@linux.intel.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vqIgKAfpdv94gIeifTHhLxHgaRAJkliTV
From: Eric Blake <eblake@redhat.com>
To: He Chen <he.chen@linux.intel.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <a10f2054-de74-b1ce-61f4-dd4516f0d42a@redhat.com>
Subject: Re: [PATCH v2] x86: Allow to set NUMA distance for different NUMA
 nodes
References: <1489653504-25229-1-git-send-email-he.chen@linux.intel.com>
In-Reply-To: <1489653504-25229-1-git-send-email-he.chen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 03:38 AM, He Chen wrote:
> Current, QEMU does not provide a clear command to set vNUMA distance fo=
r
> guest although we already have `-numa` command to set vNUMA nodes.

Subject line: "Allow to $verb" is not idiomatic English.  It is either
"Allow $subject to $verb", or the shorter "Allow ${verb}ing"; in this
case, I'd go with "Allow setting NUMA distance...".


> +++ b/qapi-schema.json
> @@ -5647,7 +5647,7 @@
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node' ] }
> +  'data': [ 'node', 'dist' ] }

Missing documentation for dist.

> =20
>  ##
> +# @NumaDistOptions:
> +#
> +# Set distance between 2 NUMA nodes. (for OptsVisitor)

The '(for OptsVisitor)' comment doesn't add anything useful; I'd drop it.=


> =20
> +@var{source} and @var{destination} are NUMA node ID.

Maybe s/ID/IDs/

> +@var{distance} is NUMA distance from @var{source} to @var{destination}=
=2E

s/is/is the/

> +The distance from node A to node B may be different from the distance =
from
> +node B to node A since the distance allows to be asymmetry.

s/allows to be asymmetry/can be asymmetric/

> +If the distance is not set, the default distance for local NUMA node i=
s 10,
> +and 20 for remote node.

s/for/for a/g

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vqIgKAfpdv94gIeifTHhLxHgaRAJkliTV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0TFEAAoJEKeha0olJ0Nqlp4H/jhtcL42CnSM7EIb9vrhoCY0
HR0FoiU0NudpDsdzEj/cb2Ryf9rMuZcf2vYqAP0kPVdjcRPd2eFV7Kj3iF0L4wtl
agEfIa7ujNw8cLq0LVW4a/rNs2Z1dW+2avAnjtHxVWYSqEMW4WW9xWmfFn9KdEJn
YFTR4BEgK5YCskXA+oTNHjgYlQ4PjGXSP9i+g4OFnh9sC+8v7PEcjvkoPDPTxqk7
rqwKWwBnzvGGmgm1lrAvGUSEZHZFScOxZYwsEtIFpYR1Q+iK93wbWAJWwzr8ss1d
gcvn6V8JvE6YTPVM5o4zqNL6I208LlxaFReCyUC5v8HQIMRV7j2NpIFTMkC39Uk=
=dMvG
-----END PGP SIGNATURE-----

--vqIgKAfpdv94gIeifTHhLxHgaRAJkliTV--
