Received: from eggs.gnu.org ([2001:4830:134:3::10]:49057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dYUH6-0008QR-GZ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dYUH5-0006fW-9Z
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:31:08 -0400
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:37902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1dYUH5-0006f3-2l
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:31:07 -0400
Received: by mail-ua0-x22d.google.com with SMTP id w45so41391985uac.5
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 02:31:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170721083816.GC17693@redhat.com>
References: <CAB3eZfsG9YLTfA8ATJujjGE1D3G3iQQ+OXmUvo49J7d-QpDgTg@mail.gmail.com>
	<20170720085958.GC21566@redhat.com>
	<CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
	<20170720091224.GD21566@redhat.com>
	<CAB3eZfupcH0G+zRBaaE-8OU1JjM3exSOEvYeuOtB1uRUCZ4yiQ@mail.gmail.com>
	<20170721083816.GC17693@redhat.com>
From: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>
Date: Fri, 21 Jul 2017 17:31:04 +0800
Message-ID: <CAB3eZfu8dhhaxe-MEj+=WFxCCns6prZEjZnjg2rDd_RCmG8x8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

It works after I replace the /usr/bin/qemu-nbd with binary I built.

My cmd is :

> qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
>              --image-opts driver=3Dqcow2,file.filename=3D
> demo.qcow2,encrypt.format=3Dluks,encrypt.key-secret=3Dsec0


But I got other message:

> Block format 'qcow2' does not support the option 'encrypt.format'


Maybe it doen't support yet?

2017-07-21 16:38 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:

> On Fri, Jul 21, 2017 at 09:44:33AM +0800, =E9=99=B3=E5=9F=B9=E6=B3=93 wro=
te:
> > I re-build qemu from the https://github.com/qemu/qemu, and it didn't
> show
> > any errors.
> >
> > I tried the cmd you suggested below:
> >
> > > qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
> > >            -c /dev/nbd0 \
> > >            --image-opts driver=3Dqcow2,file.filename=3D
> > > demo.qcow2,encrypt.format=3Dluks,encrypt.key-secret=3Dsec0
> >
> > but it shows unrecognized option '--object '
> > why?I missed to install something?
>
> Sounds like you're not running the binaries you just built
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>
