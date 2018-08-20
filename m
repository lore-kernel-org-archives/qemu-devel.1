Received: from eggs.gnu.org ([2001:4830:134:3::10]:55790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1frqsh-0000Ij-Uw
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1frqsZ-0004xN-3a
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:34:27 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1frqsW-0004pP-RQ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:34:21 -0400
Received: by mail-pl0-x242.google.com with SMTP id b90-v6so7678823plb.0
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 13:34:20 -0700 (PDT)
References: <20180816025452.21358-1-richard.henderson@linaro.org>
	<20180816025452.21358-4-richard.henderson@linaro.org>
	<20180817170359.GC7067@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b687794b-423a-330c-dfd5-ab96d2b58ae7@linaro.org>
Date: Mon, 20 Aug 2018 13:34:16 -0700
MIME-Version: 1.0
In-Reply-To: <20180817170359.GC7067@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] target/s390x: Convert to
 HAVE_CMPXCHG128 and HAVE_ATOMIC128
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

On 08/17/2018 10:03 AM, Emilio G. Cota wrote:
>> -        if (((4 << fc) | (1 << sc)) & mask) {
>> +        if ((HAVE_CMPXCHG128 ? 0 : fsize > max) ||
>> +            (HAVE_ATOMIC128  ? 0 : ssize > max)) {
> I don't know what fsize/ssize are, so this is hard to review
> for me--just opened the PoO for the first time ever, and I'm
> even more confused :-)

I've renamed the variables to swap_size and store_size;
hopefully that makes this clearer.


r~
