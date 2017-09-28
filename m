Received: from eggs.gnu.org ([2001:4830:134:3::10]:50245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxdSJ-0002yB-H9
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxdSG-0003Xa-DL
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:22:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dxdSG-0003X9-5L
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:22:36 -0400
References: <20170928120621.30288-1-berrange@redhat.com>
	<20170928120621.30288-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a7007b76-bcbf-eb19-ebbc-fe1422ef484d@redhat.com>
Date: Thu, 28 Sep 2017 13:22:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170928120621.30288-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AdkLvDOhkVhhfhqVH9kJegR0kQfiXfJhk"
Subject: Re: [Qemu-devel] [PATCH v7 3/6] ui: add keycodemapdb repository as
 a GIT submodule
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AdkLvDOhkVhhfhqVH9kJegR0kQfiXfJhk
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7007b76-bcbf-eb19-ebbc-fe1422ef484d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/6] ui: add keycodemapdb repository as a
 GIT submodule
References: <20170928120621.30288-1-berrange@redhat.com>
 <20170928120621.30288-4-berrange@redhat.com>
In-Reply-To: <20170928120621.30288-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/28/2017 07:06 AM, Daniel P. Berrange wrote:
> The https://gitlab.com/keycodemap/keycodemapdb/ repo contains a
> data file mapping between all the different scancode/keycode/keysym
> sets that are known, and a tool to auto-generate lookup tables for
> different combinations.
>=20
> It is used by GTK-VNC, SPICE-GTK and libvirt for mapping keys.
> Using it in QEMU will let us replace many hand written lookup
> tables with auto-generated tables from a master data source,
> reducing bugs. Adding new QKeyCodes will now only require the
> master table to be updated, all ~20 other tables will be
> automatically updated to follow.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

> +++ b/configure
> @@ -264,7 +264,13 @@ cc_i386=3Di386-pc-linux-gnu-gcc
>  libs_qga=3D""
>  debug_info=3D"yes"
>  stack_protector=3D""
> -git_submodules=3D""
> +
> +if test -d "$source_path/.git"

Again, .git does not have to be a directory; test -e is probably safer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AdkLvDOhkVhhfhqVH9kJegR0kQfiXfJhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnNPeQACgkQp6FrSiUn
Q2qJggf/WhxstrepbBZzOjyOrFRLrkuvSmE7nSENY4Qi2yjbXPwlpm9l1eJwGeEn
CY5A5RMP10R8IZzgHEhkc5NbFU0Y1PQ9EM5grH8YJ50gnE2pjoLAOIMbXGYNE7rq
4Nn5Zmmk74IyD3hHQAqx/aqciyqfj+Z73+XmFTy6Gee8s5QlakI3vvYveDjpNv8M
MpIvWZwIKSTiZZcAwxD9pmq4b7Cl9/JP+cvXyUpY/gAIQWdhqcyupkZ/h1/cztM1
qo9IqQJOEuKakzAIfPkOVUeaIPqs6vMQQ4qRmSqgle41670feXzszw8Oa/nbEOK2
4kMddL6yh3j71/SW8bKsOYOow0hNPA==
=V5y6
-----END PGP SIGNATURE-----

--AdkLvDOhkVhhfhqVH9kJegR0kQfiXfJhk--
