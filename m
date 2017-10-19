Received: from eggs.gnu.org ([2001:4830:134:3::10]:34351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e5DrM-00046L-BL
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e5DrH-0005rl-CJ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:39:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42446
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e5DrH-0005rF-5x
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:39:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JGd55s027571
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 12:39:43 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dpyrmg0u7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 12:39:42 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 17:39:41 +0100
References: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
	<20170913132752.8484-2-pasic@linux.vnet.ibm.com>
	<20170914162603.1cdabd09.cohuck@redhat.com>
	<0b42ef59-4366-175f-8dc7-bc3ed02e2fb4@linux.vnet.ibm.com>
	<20170915092758.16ea52fc.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 18:39:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170915092758.16ea52fc.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <711b1e41-693a-de7d-9c13-fbe0f964c53c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>



On 09/15/2017 09:27 AM, Cornelia Huck wrote:
>>>   
>>>> +    DEFINE_PROP_UINT8("chpid_type", CcwTesterDevice, chpid_type,
>>>> +                       0x98),
> This might also need re-evaluation - we should not really need a new
> chpid type.
> 

I'm back at ccw-tester again (for v2). I've realized we did not agree
on what to use here (chpid_type). Shall I use 0x25 (Fibre Channel) or
EMULATED_CCW_3270_CHPID_TYPE, or even 0x32 (virtio-ccw) as a default
value? And should EMULATED_CCW_3270_CHPID_TYPE be called like that
(is it really supposed to be specific to 3270?

Sorry I did not notice sooner.

Regards,
Halil
