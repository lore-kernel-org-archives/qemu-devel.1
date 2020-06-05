Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB19C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D332070B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 14:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D332070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDCc-0004JQ-Bs
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 10:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jhDBk-0003Ly-3B
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:19:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:59298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jhDBi-0007Rm-Tj
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:19:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1BC38AECD;
 Fri,  5 Jun 2020 14:19:15 +0000 (UTC)
Subject: Re: [PATCH 01/13] i386: hvf: Move HVFState definition into hvf
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
 <20200528193758.51454-2-r.bolshakov@yadro.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <0bf90b7e-65d4-ab00-a1a6-c107e1c3e8f7@suse.de>
Date: Fri, 5 Jun 2020 16:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200528193758.51454-2-r.bolshakov@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 01:26:41
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

On 5/28/20 9:37 PM, Roman Bolshakov wrote:
> "sysemu/hvf.h" is intended for inclusion in generic code. However it
> also contains several hvf definitions and declarations, including
> HVFState that are used only inside "hvf.c". "hvf-i386.h" would be more
> appropriate place to define HVFState as it's only included by "hvf.c"
> and "x86_task.c".
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  include/sysemu/hvf.h       | 37 -------------------------------------
>  target/i386/hvf/hvf-i386.h | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 37 deletions(-)
> 
> diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
> index d211e808e9..30a565ab73 100644
> --- a/include/sysemu/hvf.h
> +++ b/include/sysemu/hvf.h
> @@ -15,8 +15,6 @@
>  
>  #include "cpu.h"
>  #include "qemu/bitops.h"
> -#include "exec/memory.h"
> -#include "sysemu/accel.h"
>  
>  extern bool hvf_allowed;
>  #ifdef CONFIG_HVF
> @@ -32,41 +30,6 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>  #define hvf_get_supported_cpuid(func, idx, reg) 0
>  #endif
>  
> -/* hvf_slot flags */
> -#define HVF_SLOT_LOG (1 << 0)
> -
> -typedef struct hvf_slot {
> -    uint64_t start;
> -    uint64_t size;
> -    uint8_t *mem;
> -    int slot_id;
> -    uint32_t flags;
> -    MemoryRegion *region;
> -} hvf_slot;
> -
> -typedef struct hvf_vcpu_caps {
> -    uint64_t vmx_cap_pinbased;
> -    uint64_t vmx_cap_procbased;
> -    uint64_t vmx_cap_procbased2;
> -    uint64_t vmx_cap_entry;
> -    uint64_t vmx_cap_exit;
> -    uint64_t vmx_cap_preemption_timer;
> -} hvf_vcpu_caps;
> -
> -typedef struct HVFState {
> -    AccelState parent;
> -    hvf_slot slots[32];
> -    int num_slots;
> -
> -    hvf_vcpu_caps *hvf_caps;
> -} HVFState;
> -extern HVFState *hvf_state;
> -
> -void hvf_set_phys_mem(MemoryRegionSection *, bool);
> -void hvf_handle_io(CPUArchState *, uint16_t, void *,
> -                  int, int, int);
> -hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
> -
>  /* Disable HVF if |disable| is 1, otherwise, enable it iff it is supported by
>   * the host CPU. Use hvf_enabled() after this to get the result. */
>  void hvf_disable(int disable);
> diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
> index 15ee4835cf..7cdf256649 100644
> --- a/target/i386/hvf/hvf-i386.h
> +++ b/target/i386/hvf/hvf-i386.h
> @@ -16,6 +16,7 @@
>  #ifndef HVF_I386_H
>  #define HVF_I386_H
>  
> +#include "sysemu/accel.h"
>  #include "sysemu/hvf.h"
>  #include "cpu.h"
>  #include "x86.h"
> @@ -37,6 +38,40 @@ struct hvf_state {
>      uint64_t mem_quota;
>  };
>  
> +/* hvf_slot flags */
> +#define HVF_SLOT_LOG (1 << 0)
> +
> +typedef struct hvf_slot {
> +    uint64_t start;
> +    uint64_t size;
> +    uint8_t *mem;
> +    int slot_id;
> +    uint32_t flags;
> +    MemoryRegion *region;
> +} hvf_slot;
> +
> +typedef struct hvf_vcpu_caps {
> +    uint64_t vmx_cap_pinbased;
> +    uint64_t vmx_cap_procbased;
> +    uint64_t vmx_cap_procbased2;
> +    uint64_t vmx_cap_entry;
> +    uint64_t vmx_cap_exit;
> +    uint64_t vmx_cap_preemption_timer;
> +} hvf_vcpu_caps;
> +
> +typedef struct HVFState {
> +    AccelState parent;
> +    hvf_slot slots[32];
> +    int num_slots;
> +
> +    hvf_vcpu_caps *hvf_caps;
> +} HVFState;
> +extern HVFState *hvf_state;
> +
> +void hvf_set_phys_mem(MemoryRegionSection *, bool);
> +void hvf_handle_io(CPUArchState *, uint16_t, void *, int, int, int);
> +hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
> +
>  #ifdef NEED_CPU_H
>  /* Functions exported to host specific mode */
>  
> 

Reviewed-by: Claudio Fontana <cfontana@suse.de>

