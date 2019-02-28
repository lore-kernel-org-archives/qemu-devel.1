Received: from eggs.gnu.org ([209.51.188.92]:60870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzH5v-0002rx-8C
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzH5u-0004Ti-LE
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:31:07 -0500
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-14-david@redhat.com>
	<d21b7c5f-8c54-6fde-84c5-a0799ad61142@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bdd6f0bb-6d8e-891f-e6b4-24bddc027b4b@redhat.com>
Date: Thu, 28 Feb 2019 09:30:59 +0100
MIME-Version: 1.0
In-Reply-To: <d21b7c5f-8c54-6fde-84c5-a0799ad61142@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 13/33] s390x/tcg: Implement VECTOR LOAD
 LOGICAL ELEMENT AND ZERO
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

On 27.02.19 16:56, Richard Henderson wrote:
> On 2/26/19 3:38 AM, David Hildenbrand wrote:
>> +    zero_vec(TMP_VREG_0);
>> +    load_vec_element(s, TMP_VREG_0, enr, o->addr1, es);
>> +    gen_gvec_mov(get_field(s->fields, v1), TMP_VREG_0);
> 
> load into TCGv_i64, zero real dest, store into real dest.
> 

Yes, can do!

-- 

Thanks,

David / dhildenb
