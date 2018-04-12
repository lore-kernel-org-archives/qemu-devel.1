Received: from eggs.gnu.org ([2001:4830:134:3::10]:38792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f6bR4-00036F-2T
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f6bR1-0004NP-F1
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:34:42 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:36804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f6bR1-0004Lz-0O
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:34:39 -0400
References: <20180412115838.10208-1-alex.bennee@linaro.org>
	<20180412115838.10208-3-alex.bennee@linaro.org>
	<CAFEAcA_9F3s5h8r-BGF2K_3-qgs7qUzpQQpjwtn+CdgUF-9zkg@mail.gmail.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <8a3b838f-70ce-33ec-db83-ee4fa2aad3a0@mail.uni-paderborn.de>
Date: Thu, 12 Apr 2018 14:34:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_9F3s5h8r-BGF2K_3-qgs7qUzpQQpjwtn+CdgUF-9zkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] fpu/softfloat: raise float_invalid
 for NaN in float_to_int
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 04/12/2018 02:26 PM, Peter Maydell wrote:
> On 12 April 2018 at 12:58, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Fixes https://bugs.launchpad.net/qemu/+bug/1759264
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> ---
>>  fpu/softfloat.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>> index 9b99aa6ec8..ddc77c273c 100644
>> --- a/fpu/softfloat.c
>> +++ b/fpu/softfloat.c
>> @@ -1344,6 +1344,7 @@ static int64_t round_to_int_and_pack(FloatParts in, int rmode,
>>      case float_class_qnan:
>>      case float_class_dnan:
>>      case float_class_msnan:
>> +        s->float_exception_flags = orig_flags | float_flag_invalid;
>>          return max;
>>      case float_class_inf:
>>          return p.sign ? min : max;
> 
> Don't we also need to raise the Invalid flag for float_class_inf ?
> 

Yup, as mentioned in the bug report.

Cheers,
Bastian
