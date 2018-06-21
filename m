Received: from eggs.gnu.org ([2001:4830:134:3::10]:35455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVvf9-00005L-Ds
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 05:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVvf6-0002r1-4T
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 05:13:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVvf5-0002qO-Vv
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 05:13:52 -0400
Date: Thu, 21 Jun 2018 10:13:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180621091345.GE3615@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180621062605.941-1-alex.bennee@linaro.org>
	<20180621062605.941-2-alex.bennee@linaro.org>
	<CAFEAcA8WQD26TW+zfd-f=qeUP7QFxHixV-AENWEmWyyNU3bseg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8WQD26TW+zfd-f=qeUP7QFxHixV-AENWEmWyyNU3bseg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 01/57] docker: docker.py wrap StringIO
 import for python3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>

On Thu, Jun 21, 2018 at 09:49:55AM +0100, Peter Maydell wrote:
> On 21 June 2018 at 07:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> > Although the docker.py is nominally python2 we actually invoke it wit=
h
> > the configured python from the configure script.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> > diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> > index 306e14cf69..e4095270eb 100755
> > --- a/tests/docker/docker.py
> > +++ b/tests/docker/docker.py
> > @@ -26,7 +26,10 @@ import tempfile
> >  import re
> >  import signal
> >  from tarfile import TarFile, TarInfo
> > -from StringIO import StringIO
> > +try:
> > +    from StringIO import StringIO
> > +except ImportError:
> > +    from io import StringIO
> >  from shutil import copy, rmtree
> >  from pwd import getpwuid
>=20
> This is fairly trivial, but it is a new unreviewed patch:
> would one of the python experts like to review it ?

Yes, this is the normal fix for this particular scenario.

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
