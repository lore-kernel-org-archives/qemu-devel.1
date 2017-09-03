Received: from eggs.gnu.org ([2001:4830:134:3::10]:43363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <izik@veertu.com>) id 1doKch-0003jv-OY
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 22:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <izik@veertu.com>) id 1doKcc-0008LQ-Lu
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 22:26:55 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <izik@veertu.com>) id 1doKcc-0008J9-BC
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 22:26:50 -0400
Received: by mail-wr0-x22d.google.com with SMTP id r64so2588209wrb.1
	for <qemu-devel@nongnu.org>; Sat, 02 Sep 2017 19:26:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABgObfaDtgixAEF8OPLuDf=21GiCwY3EUOPHujXPeLqYTup=Yw@mail.gmail.com>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-3-Sergio.G.DelReal@gmail.com>
	<20170830140738.GS18526@redhat.com>
	<20170831074215.GA13619@stefanha-x1.localdomain>
	<CABgObfYRUtdH9-7+zWx5Zur=iE_Qr5953+EOgcxRfVGnEonbmg@mail.gmail.com>
	<CAJTBuyhJgVZ-A+AHatjAwPjsSv2Q-HxuF7nc1NpbWNmGnCOhVQ@mail.gmail.com>
	<CABgObfaDtgixAEF8OPLuDf=21GiCwY3EUOPHujXPeLqYTup=Yw@mail.gmail.com>
From: Izik Eidus <izik@veertu.com>
Date: Sun, 3 Sep 2017 05:26:47 +0300
Message-ID: <CAJTBuyhrtaAr2zsLn+UqeVTmrON-hAigtKzB5VNByVQ1pjo1oA@mail.gmail.com>
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
Cc: vpalatin@chromium.org, qemu-devel <qemu-devel@nongnu.org>, "Hajnoczi, Stefan" <stefanha@gmail.com>, =?UTF-8?Q?Sergio_Andr=C3=A9s_G=C3=B3mez_del_Real?= <sergio.g.delreal@gmail.com>

On Fri, Sep 1, 2017 at 12:21 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:

> Il 31 ago 2017 3:54 PM, "Izik Eidus" <izik@veertu.com> ha scritto:
>
> > Izik, Vincent (assuming you are the right person to contact at Google),
> > can you reply to Daniel and Stefan?
> >
>
> Hi,
>
> What I suggest is that we will send our patch' again as gpl2+ and clean the
> entire stuff to make sure they are falling into the right copyright
> category as required by QEMU.
>
>
> That's not necessary. Just you and Vincent replying to this thread with a
> "Signed-off-by" line would be enough for Sergio to use the right license in
> his v3 submission. Sergio already made some non-trivial changes that are
> needed for inclusion in QEMU from a supportability (e.g. dirty page
> tracking for graphics) or maintainability perspective (e.g. -cpu support),
> so the simplest thing to do is to retrofit the right license to his
> submission. You can do so if you can confirm that the code you used only
> came from QEMU itself, Bochs or other GPLv2+/LGPL software (and the rest
> was written by Veertu).
>


Hi,

I found 2 functions that can't be licensed as GPLv2+ (only GPLv2) they are
very insignificant and one of them is never being called, As soon as Sergio
reply to me about what I am missing in getting 1/13 and 2/13 patch's to
work, I will send 2/13 again acked by me with full GPLv2+ license code
(without the GPLv2 code) from Veertu and then Google have to approve as
well.

Thanks.


>
> Google has already contributed the HAXN accelerator, so I am moderately
> optimistic that they can help with HVF too.
>
> BTW, another thing that need to be integrated in order to make this stuff
> useful is the vmnet patch's, it is apple NAT for vms that allow guests to
> have networking...
>
>
> People can always use slirp (or tap with some more effort), so these
> patches are already a minimum viable feature and pretty close to being
> mergeable. But of course any other contribution is welcome!
>
> Paolo
>
>
> (altho that it come with a trick, without certificate it
> will require root permission, while hypverisor framework itself can run
> without root)
>
> What do you guys think?
>
>
> >
> > Sergio worked on completing the QEMU port to Hypervisor.framework. The
> > hvf-all.c file that Daniel pointed out as v2-only is derived from
> kvm-all.c
> > and hax-all.c, and should be under v2-or-later license. The others seem
> to
> > be either original or derived from Bochs, which is LGPL, so they could be
> > LGPL or GPLv2+.
> >
> > Thanks,
> >
> > Paolo
> >
> >
> > There are benefits to having this code upstream.  If they ever want to
> > rebase on qemu.git there will be less work for them.
> >
> > Stefan
> >
> >
> >
>
>
>
