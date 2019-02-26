Received: from eggs.gnu.org ([209.51.188.92]:47473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gyYcH-0007qm-NR
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gyYcA-0006ow-0A
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:01:29 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1gyYc0-0006kl-2B
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:01:17 -0500
Received: by mail-pl1-x641.google.com with SMTP id m10so5904605plt.10
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 01:01:15 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Tue, 26 Feb 2019 11:58:07 +0300
References: <201902230335.59138.randrianasulu@gmail.com>
	<201902252029.28990.randrianasulu@gmail.com>
	<6de6b2df-380a-75dd-b3e9-4197ca4db866@redhat.com>
In-Reply-To: <6de6b2df-380a-75dd-b3e9-4197ca4db866@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201902261158.09086.randrianasulu@gmail.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
Tuesday 26 February 2019 11:54:12 =D0=B2=D1=8B =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB=D0=B8:
> On 25/02/2019 18.29, Andrew Randrianasulu wrote:
> > =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Monday 25 February 2019 19:19:01 Philippe Mathieu-Daudc3a9
> >
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
> >> Hi Andrew,
> >>
> >> On 2/23/19 1:35 AM, Andrew Randrianasulu wrote:
> >>> Hello!
> >>>
> >>> I just pulled latest git
> >>
> >> [...]
> >>
> >>> and default build with simple ./configure on slackware 14.2 x86-64 box
> >>> failed like this:
> >>>
> >>> root@slax:~/src/qemu# LANG=3DC make -j 5
> >>>         CHK version_gen.h
> >>>   CC      qobject/block-qdict.o
> >>>   CC      util/thread-pool.o
> >>>   CC      util/main-loop.o
> >>>   CC      util/qemu-timer.o
> >>>   CC      util/iohandler.o
> >>>   CC      util/aio-posix.o
> >>> qobject/block-qdict.c: In function 'qdict_array_split':
> >>> qobject/block-qdict.c:259:9: error: 'subqdict' may be used
> >>> uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >>>          qlist_append_obj(*dst, subqobj ?: QOBJECT(subqdict));
> >>>          ^
> >>
> >> That's odd, I can not reproduce with a simple ./configure:
> >>
> >> $ cat /etc/slackware-version
> >> Slackware 14.2
> >>
> >> $ gcc --version
> >> gcc (GCC) 5.5.0
> >
> > Well, then may be this is false positive, right now another qemu instan=
ce
> > is busy inside same chroot, will try patch posted in earlier mail (after
> > removing CFLAG I added for compiling qemu at all after this error).
> >
> > Thanks for trying to reproduce.
>
> Just to be sure: You don't compile with -O3 or -O1 or -O0 in the CFLAGS
> here, do you?

This time  it was -O3, but I got some corruption in ppc64le guest's X, so I=
 plan=20
to revert this -O3 back to default ....

another qemu still busy compiling kernel (modified Alpine linux ppc64le con=
fig),=20
and also Cinelerra-GG (video editor I'm hacking on), so I hope whole thing =
will=20
be finished ..in day or so.

>
>  Thomas
