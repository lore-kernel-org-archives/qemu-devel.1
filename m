Received: from eggs.gnu.org ([2001:4830:134:3::10]:59891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN4Kh-0002Su-EV
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN4Kb-0002wV-An
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:35:39 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN4Kb-0002wD-5e
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 17:35:33 -0400
Received: by mail-qt0-x242.google.com with SMTP id o21so21031907qtb.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 14:35:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170610223135.1731-1-f4bug@amsat.org> <87vanzitxx.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a8a14467-768e-ca8d-648a-4fb025579619@twiddle.net>
Date: Mon, 19 Jun 2017 14:35:29 -0700
MIME-Version: 1.0
In-Reply-To: <87vanzitxx.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: enable bswap16_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: "Emilio G . Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 06/13/2017 12:11 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> remove some copy/paste leftover, code seems sane.
>>
>> while running Alex Bennée's image aarch64-linux-3.15rc2-buildroot.img:
>>
>> Trace 0x7fa1904b0890 [0: ffffffc00036cd04]
>> ----------------
>> IN:
>> 0xffffffc00036cd24:  5ac00694      rev16 w20, w20
>>
>> OP:
>>   ---- ffffffc00036cd24 0000000000000000 0000000000000000
>>   ext32u_i64 tmp3,x20
>>   ext16u_i64 tmp2,tmp3
>>   bswap16_i64 x20,tmp2
>>   movi_i64 tmp4,$0x10
>>   shr_i64 tmp2,tmp3,tmp4
>>   ext16u_i64 tmp2,tmp2
>>   bswap16_i64 tmp2,tmp2
>>   deposit_i64 x20,x20,tmp2,$0x10,$0x10
>>
>> Linking TBs 0x7fa1904b0890 [ffffffc00036cd04] index 0 -> 0x7fa1904b0aa0 [ffffffc00036cd24]
>> Trace 0x7fa1904b0aa0 [0: ffffffc00036cd24]
>> TODO qemu/tci.c:1049: tcg_qemu_tb_exec()
>> qemu/tci.c:1049: tcg fatal error
>> Aborted
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Possibly the only person who has run tci recently ;-)

Is it time to remove it?  I'm pretty sure the only hosts for which it will work 
have proper backends...


r~
