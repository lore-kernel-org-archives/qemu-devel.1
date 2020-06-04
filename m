Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB50C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66BC2065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66BC2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglqq-00026X-6w
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jglps-0000Ot-2J
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:06:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:60868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jglpq-0005En-2m
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:06:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D976FAC46;
 Thu,  4 Jun 2020 09:06:51 +0000 (UTC)
Subject: Re: [PATCH 06/13] i386: hvf: Use IP from CPUX86State
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
 <20200528193758.51454-7-r.bolshakov@yadro.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <9e0f0355-73d4-33af-3a1b-a96e64006877@suse.de>
Date: Thu, 4 Jun 2020 11:06:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200528193758.51454-7-r.bolshakov@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 00:26:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Roman,

On 5/28/20 9:37 PM, Roman Bolshakov wrote:
> Drop and replace rip field from HVFX86EmulatorState in favor of eip from
> common CPUX86State.
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  target/i386/hvf/hvf.c        |  6 +--
>  target/i386/hvf/x86.h        |  3 --
>  target/i386/hvf/x86_decode.c |  6 +--
>  target/i386/hvf/x86_emu.c    | 86 ++++++++++++++++++------------------
>  target/i386/hvf/x86_task.c   |  4 +-
>  5 files changed, 51 insertions(+), 54 deletions(-)
> 
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 8ff1d25521..45ae55dd27 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -797,7 +797,7 @@ int hvf_vcpu_exec(CPUState *cpu)
>                  } else {
>                      RAX(env) = (uint64_t)val;
>                  }
> -                RIP(env) += ins_len;
> +                env->eip += ins_len;
>                  store_regs(cpu);
>                  break;
>              } else if (!string && !in) {
> @@ -871,7 +871,7 @@ int hvf_vcpu_exec(CPUState *cpu)
>              } else {
>                  simulate_wrmsr(cpu);
>              }
> -            RIP(env) += ins_len;
> +            env->eip += ins_len;
>              store_regs(cpu);
>              break;
>          }
> @@ -907,7 +907,7 @@ int hvf_vcpu_exec(CPUState *cpu)
>                  error_report("Unrecognized CR %d", cr);
>                  abort();
>              }
> -            RIP(env) += ins_len;
> +            env->eip += ins_len;
>              store_regs(cpu);
>              break;
>          }
> diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
> index 56fcde13c6..e3ab7c5137 100644
> --- a/target/i386/hvf/x86.h
> +++ b/target/i386/hvf/x86.h
> @@ -294,7 +294,6 @@ typedef struct lazy_flags {
>  /* Definition of hvf_x86_state is here */
>  struct HVFX86EmulatorState {
>      uint64_t fetch_rip;
> -    uint64_t rip;
>      struct x86_register regs[16];
>      struct x86_reg_flags   rflags;
>      struct lazy_flags   lflags;
> @@ -302,8 +301,6 @@ struct HVFX86EmulatorState {
>  };
>  
>  /* useful register access  macros */
> -#define RIP(cpu)    (cpu->hvf_emul->rip)
> -#define EIP(cpu)    ((uint32_t)cpu->hvf_emul->rip)
>  #define RFLAGS(cpu) (cpu->hvf_emul->rflags.rflags)
>  #define EFLAGS(cpu) (cpu->hvf_emul->rflags.eflags)
>  
> diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
> index 77c346605f..a590088f54 100644
> --- a/target/i386/hvf/x86_decode.c
> +++ b/target/i386/hvf/x86_decode.c
> @@ -75,7 +75,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
>          VM_PANIC_EX("%s invalid size %d\n", __func__, size);
>          break;
>      }
> -    target_ulong va  = linear_rip(env_cpu(env), RIP(env)) + decode->len;
> +    target_ulong va  = linear_rip(env_cpu(env), env->eip) + decode->len;
>      vmx_read_mem(env_cpu(env), &val, va, size);
>      decode->len += size;
>      
> @@ -1771,7 +1771,7 @@ void calc_modrm_operand32(CPUX86State *env, struct x86_decode *decode,
>          ptr += get_sib_val(env, decode, &seg);
>      } else if (!decode->modrm.mod && 5 == decode->modrm.rm) {
>          if (x86_is_long_mode(env_cpu(env))) {
> -            ptr += RIP(env) + decode->len;
> +            ptr += env->eip + decode->len;
>          } else {
>              ptr = decode->displacement;
>          }
> @@ -1807,7 +1807,7 @@ void calc_modrm_operand64(CPUX86State *env, struct x86_decode *decode,
>      if (4 == rm) {
>          ptr = get_sib_val(env, decode, &seg) + offset;
>      } else if (0 == mod && 5 == rm) {
> -        ptr = RIP(env) + decode->len + (int32_t) offset;
> +        ptr = env->eip + decode->len + (int32_t) offset;
>      } else {
>          ptr = get_reg_val(env, src, decode->rex.rex, decode->rex.b, 8) +
>                (int64_t) offset;
> diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
> index 92ab815f5d..0efd9f9928 100644
> --- a/target/i386/hvf/x86_emu.c
> +++ b/target/i386/hvf/x86_emu.c
> @@ -267,49 +267,49 @@ static void exec_mov(struct CPUX86State *env, struct x86_decode *decode)
>      write_val_ext(env, decode->op[0].ptr, decode->op[1].val,
>                    decode->operand_size);
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_add(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      EXEC_2OP_FLAGS_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_or(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      EXEC_2OP_FLAGS_CMD(env, decode, |, SET_FLAGS_OSZAPC_LOGIC, true);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_adc(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      EXEC_2OP_FLAGS_CMD(env, decode, +get_CF(env)+, SET_FLAGS_OSZAPC_ADD, true);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_sbb(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      EXEC_2OP_FLAGS_CMD(env, decode, -get_CF(env)-, SET_FLAGS_OSZAPC_SUB, true);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_and(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      EXEC_2OP_FLAGS_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, true);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_sub(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, true);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_xor(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      EXEC_2OP_FLAGS_CMD(env, decode, ^, SET_FLAGS_OSZAPC_LOGIC, true);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_neg(struct CPUX86State *env, struct x86_decode *decode)
> @@ -332,13 +332,13 @@ static void exec_neg(struct CPUX86State *env, struct x86_decode *decode)
>      }
>  
>      /*lflags_to_rflags(env);*/
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_cmp(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_inc(struct CPUX86State *env, struct x86_decode *decode)
> @@ -348,7 +348,7 @@ static void exec_inc(struct CPUX86State *env, struct x86_decode *decode)
>  
>      EXEC_2OP_FLAGS_CMD(env, decode, +1+, SET_FLAGS_OSZAP_ADD, true);
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_dec(struct CPUX86State *env, struct x86_decode *decode)
> @@ -357,13 +357,13 @@ static void exec_dec(struct CPUX86State *env, struct x86_decode *decode)
>      decode->op[1].val = 0;
>  
>      EXEC_2OP_FLAGS_CMD(env, decode, -1-, SET_FLAGS_OSZAP_SUB, true);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_tst(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      EXEC_2OP_FLAGS_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, false);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_not(struct CPUX86State *env, struct x86_decode *decode)
> @@ -372,7 +372,7 @@ static void exec_not(struct CPUX86State *env, struct x86_decode *decode)
>  
>      write_val_ext(env, decode->op[0].ptr, ~decode->op[0].val,
>                    decode->operand_size);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  void exec_movzx(struct CPUX86State *env, struct x86_decode *decode)
> @@ -392,7 +392,7 @@ void exec_movzx(struct CPUX86State *env, struct x86_decode *decode)
>      decode->op[1].val = read_val_ext(env, decode->op[1].ptr, src_op_size);
>      write_val_ext(env, decode->op[0].ptr, decode->op[1].val, op_size);
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_out(struct CPUX86State *env, struct x86_decode *decode)
> @@ -416,7 +416,7 @@ static void exec_out(struct CPUX86State *env, struct x86_decode *decode)
>          VM_PANIC("Bad out opcode\n");
>          break;
>      }
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_in(struct CPUX86State *env, struct x86_decode *decode)
> @@ -452,7 +452,7 @@ static void exec_in(struct CPUX86State *env, struct x86_decode *decode)
>          break;
>      }
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static inline void string_increment_reg(struct CPUX86State *env, int reg,
> @@ -505,7 +505,7 @@ static void exec_ins(struct CPUX86State *env, struct x86_decode *decode)
>          exec_ins_single(env, decode);
>      }
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_outs_single(struct CPUX86State *env, struct x86_decode *decode)
> @@ -528,7 +528,7 @@ static void exec_outs(struct CPUX86State *env, struct x86_decode *decode)
>          exec_outs_single(env, decode);
>      }
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_movs_single(struct CPUX86State *env, struct x86_decode *decode)
> @@ -556,7 +556,7 @@ static void exec_movs(struct CPUX86State *env, struct x86_decode *decode)
>          exec_movs_single(env, decode);
>      }
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_cmps_single(struct CPUX86State *env, struct x86_decode *decode)
> @@ -586,7 +586,7 @@ static void exec_cmps(struct CPUX86State *env, struct x86_decode *decode)
>      } else {
>          exec_cmps_single(env, decode);
>      }
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  
> @@ -612,7 +612,7 @@ static void exec_stos(struct CPUX86State *env, struct x86_decode *decode)
>          exec_stos_single(env, decode);
>      }
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_scas_single(struct CPUX86State *env, struct x86_decode *decode)
> @@ -638,7 +638,7 @@ static void exec_scas(struct CPUX86State *env, struct x86_decode *decode)
>          exec_scas_single(env, decode);
>      }
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_lods_single(struct CPUX86State *env, struct x86_decode *decode)
> @@ -661,7 +661,7 @@ static void exec_lods(struct CPUX86State *env, struct x86_decode *decode)
>          exec_lods_single(env, decode);
>      }
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  void simulate_rdmsr(struct CPUState *cpu)
> @@ -758,7 +758,7 @@ void simulate_rdmsr(struct CPUState *cpu)
>  static void exec_rdmsr(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      simulate_rdmsr(env_cpu(env));
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  void simulate_wrmsr(struct CPUState *cpu)
> @@ -853,7 +853,7 @@ void simulate_wrmsr(struct CPUState *cpu)
>  static void exec_wrmsr(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      simulate_wrmsr(env_cpu(env));
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  /*
> @@ -909,25 +909,25 @@ static void do_bt(struct CPUX86State *env, struct x86_decode *decode, int flag)
>  static void exec_bt(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      do_bt(env, decode, 0);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_btc(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      do_bt(env, decode, 1);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_btr(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      do_bt(env, decode, 3);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_bts(struct CPUX86State *env, struct x86_decode *decode)
>  {
>      do_bt(env, decode, 2);
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  void exec_shl(struct CPUX86State *env, struct x86_decode *decode)
> @@ -991,7 +991,7 @@ void exec_shl(struct CPUX86State *env, struct x86_decode *decode)
>  
>  exit:
>      /* lflags_to_rflags(env); */
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  void exec_movsx(CPUX86State *env, struct x86_decode *decode)
> @@ -1014,7 +1014,7 @@ void exec_movsx(CPUX86State *env, struct x86_decode *decode)
>  
>      write_val_ext(env, decode->op[0].ptr, decode->op[1].val, op_size);
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  void exec_ror(struct CPUX86State *env, struct x86_decode *decode)
> @@ -1092,7 +1092,7 @@ void exec_ror(struct CPUX86State *env, struct x86_decode *decode)
>          break;
>          }
>      }
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  void exec_rol(struct CPUX86State *env, struct x86_decode *decode)
> @@ -1173,7 +1173,7 @@ void exec_rol(struct CPUX86State *env, struct x86_decode *decode)
>          break;
>          }
>      }
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  
> @@ -1259,7 +1259,7 @@ void exec_rcl(struct CPUX86State *env, struct x86_decode *decode)
>          break;
>          }
>      }
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  void exec_rcr(struct CPUX86State *env, struct x86_decode *decode)
> @@ -1334,7 +1334,7 @@ void exec_rcr(struct CPUX86State *env, struct x86_decode *decode)
>          break;
>          }
>      }
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_xchg(struct CPUX86State *env, struct x86_decode *decode)
> @@ -1346,7 +1346,7 @@ static void exec_xchg(struct CPUX86State *env, struct x86_decode *decode)
>      write_val_ext(env, decode->op[1].ptr, decode->op[0].val,
>                    decode->operand_size);
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static void exec_xadd(struct CPUX86State *env, struct x86_decode *decode)
> @@ -1355,7 +1355,7 @@ static void exec_xadd(struct CPUX86State *env, struct x86_decode *decode)
>      write_val_ext(env, decode->op[1].ptr, decode->op[0].val,
>                    decode->operand_size);
>  
> -    RIP(env) += decode->len;
> +    env->eip += decode->len;
>  }
>  
>  static struct cmd_handler {
> @@ -1434,7 +1434,7 @@ void load_regs(struct CPUState *cpu)
>  
>      RFLAGS(env) = rreg(cpu->hvf_fd, HV_X86_RFLAGS);
>      rflags_to_lflags(env);
> -    RIP(env) = rreg(cpu->hvf_fd, HV_X86_RIP);
> +    env->eip = rreg(cpu->hvf_fd, HV_X86_RIP);
>  }
>  
>  void store_regs(struct CPUState *cpu)
> @@ -1457,20 +1457,20 @@ void store_regs(struct CPUState *cpu)
>  
>      lflags_to_rflags(env);
>      wreg(cpu->hvf_fd, HV_X86_RFLAGS, RFLAGS(env));
> -    macvm_set_rip(cpu, RIP(env));
> +    macvm_set_rip(cpu, env->eip);
>  }
>  
>  bool exec_instruction(struct CPUX86State *env, struct x86_decode *ins)
>  {
>      /*if (hvf_vcpu_id(cpu))
> -    printf("%d, %llx: exec_instruction %s\n", hvf_vcpu_id(cpu),  RIP(cpu),
> +    printf("%d, %llx: exec_instruction %s\n", hvf_vcpu_id(cpu),  env->eip,
>            decode_cmd_to_string(ins->cmd));*/
>  
>      if (!_cmd_handler[ins->cmd].handler) {
> -        printf("Unimplemented handler (%llx) for %d (%x %x) \n", RIP(env),
> +        printf("Unimplemented handler (%llx) for %d (%x %x) \n", env->eip,




this space before \n is what checkpatch is complaining about.

Ciao,

CLaudio

>                  ins->cmd, ins->opcode[0],
>                  ins->opcode_len > 1 ? ins->opcode[1] : 0);
> -        RIP(env) += ins->len;
> +        env->eip += ins->len;
>          return true;
>      }
>  
> diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
> index 1daac6cc2b..834baec3ea 100644
> --- a/target/i386/hvf/x86_task.c
> +++ b/target/i386/hvf/x86_task.c
> @@ -38,7 +38,7 @@ static void save_state_to_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
>      CPUX86State *env = &x86_cpu->env;
>  
>      /* CR3 and ldt selector are not saved intentionally */
> -    tss->eip = EIP(env);
> +    tss->eip = (uint32_t)env->eip;
>      tss->eflags = EFLAGS(env);
>      tss->eax = EAX(env);
>      tss->ecx = ECX(env);
> @@ -64,7 +64,7 @@ static void load_state_from_tss32(CPUState *cpu, struct x86_tss_segment32 *tss)
>  
>      wvmcs(cpu->hvf_fd, VMCS_GUEST_CR3, tss->cr3);
>  
> -    RIP(env) = tss->eip;
> +    env->eip = tss->eip;
>      EFLAGS(env) = tss->eflags | 2;
>  
>      /* General purpose registers */
> 


