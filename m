Received: from eggs.gnu.org ([2001:4830:134:3::10]:46386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elf1R-0008A6-0t
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elf1N-0001mS-8i
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:09:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1elf1N-0001mH-2Q
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 13:09:37 -0500
Date: Tue, 13 Feb 2018 18:09:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180213180918.GY573@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180213173429.19501-1-stefanha@redhat.com>
	<20180213173429.19501-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180213173429.19501-2-stefanha@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, Feb 13, 2018 at 05:34:25PM +0000, Stefan Hajnoczi wrote:
> From: Fam Zheng <famz@redhat.com>
>=20
> git-publish [1] is a convenient tool to send patches and has been
> popular among QEMU developers.  Recently it has been made available in
> Fedora official repo thanks to Stefan's work.
>=20
> One nice feature of the tool is a per-project configuration with
> profiles, especially in which the cccmd option is a handy method to
> create the Cc list.
>=20
> [1]: https://github.com/stefanha/git-publish
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-id: 20180205054725.25634-2-famz@redhat.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  .gitpublish | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 .gitpublish
>=20
> diff --git a/.gitpublish b/.gitpublish
> new file mode 100644
> index 0000000000..ed48f6e52c
> --- /dev/null
> +++ b/.gitpublish
> @@ -0,0 +1,58 @@
> +#
> +# Common git-publish profiles that can be used to send patches to QEMU=
 upstream.
> +#
> +# See https://github.com/stefanha/git-publish for more information
> +#
> +[gitpublishprofile "default"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "rfc"]
> +base =3D master
> +prefix =3D RFC PATCH
> +to =3D qemu-devel@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "stable"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-stable@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "trivial"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-trivial@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "block"]
> +base =3D master
> +prefix =3D PATCH
> +to =3D qemu-devel@nongnu.org
> +cc =3D qemu-block@nongnu.org
> +cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null

Why is a custom entry needed for block here (and other things
below).   Won't running get_maintainer.pl already correctly
report when a patch needs cc'ing to qemu-block@nongnu.org
based on MAINTAINER rules ?


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
