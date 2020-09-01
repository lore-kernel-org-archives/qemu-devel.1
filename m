Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9FCC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED245205CB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="MnYGLeuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED245205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2h3-00034V-4G
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kD2gK-0002PF-Ec
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:34:24 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:47010 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kD2gI-0001AI-H1
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:34:24 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id CC8B253F9D;
 Tue,  1 Sep 2020 09:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1598952859;
 x=1600767260; bh=RzHpEk1F10DnnAZ0g88sHAftn+WYCKrbgMThcHzIqMs=; b=
 MnYGLeuGNSyq7upsAKcGGh2cWYns2+2pJkix8W1c8Us1GpHal/g76MdivEUrioYV
 eGpWQJlE9wxXFdmcWRn/cwhFFYquzk9GMOUOROkqdF+FZdaA5IZOzz3OAm9qLHwE
 A6Z6SHSlKWww0ihd5CX58m6/66sL0Zrsg2TveZBHnIY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RjxkTBE-zxH3; Tue,  1 Sep 2020 12:34:19 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id A1C7F4D905;
 Tue,  1 Sep 2020 12:34:18 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 1 Sep
 2020 12:34:18 +0300
Date: Tue, 1 Sep 2020 12:34:18 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 11/16] cpus: remove checks for non-NULL cpus_accel
Message-ID: <20200901093418.GC22344@SPB-NB-133.local>
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-12-cfontana@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200901072201.7133-12-cfontana@suse.de>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:30:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 09:21:56AM +0200, Claudio Fontana wrote:
> now that all accelerators support the CpusAccel interface,
> we can remove most checks for non-NULL cpus_accel,
> we just add a sanity check/assert at vcpu creation.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  softmmu/cpus.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/softmmu/cpus.c b/softmmu/cpus.c
> index 3d8350fba9..f32ecb4bb9 100644
> --- a/softmmu/cpus.c
> +++ b/softmmu/cpus.c
> @@ -166,34 +166,46 @@ void cpu_synchronize_all_pre_loadvm(void)
>  
>  void cpu_synchronize_state(CPUState *cpu)
>  {
> -    if (cpus_accel && cpus_accel->synchronize_state) {
> +    if (cpus_accel->synchronize_state) {
>          cpus_accel->synchronize_state(cpu);
>      }
>  }
>  
>  void cpu_synchronize_post_reset(CPUState *cpu)
>  {
> -    if (cpus_accel && cpus_accel->synchronize_post_reset) {
> +    if (cpus_accel->synchronize_post_reset) {
>          cpus_accel->synchronize_post_reset(cpu);
>      }
>  }
>  
>  void cpu_synchronize_post_init(CPUState *cpu)
>  {
> -    if (cpus_accel && cpus_accel->synchronize_post_init) {
> +    if (cpus_accel->synchronize_post_init) {
>          cpus_accel->synchronize_post_init(cpu);
>      }
>  }
>  
>  void cpu_synchronize_pre_loadvm(CPUState *cpu)
>  {
> -    if (cpus_accel && cpus_accel->synchronize_pre_loadvm) {
> +    if (cpus_accel->synchronize_pre_loadvm) {
>          cpus_accel->synchronize_pre_loadvm(cpu);
>      }
>  }
>  
>  int64_t cpus_get_virtual_clock(void)
>  {
> +    /*
> +     * XXX
> +     *
> +     * need to check that cpus_accel is not NULL, because qcow2 calls
> +     * qemu_get_clock_ns(CLOCK_VIRTUAL) without any accel initialized and
> +     * with ticks disabled in some io-tests:
> +     * 030 040 041 060 099 120 127 140 156 161 172 181 191 192 195 203 229 249 256 267
> +     *
> +     * is this expected?
> +     *
> +     * XXX
> +     */
>      if (cpus_accel && cpus_accel->get_virtual_clock) {
>          return cpus_accel->get_virtual_clock();
>      }
> @@ -207,7 +219,7 @@ int64_t cpus_get_virtual_clock(void)
>   */
>  int64_t cpus_get_elapsed_ticks(void)
>  {
> -    if (cpus_accel && cpus_accel->get_elapsed_ticks) {
> +    if (cpus_accel->get_elapsed_ticks) {
>          return cpus_accel->get_elapsed_ticks();
>      }
>      return cpu_get_ticks();
> @@ -399,7 +411,7 @@ void cpus_kick_thread(CPUState *cpu)
>  void qemu_cpu_kick(CPUState *cpu)
>  {
>      qemu_cond_broadcast(cpu->halt_cond);
> -    if (cpus_accel && cpus_accel->kick_vcpu_thread) {
> +    if (cpus_accel->kick_vcpu_thread) {
>          cpus_accel->kick_vcpu_thread(cpu);
>      } else { /* default */
>          cpus_kick_thread(cpu);
> @@ -573,12 +585,9 @@ void qemu_init_vcpu(CPUState *cpu)
>          cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
>      }
>  
> -    if (cpus_accel) {
> -        /* accelerator already implements the CpusAccel interface */
> -        cpus_accel->create_vcpu_thread(cpu);
> -    } else {
> -        g_assert_not_reached();
> -    }
> +    /* accelerators all implement the CpusAccel interface */
> +    g_assert(cpus_accel != NULL && cpus_accel->create_vcpu_thread != NULL);
> +    cpus_accel->create_vcpu_thread(cpu);
>  
>      while (!cpu->created) {
>          qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
> -- 
> 2.26.2
> 

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>

but I still find the condition (if cpus_accel->func) redundant, is it
feasible to drop it?

Regards,
Roman

