Received: from eggs.gnu.org ([2001:4830:134:3::10]:52941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1doOJN-0007U2-W8
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 02:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1doOJH-0002Fj-8U
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 02:23:12 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1doOJH-0002FH-1Z
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 02:23:07 -0400
Received: by mail-oi0-f52.google.com with SMTP id n18so26385660oig.2
	for <qemu-devel@nongnu.org>; Sat, 02 Sep 2017 23:23:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJTBuyhCg1YMShp4W72eHzYh0jcOC3e9NhY7iv=sJv6iMaPe6w@mail.gmail.com>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-3-Sergio.G.DelReal@gmail.com>
	<20170830140738.GS18526@redhat.com>
	<20170831074215.GA13619@stefanha-x1.localdomain>
	<CABgObfYRUtdH9-7+zWx5Zur=iE_Qr5953+EOgcxRfVGnEonbmg@mail.gmail.com>
	<CAJTBuyhJgVZ-A+AHatjAwPjsSv2Q-HxuF7nc1NpbWNmGnCOhVQ@mail.gmail.com>
	<CABgObfaDtgixAEF8OPLuDf=21GiCwY3EUOPHujXPeLqYTup=Yw@mail.gmail.com>
	<CAMzKsXuvdroUvT=6rjeTtM+FKHz6pat9Fgby5ayF_dZp9qaQaw@mail.gmail.com>
	<CAJTBuyhCg1YMShp4W72eHzYh0jcOC3e9NhY7iv=sJv6iMaPe6w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 3 Sep 2017 08:23:04 +0200
Message-ID: <CABgObfb_HCGjE7gfU8Jeu3WofiRQOQqt8rBVC7ws46V2gDX2Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: vpalatin@chromium.org, qemu-devel <qemu-devel@nongnu.org>, "Hajnoczi, Stefan" <stefanha@gmail.com>, =?UTF-8?Q?Sergio_Andr=C3=A9s_G=C3=B3mez_del_Real?= <sergio.g.delreal@gmail.com>, Frank Yang <lfy@google.com>

Il 01 set 2017 7:59 PM, "Izik Eidus" <izik@veertu.com> ha scritto:

Hi,

Sergio, I was trying to applying patch  1/13 and 2/13 and then I ran:
./configure and saw: 'HVF support       yes'
after that 'make' was happy
and:

./x86_64-softmmu/qemu-system-x86_64 --help | grep accel

\                property accel=3Daccel1[:accel2[:...]] selects accelerator

                supported accelerators are kvm, xen, hax, hvf or tcg
(default: tcg)

                kernel_irqchip=3Don|off|split controls accelerated irqchip
support (default=3Doff)


however:

./x86_64-softmmu/qemu-system-x86_64 -cdrom
/Users/izik/Downloads/ubuntu-16.04.3-desktop-amd64.iso -machine
q35,accel=3Dhvf

qemu-system-x86_64: -machine accel=3Dhvf: No accelerator found


What am I doing wrong?


Try applying patch 3 too. Most of the early patches will end up squashed.

Paolo


Thanks.




On Fri, Sep 1, 2017 at 12:41 AM, Sergio Andr=C3=A9s G=C3=B3mez del Real <
sergio.g.delreal@gmail.com> wrote:

> Hello,
> Mr. Frank Yang was the guy at Google that introduced the HVF port to
> Google's Android Emulator QEMU branch.
> Frank, in this thread we are discussing the licensing issue with the HVF
> files (their being GPL v2-only). Paolo from Red Hat was asking to Veertu
> developer Izik Eidus if the code in Veertu derived only from QEMU, Bochs
> and other GPLv2+ or LGPL software. Because the code at Google was itself
> derived from Veertu, I'd imagine the same licensing terms would apply in
> your case. Any light you can throw over this issue would be much
> appreciated.
>
> Thank you.
>
> On Thu, Aug 31, 2017 at 4:21 PM, Paolo Bonzini <pbonzini@redhat.com>
> wrote:
>
>> Il 31 ago 2017 3:54 PM, "Izik Eidus" <izik@veertu.com> ha scritto:
>>
>> > Izik, Vincent (assuming you are the right person to contact at Google)=
,
>> > can you reply to Daniel and Stefan?
>> >
>>
>> Hi,
>>
>> What I suggest is that we will send our patch' again as gpl2+ and clean
>> the
>> entire stuff to make sure they are falling into the right copyright
>> category as required by QEMU.
>>
>>
>> That's not necessary. Just you and Vincent replying to this thread with =
a
>> "Signed-off-by" line would be enough for Sergio to use the right license
in
>> his v3 submission. Sergio already made some non-trivial changes that are
>> needed for inclusion in QEMU from a supportability (e.g. dirty page
>> tracking for graphics) or maintainability perspective (e.g. -cpu
support),
>> so the simplest thing to do is to retrofit the right license to his
>> submission. You can do so if you can confirm that the code you used only
>> came from QEMU itself, Bochs or other GPLv2+/LGPL software (and the rest
>> was written by Veertu).
>>
>> Google has already contributed the HAXN accelerator, so I am moderately
>> optimistic that they can help with HVF too.
>>
>> BTW, another thing that need to be integrated in order to make this stuf=
f
>> useful is the vmnet patch's, it is apple NAT for vms that allow guests t=
o
>> have networking...
>>
>>
>> People can always use slirp (or tap with some more effort), so these
>> patches are already a minimum viable feature and pretty close to being
>> mergeable. But of course any other contribution is welcome!
>>
>> Paolo
>>
>>
>> (altho that it come with a trick, without certificate it
>> will require root permission, while hypverisor framework itself can run
>> without root)
>>
>> What do you guys think?
>>
>>
>> >
>> > Sergio worked on completing the QEMU port to Hypervisor.framework. The
>> > hvf-all.c file that Daniel pointed out as v2-only is derived from
>> kvm-all.c
>> > and hax-all.c, and should be under v2-or-later license. The others see=
m
>> to
>> > be either original or derived from Bochs, which is LGPL, so they could
>> be
>> > LGPL or GPLv2+.
>> >
>> > Thanks,
>> >
>> > Paolo
>> >
>> >
>> > There are benefits to having this code upstream.  If they ever want to
>> > rebase on qemu.git there will be less work for them.
>> >
>> > Stefan
>> >
>> >
>> >
>>
>>
>>
>
