Received: from eggs.gnu.org ([2001:4830:134:3::10]:39764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cP8OI-0006E3-DX
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 08:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cP8OE-0008C5-FG
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 08:47:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cP8OE-0008Bn-8h
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 08:47:34 -0500
References: <1463570440-29685-1-git-send-email-jitendra.kolhe@hpe.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C34811E@shsmsx102.ccr.corp.intel.com>
	<ebc6d79a-833d-5413-8617-b3252bc45a07@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C34BC76@shsmsx102.ccr.corp.intel.com>
	<a21b2517-08ec-653a-2e1e-9b8c325d3267@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C34C20B@shsmsx102.ccr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <743b6631-4615-e9a1-ca24-26bc8e089203@redhat.com>
Date: Thu, 5 Jan 2017 14:47:25 +0100
MIME-Version: 1.0
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3C34C20B@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] migration: skip scanning and
 migrating ram pages released by virtio-balloon driver.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Li, Liang Z" <liang.z.li@intel.com>, Jitendra Kolhe <jitendra.kolhe@hpe.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "simhan@hpe.com" <simhan@hpe.com>, "JBottomley@Odin.com" <JBottomley@Odin.com>, "armbru@redhat.com" <armbru@redhat.com>, "lcapitulino@redhat.com" <lcapitulino@redhat.com>, "renganathan.meenakshisundaram@hpe.com" <renganathan.meenakshisundaram@hpe.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mst@redhat.com" <mst@redhat.com>, "mohan_parthasarathy@hpe.com" <mohan_parthasarathy@hpe.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "den@openvz.org" <den@openvz.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

Am 05.01.2017 um 11:15 schrieb Li, Liang Z:
>>>> If we want to actually host enforce (disallow) access to inflated
>>>> pages, having
>>>
>>> Is that a new feature?
>>
>> Still in the design phase. Andrea Arcangeli briefly mentioned in in his reply to
>> v5 of your patch series
>>
>> "We also plan to use userfaultfd to make the balloon driver host enforced
>> (will work fine on hugetlbfs 2M and tmpfs too) but that's going to be invisible
>> to the ABI so it's not strictly relevant for this discussion."
>>
>
> Looking forward to see more details. Is there any thread about the design?
>

Not yet, we're still evaluating possible approaches. As soon as we
sorted out the details, we'll start a discussion thread. I'll put you
on cc!

Thanks!

> Thanks!
>
> Liang
>
>>>
>>>> such a bitmap in QEMU is required. Getting them from the guest
>>>> doesn't make sense in that context anymore.
>>>
>>> Even a bitmap is required, we should avoid to send it in the stop & copy
>> stage.
>>
>> yes, I agree.
>>
>> Thanks!


-- 

David
