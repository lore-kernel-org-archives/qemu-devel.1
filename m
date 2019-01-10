Received: from eggs.gnu.org ([209.51.188.92]:36870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gheZa-00063v-Mf
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gheZZ-0002d2-C3
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:56:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gheZZ-0002cc-6o
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:56:53 -0500
Date: Thu, 10 Jan 2019 17:56:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190110175645.GV2178@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
	<20190110174516.21586-6-alex.bennee@linaro.org>
	<4e3923c6-ab62-3e78-eb96-5e68544fa7ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e3923c6-ab62-3e78-eb96-5e68544fa7ca@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 05/19] tests: update Fedora i386 cross
 image to Fedora 29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, ymankad@redhat.com, Fam Zheng <fam@euphon.net>

On Thu, Jan 10, 2019 at 06:54:24PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 1/10/19 6:45 PM, Alex Benn=C3=A9e wrote:
> > From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >=20
> > Using the "latest" tag is not a good idea because this changes what
> > release it points to every 6 months. Together with caching of docker
> > builds this can cause confusion where CI has cached & built with Fedo=
ra
> > N, while a developer tries to reproduce a CI problem with Fedora N + =
1,
> > or vica-verca.
>=20
> So we now learned the hard way commiting "FROM x:latest" to a repositor=
y
> is a bad practice.

Unfortunately this is the second time we've had to learn it :-(

  commit 5b9b49d7bd3e0da13e8f6d58578443a11817f56e
  Author: Paolo Bonzini <pbonzini@redhat.com>
  Date:   Fri Jan 12 12:11:43 2018 +0100

    docker: change Fedora base image to fedora:27
   =20
    Using "fedora:latest" makes behavior different depending on when you
    actually pulled the image from the docker repository.  In my case,
    the supposedly "latest" image was a Fedora 25 download from 8 months
    ago, and the new "test-debug" test was failing.
   =20
    Use "27" to improve reproducibility and make it clear when the image
    is obsolete.
   =20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
