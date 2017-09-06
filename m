Received: from eggs.gnu.org ([2001:4830:134:3::10]:60855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpcQH-0006hm-BW
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpcQE-0002PW-GS
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:39:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpcQE-0002Ob-6y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:39:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40541C0587DF
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 15:39:21 +0000 (UTC)
References: <cover.1504696921.git.mprivozn@redhat.com>
	<6f78df0d8af98d89bdae1d189c0e21ba7ca3ead9.1504696921.git.mprivozn@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0f4b8e2-cdc3-e342-0cd2-3b144ad5cc7f@redhat.com>
Date: Wed, 6 Sep 2017 10:39:18 -0500
MIME-Version: 1.0
In-Reply-To: <6f78df0d8af98d89bdae1d189c0e21ba7ca3ead9.1504696921.git.mprivozn@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E2ivF3madaae2QtsG6Kj9Gjts3PtIR4JI"
Subject: Re: [Qemu-devel] [PATCH v4 3/3] watchdog: Allow setting action on
 the fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E2ivF3madaae2QtsG6Kj9Gjts3PtIR4JI
From: Eric Blake <eblake@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com
Message-ID: <a0f4b8e2-cdc3-e342-0cd2-3b144ad5cc7f@redhat.com>
Subject: Re: [PATCH v4 3/3] watchdog: Allow setting action on the fly
References: <cover.1504696921.git.mprivozn@redhat.com>
 <6f78df0d8af98d89bdae1d189c0e21ba7ca3ead9.1504696921.git.mprivozn@redhat.com>
In-Reply-To: <6f78df0d8af98d89bdae1d189c0e21ba7ca3ead9.1504696921.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2017 06:24 AM, Michal Privoznik wrote:
> Currently, the only time that users can set watchdog action is at
> the start as all we expose is this -watchdog-action command line
> argument. This is suboptimal when users want to plug the device
> later via monitor. Alternatively, they might want to change the
> action for already existing device on the fly.
>=20
> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=3D1447169
>=20
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  hw/watchdog/watchdog.c | 8 +++++++-
>  qapi-schema.json       | 9 +++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>=20

> +++ b/qapi-schema.json
> @@ -3143,3 +3143,12 @@
>  # Since 2.9
>  ##
>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> +
> +##
> +# @watchdog-set-action:
> +#
> +# Set watchdog action
> +#
> +# Since 2.11
> +##
> +{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogActio=
n'} }

Markus went to some effort to sort the documentation output; is plopping
this at the end of the file the best location?

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--E2ivF3madaae2QtsG6Kj9Gjts3PtIR4JI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwFqYACgkQp6FrSiUn
Q2rooggAqJO49bSADN/bQQptruto0OlnsPPE/EGL9PjCjag+F1mxZnfcyHsZYMa5
VNE0dePJ2SlhGQx3+Ufm6ZH2qPkLxt8tMcI82b7XR1gXMJK1dRxglGcUaLpZ0vAK
gZhEQgwLiXuNeKJ1NCN0+zAJbL4HyqK/bptEMq6NhyNoguFHn3Frj39Z+Evhmovz
XSYlZDfZgNKfpPD5+wyDEtT+mQq/LLb4Cmf3/015dohS6YQlBbwho/LLE1G0CwtZ
0jp+0cJvmkEOqj5wR2YN45h3kFi43S77AyJV8x53JlZlBAHfKlN8gxelLcKynHPC
soc/ufMH51DvMjQxLmhJRoXSnUiUMw==
=vS0A
-----END PGP SIGNATURE-----

--E2ivF3madaae2QtsG6Kj9Gjts3PtIR4JI--
