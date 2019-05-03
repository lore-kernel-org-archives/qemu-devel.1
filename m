Received: from eggs.gnu.org ([209.51.188.92]:45866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMX3B-0003Z3-Fe
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMX3A-0006cI-IL
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:12:25 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMX3A-0006bn-CH
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:12:24 -0400
Received: by mail-oi1-x242.google.com with SMTP id t70so4231363oif.5
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190315143057.20165-1-peter.maydell@linaro.org>
	<87sgvkw4vp.fsf@zen.linaroharston>
	<CAFEAcA_n2MvRfCdydianR9EgDxdP093+Fi-Co2WRa0ncAF=Pgg@mail.gmail.com>
In-Reply-To: <CAFEAcA_n2MvRfCdydianR9EgDxdP093+Fi-Co2WRa0ncAF=Pgg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 13:12:11 +0100
Message-ID: <CAFEAcA88dHzePhpOBdKFXr4HpF3J40FqY6qdwFpNhyBgxbehkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0?] arm: Allow system registers for
 KVM guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Eric Auger <eric.auger@redhat.com>

On Mon, 25 Mar 2019 at 10:25, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 18 Mar 2019 at 15:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
[...]
> > > Support this by making kvm_arch_put_registers() synchronize
> > > CPU state back into the list. We sync only those registers
> > > where the initial write succeeds, which should be sufficient.
> > >
> > > This commit is the same as commit 823e1b3818f9b10b824ddc which we
> > > had to revert in commit 942f99c825fc94c8b1a4, except that the bug
> > > which was preventing EDK2 guest firmware running has been fixed:
> > > kvm_arm_reset_vcpu() now calls write_list_to_cpustate().

> > > Should we try to put this in for rc1? Not sure... Testing
> > > definitely appreciated.
>
> > Hmm so running my testcase:
> >
> >  * gdbstub enabled with an active sw or hw breakpoint
> >  * run userspace program in guest:
> >    - sw breakpoint works fine
> >    - hw breakpoint never triggers because guest segs
>
> Further testing from Alex suggests this is some unrelated
> bug or regression (ie not caused by this patch), but:
> since the only in-tree use for this patch is to get nested
> debugging working and it would be broken for this other
> reason even with this patch, I'm going to postpone applying
> this patch until the start of the 4.1 cycle.

Since we're now in the 4.1 cycle I'm going to apply this
patch, as I suggested above -- I'm putting it into my
target-arm.next queue to go in in my next pullreq.

We should make sure we investigate the debugging-KVM
breakage Alex described at some point this cycle too.

thanks
-- PMM
