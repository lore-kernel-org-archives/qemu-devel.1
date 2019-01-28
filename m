Received: from eggs.gnu.org ([209.51.188.92]:37974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goBEu-0004Ao-IK
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goB0i-0001Q9-CN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:47:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1goB0i-0001Lo-2Y
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:47:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D148F7F6CB
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 17:47:39 +0000 (UTC)
References: <20190128170321.16936-1-dgilbert@redhat.com>
	<20190128170321.16936-8-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf3e5c3d-0802-42b0-a4eb-ffc2dfbf3706@redhat.com>
Date: Mon, 28 Jan 2019 11:47:35 -0600
MIME-Version: 1.0
In-Reply-To: <20190128170321.16936-8-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vf2DETuNPqRryj0pL0vp9MCZNfv5IiOcw"
Subject: Re: [Qemu-devel] [PATCH 7/9] qmp: Add announce-self command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vf2DETuNPqRryj0pL0vp9MCZNfv5IiOcw
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com,
 mst@redhat.com, armbru@redhat.com, berrange@redhat.com
Message-ID: <cf3e5c3d-0802-42b0-a4eb-ffc2dfbf3706@redhat.com>
Subject: Re: [PATCH 7/9] qmp: Add announce-self command
References: <20190128170321.16936-1-dgilbert@redhat.com>
 <20190128170321.16936-8-dgilbert@redhat.com>
In-Reply-To: <20190128170321.16936-8-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/28/19 11:03 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Add a qmp command that can trigger guest announcements.
>=20
> It uses it's own announce-timer instance, and parameters

s/it's/its/ (here, you want the possessive form without apostrophe; the
contraction form is correct only when you can use "it is" in the same pla=
ce)

> passed to it explicitly in the command.
>=20
> Like most qmp commands, it's in the main thread/bql, so

Here, "it's" is correct.

> there's no racing with any outstanding timer.
>=20
> Based on work of Germano Veit Michel <germano@redhat.com> and
>                  Vladislav Yasevich <vyasevic@redhat.com>
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  net/announce.c |  8 ++++++++
>  qapi/net.json  | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>=20

> +++ b/qapi/net.json
> @@ -707,3 +707,23 @@
>              'max': 'int',
>              'rounds': 'int',
>              'step': 'int' } }
> +
> +##
> +# @announce-self:
> +#
> +# Trigger generation of broadcast RARP frames to update network switch=
es.
> +# This can be useful when network bonds fail-over the active slave.
> +#
> +# @params: AnnounceParameters giving timing and repetition count of an=
nounce
> +#
> +# Example:
> +#
> +# -> { "execute": "announce-self"
> +#      "arguments": { "initial": 50, "max": 550, "rounds": 10, "step":=
 50 } }

Again, can any of these have useful defaults to be left optional?

> +# <- { "return": {} }
> +#
> +# Since: 4.0
> +##
> +{ 'command': 'announce-self',
> +  'data' : {'params': 'AnnounceParameters'} }
> +
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--vf2DETuNPqRryj0pL0vp9MCZNfv5IiOcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxPQDcACgkQp6FrSiUn
Q2rKywf8DxfSpt6ZyA/J+FcQxvFN+QMBTrvbm47kClsHRWNgpQBfCazvOHyUITF3
/qL+sImmHYt3K2KX7V4AzaJdtm8VMJ3T1FkFIY6D3I4+E0oN0Dtb7HEpTrn2Bo4q
65HB/gXYDUduv2exZESpmvEEii3ukjuLQGjp8E4qUwMgenpEGcBdadQeKS7AUyQa
0GY9yfg2HlPmmPKLy2IjuWcQJ+M46XAWGgHktJi5DmXpGbaMJH/E3g20XKpKMCWp
e5z7XUEzMA5am8ePU/8Pa5GTaS2SehKVo8zgZsloc2/jkU+jCT9d82ClU1l9jEeF
n5OEq3Mddqz+ATLlXxb/13Wz6d3xog==
=y2VA
-----END PGP SIGNATURE-----

--vf2DETuNPqRryj0pL0vp9MCZNfv5IiOcw--
