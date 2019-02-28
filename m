Received: from eggs.gnu.org ([209.51.188.92]:40842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHfh-0001zD-T0
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHff-0003Dd-Sz
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:08:04 -0500
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-26-david@redhat.com>
	<f76916bb-ef7e-e734-e675-2f2d520c1ee3@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <224fa006-9acc-6c81-dc76-8b7aca3b14f8@redhat.com>
Date: Thu, 28 Feb 2019 10:07:52 +0100
MIME-Version: 1.0
In-Reply-To: <f76916bb-ef7e-e734-e675-2f2d520c1ee3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 25/33] s390x/tcg: Implement VECTOR
 REPLICATE IMMEDIATE
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

On 28.02.19 00:39, Richard Henderson wrote:
> On 2/26/19 3:39 AM, David Hildenbrand wrote:
>> +    tmp = tcg_temp_new_i64();
>> +    tcg_gen_movi_i64(tmp, data);
>> +    gen_gvec_dup_i64(es, get_field(s->fields, v1), tmp);
>> +    tcg_temp_free_i64(tmp);
>> +    return DISAS_NEXT;
> 
> Reuse the dupi8, dupi16, ... switch from one of the other patches upthread?

Yes, makes sense!

> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
