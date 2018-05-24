Received: from eggs.gnu.org ([2001:4830:134:3::10]:37129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fLz0A-0007DJ-IO
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fLz09-000145-At
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:46:30 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fLz09-000135-1i
	for qemu-devel@nongnu.org; Thu, 24 May 2018 18:46:29 -0400
Received: by mail-wr0-x243.google.com with SMTP id y15-v6so5899867wrg.11
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 15:46:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-27-git-send-email-mjc@sifive.com>
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-27-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 May 2018 15:45:57 -0700
Message-ID: <CAKmqyKNQjptj4_uDOKds1ywFHwBZm_OAjNhyUWFT8i6Dpm50+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 26/30] RISC-V: Remove unnecessary
 disassembler constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On Tue, May 22, 2018 at 5:15 PM, Michael Clark <mjc@sifive.com> wrote:
> Remove machine generated constraints that are not
> referenced by the pseudo-instruction constraints.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 138 ----------------------------------------------------------
>  1 file changed, 138 deletions(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 7fd1019623ee..27546dd7902c 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -87,33 +87,10 @@ typedef enum {
>
>  typedef enum {
>      rvc_end,
> -    rvc_simm_6,
> -    rvc_imm_6,
> -    rvc_imm_7,
> -    rvc_imm_8,
> -    rvc_imm_9,
> -    rvc_imm_10,
> -    rvc_imm_12,
> -    rvc_imm_18,
> -    rvc_imm_nz,
> -    rvc_imm_x2,
> -    rvc_imm_x4,
> -    rvc_imm_x8,
> -    rvc_imm_x16,
> -    rvc_rd_b3,
> -    rvc_rs1_b3,
> -    rvc_rs2_b3,
> -    rvc_rd_eq_rs1,
>      rvc_rd_eq_ra,
> -    rvc_rd_eq_sp,
>      rvc_rd_eq_x0,
> -    rvc_rs1_eq_sp,
>      rvc_rs1_eq_x0,
>      rvc_rs2_eq_x0,
> -    rvc_rd_ne_x0_x2,
> -    rvc_rd_ne_x0,
> -    rvc_rs1_ne_x0,
> -    rvc_rs2_ne_x0,
>      rvc_rs2_eq_rs1,
>      rvc_rs1_eq_ra,
>      rvc_imm_eq_zero,
> @@ -2522,111 +2499,16 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
>      uint8_t rd = dec->rd, rs1 = dec->rs1, rs2 = dec->rs2;
>      while (*c != rvc_end) {
>          switch (*c) {
> -        case rvc_simm_6:
> -            if (!(imm >= -32 && imm < 32)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_imm_6:
> -            if (!(imm <= 63)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_imm_7:
> -            if (!(imm <= 127)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_imm_8:
> -            if (!(imm <= 255)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_imm_9:
> -            if (!(imm <= 511)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_imm_10:
> -            if (!(imm <= 1023)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_imm_12:
> -            if (!(imm <= 4095)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_imm_18:
> -            if (!(imm <= 262143)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_imm_nz:
> -            if (!(imm != 0)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_imm_x2:
> -            if (!((imm & 0b1) == 0)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_imm_x4:
> -            if (!((imm & 0b11) == 0)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_imm_x8:
> -            if (!((imm & 0b111) == 0)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_imm_x16:
> -            if (!((imm & 0b1111) == 0)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_rd_b3:
> -            if (!(rd  >= 8 && rd  <= 15)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_rs1_b3:
> -            if (!(rs1 >= 8 && rs1 <= 15)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_rs2_b3:
> -            if (!(rs2 >= 8 && rs2 <= 15)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_rd_eq_rs1:
> -            if (!(rd == rs1)) {
> -                return false;
> -            }
> -            break;
>          case rvc_rd_eq_ra:
>              if (!(rd == 1)) {
>                  return false;
>              }
>              break;
> -        case rvc_rd_eq_sp:
> -            if (!(rd == 2)) {
> -                return false;
> -            }
> -            break;
>          case rvc_rd_eq_x0:
>              if (!(rd == 0)) {
>                  return false;
>              }
>              break;
> -        case rvc_rs1_eq_sp:
> -            if (!(rs1 == 2)) {
> -                return false;
> -            }
> -            break;
>          case rvc_rs1_eq_x0:
>              if (!(rs1 == 0)) {
>                  return false;
> @@ -2637,26 +2519,6 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
>                  return false;
>              }
>              break;
> -        case rvc_rd_ne_x0_x2:
> -            if (!(rd != 0 && rd != 2)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_rd_ne_x0:
> -            if (!(rd != 0)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_rs1_ne_x0:
> -            if (!(rs1 != 0)) {
> -                return false;
> -            }
> -            break;
> -        case rvc_rs2_ne_x0:
> -            if (!(rs2 != 0)) {
> -                return false;
> -            }
> -            break;
>          case rvc_rs2_eq_rs1:
>              if (!(rs2 == rs1)) {
>                  return false;
> --
> 2.7.0
>
>
