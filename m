Received: from eggs.gnu.org ([2001:4830:134:3::10]:53257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eJKY5-0001q5-8T
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eJKY0-0003aa-Ed
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:38:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59178
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eJKY0-0003aO-8t
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 09:38:12 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAREYwJU140861
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 09:38:08 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2egkd93xmy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 09:38:07 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 14:38:06 -0000
References: <20171121111825.17916-1-pasic@linux.vnet.ibm.com>
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
	<ab616336-33c3-7041-056d-11dfd8aa437a@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 15:38:02 +0100
MIME-Version: 1.0
In-Reply-To: <ab616336-33c3-7041-056d-11dfd8aa437a@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d65ff34d-0779-4da9-1188-b67488a162fd@linux.vnet.ibm.com>
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
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>



On 11/27/2017 03:03 PM, Christian Borntraeger wrote:
> 
> 
> On 11/27/2017 02:19 PM, Cornelia Huck wrote:
>> On Mon, 27 Nov 2017 14:11:57 +0100
>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>
>>> On 11/27/2017 01:56 PM, Cornelia Huck wrote:
>>>> On Fri, 24 Nov 2017 17:39:04 +0100
>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>>   
>>>>> On 11/24/2017 05:15 PM, Cornelia Huck wrote:  
>>
>>>>>> (Unless we simply make this a "default cssid" prop after all - then it
>>>>>> would be more than just a simple indication for libvirt...)
>>>>>>     
>>>>>
>>>>> We are now talking about the "cssid-unrestricted" property. The default
>>>>> cssid is not something I would like to do any time soon.  
>>>>
>>>> What's so bad about this? As said above, I think it would be much more
>>>> useful. If libvirt can detect r/o vs. r/w for properties, we can simply
>>>> start out with a r/o variant now...
>>>>   
>>>
>>> I'm not sure I understand you. Are you proposing the following:
>>> Drop the restriction, but don't indicate this via a read only
>>> "cssid-unrestricted" device property but via a "default-css"
>>> read only machine property.
>>>
>>> Libvirt then should know that if "default-css" is present then
>>> we don't have this virtual into 0xfe and non virtual into 0xfd
>>> restriction any more.
>>
>> Yes.
> 
> Unless we implement the ability to set the default css _NOW_, I would
> prefer to not couple different things (ability to change default-css
> and abiltity to move devices around). Otherwise we might need to change
> things again if we find out that our plan does not work out.
> 
> So what about having
> - a cssid-unrestricted machine property that shows that devices can move around
> - later a default-css machine property when we actually implement that
> 
> ?
> 

I can -- compromise and -- live with that. I'm still not convinced
that having the property at the machines is better. But I don't think,
I can convince Connie that having it at the devices is better. I would
like to get this done.

> Christian
> 
> 
