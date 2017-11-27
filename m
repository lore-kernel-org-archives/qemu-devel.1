Received: from eggs.gnu.org ([2001:4830:134:3::10]:43440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eJKAn-0001NT-Db
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eJKAh-0000qj-Cd
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:14:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60850
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eJKAh-0000qb-6U
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:14:07 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vARE9WYs047005
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 09:14:05 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2egj5t71wb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 09:14:04 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 14:14:03 -0000
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
	<1ddb44db-2c5c-d64f-56e0-e4582f82b572@linux.vnet.ibm.com>
	<20171124171510.2343ccdf.cohuck@redhat.com>
	<8c18df3e-92a0-f88f-6d24-e1df051c8138@linux.vnet.ibm.com>
	<20171127135624.28052dc5.cohuck@redhat.com>
	<57f95f61-b9d9-1341-78c7-259006cb5945@linux.vnet.ibm.com>
	<20171127141929.1d692aad.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 15:13:59 +0100
MIME-Version: 1.0
In-Reply-To: <20171127141929.1d692aad.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <39cb6a69-7f32-80d4-214d-26e1e81a9fd7@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] s390x/css: unresrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>



On 11/27/2017 02:19 PM, Cornelia Huck wrote:
> On Mon, 27 Nov 2017 14:11:57 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 11/27/2017 01:56 PM, Cornelia Huck wrote:
>>> On Fri, 24 Nov 2017 17:39:04 +0100
>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>   
>>>> On 11/24/2017 05:15 PM, Cornelia Huck wrote:  
> 
>>>>> (Unless we simply make this a "default cssid" prop after all - then it
>>>>> would be more than just a simple indication for libvirt...)
>>>>>     
>>>>
>>>> We are now talking about the "cssid-unrestricted" property. The default
>>>> cssid is not something I would like to do any time soon.  
>>>
>>> What's so bad about this? As said above, I think it would be much more
>>> useful. If libvirt can detect r/o vs. r/w for properties, we can simply
>>> start out with a r/o variant now...
>>>   
>>
>> I'm not sure I understand you. Are you proposing the following:
>> Drop the restriction, but don't indicate this via a read only
>> "cssid-unrestricted" device property but via a "default-css"
>> read only machine property.
>>
>> Libvirt then should know that if "default-css" is present then
>> we don't have this virtual into 0xfe and non virtual into 0xfd
>> restriction any more.
> 
> Yes.
> 

@Boris:
Does this work for you? Technically it's equivalent to having
"cssid-unrestricted" at machine level.

I don't really like the idea of indicating unrestricted via
something mostly unrelated (at least for me it ain't obvious that
having the id of the default css exposed means we got rid of the
limitation.). But I'm tied of discussing this, so I'm willing to
compromise.

Halil
