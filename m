Received: from eggs.gnu.org ([2001:4830:134:3::10]:42387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gaLP0-0002YA-LJ
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gaLOx-0007ug-Uj
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:03:46 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:29196
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gaLOx-0007sw-Hj
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:03:43 -0500
References: <76d14474.f850.167cb46b4d9.Coremail.13824125580@163.com>
	<87d0pw9y7m.fsf@linaro.org>
	<19e6128e.27e9.167ce041690.Coremail.13824125580@163.com>
	<874lb79ru9.fsf@linaro.org>
	<744a1829.ff89.167d091062b.Coremail.13824125580@163.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <7f94976c-f081-492e-8c68-c6766a88a115@cn.fujitsu.com>
Date: Fri, 21 Dec 2018 22:03:31 +0800
MIME-Version: 1.0
In-Reply-To: <744a1829.ff89.167d091062b.Coremail.13824125580@163.com>
Content-Language: en-US
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
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
To: tugouxp <13824125580@163.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org


On 12/21/18 19:40, tugouxp wrote:
> thank you.
>   
> i just want to confirm one thing,  that is whether the qemu can emulate a whole operation system just by analysis instructions by instructions manually  without the support of KVM.

IIUC£¬
"operation system" often means a software but QEMU usually emulates hardwares, including cpus, memory, NIC, etc.
Please know that QEMU born earlier than KVM, so QEMU can work well without KVM.

Thanks


> so from the answer you give to me, it is feasible, right?
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
> At 2018-12-21 17:01:02, "Alex Benn¨¦e" <alex.bennee@linaro.org> wrote:
>> tugouxp <13824125580@163.com> writes:
>>
>>> Hi alex:
>>>      now my host machine did not have the "/dev/kvm" nodes and no chance to make it exists.
>>> so i want to know whether the "/dev/kvm" is  mandatory  for qemu to emulate the whole system.
>>> so i can make the emulation without the support of kvm mechanism.
>> QEMU runs in two modes - full system emulation with TCG doesn't require
>> KVM although it is relatively slow. On systems where there guest
>> architecture is the same as the host architecture you can run with KMV
>> (or HAX/WHPX/HVF) accelerators at near native speeds.
>>
>> The reasons for not having a /dev/kvm can vary but you haven't said what
>> your host architecture is and what OS you are running so it's hard to
>> offer advice here.
>>
>> --
>> Alex Benn¨¦e
>
-- 
Best regards.
Li Zhijian (8528)
