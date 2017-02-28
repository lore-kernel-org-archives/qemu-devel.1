Received: from eggs.gnu.org ([2001:4830:134:3::10]:37515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cimf1-0007fR-Cv
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cimey-0001UU-Aa
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:38:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cimey-0001UC-2C
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:38:04 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1556980463
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 18:38:04 +0000 (UTC)
References: <1488303560-18803-1-git-send-email-armbru@redhat.com>
	<1488303560-18803-24-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1dac8734-4fbc-a43c-42a2-1a8db5520b4f@redhat.com>
Date: Tue, 28 Feb 2017 12:38:01 -0600
MIME-Version: 1.0
In-Reply-To: <1488303560-18803-24-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7Mf42cO3nAGvQ5fQ7bV3cXPc7aIu5b1Qn"
Subject: Re: [Qemu-devel] [PATCH v3 23/26] qapi: Make input visitors detect
 unvisited list tails
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
--7Mf42cO3nAGvQ5fQ7bV3cXPc7aIu5b1Qn
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <1dac8734-4fbc-a43c-42a2-1a8db5520b4f@redhat.com>
Subject: Re: [PATCH v3 23/26] qapi: Make input visitors detect unvisited list
 tails
References: <1488303560-18803-1-git-send-email-armbru@redhat.com>
 <1488303560-18803-24-git-send-email-armbru@redhat.com>
In-Reply-To: <1488303560-18803-24-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 11:39 AM, Markus Armbruster wrote:
> Fix the design flaw demonstrated in the previous commit: new method
> check_list() lets input visitors report that unvisited input remains
> for a list, exactly like check_struct() lets them report that
> unvisited input remains for a struct or union.
>=20
> Implement the method for the qobject input visitor (straightforward),
> and the string input visitor (less so, due to the magic list syntax
> there).  The opts visitor's list magic is even more impenetrable, and
> all I can do there today is a stub with a FIXME comment.  No worse
> than before.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/hw/ppc/spapr_drc.c
> @@ -326,7 +326,12 @@ static void prop_get_fdt(Object *obj, Visitor *v, =
const char *name,
>                      return;
>                  }
>              }
> +            visit_check_list(v, &err);
>              visit_end_list(v, NULL);
> +            if (err) {
> +                error_propagate(errp, err);
> +                return;
> +            }
>              break;
>          }

Better. Thanks for the fast respin.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7Mf42cO3nAGvQ5fQ7bV3cXPc7aIu5b1Qn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtcOJAAoJEKeha0olJ0NqZhIH/3Elr5w4tLWwWdvHLQwtt2EP
ZbEgW/BgOnUpx8mF1MtiIilch469tQ+LeqdyJX81JMGwEGbN+c/z5lWQlVYDg2jo
5z4bej4MinM9O+34T6R9a6zbuAO/2DGEVYZa4AI+s5F4muVqsjj3l/h9G55X9MjN
DQiYCn89fzSyQY2CIgmVqv5Ta6iZ0S4Cuy3TVBoz0GTn0jvulqqI9kZmysAzP5x6
wbkt5LIq+y+pIOVBFdh8fNuFOmC7S6wXkrxdDKQM2PrYlUmcy/0r25AdLkvdJnQ2
92SOVd7vGXpljC7wboE85jsfHy27zPcF4iWSt380COCw3+w01OdRZM9DbCRZ0YM=
=zo98
-----END PGP SIGNATURE-----

--7Mf42cO3nAGvQ5fQ7bV3cXPc7aIu5b1Qn--
