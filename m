Received: from eggs.gnu.org ([2001:4830:134:3::10]:53703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1fiwSI-00072A-Js
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1fiwSF-0008PZ-H5
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:42:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36224
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.vnet.ibm.com>)
	id 1fiwSF-0008PI-A1
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:42:23 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6R6dg3u126176
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 02:42:22 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kfsqn9e29-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 02:42:21 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.vnet.ibm.com>;
	Fri, 27 Jul 2018 07:42:19 +0100
References: <153258768962.6738.11319866502689416568.stgit@dhcp-9-109-246-16>
	<b707ccc3-47bb-569f-3df0-aeb91e90b820@linaro.org>
From: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Date: Fri, 27 Jul 2018 12:12:14 +0530
MIME-Version: 1.0
In-Reply-To: <b707ccc3-47bb-569f-3df0-aeb91e90b820@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <a40f756f-7bdd-755b-2086-810a2b7f711b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] linux-user: ppc64: don't use volatile
 register during safe_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, dgibson@redhat.com, riku.voipio@iki.fi, laurent@vivier.eu
Cc: qemu-devel@nongnu.org



On 07/26/2018 10:56 PM, Richard Henderson wrote:
> On 07/25/2018 11:48 PM, Shivaprasad G Bhat wrote:
>> Reference:
>> https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html#REG
> This document is for _CALL_ELF < 2.  For ppc64le, the document is at
>
> https://openpowerfoundation.org/wp-content/uploads/2016/03/ABI64BitOpenPOWERv1.1_16July2015_pub4.pdf
>
> In both cases, it appears that we can (ab)use SP+16 to save
> the value of r14 across the syscall.  This slot would normally
> be used for saving our own return address (LR), but we have no
> need to save that value because it *is* preserved across the syscall.
I will send updated patch as suggested.

Thanks,
Shivaprasad
>
>
> r~
>
