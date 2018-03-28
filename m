Received: from eggs.gnu.org ([2001:4830:134:3::10]:47333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f13iX-0003Rp-Kz
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f13iW-0005bA-SM
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:33:49 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:45167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f13iW-0005b3-IZ
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 01:33:48 -0400
Received: by mail-oi0-x22f.google.com with SMTP id 71-v6so1090061oie.12
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 22:33:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <11555693-5ceb-883f-70b7-b6fb62b00528@linaro.org>
References: <1521926678-76539-1-git-send-email-mjc@sifive.com>
	<3cc72690-683f-a264-033c-25a2947f40fe@linaro.org>
	<CAHNT7Ntgkq+j1LfO9rGQPyS+qG0YHtXAtd4ZiGc6q3j8HJJ7yQ@mail.gmail.com>
	<11555693-5ceb-883f-70b7-b6fb62b00528@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 27 Mar 2018 22:33:47 -0700
Message-ID: <CAHNT7NvwBftXQy_GkjurYqqqhEgNJ3kTJ1rLeKhGh5WbM2nOeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>

On Tue, Mar 27, 2018 at 5:35 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 03/28/2018 01:43 AM, Michael Clark wrote:
> >     > +    if ((ct & TCG_CT_CONST_N12) && val >= -2047 && val <= 2047) {
> >
> >     +2048?
>

Yes of course, you're right. It's safe. I just hadn't thought about it
carefully enough.


> > We use this constraint for a negatable immediate and the constraint is
> only
> > applied to sub. We have no subi, so we implement subi as addi rd, rs1,
> -imm
> >
> >     case INDEX_op_sub_i32:
> >         if (c2) {
> >             tcg_out_opc_imm(s, is32bit ? OPC_ADDI : OPC_ADDIW, a0, a1,
> -a2);
> >         } else {
> >             tcg_out_opc_reg(s, is32bit ? OPC_SUB : OPC_SUBW, a0, a1, a2);
> >         }
> >         break;
>
> That's my point.  The "positive" range for addition is -2048...2047, so the
> "negative" range for subtraction should be -2047...2048.
>

Got it. Thanks.
