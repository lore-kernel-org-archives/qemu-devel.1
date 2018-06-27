Received: from eggs.gnu.org ([2001:4830:134:3::10]:45382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYD6D-0007KX-Op
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYD6A-0004Pb-JA
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:15:17 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:40776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYD6A-0004Nq-Bg
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:15:14 -0400
Received: by mail-pl0-x244.google.com with SMTP id t6-v6so1270135plo.7
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 09:15:14 -0700 (PDT)
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-20-richard.henderson@linaro.org>
	<66ecea9b-bc0b-371a-b834-0a9c0a4685ad@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <86822f08-52fb-7912-874b-b2f04d1d79b4@linaro.org>
Date: Wed, 27 Jun 2018 09:15:09 -0700
MIME-Version: 1.0
In-Reply-To: <66ecea9b-bc0b-371a-b834-0a9c0a4685ad@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 19/22] target/openrisc: Add
 print_insn_or1k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, shorne@gmail.com

On 06/27/2018 09:03 AM, Philippe Mathieu-Daudé wrote:
>> +INSN(lwa,    "r%d, %d(r%d)", a->d, a->i, a->a)
>> +INSN(lwz,    "r%d, %d(r%d)", a->d, a->i, a->a)
>> +INSN(lws,    "r%d, %d(r%d)", a->d, a->i, a->a)
>> +INSN(lbz,    "r%d, %d(r%d)", a->d, a->i, a->a)
>> +INSN(lbs,    "r%d, %d(r%d)", a->d, a->i, a->a)
>> +INSN(lhz,    "r%d, %d(r%d)", a->d, a->i, a->a)
>> +INSN(lhs,    "r%d, %d(r%d)", a->d, a->i, a->a)
>> +INSN(swa,    "%d(r%d), r%d", a->i, a->a, a->b)
>> +INSN(sw,     "%d(r%d), r%d", a->i, a->a, a->b)
>> +INSN(sb,     "%d(r%d), r%d", a->i, a->a, a->b)
>> +INSN(sh,     "%d(r%d), r%d", a->i, a->a, a->b)
> 
> You updated to use the offset(reg) notation, ok.

Yes, failure to match the usual format was confusing.

>> +INSN(nop,    "")
> 
> The nop previously displayed 'k', I suppose a left-over from sys/trap.

Yes, real nop has no argument.


r~
