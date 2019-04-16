Received: from eggs.gnu.org ([209.51.188.92]:36811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGRnT-0003Qi-Sn
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGRnS-0006RS-Ve
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:23:03 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGRnS-0006Pz-Iz
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:23:02 -0400
Received: by mail-pf1-x444.google.com with SMTP id z5so10734455pfn.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:23:02 -0700 (PDT)
References: <20190401031155.21293-1-richard.henderson@linaro.org>
	<20190401031155.21293-4-richard.henderson@linaro.org>
	<c6b66db9-24d5-b55b-8b45-e73f3d7c3fba@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <50effb1c-3bbe-126b-9bfb-0b65eacc9c36@linaro.org>
Date: Tue, 16 Apr 2019 07:22:55 -1000
MIME-Version: 1.0
In-Reply-To: <c6b66db9-24d5-b55b-8b45-e73f3d7c3fba@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 3/8] target/riscv: Merge argument
 sets for insn32 and insn16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: palmer@sifive.com, Alistair.Francis@wdc.com, qemu-riscv@nongnu.org

On 4/16/19 2:02 AM, Bastian Koppelmann wrote:
> 
> On 4/1/19 5:11 AM, Richard Henderson wrote:
>>     # *** RV64C Standard Extension (Quadrant 0) ***
>>   c_addi4spn        000    ........ ... 00 @ciw
>> -c_fld             001  ... ... .. ... 00 @cl_d
>> -c_lw              010  ... ... .. ... 00 @cl_w
>> +fld               001  ... ... .. ... 00 @cl_d
>> +lw                010  ... ... .. ... 00 @cl_w
> 
> This leads to a redefinition of arg_lw and arg_fld for which clang emits a
> warning as found by Peter as he wanted to merge the original pull request for
> RISC-V-dt. The same goes for all other merged args.

I thought that would be handled by the #pragma, but it seems
that we need another one for clang-6.


r~


diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index fb66e886bf..c96c616539 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -695,6 +695,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
  */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wredundant-decls"
+#pragma GCC diagnostic ignored "-Wtypedef-redefinition"

 #include "decode_insn16.inc.c"
