Received: from eggs.gnu.org ([2001:4830:134:3::10]:36182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dU8yC-0006yO-TE
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 05:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dU8y8-00068v-0g
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 05:57:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60328
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongdwdw@linux.vnet.ibm.com>)
	id 1dU8y7-00067v-Pm
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 05:57:35 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v699rO1Z030333
	for <qemu-devel@nongnu.org>; Sun, 9 Jul 2017 05:57:33 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bjuhgwwxk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 05:57:33 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <dongdwdw@linux.vnet.ibm.com>;
	Sun, 9 Jul 2017 19:57:30 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v699vSsR13893792
	for <qemu-devel@nongnu.org>; Sun, 9 Jul 2017 19:57:28 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v699vRAH006261
	for <qemu-devel@nongnu.org>; Sun, 9 Jul 2017 19:57:27 +1000
From: Wang Dong <dongdwdw@linux.vnet.ibm.com>
Date: Sun, 9 Jul 2017 17:57:28 +0800
MIME-Version: 1.0
Message-Id: <f7206d1d-addb-1f69-1a77-dc83c1b50e36@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] About the trace framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

Hi,

I am new to QEMU. But I got some problem so that  I want to figure it out.

So I try to debug qemu to see what happened.

And I found trace framework. I think this will help me understand the point.

So I compiled qemu with option:

## *--enable-trace-backends=simple*

And did as the docs/tracing.txt tell. But when I execute the example 
command in it, nothing just happens.

*./scripts/simpletrace.py trace-events-all trace-xxxxxx(my trace file 
produced by qemu)
I am not sure what happened. Just ask this.
Any clue will be appreciated. Thanks in advance.
*

-- 
Best regards.

Wang Dong
