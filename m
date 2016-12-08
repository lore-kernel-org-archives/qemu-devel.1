Received: from eggs.gnu.org ([2001:4830:134:3::10]:39586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cF3E9-0003bd-9C
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 13:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cF3E4-0004gi-BU
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 13:15:29 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cF3E4-0004MF-7j
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 13:15:24 -0500
Received: by mail-qt0-f195.google.com with SMTP id l20so49733750qta.1
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 10:15:03 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-43-git-send-email-rth@twiddle.net>
	<871sxiz4mh.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ebe1ea7b-f67c-6c70-988c-7ae0c7831faa@twiddle.net>
Date: Thu, 8 Dec 2016 10:13:58 -0800
MIME-Version: 1.0
In-Reply-To: <871sxiz4mh.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 42/64] tcg/arm: Handle ctz and clz
 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 12/08/2016 09:56 AM, Alex Bennée wrote:
>> +        if (c && a2 == 32) {
>> +            tcg_out_dat_reg(s, COND_AL, INSN_CLZ, a0, 0, a1, 0);
>> +            break;
>> +        }
>
> Why the early break instead of else leg?
>
>> +        tcg_out_dat_imm(s, COND_AL, ARITH_CMP, 0, a1, 0);
>> +        tcg_out_dat_reg(s, COND_NE, INSN_CLZ, a0, 0, a1, 0);
>> +        if (c || a0 != a2) {
>> +            tcg_out_dat_rIK(s, COND_EQ, ARITH_MOV, ARITH_MVN, a0, 0, a2, c);

It keeps this line under 80 columns, is all.


r~
