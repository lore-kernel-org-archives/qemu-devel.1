Received: from eggs.gnu.org ([2001:4830:134:3::10]:49621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eoAPD-0005Tn-6n
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eoAP7-0000GK-HG
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:04:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eoAP7-0000DD-9K
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:04:29 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1KFxtlQ132897
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 11:04:26 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g8m3xg67y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 11:04:25 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 20 Feb 2018 16:04:23 -0000
References: <20180220150713.6056-1-pasic@linux.vnet.ibm.com>
	<20180220165323.02898d8a.cohuck@redhat.com>
	<c836fb0b-4af8-d5c0-a20d-194990f38326@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 20 Feb 2018 17:04:19 +0100
MIME-Version: 1.0
In-Reply-To: <c836fb0b-4af8-d5c0-a20d-194990f38326@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <437eecac-036e-bbdd-a275-31dc0c812f32@de.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>



On 02/20/2018 04:55 PM, David Hildenbrand wrote:
> On 20.02.2018 16:53, Cornelia Huck wrote:
>> On Tue, 20 Feb 2018 16:07:13 +0100
>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>
>>> The 'bit' field of the 'S390FeatDef' structure is not applicable to all
>>> it's instances. Currently a this field is not applicable, and remains
>>
>> s/it's/its/
>>
>> s/a this/this/
>>
>>> unused, iff the feature is of type S390_FEAT_TYPE_MISC. Having the value 0
>>> specified for multiple such feature definition  was a little confusing,
>>> as it's a perfectly legit bit value, and as usually the value of the bit
>>> field is ought to be unique for each feature.
>>>
>>> Let's document this, and hopefully reduce the potential for confusion.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> ---
>>>
>>> Hi!
>>>
>>> This may be an overkill. A comment where the misc features
>>> are defined would do to, but I think this is nicer. So
>>> I decided to try it with this approach first.
>>
>> Is there likely to be anything else than FEAT_MISC _not_ using .bit? If
>> not, would it be better to at a comment to the FEAT_MISC definition?
> 
> Doubt it right now. I would sign the "overkill" part :)

I can cconfirm that this code caused some questions and it took me some
minutes to remember why 0 and 0 was ok. So I certainly want to have a comment
of some form.
