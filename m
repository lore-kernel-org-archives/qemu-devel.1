Received: from eggs.gnu.org ([2001:4830:134:3::10]:42273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fWMy2-0006pE-W5
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fWMxz-0003zy-3e
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:23:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53350 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fWMxy-0003zq-Um
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:23:11 -0400
Date: Fri, 22 Jun 2018 15:23:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180622142305.GM23296@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180622140223.26056-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180622140223.26056-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add fedora-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org

On Fri, Jun 22, 2018 at 11:02:23AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> As of this commit:
>=20
>   $ xtensa-linux-gnu-as -v
>   GNU assembler version 2.29.1 (xtensa-linux-gnu) using BFD version ver=
sion 2.29.1-1.fc27
>=20
>   $ xtensa-linux-gnu-gcc -v
>   Target: xtensa-linux-gnu
>   gcc version 7.2.1 20170915 (Red Hat Cross 7.2.1-1) (GCC)
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/fedora-xtensa-cross.docker | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/fedora-xtensa-cross.docker
>=20
> diff --git a/tests/docker/dockerfiles/fedora-xtensa-cross.docker b/test=
s/docker/dockerfiles/fedora-xtensa-cross.docker
> new file mode 100644
> index 0000000000..6f9521520c
> --- /dev/null
> +++ b/tests/docker/dockerfiles/fedora-xtensa-cross.docker
> @@ -0,0 +1,7 @@
> +FROM fedora:latest

IIRC, we decided using ':latest' is not a good idea because its meaning
will change over time and lead to inconsistent results for devs. We saw
this before when patchew reported failure on fedora while developers saw
nothing, due to patchew having cached a ":latest" image which was differe=
nt.

> +ENV PACKAGES \
> +    binutils-xtensa-linux-gnu \
> +    gcc-xtensa-linux-gnu
> +
> +RUN dnf install -y $PACKAGES
> +RUN rpm -q $PACKAGES | sort > /packages.txt


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
