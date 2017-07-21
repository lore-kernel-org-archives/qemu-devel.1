Received: from eggs.gnu.org ([2001:4830:134:3::10]:51136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dYUQu-0006yI-Fm
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dYUQt-0002rw-Fr
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:41:16 -0400
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:35420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1dYUQt-0002rV-AE
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:41:15 -0400
Received: by mail-ua0-x236.google.com with SMTP id d29so32094309uai.2
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 02:41:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170721093433.GG17693@redhat.com>
References: <CAB3eZfsG9YLTfA8ATJujjGE1D3G3iQQ+OXmUvo49J7d-QpDgTg@mail.gmail.com>
	<20170720085958.GC21566@redhat.com>
	<CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
	<20170720091224.GD21566@redhat.com>
	<CAB3eZfupcH0G+zRBaaE-8OU1JjM3exSOEvYeuOtB1uRUCZ4yiQ@mail.gmail.com>
	<20170721083816.GC17693@redhat.com>
	<CAB3eZfu8dhhaxe-MEj+=WFxCCns6prZEjZnjg2rDd_RCmG8x8w@mail.gmail.com>
	<20170721093433.GG17693@redhat.com>
From: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>
Date: Fri, 21 Jul 2017 17:41:14 +0800
Message-ID: <CAB3eZfuWJGwO1m8SgVr=x6NLtfvZFOuLQEdzs+9K5osStM2nOA@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

oh Maybe the version is something wrong?

qemu-img -V

> qemu-img version 2.9.0


qemu-nbd -V

> qemu-nbd version 0.0.1


They're not correspondent?

2017-07-21 17:34 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:

> On Fri, Jul 21, 2017 at 05:31:04PM +0800, =E9=99=B3=E5=9F=B9=E6=B3=93 wro=
te:
> > It works after I replace the /usr/bin/qemu-nbd with binary I built.
> >
> > My cmd is :
> >
> > > qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
> > >              --image-opts driver=3Dqcow2,file.filename=3D
> > > demo.qcow2,encrypt.format=3Dluks,encrypt.key-secret=3Dsec0
> >
> >
> > But I got other message:
> >
> > > Block format 'qcow2' does not support the option 'encrypt.format'
> >
> >
> > Maybe it doen't support yet?
>
> It is supported. I think you're git checkout is not fully updated.
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
