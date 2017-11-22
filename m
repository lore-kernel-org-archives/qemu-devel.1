Received: from eggs.gnu.org ([2001:4830:134:3::10]:55519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHQGO-00075e-DO
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eHQGI-0001hM-G0
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:20:08 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:41555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eHQGI-0001h4-8r
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 03:20:02 -0500
Received: by mail-wm0-x230.google.com with SMTP id b189so8401671wmd.0
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 00:20:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20171109144155.17076-1-batuzovk@ispras.ru>
	<20171109144155.17076-4-batuzovk@ispras.ru>
	<c4be5f68-2093-db46-c917-953578a22d46@linaro.org>
Message-ID: <842a000d-11bf-a3f4-e1ac-8f0f6ed07324@linaro.org>
Date: Wed, 22 Nov 2017 09:19:58 +0100
MIME-Version: 1.0
In-Reply-To: <c4be5f68-2093-db46-c917-953578a22d46@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 3/3] tcg/optimize: handle vector loads
 and stores during copy propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/22/2017 09:06 AM, Richard Henderson wrote:
> On 11/09/2017 03:41 PM, Kirill Batuzov wrote:
>> +                    } else if (re == INDEX_op_mov_vec) {
>> +                        if (ts_are_copies(arg_temp(op->args[0]), ml->copy)) {
>> +                            tcg_op_remove(s, op);
>> +                            break;
>> +                        }
>> +                        op->opc = re;
>> +                        op->args[1] = temp_arg(find_better_copy(s, ml->copy));
>> +                        op->args[2] = op->args[3];
>>                      } else {
> 
> Why don't you send this through tcg_opt_gen_mov as with mov_i32 and mov_i64?

Oh nevermind, you're handling the extra size operand that was in v3.  Well,
good news is that you don't need that anymore.  ;-)


r~
