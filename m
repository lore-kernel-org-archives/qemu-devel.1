Received: from eggs.gnu.org ([2001:4830:134:3::10]:47395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1frppY-00075y-0h
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1frppM-00006A-P9
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:27:08 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:47052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1frppF-0008Td-GE
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:26:58 -0400
Received: by mail-pg1-x541.google.com with SMTP id f14-v6so7242891pgv.13
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 12:26:52 -0700 (PDT)
References: <20180816025452.21358-1-richard.henderson@linaro.org>
	<20180816025452.21358-2-richard.henderson@linaro.org>
	<20180817164253.GA7067@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a98cd262-d15a-e4b8-eb92-ce295e944c13@linaro.org>
Date: Mon, 20 Aug 2018 12:26:48 -0700
MIME-Version: 1.0
In-Reply-To: <20180817164253.GA7067@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] tcg: Split CONFIG_ATOMIC128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On 08/17/2018 09:42 AM, Emilio G. Cota wrote:
>> +/* Through gcc 8, aarch64 has no support for 128-bit at all.  */
>> +static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
>> +{
>> +    uint64_t cmpl = cmp, cmph = cmp >> 64;
>> +    uint64_t newl = new, newh = new >> 64;
> Here I'd use int128_getlo/hi, since we're not checking for
> CONFIG_INT128 (I'm thinking of old compilers here)

I suppose, but this is aarch64 -- there are no really old compilers.
The oldest is probably gcc 4.8, which already has __int128_t.

Thanks for the other catches too.


r~
