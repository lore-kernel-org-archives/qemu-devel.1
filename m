Received: from eggs.gnu.org ([2001:4830:134:3::10]:56389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0z4I-0002Si-Kq
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0z4F-0000dr-I3
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:35:58 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:40436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f0z4F-0000cP-Be
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 20:35:55 -0400
Received: by mail-pf0-x242.google.com with SMTP id y66so273968pfi.7
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 17:35:54 -0700 (PDT)
References: <1521926678-76539-1-git-send-email-mjc@sifive.com>
	<3cc72690-683f-a264-033c-25a2947f40fe@linaro.org>
	<CAHNT7Ntgkq+j1LfO9rGQPyS+qG0YHtXAtd4ZiGc6q3j8HJJ7yQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <11555693-5ceb-883f-70b7-b6fb62b00528@linaro.org>
Date: Wed, 28 Mar 2018 08:35:45 +0800
MIME-Version: 1.0
In-Reply-To: <CAHNT7Ntgkq+j1LfO9rGQPyS+qG0YHtXAtd4ZiGc6q3j8HJJ7yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1] RISC-V: RISC-V TCG backend work in
 progress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>

On 03/28/2018 01:43 AM, Michael Clark wrote:
>     > +    if ((ct & TCG_CT_CONST_N12) && val >= -2047 && val <= 2047) {
> 
>     +2048?
> 
> We use this constraint for a negatable immediate and the constraint is only
> applied to sub. We have no subi, so we implement subi as addi rd, rs1, -imm
> 
>     case INDEX_op_sub_i32:
>         if (c2) {
>             tcg_out_opc_imm(s, is32bit ? OPC_ADDI : OPC_ADDIW, a0, a1, -a2);
>         } else {
>             tcg_out_opc_reg(s, is32bit ? OPC_SUB : OPC_SUBW, a0, a1, a2);
>         }
>         break;

That's my point.  The "positive" range for addition is -2048...2047, so the
"negative" range for subtraction should be -2047...2048.


r~
