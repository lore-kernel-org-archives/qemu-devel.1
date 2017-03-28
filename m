Received: from eggs.gnu.org ([2001:4830:134:3::10]:49149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cstU5-0008JQ-Hl
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cstU2-0001Ud-Ul
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:56:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cstU2-0001U3-Mi
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:56:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B592C8FCFE
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 15:56:31 +0000 (UTC)
References: <20170328152745.28186-1-dgilbert@redhat.com>
	<20170328152745.28186-2-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c9d5d33-4d90-24de-9c15-ac5742079c87@redhat.com>
Date: Tue, 28 Mar 2017 10:56:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170328152745.28186-2-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IskwAHGu5VGHKeM1twCIQNdODrf2GeVd5"
Subject: Re: [Qemu-devel] [PATCH 1/6] migration/announce: Add parameters for
 self-announce
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com
Cc: kashyap@redhat.com, germano@redhat.com, jasowang@redhat.com, armbru@redhat.com, jdenemar@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IskwAHGu5VGHKeM1twCIQNdODrf2GeVd5
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com
Cc: kashyap@redhat.com, germano@redhat.com, jasowang@redhat.com,
 armbru@redhat.com, jdenemar@redhat.com
Message-ID: <5c9d5d33-4d90-24de-9c15-ac5742079c87@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] migration/announce: Add parameters for
 self-announce
References: <20170328152745.28186-1-dgilbert@redhat.com>
 <20170328152745.28186-2-dgilbert@redhat.com>
In-Reply-To: <20170328152745.28186-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/28/2017 10:27 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Add the parameters and wire into the set/get routines.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/migration.c | 52 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  qapi-schema.json      | 34 +++++++++++++++++++++++++++++++--
>  2 files changed, 84 insertions(+), 2 deletions(-)
>=20

> =20
> +    if (params->has_announce_initial &&
> +        (params->announce_initial < 1 || params->announce_initial > 10=
0000)) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "announce_initi=
al",
> +                   "is invalid, it should be in the range of 1 to 1000=
00 ms");
> +    }
> +    if (params->has_announce_max &&
> +        (params->announce_max < 1 || params->announce_max > 100000)) {=


You're doing range validation here...

> +++ b/qapi-schema.json
> @@ -960,6 +960,18 @@
>  #
>  # Migration parameters enumeration
>  #
> +# @announce-initial: The inital delay (in ms) before sending the first=
 announce
> +#          (Since 2.10)

=2E..so it would be useful to mention the bounds here. Also, mentioning
the defaults is a good idea.

s/inital/initial/

> +#
> +# @announce-max: The maximum delay (in ms) between packets in the anno=
uncment
> +#          (Since 2.10)

s/announcment/announcement/

> +#
> +# @announce-rounds: The number of self-announce packets sent after mig=
ration
> +#          (Since 2.10)
> +#
> +# @announce-step: The increase in delay (in ms) between subsequent pac=
kets in
> +#          the announcement (Since 2.10)
> +#

> @@ -1038,6 +1052,18 @@
>  # ('query-migrate-parameters'), with the exception of tls-creds and
>  # tls-hostname.
>  #
> +# @announce-initial: The inital delay (in ms) before sending the first=
 announce
> +#          (Since 2.10)
> +#
> +# @announce-max: The maximum delay (in ms) between packets in the anno=
uncment
> +#          (Since 2.10)

same two typos

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IskwAHGu5VGHKeM1twCIQNdODrf2GeVd5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2oefAAoJEKeha0olJ0NqFs0IAITO2DVWST7qft3OX2RcZ7p9
3Bf/SUHHFx1LIrFz5Sd/dSxEPxJMQQfDkDhenRkL9E1CPAoQQuytq+dqpBmmITCz
W45k6hBxKPTg+NzyLZiSo0dqdFRBOtMTasBnUlU3rmqrmQF6JticMK1lCVSbzhlz
ccYzP4rTnO8YNj7JGuS+dQhHo1NcODE+tQrY+rHoQCxuPxuG+xVGIzjzntVso5JR
5n9NFH9yLdTNhLat8/Y72/Z12s1J3ccUW+9mskL3eHbSUyuAyPDyf9/gCCvVt1Wv
nf/wGYWdvgfZZO3oNgl2JEMzHiF804Pc8kzkufZ5Lwps/sJW3tTMIALmXA2YUC8=
=SQXU
-----END PGP SIGNATURE-----

--IskwAHGu5VGHKeM1twCIQNdODrf2GeVd5--
