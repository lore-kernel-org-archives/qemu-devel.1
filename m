Received: from eggs.gnu.org ([2001:4830:134:3::10]:50536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eoATS-00083D-GY
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eoATO-00026Q-Cv
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:08:58 -0500
References: <20180220150713.6056-1-pasic@linux.vnet.ibm.com>
	<20180220165323.02898d8a.cohuck@redhat.com>
	<c836fb0b-4af8-d5c0-a20d-194990f38326@redhat.com>
	<437eecac-036e-bbdd-a275-31dc0c812f32@de.ibm.com>
	<20180220170740.766b2234.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <054d7875-140c-c9c0-f5c3-db52e79feeac@redhat.com>
Date: Tue, 20 Feb 2018 17:08:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180220170740.766b2234.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 20.02.2018 17:07, Cornelia Huck wrote:
> On Tue, 20 Feb 2018 17:04:19 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 02/20/2018 04:55 PM, David Hildenbrand wrote:
>>> On 20.02.2018 16:53, Cornelia Huck wrote:  
>>>> On Tue, 20 Feb 2018 16:07:13 +0100
>>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>>  
>>>>> The 'bit' field of the 'S390FeatDef' structure is not applicable to all
>>>>> it's instances. Currently a this field is not applicable, and remains  
>>>>
>>>> s/it's/its/
>>>>
>>>> s/a this/this/
>>>>  
>>>>> unused, iff the feature is of type S390_FEAT_TYPE_MISC. Having the value 0
>>>>> specified for multiple such feature definition  was a little confusing,
>>>>> as it's a perfectly legit bit value, and as usually the value of the bit
>>>>> field is ought to be unique for each feature.
>>>>>
>>>>> Let's document this, and hopefully reduce the potential for confusion.
>>>>>
>>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>>> ---
>>>>>
>>>>> Hi!
>>>>>
>>>>> This may be an overkill. A comment where the misc features
>>>>> are defined would do to, but I think this is nicer. So
>>>>> I decided to try it with this approach first.  
>>>>
>>>> Is there likely to be anything else than FEAT_MISC _not_ using .bit? If
>>>> not, would it be better to at a comment to the FEAT_MISC definition?  
>>>
>>> Doubt it right now. I would sign the "overkill" part :)  
>>
>> I can cconfirm that this code caused some questions and it took me some
>> minutes to remember why 0 and 0 was ok. So I certainly want to have a comment
>> of some form.
>>
> 
> I'd prefer a comment about FEAT_MISC usage rather than a magic value.
> 

We can also add FEAT_INIT_MISC. And add a comment in the initializer.

-- 

Thanks,

David / dhildenb
