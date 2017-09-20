Received: from eggs.gnu.org ([2001:4830:134:3::10]:43846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1duSUl-0005r2-GR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1duSUi-000296-FL
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:04:03 -0400
MIME-Version: 1.0
In-Reply-To: <20170915150849.23557-1-peter.maydell@linaro.org>
References: <20170915150849.23557-1-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Sep 2017 17:03:27 -0700
Message-ID: <CAKmqyKPEtdXp2Dn2a2FuL-f_WVaRDEaY_3_=h=2kVobFm4z4QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Remove out of date ARM ARM
 section references in A64 decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Patch Tracking <patches@linaro.org>

On Fri, Sep 15, 2017 at 8:08 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> In the A64 decoder, we have a lot of references to section numbers
> from version A.a of the v8A ARM ARM (DDI0487). This version of the
> document is now long obsolete (we are currently on revision B.a),
> and various intervening versions renumbered all the sections.
>
> The most recent B.a version of the document doesn't assign
> section numbers at all to the individual instruction classes
> in the way that the various A.x versions did. The simplest thing
> to do is just to delete all the out of date C.x.x references.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Definitely a Friday afternoon kind of a patch...
>
>  target/arm/translate-a64.c | 227 +++++++++++++++++++++++----------------------
>  1 file changed, 114 insertions(+), 113 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 9017e30510..e04007376c 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1203,12 +1203,14 @@ static inline AArch64DecodeFn *lookup_disas_fn(const AArch64DecodeTable *table,
>  }
>
>  /*
> - * the instruction disassembly implemented here matches
> - * the instruction encoding classifications in chapter 3 (C3)
> - * of the ARM Architecture Reference Manual (DDI0487A_a)
> + * The instruction disassembly implemented here matches
> + * the instruction encoding classifications in chapter C4
> + * of the ARM Architecture Reference Manual (DDI0487B_a);
> + * classification names and decode diagrams here should generally
> + * match up with those in the manual.
>   */
>
> -/* C3.2.7 Unconditional branch (immediate)
> +/* Unconditional branch (immediate)
>   *   31  30       26 25                                  0
>   * +----+-----------+-------------------------------------+
>   * | op | 0 0 1 0 1 |                 imm26               |
> @@ -1219,15 +1221,15 @@ static void disas_uncond_b_imm(DisasContext *s, uint32_t insn)
>      uint64_t addr = s->pc + sextract32(insn, 0, 26) * 4 - 4;
>
>      if (insn & (1U << 31)) {
> -        /* C5.6.26 BL Branch with link */
> +        /* BL Branch with link */
>          tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
>      }
>
> -    /* C5.6.20 B Branch / C5.6.26 BL Branch with link */
> +    /* B Branch / BL Branch with link */
>      gen_goto_tb(s, 0, addr);
>  }
>
> -/* C3.2.1 Compare & branch (immediate)
> +/* Compare and branch (immediate)
>   *   31  30         25  24  23                  5 4      0
>   * +----+-------------+----+---------------------+--------+
>   * | sf | 0 1 1 0 1 0 | op |         imm19       |   Rt   |
> @@ -1256,7 +1258,7 @@ static void disas_comp_b_imm(DisasContext *s, uint32_t insn)
>      gen_goto_tb(s, 1, addr);
>  }
>
> -/* C3.2.5 Test & branch (immediate)
> +/* Test and branch (immediate)
>   *   31  30         25  24  23   19 18          5 4    0
>   * +----+-------------+----+-------+-------------+------+
>   * | b5 | 0 1 1 0 1 1 | op |  b40  |    imm14    |  Rt  |
> @@ -1285,7 +1287,7 @@ static void disas_test_b_imm(DisasContext *s, uint32_t insn)
>      gen_goto_tb(s, 1, addr);
>  }
>
> -/* C3.2.2 / C5.6.19 Conditional branch (immediate)
> +/* Conditional branch (immediate)
>   *  31           25  24  23                  5   4  3    0
>   * +---------------+----+---------------------+----+------+
>   * | 0 1 0 1 0 1 0 | o1 |         imm19       | o0 | cond |
> @@ -1316,7 +1318,7 @@ static void disas_cond_b_imm(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C5.6.68 HINT */
> +/* HINT instruction group, including various allocated HINTs */
>  static void handle_hint(DisasContext *s, uint32_t insn,
>                          unsigned int op1, unsigned int op2, unsigned int crm)
>  {
> @@ -1401,7 +1403,7 @@ static void handle_sync(DisasContext *s, uint32_t insn,
>      }
>  }
>
> -/* C5.6.130 MSR (immediate) - move immediate to processor state field */
> +/* MSR (immediate) - move immediate to processor state field */
>  static void handle_msr_i(DisasContext *s, uint32_t insn,
>                           unsigned int op1, unsigned int op2, unsigned int crm)
>  {
> @@ -1477,10 +1479,10 @@ static void gen_set_nzcv(TCGv_i64 tcg_rt)
>      tcg_temp_free_i32(nzcv);
>  }
>
> -/* C5.6.129 MRS - move from system register
> - * C5.6.131 MSR (register) - move to system register
> - * C5.6.204 SYS
> - * C5.6.205 SYSL
> +/* MRS - move from system register
> + * MSR (register) - move to system register
> + * SYS
> + * SYSL
>   * These are all essentially the same insn in 'read' and 'write'
>   * versions, with varying op0 fields.
>   */
> @@ -1603,7 +1605,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
>      }
>  }
>
> -/* C3.2.4 System
> +/* System
>   *  31                 22 21  20 19 18 16 15   12 11    8 7   5 4    0
>   * +---------------------+---+-----+-----+-------+-------+-----+------+
>   * | 1 1 0 1 0 1 0 1 0 0 | L | op0 | op1 |  CRn  |  CRm  | op2 |  Rt  |
> @@ -1626,13 +1628,13 @@ static void disas_system(DisasContext *s, uint32_t insn)
>              return;
>          }
>          switch (crn) {
> -        case 2: /* C5.6.68 HINT */
> +        case 2: /* HINT (including allocated hints like NOP, YIELD, etc) */
>              handle_hint(s, insn, op1, op2, crm);
>              break;
>          case 3: /* CLREX, DSB, DMB, ISB */
>              handle_sync(s, insn, op1, op2, crm);
>              break;
> -        case 4: /* C5.6.130 MSR (immediate) */
> +        case 4: /* MSR (immediate) */
>              handle_msr_i(s, insn, op1, op2, crm);
>              break;
>          default:
> @@ -1644,7 +1646,7 @@ static void disas_system(DisasContext *s, uint32_t insn)
>      handle_sys(s, insn, l, op0, op1, op2, crn, crm, rt);
>  }
>
> -/* C3.2.3 Exception generation
> +/* Exception generation
>   *
>   *  31             24 23 21 20                     5 4   2 1  0
>   * +-----------------+-----+------------------------+-----+----+
> @@ -1751,7 +1753,7 @@ static void disas_exc(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C3.2.7 Unconditional branch (register)
> +/* Unconditional branch (register)
>   *  31           25 24   21 20   16 15   10 9    5 4     0
>   * +---------------+-------+-------+-------+------+-------+
>   * | 1 1 0 1 0 1 1 |  opc  |  op2  |  op3  |  Rn  |  op4  |
> @@ -1806,7 +1808,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
>      s->base.is_jmp = DISAS_JUMP;
>  }
>
> -/* C3.2 Branches, exception generating and system instructions */
> +/* Branches, exception generating and system instructions */
>  static void disas_b_exc_sys(DisasContext *s, uint32_t insn)
>  {
>      switch (extract32(insn, 25, 7)) {
> @@ -1974,7 +1976,7 @@ static bool disas_ldst_compute_iss_sf(int size, bool is_signed, int opc)
>      return regsize == 64;
>  }
>
> -/* C3.3.6 Load/store exclusive
> +/* Load/store exclusive
>   *
>   *  31 30 29         24  23  22   21  20  16  15  14   10 9    5 4    0
>   * +-----+-------------+----+---+----+------+----+-------+------+------+
> @@ -2051,7 +2053,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
>  }
>
>  /*
> - * C3.3.5 Load register (literal)
> + * Load register (literal)
>   *
>   *  31 30 29   27  26 25 24 23                5 4     0
>   * +-----+-------+---+-----+-------------------+-------+
> @@ -2107,15 +2109,15 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
>  }
>
>  /*
> - * C5.6.80 LDNP (Load Pair - non-temporal hint)
> - * C5.6.81 LDP (Load Pair - non vector)
> - * C5.6.82 LDPSW (Load Pair Signed Word - non vector)
> - * C5.6.176 STNP (Store Pair - non-temporal hint)
> - * C5.6.177 STP (Store Pair - non vector)
> - * C6.3.165 LDNP (Load Pair of SIMD&FP - non-temporal hint)
> - * C6.3.165 LDP (Load Pair of SIMD&FP)
> - * C6.3.284 STNP (Store Pair of SIMD&FP - non-temporal hint)
> - * C6.3.284 STP (Store Pair of SIMD&FP)
> + * LDNP (Load Pair - non-temporal hint)
> + * LDP (Load Pair - non vector)
> + * LDPSW (Load Pair Signed Word - non vector)
> + * STNP (Store Pair - non-temporal hint)
> + * STP (Store Pair - non vector)
> + * LDNP (Load Pair of SIMD&FP - non-temporal hint)
> + * LDP (Load Pair of SIMD&FP)
> + * STNP (Store Pair of SIMD&FP - non-temporal hint)
> + * STP (Store Pair of SIMD&FP)
>   *
>   *  31 30 29   27  26  25 24   23  22 21   15 14   10 9    5 4    0
>   * +-----+-------+---+---+-------+---+-----------------------------+
> @@ -2261,9 +2263,9 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
>  }
>
>  /*
> - * C3.3.8 Load/store (immediate post-indexed)
> - * C3.3.9 Load/store (immediate pre-indexed)
> - * C3.3.12 Load/store (unscaled immediate)
> + * Load/store (immediate post-indexed)
> + * Load/store (immediate pre-indexed)
> + * Load/store (unscaled immediate)
>   *
>   * 31 30 29   27  26 25 24 23 22 21  20    12 11 10 9    5 4    0
>   * +----+-------+---+-----+-----+---+--------+-----+------+------+
> @@ -2379,7 +2381,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
>  }
>
>  /*
> - * C3.3.10 Load/store (register offset)
> + * Load/store (register offset)
>   *
>   * 31 30 29   27  26 25 24 23 22 21  20  16 15 13 12 11 10 9  5 4  0
>   * +----+-------+---+-----+-----+---+------+-----+--+-----+----+----+
> @@ -2476,7 +2478,7 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
>  }
>
>  /*
> - * C3.3.13 Load/store (unsigned immediate)
> + * Load/store (unsigned immediate)
>   *
>   * 31 30 29   27  26 25 24 23 22 21        10 9     5
>   * +----+-------+---+-----+-----+------------+-------+------+
> @@ -2587,14 +2589,14 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C3.3.1 AdvSIMD load/store multiple structures
> +/* AdvSIMD load/store multiple structures
>   *
>   *  31  30  29           23 22  21         16 15    12 11  10 9    5 4    0
>   * +---+---+---------------+---+-------------+--------+------+------+------+
>   * | 0 | Q | 0 0 1 1 0 0 0 | L | 0 0 0 0 0 0 | opcode | size |  Rn  |  Rt  |
>   * +---+---+---------------+---+-------------+--------+------+------+------+
>   *
> - * C3.3.2 AdvSIMD load/store multiple structures (post-indexed)
> + * AdvSIMD load/store multiple structures (post-indexed)
>   *
>   *  31  30  29           23 22  21  20     16 15    12 11  10 9    5 4    0
>   * +---+---+---------------+---+---+---------+--------+------+------+------+
> @@ -2719,14 +2721,14 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
>      tcg_temp_free_i64(tcg_addr);
>  }
>
> -/* C3.3.3 AdvSIMD load/store single structure
> +/* AdvSIMD load/store single structure
>   *
>   *  31  30  29           23 22 21 20       16 15 13 12  11  10 9    5 4    0
>   * +---+---+---------------+-----+-----------+-----+---+------+------+------+
>   * | 0 | Q | 0 0 1 1 0 1 0 | L R | 0 0 0 0 0 | opc | S | size |  Rn  |  Rt  |
>   * +---+---+---------------+-----+-----------+-----+---+------+------+------+
>   *
> - * C3.3.4 AdvSIMD load/store single structure (post-indexed)
> + * AdvSIMD load/store single structure (post-indexed)
>   *
>   *  31  30  29           23 22 21 20       16 15 13 12  11  10 9    5 4    0
>   * +---+---+---------------+-----+-----------+-----+---+------+------+------+
> @@ -2869,7 +2871,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
>      tcg_temp_free_i64(tcg_addr);
>  }
>
> -/* C3.3 Loads and stores */
> +/* Loads and stores */
>  static void disas_ldst(DisasContext *s, uint32_t insn)
>  {
>      switch (extract32(insn, 24, 6)) {
> @@ -2899,7 +2901,7 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C3.4.6 PC-rel. addressing
> +/* PC-rel. addressing
>   *   31  30   29 28       24 23                5 4    0
>   * +----+-------+-----------+-------------------+------+
>   * | op | immlo | 1 0 0 0 0 |       immhi       |  Rd  |
> @@ -2928,7 +2930,7 @@ static void disas_pc_rel_adr(DisasContext *s, uint32_t insn)
>  }
>
>  /*
> - * C3.4.1 Add/subtract (immediate)
> + * Add/subtract (immediate)
>   *
>   *  31 30 29 28       24 23 22 21         10 9   5 4   0
>   * +--+--+--+-----------+-----+-------------+-----+-----+
> @@ -3078,7 +3080,7 @@ static bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
>      return true;
>  }
>
> -/* C3.4.4 Logical (immediate)
> +/* Logical (immediate)
>   *   31  30 29 28         23 22  21  16 15  10 9    5 4    0
>   * +----+-----+-------------+---+------+------+------+------+
>   * | sf | opc | 1 0 0 1 0 0 | N | immr | imms |  Rn  |  Rd  |
> @@ -3151,7 +3153,7 @@ static void disas_logic_imm(DisasContext *s, uint32_t insn)
>  }
>
>  /*
> - * C3.4.5 Move wide (immediate)
> + * Move wide (immediate)
>   *
>   *  31 30 29 28         23 22 21 20             5 4    0
>   * +--+-----+-------------+-----+----------------+------+
> @@ -3203,7 +3205,7 @@ static void disas_movw_imm(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C3.4.2 Bitfield
> +/* Bitfield
>   *   31  30 29 28         23 22  21  16 15  10 9    5 4    0
>   * +----+-----+-------------+---+------+------+------+------+
>   * | sf | opc | 1 0 0 1 1 0 | N | immr | imms |  Rn  |  Rd  |
> @@ -3281,7 +3283,7 @@ static void disas_bitfield(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C3.4.3 Extract
> +/* Extract
>   *   31  30  29 28         23 22   21  20  16 15    10 9    5 4    0
>   * +----+------+-------------+---+----+------+--------+------+------+
>   * | sf | op21 | 1 0 0 1 1 1 | N | o0 |  Rm  |  imms  |  Rn  |  Rd  |
> @@ -3341,7 +3343,7 @@ static void disas_extract(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C3.4 Data processing - immediate */
> +/* Data processing - immediate */
>  static void disas_data_proc_imm(DisasContext *s, uint32_t insn)
>  {
>      switch (extract32(insn, 23, 6)) {
> @@ -3435,7 +3437,7 @@ static void shift_reg_imm(TCGv_i64 dst, TCGv_i64 src, int sf,
>      }
>  }
>
> -/* C3.5.10 Logical (shifted register)
> +/* Logical (shifted register)
>   *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
>   * +----+-----+-----------+-------+---+------+--------+------+------+
>   * | sf | opc | 0 1 0 1 0 | shift | N |  Rm  |  imm6  |  Rn  |  Rd  |
> @@ -3526,7 +3528,7 @@ static void disas_logic_reg(DisasContext *s, uint32_t insn)
>  }
>
>  /*
> - * C3.5.1 Add/subtract (extended register)
> + * Add/subtract (extended register)
>   *
>   *  31|30|29|28       24|23 22|21|20   16|15  13|12  10|9  5|4  0|
>   * +--+--+--+-----------+-----+--+-------+------+------+----+----+
> @@ -3599,7 +3601,7 @@ static void disas_add_sub_ext_reg(DisasContext *s, uint32_t insn)
>  }
>
>  /*
> - * C3.5.2 Add/subtract (shifted register)
> + * Add/subtract (shifted register)
>   *
>   *  31 30 29 28       24 23 22 21 20   16 15     10 9    5 4    0
>   * +--+--+--+-----------+-----+--+-------+---------+------+------+
> @@ -3662,13 +3664,12 @@ static void disas_add_sub_reg(DisasContext *s, uint32_t insn)
>      tcg_temp_free_i64(tcg_result);
>  }
>
> -/* C3.5.9 Data-processing (3 source)
> -
> -   31 30  29 28       24 23 21  20  16  15  14  10 9    5 4    0
> -  +--+------+-----------+------+------+----+------+------+------+
> -  |sf| op54 | 1 1 0 1 1 | op31 |  Rm  | o0 |  Ra  |  Rn  |  Rd  |
> -  +--+------+-----------+------+------+----+------+------+------+
> -
> +/* Data-processing (3 source)
> + *
> + *    31 30  29 28       24 23 21  20  16  15  14  10 9    5 4    0
> + *  +--+------+-----------+------+------+----+------+------+------+
> + *  |sf| op54 | 1 1 0 1 1 | op31 |  Rm  | o0 |  Ra  |  Rn  |  Rd  |
> + *  +--+------+-----------+------+------+----+------+------+------+
>   */
>  static void disas_data_proc_3src(DisasContext *s, uint32_t insn)
>  {
> @@ -3761,7 +3762,7 @@ static void disas_data_proc_3src(DisasContext *s, uint32_t insn)
>      tcg_temp_free_i64(tcg_tmp);
>  }
>
> -/* C3.5.3 - Add/subtract (with carry)
> +/* Add/subtract (with carry)
>   *  31 30 29 28 27 26 25 24 23 22 21  20  16  15   10  9    5 4   0
>   * +--+--+--+------------------------+------+---------+------+-----+
>   * |sf|op| S| 1  1  0  1  0  0  0  0 |  rm  | opcode2 |  Rn  |  Rd |
> @@ -3803,7 +3804,7 @@ static void disas_adc_sbc(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C3.5.4 - C3.5.5 Conditional compare (immediate / register)
> +/* Conditional compare (immediate / register)
>   *  31 30 29 28 27 26 25 24 23 22 21  20    16 15  12  11  10  9   5  4 3   0
>   * +--+--+--+------------------------+--------+------+----+--+------+--+-----+
>   * |sf|op| S| 1  1  0  1  0  0  1  0 |imm5/rm | cond |i/r |o2|  Rn  |o3|nzcv |
> @@ -3908,7 +3909,7 @@ static void disas_cc(DisasContext *s, uint32_t insn)
>      tcg_temp_free_i32(tcg_t2);
>  }
>
> -/* C3.5.6 Conditional select
> +/* Conditional select
>   *   31   30  29  28             21 20  16 15  12 11 10 9    5 4    0
>   * +----+----+---+-----------------+------+------+-----+------+------+
>   * | sf | op | S | 1 1 0 1 0 1 0 0 |  Rm  | cond | op2 |  Rn  |  Rd  |
> @@ -4019,7 +4020,7 @@ static void handle_rbit(DisasContext *s, unsigned int sf,
>      }
>  }
>
> -/* C5.6.149 REV with sf==1, opcode==3 ("REV64") */
> +/* REV with sf==1, opcode==3 ("REV64") */
>  static void handle_rev64(DisasContext *s, unsigned int sf,
>                           unsigned int rn, unsigned int rd)
>  {
> @@ -4030,8 +4031,8 @@ static void handle_rev64(DisasContext *s, unsigned int sf,
>      tcg_gen_bswap64_i64(cpu_reg(s, rd), cpu_reg(s, rn));
>  }
>
> -/* C5.6.149 REV with sf==0, opcode==2
> - * C5.6.151 REV32 (sf==1, opcode==2)
> +/* REV with sf==0, opcode==2
> + * REV32 (sf==1, opcode==2)
>   */
>  static void handle_rev32(DisasContext *s, unsigned int sf,
>                           unsigned int rn, unsigned int rd)
> @@ -4056,7 +4057,7 @@ static void handle_rev32(DisasContext *s, unsigned int sf,
>      }
>  }
>
> -/* C5.6.150 REV16 (opcode==1) */
> +/* REV16 (opcode==1) */
>  static void handle_rev16(DisasContext *s, unsigned int sf,
>                           unsigned int rn, unsigned int rd)
>  {
> @@ -4075,7 +4076,7 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
>      tcg_temp_free_i64(tcg_tmp);
>  }
>
> -/* C3.5.7 Data-processing (1 source)
> +/* Data-processing (1 source)
>   *   31  30  29  28             21 20     16 15    10 9    5 4    0
>   * +----+---+---+-----------------+---------+--------+------+------+
>   * | sf | 1 | S | 1 1 0 1 0 1 1 0 | opcode2 | opcode |  Rn  |  Rd  |
> @@ -4144,7 +4145,7 @@ static void handle_div(DisasContext *s, bool is_signed, unsigned int sf,
>      }
>  }
>
> -/* C5.6.115 LSLV, C5.6.118 LSRV, C5.6.17 ASRV, C5.6.154 RORV */
> +/* LSLV, LSRV, ASRV, RORV */
>  static void handle_shift_reg(DisasContext *s,
>                               enum a64_shift_type shift_type, unsigned int sf,
>                               unsigned int rm, unsigned int rn, unsigned int rd)
> @@ -4206,7 +4207,7 @@ static void handle_crc32(DisasContext *s,
>      tcg_temp_free_i32(tcg_bytes);
>  }
>
> -/* C3.5.8 Data-processing (2 source)
> +/* Data-processing (2 source)
>   *   31   30  29 28             21 20  16 15    10 9    5 4    0
>   * +----+---+---+-----------------+------+--------+------+------+
>   * | sf | 0 | S | 1 1 0 1 0 1 1 0 |  Rm  | opcode |  Rn  |  Rd  |
> @@ -4265,7 +4266,7 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C3.5 Data processing - register */
> +/* Data processing - register */
>  static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
>  {
>      switch (extract32(insn, 24, 5)) {
> @@ -4359,7 +4360,7 @@ static void handle_fp_compare(DisasContext *s, bool is_double,
>      tcg_temp_free_i64(tcg_flags);
>  }
>
> -/* C3.6.22 Floating point compare
> +/* Floating point compare
>   *   31  30  29 28       24 23  22  21 20  16 15 14 13  10    9    5 4     0
>   * +---+---+---+-----------+------+---+------+-----+---------+------+-------+
>   * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | op  | 1 0 0 0 |  Rn  |  op2  |
> @@ -4389,7 +4390,7 @@ static void disas_fp_compare(DisasContext *s, uint32_t insn)
>      handle_fp_compare(s, type, rn, rm, opc & 1, opc & 2);
>  }
>
> -/* C3.6.23 Floating point conditional compare
> +/* Floating point conditional compare
>   *   31  30  29 28       24 23  22  21 20  16 15  12 11 10 9    5  4   3    0
>   * +---+---+---+-----------+------+---+------+------+-----+------+----+------+
>   * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | cond | 0 1 |  Rn  | op | nzcv |
> @@ -4437,7 +4438,7 @@ static void disas_fp_ccomp(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C3.6.24 Floating point conditional select
> +/* Floating point conditional select
>   *   31  30  29 28       24 23  22  21 20  16 15  12 11 10 9    5 4    0
>   * +---+---+---+-----------+------+---+------+------+-----+------+------+
>   * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | cond | 1 1 |  Rn  |  Rd  |
> @@ -4484,7 +4485,7 @@ static void disas_fp_csel(DisasContext *s, uint32_t insn)
>      tcg_temp_free_i64(t_true);
>  }
>
> -/* C3.6.25 Floating-point data-processing (1 source) - single precision */
> +/* Floating-point data-processing (1 source) - single precision */
>  static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
>  {
>      TCGv_ptr fpst;
> @@ -4540,7 +4541,7 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
>      tcg_temp_free_i32(tcg_res);
>  }
>
> -/* C3.6.25 Floating-point data-processing (1 source) - double precision */
> +/* Floating-point data-processing (1 source) - double precision */
>  static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
>  {
>      TCGv_ptr fpst;
> @@ -4662,7 +4663,7 @@ static void handle_fp_fcvt(DisasContext *s, int opcode,
>      }
>  }
>
> -/* C3.6.25 Floating point data-processing (1 source)
> +/* Floating point data-processing (1 source)
>   *   31  30  29 28       24 23  22  21 20    15 14       10 9    5 4    0
>   * +---+---+---+-----------+------+---+--------+-----------+------+------+
>   * | M | 0 | S | 1 1 1 1 0 | type | 1 | opcode | 1 0 0 0 0 |  Rn  |  Rd  |
> @@ -4720,7 +4721,7 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C3.6.26 Floating-point data-processing (2 source) - single precision */
> +/* Floating-point data-processing (2 source) - single precision */
>  static void handle_fp_2src_single(DisasContext *s, int opcode,
>                                    int rd, int rn, int rm)
>  {
> @@ -4773,7 +4774,7 @@ static void handle_fp_2src_single(DisasContext *s, int opcode,
>      tcg_temp_free_i32(tcg_res);
>  }
>
> -/* C3.6.26 Floating-point data-processing (2 source) - double precision */
> +/* Floating-point data-processing (2 source) - double precision */
>  static void handle_fp_2src_double(DisasContext *s, int opcode,
>                                    int rd, int rn, int rm)
>  {
> @@ -4826,7 +4827,7 @@ static void handle_fp_2src_double(DisasContext *s, int opcode,
>      tcg_temp_free_i64(tcg_res);
>  }
>
> -/* C3.6.26 Floating point data-processing (2 source)
> +/* Floating point data-processing (2 source)
>   *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
>   * +---+---+---+-----------+------+---+------+--------+-----+------+------+
>   * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | opcode | 1 0 |  Rn  |  Rd  |
> @@ -4863,7 +4864,7 @@ static void disas_fp_2src(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C3.6.27 Floating-point data-processing (3 source) - single precision */
> +/* Floating-point data-processing (3 source) - single precision */
>  static void handle_fp_3src_single(DisasContext *s, bool o0, bool o1,
>                                    int rd, int rn, int rm, int ra)
>  {
> @@ -4901,7 +4902,7 @@ static void handle_fp_3src_single(DisasContext *s, bool o0, bool o1,
>      tcg_temp_free_i32(tcg_res);
>  }
>
> -/* C3.6.27 Floating-point data-processing (3 source) - double precision */
> +/* Floating-point data-processing (3 source) - double precision */
>  static void handle_fp_3src_double(DisasContext *s, bool o0, bool o1,
>                                    int rd, int rn, int rm, int ra)
>  {
> @@ -4939,7 +4940,7 @@ static void handle_fp_3src_double(DisasContext *s, bool o0, bool o1,
>      tcg_temp_free_i64(tcg_res);
>  }
>
> -/* C3.6.27 Floating point data-processing (3 source)
> +/* Floating point data-processing (3 source)
>   *   31  30  29 28       24 23  22  21  20  16  15  14  10 9    5 4    0
>   * +---+---+---+-----------+------+----+------+----+------+------+------+
>   * | M | 0 | S | 1 1 1 1 1 | type | o1 |  Rm  | o0 |  Ra  |  Rn  |  Rd  |
> @@ -4973,7 +4974,7 @@ static void disas_fp_3src(DisasContext *s, uint32_t insn)
>      }
>  }
>
> -/* C3.6.28 Floating point immediate
> +/* Floating point immediate
>   *   31  30  29 28       24 23  22  21 20        13 12   10 9    5 4    0
>   * +---+---+---+-----------+------+---+------------+-------+------+------+
>   * | M | 0 | S | 1 1 1 1 0 | type | 1 |    imm8    | 1 0 0 | imm5 |  Rd  |
> @@ -5144,7 +5145,7 @@ static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
>      tcg_temp_free_i32(tcg_shift);
>  }
>
> -/* C3.6.29 Floating point <-> fixed point conversions
> +/* Floating point <-> fixed point conversions
>   *   31   30  29 28       24 23  22  21 20   19 18    16 15   10 9    5 4    0
>   * +----+---+---+-----------+------+---+-------+--------+-------+------+------+
>   * | sf | 0 | S | 1 1 1 1 0 | type | 0 | rmode | opcode | scale |  Rn  |  Rd  |
> @@ -5244,7 +5245,7 @@ static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
>      }
>  }
>
> -/* C3.6.30 Floating point <-> integer conversions
> +/* Floating point <-> integer conversions
>   *   31   30  29 28       24 23  22  21 20   19 18 16 15         10 9  5 4  0
>   * +----+---+---+-----------+------+---+-------+-----+-------------+----+----+
>   * | sf | 0 | S | 1 1 1 1 0 | type | 1 | rmode | opc | 0 0 0 0 0 0 | Rn | Rd |
> @@ -5379,7 +5380,7 @@ static void do_ext64(DisasContext *s, TCGv_i64 tcg_left, TCGv_i64 tcg_right,
>      tcg_temp_free_i64(tcg_tmp);
>  }
>
> -/* C3.6.1 EXT
> +/* EXT
>   *   31  30 29         24 23 22  21 20  16 15  14  11 10  9    5 4    0
>   * +---+---+-------------+-----+---+------+---+------+---+------+------+
>   * | 0 | Q | 1 0 1 1 1 0 | op2 | 0 |  Rm  | 0 | imm4 | 0 |  Rn  |  Rd  |
> @@ -5452,7 +5453,7 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
>      tcg_temp_free_i64(tcg_resh);
>  }
>
> -/* C3.6.2 TBL/TBX
> +/* BL/TBX

I don't know how I noticed this, but it looks like you are missing a T.

Thanks,
Alistair
