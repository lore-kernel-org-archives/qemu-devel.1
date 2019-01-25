Received: from eggs.gnu.org ([209.51.188.92]:46189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gn7nk-0007MK-69
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gn7ni-0001ed-5A
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:10:08 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:43659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gn7ng-0001dL-87
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:10:05 -0500
Received: by mail-pg1-x52c.google.com with SMTP id v28so4630732pgk.10
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 12:10:03 -0800 (PST)
References: <20190123225705.28963-1-richard.henderson@linaro.org>
	<20190123225705.28963-5-richard.henderson@linaro.org>
	<87h8dwzh4j.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0e193b50-d768-c3b0-2b18-4edc86906465@linaro.org>
Date: Fri, 25 Jan 2019 12:09:59 -0800
MIME-Version: 1.0
In-Reply-To: <87h8dwzh4j.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/13] tcg/aarch64: enable dynamic TLB
 sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, cota@braap.org

On 1/25/19 11:12 AM, Alex Bennée wrote:
>> +    if (table_ofs > 0xfff) {
>> +        int table_hi = table_ofs & ~0xfff;
>> +        int mask_hi = mask_ofs & ~0xfff;
> 
> Isn't there a #define for this number here?

No.  I don't know what I'd call it, either.
You're just Supposed to Know that arm memory offsets are 12 bits.  ;-P


r~
