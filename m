Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEF2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 19:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CBD207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 19:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idwZagCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CBD207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB0nz-0000pb-8E
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 15:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kB0m1-000614-Ux
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 15:07:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34001
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ckuehl@redhat.com>) id 1kB0lz-00048u-Rv
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 15:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598468871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a07nTm9p+uFL/cBgcEJoDBqsweuoxo7VFuGlsvwVi7g=;
 b=idwZagCVap9bM4chbt0I4Vzdj3zmq7OtDohHYH4OX//qpjXetKDoz6NVk4ed8323RZ1erA
 h8IIAh9jqg+2auBuHgEmQ9S2dLEFa57a/L4rP37Fc/TwP7tsrBYWPkDSpHYQjZO/QV0HZ6
 No4VvQeehqn8zonJoHsEmXR0K09TP04=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-s6-bZEPiOMq7KmBaL4swXw-1; Wed, 26 Aug 2020 15:07:49 -0400
X-MC-Unique: s6-bZEPiOMq7KmBaL4swXw-1
Received: by mail-qk1-f200.google.com with SMTP id t10so2518910qke.11
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 12:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a07nTm9p+uFL/cBgcEJoDBqsweuoxo7VFuGlsvwVi7g=;
 b=ME/kGGEY92kggJWCy4zcID8uklnWVzD9hfRequKLFFU+1Q8LhP0WdDnK4PWVsMLYXQ
 wG3/dSh6G1b/byY+hIJA7GJQXXKfLx/+lzQlXuR1nwohWyI2j1pEQOXgrJNSxO/RJaHq
 BolqdKG7l02zzwD8y3aR4HamTzGQN/2EDNbCK/GMtQSEZ+3h1J0hJwD4ZZUnyRwr6xVF
 ZjLy/2VWW0jinnY2bBbHLxPF2l9VpaJJ+UVoA8xAkYzdD47i0sqKPL7YCkQOvjVI9bkM
 wbh9YBYXQ+GXzsP9HdoFnvNyWCmqPMN9LUjWMrgvjQDhi+7HJFRBhQcokF/zA+nK0IcK
 NMFQ==
X-Gm-Message-State: AOAM531f83aXD654Dr6bFN+PQRl6TKBTAz1FfEXY2B/dlYAkS7DAYcjc
 g9tXMySHbxmH5Nr55xVydmaR6RirZhBStKtqq1IzX8/fLsRLMtkyhR8AP1vT9G8FsBESJuG4mrU
 xCe34QrH+bZangVs=
X-Received: by 2002:ac8:73c4:: with SMTP id v4mr7726521qtp.116.1598468868884; 
 Wed, 26 Aug 2020 12:07:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfSJRaiXyFaBnrtMqYioa6gOA8mWlW2AiQlgfUQDXoQJXHGjysYw3Myhe4RXoiDi92cVEGdw==
X-Received: by 2002:ac8:73c4:: with SMTP id v4mr7726501qtp.116.1598468868637; 
 Wed, 26 Aug 2020 12:07:48 -0700 (PDT)
Received: from [192.168.0.172] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
 by smtp.gmail.com with ESMTPSA id
 q34sm2885634qtk.32.2020.08.26.12.07.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 12:07:48 -0700 (PDT)
Subject: Re: [PATCH 3/4] sev/i386: Don't allow a system reset under an SEV-ES
 guest
To: Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <cover.1598382343.git.thomas.lendacky@amd.com>
 <b394ef2e743ebd57d3b8fb5ce1d5069c030ffcfc.1598382343.git.thomas.lendacky@amd.com>
From: Connor Kuehl <ckuehl@redhat.com>
Message-ID: <cfca1081-15e1-c57c-e3b9-d26421cfc21a@redhat.com>
Date: Wed, 26 Aug 2020 14:07:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b394ef2e743ebd57d3b8fb5ce1d5069c030ffcfc.1598382343.git.thomas.lendacky@amd.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ckuehl@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ckuehl@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 2:05 PM, Tom Lendacky wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> An SEV-ES guest does not allow register state to be altered once it has
> been measured. When a SEV-ES guest issues a reboot command, Qemu will
> reset the vCPU state and resume the guest. This will cause failures under
> SEV-ES, so prevent that from occurring.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   accel/kvm/kvm-all.c       | 8 ++++++++
>   include/sysemu/cpus.h     | 2 ++
>   include/sysemu/hw_accel.h | 4 ++++
>   include/sysemu/kvm.h      | 2 ++
>   softmmu/cpus.c            | 5 +++++
>   softmmu/vl.c              | 5 ++++-
>   6 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 54e8fd098d..1d925821b2 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2384,6 +2384,14 @@ void kvm_flush_coalesced_mmio_buffer(void)
>       s->coalesced_flush_in_progress = false;
>   }
>   
> +bool kvm_cpu_check_resettable(void)
> +{
> +    /* If we have a valid reset vector override, then SEV-ES is active
> +     * and the CPU can't be reset.
> +     */
> +    return !kvm_state->reset_valid;
> +}
> +
>   static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
>   {
>       if (!cpu->vcpu_dirty) {
> diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
> index 3c1da6a018..6d688c757f 100644
> --- a/include/sysemu/cpus.h
> +++ b/include/sysemu/cpus.h
> @@ -24,6 +24,8 @@ void dump_drift_info(void);
>   void qemu_cpu_kick_self(void);
>   void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
>   
> +bool cpu_is_resettable(void);
> +
>   void cpu_synchronize_all_states(void);
>   void cpu_synchronize_all_post_reset(void);
>   void cpu_synchronize_all_post_init(void);
> diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
> index e128f8b06b..1fddf4f5e1 100644
> --- a/include/sysemu/hw_accel.h
> +++ b/include/sysemu/hw_accel.h
> @@ -17,6 +17,10 @@
>   #include "sysemu/hvf.h"
>   #include "sysemu/whpx.h"
>   
> +static inline bool cpu_check_resettable(void)
> +{
> +    return kvm_enabled() ? kvm_cpu_check_resettable() : true;
> +}

There's a missing newline here that would separate the closing brace 
from the function below this one.

>   static inline void cpu_synchronize_state(CPUState *cpu)
>   {
>       if (kvm_enabled()) {
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index f74cfa85ab..eb94bbbff9 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -494,6 +494,8 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>   
>   #endif /* NEED_CPU_H */
>   
> +bool kvm_cpu_check_resettable(void);
> +
>   void kvm_cpu_synchronize_state(CPUState *cpu);
>   void kvm_cpu_synchronize_post_reset(CPUState *cpu);
>   void kvm_cpu_synchronize_post_init(CPUState *cpu);
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index a802e899ab..32f286643f 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -927,6 +927,11 @@ void hw_error(const char *fmt, ...)
>       abort();
>   }
>   
> +bool cpu_is_resettable(void)
> +{
> +    return cpu_check_resettable();
> +}
> +
>   void cpu_synchronize_all_states(void)
>   {
>       CPUState *cpu;
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 4eb9d1f7fd..422fbb1650 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -1475,7 +1475,10 @@ void qemu_system_guest_crashloaded(GuestPanicInformation *info)
>   
>   void qemu_system_reset_request(ShutdownCause reason)
>   {
> -    if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
> +    if (!cpu_is_resettable()) {
> +        error_report("cpus are not resettable, terminating");
> +        shutdown_requested = reason;
> +    } else if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
>           shutdown_requested = reason;
>       } else {
>           reset_requested = reason;
> 


