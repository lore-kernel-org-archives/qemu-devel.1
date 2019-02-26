Received: from eggs.gnu.org ([209.51.188.92]:56185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gyZN2-0001YI-LP
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gyZN0-0001UG-HJ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:49:52 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1gyZMy-0001Qh-Ec
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 04:49:48 -0500
Received: by mail-pg1-x541.google.com with SMTP id j3so5946185pgm.11
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 01:49:48 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Tue, 26 Feb 2019 12:46:41 +0300
References: <201902230335.59138.randrianasulu@gmail.com>
	<201902261158.09086.randrianasulu@gmail.com>
	<e9d2cf10-0c52-a1b6-2be9-e396bd76cf2f@redhat.com>
In-Reply-To: <e9d2cf10-0c52-a1b6-2be9-e396bd76cf2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201902261246.41653.randrianasulu@gmail.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
Tuesday 26 February 2019 12:05:02 Thomas Huth =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB(=D0=B0):
> On 26/02/2019 09.58, Andrew Randrianasulu wrote:
> > =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Tuesday 26 February 2019 11:54:12 =D0=B2=D1=8B =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB=D0=B8:
> >> On 25/02/2019 18.29, Andrew Randrianasulu wrote:
> >>> =D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=
=D1=82 Monday 25 February 2019 19:19:01 Philippe
> >>> Mathieu-Daudc3a9
> >>>
> >>> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
> >>>> Hi Andrew,
> >>>>
> >>>> On 2/23/19 1:35 AM, Andrew Randrianasulu wrote:
> >>>>> Hello!
> >>>>>
> >>>>> I just pulled latest git
> >>>>
> >>>> [...]
> >>>>
> >>>>> and default build with simple ./configure on slackware 14.2 x86-64
> >>>>> box failed like this:
> >>>>>
> >>>>> root@slax:~/src/qemu# LANG=3DC make -j 5
> >>>>>         CHK version_gen.h
> >>>>>   CC      qobject/block-qdict.o
> >>>>>   CC      util/thread-pool.o
> >>>>>   CC      util/main-loop.o
> >>>>>   CC      util/qemu-timer.o
> >>>>>   CC      util/iohandler.o
> >>>>>   CC      util/aio-posix.o
> >>>>> qobject/block-qdict.c: In function 'qdict_array_split':
> >>>>> qobject/block-qdict.c:259:9: error: 'subqdict' may be used
> >>>>> uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >>>>>          qlist_append_obj(*dst, subqobj ?: QOBJECT(subqdict));
> >>>>>          ^
> >>>>
> >>>> That's odd, I can not reproduce with a simple ./configure:
> >>>>
> >>>> $ cat /etc/slackware-version
> >>>> Slackware 14.2
> >>>>
> >>>> $ gcc --version
> >>>> gcc (GCC) 5.5.0
> >>>
> >>> Well, then may be this is false positive, right now another qemu
> >>> instance is busy inside same chroot, will try patch posted in earlier
> >>> mail (after removing CFLAG I added for compiling qemu at all after th=
is
> >>> error).
> >>>
> >>> Thanks for trying to reproduce.
> >>
> >> Just to be sure: You don't compile with -O3 or -O1 or -O0 in the CFLAGS
> >> here, do you?
> >
> > This time  it was -O3, but I got some corruption in ppc64le guest's X, =
so
> > I plan to revert this -O3 back to default ....
>
> Ok, then that's the problem here: GCC often produces some additional
> "may be unused" warnings with -O3, and we normally only guarantee that
> QEMU compiles without warnings when using the standard -O2 optimization
> level.
> So if you want to compile with -O3, you also have to specify
> --disable-werror (or add -Wno-error=3Dmaybe-unitialized to the CFLAGS).
> But unless you have really an urgent need for O3, I'd rather recommend
> to compile with the well-tested O2 optimization level instead.

Ok, will do ....

I was hoping for some speed-up in (mt)tcg based machines, because compiling=
 big=20
programs inside qemu obviously not ultrafast.

3916 root      20   0 5442m 2.8g 3396 R  213 24.0   2758:40 qemu-system-ppc

from 'top' on host.

But then, soon-to-be 4.0 qemu should be faster in general due to all those =
tcg=20
optimizations, so -O3 really will be dropped on my side.

Still, I have more funny observations, like this blue screen with qemu's -v=
ga=20
virtio/cirrus was present even on 2.12+, but this probably offb bug (assume=
s BE=20
when compiled for power?) .

And=20
root@slax:~/src/qemu# qemu-system-ppc64 -m 2G -display sdl,gl=3Don -smp=20
3  -hda /mnt/alpine_disk.img -g 1120x832x24

somewhat resulted in 8-bit X display (xf86-video-fbdev over offb, i think. =
due=20
to 'nomodeset' default in alpine kernel - another reason to recompile {firs=
t=20
reason was es1370 audio device support} and alter some parameters..)=20

:)

In some sense this is cool, because I can see same problem with not loading=
 png=20
images into Cinelerra-GG itself, even on 8-bit display (without GLX and=20
composite), but may be it was not intended.

will look into offb's sources ...

also, -g 1186x864x32 resulted in funnuy diagonal corruption even at firmwar=
e=20
screen level, and probably same happening with x86-64/kvm guest if I select=
=20
some less comon, but exposed via xrandr mode. (this bit for -vga std, defau=
lt)

>
>  Thomas
