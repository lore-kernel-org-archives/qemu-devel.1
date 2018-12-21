Received: from eggs.gnu.org ([2001:4830:134:3::10]:46368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gaLZy-0007Rk-OR
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gaLZu-0007jH-Ii
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:15:06 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:35800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gaLZu-0007g8-6u
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:15:02 -0500
Received: by mail-wm1-x329.google.com with SMTP id c126so5857344wmh.0
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 06:15:01 -0800 (PST)
References: <76d14474.f850.167cb46b4d9.Coremail.13824125580@163.com>
	<87d0pw9y7m.fsf@linaro.org>
	<19e6128e.27e9.167ce041690.Coremail.13824125580@163.com>
	<874lb79ru9.fsf@linaro.org>
	<744a1829.ff89.167d091062b.Coremail.13824125580@163.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <744a1829.ff89.167d091062b.Coremail.13824125580@163.com>
Date: Fri, 21 Dec 2018 14:14:58 +0000
Message-ID: <8736qr9db1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] did the qemu can emulate the whole system with the
 processor that without support the "virtulization and kvm"?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: tugouxp <13824125580@163.com>
Cc: qemu-devel@nongnu.org


tugouxp <13824125580@163.com> writes:

> thank you.
>
> i just want to confirm one thing,  that is whether the qemu can emulate a=
 whole operation system just by analysis instructions by instructions manua=
lly  without the support of KVM.
> so from the answer you give to me, it is feasible, right?

Yes - if you run qemu-system-$(ARCH) you are emulating a full machine
with hardware attached. It can either use TCG or a HW based acceleration
like KVM. HW based acceleration is only available on the same machine
type.

There is a third type - qemu-$(ARCH) which is often called linux-user
mode. Here the translation engine only translates instruction from guest
to the host and then maps system calls to the host system. This is isn't
emulating a whole system but allows you to run binaries from one
architecture on another.

>
>
>
> thanks very much!
>
>
>
>
>
>
>
>
>
> At 2018-12-21 17:01:02, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wrote:
>>
>>tugouxp <13824125580@163.com> writes:
>>
>>> Hi alex:
>>>     now my host machine did not have the "/dev/kvm" nodes and no chance=
 to make it exists.
>>> so i want to know whether the "/dev/kvm" is  mandatory  for qemu to emu=
late the whole system.
>>> so i can make the emulation without the support of kvm mechanism.
>>
>>QEMU runs in two modes - full system emulation with TCG doesn't require
>>KVM although it is relatively slow. On systems where there guest
>>architecture is the same as the host architecture you can run with KMV
>>(or HAX/WHPX/HVF) accelerators at near native speeds.
>>
>>The reasons for not having a /dev/kvm can vary but you haven't said what
>>your host architecture is and what OS you are running so it's hard to
>>offer advice here.
>>
>>--
>>Alex Benn=C3=A9e


--
Alex Benn=C3=A9e
