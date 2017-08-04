Received: from eggs.gnu.org ([2001:4830:134:3::10]:57043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddfwC-0005Sv-GA
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddfw3-0007Al-5u
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:58:56 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:34157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddfw3-00079u-0x
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 12:58:51 -0400
Received: by mail-pg0-x233.google.com with SMTP id u185so10195906pgb.1
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 09:58:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170804054426.10590-1-rth@twiddle.net>
	<20170804054426.10590-23-rth@twiddle.net>
	<a9a144cb-0e9d-c6dc-c549-c2bd6a1836a9@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7490e99e-8276-2ffd-76cf-6983c8ba6b4a@twiddle.net>
Date: Fri, 4 Aug 2017 09:58:46 -0700
MIME-Version: 1.0
In-Reply-To: <a9a144cb-0e9d-c6dc-c549-c2bd6a1836a9@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 22/23] tcg/ppc: Look for shifted
 constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 08/04/2017 09:39 AM, Philippe Mathieu-Daudé wrote:
>>   @@ -638,6 +639,14 @@ static void tcg_out_movi_int(TCGContext *s, TCGType
>> type, TCGReg ret,
>>           return;
>>       }
>>   +    lsb = ctz64(arg);
>> +    high = arg >> lsb;
>> +    if (arg == (int16_t)arg) {
> 
> Can you move these here?
> 
> +    lsb = ctz64(arg);
> +    high = arg >> lsb;

No, because you've found a bug -- the if should be testing high, not arg.  ;-)

Thanks,


r~
