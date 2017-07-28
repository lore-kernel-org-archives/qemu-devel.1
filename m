Received: from eggs.gnu.org ([2001:4830:134:3::10]:50087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db9xG-0005qY-HM
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db9xC-0001o0-J4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:25:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db9xC-0001nj-5i
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:25:38 -0400
References: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com>
	<20170728121044.15488-3-vadim.galitsyn@profitbricks.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9429617-2e3c-6b85-572f-8f0c70f93b62@redhat.com>
Date: Fri, 28 Jul 2017 13:25:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170728121044.15488-3-vadim.galitsyn@profitbricks.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eKPegrlAM6Q996WU3OoPCLB1eTXuFokBt"
Subject: Re: [Qemu-devel] [PATCH v5 2/3] qmp: introduce
 query-memory-size-summary command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>, Mohammed Gamal <mohammed.gamal@profitbricks.com>, Eduardo Otubo <eduardo.otubo@profitbricks.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eKPegrlAM6Q996WU3OoPCLB1eTXuFokBt
From: Eric Blake <eblake@redhat.com>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org
Cc: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>,
 Mohammed Gamal <mohammed.gamal@profitbricks.com>,
 Eduardo Otubo <eduardo.otubo@profitbricks.com>
Message-ID: <b9429617-2e3c-6b85-572f-8f0c70f93b62@redhat.com>
Subject: Re: [PATCH v5 2/3] qmp: introduce query-memory-size-summary command
References: <20170728121044.15488-1-vadim.galitsyn@profitbricks.com>
 <20170728121044.15488-3-vadim.galitsyn@profitbricks.com>
In-Reply-To: <20170728121044.15488-3-vadim.galitsyn@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 07:10 AM, Vadim Galitsyn wrote:
> Command above provides the following memory information in bytes:
>=20
>   * base-memory - size of "base" memory specified with command line opt=
ion -m.
>=20
>   * hotunpluggable-memory - amount of memory that was hot-plugged.
>     If target does not have CONFIG_MEM_HOTPLUG enabled, no
>     value is reported.
>=20
> Signed-off-by: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.co=
m>
> Signed-off-by: Mohammed Gamal <mohammed.gamal@profitbricks.com>
> Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
> Signed-off-by: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
> Reviewed-by: Eugene Crosser <evgenii.cherkashin@profitbricks.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---

> +++ b/qapi-schema.json
> @@ -4407,6 +4407,31 @@
>    'data': { 'name': 'str', '*migration-safe': 'bool', 'static': 'bool'=
,
>              '*unavailable-features': [ 'str' ], 'typename': 'str' } }
> =20
> +##
> +# @MemoryInfo:
> +#
> +# Actual memory information in bytes.
> +#
> +# @base-memory: size of "base" memory specified with command line
> +#               option -m.
> +#
> +# @hotunpluggable-memory: size memory that can be hot-unplugged.
> +#
> +# Since: 2.10.0

At this point, we've missed feature freeze for 2.10; so this would be
better as 2.11.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eKPegrlAM6Q996WU3OoPCLB1eTXuFokBt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7gZkACgkQp6FrSiUn
Q2o2qQf/TYH55GefQXE8sENa3mNRMGatBzDTGSE3/p+u34u1eYHWw30QrPc1NgZV
7S/rI/Qc0CBaEJnNSUolzd8B6EuFWLFZG+7zNZ8dmb+++C0NaKMiHDjRzYaI9wjm
otdrL8XS1o3dlicdKc54vixO/Uc+g0+mnN/b1MavSRqhoLdPyaMbSMlhjVz/idl2
IvBSi8quiDb/O0dLZKeHZLFwvClZVwwOsJOibxlQXXaugU2WOxWCu21Nmy+TEcXo
EZ27CzC2wS0kyiyeCY0hoQ6MkiX1lYpTjzsAT3VnIvHQhfCeM8pyHPluD8Ypb+QR
NaYyjY0gTVIzjzGoyLuciWwlkFHe1g==
=9B9S
-----END PGP SIGNATURE-----

--eKPegrlAM6Q996WU3OoPCLB1eTXuFokBt--
