Received: from eggs.gnu.org ([2001:4830:134:3::10]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <izik@veertu.com>) id 1dnXfu-0006kV-KT
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 18:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <izik@veertu.com>) id 1dnXfs-0006vF-RZ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 18:10:58 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <izik@veertu.com>) id 1dnXfs-0006uj-Ff
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 18:10:56 -0400
Received: by mail-wm0-x235.google.com with SMTP id v2so5652145wmf.0
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 15:10:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEkmjvVmHJfgtek9XDb77n12B-cV4=hLNJ66zQBLwOGDg6gUHQ@mail.gmail.com>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-3-Sergio.G.DelReal@gmail.com>
	<20170830140738.GS18526@redhat.com>
	<20170831074215.GA13619@stefanha-x1.localdomain>
	<CABgObfYRUtdH9-7+zWx5Zur=iE_Qr5953+EOgcxRfVGnEonbmg@mail.gmail.com>
	<CAJTBuyhJgVZ-A+AHatjAwPjsSv2Q-HxuF7nc1NpbWNmGnCOhVQ@mail.gmail.com>
	<CABgObfaDtgixAEF8OPLuDf=21GiCwY3EUOPHujXPeLqYTup=Yw@mail.gmail.com>
	<CAMzKsXuvdroUvT=6rjeTtM+FKHz6pat9Fgby5ayF_dZp9qaQaw@mail.gmail.com>
	<CAEkmjvVmHJfgtek9XDb77n12B-cV4=hLNJ66zQBLwOGDg6gUHQ@mail.gmail.com>
From: Izik Eidus <izik@veertu.com>
Date: Fri, 1 Sep 2017 01:10:54 +0300
Message-ID: <CAJTBuyj96Jd5Ys43sqVTR2y-Q2y-jRqSovHxRtQKGKKfezfZhg@mail.gmail.com>
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
To: Frank Yang <lfy@google.com>
Cc: =?UTF-8?Q?Sergio_Andr=C3=A9s_G=C3=B3mez_del_Real?= <sergio.g.delreal@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, vpalatin@chromium.org, qemu-devel <qemu-devel@nongnu.org>, "Hajnoczi,
	Stefan" <stefanha@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, "J. Eason" <easonj@google.com>

On Fri, Sep 1, 2017 at 1:02 AM, Frank Yang <lfy@google.com> wrote:

> + our product manager
>
> If I understand correctly, we will need to reconsider things if I include=
d
> any additional technology in my port. However, I didn't include any
> additional references/source in my port compared to Veertu, that was not =
in
> the qemu code already (e.g., hax-all/kvm-all) so I think we can just chan=
ge
> the QEMU upstream port to use gplv2+.
>
> Izik, are you ok with this assessment?
>

Yes we are fine with changing everything to GPLv2+, I am just going over
the code and confirm that all copyright attributions as I saw a file that
was missing Bochs LGPLv2 copyright.



>
> On Thu, Aug 31, 2017 at 2:41 PM, Sergio Andr=C3=A9s G=C3=B3mez del Real <
> sergio.g.delreal@gmail.com> wrote:
>
>> Hello,
>> Mr. Frank Yang was the guy at Google that introduced the HVF port to
>> Google's Android Emulator QEMU branch.
>> Frank, in this thread we are discussing the licensing issue with the HVF
>> files (their being GPL v2-only). Paolo from Red Hat was asking to Veertu
>> developer Izik Eidus if the code in Veertu derived only from QEMU, Bochs
>> and other GPLv2+ or LGPL software. Because the code at Google was itself
>> derived from Veertu, I'd imagine the same licensing terms would apply in
>> your case. Any light you can throw over this issue would be much
>> appreciated.
>>
>> Thank you.
>>
>> On Thu, Aug 31, 2017 at 4:21 PM, Paolo Bonzini <pbonzini@redhat.com>
>> wrote:
>>
>>> Il 31 ago 2017 3:54 PM, "Izik Eidus" <izik@veertu.com> ha scritto:
>>>
>>> > Izik, Vincent (assuming you are the right person to contact at Google=
),
>>> > can you reply to Daniel and Stefan?
>>> >
>>>
>>> Hi,
>>>
>>> What I suggest is that we will send our patch' again as gpl2+ and clean
>>> the
>>> entire stuff to make sure they are falling into the right copyright
>>> category as required by QEMU.
>>>
>>>
>>> That's not necessary. Just you and Vincent replying to this thread with
>>> a "Signed-off-by" line would be enough for Sergio to use the right lice=
nse
>>> in his v3 submission. Sergio already made some non-trivial changes that=
 are
>>> needed for inclusion in QEMU from a supportability (e.g. dirty page
>>> tracking for graphics) or maintainability perspective (e.g. -cpu suppor=
t),
>>> so the simplest thing to do is to retrofit the right license to his
>>> submission. You can do so if you can confirm that the code you used onl=
y
>>> came from QEMU itself, Bochs or other GPLv2+/LGPL software (and the res=
t
>>> was written by Veertu).
>>>
>>> Google has already contributed the HAXN accelerator, so I am moderately
>>> optimistic that they can help with HVF too.
>>>
>>> BTW, another thing that need to be integrated in order to make this stu=
ff
>>> useful is the vmnet patch's, it is apple NAT for vms that allow guests =
to
>>> have networking...
>>>
>>>
>>> People can always use slirp (or tap with some more effort), so these
>>> patches are already a minimum viable feature and pretty close to being
>>> mergeable. But of course any other contribution is welcome!
>>>
>>
> That's what we do with networking in HVF for android emulator, btw; use
> slirp.
>


Yes, you guys can use our vmnet implemantion together proxy that we are
having to allow to run it without root, I think this proxy is making sense
for the android users as they won't required root, but for QEMU I think
only the vmnet implemantion will be wanted.
after this stuff will get merged we will send the vmnet stuff as GPLv2+ as
now it is GPLv2/GPLv3.

(BTW, I am pretty sure the copyright message that include GPLv2/GPLv3 and
created all this mess was taken from QEMU itself ... :))


>
>
>>
>>> Paolo
>>>
>>>
>>> (altho that it come with a trick, without certificate it
>>> will require root permission, while hypverisor framework itself can run
>>> without root)
>>>
>>> What do you guys think?
>>>
>>>
>>> >
>>> > Sergio worked on completing the QEMU port to Hypervisor.framework. Th=
e
>>> > hvf-all.c file that Daniel pointed out as v2-only is derived from
>>> kvm-all.c
>>> > and hax-all.c, and should be under v2-or-later license. The others
>>> seem to
>>> > be either original or derived from Bochs, which is LGPL, so they coul=
d
>>> be
>>> > LGPL or GPLv2+.
>>> >
>>> > Thanks,
>>> >
>>> > Paolo
>>> >
>>> >
>>> > There are benefits to having this code upstream.  If they ever want t=
o
>>> > rebase on qemu.git there will be less work for them.
>>> >
>>> > Stefan
>>> >
>>> >
>>> >
>>>
>>>
>>>
>>
>
