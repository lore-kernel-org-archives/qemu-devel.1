Received: from eggs.gnu.org ([209.51.188.92]:41278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHhU-00039c-Gf
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHhO-0003pz-Ej
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:09:53 -0500
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-28-david@redhat.com>
	<4275baaf-f3c4-6a64-46bf-21a0e6d511c6@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e247fe1e-6326-1607-96ce-0cacb77d41f4@redhat.com>
Date: Thu, 28 Feb 2019 10:09:44 +0100
MIME-Version: 1.0
In-Reply-To: <4275baaf-f3c4-6a64-46bf-21a0e6d511c6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 27/33] s390x/tcg: Implement VECTOR SELECT
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

On 28.02.19 00:42, Richard Henderson wrote:
> On 2/26/19 3:39 AM, David Hildenbrand wrote:
>> +    tcg_gen_not_vec(vece, t, c);
>> +    tcg_gen_and_vec(vece, t, t, b);
> 
> tcg_gen_andc_vec(t, b, c);
> 
>> +    tcg_gen_not_i64(t, c);
>> +    tcg_gen_and_i64(t, b, t);
> 
> Likewise.
> 

Changed, thanks.


-- 

Thanks,

David / dhildenb
