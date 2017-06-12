Received: from eggs.gnu.org ([2001:4830:134:3::10]:52792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dKMWG-0003Hy-UM
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongdwdw@linux.vnet.ibm.com>) id 1dKMWC-0002Qw-Rl
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:24:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42411
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongdwdw@linux.vnet.ibm.com>)
	id 1dKMWC-0002Qs-KR
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:24:20 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5CAOJGn002156
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 06:24:19 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2b1qbpmv6d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 06:24:01 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <dongdwdw@linux.vnet.ibm.com>;
	Mon, 12 Jun 2017 20:23:57 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v5CANt6H7012820
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 20:23:55 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v5CANsCH022493
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 20:23:54 +1000
Received: from [9.115.125.107] (ibm829-pc026gpq.cn.ibm.com [9.115.125.107])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	v5CANrc5022437
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 20:23:54 +1000
From: Wang Dong <dongdwdw@linux.vnet.ibm.com>
Date: Mon, 12 Jun 2017 18:23:54 +0800
MIME-Version: 1.0
Message-Id: <19e31603-201e-b7c9-3496-2a8c07aaff26@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] when the device property is called?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I am newbie to qemu. Recently, I am reading the code and found one question.

I can see some property function is added to the object. But I wonder 
when these

property functions are called or triggered. When I try to trace them, 
only the initialization

is found. I found some unclear lines in the doc, I can not figure out 
the details.

*"Device properties in QOM are bound to devices and are implemented by 
closures provided by the device.
***

*A Visitor is passed to the closure which effectively allows properties 
to be set/get through native C types.***

*Mapping to any other type of representation (string or otherwise) is 
done by a Visitor with no knowledge of the device or property.***

  "

I also found this property function has something to do with the 
*Visitor*, and I trace the function *x86_cpu_get_crash_info_qom* along with

Visitor. And I found that these crash information is finally read out to 
log file along with this visitor. *But **still I have no idea when this **
**x86_cpu_get_crash_info_qom is triggered.
*

But as I found that the cpu class is initialized with an another 
function *cc->get_crash_info = x86_cpu_get_crash_info*

And with this function, the crash information will also be put out to 
log file. And this function will return a crash information struct to 
*qemu_system_**guest**_panicked*, which will then print the crash info 
to log file too.

*I wonder what is the difference between them? And when the property 
function is called?
*

*
*

*Any clue will be very appreciated. Thanks in advance.
*

Thanks in advance.



-- 
Best regards.

Wang Dong
