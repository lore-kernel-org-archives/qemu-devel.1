Received: from eggs.gnu.org ([2001:4830:134:3::10]:39427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <izik@veertu.com>) id 1dpaOB-00018z-AW
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <izik@veertu.com>) id 1dpaO5-0006vD-4I
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:29:07 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <izik@veertu.com>) id 1dpaO4-0006u3-Q3
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:29:01 -0400
Received: by mail-wm0-x22c.google.com with SMTP id 187so31036511wmn.1
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 06:28:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABgObfYv7GCbjhtCe0e=+MJH0dw_sfqhT6RxaeL9M6vRwKRFwg@mail.gmail.com>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-3-Sergio.G.DelReal@gmail.com>
	<20170830140738.GS18526@redhat.com>
	<20170831074215.GA13619@stefanha-x1.localdomain>
	<CABgObfYRUtdH9-7+zWx5Zur=iE_Qr5953+EOgcxRfVGnEonbmg@mail.gmail.com>
	<CAJTBuyhJgVZ-A+AHatjAwPjsSv2Q-HxuF7nc1NpbWNmGnCOhVQ@mail.gmail.com>
	<CABgObfaDtgixAEF8OPLuDf=21GiCwY3EUOPHujXPeLqYTup=Yw@mail.gmail.com>
	<CAJTBuyhKqbXWjphh-t60TVjZfVFEYGyWFgEs4TmR+CE1q04GhQ@mail.gmail.com>
	<CAJTBuyhvCySRHvrKMOW7fvjuogTUUUXi4QRjiJrrzfu-gbb5jQ@mail.gmail.com>
	<CABgObfYAH3xtVO0mZCBiVnE5m=p_BqiopGJtovzL1LFBN0366Q@mail.gmail.com>
	<CAJTBuyg2Q43RhiVo1KuYL6uKZG3ztt5j09oeEoOk5h8r16hjeA@mail.gmail.com>
	<CABgObfaDuLvaxpb-GmefsNcoUsjJi3y_oAnfYuQU8LQcGtx9zQ@mail.gmail.com>
	<CABgObfYx+uP2gmsT4SfagM-kZre-8RieyMQ21yOEcLOp38WaNg@mail.gmail.com>
	<CAJTBuyj7rQgOUBZRb1p4JdSbSFbTLDJM6suArdpD3myug79WEQ@mail.gmail.com>
	<CABgObfZTRAF7NJea=-SyNy67ZXFZVgoQLRjgswvPSs14euq+zw@mail.gmail.com>
	<CABgObfYv7GCbjhtCe0e=+MJH0dw_sfqhT6RxaeL9M6vRwKRFwg@mail.gmail.com>
From: Izik Eidus <izik@veertu.com>
Date: Wed, 6 Sep 2017 16:28:56 +0300
Message-ID: <CAJTBuyiG6V+N2WNEqopbRvJHPX4W5pgjU4k1_A8u+u1axy7Vqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 02/13] hvf: add code base from Google's
 QEMU repository
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, vpalatin@chromium.org, "Hajnoczi, Stefan" <stefanha@gmail.com>, =?UTF-8?Q?Sergio_Andr=C3=A9s_G=C3=B3mez_del_Real?= <sergio.g.delreal@gmail.com>

On Mon, Sep 4, 2017 at 9:47 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
>
> Il 03 set 2017 8:49 PM, "Izik Eidus" <izik@veertu.com> ha scritto:
>
> For now i want to get hypervisor framework merged into QEMU in required license. I did offer to open source everything needed from anka to the make QEMU being able to run any os using hypervisor.framework.
>
>
> Having such code as open source will certainly help anyone who is going to work more on QEMU HVF so it would be great.
>
> Sergio, in the meanwhile can you post v3 with an extra patch after 2/13 that:
>
> - moves the task switch code to a new file with v2-only header
>
> - changes all v2-only or v2-v3 headers in HVF files to v2-or-later


Hi,

Paolo, I was reviewing more and more our code and found another issue
regarding licensing of gpl2v+:
the file x86_descr.c include:
#define VMX_SEGMENT_FIELD(seg) that is coming from KVM that is gpl2 code.
unfortunately we had a developer that introduced both this code and
the task_switch, I am reviewing more and more this now to find if we
have any other gpl2v only in our code.

Maybe it does worth to reconsider us donating hypervisor.framework
implemantion that will be clean from such gpl2v only issue? I know it
will slow little bit the integration but we are willing to put all the
effort that is needed, including syncing all Sergio later on patch's
and whatever is needed more.

Thanks.

>
>
> Then Izik and Frank can reply with their Signed-off-by to that extra patch.
>
> Thanks,
>
> Paolo
>
>
>
> >
> > I think it's safe to use v2+ for this code once Google agrees. The task
> > switch code, which is going to go away soon anyway and is isolated from the
> > rest, can be moved to a separate file for the time being.
> >
>
>
> OK, such case would be simpler to me to go if this what you prefer, in such
> case, i will send the 1|2|3 patches splited from task switch and
> everything  beside task switch as gpl2v+.
>
> Whatever you guys decide...
>
> Thanks.
>
>
> >
> > Paolo
> >
> >
> > >
> > > Paolo
> > >
> > > in
> > > such case all copyright go back to BSD2 and we can license it as GPL2v+
> > or
> > > whatever work for QEMU.
> > > If you want to go in such case what we will do would be the following:
> > > take kvm user space implemantion of qemu that is GPLv2+, integrate to it
> > > the hypervisor framework from Anka (in kvm user space style) - this will
> > > put us in hvf [1|2|3 / 13] in safe GPLv2+ and then we can back port the
> > > rest of Sergio changes to this stuff.
> > >
> > > I know this is less than ideal as it requires some changes to the current
> > > patch set, however it will make it 100% safe to be GPL2v+, what you guys
> > > think?, we can get this stuff done before the end of this week...
> > >
> > > Thanks.
> > >
> > >
> > > On Fri, Sep 1, 2017 at 12:39 AM, Izik Eidus <izik@veertu.com
> > <javascript:_e(%7B%7D,'cvml','izik@veertu.com');>> wrote:
> > >
> > > >
> > > >
> > > > On Fri, Sep 1, 2017 at 12:21 AM, Paolo Bonzini <pbonzini@redhat.com
> > <javascript:_e(%7B%7D,'cvml','pbonzini@redhat.com');>>
> > > > wrote:
> > > >
> > > >> Il 31 ago 2017 3:54 PM, "Izik Eidus" <izik@veertu.com
> > <javascript:_e(%7B%7D,'cvml','izik@veertu.com');>> ha scritto:
>
> > > >>
> > > >> > Izik, Vincent (assuming you are the right person to contact at
> > > Google),
> > > >> > can you reply to Daniel and Stefan?
> > > >> >
> > > >>
> > > >> Hi,
> > > >>
> > > >> What I suggest is that we will send our patch' again as gpl2+ and
> > clean
> > > >> the
> > > >> entire stuff to make sure they are falling into the right copyright
> > > >> category as required by QEMU.
> > > >>
> > > >>
> > > >> That's not necessary. Just you and Vincent replying to this thread
> > with
> > > a
> > > >> "Signed-off-by" line would be enough for Sergio to use the right
> > > license in
> > > >> his v3 submission. Sergio already made some non-trivial changes that
> > are
> > > >> needed for inclusion in QEMU from a supportability (e.g. dirty page
> > > >> tracking for graphics) or maintainability perspective (e.g. -cpu
> > > support),
> > > >> so the simplest thing to do is to retrofit the right license to his
> > > >> submission. You can do so if you can confirm that the code you used
> > only
> > > >> came from QEMU itself, Bochs or other GPLv2+/LGPL software (and the
> > rest
> > > >> was written by Veertu).
> > > >>
> > > >
> > > > Hi,
> > > >
> > > > Sure fine with us, let me go over all the code and see that all
> > copyright
> > > > that are needed are there, and then you can relicense all our code to
> > > > GPLv2+, I think I saw a a file that was missing Bochs copyright in it,
> > > so I
> > > > want to make sure that I fix this before and that all others are fine.
> > > >
> > > > Thanks.
> > > >
> > > >
> > > >>
> > > >> Google has already contributed the HAXN accelerator, so I am
> > moderately
> > > >> optimistic that they can help with HVF too.
> > > >>
> > > >> BTW, another thing that need to be integrated in order to make this
> > > stuff
> > > >> useful is the vmnet patch's, it is apple NAT for vms that allow guests
> > > to
> > > >> have networking...
> > > >>
> > > >>
> > > >> People can always use slirp (or tap with some more effort), so these
> > > >> patches are already a minimum viable feature and pretty close to being
> > > >> mergeable. But of course any other contribution is welcome!
> > > >>
> > > >> Paolo
> > > >>
> > > >>
> > > >> (altho that it come with a trick, without certificate it
> > > >> will require root permission, while hypverisor framework itself can
> > run
> > > >> without root)
> > > >>
> > > >> What do you guys think?
> > > >>
> > > >>
> > > >> >
> > > >> > Sergio worked on completing the QEMU port to Hypervisor.framework.
> > The
> > > >> > hvf-all.c file that Daniel pointed out as v2-only is derived from
> > > >> kvm-all.c
> > > >> > and hax-all.c, and should be under v2-or-later license. The others
> > > seem
> > > >> to
> > > >> > be either original or derived from Bochs, which is LGPL, so they
> > could
> > > >> be
> > > >> > LGPL or GPLv2+.
> > > >> >
> > > >> > Thanks,
> > > >> >
> > > >> > Paolo
> > > >> >
> > > >> >
> > > >> > There are benefits to having this code upstream.  If they ever want
> > to
> > > >> > rebase on qemu.git there will be less work for them.
> > > >>
> > > >>
> > > OK,
> > >
> > >
> > > > >
> > > >> > Stefan
> > > >> >
> > > >> >
> > > >> >
> > > >>
> > > >>
> > > >>
> > > >
> > >
> > >
> > >
> >
> >
> >
>
>
