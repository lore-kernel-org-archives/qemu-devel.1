Received: from eggs.gnu.org ([2001:4830:134:3::10]:40227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB6GK-0000uS-D5
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB6GH-0000B1-91
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:18:12 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:46655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fB6GH-0000AT-3n
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:18:09 -0400
Received: by mail-qt0-x244.google.com with SMTP id m16-v6so942720qtg.13
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 15:18:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180423162523.6392-1-f4bug@amsat.org>
	<20180423162523.6392-2-f4bug@amsat.org>
	<CAFEAcA-p1-5YzcE-0mN4Wy-1oMtr_qfbntws5ynHrrg2FxEZuw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e7fba9cb-854b-dce8-2294-cbd37e6aaf4f@amsat.org>
Date: Tue, 24 Apr 2018 19:18:04 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-p1-5YzcE-0mN4Wy-1oMtr_qfbntws5ynHrrg2FxEZuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] bswap.h: Fix ldl_he_p() signedness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 04/23/2018 01:56 PM, Peter Maydell wrote:
> On 23 April 2018 at 17:25, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> As per the "Load and Store APIs" documentation (docs/devel/loads-stores.rst),
>> "No signed load operations are provided."
> 
> That phrase is used in the documentation sections for other
> kinds of load/store function, but not in the section for ld*_p
> and st*_p, which do provide both signed and unsigned flavours.
> 
>> Update lduw_he_p() to return as unsigned.
> 
> Code is changing a different function to the one named here...
> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/qemu/bswap.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
>> index 3f28f661b1..613978f838 100644
>> --- a/include/qemu/bswap.h
>> +++ b/include/qemu/bswap.h
>> @@ -330,9 +330,9 @@ static inline void stw_he_p(void *ptr, uint16_t v)
>>      memcpy(ptr, &v, sizeof(v));
>>  }
>>
>> -static inline int ldl_he_p(const void *ptr)
>> +static inline uint32_t ldl_he_p(const void *ptr)
> 
> This would make it not match the other ldl*_p functions
> (ldl_le_p, ldl_be_p).
> 
> The expectation with the ldl functions is that you're
> putting it into a variable of the right type and size,
> and so we don't need to provide both a signed 32 bit load
> and an unsigned 32 bit load.

OK, thank you for the clarification.

Regards,

Phil.
