Received: from eggs.gnu.org ([2001:4830:134:3::10]:34221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuI72-0003sE-Nh
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuI71-0003AS-MG
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:03:24 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-13-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c8fe6817-6f09-f476-32d3-25d0ca3abb59@redhat.com>
Date: Mon, 27 Aug 2018 16:03:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-13-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ikD9YaHzKRCcO53ezosQcTnsyngmfFbGz"
Subject: Re: [Qemu-devel] [PATCH v2 12/13] qapi/block-stream: expose new job
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ikD9YaHzKRCcO53ezosQcTnsyngmfFbGz
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <c8fe6817-6f09-f476-32d3-25d0ca3abb59@redhat.com>
Subject: Re: [PATCH v2 12/13] qapi/block-stream: expose new job properties
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-13-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-13-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:22, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c           |  9 +++++++++
>  hmp.c                |  5 +++--
>  qapi/block-core.json | 16 +++++++++++++++-
>  3 files changed, 27 insertions(+), 3 deletions(-)

[...]

> diff --git a/hmp.c b/hmp.c
> index 2aafb50e8e..e3c3ecd76f 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1865,8 +1865,9 @@ void hmp_block_stream(Monitor *mon, const QDict *=
qdict)
>      int64_t speed =3D qdict_get_try_int(qdict, "speed", 0);
> =20
>      qmp_block_stream(true, device, device, base !=3D NULL, base, false=
, NULL,
> -                     false, NULL, qdict_haskey(qdict, "speed"), speed,=

> -                     true, BLOCKDEV_ON_ERROR_REPORT, &error);
> +                     false, NULL, qdict_haskey(qdict, "speed"), speed,=
 true,
> +                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, fa=
lse,

Does this remind me more of Dilbert's RNG or of Wheatley brute-forcing
passwords in Portal 2?

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +                     &error);
> =20
>      hmp_handle_error(mon, &error);
>  }


--ikD9YaHzKRCcO53ezosQcTnsyngmfFbGz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluEBJ4ACgkQ9AfbAGHV
z0A3cQgAnNB6tLCxFrIgPz68IP7Q/Clx6x9S0yQKl2dMVoN045O+HSph69yRTpQ1
pQ6vldK+xKWT7EKQGKvlGNYIxtqF0KuV9aTvhHp7gkIJpZcSSBYsySRtwU64k7hz
3hNOnsR+6XtxI4iOqiN7aMTUYep0HAcd898rcJm+GUtbVajYr799XeaAtP/xVVS1
gjyA3rBuBEkEuheLujv98qNPq1hhqDZ5itpaJADORQw/uL82iiE7gTC94pZetCQ2
j/ZkdHcVYNvNfStyj7wIn+Id6P5bRu2HwBwdaCEMxkILkUywklUPj74VQv4N2wM9
WEvT53zEmK8hskhwTQ7mt19fvShlhg==
=m3GG
-----END PGP SIGNATURE-----

--ikD9YaHzKRCcO53ezosQcTnsyngmfFbGz--
