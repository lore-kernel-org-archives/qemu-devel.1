Received: from eggs.gnu.org ([2001:4830:134:3::10]:50615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dnWu8-0002HB-3i
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 17:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dnWu3-0008Ms-5m
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 17:21:36 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:32810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dnWu2-0008Md-Uy
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 17:21:31 -0400
Received: by mail-oi0-f46.google.com with SMTP id r203so7556481oih.0
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 14:21:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJTBuyhJgVZ-A+AHatjAwPjsSv2Q-HxuF7nc1NpbWNmGnCOhVQ@mail.gmail.com>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-3-Sergio.G.DelReal@gmail.com>
	<20170830140738.GS18526@redhat.com>
	<20170831074215.GA13619@stefanha-x1.localdomain>
	<CABgObfYRUtdH9-7+zWx5Zur=iE_Qr5953+EOgcxRfVGnEonbmg@mail.gmail.com>
	<CAJTBuyhJgVZ-A+AHatjAwPjsSv2Q-HxuF7nc1NpbWNmGnCOhVQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 Aug 2017 23:21:29 +0200
Message-ID: <CABgObfaDtgixAEF8OPLuDf=21GiCwY3EUOPHujXPeLqYTup=Yw@mail.gmail.com>
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
To: Izik Eidus <izik@veertu.com>
Cc: vpalatin@chromium.org, qemu-devel <qemu-devel@nongnu.org>, "Hajnoczi, Stefan" <stefanha@gmail.com>, sergio.g.delreal@gmail.com

Il 31 ago 2017 3:54 PM, "Izik Eidus" <izik@veertu.com> ha scritto:

> Izik, Vincent (assuming you are the right person to contact at Google),
> can you reply to Daniel and Stefan?
>

Hi,

What I suggest is that we will send our patch' again as gpl2+ and clean the
entire stuff to make sure they are falling into the right copyright
category as required by QEMU.


That's not necessary. Just you and Vincent replying to this thread with a
"Signed-off-by" line would be enough for Sergio to use the right license in
his v3 submission. Sergio already made some non-trivial changes that are
needed for inclusion in QEMU from a supportability (e.g. dirty page
tracking for graphics) or maintainability perspective (e.g. -cpu support),
so the simplest thing to do is to retrofit the right license to his
submission. You can do so if you can confirm that the code you used only
came from QEMU itself, Bochs or other GPLv2+/LGPL software (and the rest
was written by Veertu).

Google has already contributed the HAXN accelerator, so I am moderately
optimistic that they can help with HVF too.

BTW, another thing that need to be integrated in order to make this stuff
useful is the vmnet patch's, it is apple NAT for vms that allow guests to
have networking...


People can always use slirp (or tap with some more effort), so these
patches are already a minimum viable feature and pretty close to being
mergeable. But of course any other contribution is welcome!

Paolo


(altho that it come with a trick, without certificate it
will require root permission, while hypverisor framework itself can run
without root)

What do you guys think?


>
> Sergio worked on completing the QEMU port to Hypervisor.framework. The
> hvf-all.c file that Daniel pointed out as v2-only is derived from
kvm-all.c
> and hax-all.c, and should be under v2-or-later license. The others seem to
> be either original or derived from Bochs, which is LGPL, so they could be
> LGPL or GPLv2+.
>
> Thanks,
>
> Paolo
>
>
> There are benefits to having this code upstream.  If they ever want to
> rebase on qemu.git there will be less work for them.
>
> Stefan
>
>
>
