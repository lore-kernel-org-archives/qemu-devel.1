Received: from eggs.gnu.org ([209.51.188.92]:46769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gr4bl-0000J3-C0
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gr4bk-0004Nm-OR
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:34:05 -0500
MIME-Version: 1.0
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 5 Feb 2019 18:33:48 +0100
Message-ID: <CABoDooNUh3SnTEN2-3d2NJf6E9d1tTMcfxxAqdD1On-qR4dbjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] ARM: another round of missed undefined instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello,

here are some missed undefined instructions I skipped over last time
(I had forgotten to enable FP16 support in QEMU):

- disas_simd_across_lanes: for FP16 FMAX/FMINV/FMAXNMV/FMINNMV it
should be checked that bit 0 of the size field is 0

- disas_simd_mod_imm: FP16 FMOV imm must have bit 29 = 0

- disas_simd_scalar_pairwise: FP16 FMAXP/FADPP/... must have bit 0 of
the size field = 0

- disas_simd_three_reg_same_fp16: opcodes 5, b, c, d, 11, 19, 1b, 1f
are unallocated

- disas_simd_two_reg_misc_fp16: FRECPX is a scalar only instruction

- disas_simd_two_reg_misc_fp16: FABS/FNEG/FSQRT are vector only instructions

- disas_simd_two_reg_misc_fp16: the default clause should undef in the
first switch statement

- disas_simd_two_reg_misc_fp16:  FNEG should be removed from the scalar part.

Hopefully that's all that was left...

Thanks,

Laurent
