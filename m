Received: from eggs.gnu.org ([2001:4830:134:3::10]:52116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dVZ3p-0006Cw-1g
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dVZ3l-0004Fy-Up
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:01:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50081
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongdwdw@linux.vnet.ibm.com>)
	id 1dVZ3l-0004Fl-P0
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:01:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6D7x2hL112412
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 04:01:16 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3p4n5j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 04:01:16 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <dongdwdw@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 18:01:13 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v6D81B8h21889148
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 18:01:11 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v6D812hx001416
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 18:01:03 +1000
References: <f7206d1d-addb-1f69-1a77-dc83c1b50e36@linux.vnet.ibm.com>
	<f462bb68-fc63-baec-235c-726066e25d44@gmail.com>
	<20170710124025.GE14195@stefanha-x1.localdomain>
From: Wang Dong <dongdwdw@linux.vnet.ibm.com>
Date: Thu, 13 Jul 2017 16:01:09 +0800
MIME-Version: 1.0
In-Reply-To: <20170710124025.GE14195@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <5fd4160d-87ca-6cb1-1a32-1d4debf34d76@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] About the trace framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>
Cc: qemu-devel@nongnu.org



On 07/10/2017 08:40 PM, Stefan Hajnoczi wrote:
> On Mon, Jul 10, 2017 at 01:24:23PM +0800, Xie Changlong wrote:
>> =E5=9C=A8 7/9/2017 5:57 PM, Wang Dong =E5=86=99=E9=81=93:
>>> Hi,
>>>
>>> I am new to QEMU. But I got some problem so that  I want to figure it=
 out.
>>>
>>> So I try to debug qemu to see what happened.
>>>
>>> And I found trace framework. I think this will help me understand the
>>> point.
>>>
>>> So I compiled qemu with option:
>>>
>>> ## *--enable-trace-backends=3Dsimple*
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
>> Did you set *trace-event*? I've encountered this issue in the past :)
>> (qemu) help trace-event
>> trace-event name on|off -- changes status of a specific trace event
>> (qemu) info trace-events
> Yes, you need to enable specific trace events that you are interested
> in.  'trace-event' does that from the QEMU monitor at runtime.  If you'=
d
> rather keep a file with a list of events to enable:
>
>    $ echo bdrv_aio_readv   > /tmp/events
>    $ echo bdrv_aio_writev >> /tmp/events
>    $ qemu -trace events=3D/tmp/events ... # your normal QEMU invocation
>
> It's hard to know what is missing without seeing your QEMU command-line
> and monitor commands you used.
>
> Stefan

I thought the example in doc was enabled by default.

Thanks for your reply. Below is my command:
When to compile:

./configure --enable-debug --enable-trace-backends=3Dsimple

$ echo bdrv_aio_readv   > /tmp/events
$ echo bdrv_aio_writev >> /tmp/events


qemu [...]

-chardev socket,id=3Dmon1,host=3Dlocalhost,port=3D7777,server,nowait \
-mon chardev=3Dmon1,mode=3Dcontrol,pretty=3Don \
-trace events=3D/tmp/events


Did I miss something?

--=20
Best regards. Wang Dong
