Received: from eggs.gnu.org ([209.51.188.92]:33146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gyJKU-0007t5-Kd
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gyJKS-0003Nq-9z
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:42:10 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gyJKL-0003HB-53
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:42:04 -0500
Received: by mail-pl1-x642.google.com with SMTP id m10so4730399plt.10
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 08:41:54 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190225154204.26751-1-david@redhat.com>
	<1d0255c0-5b8d-2fca-d5e3-63b8f4b82d69@twiddle.net>
	<c3c62377-c947-02b9-6855-ea001dd85354@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7c7b0cb3-1dfa-d5da-9fdc-5484cdab7d8e@twiddle.net>
Date: Mon, 25 Feb 2019 08:41:50 -0800
MIME-Version: 1.0
In-Reply-To: <c3c62377-c947-02b9-6855-ea001dd85354@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tcg: Implement tcg_gen_shri2_i64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

On 2/25/19 8:36 AM, David Hildenbrand wrote:
> On 25.02.19 17:34, Richard Henderson wrote:
>> On 2/25/19 7:42 AM, David Hildenbrand wrote:
>>> +void tcg_gen_shri2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah, int64_t count)
>>
>> Actually, I now wonder if a better name might be tcg_gen_extract2_i64
>> (no other change to arguments, i.e. the "len" parameter that extract
>> has is fixed at 64).
>>
>> Thoughts?
> 
> That is actually a good idea. Maybe add a comment regarding len fixed to 64.
> 
> Shall I resend or do you want to fix it up?

I'll fix it up.


r~
