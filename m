Received: from eggs.gnu.org ([2001:4830:134:3::10]:43426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dFsbz-0002zj-6X
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dFsbw-0004i9-Ks
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:39:47 -0400
Received: from [59.151.112.132] (port=39535 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dFsbw-0004dr-8L
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:39:44 -0400
References: <20170526082925.2888-1-maozy.fnst@cn.fujitsu.com>
	<20170526114320.63f4f0b3@nial.brq.redhat.com>
	<87y3tgayod.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <86e97bfd-79c9-3fbd-55b6-431f9d889327@cn.fujitsu.com>
Date: Wed, 31 May 2017 09:38:21 +0800
MIME-Version: 1.0
In-Reply-To: <87y3tgayod.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci: Set err to errp directly rather than
 through error_porpagate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: marcel@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

Hi, Markus

On 05/29/2017 03:51 PM, Markus Armbruster wrote:
> Igor Mammedov <imammedo@redhat.com> writes:
>
>> On Fri, 26 May 2017 16:29:25 +0800
>> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> wrote:
>>
>>> ioh3420_interrupts_init() and its callers, rp_realize() and
>>> pci_qdev_realize() fill error message to local_err, then
>>> propagate it to errp by error_porpagate(), which's not necessary.
>>> So eliminate it and pass errp directly instead of local_err.
>>> Of course, error_propagate() also will be removed.
>>>
>>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>>> ---
[...]

>>
>> dropping local_error here looks wrong since it's used
>> to check error status inside these functions and to undo
>> side effects in case of failure.
>>
>> consider if caller pass errp = NULL
>> then error handling path won't be executed.
>
> Exactly.  The big comment in include/qapi/error.h explains this and
> more.

Thanks for providing the specific path, I have seen detailed comments
that have really helped me.

Thanks,
Mao

>
>> So keep the rest of the patch but drop above hunks.
>
>
>
