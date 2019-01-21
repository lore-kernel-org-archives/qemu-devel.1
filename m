Received: from eggs.gnu.org ([209.51.188.92]:37644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1glYwn-0005Sd-4z
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1glYss-0000xi-KW
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:40:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1glYss-0000pp-Dv
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:40:58 -0500
Date: Mon, 21 Jan 2019 12:40:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190121124045.GB3683@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <154805723903.5550.18349469177184195707@2d3111e9616b>
	<3304e77c-c228-e5d7-0319-8f3325e8c0cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3304e77c-c228-e5d7-0319-8f3325e8c0cd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/8] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, fam@euphon.net, peter.maydell@linaro.org

On Mon, Jan 21, 2019 at 01:21:34PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 1/21/19 8:54 AM, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/20190116010106.27626-1-jsnow@re=
dhat.com/
> >=20
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > time make docker-test-mingw@fedora SHOW_ENV=3D1 J=3D14
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >=20
> >   CC      crypto/block.o
> >   CC      crypto/block-qcow.o
> > /tmp/qemu-test/src/block/sheepdog.c: In function 'find_vdi_name':
> > /tmp/qemu-test/src/block/sheepdog.c:1239:5: error: 'strncpy' specifie=
d bound 256 equals destination size [-Werror=3Dstringop-truncation]
> >      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
> >      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
>=20
> Thanks Patchew, this error is now fixed (merged in 51c1c135608).

patchew's build test queue seems to running about 5 days slow, but its
git apply queue is timely. So it is testing this patch using git head
as of 5 days ago, despite the build only running today.

So I presume the fix in 51c1c135608 will only start to have effect for
patches that patchew imported to git after 51c1c135608 merged.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
