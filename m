Received: from eggs.gnu.org ([2001:4830:134:3::10]:43001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dURBn-0003Pa-7X
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 01:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dURBk-00017W-1e
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 01:24:55 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:35350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <xiechanglong.d@gmail.com>)
	id 1dURBj-00017I-SC
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 01:24:51 -0400
Received: by mail-pf0-x22e.google.com with SMTP id c73so44068270pfk.2
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 22:24:50 -0700 (PDT)
References: <f7206d1d-addb-1f69-1a77-dc83c1b50e36@linux.vnet.ibm.com>
From: Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <f462bb68-fc63-baec-235c-726066e25d44@gmail.com>
Date: Mon, 10 Jul 2017 13:24:23 +0800
MIME-Version: 1.0
In-Reply-To: <f7206d1d-addb-1f69-1a77-dc83c1b50e36@linux.vnet.ibm.com>
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

在 7/9/2017 5:57 PM, Wang Dong 写道:
> Hi,
> 
> I am new to QEMU. But I got some problem so that  I want to figure it out.
> 
> So I try to debug qemu to see what happened.
> 
> And I found trace framework. I think this will help me understand the 
> point.
> 
> So I compiled qemu with option:
> 
> ## *--enable-trace-backends=simple*
> 
> And did as the docs/tracing.txt tell. But when I execute the example 
> command in it, nothing just happens.
> 
> *./scripts/simpletrace.py trace-events-all trace-xxxxxx(my trace file 
> produced by qemu)
> I am not sure what happened. Just ask this.
> Any clue will be appreciated. Thanks in advance.
> *
> 

Did you set *trace-event*? I've encountered this issue in the past :)
(qemu) help trace-event
trace-event name on|off -- changes status of a specific trace event
(qemu) info trace-events

-- 
Thanks
     -Xie
