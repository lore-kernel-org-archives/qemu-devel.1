Received: from eggs.gnu.org ([2001:4830:134:3::10]:44205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cP4Xt-0001I1-8c
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 04:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cP4Xp-0000wg-Ce
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 04:41:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cP4Xp-0000wA-6N
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 04:41:13 -0500
References: <1463570440-29685-1-git-send-email-jitendra.kolhe@hpe.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C34811E@shsmsx102.ccr.corp.intel.com>
	<ebc6d79a-833d-5413-8617-b3252bc45a07@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C34BC76@shsmsx102.ccr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a21b2517-08ec-653a-2e1e-9b8c325d3267@redhat.com>
Date: Thu, 5 Jan 2017 10:41:02 +0100
MIME-Version: 1.0
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3C34BC76@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
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


>>
>> If we want to actually host enforce (disallow) access to inflated pages, having
>
> Is that a new feature?

Still in the design phase. Andrea Arcangeli briefly mentioned in in his
reply to v5 of your patch series

"We also plan to use userfaultfd to make the balloon driver host
enforced (will work fine on hugetlbfs 2M and tmpfs too) but that's
going to be invisible to the ABI so it's not strictly relevant for
this discussion."

>
>> such a bitmap in QEMU is required. Getting them from the guest doesn't
>> make sense in that context anymore.
>
> Even a bitmap is required, we should avoid to send it in the stop & copy stage.

yes, I agree.

Thanks!

>
> Thanks!
> Liang
>>
>> Thanks,
>> David
>>


-- 

David
