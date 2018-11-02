Received: from eggs.gnu.org ([2001:4830:134:3::10]:40942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gIcje-0006Bm-Ka
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gIcjZ-0005cq-O8
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:55:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gIcjY-0005KA-KI
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:55:45 -0400
Received: by mail-wr1-x443.google.com with SMTP id d17-v6so2635760wre.11
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 09:55:26 -0700 (PDT)
References: <d5d6e09a-78ed-41c4-bbb9-260263c05bf2@windriver.com>
	<87pnvn6hnq.fsf@linaro.org>
	<b109fe05-1e88-a6e3-34cb-21a4b61e64b3@windriver.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <b109fe05-1e88-a6e3-34cb-21a4b61e64b3@windriver.com>
Date: Fri, 02 Nov 2018 16:55:22 +0000
Message-ID: <87lg6b5shx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] strange situation,
 guest cpu thread spinning at ~100%, but display not yet initialized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chris Friesen <chris.friesen@windriver.com>
Cc: qemu-devel@nongnu.org


Chris Friesen <chris.friesen@windriver.com> writes:

> On 11/2/2018 1:51 AM, Alex Benn=C3=A9e wrote:
>>
>> Chris Friesen <chris.friesen@windriver.com> writes:
>>
>>> Hi all,
>>>
>>> I have an odd situation which occurs very infrequently and I'm hoping
>>> to get some advice on how to debug.  Apologies for the length of this
>>> message, I tried to include as much potentially useful information as
>>> possible.
>>>
>>> In the context of an OpenStack compute node I have a qemu guest (with
>>> kvm acceleration) that has started up.  The virtual console shows
>>> "Guest has not initialized the display (yet)."   I'm trying to figure
>>> out what's going on and how we got into this state.  I assume it's
>>> some sort of deadlock/livelock, but I can't figure out what's causing
>>> it.
>
>>> At this point gdb appears to be stuck, though the task is still
>>> chewing 99.9% of host cpu 43.
>>
>> That's because the vcpu_ioctl you just trace through is into the
>> VCPU_RUN, basically when you enter the guest code (assuming the in
>> kernel KVM code isn't spinning).
>
> That's what I figured, thanks for the confirmation.
>
>> If you want to get an idea why your guest is spinning you probably want
>> to enable the gdb stub and look at what your guest kernel is doing.
>
> Given the "not initialized" message on the console, I wasn't sure
> whether the kernel had even started yet.

There will be a lot that happens between the kernel decompressing and
some sort of video hardware output being started. You didn't say what
guest architecture you were booting or what your qemu command line was.
You might want to look at enabling the serial console and seeing if you
get some clues from that.

--
Alex Benn=C3=A9e
