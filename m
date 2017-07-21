Received: from eggs.gnu.org ([2001:4830:134:3::10]:34768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYTS5-0006h4-K9
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dYTS1-0006hN-U7
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:38:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dYTS1-0006gf-Ni
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:38:21 -0400
Date: Fri, 21 Jul 2017 09:38:16 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170721083816.GC17693@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAB3eZfsG9YLTfA8ATJujjGE1D3G3iQQ+OXmUvo49J7d-QpDgTg@mail.gmail.com>
	<20170720085958.GC21566@redhat.com>
	<CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
	<20170720091224.GD21566@redhat.com>
	<CAB3eZfupcH0G+zRBaaE-8OU1JjM3exSOEvYeuOtB1uRUCZ4yiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB3eZfupcH0G+zRBaaE-8OU1JjM3exSOEvYeuOtB1uRUCZ4yiQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Can I mount encrypt qcow2?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>
Cc: qemu-devel@nongnu.org

On Fri, Jul 21, 2017 at 09:44:33AM +0800, =E9=99=B3=E5=9F=B9=E6=B3=93 wro=
te:
> I re-build qemu from the https://github.com/qemu/qemu, and it didn't sh=
ow
> any errors.
>=20
> I tried the cmd you suggested below:
>=20
> > qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
> >            -c /dev/nbd0 \
> >            --image-opts driver=3Dqcow2,file.filename=3D
> > demo.qcow2,encrypt.format=3Dluks,encrypt.key-secret=3Dsec0
>=20
> but it shows unrecognized option '--object '
> why?I missed to install something?

Sounds like you're not running the binaries you just built


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
