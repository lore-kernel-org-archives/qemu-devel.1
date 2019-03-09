Received: from eggs.gnu.org ([209.51.188.92]:39135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h2eye-00061H-8n
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 11:37:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h2eyd-0006Wj-KB
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 11:37:36 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:35169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h2eyd-0006Vi-BP
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 11:37:35 -0500
Received: by mail-pg1-x531.google.com with SMTP id e17so619976pgd.2
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 08:37:34 -0800 (PST)
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<20190307144126.31847-3-richard.henderson@linaro.org>
	<7f43300d-a86e-f4ef-e250-46c864409b73@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f41921d1-3714-60ed-5789-0841e84f1431@linaro.org>
Date: Sat, 9 Mar 2019 08:37:30 -0800
MIME-Version: 1.0
In-Reply-To: <7f43300d-a86e-f4ef-e250-46c864409b73@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/9] tcg: Add INDEX_op_extract2_{i32,i64}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: david@redhat.com

On 3/8/19 3:28 PM, Philippe Mathieu-Daudé wrote:
>> +        CASE_OP_32_64(extract2):
>> +            if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
>> +                TCGArg v1 = arg_info(op->args[1])->val;
>> +                TCGArg v2 = arg_info(op->args[2])->val;
>> +                tmp = (v1 >> op->args[3]) | (v2 << (64 - op->args[3]));
> Shouldn't this be:
> 
> tmp = (v1 >> op->args[3]) | (v2 << (TCG_TARGET_REG_BITS - op->args[3]));

No, but there should be different constants for the two cases.

Thanks.


r~
