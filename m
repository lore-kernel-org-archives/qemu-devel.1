Received: from eggs.gnu.org ([2001:4830:134:3::10]:42335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dZrQy-0003bq-JF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 00:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dZrQx-0005me-9P
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 00:27:00 -0400
Received: from mail-ua0-x22c.google.com ([2607:f8b0:400c:c08::22c]:36036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1dZrQw-0005lu-Vz
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 00:26:59 -0400
Received: by mail-ua0-x22c.google.com with SMTP id k43so57376203uaf.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 21:26:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <deb984a7-3d71-9db0-f3fb-eaf12c13064e@redhat.com>
References: <20170720085958.GC21566@redhat.com>
	<CAB3eZfuGD8OKr0HJwzDmiuAp5Sk5BuA8K4E+CvhwuYTAaKuMQA@mail.gmail.com>
	<20170720091224.GD21566@redhat.com>
	<CAB3eZfupcH0G+zRBaaE-8OU1JjM3exSOEvYeuOtB1uRUCZ4yiQ@mail.gmail.com>
	<20170721083816.GC17693@redhat.com>
	<CAB3eZfu8dhhaxe-MEj+=WFxCCns6prZEjZnjg2rDd_RCmG8x8w@mail.gmail.com>
	<20170721093433.GG17693@redhat.com>
	<CAB3eZfuWJGwO1m8SgVr=x6NLtfvZFOuLQEdzs+9K5osStM2nOA@mail.gmail.com>
	<9959acca-6934-97c0-20a2-ff793d05f526@redhat.com>
	<18c3027a-d30b-98df-9693-826751f80ea9@redhat.com>
	<20170721140631.GS17693@redhat.com>
	<81f2f144-896a-d16e-83da-1fae313ccfff@redhat.com>
	<CAB3eZfsDUpcYDLogUuz4H-X-petqnc4+hXwkXjO3v1jrRB=r2w@mail.gmail.com>
	<deb984a7-3d71-9db0-f3fb-eaf12c13064e@redhat.com>
From: lampahome <pahome.chen@mirlab.org>
Date: Tue, 25 Jul 2017 12:26:56 +0800
Message-ID: <CAB3eZft4kBbxfR1L080p7SF5X3XJk1Bmr3Y6uw6z9X4U44tOfA@mail.gmail.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

I thought 2.9.0 is the latest and check to the wrong commit.
Now it supports encryption.

My cmd is:

> qemu-nbd --object secret,id=3Dsec0,file=3Dpasswd.txt,format=3Draw \
>              --image-opts
> driver=3Dqcow2,file.filename=3Ddemo.qcow2,encrypt.format=3Dluks,encrypt.k=
ey-secret=3Dsec0

But it shows error message:

> No encryption in image header, but options specified format 'luks'

Something wrong?

My procedure is below:
1. create a clean demo.qcow2 image(no compression, no encryption)
2. use the cmd above to encrypt the demo.qcow2 image

2017-07-24 20:25 GMT+08:00 Eric Blake <eblake@redhat.com>:

> On 07/23/2017 08:49 PM, =E9=99=B3=E5=9F=B9=E6=B3=93 wrote:
> > I check to the newest version of qemu.
>
> You're still top-posting, which makes it really hard to answer your
> questions.
>
> >
> > and do the cmds to install followed by the documents in github:
> >
> >> mkdir build
> >> cd build
> >> ../configure
> >> make
> >
> >
> > and it show nothing errors=E2=80=8B
> > It's the version when I enter qemu-img --help:
> >
> > and I execute encrypt format(luks) to the qcow2 file:
> >
> > =E2=80=8B
>
> Attaching inline images is a horrible waste of bandwidth, compared to
> copying-and-pasting the terminal text directly.  Furthermore, your email
> is illegible in a plain-text client (like what I prefer to use), and
> requires that I switch to html view to even understand what you are askin=
g.
>
> > always shows the error, how to solve it?=E2=80=8B
>
> Transcribing one of your images:
>
> > pahome@pahome-QW09:~/git/qemu/build$ ./qemu-img --help
> > qemu-img version 2.9.0 (v2.9.0-dirty)
>
> You aren't building the latest version of qemu.git.  If you were, you'd
> be getting something like this:
>
> $ ./qemu-img --help | head -n1
> qemu-img version 2.9.50 (v2.9.0-2519-gb52f59694d)
>
> Before you can complain that something recently added isn't working, you
> first have to make sure you are building the right version.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>
