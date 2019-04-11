Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3714C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B3E2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B3E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48014 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEYgw-00072U-UC
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 08:20:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEYfR-0006Pu-SG
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEYfQ-0001uC-Ka
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:18:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hEYfQ-0001u0-9I; Thu, 11 Apr 2019 08:18:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B3613065457;
	Thu, 11 Apr 2019 12:18:55 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A0EEE605CF;
	Thu, 11 Apr 2019 12:18:52 +0000 (UTC)
Date: Thu, 11 Apr 2019 14:18:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <20190411141848.119ee969@redhat.com>
In-Reply-To: <efb2140df508fc04be96c5dc0f989923bfcb7424.1554937288.git.alistair.francis@wdc.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<efb2140df508fc04be96c5dc0f989923bfcb7424.1554937288.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 11 Apr 2019 12:18:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3 2/6] target/riscv: Fall back to
 generating a RISC-V CPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
	"palmer@sifive.com" <palmer@sifive.com>,
	"qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"ijc@hellion.org.uk" <ijc@hellion.org.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411121848.nJYzCKHH-dGNUweAAyx_jA-cV-6e3cvYC1JGod8FF0I@z>

On Wed, 10 Apr 2019 23:10:25 +0000
Alistair Francis <Alistair.Francis@wdc.com> wrote:

> If a user specifies a CPU that we don't understand then we want to fall
> back to a CPU generated from the ISA string.
It might look like a nice thing to do at the beginning, but
fallbacks become a source of pain in future and get in the way
of refactorings if there is a promise to maintain defaults (fallbacks)
stable.

I suggest do not fallback to anything, just fail cleanly
with informative error telling users what is wrong and let user
fix their invalid CLI in the first place.

 
> At the moment the generated CPU is assumed to be a privledge spec
> version 1.10 CPU with an MMU. This can be changed in the future.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>  - Ensure a minimal length so we don't run off the end of the string.
>  - Don't parse the rv32/rv64 in the loop
>  target/riscv/cpu.c | 101 ++++++++++++++++++++++++++++++++++++++++++++-
>  target/riscv/cpu.h |   2 +
>  2 files changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d61bce6d55..27be9e412a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -19,6 +19,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> +#include "qemu/error-report.h"
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "qapi/error.h"
> @@ -103,6 +104,99 @@ static void set_resetvec(CPURISCVState *env, int resetvec)
>  #endif
>  }
>  
> +static void riscv_generate_cpu_init(Object *obj)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    CPURISCVState *env = &cpu->env;
> +    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> +    const char *riscv_cpu = mcc->isa_str;
> +    target_ulong target_misa = 0;
> +    target_ulong rvxlen = 0;
> +    int i;
> +    bool valid = false;
> +
> +    /*
> +     * We need at least 5 charecters for the string to be valid. Check that
> +     * now so we can be lazier later.
> +     */
> +    if (strlen(riscv_cpu) < 5) {
> +        error_report("'%s' does not appear to be a valid RISC-V ISA string",
> +                     riscv_cpu);
> +        exit(1);
> +    }
> +
> +    if (riscv_cpu[0] == 'r' && riscv_cpu[1] == 'v') {
> +        /* Starts with "rv" */
> +        if (riscv_cpu[2] == '3' && riscv_cpu[3] == '2') {
> +            valid = true;
> +            rvxlen = RV32;
> +        }
> +        if (riscv_cpu[2] == '6' && riscv_cpu[3] == '4') {
> +            valid = true;
> +            rvxlen = RV64;
> +        }
> +    }
> +
> +    if (!valid) {
> +        error_report("'%s' does not appear to be a valid RISC-V CPU",
> +                     riscv_cpu);
> +        exit(1);
> +    }
> +
> +    for (i = 4; i < strlen(riscv_cpu); i++) {
> +        switch (riscv_cpu[i]) {
> +        case 'i':
> +            if (target_misa & RVE) {
> +                error_report("I and E extensions are incompatible");
> +                exit(1);
> +            }
> +            target_misa |= RVI;
> +            continue;
> +        case 'e':
> +            if (target_misa & RVI) {
> +                error_report("I and E extensions are incompatible");
> +                exit(1);
> +            }
> +            target_misa |= RVE;
> +            continue;
> +        case 'g':
> +            target_misa |= RVI | RVM | RVA | RVF | RVD;
> +            continue;
> +        case 'm':
> +            target_misa |= RVM;
> +            continue;
> +        case 'a':
> +            target_misa |= RVA;
> +            continue;
> +        case 'f':
> +            target_misa |= RVF;
> +            continue;
> +        case 'd':
> +            target_misa |= RVD;
> +            continue;
> +        case 'c':
> +            target_misa |= RVC;
> +            continue;
> +        case 's':
> +            target_misa |= RVS;
> +            continue;
> +        case 'u':
> +            target_misa |= RVU;
> +            continue;
> +        default:
> +            warn_report("QEMU does not support the %c extension",
> +                        riscv_cpu[i]);
> +            continue;
> +        }
> +    }
> +
> +    set_misa(env, rvxlen | target_misa);
> +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> +    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_feature(env, RISCV_FEATURE_MMU);
> +    set_feature(env, RISCV_FEATURE_PMP);
> +}
> +
>  static void riscv_any_cpu_init(Object *obj)
>  {
>      CPURISCVState *env = &RISCV_CPU(obj)->env;
> @@ -178,6 +272,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
>  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
> +    RISCVCPUClass *mcc;
>      char *typename;
>      char **cpuname;
>  
> @@ -188,7 +283,10 @@ static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
>      g_free(typename);
>      if (!oc || !object_class_dynamic_cast(oc, TYPE_RISCV_CPU) ||
>          object_class_is_abstract(oc)) {
> -        return NULL;
> +        /* No CPU found, try the generic CPU and pass in the ISA string */
> +        oc = object_class_by_name(TYPE_RISCV_CPU_GEN);
> +        mcc = RISCV_CPU_CLASS(oc);
> +        mcc->isa_str = g_strdup(cpu_model);
>      }
>      return oc;
>  }
> @@ -440,6 +538,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>          .class_init = riscv_cpu_class_init,
>      },
>      DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
> +    DEFINE_CPU(TYPE_RISCV_CPU_GEN,              riscv_generate_cpu_init),
>  #if defined(TARGET_RISCV32)
>      DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_09_1, rv32gcsu_priv1_09_1_cpu_init),
>      DEFINE_CPU(TYPE_RISCV_CPU_RV32GCSU_V1_10_0, rv32gcsu_priv1_10_0_cpu_init),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 20bce8742e..453108a855 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -48,6 +48,7 @@
>  #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
>  
>  #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
> +#define TYPE_RISCV_CPU_GEN              RISCV_CPU_TYPE_NAME("rv*")
>  #define TYPE_RISCV_CPU_RV32GCSU_V1_09_1 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.9.1")
>  #define TYPE_RISCV_CPU_RV32GCSU_V1_10_0 RISCV_CPU_TYPE_NAME("rv32gcsu-v1.10.0")
>  #define TYPE_RISCV_CPU_RV32IMACU_NOMMU  RISCV_CPU_TYPE_NAME("rv32imacu-nommu")
> @@ -211,6 +212,7 @@ typedef struct RISCVCPUClass {
>      /*< public >*/
>      DeviceRealize parent_realize;
>      void (*parent_reset)(CPUState *cpu);
> +    const char *isa_str;
>  } RISCVCPUClass;
>  
>  /**


