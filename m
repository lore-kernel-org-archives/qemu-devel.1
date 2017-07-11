Received: from eggs.gnu.org ([2001:4830:134:3::10]:47461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dUrfx-00025g-Gw
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dUrfu-0003Ba-BJ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:41:49 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <xiechanglong.d@gmail.com>)
	id 1dUrfu-0003At-5P
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:41:46 -0400
Received: by mail-pg0-f51.google.com with SMTP id j186so63871987pge.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 02:41:43 -0700 (PDT)
References: <f7206d1d-addb-1f69-1a77-dc83c1b50e36@linux.vnet.ibm.com>
	<f462bb68-fc63-baec-235c-726066e25d44@gmail.com>
	<8b8c84aa-16c0-2bac-3b8a-9be595682356@linux.vnet.ibm.com>
From: Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <2f6d682c-68af-b689-701b-b7b05a598d7a@gmail.com>
Date: Tue, 11 Jul 2017 17:39:54 +0800
MIME-Version: 1.0
In-Reply-To: <8b8c84aa-16c0-2bac-3b8a-9be595682356@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] About the trace framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang Dong <dongdwdw@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com

在 7/11/2017 9:33 AM, Wang Dong 写道:
> 
> 
> On 07/10/2017 01:24 PM, Xie Changlong wrote:
>> 在 7/9/2017 5:57 PM, Wang Dong 写道:
>>> Hi,
>>>
>>> I am new to QEMU. But I got some problem so that  I want to figure it 
>>> out.
>>>
>>> So I try to debug qemu to see what happened.
>>>
>>> And I found trace framework. I think this will help me understand the 
>>> point.
>>>
>>> So I compiled qemu with option:
>>>
>>> ## *--enable-trace-backends=simple*
>>>
>>> And did as the docs/tracing.txt tell. But when I execute the example 
>>> command in it, nothing just happens.
>>>
>>> *./scripts/simpletrace.py trace-events-all trace-xxxxxx(my trace file 
>>> produced by qemu)
>>> I am not sure what happened. Just ask this.
>>> Any clue will be appreciated. Thanks in advance.
>>> *
>>>
>>
>> Did you set *trace-event*? I've encountered this issue in the past :)
>> (qemu) help trace-event
>> trace-event name on|off -- changes status of a specific trace event
>> (qemu) info trace-events
> yes, I set it. I just did as the docs told. If this does not work or 
> misses something, it should be corrected I think.
> 
> Have you also tried out the examples in docs? how did you do that? I 

Yes, just follow the docs. No something special.

> think I misses some. Could you tell more about
> it? Thanks.

You should confirm the *trace-event*s you set are really triggered by 
qemu. Use gdb breakpoint to verify it is a good choice.

> 

-- 
Thanks
     -Xie
