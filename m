Received: from eggs.gnu.org ([2001:4830:134:3::10]:47787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eIFwT-0000Ul-3C
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eIFwP-0001xm-Vr
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:31:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eIFwP-0001x6-MR
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 10:30:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAOFUjvW028185
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 10:30:53 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eem3adeyw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 10:30:52 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 24 Nov 2017 15:30:26 -0000
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
	<20171121144457.60adb0c3.cohuck@redhat.com>
	<1145a6bc-45fd-820a-9dcc-249d9b2802ff@linux.vnet.ibm.com>
	<20171121172022.5da16158.cohuck@redhat.com>
	<88bc72cf-732c-fc07-9898-18d7b58b947d@linux.vnet.ibm.com>
	<20171122131343.26da0482.cohuck@redhat.com>
	<594e1952-7097-0927-d913-d3b915df2305@linux.vnet.ibm.com>
	<20171122172522.281cfb4b.cohuck@redhat.com>
	<76f95c6f-641e-2fe0-73b4-3ab24fc1a93f@linux.vnet.ibm.com>
	<20171124134650.46665791.cohuck@redhat.com>
	<7eaa796e-7815-f943-58b5-ecb5a0bb252e@de.ibm.com>
	<20171124142758.39d7726f.cohuck@redhat.com>
	<131b311b-c262-3636-c7ee-1c59ee283823@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 24 Nov 2017 16:30:24 +0100
MIME-Version: 1.0
In-Reply-To: <131b311b-c262-3636-c7ee-1c59ee283823@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <1ddb44db-2c5c-d64f-56e0-e4582f82b572@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>



On 11/24/2017 03:58 PM, Christian Borntraeger wrote:
> 
> 
> On 11/24/2017 02:27 PM, Cornelia Huck wrote:
>> On Fri, 24 Nov 2017 14:01:20 +0100
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> I first liked the idea to have it as a property of the css, but 
>>> this is all pretty unclear how to do right. I start to think that going with
>>> Halils first patch (a property per virtio device) is going to be the most
>>> simple solution without causing any harm. After all as of today we only want 
>>> to have a way to tell libvirt that devices can be everywhere. Specifying the
>>> default css might be something that we want to have in the future, but here
>>> future might even mean never.
>>
>> I still don't like the idea of a per-device property, but I agree that
>> adding a css property would need too much discussion to get to a
>> solution in the near future.
>>
>> Is there anything that speaks against a machine property, though? While
>> not ideal, I like it better than the per-device one.
> 
> In theory this should work. 
> 
> In reality it seems more complicated. A per-device property is easy and can be
> inspected on the command line (e.g. -device virtio-blk-ccw,help), while a new 
> machine property would require to change the qemu help output and qemu-options 
> file (which makes it visible for all architectures).

And then we have the fun of describing, that this property is weird, and can
not be set, and it's value does not matter.

BTW one can do -machine s390-ccw-virtio-2.11,help and get a list of properties,
so the command line introspection would work similar.

I've already brought some other arguments against the machine property.
Won't repeat them here.

> Not sure if there are
> easier ways to do it. (e.g. QOM-only things, but then we have no command line
> way of doing it)
> 
> 
 
If we don't care about if it can be introspected on the command line my
trait type approach is pretty minimal. But the least surprise is probably
still the device property (IMHO).
