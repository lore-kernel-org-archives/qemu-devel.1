Received: from eggs.gnu.org ([2001:4830:134:3::10]:51775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnsqW-00023Z-8F
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnsqS-0003G6-95
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:15:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnsqS-0003Fp-0X
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:15:00 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-18-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1bc48113-aed0-5a5e-0818-f842c984ac64@redhat.com>
Date: Tue, 14 Mar 2017 15:14:57 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-18-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RVhcl9CLbFxmLNwo2cdefnXp1uR05LEhD"
Subject: Re: [Qemu-devel] [PATCH for-2.9 17/47] qapi: The #optional tag is
 redundant, drop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RVhcl9CLbFxmLNwo2cdefnXp1uR05LEhD
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <1bc48113-aed0-5a5e-0818-f842c984ac64@redhat.com>
Subject: Re: [PATCH for-2.9 17/47] qapi: The #optional tag is redundant, drop
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-18-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-18-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> We traditionally mark optional members #optional in the doc comment.
> Before commit 3313b61, this was entirely manual.
>=20
> Commit 3313b61 added some automation because its qapi2texi.py relied
> on #optional to determine whether a member is optional.  This is no
> longer the case since the previous commit: the only thing qapi2texi.py
> still does with #optional is stripping it out.  We still reject bogus
> qapi-schema.json and six places for qga/qapi-schema.json.
>=20
> Thus, you can't actually rely on #optional to see whether something is
> optional.  Yet we still make people add it manually.  That's just
> busy-work.
>=20
> Drop the code to check, fix up and strip out #optional, along with all
> instances of #optional.  To keep it out, add code to reject it, to be
> dropped again once the dust settles.
>=20
> No change to generated documentation.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/qapi-code-gen.txt              |  16 +-
>  docs/writing-qmp-commands.txt       |   4 +-
>  qapi-schema.json                    | 378 ++++++++++++++++------------=
----
>  qapi/block-core.json                | 418 ++++++++++++++++++----------=
--------

You'll have to rebase this on master, due to ...


> @@ -2349,17 +2349,17 @@
>  #
>  # @volume:              Name of the Archipelago volume image
>  #
> -# @mport:               #optional The port number on which mapperd is
> +# @mport:               The port number on which mapperd is
>  #                       listening. This is optional
>  #                       and if not specified, QEMU will make Archipela=
go
>  #                       use the default port (1001).
>  #

=2E..commit e32ccbc killing broken archipelago

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--RVhcl9CLbFxmLNwo2cdefnXp1uR05LEhD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyE9BAAoJEKeha0olJ0Nq2agH/0Ca+YlwLySTeb0VC1sapOuI
PVBb0JTS6F6oYe42zJUzyl3lIhAD3aq1k8mezUxBaE7mKGLeouFRsjTfOnLpEIHs
Pfh49TZtW1xjdNT2AQkQn+5PzyT+H2jTSJhKZhHDttFgX4lkJUQzy02CRcfevdXf
WNJ4dBVt8R3BvIfNdDvMeGz7f0pTNnrnZpTlkTwXPqvStNnqlmFL4Bd1bosDMYW4
lnxqAnJLenexjLh7ugETl0wEyBCAyItdlqmVQ7cw2SNBSrZ7Yl03Kx5Dgs5U+RkW
P/8FkZVZy1TjhYcSrQ1CFzEOCDuMV2PaIgrs1CdHZEJnlJwIjT5/1NsEjvcIj3Q=
=PqEQ
-----END PGP SIGNATURE-----

--RVhcl9CLbFxmLNwo2cdefnXp1uR05LEhD--
