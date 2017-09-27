Received: from eggs.gnu.org ([2001:4830:134:3::10]:33010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxJEr-0003Nh-It
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxJEn-0007xy-MI
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:47:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dxJEn-0007xr-D3
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:47:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4601CA1969
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 20:47:20 +0000 (UTC)
References: <20170927204148.2311-1-ehabkost@redhat.com>
	<20170927204148.2311-3-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d06c7b8f-02aa-3e5f-1c76-0355a016bb09@redhat.com>
Date: Wed, 27 Sep 2017 15:47:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170927204148.2311-3-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Kk6PXWhjI9ptTE6vwnIUO0CAIWqkFTrch"
Subject: Re: [Qemu-devel] [PATCH v3 2/2] vl: Print warning when a default
 config file is loaded
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
--Kk6PXWhjI9ptTE6vwnIUO0CAIWqkFTrch
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <d06c7b8f-02aa-3e5f-1c76-0355a016bb09@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] vl: Print warning when a default
 config file is loaded
References: <20170927204148.2311-1-ehabkost@redhat.com>
 <20170927204148.2311-3-ehabkost@redhat.com>
In-Reply-To: <20170927204148.2311-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/27/2017 03:41 PM, Eduardo Habkost wrote:
> In case there were options set in the default config file, print
> a warning so users can update their scripts.
>=20
> If somebody wants to keep the config file as-is, avoid the
> warning and use a command-line that will work in future QEMU
> versions, they can use:
>=20
>  $QEMU -no-user-config -readconfig /etc/qemu/qemu.conf
>=20
> I was going to add an additional message suggesting it as a
> solution, but I thought it could make it more confusing. The
> solution can be documented in the QEMU 2.11 ChangeLog.
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v2 -> v3:
> * Rebase (no code changes)
> * Commit message update: suggest -no-user-config

> +    if (ret > 0) {
> +        loc_set_none();
> +        error_report("Warning: Future QEMU versions won't load %s auto=
matically",
> +                     CONFIG_QEMU_CONFDIR "/qemu.conf");

Shouldn't we now use warn_report() with no 'Warning:' prefix?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Kk6PXWhjI9ptTE6vwnIUO0CAIWqkFTrch
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnMDlYACgkQp6FrSiUn
Q2pE1wgAh8BqjHkFogeog/fg4AAh8a4kVNpfWHhlwuADt8UfFcjVGazx39cHuDiU
Cg4qovEjcU+d+hN+2LKGlicmRSZrP2Sg0jQfsuFG60mmqFisTnAEzisEdqlU51ZH
n0TkFIkaOSScBRSYDEnh8HOBJgGaQ5eJsDf6bZG2nc0ysgSKKvQNDC31KWpzVtKl
VbfxEZG5N2Gz9PTlokFzwsxZ+bS+rAoPzhxhpiVk3ewB1RacdpTX/vf+jQSJx5Y4
bkh1s+ESM4+1WQzguDA6HpeXpM6ST4GgEtnczAbjwX4MPYJn6FAdTPOqArXtJw2L
MPjvaCZuJ4pUf86HVtfNi2gsPr3stQ==
=R0Xh
-----END PGP SIGNATURE-----

--Kk6PXWhjI9ptTE6vwnIUO0CAIWqkFTrch--
