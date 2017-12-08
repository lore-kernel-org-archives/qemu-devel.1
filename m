Received: from eggs.gnu.org ([2001:4830:134:3::10]:47763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNI7w-0006Y7-9P
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNI7t-0004hp-40
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:51:40 -0500
References: <20171207165355.7559-1-david@redhat.com>
	<20171207165355.7559-2-david@redhat.com>
	<c49db6d7-55fa-84df-ffd5-ca7fa46da698@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <06f5967d-9aa4-5e43-013c-dd2232764d24@redhat.com>
Date: Fri, 8 Dec 2017 13:51:32 +0100
MIME-Version: 1.0
In-Reply-To: <c49db6d7-55fa-84df-ffd5-ca7fa46da698@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 01/10] s390x/tcg: ASI/ASGI are
 atomic with interlocked-acccess facility 1
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

On 08.12.2017 00:41, Richard Henderson wrote:
> On 12/07/2017 08:53 AM, David Hildenbrand wrote:
>> +static ExitStatus op_asi(DisasContext *s, DisasOps *o)
>> +{
>> +    o->in1 = tcg_temp_new_i64();
>> +    /* Perform the atomic addition in memory. */
>> +    tcg_gen_atomic_fetch_add_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
>> +                                 s->insn->data);
>> +    /* However, we need to recompute the addition for setting CC.  */
>> +    tcg_gen_add_i64(o->out, o->in1, o->in2);
>> +    return NO_EXIT;
>> +}
> 
> Is it worth conditionalizing the atomic operation on having
> interlocked-access-facility-1 enabled?
> 

Should be easily doable with a few LOC. Will give it a shot.

> 
> r~
> 


-- 

Thanks,

David / dhildenb
