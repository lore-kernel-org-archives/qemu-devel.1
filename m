Received: from eggs.gnu.org ([209.51.188.92]:42954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hGK59-0001fc-DV
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hGK57-00025X-Np
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:08:46 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-10-david@redhat.com>
	<71ce854d-da00-565e-0b36-9458a7bc9183@linaro.org>
	<a7298c65-fea3-7839-6b68-5b3bf5d64c1a@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7e9ca895-031e-9843-8617-491e72a330e7@twiddle.net>
Date: Mon, 15 Apr 2019 23:08:32 -1000
MIME-Version: 1.0
In-Reply-To: <a7298c65-fea3-7839-6b68-5b3bf5d64c1a@redhat.com>
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
To: David Hildenbrand <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 4/15/19 10:58 PM, David Hildenbrand wrote:
>> You could use
>>
>>   tcg_gen_add2_i32(sum, tmp, sum, zero, tmp, zero);
>>   tcg_gen_add_i32(sum, sum, tmp);
> That makes perfect sense, I will use that for now, thanks!
> 

Here's a funny one.  We can do this in one operation:

  tcg_gen_add2_i32(tmp, sum, sum, sum, tmp, tmp);

The lower (sum+tmp) carries into the upper (sum+tmp).
We take the upper result and discard the lower.


r~
