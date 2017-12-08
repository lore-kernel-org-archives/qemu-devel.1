Received: from eggs.gnu.org ([2001:4830:134:3::10]:46480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNI2E-0005Bb-2L
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNI2C-0001C2-4b
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:45:46 -0500
References: <20171207153141.15523-1-david@redhat.com>
	<20171207153141.15523-5-david@redhat.com>
	<2e29bd7a-d0d2-bafd-0579-9c8235727c4c@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b17be673-28ab-98bb-1367-76f7f97157f1@redhat.com>
Date: Fri, 8 Dec 2017 13:45:40 +0100
MIME-Version: 1.0
In-Reply-To: <2e29bd7a-d0d2-bafd-0579-9c8235727c4c@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 4/5] s390x/tcg: indicate value
 of TODPR in STCKE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 08.12.2017 01:02, Richard Henderson wrote:
> On 12/07/2017 07:31 AM, David Hildenbrand wrote:
>> +    /* 16 bit value store in an uint32_t (only valid bits set) */
>> +    tcg_gen_ld32u_i64(todpr, cpu_env, offsetof(CPUS390XState, todpr));
> 
> Any reason not to use a uint16_t and use tcg_gen_ld16u_i64 here?
> 

Yes, KVM introduced and uses this field. As it is used for migration, we
cannot easily change it. (any maybe it was designed that way for future
changes)

> 
> r~
> 


-- 

Thanks,

David / dhildenb
