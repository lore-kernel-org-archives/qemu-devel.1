Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19A9C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA57821721
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA57821721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdg6j-0006aC-Rd
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47117)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hdg3w-00058j-Rr
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hdg3m-0006YW-C7
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:15:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hdg3i-0006RH-Jx
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:15:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2D0E30860B7;
 Wed, 19 Jun 2019 19:15:48 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 504C76013D;
 Wed, 19 Jun 2019 19:15:48 +0000 (UTC)
Date: Wed, 19 Jun 2019 16:15:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190619191546.GD26409@habkost.net>
References: <20190612084104.34984-1-like.xu@linux.intel.com>
 <20190612084104.34984-8-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612084104.34984-8-like.xu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 19 Jun 2019 19:15:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 7/9] target/i386: Support multi-dies
 when host doesn't support CPUID.1F
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 04:41:02PM +0800, Like Xu wrote:
> In guest CPUID generation process, the cpuid_min_level would be adjusted to
> the maximum passed value for basic CPUID configuration and it should not be
> restricted by the limited value returned from cpu_x86_cpuid(). After the basic
> cpu_x86_cpuid() loop is finished, the cpuid_0_entry.eax needs to be configured
> again by the last adjusted cpuid_min_level value.
> 
> If a user wants to expose CPUID.1F by passing dies > 1 for any reason without
> host support, a per-cpu smp topology warning will appear but it's not blocked.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

This code doesn't look at host CPUID at all, as far as I can see.
Isn't it simpler to just make cpuid_x86_cpuid() return the
correct data?

> ---
>  target/i386/kvm.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 9b4da9b265..8bf1604d2b 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -931,12 +931,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      struct kvm_cpuid_entry2 *c;
>      uint32_t signature[3];
>      int kvm_base = KVM_CPUID_SIGNATURE;
> -    int r;
> +    int r, cpuid_0_entry, cpuid_min_level;
>      Error *local_err = NULL;
>  
>      memset(&cpuid_data, 0, sizeof(cpuid_data));
>  
> -    cpuid_i = 0;
> +    cpuid_i = cpuid_0_entry = cpuid_min_level = 0;
>  
>      r = kvm_arch_set_tsc_khz(cs);
>      if (r < 0) {
> @@ -1050,6 +1050,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>  
>      cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
>  
> +    /* Allow 0x1f setting regardless of kvm support if nr_dies > 1 */
> +    if (limit < 0x1f && env->nr_dies > 1 && cpu->enable_cpuid_0x1f) {
> +        limit = env->cpuid_level = env->cpuid_min_level = 0x1f;
> +        warn_report("CPU topology: the CPUID.1F isn't supported on the host.");
> +    }
> +
>      for (i = 0; i <= limit; i++) {
>          if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
>              fprintf(stderr, "unsupported level value: 0x%x\n", limit);
> @@ -1151,8 +1157,22 @@ int kvm_arch_init_vcpu(CPUState *cs)
>              cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
>              break;
>          }
> +
> +        /* Remember the index of cpuid.0 leaf for reconfiguration. */
> +        cpuid_0_entry = (i == 0) ? (cpuid_i - 1) : cpuid_0_entry;
> +
> +        /* Adjust cpuid_min_level to the maximum index of valid basic cpuids. */
> +        cpuid_min_level =
> +                ((c->eax | c->ebx | c->ecx | c->edx | c->flags | c->index) &&
> +                                (i > cpuid_min_level)) ? i : cpuid_min_level;
>      }
>  
> +    env->cpuid_level = env->cpuid_min_level = cpuid_min_level;
> +
> +    /* Reconfigure cpuid_0_eax value to follow CPUID.0 instruction spec.*/
> +    c = &cpuid_data.entries[cpuid_0_entry];
> +    cpu_x86_cpuid(env, 0, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
> +
>      if (limit >= 0x0a) {
>          uint32_t eax, edx;
>  
> -- 
> 2.21.0
> 

-- 
Eduardo

