Received: from eggs.gnu.org ([2001:4830:134:3::10]:33772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxJHO-0004fd-4Q
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxJHK-00015k-W8
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:50:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dxJHK-00013d-Nl
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:49:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BED29C0BD3BB
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 20:49:57 +0000 (UTC)
References: <20170927204148.2311-1-ehabkost@redhat.com>
	<20170927204148.2311-2-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e0e7e4a-0e66-ef49-8ee7-02e6ffd424b4@redhat.com>
Date: Wed, 27 Sep 2017 15:49:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170927204148.2311-2-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JJ6QkA5I5EMH26UuUaSJw8F10Lirg0nxV"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] config: qemu_config_parse() return
 number of config groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JJ6QkA5I5EMH26UuUaSJw8F10Lirg0nxV
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <3e0e7e4a-0e66-ef49-8ee7-02e6ffd424b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] config: qemu_config_parse() return
 number of config groups
References: <20170927204148.2311-1-ehabkost@redhat.com>
 <20170927204148.2311-2-ehabkost@redhat.com>
In-Reply-To: <20170927204148.2311-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2017 03:41 PM, Eduardo Habkost wrote:
> Change qemu_config_parse() to return the number of config groups
> in success and -EINVAL on error. This will allow callers of
> qemu_config_parse() to check if something was really loaded from
> the config file.
>=20
> All existing callers of qemu_config_parse() and
> qemu_read_config_file() only check if the return value was
> negative, so the change shouldn't affect them.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

> Changes v2 -> v3:
> * None (rebase only)
>=20
> Changes v1 -> v2:
> * Remove unnecessary translation of qemu_config_parse()
>   erros to -EINVAL at block/blkdebug.c:read_config()
>   * Suggsted-by: Markus Armbruster <armbru@redhat.com>

Do you want the Suggested-by (spelled correctly) in the commit body prope=
r?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JJ6QkA5I5EMH26UuUaSJw8F10Lirg0nxV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnMDvQACgkQp6FrSiUn
Q2rGjQf9FO0+v+CcJmfySMXwTB4d3KrIAjCn/5rSpsGc1j8sRFo+rLp9rnTihy0s
J+RUASDz2OkhI0b58AZGRYHhhtiOaaEXycXZzHwX1S6dMV8zmEVr0874os6vRjii
7xOo5bWG3v7ZD5LHxu/+NfvUJpTQlNlmPO96Jg6689fvOtFjwvGDJLs7BQ/2D6Iq
hHVcj9SczkepOcE5WKwyUj/swQ2tcJGKHerHM4GXy5HC+gxcQoMUSO+1y9k4Mniz
XcMI35KM0yX6T7BtJJzqrdnwyFmcOBioesMDIJ+wyWY9FJxHlBS9gzdzuogEFAh0
eabTmZzEj6dvSTRq2Q0mq+t24l8yaQ==
=SA6W
-----END PGP SIGNATURE-----

--JJ6QkA5I5EMH26UuUaSJw8F10Lirg0nxV--
