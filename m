Received: from eggs.gnu.org ([2001:4830:134:3::10]:58300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMFzd-00046Y-7T
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMFzY-0004CZ-AH
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:22:49 -0500
References: <20171204125505.29203-1-david@redhat.com>
	<20171204125505.29203-3-david@redhat.com>
	<89bee1c4-05f8-8f60-f5c7-2913cc1c3a41@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <45b9ad55-69b7-e039-f2bf-099ac15f487c@redhat.com>
Date: Tue, 5 Dec 2017 17:22:38 +0100
MIME-Version: 1.0
In-Reply-To: <89bee1c4-05f8-8f60-f5c7-2913cc1c3a41@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 2/5] s390x/tcg: fix and cleanup
 mcck injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>


>> @@ -426,7 +423,8 @@ static void do_mchk_interrupt(CPUS390XState *env)
>>      DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__,
>>              env->psw.mask, env->psw.addr);
>>  
>> -    load_psw(env, mask, addr);
>> +    load_psw(env, be64_to_cpu(lowcore->mcck_new_psw.mask),
>> +             be64_to_cpu(lowcore->mcck_new_psw.addr));
> 
> ... but here you still touch it? Looks like a bug to me...?

Indeed, didn't notice as the addresses won't change. Thanks!

> 
>  Thomas
> 


-- 

Thanks,

David / dhildenb
