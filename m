Received: from eggs.gnu.org ([2001:4830:134:3::10]:53267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abezzubikov@ispras.ru>) id 1duKjf-00044t-L2
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abezzubikov@ispras.ru>) id 1duKjc-0001Wt-4R
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:46:55 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51858)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abezzubikov@ispras.ru>) id 1duKjb-0001VX-Nt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:46:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 19 Sep 2017 18:46:48 +0300
From: Alexander Bezzubikov <abezzubikov@ispras.ru>
In-Reply-To: <878thaepe2.fsf@linaro.org>
References: <CAPnv1PJeMRPKv9UUSmSWxyn=GFOPaWY8eUgH8ZeL=ZBMDJpbdg@mail.gmail.com>
	<CAJhHMCCZh7hvQT8x9Bks9k6=ka4G1Oybv1MrkKJ9_VZ_eRZBfQ@mail.gmail.com>
	<CAPnv1PL7-BAt36BvTxP7G8J8990Ur9MJJbr-QPccWziD4sy28g@mail.gmail.com>
	<87bmrj8eks.fsf@linaro.org>
	<CAPnv1PKyak1G-uL=H=-Vh_9TH2dZKffYjDf_2Z+LWuqovMKCBQ@mail.gmail.com>
	<CAKSfGUC_k6K=2Xy8pGcwuQ66DMPYCDvA47Ojgm7ntQfALGwDsQ@mail.gmail.com>
	<CAKSfGUD-FEb+DGwtrVHm2_NR_WOes9_+WkPm3Z76OPNhc3vbGA@mail.gmail.com>
	<000601d33128$2dd9d5e0$898d81a0$@ru> <87bmm7dohw.fsf@linaro.org>
	<CAKSfGUCt7p95nDeW12Q_-BSTXVhRLPtL+=u_WLx5_BZEgAgeLw@mail.gmail.com>
	<878thaepe2.fsf@linaro.org>
Message-ID: <b2bbaf4fcf6edca6bf7799c4e8670ef2@ispras.ru>
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
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Aleksandr Bezzubikov <zuban32s@gmail.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, Pranith Kumar <bobby.prani+qemu@gmail.com>, pavel.dovgaluk@ispras.ru, Paolo Bonzini <pbonzini@redhat.com>, Igor R <boost.lists@gmail.com>

Alex Benn=C3=A9e =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-09-19 17:25:
> Aleksandr Bezzubikov <zuban32s@gmail.com> writes:
>=20
>> 2017-09-19 12:30 GMT+03:00 Alex Benn=C3=A9e <alex.bennee@linaro.org>:
>>>=20
>>> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>>=20
>>>>> From: Aleksandr Bezzubikov [mailto:zuban32s@gmail.com]
>>>>> 2017-09-18 15:02 GMT+03:00 Aleksandr Bezzubikov=20
>>>>> <zuban32s@gmail.com>:
>>>>> > 2017-05-02 15:42 GMT+03:00 Igor R <boost.lists@gmail.com>:
>>>>> >>>>>> I'm trying to use the deterministic record/replay feature, a=
nd I would
>>>>> >>>>>> like to know which commit I should take to get it work.
>>>>> >>>>>> In RC0 it seems to be broken. I tried pre-MTTCG commit 2421f=
381dc, as
>>>>> >>>>
>>>>> >>>>> Can you retry with the latest rc? There were some fixes regar=
ding rr since rc0.
>>>>> >>>>
>>>>> >>>>
>>>>> >>>> I've taken 2.9 release, and RR does not seem to work there.
>>>>> >>>> I recorded the boot process of x86 Fedora-21 linux and the rep=
lay got
>>>>> >>>> stuck almost immediately.
>>>>> >>>
>>>>> >>> What's your command line?
>>>>> >>>
>>>>> >>> Does it get stuck at the same place each time?
>>>>> >>>
>>>>> >>> Can you boot fine with icount but without record/replay?
>>>>> >>
>>>>> >> Here is the exact scenario:
>>>>> >> - Get 2.9 from git, configure it as follows: "./configure
>>>>> >> --target-list=3Di386-softmmu --enable-sdl" and  make.
>>>>> >> - Download https://people.debian.org/~aurel32/qemu/i386/debian_s=
queeze_i386_standard.qcow2
>>>>> >> - Run qemu with the following command line, until login prompt:
>>>>> >> -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin -drive
>>>>> >> file=3Ddebian_squeeze_i386_standard.qcow2,if=3Dnone,id=3Dimg-dir=
ect -drive
>>>>> >> driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkrepl=
ay -device
>>>>> >> ide-hd,drive=3Dimg-blkreplay -monitor stdio
>>>>> >> - Replay: -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin -dri=
ve
>>>>> >> file=3Ddebian_squeeze_i386_standard.qcow2,if=3Dnone,id=3Dimg-dir=
ect -drive
>>>>> >> driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkrepl=
ay -device
>>>>> >> ide-hd,drive=3Dimg-blkreplay -monitor stdio
>>>>> >>
>>>>> >> Every time I attempt to replay, QEMU gets stuck at the same EIP,=
 at a
>>>>> >> very early stage.
>>>>> >>
>>>>> >>
>>>>> >>> Can you boot fine with icount but without record/replay?
>>>>> >>
>>>>> >> Yes. I can also enable icount and recording - it also boots fine=
. The
>>>>> >> problem with the replay.
>>>>> >
>>>>> > Hi guys,
>>>>> > Maybe the thread is a bit outdated, but the problem is still rele=
vant.
>>>>> > I've just tried to record and replay WinXP boot process, and I've=
 encountered
>>>>> > exactly the same problem as described above - record is fine, rep=
lay
>>>>> > gets stuck early. I use current master.
>>>>=20
>>>> Maybe this commit will work:=20
>>>> cfb2d02be9413d45b30ed6d8e38800250b6b4b48
>>=20
>> Unfortunately this one doesn't work either. It seems we need just an
>> all-in-one fix
>> for the current implementation to make it work.
>>=20
>>>>=20
>>>>> > And I've discovered the second problem - recording makes initial =
snapshot,
>>>>> > but it doesn't seem to be saved to the disk - replay can't see it=
.
>>>>=20
>>>> It is ok, because there is a mode where snapshot is created and=20
>>>> loaded.
>>=20
>> So it shouldn't work properly when I use 'rrsnapshot=3D<name>' for bot=
h
>> record and replay?
>> Then how can I enable this mode?
>>=20
>>>>=20
>>>>> >
>>>>> > Hope you've already found the solution (as the last post was on 2=
 May)
>>>>> > and it's just got missed the mailing list.
>>>>=20
>>>> As I know, RR is still broken in the current version.
>>>> It was caused by the MTTCG implementation.
>>>> Alex Bennee tried to fix RR back. Alex, have you found any solution?
>>>>=20
>>>> We also trying to find a way to fix RR. It seems, that we will=20
>>>> reinvent BQL for RR.
>>>=20
>>> I think the method outlined in my RFC is the way to go, essentially=20
>>> the
>>> RR mutex taking over for the what the BQL did. The RFC patch hadn't
>>> hoisted the mutex for the additional devices so I'm just re-basing=20
>>> now
>>> and I'll see if I can make the changes for Igor's test case.
>>>=20
>>> --
>>> Alex Benn=C3=A9e
>=20
> Could you try:
>=20
>   https://github.com/stsquad/qemu/tree/bql-and-replay-locks-v2
>=20
> And report back?

I've encountered 2 new things:
1) Significant performance regression during recording
2) Sometimes I can get through BIOS to the OS boot process itself
    Previously it got stuck in BIOS, the last block I had (I mean with -d=
=20
in_asm) was

     IN:
     0x0000000000007ef6:  pushfl
     0x0000000000007ef8:  pushal
     0x0000000000007efa:  mov    $0xe,%ah
     0x0000000000007efc:  xor    %bx,%bx
     0x0000000000007efe:  int    $0x10

    So I couldn't even get to the boot process of the OS itself.
    Now it passes to the OS unpredictably, and still not very far.=20
Anyway, it doesn't
    reach the point I stopped recording.

So we have a little progress here.


>=20
> --
> Alex Benn=C3=A9e

--=20
Aleksandr Bezzubikov
