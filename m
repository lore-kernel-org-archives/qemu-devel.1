Received: from eggs.gnu.org ([209.51.188.92]:54917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gr7VL-0005jz-DK
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gr7PS-0005qS-3N
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 15:33:35 -0500
References: <1549397675-189741-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1549397675-189741-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce1a623e-8844-72d5-e4a7-ca8cb9354c86@redhat.com>
Date: Tue, 5 Feb 2019 14:33:15 -0600
MIME-Version: 1.0
In-Reply-To: <1549397675-189741-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aR2UHf0IY4p7KOx4gdMFh23i8aRwMXQHd"
Subject: Re: [Qemu-devel] [PATCH v12 2/3] qcow2: Add list of bitmaps to
 ImageInfoSpecificQCow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aR2UHf0IY4p7KOx4gdMFh23i8aRwMXQHd
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com,
 berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <ce1a623e-8844-72d5-e4a7-ca8cb9354c86@redhat.com>
Subject: Re: [PATCH v12 2/3] qcow2: Add list of bitmaps to
 ImageInfoSpecificQCow2
References: <1549397675-189741-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1549397675-189741-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1549397675-189741-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/5/19 2:14 PM, Andrey Shinkevich wrote:
> In the 'Format specific information' section of the 'qemu-img info'
> command output, the supplemental information about existing QCOW2
> bitmaps will be shown, such as a bitmap name, flags and granularity:
>=20

> +##
> +# @Qcow2BitmapInfo:
> +#
> +# Qcow2 bitmap information.
> +#
> +# @name: the name of the bitmap
> +#
> +# @granularity: granularity of the bitmap in bytes
> +#
> +# @flags: flags of the bitmap
> +#
> +# Since: 4.0

You got rid of the docs for unknown-flags,

> +##
> +{ 'struct': 'Qcow2BitmapInfo',
> +  'data': {'name': 'str', 'granularity': 'uint32',
> +           'flags': ['Qcow2BitmapInfoFlags'],
> +           '*unknown-flags': 'uint32' } }

but forgot to actually get rid of the field. That's a pretty simple
cleanup, which I don't mind making if this series is otherwise ready to g=
o.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--aR2UHf0IY4p7KOx4gdMFh23i8aRwMXQHd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxZ8wsACgkQp6FrSiUn
Q2quEggAqY0M9lSNeURIgJzBB8rCW2oAPFfyRKr0vjVOSsk1pIfJkYSdDwdfHRiq
6PRmyjxrX7GO7C6Xs86VW+WI5kqCGx+IcTUf9hVE3caqdxt2gvT4Vu+9k+2f+wIi
s1krTMiNF+e/PB9CojCsndvvBSmC5SPJ5p34EVzPUmJqQMS07afa4/ozJ+ljKELw
aMk4jBLVodY9WH1PieQVk0AiA3wJ9DlQqv0Q/nYMW1TCZ9h0AdRwSarVH6+6R2oP
aJ9c4Rj1f/QOwforZYy7dcVcQIWIxoXe7ubsyOLIAY7lOrossE40Hu09QpkpNJmh
VxzDwLh9e3f64MQ53IFeTaBAMfoeaw==
=Ckd8
-----END PGP SIGNATURE-----

--aR2UHf0IY4p7KOx4gdMFh23i8aRwMXQHd--
