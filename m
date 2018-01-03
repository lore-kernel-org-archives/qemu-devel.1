Received: from eggs.gnu.org ([2001:4830:134:3::10]:42089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWYMQ-0006gu-S3
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eWYME-0004Qe-2u
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:00:54 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:44733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eWYMD-0004Pn-KG
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:00:42 -0500
Received: by mail-oi0-x229.google.com with SMTP id g6so151294oib.11
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 18:00:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NuaLUODyFmt5pXH78hq38m4m5GGGO_GGULfprd-sjCX1Q@mail.gmail.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<151494290795.165.10006581095663113372@5adcb62bf0d6>
	<CAHNT7NuaLUODyFmt5pXH78hq38m4m5GGGO_GGULfprd-sjCX1Q@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 3 Jan 2018 15:00:39 +1300
Message-ID: <CAHNT7NuVN4iEkyKQSE+8QKx+To0gYmDVUcFHz=bcXWDTykLZEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 00/21] RISC-V QEMU Port Submission v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

So it's essentially one error, the single line case pattern for
table-driven decode which flags for long lines and asks to separate break
onto its own line.

We have actually reduced the readability of other parts of the code to
conform to this specific rule. In fact I spent a day and a half with
checkpatch, but it didn't seem to make sense for the disassembler.

The question is should one blindly comply with the rule for
machine-generated tables. Editing the code manually introduces the
potential for human error. I can, if needed, modify the disassembler
generator to output code with the required verbosity.

On Wed, Jan 3, 2018 at 2:46 PM, Michael Clark <mjc@sifive.com> wrote:

> Hi famz,
>
> If you read the patch logs, you'll see we mention that two of the patches
> don't pass checkpatch. The checkpatch warnings are in the patch comments.
>
> [0004/0021] RISC-V Disassembler violates some select standards for
> brevity. It is repetitive machine generated code. LOC will blow up.
> [0021/0021] RISC-V Build-Infrastructure scripts/qemu-binfmt-conf.sh
> violates the coding standard to be consistent with the rest of the file
>
> I checked other files in the disas/ directory and note that they also
> violate the 90 column rule. We've used a single line case format as in this
> case it is the sane thing to do. i.e. the checkpatch script is not able to
> exercise human jugdement.
>
> Please read the patch comments for 0004 and 0021 where I describe the
> rationale for the specific violations.
>
> I'm happy to change 0004 but we might explode what was originally ~2000
> lines into ~4000 lines or possible more.
>
> Making hex binary span lines in 0021 is risky, and scripts/qemu-binfmt
> -conf.sh already violates the coding standard.
>
> The other 19 patches (~12,000 LOC) have 0 warnings from checkpatch.
>
> Regards,
> Michael.
>
> On Wed, Jan 3, 2018 at 2:28 PM, <no-reply@patchew.org> wrote:
>
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
>>
>> Type: series
>> Message-id: 1514940265-18093-1-git-send-email-mjc@sifive.com
>> Subject: [Qemu-devel] [PATCH v1 00/21] RISC-V QEMU Port Submission v1
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>>
>> BASE=base
>> n=1
>> total=$(git log --oneline $BASE.. | wc -l)
>> failed=0
>>
>> git config --local diff.renamelimit 0
>> git config --local diff.renames True
>>
>> commits="$(git log --format=%H --reverse $BASE..)"
>> for c in $commits; do
>>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback
>> -; then
>>         failed=1
>>         echo
>>     fi
>>     n=$((n+1))
>> done
>>
>> exit $failed
>> === TEST SCRIPT END ===
>>
>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>> Switched to a new branch 'test'
>> 4f446c5863 RISC-V Build Infrastructure
>> dc2bad7c46 SiFive Freedom U500 RISC-V Machine
>> e8c7a0bbdd SiFive Freedom E300 RISC-V Machine
>> a9b44928ef SiFive RISC-V PRCI Block
>> 4bd2745c81 SiFive RISC-V UART Device
>> b9c4953978 RISC-V VirtIO Machine
>> 6620d95309 RISC-V Spike Machines
>> 119e3a2f08 SiFive RISC-V PLIC Block
>> 93a3a277a0 SiFive RISC-V CLINT Block
>> b5519a281a RISC-V HART Array
>> 6c8f07e0a3 RISC-V HTIF Console
>> e65c25876b RISC-V Linux User Emulation
>> 0f54fcb416 RISC-V Physical Memory Protection
>> c281030b68 RISC-V TCG Code Generation
>> 53921ca558 RISC-V GDB Stub
>> 179acf20f4 RISC-V FPU Support
>> ba8be079a6 RISC-V CPU Helpers
>> 34f8b2462e RISC-V Disassembler
>> d8f0414bcc RISC-V CPU Core Definition
>> 0318b443cf RISC-V ELF Machine Definition
>> 05c32015d3 RISC-V Maintainers
>>
>> === OUTPUT BEGIN ===
>> Checking PATCH 1/21: RISC-V Maintainers...
>> Checking PATCH 2/21: RISC-V ELF Machine Definition...
>> Checking PATCH 3/21: RISC-V CPU Core Definition...
>> Checking PATCH 4/21: RISC-V Disassembler...
>> WARNING: line over 80 characters
>> #655: FILE: disas/riscv.c:605:
>> +static const rvc_constraint rvcc_jalr[] = { rvc_rd_eq_ra,
>> rvc_imm_eq_zero, rvc_end };
>>
>> ERROR: line over 90 characters
>> #656: FILE: disas/riscv.c:606:
>> +static const rvc_constraint rvcc_nop[] = { rvc_rd_eq_x0, rvc_rs1_eq_x0,
>> rvc_imm_eq_zero, rvc_end };
>>
>> WARNING: line over 80 characters
>> #686: FILE: disas/riscv.c:636:
>> +static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
>> rvc_end };
>>
>> WARNING: line over 80 characters
>> #687: FILE: disas/riscv.c:637:
>> +static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
>> rvc_end };
>>
>> WARNING: line over 80 characters
>> #688: FILE: disas/riscv.c:638:
>> +static const rvc_constraint rvcc_rdcycle[] = { rvc_rs1_eq_x0,
>> rvc_csr_eq_0xc00, rvc_end };
>>
>> WARNING: line over 80 characters
>> #689: FILE: disas/riscv.c:639:
>> +static const rvc_constraint rvcc_rdtime[] = { rvc_rs1_eq_x0,
>> rvc_csr_eq_0xc01, rvc_end };
>>
>> ERROR: line over 90 characters
>> #690: FILE: disas/riscv.c:640:
>> +static const rvc_constraint rvcc_rdinstret[] = { rvc_rs1_eq_x0,
>> rvc_csr_eq_0xc02, rvc_end };
>>
>> ERROR: line over 90 characters
>> #691: FILE: disas/riscv.c:641:
>> +static const rvc_constraint rvcc_rdcycleh[] = { rvc_rs1_eq_x0,
>> rvc_csr_eq_0xc80, rvc_end };
>>
>> WARNING: line over 80 characters
>> #692: FILE: disas/riscv.c:642:
>> +static const rvc_constraint rvcc_rdtimeh[] = { rvc_rs1_eq_x0,
>> rvc_csr_eq_0xc81, rvc_end };
>>
>> ERROR: line over 90 characters
>> #693: FILE: disas/riscv.c:643:
>> +static const rvc_constraint rvcc_rdinstreth[] = { rvc_rs1_eq_x0,
>> rvc_csr_eq_0xc80, rvc_end };
>>
>> WARNING: line over 80 characters
>> #694: FILE: disas/riscv.c:644:
>> +static const rvc_constraint rvcc_frcsr[] = { rvc_rs1_eq_x0,
>> rvc_csr_eq_0x003, rvc_end };
>>
>> WARNING: line over 80 characters
>> #695: FILE: disas/riscv.c:645:
>> +static const rvc_constraint rvcc_frrm[] = { rvc_rs1_eq_x0,
>> rvc_csr_eq_0x002, rvc_end };
>>
>> WARNING: line over 80 characters
>> #696: FILE: disas/riscv.c:646:
>> +static const rvc_constraint rvcc_frflags[] = { rvc_rs1_eq_x0,
>> rvc_csr_eq_0x001, rvc_end };
>>
>> ERROR: line over 90 characters
>> #1095: FILE: disas/riscv.c:1045:
>> +    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL,
>> rv_op_addi, rv_op_addi, rv_op_addi },
>>
>> WARNING: line over 80 characters
>> #1096: FILE: disas/riscv.c:1046:
>> +    { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NULL, rv_op_fld,
>> rv_op_fld, 0 },
>>
>> WARNING: line over 80 characters
>> #1097: FILE: disas/riscv.c:1047:
>> +    { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL, rv_op_lw,
>> rv_op_lw, rv_op_lw },
>>
>> WARNING: line over 80 characters
>> #1099: FILE: disas/riscv.c:1049:
>> +    { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsd,
>> rv_op_fsd, 0 },
>>
>> WARNING: line over 80 characters
>> #1100: FILE: disas/riscv.c:1050:
>> +    { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw,
>> rv_op_sw, rv_op_sw },
>>
>> WARNING: line over 80 characters
>> #1102: FILE: disas/riscv.c:1052:
>> +    { "c.nop", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_addi,
>> rv_op_addi, rv_op_addi },
>>
>> ERROR: line over 90 characters
>> #1103: FILE: disas/riscv.c:1053:
>> +    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
>> rv_op_addi, rv_op_addi },
>>
>> ERROR: line over 90 characters
>> #1105: FILE: disas/riscv.c:1055:
>> +    { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
>> rv_op_addi, rv_op_addi },
>>
>> ERROR: line over 90 characters
>> #1106: FILE: disas/riscv.c:1056:
>> +    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL,
>> rv_op_addi, rv_op_addi, rv_op_addi },
>>
>> WARNING: line over 80 characters
>> #1107: FILE: disas/riscv.c:1057:
>> +    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_imm, NULL, rv_op_lui,
>> rv_op_lui, rv_op_lui },
>>
>> ERROR: line over 90 characters
>> #1108: FILE: disas/riscv.c:1058:
>> +    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli,
>> rv_op_srli, rv_op_srli },
>>
>> ERROR: line over 90 characters
>> #1109: FILE: disas/riscv.c:1059:
>> +    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai,
>> rv_op_srai, rv_op_srai },
>>
>> ERROR: line over 90 characters
>> #1110: FILE: disas/riscv.c:1060:
>> +    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi,
>> rv_op_andi, rv_op_andi },
>>
>> WARNING: line over 80 characters
>> #1111: FILE: disas/riscv.c:1061:
>> +    { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub,
>> rv_op_sub, rv_op_sub },
>>
>> WARNING: line over 80 characters
>> #1112: FILE: disas/riscv.c:1062:
>> +    { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_xor,
>> rv_op_xor, rv_op_xor },
>>
>> WARNING: line over 80 characters
>> #1113: FILE: disas/riscv.c:1063:
>> +    { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_or, rv_op_or,
>> rv_op_or },
>>
>> WARNING: line over 80 characters
>> #1114: FILE: disas/riscv.c:1064:
>> +    { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_and,
>> rv_op_and, rv_op_and },
>>
>> ERROR: line over 90 characters
>> #1115: FILE: disas/riscv.c:1065:
>> +    { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_subw,
>> rv_op_subw, rv_op_subw },
>>
>> ERROR: line over 90 characters
>> #1116: FILE: disas/riscv.c:1066:
>> +    { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_addw,
>> rv_op_addw, rv_op_addw },
>>
>> WARNING: line over 80 characters
>> #1117: FILE: disas/riscv.c:1067:
>> +    { "c.j", rv_codec_cj, rv_fmt_rd_offset, NULL, rv_op_jal, rv_op_jal,
>> rv_op_jal },
>>
>> ERROR: line over 90 characters
>> #1118: FILE: disas/riscv.c:1068:
>> +    { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_beq,
>> rv_op_beq, rv_op_beq },
>>
>> ERROR: line over 90 characters
>> #1119: FILE: disas/riscv.c:1069:
>> +    { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_bne,
>> rv_op_bne, rv_op_bne },
>>
>> ERROR: line over 90 characters
>> #1120: FILE: disas/riscv.c:1070:
>> +    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli,
>> rv_op_slli, rv_op_slli },
>>
>> ERROR: line over 90 characters
>> #1121: FILE: disas/riscv.c:1071:
>> +    { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, NULL,
>> rv_op_fld, rv_op_fld, rv_op_fld },
>>
>> ERROR: line over 90 characters
>> #1122: FILE: disas/riscv.c:1072:
>> +    { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lw,
>> rv_op_lw, rv_op_lw },
>>
>> WARNING: line over 80 characters
>> #1123: FILE: disas/riscv.c:1073:
>> +    { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1, NULL,
>> rv_op_flw, 0, 0 },
>>
>> ERROR: line over 90 characters
>> #1124: FILE: disas/riscv.c:1074:
>> +    { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset, NULL, rv_op_jalr,
>> rv_op_jalr, rv_op_jalr },
>>
>> ERROR: line over 90 characters
>> #1125: FILE: disas/riscv.c:1075:
>> +    { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, NULL, rv_op_addi,
>> rv_op_addi, rv_op_addi },
>>
>> ERROR: line over 90 characters
>> #1126: FILE: disas/riscv.c:1076:
>> +    { "c.ebreak", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_ebreak,
>> rv_op_ebreak, rv_op_ebreak },
>>
>> ERROR: line over 90 characters
>> #1127: FILE: disas/riscv.c:1077:
>> +    { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset, NULL,
>> rv_op_jalr, rv_op_jalr, rv_op_jalr },
>>
>> WARNING: line over 80 characters
>> #1128: FILE: disas/riscv.c:1078:
>> +    { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, NULL, rv_op_add,
>> rv_op_add, rv_op_add },
>>
>> ERROR: line over 90 characters
>> #1129: FILE: disas/riscv.c:1079:
>> +    { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs1, NULL,
>> rv_op_fsd, rv_op_fsd, rv_op_fsd },
>>
>> ERROR: line over 90 characters
>> #1130: FILE: disas/riscv.c:1080:
>> +    { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1, NULL,
>> rv_op_sw, rv_op_sw, rv_op_sw },
>>
>> WARNING: line over 80 characters
>> #1131: FILE: disas/riscv.c:1081:
>> +    { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs1, NULL,
>> rv_op_fsw, 0, 0 },
>>
>> WARNING: line over 80 characters
>> #1132: FILE: disas/riscv.c:1082:
>> +    { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, NULL, 0, rv_op_ld,
>> rv_op_ld },
>>
>> WARNING: line over 80 characters
>> #1133: FILE: disas/riscv.c:1083:
>> +    { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1, NULL, 0, rv_op_sd,
>> rv_op_sd },
>>
>> WARNING: line over 80 characters
>> #1134: FILE: disas/riscv.c:1084:
>> +    { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, 0, rv_op_addiw,
>> rv_op_addiw },
>>
>> WARNING: line over 80 characters
>> #1135: FILE: disas/riscv.c:1085:
>> +    { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1, NULL, 0,
>> rv_op_ld, rv_op_ld },
>>
>> WARNING: line over 80 characters
>> #1136: FILE: disas/riscv.c:1086:
>> +    { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1, NULL, 0,
>> rv_op_sd, rv_op_sd },
>>
>> WARNING: line over 80 characters
>> #1140: FILE: disas/riscv.c:1090:
>> +    { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1, NULL, 0, 0,
>> rv_op_sq },
>>
>> ERROR: trailing statements should be on next line
>> #1404: FILE: disas/riscv.c:1354:
>> +        case 0: op = rv_op_c_addi4spn; break;
>>
>> ERROR: trailing statements should be on next line
>> #1412: FILE: disas/riscv.c:1362:
>> +        case 2: op = rv_op_c_lw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1427: FILE: disas/riscv.c:1377:
>> +        case 6: op = rv_op_c_sw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1441: FILE: disas/riscv.c:1391:
>> +            case 0: op = rv_op_c_nop; break;
>>
>> ERROR: trailing statements should be on next line
>> #1442: FILE: disas/riscv.c:1392:
>> +            default: op = rv_op_c_addi; break;
>>
>> ERROR: trailing statements should be on next line
>> #1452: FILE: disas/riscv.c:1402:
>> +        case 2: op = rv_op_c_li; break;
>>
>> ERROR: trailing statements should be on next line
>> #1455: FILE: disas/riscv.c:1405:
>> +            case 2: op = rv_op_c_addi16sp; break;
>>
>> ERROR: trailing statements should be on next line
>> #1456: FILE: disas/riscv.c:1406:
>> +            default: op = rv_op_c_lui; break;
>>
>> ERROR: trailing statements should be on next line
>> #1467: FILE: disas/riscv.c:1417:
>> +            case 2: op = rv_op_c_andi; break;
>>
>> ERROR: trailing statements should be on next line
>> #1470: FILE: disas/riscv.c:1420:
>> +                case 0: op = rv_op_c_sub; break;
>>
>> ERROR: trailing statements should be on next line
>> #1471: FILE: disas/riscv.c:1421:
>> +                case 1: op = rv_op_c_xor; break;
>>
>> ERROR: trailing statements should be on next line
>> #1472: FILE: disas/riscv.c:1422:
>> +                case 2: op = rv_op_c_or; break;
>>
>> ERROR: trailing statements should be on next line
>> #1473: FILE: disas/riscv.c:1423:
>> +                case 3: op = rv_op_c_and; break;
>>
>> ERROR: trailing statements should be on next line
>> #1474: FILE: disas/riscv.c:1424:
>> +                case 4: op = rv_op_c_subw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1475: FILE: disas/riscv.c:1425:
>> +                case 5: op = rv_op_c_addw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1480: FILE: disas/riscv.c:1430:
>> +        case 5: op = rv_op_c_j; break;
>>
>> ERROR: trailing statements should be on next line
>> #1481: FILE: disas/riscv.c:1431:
>> +        case 6: op = rv_op_c_beqz; break;
>>
>> ERROR: trailing statements should be on next line
>> #1482: FILE: disas/riscv.c:1432:
>> +        case 7: op = rv_op_c_bnez; break;
>>
>> ERROR: trailing statements should be on next line
>> #1497: FILE: disas/riscv.c:1447:
>> +        case 2: op = rv_op_c_lwsp; break;
>>
>> ERROR: trailing statements should be on next line
>> #1509: FILE: disas/riscv.c:1459:
>> +                case 0: op = rv_op_c_jr; break;
>>
>> ERROR: trailing statements should be on next line
>> #1510: FILE: disas/riscv.c:1460:
>> +                default: op = rv_op_c_mv; break;
>>
>> ERROR: trailing statements should be on next line
>> #1517: FILE: disas/riscv.c:1467:
>> +                    case 0: op = rv_op_c_ebreak; break;
>>
>> ERROR: trailing statements should be on next line
>> #1518: FILE: disas/riscv.c:1468:
>> +                    default: op = rv_op_c_jalr; break;
>>
>> ERROR: trailing statements should be on next line
>> #1521: FILE: disas/riscv.c:1471:
>> +                default: op = rv_op_c_add; break;
>>
>> ERROR: trailing statements should be on next line
>> #1532: FILE: disas/riscv.c:1482:
>> +        case 6: op = rv_op_c_swsp; break;
>>
>> ERROR: trailing statements should be on next line
>> #1546: FILE: disas/riscv.c:1496:
>> +            case 0: op = rv_op_lb; break;
>>
>> ERROR: trailing statements should be on next line
>> #1547: FILE: disas/riscv.c:1497:
>> +            case 1: op = rv_op_lh; break;
>>
>> ERROR: trailing statements should be on next line
>> #1548: FILE: disas/riscv.c:1498:
>> +            case 2: op = rv_op_lw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1549: FILE: disas/riscv.c:1499:
>> +            case 3: op = rv_op_ld; break;
>>
>> ERROR: trailing statements should be on next line
>> #1550: FILE: disas/riscv.c:1500:
>> +            case 4: op = rv_op_lbu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1551: FILE: disas/riscv.c:1501:
>> +            case 5: op = rv_op_lhu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1552: FILE: disas/riscv.c:1502:
>> +            case 6: op = rv_op_lwu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1553: FILE: disas/riscv.c:1503:
>> +            case 7: op = rv_op_ldu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1558: FILE: disas/riscv.c:1508:
>> +            case 2: op = rv_op_flw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1559: FILE: disas/riscv.c:1509:
>> +            case 3: op = rv_op_fld; break;
>>
>> ERROR: trailing statements should be on next line
>> #1560: FILE: disas/riscv.c:1510:
>> +            case 4: op = rv_op_flq; break;
>>
>> ERROR: trailing statements should be on next line
>> #1565: FILE: disas/riscv.c:1515:
>> +            case 0: op = rv_op_fence; break;
>>
>> ERROR: trailing statements should be on next line
>> #1566: FILE: disas/riscv.c:1516:
>> +            case 1: op = rv_op_fence_i; break;
>>
>> ERROR: trailing statements should be on next line
>> #1567: FILE: disas/riscv.c:1517:
>> +            case 2: op = rv_op_lq; break;
>>
>> ERROR: trailing statements should be on next line
>> #1572: FILE: disas/riscv.c:1522:
>> +            case 0: op = rv_op_addi; break;
>>
>> ERROR: trailing statements should be on next line
>> #1575: FILE: disas/riscv.c:1525:
>> +                case 0: op = rv_op_slli; break;
>>
>> ERROR: trailing statements should be on next line
>> #1578: FILE: disas/riscv.c:1528:
>> +            case 2: op = rv_op_slti; break;
>>
>> ERROR: trailing statements should be on next line
>> #1579: FILE: disas/riscv.c:1529:
>> +            case 3: op = rv_op_sltiu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1580: FILE: disas/riscv.c:1530:
>> +            case 4: op = rv_op_xori; break;
>>
>> ERROR: trailing statements should be on next line
>> #1583: FILE: disas/riscv.c:1533:
>> +                case 0: op = rv_op_srli; break;
>>
>> ERROR: trailing statements should be on next line
>> #1584: FILE: disas/riscv.c:1534:
>> +                case 8: op = rv_op_srai; break;
>>
>> ERROR: trailing statements should be on next line
>> #1587: FILE: disas/riscv.c:1537:
>> +            case 6: op = rv_op_ori; break;
>>
>> ERROR: trailing statements should be on next line
>> #1588: FILE: disas/riscv.c:1538:
>> +            case 7: op = rv_op_andi; break;
>>
>> ERROR: trailing statements should be on next line
>> #1591: FILE: disas/riscv.c:1541:
>> +        case 5: op = rv_op_auipc; break;
>>
>> ERROR: trailing statements should be on next line
>> #1594: FILE: disas/riscv.c:1544:
>> +            case 0: op = rv_op_addiw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1597: FILE: disas/riscv.c:1547:
>> +                case 0: op = rv_op_slliw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1602: FILE: disas/riscv.c:1552:
>> +                case 0: op = rv_op_srliw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1603: FILE: disas/riscv.c:1553:
>> +                case 32: op = rv_op_sraiw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1610: FILE: disas/riscv.c:1560:
>> +            case 0: op = rv_op_sb; break;
>>
>> ERROR: trailing statements should be on next line
>> #1611: FILE: disas/riscv.c:1561:
>> +            case 1: op = rv_op_sh; break;
>>
>> ERROR: trailing statements should be on next line
>> #1612: FILE: disas/riscv.c:1562:
>> +            case 2: op = rv_op_sw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1613: FILE: disas/riscv.c:1563:
>> +            case 3: op = rv_op_sd; break;
>>
>> ERROR: trailing statements should be on next line
>> #1614: FILE: disas/riscv.c:1564:
>> +            case 4: op = rv_op_sq; break;
>>
>> ERROR: trailing statements should be on next line
>> #1619: FILE: disas/riscv.c:1569:
>> +            case 2: op = rv_op_fsw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1620: FILE: disas/riscv.c:1570:
>> +            case 3: op = rv_op_fsd; break;
>>
>> ERROR: trailing statements should be on next line
>> #1621: FILE: disas/riscv.c:1571:
>> +            case 4: op = rv_op_fsq; break;
>>
>> ERROR: trailing statements should be on next line
>> #1626: FILE: disas/riscv.c:1576:
>> +            case 2: op = rv_op_amoadd_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1627: FILE: disas/riscv.c:1577:
>> +            case 3: op = rv_op_amoadd_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1628: FILE: disas/riscv.c:1578:
>> +            case 4: op = rv_op_amoadd_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1629: FILE: disas/riscv.c:1579:
>> +            case 10: op = rv_op_amoswap_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1630: FILE: disas/riscv.c:1580:
>> +            case 11: op = rv_op_amoswap_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1631: FILE: disas/riscv.c:1581:
>> +            case 12: op = rv_op_amoswap_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1634: FILE: disas/riscv.c:1584:
>> +                case 0: op = rv_op_lr_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1639: FILE: disas/riscv.c:1589:
>> +                case 0: op = rv_op_lr_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1644: FILE: disas/riscv.c:1594:
>> +                case 0: op = rv_op_lr_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1647: FILE: disas/riscv.c:1597:
>> +            case 26: op = rv_op_sc_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1648: FILE: disas/riscv.c:1598:
>> +            case 27: op = rv_op_sc_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1649: FILE: disas/riscv.c:1599:
>> +            case 28: op = rv_op_sc_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1650: FILE: disas/riscv.c:1600:
>> +            case 34: op = rv_op_amoxor_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1651: FILE: disas/riscv.c:1601:
>> +            case 35: op = rv_op_amoxor_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1652: FILE: disas/riscv.c:1602:
>> +            case 36: op = rv_op_amoxor_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1653: FILE: disas/riscv.c:1603:
>> +            case 66: op = rv_op_amoor_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1654: FILE: disas/riscv.c:1604:
>> +            case 67: op = rv_op_amoor_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1655: FILE: disas/riscv.c:1605:
>> +            case 68: op = rv_op_amoor_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1656: FILE: disas/riscv.c:1606:
>> +            case 98: op = rv_op_amoand_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1657: FILE: disas/riscv.c:1607:
>> +            case 99: op = rv_op_amoand_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1658: FILE: disas/riscv.c:1608:
>> +            case 100: op = rv_op_amoand_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1659: FILE: disas/riscv.c:1609:
>> +            case 130: op = rv_op_amomin_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1660: FILE: disas/riscv.c:1610:
>> +            case 131: op = rv_op_amomin_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1661: FILE: disas/riscv.c:1611:
>> +            case 132: op = rv_op_amomin_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1662: FILE: disas/riscv.c:1612:
>> +            case 162: op = rv_op_amomax_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1663: FILE: disas/riscv.c:1613:
>> +            case 163: op = rv_op_amomax_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1664: FILE: disas/riscv.c:1614:
>> +            case 164: op = rv_op_amomax_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1665: FILE: disas/riscv.c:1615:
>> +            case 194: op = rv_op_amominu_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1666: FILE: disas/riscv.c:1616:
>> +            case 195: op = rv_op_amominu_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1667: FILE: disas/riscv.c:1617:
>> +            case 196: op = rv_op_amominu_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1668: FILE: disas/riscv.c:1618:
>> +            case 226: op = rv_op_amomaxu_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1669: FILE: disas/riscv.c:1619:
>> +            case 227: op = rv_op_amomaxu_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1670: FILE: disas/riscv.c:1620:
>> +            case 228: op = rv_op_amomaxu_q; break;
>>
>> WARNING: line over 80 characters
>> #1674: FILE: disas/riscv.c:1624:
>> +            switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) &
>> 0b0000000111)) {
>>
>> ERROR: trailing statements should be on next line
>> #1675: FILE: disas/riscv.c:1625:
>> +            case 0: op = rv_op_add; break;
>>
>> ERROR: trailing statements should be on next line
>> #1676: FILE: disas/riscv.c:1626:
>> +            case 1: op = rv_op_sll; break;
>>
>> ERROR: trailing statements should be on next line
>> #1677: FILE: disas/riscv.c:1627:
>> +            case 2: op = rv_op_slt; break;
>>
>> ERROR: trailing statements should be on next line
>> #1678: FILE: disas/riscv.c:1628:
>> +            case 3: op = rv_op_sltu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1679: FILE: disas/riscv.c:1629:
>> +            case 4: op = rv_op_xor; break;
>>
>> ERROR: trailing statements should be on next line
>> #1680: FILE: disas/riscv.c:1630:
>> +            case 5: op = rv_op_srl; break;
>>
>> ERROR: trailing statements should be on next line
>> #1681: FILE: disas/riscv.c:1631:
>> +            case 6: op = rv_op_or; break;
>>
>> ERROR: trailing statements should be on next line
>> #1682: FILE: disas/riscv.c:1632:
>> +            case 7: op = rv_op_and; break;
>>
>> ERROR: trailing statements should be on next line
>> #1683: FILE: disas/riscv.c:1633:
>> +            case 8: op = rv_op_mul; break;
>>
>> ERROR: trailing statements should be on next line
>> #1684: FILE: disas/riscv.c:1634:
>> +            case 9: op = rv_op_mulh; break;
>>
>> ERROR: trailing statements should be on next line
>> #1685: FILE: disas/riscv.c:1635:
>> +            case 10: op = rv_op_mulhsu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1686: FILE: disas/riscv.c:1636:
>> +            case 11: op = rv_op_mulhu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1687: FILE: disas/riscv.c:1637:
>> +            case 12: op = rv_op_div; break;
>>
>> ERROR: trailing statements should be on next line
>> #1688: FILE: disas/riscv.c:1638:
>> +            case 13: op = rv_op_divu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1689: FILE: disas/riscv.c:1639:
>> +            case 14: op = rv_op_rem; break;
>>
>> ERROR: trailing statements should be on next line
>> #1690: FILE: disas/riscv.c:1640:
>> +            case 15: op = rv_op_remu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1691: FILE: disas/riscv.c:1641:
>> +            case 256: op = rv_op_sub; break;
>>
>> ERROR: trailing statements should be on next line
>> #1692: FILE: disas/riscv.c:1642:
>> +            case 261: op = rv_op_sra; break;
>>
>> ERROR: trailing statements should be on next line
>> #1695: FILE: disas/riscv.c:1645:
>> +        case 13: op = rv_op_lui; break;
>>
>> WARNING: line over 80 characters
>> #1697: FILE: disas/riscv.c:1647:
>> +            switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) &
>> 0b0000000111)) {
>>
>> ERROR: trailing statements should be on next line
>> #1698: FILE: disas/riscv.c:1648:
>> +            case 0: op = rv_op_addw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1699: FILE: disas/riscv.c:1649:
>> +            case 1: op = rv_op_sllw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1700: FILE: disas/riscv.c:1650:
>> +            case 5: op = rv_op_srlw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1701: FILE: disas/riscv.c:1651:
>> +            case 8: op = rv_op_mulw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1702: FILE: disas/riscv.c:1652:
>> +            case 12: op = rv_op_divw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1703: FILE: disas/riscv.c:1653:
>> +            case 13: op = rv_op_divuw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1704: FILE: disas/riscv.c:1654:
>> +            case 14: op = rv_op_remw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1705: FILE: disas/riscv.c:1655:
>> +            case 15: op = rv_op_remuw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1706: FILE: disas/riscv.c:1656:
>> +            case 256: op = rv_op_subw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1707: FILE: disas/riscv.c:1657:
>> +            case 261: op = rv_op_sraw; break;
>>
>> ERROR: trailing statements should be on next line
>> #1712: FILE: disas/riscv.c:1662:
>> +            case 0: op = rv_op_fmadd_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1713: FILE: disas/riscv.c:1663:
>> +            case 1: op = rv_op_fmadd_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1714: FILE: disas/riscv.c:1664:
>> +            case 3: op = rv_op_fmadd_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1719: FILE: disas/riscv.c:1669:
>> +            case 0: op = rv_op_fmsub_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1720: FILE: disas/riscv.c:1670:
>> +            case 1: op = rv_op_fmsub_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1721: FILE: disas/riscv.c:1671:
>> +            case 3: op = rv_op_fmsub_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1726: FILE: disas/riscv.c:1676:
>> +            case 0: op = rv_op_fnmsub_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1727: FILE: disas/riscv.c:1677:
>> +            case 1: op = rv_op_fnmsub_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1728: FILE: disas/riscv.c:1678:
>> +            case 3: op = rv_op_fnmsub_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1733: FILE: disas/riscv.c:1683:
>> +            case 0: op = rv_op_fnmadd_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1734: FILE: disas/riscv.c:1684:
>> +            case 1: op = rv_op_fnmadd_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1735: FILE: disas/riscv.c:1685:
>> +            case 3: op = rv_op_fnmadd_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1740: FILE: disas/riscv.c:1690:
>> +            case 0: op = rv_op_fadd_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1741: FILE: disas/riscv.c:1691:
>> +            case 1: op = rv_op_fadd_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1742: FILE: disas/riscv.c:1692:
>> +            case 3: op = rv_op_fadd_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1743: FILE: disas/riscv.c:1693:
>> +            case 4: op = rv_op_fsub_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1744: FILE: disas/riscv.c:1694:
>> +            case 5: op = rv_op_fsub_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1745: FILE: disas/riscv.c:1695:
>> +            case 7: op = rv_op_fsub_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1746: FILE: disas/riscv.c:1696:
>> +            case 8: op = rv_op_fmul_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1747: FILE: disas/riscv.c:1697:
>> +            case 9: op = rv_op_fmul_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1748: FILE: disas/riscv.c:1698:
>> +            case 11: op = rv_op_fmul_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1749: FILE: disas/riscv.c:1699:
>> +            case 12: op = rv_op_fdiv_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1750: FILE: disas/riscv.c:1700:
>> +            case 13: op = rv_op_fdiv_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1751: FILE: disas/riscv.c:1701:
>> +            case 15: op = rv_op_fdiv_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1754: FILE: disas/riscv.c:1704:
>> +                case 0: op = rv_op_fsgnj_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1755: FILE: disas/riscv.c:1705:
>> +                case 1: op = rv_op_fsgnjn_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1756: FILE: disas/riscv.c:1706:
>> +                case 2: op = rv_op_fsgnjx_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1761: FILE: disas/riscv.c:1711:
>> +                case 0: op = rv_op_fsgnj_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1762: FILE: disas/riscv.c:1712:
>> +                case 1: op = rv_op_fsgnjn_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1763: FILE: disas/riscv.c:1713:
>> +                case 2: op = rv_op_fsgnjx_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1768: FILE: disas/riscv.c:1718:
>> +                case 0: op = rv_op_fsgnj_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1769: FILE: disas/riscv.c:1719:
>> +                case 1: op = rv_op_fsgnjn_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1770: FILE: disas/riscv.c:1720:
>> +                case 2: op = rv_op_fsgnjx_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1775: FILE: disas/riscv.c:1725:
>> +                case 0: op = rv_op_fmin_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1776: FILE: disas/riscv.c:1726:
>> +                case 1: op = rv_op_fmax_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1781: FILE: disas/riscv.c:1731:
>> +                case 0: op = rv_op_fmin_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1782: FILE: disas/riscv.c:1732:
>> +                case 1: op = rv_op_fmax_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1787: FILE: disas/riscv.c:1737:
>> +                case 0: op = rv_op_fmin_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1788: FILE: disas/riscv.c:1738:
>> +                case 1: op = rv_op_fmax_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1793: FILE: disas/riscv.c:1743:
>> +                case 1: op = rv_op_fcvt_s_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1794: FILE: disas/riscv.c:1744:
>> +                case 3: op = rv_op_fcvt_s_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1799: FILE: disas/riscv.c:1749:
>> +                case 0: op = rv_op_fcvt_d_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1800: FILE: disas/riscv.c:1750:
>> +                case 3: op = rv_op_fcvt_d_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1805: FILE: disas/riscv.c:1755:
>> +                case 0: op = rv_op_fcvt_q_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1806: FILE: disas/riscv.c:1756:
>> +                case 1: op = rv_op_fcvt_q_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1811: FILE: disas/riscv.c:1761:
>> +                case 0: op = rv_op_fsqrt_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1816: FILE: disas/riscv.c:1766:
>> +                case 0: op = rv_op_fsqrt_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1821: FILE: disas/riscv.c:1771:
>> +                case 0: op = rv_op_fsqrt_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1826: FILE: disas/riscv.c:1776:
>> +                case 0: op = rv_op_fle_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1827: FILE: disas/riscv.c:1777:
>> +                case 1: op = rv_op_flt_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1828: FILE: disas/riscv.c:1778:
>> +                case 2: op = rv_op_feq_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1833: FILE: disas/riscv.c:1783:
>> +                case 0: op = rv_op_fle_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1834: FILE: disas/riscv.c:1784:
>> +                case 1: op = rv_op_flt_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1835: FILE: disas/riscv.c:1785:
>> +                case 2: op = rv_op_feq_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1840: FILE: disas/riscv.c:1790:
>> +                case 0: op = rv_op_fle_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1841: FILE: disas/riscv.c:1791:
>> +                case 1: op = rv_op_flt_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1842: FILE: disas/riscv.c:1792:
>> +                case 2: op = rv_op_feq_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1847: FILE: disas/riscv.c:1797:
>> +                case 0: op = rv_op_fcvt_w_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1848: FILE: disas/riscv.c:1798:
>> +                case 1: op = rv_op_fcvt_wu_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1849: FILE: disas/riscv.c:1799:
>> +                case 2: op = rv_op_fcvt_l_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1850: FILE: disas/riscv.c:1800:
>> +                case 3: op = rv_op_fcvt_lu_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1855: FILE: disas/riscv.c:1805:
>> +                case 0: op = rv_op_fcvt_w_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1856: FILE: disas/riscv.c:1806:
>> +                case 1: op = rv_op_fcvt_wu_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1857: FILE: disas/riscv.c:1807:
>> +                case 2: op = rv_op_fcvt_l_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1858: FILE: disas/riscv.c:1808:
>> +                case 3: op = rv_op_fcvt_lu_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1863: FILE: disas/riscv.c:1813:
>> +                case 0: op = rv_op_fcvt_w_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1864: FILE: disas/riscv.c:1814:
>> +                case 1: op = rv_op_fcvt_wu_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1865: FILE: disas/riscv.c:1815:
>> +                case 2: op = rv_op_fcvt_l_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1866: FILE: disas/riscv.c:1816:
>> +                case 3: op = rv_op_fcvt_lu_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1871: FILE: disas/riscv.c:1821:
>> +                case 0: op = rv_op_fcvt_s_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1872: FILE: disas/riscv.c:1822:
>> +                case 1: op = rv_op_fcvt_s_wu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1873: FILE: disas/riscv.c:1823:
>> +                case 2: op = rv_op_fcvt_s_l; break;
>>
>> ERROR: trailing statements should be on next line
>> #1874: FILE: disas/riscv.c:1824:
>> +                case 3: op = rv_op_fcvt_s_lu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1879: FILE: disas/riscv.c:1829:
>> +                case 0: op = rv_op_fcvt_d_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1880: FILE: disas/riscv.c:1830:
>> +                case 1: op = rv_op_fcvt_d_wu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1881: FILE: disas/riscv.c:1831:
>> +                case 2: op = rv_op_fcvt_d_l; break;
>>
>> ERROR: trailing statements should be on next line
>> #1882: FILE: disas/riscv.c:1832:
>> +                case 3: op = rv_op_fcvt_d_lu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1887: FILE: disas/riscv.c:1837:
>> +                case 0: op = rv_op_fcvt_q_w; break;
>>
>> ERROR: trailing statements should be on next line
>> #1888: FILE: disas/riscv.c:1838:
>> +                case 1: op = rv_op_fcvt_q_wu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1889: FILE: disas/riscv.c:1839:
>> +                case 2: op = rv_op_fcvt_q_l; break;
>>
>> ERROR: trailing statements should be on next line
>> #1890: FILE: disas/riscv.c:1840:
>> +                case 3: op = rv_op_fcvt_q_lu; break;
>>
>> WARNING: line over 80 characters
>> #1894: FILE: disas/riscv.c:1844:
>> +                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) &
>> 0b00000111)) {
>>
>> ERROR: trailing statements should be on next line
>> #1895: FILE: disas/riscv.c:1845:
>> +                case 0: op = rv_op_fmv_x_s; break;
>>
>> ERROR: trailing statements should be on next line
>> #1896: FILE: disas/riscv.c:1846:
>> +                case 1: op = rv_op_fclass_s; break;
>>
>> WARNING: line over 80 characters
>> #1900: FILE: disas/riscv.c:1850:
>> +                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) &
>> 0b00000111)) {
>>
>> ERROR: trailing statements should be on next line
>> #1901: FILE: disas/riscv.c:1851:
>> +                case 0: op = rv_op_fmv_x_d; break;
>>
>> ERROR: trailing statements should be on next line
>> #1902: FILE: disas/riscv.c:1852:
>> +                case 1: op = rv_op_fclass_d; break;
>>
>> WARNING: line over 80 characters
>> #1906: FILE: disas/riscv.c:1856:
>> +                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) &
>> 0b00000111)) {
>>
>> ERROR: trailing statements should be on next line
>> #1907: FILE: disas/riscv.c:1857:
>> +                case 0: op = rv_op_fmv_x_q; break;
>>
>> ERROR: trailing statements should be on next line
>> #1908: FILE: disas/riscv.c:1858:
>> +                case 1: op = rv_op_fclass_q; break;
>>
>> WARNING: line over 80 characters
>> #1912: FILE: disas/riscv.c:1862:
>> +                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) &
>> 0b00000111)) {
>>
>> ERROR: trailing statements should be on next line
>> #1913: FILE: disas/riscv.c:1863:
>> +                case 0: op = rv_op_fmv_s_x; break;
>>
>> WARNING: line over 80 characters
>> #1917: FILE: disas/riscv.c:1867:
>> +                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) &
>> 0b00000111)) {
>>
>> ERROR: trailing statements should be on next line
>> #1918: FILE: disas/riscv.c:1868:
>> +                case 0: op = rv_op_fmv_d_x; break;
>>
>> WARNING: line over 80 characters
>> #1922: FILE: disas/riscv.c:1872:
>> +                switch (((inst >> 17) & 0b11111000) | ((inst >> 12) &
>> 0b00000111)) {
>>
>> ERROR: trailing statements should be on next line
>> #1923: FILE: disas/riscv.c:1873:
>> +                case 0: op = rv_op_fmv_q_x; break;
>>
>> ERROR: trailing statements should be on next line
>> #1930: FILE: disas/riscv.c:1880:
>> +            case 0: op = rv_op_addid; break;
>>
>> ERROR: trailing statements should be on next line
>> #1933: FILE: disas/riscv.c:1883:
>> +                case 0: op = rv_op_sllid; break;
>>
>> ERROR: trailing statements should be on next line
>> #1938: FILE: disas/riscv.c:1888:
>> +                case 0: op = rv_op_srlid; break;
>>
>> ERROR: trailing statements should be on next line
>> #1939: FILE: disas/riscv.c:1889:
>> +                case 16: op = rv_op_sraid; break;
>>
>> ERROR: trailing statements should be on next line
>> #1946: FILE: disas/riscv.c:1896:
>> +            case 0: op = rv_op_beq; break;
>>
>> ERROR: trailing statements should be on next line
>> #1947: FILE: disas/riscv.c:1897:
>> +            case 1: op = rv_op_bne; break;
>>
>> ERROR: trailing statements should be on next line
>> #1948: FILE: disas/riscv.c:1898:
>> +            case 4: op = rv_op_blt; break;
>>
>> ERROR: trailing statements should be on next line
>> #1949: FILE: disas/riscv.c:1899:
>> +            case 5: op = rv_op_bge; break;
>>
>> ERROR: trailing statements should be on next line
>> #1950: FILE: disas/riscv.c:1900:
>> +            case 6: op = rv_op_bltu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1951: FILE: disas/riscv.c:1901:
>> +            case 7: op = rv_op_bgeu; break;
>>
>> ERROR: trailing statements should be on next line
>> #1956: FILE: disas/riscv.c:1906:
>> +            case 0: op = rv_op_jalr; break;
>>
>> ERROR: trailing statements should be on next line
>> #1959: FILE: disas/riscv.c:1909:
>> +        case 27: op = rv_op_jal; break;
>>
>> ERROR: line over 90 characters
>> #1963: FILE: disas/riscv.c:1913:
>> +                switch (((inst >> 20) & 0b111111100000) | ((inst >> 7) &
>> 0b000000011111)) {
>>
>> ERROR: trailing statements should be on next line
>> #1966: FILE: disas/riscv.c:1916:
>> +                    case 0: op = rv_op_ecall; break;
>>
>> ERROR: trailing statements should be on next line
>> #1967: FILE: disas/riscv.c:1917:
>> +                    case 32: op = rv_op_ebreak; break;
>>
>> ERROR: trailing statements should be on next line
>> #1968: FILE: disas/riscv.c:1918:
>> +                    case 64: op = rv_op_uret; break;
>>
>> ERROR: trailing statements should be on next line
>> #1975: FILE: disas/riscv.c:1925:
>> +                        case 0: op = rv_op_sret; break;
>>
>> ERROR: trailing statements should be on next line
>> #1978: FILE: disas/riscv.c:1928:
>> +                    case 4: op = rv_op_sfence_vm; break;
>>
>> ERROR: trailing statements should be on next line
>> #1981: FILE: disas/riscv.c:1931:
>> +                        case 0: op = rv_op_wfi; break;
>>
>> ERROR: trailing statements should be on next line
>> #1986: FILE: disas/riscv.c:1936:
>> +                case 288: op = rv_op_sfence_vma; break;
>>
>> ERROR: trailing statements should be on next line
>> #1989: FILE: disas/riscv.c:1939:
>> +                    case 64: op = rv_op_hret; break;
>>
>> ERROR: trailing statements should be on next line
>> #1994: FILE: disas/riscv.c:1944:
>> +                    case 64: op = rv_op_mret; break;
>>
>> ERROR: trailing statements should be on next line
>> #1999: FILE: disas/riscv.c:1949:
>> +                    case 576: op = rv_op_dret; break;
>>
>> ERROR: trailing statements should be on next line
>> #2004: FILE: disas/riscv.c:1954:
>> +            case 1: op = rv_op_csrrw; break;
>>
>> ERROR: trailing statements should be on next line
>> #2005: FILE: disas/riscv.c:1955:
>> +            case 2: op = rv_op_csrrs; break;
>>
>> ERROR: trailing statements should be on next line
>> #2006: FILE: disas/riscv.c:1956:
>> +            case 3: op = rv_op_csrrc; break;
>>
>> ERROR: trailing statements should be on next line
>> #2007: FILE: disas/riscv.c:1957:
>> +            case 5: op = rv_op_csrrwi; break;
>>
>> ERROR: trailing statements should be on next line
>> #2008: FILE: disas/riscv.c:1958:
>> +            case 6: op = rv_op_csrrsi; break;
>>
>> ERROR: trailing statements should be on next line
>> #2009: FILE: disas/riscv.c:1959:
>> +            case 7: op = rv_op_csrrci; break;
>>
>> WARNING: line over 80 characters
>> #2013: FILE: disas/riscv.c:1963:
>> +            switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) &
>> 0b0000000111)) {
>>
>> ERROR: trailing statements should be on next line
>> #2014: FILE: disas/riscv.c:1964:
>> +            case 0: op = rv_op_addd; break;
>>
>> ERROR: trailing statements should be on next line
>> #2015: FILE: disas/riscv.c:1965:
>> +            case 1: op = rv_op_slld; break;
>>
>> ERROR: trailing statements should be on next line
>> #2016: FILE: disas/riscv.c:1966:
>> +            case 5: op = rv_op_srld; break;
>>
>> ERROR: trailing statements should be on next line
>> #2017: FILE: disas/riscv.c:1967:
>> +            case 8: op = rv_op_muld; break;
>>
>> ERROR: trailing statements should be on next line
>> #2018: FILE: disas/riscv.c:1968:
>> +            case 12: op = rv_op_divd; break;
>>
>> ERROR: trailing statements should be on next line
>> #2019: FILE: disas/riscv.c:1969:
>> +            case 13: op = rv_op_divud; break;
>>
>> ERROR: trailing statements should be on next line
>> #2020: FILE: disas/riscv.c:1970:
>> +            case 14: op = rv_op_remd; break;
>>
>> ERROR: trailing statements should be on next line
>> #2021: FILE: disas/riscv.c:1971:
>> +            case 15: op = rv_op_remud; break;
>>
>> ERROR: trailing statements should be on next line
>> #2022: FILE: disas/riscv.c:1972:
>> +            case 256: op = rv_op_subd; break;
>>
>> ERROR: trailing statements should be on next line
>> #2023: FILE: disas/riscv.c:1973:
>> +            case 261: op = rv_op_srad; break;
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2034: FILE: disas/riscv.c:1984:
>> +static uint32_t operand_rd(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2038: FILE: disas/riscv.c:1988:
>> +static uint32_t operand_rs1(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2042: FILE: disas/riscv.c:1992:
>> +static uint32_t operand_rs2(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2046: FILE: disas/riscv.c:1996:
>> +static uint32_t operand_rs3(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2050: FILE: disas/riscv.c:2000:
>> +static uint32_t operand_aq(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2054: FILE: disas/riscv.c:2004:
>> +static uint32_t operand_rl(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2058: FILE: disas/riscv.c:2008:
>> +static uint32_t operand_pred(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2062: FILE: disas/riscv.c:2012:
>> +static uint32_t operand_succ(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2066: FILE: disas/riscv.c:2016:
>> +static uint32_t operand_rm(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2070: FILE: disas/riscv.c:2020:
>> +static uint32_t operand_shamt5(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2074: FILE: disas/riscv.c:2024:
>> +static uint32_t operand_shamt6(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2078: FILE: disas/riscv.c:2028:
>> +static uint32_t operand_shamt7(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2082: FILE: disas/riscv.c:2032:
>> +static uint32_t operand_crdq(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2086: FILE: disas/riscv.c:2036:
>> +static uint32_t operand_crs1q(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2090: FILE: disas/riscv.c:2040:
>> +static uint32_t operand_crs1rdq(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2094: FILE: disas/riscv.c:2044:
>> +static uint32_t operand_crs2q(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2098: FILE: disas/riscv.c:2048:
>> +static uint32_t operand_crd(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2102: FILE: disas/riscv.c:2052:
>> +static uint32_t operand_crs1(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2106: FILE: disas/riscv.c:2056:
>> +static uint32_t operand_crs1rd(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2110: FILE: disas/riscv.c:2060:
>> +static uint32_t operand_crs2(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2114: FILE: disas/riscv.c:2064:
>> +static uint32_t operand_cimmsh5(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2118: FILE: disas/riscv.c:2068:
>> +static uint32_t operand_csr12(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2122: FILE: disas/riscv.c:2072:
>> +static int32_t operand_imm12(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2126: FILE: disas/riscv.c:2076:
>> +static int32_t operand_imm20(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2130: FILE: disas/riscv.c:2080:
>> +static int32_t operand_jimm20(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2137: FILE: disas/riscv.c:2087:
>> +static int32_t operand_simm12(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2142: FILE: disas/riscv.c:2092:
>> +static int32_t operand_sbimm12(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2149: FILE: disas/riscv.c:2099:
>> +static uint32_t operand_cimmsh6(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2154: FILE: disas/riscv.c:2104:
>> +static int32_t operand_cimmi(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2159: FILE: disas/riscv.c:2109:
>> +static int32_t operand_cimmui(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2164: FILE: disas/riscv.c:2114:
>> +static uint32_t operand_cimmlwsp(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2170: FILE: disas/riscv.c:2120:
>> +static uint32_t operand_cimmldsp(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2176: FILE: disas/riscv.c:2126:
>> +static uint32_t operand_cimmlqsp(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2182: FILE: disas/riscv.c:2132:
>> +static int32_t operand_cimm16sp(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2190: FILE: disas/riscv.c:2140:
>> +static int32_t operand_cimmj(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2201: FILE: disas/riscv.c:2151:
>> +static int32_t operand_cimmb(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2209: FILE: disas/riscv.c:2159:
>> +static uint32_t operand_cimmswsp(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2214: FILE: disas/riscv.c:2164:
>> +static uint32_t operand_cimmsdsp(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2219: FILE: disas/riscv.c:2169:
>> +static uint32_t operand_cimmsqsp(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2224: FILE: disas/riscv.c:2174:
>> +static uint32_t operand_cimm4spn(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2231: FILE: disas/riscv.c:2181:
>> +static uint32_t operand_cimmw(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2237: FILE: disas/riscv.c:2187:
>> +static uint32_t operand_cimmd(rv_inst inst) {
>>
>> ERROR: open brace '{' following function declarations go on the next line
>> #2242: FILE: disas/riscv.c:2192:
>> +static uint32_t operand_cimmq(rv_inst inst) {
>>
>> ERROR: trailing statements should be on next line
>> #2742: FILE: disas/riscv.c:2692:
>> +        default: break;
>>
>> ERROR: trailing statements should be on next line
>> #2807: FILE: disas/riscv.c:2757:
>> +        case 'O': append(buf, opcode_data[dec->op].name, buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2808: FILE: disas/riscv.c:2758:
>> +        case '(': append(buf, "(", buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2809: FILE: disas/riscv.c:2759:
>> +        case ',': append(buf, ",", buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2810: FILE: disas/riscv.c:2760:
>> +        case ')': append(buf, ")", buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2811: FILE: disas/riscv.c:2761:
>> +        case '0': append(buf, rv_ireg_name_sym[dec->rd], buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2812: FILE: disas/riscv.c:2762:
>> +        case '1': append(buf, rv_ireg_name_sym[dec->rs1], buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2813: FILE: disas/riscv.c:2763:
>> +        case '2': append(buf, rv_ireg_name_sym[dec->rs2], buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2814: FILE: disas/riscv.c:2764:
>> +        case '3': append(buf, rv_freg_name_sym[dec->rd], buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2815: FILE: disas/riscv.c:2765:
>> +        case '4': append(buf, rv_freg_name_sym[dec->rs1], buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2816: FILE: disas/riscv.c:2766:
>> +        case '5': append(buf, rv_freg_name_sym[dec->rs2], buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2817: FILE: disas/riscv.c:2767:
>> +        case '6': append(buf, rv_freg_name_sym[dec->rs3], buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2848: FILE: disas/riscv.c:2798:
>> +            case rv_rm_rne: append(buf, "rne", buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2849: FILE: disas/riscv.c:2799:
>> +            case rv_rm_rtz: append(buf, "rtz", buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2850: FILE: disas/riscv.c:2800:
>> +            case rv_rm_rdn: append(buf, "rdn", buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2851: FILE: disas/riscv.c:2801:
>> +            case rv_rm_rup: append(buf, "rup", buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2852: FILE: disas/riscv.c:2802:
>> +            case rv_rm_rmm: append(buf, "rmm", buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2853: FILE: disas/riscv.c:2803:
>> +            case rv_rm_dyn: append(buf, "dyn", buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2854: FILE: disas/riscv.c:2804:
>> +            default:        append(buf, "inv", buflen); break;
>>
>> ERROR: trailing statements should be on next line
>> #2965: FILE: disas/riscv.c:2915:
>> +    case rv32: decompress_inst_rv32(&dec); break;
>>
>> ERROR: trailing statements should be on next line
>> #2966: FILE: disas/riscv.c:2916:
>> +    case rv64: decompress_inst_rv64(&dec); break;
>>
>> ERROR: trailing statements should be on next line
>> #2967: FILE: disas/riscv.c:2917:
>> +    case rv128: decompress_inst_rv128(&dec); break;
>>
>> ERROR: space prohibited between function name and open parenthesis '('
>> #3025: FILE: include/disas/bfd.h:431:
>> +int print_insn_riscv32          (bfd_vma, disassemble_info*);
>>
>> ERROR: space prohibited between function name and open parenthesis '('
>> #3026: FILE: include/disas/bfd.h:432:
>> +int print_insn_riscv64          (bfd_vma, disassemble_info*);
>>
>> total: 343 errors, 38 warnings, 2989 lines checked
>>
>> Your patch has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>>
>> Checking PATCH 5/21: RISC-V CPU Helpers...
>> Checking PATCH 6/21: RISC-V FPU Support...
>> Checking PATCH 7/21: RISC-V GDB Stub...
>> Checking PATCH 8/21: RISC-V TCG Code Generation...
>> ERROR: spaces required around that ':' (ctx:VxE)
>> #662: FILE: target/riscv/translate.c:257:
>> +    CASE_OP_32_64(OPC_RISC_ADD):
>>                                 ^
>>
>> ERROR: spaces required around that ':' (ctx:VxE)
>> #665: FILE: target/riscv/translate.c:260:
>> +    CASE_OP_32_64(OPC_RISC_SUB):
>>                                 ^
>>
>> ERROR: spaces required around that ':' (ctx:VxE)
>> #719: FILE: target/riscv/translate.c:314:
>> +    CASE_OP_32_64(OPC_RISC_MUL):
>>                                 ^
>>
>> total: 3 errors, 0 warnings, 2409 lines checked
>>
>> Your patch has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>>
>> Checking PATCH 9/21: RISC-V Physical Memory Protection...
>> Checking PATCH 10/21: RISC-V Linux User Emulation...
>> Checking PATCH 11/21: RISC-V HTIF Console...
>> Checking PATCH 12/21: RISC-V HART Array...
>> Checking PATCH 13/21: SiFive RISC-V CLINT Block...
>> Checking PATCH 14/21: SiFive RISC-V PLIC Block...
>> Checking PATCH 15/21: RISC-V Spike Machines...
>> Checking PATCH 16/21: RISC-V VirtIO Machine...
>> Checking PATCH 17/21: SiFive RISC-V UART Device...
>> Checking PATCH 18/21: SiFive RISC-V PRCI Block...
>> Checking PATCH 19/21: SiFive Freedom E300 RISC-V Machine...
>> Checking PATCH 20/21: SiFive Freedom U500 RISC-V Machine...
>> Checking PATCH 21/21: RISC-V Build Infrastructure...
>> WARNING: line over 80 characters
>> #222: FILE: scripts/qemu-binfmt-conf.sh:99:
>> +riscv32_magic='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\
>> x00\x00\x00\x02\x00\xf3\x00'
>>
>> ERROR: line over 90 characters
>> #223: FILE: scripts/qemu-binfmt-conf.sh:100:
>> +riscv32_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\
>> xff\xff\xff\xff\xff\xfe\xff\xff\xff'
>>
>> WARNING: line over 80 characters
>> #226: FILE: scripts/qemu-binfmt-conf.sh:103:
>> +riscv64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\
>> x00\x00\x00\x02\x00\xf3\x00'
>>
>> ERROR: line over 90 characters
>> #227: FILE: scripts/qemu-binfmt-conf.sh:104:
>> +riscv64_mask='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\
>> xff\xff\xff\xff\xff\xfe\xff\xff\xff'
>>
>> total: 2 errors, 2 warnings, 151 lines checked
>>
>> Your patch has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>>
>> === OUTPUT END ===
>>
>> Test command exited with code: 1
>>
>>
>> ---
>> Email generated automatically by Patchew [http://patchew.org/].
>> Please send your feedback to patchew-devel@freelists.org
>
>
>
