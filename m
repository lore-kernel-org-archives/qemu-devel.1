Received: from eggs.gnu.org ([2001:4830:134:3::10]:34678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds5y4-0007Tl-Nb
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds5y1-0001ff-Jt
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:36:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34924
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ds5y1-0001f9-ET
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:36:29 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8DBYIdO017784
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:36:28 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cy18s7g6d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:36:28 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 13 Sep 2017 12:36:26 +0100
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-4-pasic@linux.vnet.ibm.com>
	<20170906144221.76132052.cohuck@redhat.com>
	<cf982df3-546f-69a7-0beb-2f83e1daaee8@linux.vnet.ibm.com>
	<20170913115847.57eab4d7.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 13 Sep 2017 13:36:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170913115847.57eab4d7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <44204f91-ead8-8108-dc4c-24d4ac4956a4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] virtio-ccw: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/13/2017 11:58 AM, Cornelia Huck wrote:
> On Mon, 11 Sep 2017 20:14:59 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 09/06/2017 02:42 PM, Cornelia Huck wrote:
>>>> @@ -488,7 +446,8 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>>>>          } else {
>>>>              virtio_bus_get_vdev_config(&dev->bus, vdev->config);
>>>>              /* XXX config space endianness */  
>>> Unrelated: That should be fine, I guess?
>>>   
>>
>> Would be pretty bad if it weren't. It's the responsibility of the
>> virtio device to give us the right endianness. We don't know the layout
>> so we could not fix it even if we had to. I guess this comment should be
>> removed.
> 
> Yes, please do so.
> 

Will do as a stand-alone patch.
