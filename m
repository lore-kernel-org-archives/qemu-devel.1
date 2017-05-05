Received: from eggs.gnu.org ([2001:4830:134:3::10]:54623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6joQ-0003OU-0q
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6joM-0000Mv-Nr
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:26:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6joM-0000Mh-Ef
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:26:46 -0400
References: <20170505201128.12099-1-ehabkost@redhat.com>
	<20170505201128.12099-2-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66817015-f286-42a6-c225-d03af470f904@redhat.com>
Date: Fri, 5 May 2017 15:26:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170505201128.12099-2-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="623clX6bdPIIj48rm00oPuMaG1xsjUT27"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] visitor: Add 'supported_qtypes'
 parameter to visit_start_alternate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--623clX6bdPIIj48rm00oPuMaG1xsjUT27
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <66817015-f286-42a6-c225-d03af470f904@redhat.com>
Subject: Re: [PATCH v2 1/3] visitor: Add 'supported_qtypes' parameter to
 visit_start_alternate()
References: <20170505201128.12099-1-ehabkost@redhat.com>
 <20170505201128.12099-2-ehabkost@redhat.com>
In-Reply-To: <20170505201128.12099-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 03:11 PM, Eduardo Habkost wrote:
> This will allow visitors to make decisions based on the supported qtype=
s
> of a given alternate type. The new parameter can replace the old
> 'promote_int' argument, as qobject-input-visitor can simply check if
> QTYPE_QINT is set in supported_qtypes.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Change supported_qtypes to uint32_t (Eric Blake)
> * Replace assert() on all generated visitor functions with a
>   single QEMU_BUILD_BUG_ON() on visit_start_alternate()
> * Extra spaces around "|" on generated visitor code
>   (Eric Blake)
> * Don't use bitops.h and just use (1U << QTYPE_FOO)
>   (Markus Armbruster)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--623clX6bdPIIj48rm00oPuMaG1xsjUT27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDN/9AAoJEKeha0olJ0Nq/RQH/RDrTzV0cUIOztxD0BEAjk/b
mzG+uVNXg/9dSTXNZ0Y6NDhAXWJBMWb6qslmvq5DDmg41uBSzQ/qLZQDOr0rKNp1
NnJpfxgqjpOut/cLoovyq5NTKUWHMdFm8p/2hTpCAdC8PBzPV8N6zf3RhgMu3gN2
2dEWiFOIgNbigzxddCnn+KTzFitJi+7gELrGvA5OkJsSu+voj7JlbyVMC4gOA2Av
NgNJ8+OcH91WowzY2/RwVtuZyZ1H6MsRMl/86RiyUYjYn4B1g3irzdTzvcid9hN1
N8pyVoHZOZZMc8kGTdFKRrdIPD3kD0OfQcmAtUfOzapvWmecpNi/BjbHpdRk8GM=
=XHbF
-----END PGP SIGNATURE-----

--623clX6bdPIIj48rm00oPuMaG1xsjUT27--
