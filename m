Received: from eggs.gnu.org ([2001:4830:134:3::10]:56941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPUAL-0001Kj-LY
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPUAH-0008G2-Jb
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:34:57 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPUAH-0008Fo-F4
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:34:53 -0400
Received: by mail-qt0-x242.google.com with SMTP id w6so201023qtg.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 06:34:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170625192125.9992-1-laurent@vivier.eu>
	<20170625192125.9992-4-laurent@vivier.eu>
	<d792cbf9-454a-1237-6c1a-02336a020d25@amsat.org>
	<2110ab22-2402-f84a-9bae-6fd68b570b77@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8ee7a344-4649-0d6f-3555-f652184546d5@twiddle.net>
Date: Mon, 26 Jun 2017 06:34:48 -0700
MIME-Version: 1.0
In-Reply-To: <2110ab22-2402-f84a-9bae-6fd68b570b77@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] target/m68k: add fsglmul and fsgldiv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 06/26/2017 01:05 AM, Laurent Vivier wrote:
>> floatx80_div()?
>>
> 
> Just to follow the spec of the instruction:
> 
> "if either operand requires more than 24 bits of mantissa to be
> accurately represented, the extraneous mantissa bits are truncated prior
> to the multiplication;"
> 
> Do you think I should keep them in floatx80 and use the floatx80_round()
> (I introduce latter in the series) to reduce the precision prior the
> floatx80_mul()?

Actually, yes.  The spec explicitly says that the exponent will be in extended 
precision.


r~
