Received: from eggs.gnu.org ([2001:4830:134:3::10]:57498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1duHbc-0002GD-Jc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1duHbW-0002u5-Ad
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:26:24 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:44454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1duHbW-0002sz-2l
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:26:18 -0400
Received: by mail-pg0-x22e.google.com with SMTP id j16so1911625pga.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:26:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87bmm7dohw.fsf@linaro.org>
References: <CAPnv1PJeMRPKv9UUSmSWxyn=GFOPaWY8eUgH8ZeL=ZBMDJpbdg@mail.gmail.com>
	<CAJhHMCCZh7hvQT8x9Bks9k6=ka4G1Oybv1MrkKJ9_VZ_eRZBfQ@mail.gmail.com>
	<CAPnv1PL7-BAt36BvTxP7G8J8990Ur9MJJbr-QPccWziD4sy28g@mail.gmail.com>
	<87bmrj8eks.fsf@linaro.org>
	<CAPnv1PKyak1G-uL=H=-Vh_9TH2dZKffYjDf_2Z+LWuqovMKCBQ@mail.gmail.com>
	<CAKSfGUC_k6K=2Xy8pGcwuQ66DMPYCDvA47Ojgm7ntQfALGwDsQ@mail.gmail.com>
	<CAKSfGUD-FEb+DGwtrVHm2_NR_WOes9_+WkPm3Z76OPNhc3vbGA@mail.gmail.com>
	<000601d33128$2dd9d5e0$898d81a0$@ru> <87bmm7dohw.fsf@linaro.org>
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Tue, 19 Sep 2017 15:26:14 +0300
Message-ID: <CAKSfGUCt7p95nDeW12Q_-BSTXVhRLPtL+=u_WLx5_BZEgAgeLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] What is the best commit for record-replay?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, Pranith Kumar <bobby.prani+qemu@gmail.com>, pavel.dovgaluk@ispras.ru, Aleksandr Bezzubikov <abezzubikov@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, Igor R <boost.lists@gmail.com>

2017-09-19 12:30 GMT+03:00 Alex Benn=C3=A9e <alex.bennee@linaro.org>:
>
> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>
>>> From: Aleksandr Bezzubikov [mailto:zuban32s@gmail.com]
>>> 2017-09-18 15:02 GMT+03:00 Aleksandr Bezzubikov <zuban32s@gmail.com>:
>>> > 2017-05-02 15:42 GMT+03:00 Igor R <boost.lists@gmail.com>:
>>> >>>>>> I'm trying to use the deterministic record/replay feature, and I=
 would
>>> >>>>>> like to know which commit I should take to get it work.
>>> >>>>>> In RC0 it seems to be broken. I tried pre-MTTCG commit 2421f381d=
c, as
>>> >>>>
>>> >>>>> Can you retry with the latest rc? There were some fixes regarding=
 rr since rc0.
>>> >>>>
>>> >>>>
>>> >>>> I've taken 2.9 release, and RR does not seem to work there.
>>> >>>> I recorded the boot process of x86 Fedora-21 linux and the replay =
got
>>> >>>> stuck almost immediately.
>>> >>>
>>> >>> What's your command line?
>>> >>>
>>> >>> Does it get stuck at the same place each time?
>>> >>>
>>> >>> Can you boot fine with icount but without record/replay?
>>> >>
>>> >> Here is the exact scenario:
>>> >> - Get 2.9 from git, configure it as follows: "./configure
>>> >> --target-list=3Di386-softmmu --enable-sdl" and  make.
>>> >> - Download https://people.debian.org/~aurel32/qemu/i386/debian_squee=
ze_i386_standard.qcow2
>>> >> - Run qemu with the following command line, until login prompt:
>>> >> -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin -drive
>>> >> file=3Ddebian_squeeze_i386_standard.qcow2,if=3Dnone,id=3Dimg-direct =
-drive
>>> >> driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay -=
device
>>> >> ide-hd,drive=3Dimg-blkreplay -monitor stdio
>>> >> - Replay: -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin -drive
>>> >> file=3Ddebian_squeeze_i386_standard.qcow2,if=3Dnone,id=3Dimg-direct =
-drive
>>> >> driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay -=
device
>>> >> ide-hd,drive=3Dimg-blkreplay -monitor stdio
>>> >>
>>> >> Every time I attempt to replay, QEMU gets stuck at the same EIP, at =
a
>>> >> very early stage.
>>> >>
>>> >>
>>> >>> Can you boot fine with icount but without record/replay?
>>> >>
>>> >> Yes. I can also enable icount and recording - it also boots fine. Th=
e
>>> >> problem with the replay.
>>> >
>>> > Hi guys,
>>> > Maybe the thread is a bit outdated, but the problem is still relevant=
.
>>> > I've just tried to record and replay WinXP boot process, and I've enc=
ountered
>>> > exactly the same problem as described above - record is fine, replay
>>> > gets stuck early. I use current master.
>>
>> Maybe this commit will work: cfb2d02be9413d45b30ed6d8e38800250b6b4b48

Unfortunately this one doesn't work either. It seems we need just an
all-in-one fix
for the current implementation to make it work.

>>
>>> > And I've discovered the second problem - recording makes initial snap=
shot,
>>> > but it doesn't seem to be saved to the disk - replay can't see it.
>>
>> It is ok, because there is a mode where snapshot is created and loaded.

So it shouldn't work properly when I use 'rrsnapshot=3D<name>' for both
record and replay?
Then how can I enable this mode?

>>
>>> >
>>> > Hope you've already found the solution (as the last post was on 2 May=
)
>>> > and it's just got missed the mailing list.
>>
>> As I know, RR is still broken in the current version.
>> It was caused by the MTTCG implementation.
>> Alex Bennee tried to fix RR back. Alex, have you found any solution?
>>
>> We also trying to find a way to fix RR. It seems, that we will reinvent =
BQL for RR.
>
> I think the method outlined in my RFC is the way to go, essentially the
> RR mutex taking over for the what the BQL did. The RFC patch hadn't
> hoisted the mutex for the additional devices so I'm just re-basing now
> and I'll see if I can make the changes for Igor's test case.
>
> --
> Alex Benn=C3=A9e



--=20
Aleksandr Bezzubikov
