Received: from eggs.gnu.org ([2001:4830:134:3::10]:41425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXnXv-0002fL-LQ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXnXs-0008Qb-Cl
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:30:27 -0500
References: <1544792887-14575-1-git-send-email-thuth@redhat.com>
	<d068a183-1162-c720-e5f0-16f168f2b607@de.ibm.com>
	<9f8c3d48-7404-b645-06e6-f44eab13d0e1@redhat.com>
	<098bd7bb-ec1b-93be-1dd6-52c4f8f33374@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fabab21c-268a-1b8f-87b4-ab8a86b76674@redhat.com>
Date: Fri, 14 Dec 2018 14:30:18 +0100
MIME-Version: 1.0
In-Reply-To: <098bd7bb-ec1b-93be-1dd6-52c4f8f33374@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Fix bad mask in time2tod()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org

On 2018-12-14 14:26, Christian Borntraeger wrote:
> 
> 
> On 14.12.2018 14:23, Thomas Huth wrote:
>> On 2018-12-14 14:15, Christian Borntraeger wrote:
>>>
>>>
>>> On 14.12.2018 14:08, Thomas Huth wrote:
>>>> The time2tod() function tries to deal with the 9 uppermost bits in the
>>>> time value, but uses the wrong mask for this: 0xff80000000000000 should
>>>> be used instead of 0xff10000000000000 here.
>>>>
>>>> Fixes: 14055ce53c2d901d826ffad7fb7d6bb8ab46bdfd
>>>
>>> Can you alsways have commit id and subject
>>>
>>> like
>>> Fixes: 14055ce53c2d ("s390x/tcg: avoid overflows in time2tod/tod2time")
>>
>> In https://wiki.qemu.org/Contribute/SubmitAPatch we currently have:
>>
>>  Fixes: <full-SHA-commit-id>
> 
> Interesting. Linus strongly opposed to only have the commit id as people often
> do cut and paste errors so nobody could actually find out which commit was meant.
> So the Linux variant is not sha commit of at least 12 digits + subject.

Mentioning the title certainly makes sense, too, so feel free to extend
the Wiki page if you like!

 Thomas
