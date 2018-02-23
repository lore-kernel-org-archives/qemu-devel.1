Received: from eggs.gnu.org ([2001:4830:134:3::10]:37285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epHA7-00034V-1s
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:29:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epHA2-000062-4C
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:29:35 -0500
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:34249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epHA1-00005H-SJ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:29:30 -0500
Received: by mail-pf0-x229.google.com with SMTP id j20so350715pfi.1
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:29:29 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-22-richard.henderson@linaro.org>
	<CAFEAcA_sKYmMijPzaYaBzuNkJ3po7oMoV+JYwJ9OE9xRsr_Gvw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0d7c838f-822c-8ee5-9097-8ca2e0c9ab49@linaro.org>
Date: Fri, 23 Feb 2018 09:29:25 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_sKYmMijPzaYaBzuNkJ3po7oMoV+JYwJ9OE9xRsr_Gvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 21/67] target/arm: Implement
 SVE floating-point exponential accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 02/23/2018 05:48 AM, Peter Maydell wrote:
>> +void HELPER(sve_fexpa_d)(void *vd, void *vn, uint32_t desc)
>> +{
>> +    static const uint64_t coeff[] = {
>> +        0x0000000000000, 0x02C9A3E778061, 0x059B0D3158574, 0x0874518759BC8,
>> +        0x0B5586CF9890F, 0x0E3EC32D3D1A2, 0x11301D0125B51, 0x1429AAEA92DE0,
>> +        0x172B83C7D517B, 0x1A35BEB6FCB75, 0x1D4873168B9AA, 0x2063B88628CD6,
>> +        0x2387A6E756238, 0x26B4565E27CDD, 0x29E9DF51FDEE1, 0x2D285A6E4030B,
>> +        0x306FE0A31B715, 0x33C08B26416FF, 0x371A7373AA9CB, 0x3A7DB34E59FF7,
>> +        0x3DEA64C123422, 0x4160A21F72E2A, 0x44E086061892D, 0x486A2B5C13CD0,
>> +        0x4BFDAD5362A27, 0x4F9B2769D2CA7, 0x5342B569D4F82, 0x56F4736B527DA,
>> +        0x5AB07DD485429, 0x5E76F15AD2148, 0x6247EB03A5585, 0x6623882552225,
>> +        0x6A09E667F3BCD, 0x6DFB23C651A2F, 0x71F75E8EC5F74, 0x75FEB564267C9,
>> +        0x7A11473EB0187, 0x7E2F336CF4E62, 0x82589994CCE13, 0x868D99B4492ED,
>> +        0x8ACE5422AA0DB, 0x8F1AE99157736, 0x93737B0CDC5E5, 0x97D829FDE4E50,
>> +        0x9C49182A3F090, 0xA0C667B5DE565, 0xA5503B23E255D, 0xA9E6B5579FDBF,
>> +        0xAE89F995AD3AD, 0xB33A2B84F15FB, 0xB7F76F2FB5E47, 0xBCC1E904BC1D2,
>> +        0xC199BDD85529C, 0xC67F12E57D14B, 0xCB720DCEF9069, 0xD072D4A07897C,
>> +        0xD5818DCFBA487, 0xDA9E603DB3285, 0xDFC97337B9B5F, 0xE502EE78B3FF6,
>> +        0xEA4AFA2A490DA, 0xEFA1BEE615A27, 0xF50765B6E4540, 0xFA7C1819E90D8,
> 
> This confused me at first because it looks like these are 64-bit numbers
> but they are only 52 bits. Maybe comment? (or add the leading '000'?)

Interesting... I didn't even notice.  This was pure cut-and-paste from the
pseudocode.  As such, with the comment, I wouldn't modify them.


r~
