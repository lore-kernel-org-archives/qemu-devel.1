Received: from eggs.gnu.org ([2001:4830:134:3::10]:44950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e99QZ-0001Z1-1H
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 08:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e99QV-0006eq-Ua
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 08:44:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42010
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e99QV-0006ef-ON
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 08:44:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9UChdGS045089
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 08:44:17 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dx0vru2e0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 08:44:17 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 30 Oct 2017 12:44:15 -0000
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<feea3ded-fecc-50ff-fe70-09e63966933b@de.ibm.com>
	<20171030134233.6aaa81a1.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Oct 2017 13:44:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171030134233.6aaa81a1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <54504556-d508-e86f-388b-b07fa7576978@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/5][RFC] Refactoring of AIS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org



On 10/30/2017 01:42 PM, Cornelia Huck wrote:
> On Mon, 30 Oct 2017 09:28:09 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Now I thought about that for a while and I start to think that we cannot implement ais
>> in QEMU and cover all cases.
>> One aspect was certainly passthrough (like you handled in patch 4).
>> Another aspect is that some interrupts might be injected from the kernel - even for
>> emulated devices. e.g. virtio-pci together with vhost-net, will inject interrupts via
>> the set_irq callback. I think disabling irqfd for these cases is not a good idea.
> 
> Is there still a fallback for irqfd emulation?

it might disable dataplane or other things. (it once did). So I think we should not
go down this path.

> 
>>
>> So what about adding a new KVM capability (for 4.14), fixup the other things in
>> QEMU and then bind it to the new capability?
> 
> For 4.15, surely?
> 
> Probably the only way we can make this work correctly...
> 
