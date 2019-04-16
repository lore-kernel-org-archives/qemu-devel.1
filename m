Received: from eggs.gnu.org ([209.51.188.92]:43908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGK9V-00040u-R6
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGK9T-000467-V4
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:13:17 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-10-david@redhat.com>
	<71ce854d-da00-565e-0b36-9458a7bc9183@linaro.org>
	<a7298c65-fea3-7839-6b68-5b3bf5d64c1a@redhat.com>
	<7e9ca895-031e-9843-8617-491e72a330e7@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5f193a1c-5695-1759-1b06-dd404ebd1854@redhat.com>
Date: Tue, 16 Apr 2019 11:13:07 +0200
MIME-Version: 1.0
In-Reply-To: <7e9ca895-031e-9843-8617-491e72a330e7@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 09/41] s390x/tcg: Implement VECTOR
 CHECKSUM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 16.04.19 11:08, Richard Henderson wrote:
> On 4/15/19 10:58 PM, David Hildenbrand wrote:
>>> You could use
>>>
>>>   tcg_gen_add2_i32(sum, tmp, sum, zero, tmp, zero);
>>>   tcg_gen_add_i32(sum, sum, tmp);
>> That makes perfect sense, I will use that for now, thanks!
>>
> 
> Here's a funny one.  We can do this in one operation:
> 
>   tcg_gen_add2_i32(tmp, sum, sum, sum, tmp, tmp);

:D I had to look at it 10 times. Very nice trick.

> 
> The lower (sum+tmp) carries into the upper (sum+tmp).
> We take the upper result and discard the lower.
> 
> 
> r~
> 


-- 

Thanks,

David / dhildenb
