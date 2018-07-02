Received: from eggs.gnu.org ([2001:4830:134:3::10]:53571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZzmj-00046R-8d
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZzmg-00078f-3n
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:26:33 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:46188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fZzmf-000771-T4
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:26:30 -0400
Received: by mail-pl0-x244.google.com with SMTP id 30-v6so8034705pld.13
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 07:26:29 -0700 (PDT)
References: <20180628030330.15615-1-richard.henderson@linaro.org>
	<153049914837.615.12803592704677471272@946cad8fd14e>
	<20180702120119.GP24595@lianli.shorne-pla.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b6bd1555-1bc3-f7f4-ec3c-e6dfceee6507@linaro.org>
Date: Mon, 2 Jul 2018 07:26:26 -0700
MIME-Version: 1.0
In-Reply-To: <20180702120119.GP24595@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/23] target/openrisc improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On 07/02/2018 05:01 AM, Stafford Horne wrote:
>> ERROR: spaces required around that '*' (ctx:WxV)
>> #129: FILE: target/openrisc/disas.c:56:
>> +    arg_l_##opcode *a, uint32_t insn)                   \
>>                     ^
>>
>> ERROR: spaces required around that '*' (ctx:WxV)
>> #224: FILE: target/openrisc/disas.c:151:
>> +    arg_lf_##opcode##_##suffix *a, uint32_t insn)                \
>>                                 ^
> 
> I have fixed these on my branch.

These should not have been "fixed".

This is checkpatch being stupid and not realizing that
the thing on the left is a type and this is a pointer
declaration, not a multiplication.


r~
