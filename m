Received: from eggs.gnu.org ([2001:4830:134:3::10]:55252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eoAq1-0007nn-Iy
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eoApy-0005B4-Ug
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:32:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eoApy-0005Af-L1
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:32:14 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1KGUmoX002165
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 11:32:11 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g8nbgwp7g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 11:32:11 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 20 Feb 2018 16:32:08 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id w1KGW6jr46071842
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 16:32:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A44942045
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 16:24:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04FA742041
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 16:24:44 +0000 (GMT)
Received: from oc3836556865.ibm.com (unknown [9.152.224.42])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 16:24:43 +0000 (GMT)
References: <20180220150713.6056-1-pasic@linux.vnet.ibm.com>
	<20180220165323.02898d8a.cohuck@redhat.com>
	<c836fb0b-4af8-d5c0-a20d-194990f38326@redhat.com>
	<437eecac-036e-bbdd-a275-31dc0c812f32@de.ibm.com>
	<20180220170740.766b2234.cohuck@redhat.com>
	<054d7875-140c-c9c0-f5c3-db52e79feeac@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 20 Feb 2018 17:32:05 +0100
MIME-Version: 1.0
In-Reply-To: <054d7875-140c-c9c0-f5c3-db52e79feeac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <272600b6-37d5-0d1f-858c-c8186ce7bd4a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/1] 390x/cpumodel: document
 S390FeatDef.bit not applicable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



On 02/20/2018 05:08 PM, David Hildenbrand wrote:
> On 20.02.2018 17:07, Cornelia Huck wrote:
>> On Tue, 20 Feb 2018 17:04:19 +0100
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 02/20/2018 04:55 PM, David Hildenbrand wrote:
>>>> On 20.02.2018 16:53, Cornelia Huck wrote:  
>>>>> On Tue, 20 Feb 2018 16:07:13 +0100
>>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>>>  
>>>>>> The 'bit' field of the 'S390FeatDef' structure is not applicable to all
>>>>>> it's instances. Currently a this field is not applicable, and remains  
>>>>>
>>>>> s/it's/its/
>>>>>
>>>>> s/a this/this/
>>>>>  
>>>>>> unused, iff the feature is of type S390_FEAT_TYPE_MISC. Having the value 0
>>>>>> specified for multiple such feature definition  was a little confusing,
>>>>>> as it's a perfectly legit bit value, and as usually the value of the bit
>>>>>> field is ought to be unique for each feature.
>>>>>>
>>>>>> Let's document this, and hopefully reduce the potential for confusion.
>>>>>>
>>>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>
>>>>>> Hi!
>>>>>>
>>>>>> This may be an overkill. A comment where the misc features
>>>>>> are defined would do to, but I think this is nicer. So
>>>>>> I decided to try it with this approach first.  
>>>>>
>>>>> Is there likely to be anything else than FEAT_MISC _not_ using .bit? If
>>>>> not, would it be better to at a comment to the FEAT_MISC definition?  
>>>>
>>>> Doubt it right now. I would sign the "overkill" part :)  
>>>
>>> I can cconfirm that this code caused some questions and it took me some
>>> minutes to remember why 0 and 0 was ok. So I certainly want to have a comment
>>> of some form.
>>>
>>
>> I'd prefer a comment about FEAT_MISC usage rather than a magic value.

As I said elsewhere such stuff used to be called 'extremal element' at
the university. We used the term 'magic value' for hard coded constants.
But the jargon can be different elsewhere.

>>
> 
> We can also add FEAT_INIT_MISC. And add a comment in the initializer.

I don't care that much about aesthetics. FEAT_INT_MISC would have the
benefit of making the definitions shorter. But whatever you decide on. 
