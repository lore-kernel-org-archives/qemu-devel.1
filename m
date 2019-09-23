Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D378C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490A821655
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490A821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPLn-0007k7-7F
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iCPKr-0007D0-EK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iCPKq-0006g8-6i
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:29:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iCPKm-0006dU-1G; Mon, 23 Sep 2019 10:29:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4F6B730ADBAA;
 Mon, 23 Sep 2019 14:28:59 +0000 (UTC)
Received: from [10.36.116.30] (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8E7260FB6;
 Mon, 23 Sep 2019 14:28:43 +0000 (UTC)
Subject: Re: [PATCH 1/4] target/arm: Make cpu_register() and set_feature()
 available for other files
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190921150420.30743-1-thuth@redhat.com>
 <20190921150420.30743-2-thuth@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9457e42b-8550-561a-d2d0-7dce076af200@redhat.com>
Date: Mon, 23 Sep 2019 16:28:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190921150420.30743-2-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 23 Sep 2019 14:28:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 9/21/19 5:04 PM, Thomas Huth wrote:
> Move the common set_feature() and unset_feature() functions from cpu.c and
> cpu64.c to internals.h, and make cpu_register() (renamed to arm_cpu_register())
> available from there, too, so we can register CPUs also from other files
> in the future.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  target/arm/cpu.c       | 20 ++------------------
>  target/arm/cpu64.c     | 17 +----------------
>  target/arm/internals.h | 18 ++++++++++++++++++
>  3 files changed, 21 insertions(+), 34 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 2399c14471..f1f9eecdc8 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -614,16 +614,6 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
>  
>  #endif
>  
> -static inline void set_feature(CPUARMState *env, int feature)
> -{
> -    env->features |= 1ULL << feature;
> -}
> -
> -static inline void unset_feature(CPUARMState *env, int feature)
> -{
> -    env->features &= ~(1ULL << feature);
> -}
> -
>  static int
>  print_insn_thumb1(bfd_vma pc, disassemble_info *info)
>  {
> @@ -2515,12 +2505,6 @@ static void arm_max_initfn(Object *obj)
>  
>  #endif /* !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64) */
>  
> -struct ARMCPUInfo {
> -    const char *name;
> -    void (*initfn)(Object *obj);
> -    void (*class_init)(ObjectClass *oc, void *data);
> -};
> -
>  static const ARMCPUInfo arm_cpus[] = {
>  #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
>      { .name = "arm926",      .initfn = arm926_initfn },
> @@ -2681,7 +2665,7 @@ static void cpu_register_class_init(ObjectClass *oc, void *data)
>      acc->info = data;
>  }
>  
> -static void cpu_register(const ARMCPUInfo *info)
> +void arm_cpu_register(const ARMCPUInfo *info)
>  {
>      TypeInfo type_info = {
>          .parent = TYPE_ARM_CPU,
> @@ -2722,7 +2706,7 @@ static void arm_cpu_register_types(void)
>      type_register_static(&idau_interface_type_info);
>  
>      while (info->name) {
> -        cpu_register(info);
> +        arm_cpu_register(info);
>          info++;
>      }
>  
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index d7f5bf610a..5239ba5529 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> +#include "internals.h"
>  #include "qemu/module.h"
>  #if !defined(CONFIG_USER_ONLY)
>  #include "hw/loader.h"
> @@ -29,16 +30,6 @@
>  #include "kvm_arm.h"
>  #include "qapi/visitor.h"
>  
> -static inline void set_feature(CPUARMState *env, int feature)
> -{
> -    env->features |= 1ULL << feature;
> -}
> -
> -static inline void unset_feature(CPUARMState *env, int feature)
> -{
> -    env->features &= ~(1ULL << feature);
> -}
> -
>  #ifndef CONFIG_USER_ONLY
>  static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
> @@ -396,12 +387,6 @@ static void aarch64_max_initfn(Object *obj)
>      }
>  }
>  
> -struct ARMCPUInfo {
> -    const char *name;
> -    void (*initfn)(Object *obj);
> -    void (*class_init)(ObjectClass *oc, void *data);
> -};
> -
>  static const ARMCPUInfo aarch64_cpus[] = {
>      { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
>      { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 232d963875..e71196ed5f 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1046,4 +1046,22 @@ void arm_log_exception(int idx);
>  
>  #endif /* !CONFIG_USER_ONLY */
>  
> +static inline void set_feature(CPUARMState *env, int feature)
> +{
> +    env->features |= 1ULL << feature;
> +}
> +
> +static inline void unset_feature(CPUARMState *env, int feature)
> +{
> +    env->features &= ~(1ULL << feature);
> +}
> +
> +struct ARMCPUInfo {
> +    const char *name;
> +    void (*initfn)(Object *obj);
> +    void (*class_init)(ObjectClass *oc, void *data);
> +};
> +
> +void arm_cpu_register(const ARMCPUInfo *info);
> +
>  #endif
> 

