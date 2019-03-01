Received: from eggs.gnu.org ([209.51.188.92]:47733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzm9B-0000L0-Le
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzm9A-0007pt-RD
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:40:33 -0500
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-23-david@redhat.com>
	<6ebfc2f2-9143-a24d-c4ea-bf04de27fcb4@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <10c0d51b-df9f-cbee-3d65-139c75355cda@redhat.com>
Date: Fri, 1 Mar 2019 18:40:17 +0100
MIME-Version: 1.0
In-Reply-To: <6ebfc2f2-9143-a24d-c4ea-bf04de27fcb4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/32] s390x/tcg: Implement VECTOR
 REPLICATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 01.03.19 18:35, Richard Henderson wrote:
> On 3/1/19 3:54 AM, David Hildenbrand wrote:
>> +    read_vec_element_i64(tmp, get_field(s->fields, v3), enr, es);
>> +    gen_gvec_dup_i64(es, get_field(s->fields, v1), tmp);
> 
> Ah!  I just remembered.  There is a special gvec primitive for this.
> 
>   tcg_gen_gvec_dup_mem(es, vec_full_reg_offset(v1),
>                        vec_reg_offset(v3, enr, es), 16, 16);
> 

Sweet - Thanks!


-- 

Thanks,

David / dhildenb
