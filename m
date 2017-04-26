Received: from eggs.gnu.org ([2001:4830:134:3::10]:56064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3RAy-00048H-P7
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3RAt-0002yr-9e
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:56:28 -0400
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
	<1493192202-3184-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fee3a5ba-5f80-61a6-bdca-92a420f5f3a1@redhat.com>
Date: Wed, 26 Apr 2017 12:56:12 -0500
MIME-Version: 1.0
In-Reply-To: <1493192202-3184-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="31fj2DbQtoWDV8RsJtukcXXWtRfhXUE12"
Subject: Re: [Qemu-devel] [PATCH 3/7] qapi: New QAPI_CLONE_MEMBERS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--31fj2DbQtoWDV8RsJtukcXXWtRfhXUE12
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org
Message-ID: <fee3a5ba-5f80-61a6-bdca-92a420f5f3a1@redhat.com>
Subject: Re: [PATCH 3/7] qapi: New QAPI_CLONE_MEMBERS()
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
 <1493192202-3184-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1493192202-3184-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 02:36 AM, Markus Armbruster wrote:
> QAPI_CLONE() returns a newly allocated QAPI object.  Inconvenient when
> we want to clone into an existing object.  QAPI_CLONE_MEMBERS() does
> exactly that.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/clone-visitor.h | 14 ++++++++++++++
>  qapi/qapi-clone-visitor.c    | 13 +++++++++++++
>  2 files changed, 27 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--31fj2DbQtoWDV8RsJtukcXXWtRfhXUE12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAN88AAoJEKeha0olJ0NqfAUH/3tMT8z9zr0gfzYhiJgjqw9h
hGZjFTjKDK1WDR4SbHPT4zm/WHI7eyFq4pbb4jJPkNo68y6l046eI9USZzFxbSAx
ti/fOJNfuFCI6DrcrUEEWsJY0CNBvZ3zPQNufbmbxOjaXEqqqYOv8WG/w/QxQuda
nkfp5EGvUfjSGLH8ja+KfEw4+/L9nF8m/s2ktD0qJlSNKo4ZWMXaedWJT/YvQLFh
TkxEHrADNHIcb/Dv1Y/IQTtDsooH1JZgrNZln6+96+vrLIvi6pVDx6IYPrPFAeRN
qhOkhp7TkZsS7R4KlKEEpUEKRRwdfxA48q3ADMv0HI9MMN0zoyH1TzfolMyX7Wk=
=0UmX
-----END PGP SIGNATURE-----

--31fj2DbQtoWDV8RsJtukcXXWtRfhXUE12--
