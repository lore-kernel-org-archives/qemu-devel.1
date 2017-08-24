Received: from eggs.gnu.org ([2001:4830:134:3::10]:60615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkv9a-000844-0K
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkv9W-0004Tu-UX
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:38:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dkv9W-0004PM-KH
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:38:42 -0400
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <04558062-88d3-0bd2-06d2-ba8a5af8ba8e@redhat.com>
Date: Thu, 24 Aug 2017 11:38:33 -0500
MIME-Version: 1.0
In-Reply-To: <1503564371-26090-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="La6cgo8U6B8klViUXktkgETMc7KlG6Fug"
Subject: Re: [Qemu-devel] [PATCH 02/16] qapi: Drop superfluous
 qapi_enum_parse() parameter max
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
--La6cgo8U6B8klViUXktkgETMc7KlG6Fug
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <04558062-88d3-0bd2-06d2-ba8a5af8ba8e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/16] qapi: Drop superfluous
 qapi_enum_parse() parameter max
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
 <1503564371-26090-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1503564371-26090-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 03:45 AM, Markus Armbruster wrote:
> The lookup tables have a sentinel, no need to make callers pass their
> size.
>=20
> Fun: the header has it in the wrong position.  Good riddance.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block.c                  |  1 -
>  block/file-posix.c       |  7 +++----
>  block/file-win32.c       |  2 +-
>  block/gluster.c          |  6 ++----
>  block/parallels.c        |  3 ++-
>  block/qcow2.c            |  6 ++----
>  blockdev.c               |  1 -
>  hmp.c                    |  2 +-
>  include/qapi/util.h      |  2 +-
>  migration/global_state.c |  3 +--

This would be a patch where using scripts/git.orderfile to highlight the
interface change first would make review a bit quicker :)

> +++ b/include/qapi/util.h
> @@ -12,7 +12,7 @@
>  #define QAPI_UTIL_H
> =20
>  int qapi_enum_parse(const char * const lookup[], const char *buf,
> -                    int max, int def, Error **errp);
> +                    int def, Error **errp);

I'm not sure what you meant by wrong position; were you thinking that
lookup/max should be immediately adjacent (since max is a property of
the lookup[] parameter), and sticking 'buf' in between the two is what
meant 'max' was in the wrong position?

The change itself is reasonable, even if the commit message needs a
tweak to answer my question.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--La6cgo8U6B8klViUXktkgETMc7KlG6Fug
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmfAQkACgkQp6FrSiUn
Q2rJ4AgAn150jB9H4PULYld+IUfgbQqWV1wcfj+MmzG/Vgb1DeCG9/JTNkM8BBT4
fTZ5Hu+PPwFlpHmqpLMvCdAZNb+enMKcmazH+tMCEsnyCN6OmGCBtIV2/ZOjPBTW
Wm0w56xdK2/NlWjvbTaJa+exf03mmWGD8ojuefiRIkyCPMBvq4HuoS0dqgKiA+4M
e9A0+rjtSuwmqn1+W/A1cPWDarCnWCPnNH/jOzZQrbtjHhGN8S17EaWWMFMpxFFD
DrlbCMkjENo0ZkzIqI9v09+MM3riRp/rjMbbeLY3NTzo6Mw91TQcCd/OSRM72rXZ
5qthlYaNCu6zsQJ0KLTJ6uFdg3cp8A==
=2Y9y
-----END PGP SIGNATURE-----

--La6cgo8U6B8klViUXktkgETMc7KlG6Fug--
