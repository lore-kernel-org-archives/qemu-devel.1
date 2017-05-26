Received: from eggs.gnu.org ([2001:4830:134:3::10]:52253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dE7Hn-0004bL-Vi
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dE7Hk-0004cK-RZ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:55:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44952
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongdwdw@linux.vnet.ibm.com>)
	id 1dE7Hk-0004c8-LS
	for qemu-devel@nongnu.org; Fri, 26 May 2017 00:55:36 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4Q4s2fO194715
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 00:55:35 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2apchsj8wt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 00:55:35 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <dongdwdw@linux.vnet.ibm.com>;
	Fri, 26 May 2017 14:55:29 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v4Q4tJCj58261710
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 14:55:27 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v4Q4ssMD017492
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 14:54:54 +1000
References: <f0b11c2d-9f61-c4c2-4b55-58644b760e31@linux.vnet.ibm.com>
	<f5c021e4-86ce-7476-44dc-d386f2349ed0@redhat.com>
From: Wang Dong <dongdwdw@linux.vnet.ibm.com>
Date: Fri, 26 May 2017 12:54:38 +0800
MIME-Version: 1.0
In-Reply-To: <f5c021e4-86ce-7476-44dc-d386f2349ed0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <e4b8f16d-b62d-582c-2659-5e6a049a6813@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] new to qemu with a simple question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org



On 05/24/2017 09:30 PM, Eric Blake wrote:
> On 05/23/2017 09:56 PM, Wang Dong wrote:
>> Hi guys,
>>
>> I am new to qemu. But I need do some job in it right now.
>>
>> When I try read qmp code. I found a interesting part against it.
>>
>> Some C source code is generate from json file.
>>
>> I wonder why this? What is the benefits of this?
> Boring and repetitive code that is easy to typo is best written by
> computer, which excels at boring and repetitive tasks.  Writing our
> description in a more concise higher language and generating C code from
> that lets us focus on the actual design, rather than the mundane
> correctness of the code implementing the design.
>
> It's the same reason that people use bison/yacc rather than hand-written
> parsers for complex grammars - you isolate the correctness of the code
> to the correctness of the generator, and free yourself to now only have
> to worry about the bigger picture of the input you feed to the
> generator.  And on another level, it's why we write programs in C
> instead of assembly.  Abstraction is good.
>
Thanks for your reply. I really appreciate it.

-- 
Best regards. Wang Dong
