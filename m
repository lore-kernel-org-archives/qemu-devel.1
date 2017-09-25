Received: from eggs.gnu.org ([2001:4830:134:3::10]:52905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dwR56-00082j-Ub
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dwR53-0002Rp-Sw
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:57:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dwR53-0002RJ-J1
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:57:41 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8PAraVx081641
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:57:37 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d6yp4axy3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 06:57:35 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 25 Sep 2017 11:57:33 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v8PAvVnd20906090
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 10:57:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33C47AE051
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 11:52:16 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07C5CAE045
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 11:52:16 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.152.224.207])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 11:52:15 +0100 (BST)
References: <8946b1ec-4d14-c953-deab-aaded7cd2c9d@linux.vnet.ibm.com>
	<20170906162019.45eeec4a.cohuck@redhat.com>
	<cc6eab96-969d-eb66-91b5-cdb965c1bcbb@linux.vnet.ibm.com>
	<20170907085831.GF31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907122400.5b2e3faa.cohuck@redhat.com>
	<27b2addf-0d1c-81d7-1e82-1a8cdac70231@linux.vnet.ibm.com>
	<20170907134134.00f387e8.cohuck@redhat.com>
	<20170908034100.GH31680@bjsdjshi@linux.vnet.ibm.com>
	<381cb778-5679-634c-9d3d-7276f877da3a@linux.vnet.ibm.com>
	<20170908115950.56996cc6.cohuck@redhat.com>
	<20170925073159.GR11080@bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 25 Sep 2017 12:57:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170925073159.GR11080@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f7755ca8-78f3-759e-f879-fea2f4fdadfc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] s390x: refactor error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



On 09/25/2017 09:31 AM, Dong Jia Shi wrote:
> * Cornelia Huck <cohuck@redhat.com> [2017-09-08 11:59:50 +0200]:
> 
>> On Fri, 8 Sep 2017 11:21:57 +0200
>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>
>>> On 09/08/2017 05:41 AM, Dong Jia Shi wrote:
>>>> Let' me summarize here, in case I misunderstand things. Now we have
>>>> two ways to choose:
>>>>
>>>> A. Kernel: no change.
>>>>    Qemu  : handle -EFAULT as option 2 by generating a program check.
>>>>
>>>> B. Kernel: return -EFAULT
>>>>            +
>>>>            update the IRB area in the I/O region for option 1 to present
>>>>            a unit check SCSW (with proper sense byte ECW), and for option
>>>>            2 to present a program check.
>>>>    Qemu  : handle -EFAULT according to the information that the IRB area
>>>>            provided.  
>>>
>>> This is not what I was trying to say. You got my message regarding A, but
>>> B was supposed to be understood like this.
>>>
>>> Keep the current handling for option 1, that is return -EFAULT. For option
>>> 2 do what the spec says, execute the program until the bad address and then
>>> generate a program-check (SCSW) once the bad stuff has it's turn. Thus
>>> the only change in QEMU would be handling -EFAULT with an unit check (because
>>> now it's just option 1).
> Let me adding some context information here by copying some words from the
> previous mail in this thread:
> The only option 2 case in the kernel is ccwchain_fetch_idal() finding a
> bad idaw_iova.
> 
> What you propose to do for this case is (correct me if I get it wrong):
> In ccwchain_fetch_idal(), we do not return -EFAULT, instead we return 0,
> and issuing the incompletely translated channel program with the bad
> address to the physical device. And QEMU will eventually get the SCSW
> with the program-check from the physical device I/O result, and inject
> it to guest for further handling.
> 

I guess that would be the cleanest. I would also be fine with not making
the physical device program-check (issuing a shortened channel program,
and doing the program check in software) but that's probably more
complicated to implement.

> Is this understanding right? If so, I'm fine with that, and I can
> provide the fix in the kernel.
> 

That would be nice.

>>
>> That makes sense to me.
>>
> 
