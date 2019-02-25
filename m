Received: from eggs.gnu.org ([209.51.188.92]:46050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gyK7M-00072V-Md
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gyK7K-0005aC-Qc
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:32:39 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1gyK7J-0005Uh-HC
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:32:37 -0500
Received: by mail-pl1-x644.google.com with SMTP id q3so4817983pll.4
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 09:32:35 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Mon, 25 Feb 2019 20:29:27 +0300
References: <201902230335.59138.randrianasulu@gmail.com>
	<0c9db8ef-a2a5-e634-7461-63fae4bba32d@redhat.com>
In-Reply-To: <0c9db8ef-a2a5-e634-7461-63fae4bba32d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201902252029.28990.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] Build error with git commit
 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116 on x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe Mathieu-Daudc3a9 <philmd@redhat.com>
Cc: qemu-devel@nongnu.org

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
Monday 25 February 2019 19:19:01 Philippe Mathieu-Daudc3a9=20
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
> Hi Andrew,
>
> On 2/23/19 1:35 AM, Andrew Randrianasulu wrote:
> > Hello!
> >
> > I just pulled latest git
>
> [...]
>
> > and default build with simple ./configure on slackware 14.2 x86-64 box
> > failed like this:
> >
> > root@slax:~/src/qemu# LANG=3DC make -j 5
> >         CHK version_gen.h
> >   CC      qobject/block-qdict.o
> >   CC      util/thread-pool.o
> >   CC      util/main-loop.o
> >   CC      util/qemu-timer.o
> >   CC      util/iohandler.o
> >   CC      util/aio-posix.o
> > qobject/block-qdict.c: In function 'qdict_array_split':
> > qobject/block-qdict.c:259:9: error: 'subqdict' may be used uninitialized
> > in this function [-Werror=3Dmaybe-uninitialized]
> >          qlist_append_obj(*dst, subqobj ?: QOBJECT(subqdict));
> >          ^
>
> That's odd, I can not reproduce with a simple ./configure:
>
> $ cat /etc/slackware-version
> Slackware 14.2
>
> $ gcc --version
> gcc (GCC) 5.5.0
>

Well, then may be this is false positive, right now another qemu instance i=
s=20
busy inside same chroot, will try patch posted in earlier mail (after remov=
ing=20
CFLAG I added for compiling qemu at all after this error).

Thanks for trying to reproduce.

> >  LANG=3DC gcc --version
> > gcc (GCC) 5.5.0
> > Copyright (C) 2015 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.  There is
> > NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> > PURPOSE.
