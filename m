Received: from eggs.gnu.org ([2001:4830:134:3::10]:47087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0TC9-0002he-Bc
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0TC5-0008RO-CX
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:01:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e0TC5-0008QA-6Y
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:01:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E99F67E380
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 14:01:35 +0000 (UTC)
References: <20171006131645.17729-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc752b7a-c910-62c9-395b-3c7e10072408@redhat.com>
Date: Fri, 6 Oct 2017 09:01:34 -0500
MIME-Version: 1.0
In-Reply-To: <20171006131645.17729-1-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GVVpppEjV6OPcO38VLQD9PapEG9N0tDFC"
Subject: Re: [Qemu-devel] [PATCH] option: Drop unused get_param_value(),
 get_next_param_value()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GVVpppEjV6OPcO38VLQD9PapEG9N0tDFC
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <bc752b7a-c910-62c9-395b-3c7e10072408@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] option: Drop unused get_param_value(),
 get_next_param_value()
References: <20171006131645.17729-1-armbru@redhat.com>
In-Reply-To: <20171006131645.17729-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/06/2017 08:16 AM, Markus Armbruster wrote:
> Their last user went away in commit f51074cdc6, "pci-hotplug-old: Has
> been dead for five major releases, bury", v2.3.0.  Remove them, as new
> code should use QemuOpts or maybe keyval_parse() instead.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qemu/option.h |  5 -----
>  util/qemu-option.c    | 34 ----------------------------------
>  2 files changed, 39 deletions(-)

Always fun to kill dead code ;-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GVVpppEjV6OPcO38VLQD9PapEG9N0tDFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnXjL4ACgkQp6FrSiUn
Q2p0OQf5AZdb8b/hae8ijUSZya6V6787jN0O8xnKPngJqSyB8IBhLO9anwsjud4R
3zFXHkzAg94zkmxRNcpx3uqGZq85hbHaKkj32PjvX1N1jRT562BtpaqX1+1ifCHJ
QOEAnot2yhwRMLgNtsxHhDDgNsUUjdiXowl2QuRxsj4+Ulm2MG21af9y3h1q7gHr
pzGhiA31fETpL2yl12dkqPkkGBbLVxxXDTXMIrkkA8gbdgEw+7ctu8wNVdj80TKS
H2lU3m0P2UFj1nDLJza4HYlKbqChAB9IL6le01Z9FPlvLpXlxoAA0nBO+i4hu/Uk
dcqIfNpuqn8/TVeScX23cDF+sq1rBA==
=sUv6
-----END PGP SIGNATURE-----

--GVVpppEjV6OPcO38VLQD9PapEG9N0tDFC--
