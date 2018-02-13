Received: from eggs.gnu.org ([2001:4830:134:3::10]:49213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elYjK-0001L2-G0
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elYjG-0007Vy-U9
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:26:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1elYjG-0007Tz-NI
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 06:26:30 -0500
Date: Tue, 13 Feb 2018 11:26:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180213112607.GE573@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180212184650.24039-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180212184650.24039-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] travis: use libgcc-4.8-dev (libgcc-6-dev
 is not available on Ubuntu 14.04)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Mon, Feb 12, 2018 at 03:46:50PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Travis image is based on Ubuntu Trusty (14.04), since d83414e1fd1 we ge=
t:
>=20
>   $ sudo -E \
>     apt-get -yq --no-install-suggests --no-install-recommends --force-y=
es \
>       install \
>         libaio-dev libattr1-dev libbrlapi-dev libcap-ng-dev libgcc-6-de=
v \
>         libgnutls-dev libgtk-3-dev libiscsi-dev liblttng-ust-dev \
>         libncurses5-dev libnfs-dev libnss3-dev libpixman-1-dev libpng12=
-dev \
>         librados-dev libsdl1.2-dev libseccomp-dev libspice-protocol-dev=
 \
>         libspice-server-dev libssh2-1-dev liburcu-dev libusb-1.0-0-dev =
\
>         libvte-2.90-dev sparse uuid-dev
>   Reading package lists...
>   Building dependency tree...
>   Reading state information...
>   E: Unable to locate package libgcc-6-dev
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Since libgcc-dev is used, Travis jobs take much longer.
>=20
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Can we get this pushed asap, as testing via travis is a key part
of my workflow before sending pull requests.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
