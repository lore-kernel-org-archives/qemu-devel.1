Received: from eggs.gnu.org ([2001:4830:134:3::10]:49884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cqcGs-00013U-Um
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cqcGr-0005q5-2l
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:09:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cqcGq-0005pp-TR
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:09:33 -0400
References: <20170130131517.8092-1-sw@weilnetz.de>
	<d2935727-a192-878d-49fe-77d6c4f14fb1@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f3a081cb-42ca-ff12-83ce-51ec19c3e447@redhat.com>
Date: Wed, 22 Mar 2017 10:09:28 +0100
MIME-Version: 1.0
In-Reply-To: <d2935727-a192-878d-49fe-77d6c4f14fb1@de.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 22.03.2017 10:07, Christian Borntraeger wrote:
> On 01/30/2017 02:15 PM, Stefan Weil wrote:
>> Returning NULL from get_max_cpu_model results in a SIGSEGV runtime error.
>>
>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>> ---
>>
>> v2: Re-sent as v1 was damaged by my mailer.
>>
>> This is also broken in Debian.
>>
>> In addition, there is no default CPU ("any"), so binfmt and related
>> actions currently don't work. I hacked my local installation by
>> duplicating the "qemu" cpu definition for "any", but maybe there is
>> a better solution.
> 
> applied to our tree. Do we need cc stable as well?

Yes, I think so.

Thanks!

-- 

Thanks,

David
