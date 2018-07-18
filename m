Received: from eggs.gnu.org ([2001:4830:134:3::10]:52275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffgqX-0004XG-8y
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffgqW-0003Yf-8i
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:26:01 -0400
Date: Wed, 18 Jul 2018 08:25:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180718072548.GB9812@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <7a6766fc-9fac-79a5-d53c-b5209abccaae@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a6766fc-9fac-79a5-d53c-b5209abccaae@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-iotests: workaround to avoid Python3 while
 running tests on Fedora Docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Tue, Jul 17, 2018 at 08:37:58PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> I noticed this while running "make docker-test-block@fedora":
>=20
> $ make docker-test-block@fedora NETWORK=3D1
>   BUILD   fedora
>     RUN test-block in qemu:fedora
> Configure options:
> --enable-werror --prefix=3D/tmp/qemu-test/install
> --python=3D/usr/bin/python3 --target-list=3Dx86_64-softmmu
> ...
> python            /usr/bin/python3 -B
> ...
>=20
> 194         - output mismatch (see 194.out.bad)
> --- /tmp/qemu-test/src/tests/qemu-iotests/194.out       2018-07-17
> 22:51:10.000000000 +0000
> +++ /tmp/qemu-test/build/tests/qemu-iotests/194.out.bad 2018-07-17
> 22:58:01.646916625 +0000
> @@ -1,18 +1,18 @@
>  Launching VMs...
>  Launching NBD server on destination...
> -{u'return': {}}
> -{u'return': {}}
> +{'return': {}}
> +{'return': {}}
>=20
> and many more errors, until:
>=20
> Failures: 045 132 148 152 162 169 194 205 208 218 222
> Failed 11 of 49 tests
> Test failed: iotests raw
>=20
> All failures are due to Python2 syntax.
> I started to fix but noticed there are too many and this isn't to
> correct fix for this release.

Were they all due to the unicode string prefix, or where there
difference failures too ?

The unicode string prefix could probably be fixed once by changing
the log() method in iotests.py to have a built-in filter that
chomps the leading 'u'


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
