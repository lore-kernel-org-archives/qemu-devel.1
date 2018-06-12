Received: from eggs.gnu.org ([2001:4830:134:3::10]:56532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSqTO-00047J-Ex
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 17:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSqTK-00052X-FY
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 17:05:02 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:37382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSqTK-000516-7h
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 17:04:58 -0400
Received: by mail-pl0-x242.google.com with SMTP id 31-v6so186722plc.4
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 14:04:58 -0700 (PDT)
References: <20180611171007.4165-1-peter.maydell@linaro.org>
	<20180611171007.4165-2-peter.maydell@linaro.org>
	<CAFEAcA9gcDabTxv7gaejegzq3bCuPkSNO6C5HRpaaJXVUk76tw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <90cda899-27e4-01ae-250f-4b149e21f5c9@linaro.org>
Date: Tue, 12 Jun 2018 11:04:53 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9gcDabTxv7gaejegzq3bCuPkSNO6C5HRpaaJXVUk76tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] bswap: Add new stn_*_p() and ldn_*_p()
 memory access functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>

On 06/11/2018 07:52 AM, Peter Maydell wrote:
> On 11 June 2018 at 18:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>> There's a common pattern in QEMU where a function needs to perform
>> a data load or store of an N byte integer in a particular endianness.
>> At the moment this is handled by doing a switch() on the size and
>> calling the appropriate ld*_p or st*_p function for each size.
>>
>> Provide a new family of functions ldn_*_p() and stn_*_p() which
>> take the size as an argument and do the switch() themselves.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  include/exec/cpu-all.h      |  4 +++
>>  include/qemu/bswap.h        | 52 +++++++++++++++++++++++++++++++++++++
>>  docs/devel/loads-stores.rst | 15 +++++++++++
>>  3 files changed, 71 insertions(+)
>>
>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>> index a635f532f97..07ec3808342 100644
>> --- a/include/exec/cpu-all.h
>> +++ b/include/exec/cpu-all.h
>> @@ -133,6 +133,8 @@ static inline void tswap64s(uint64_t *s)
>>  #define stq_p(p, v) stq_be_p(p, v)
>>  #define stfl_p(p, v) stfl_be_p(p, v)
>>  #define stfq_p(p, v) stfq_be_p(p, v)
>> +#define ldn_p(p, sz ldn_be_p(p, sz)
> 
> Silly typo here -- missing ')'.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
