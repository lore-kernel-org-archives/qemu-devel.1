Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2C7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A31F2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WC2sBAok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A31F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuZk-00030j-82
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1juuYo-0002NK-W9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:15:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41467
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1juuYm-0004qD-DK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594631738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKulg9JdPFtvxY3hiws1/TIAPAGWfgw3WyUevmTnd9o=;
 b=WC2sBAokYtGpFEy8fna1O6uI3v2zldWfDM2AjNnOHLdu5aZoFPMxL2LNrvBGbHtTkh5O/9
 s3MpsTysEFUh3XW67X3xsE7BqrhbdANPRmR/+fXLQYeN+EZmsTOKJriIViSwqFfZMjcoyS
 FC7KuVhD0Mdr0oQrxUxwPA/KEEKh3as=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-Y-CP-HH2M1Wwc4CEQIqbaQ-1; Mon, 13 Jul 2020 05:15:35 -0400
X-MC-Unique: Y-CP-HH2M1Wwc4CEQIqbaQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C6308027E1;
 Mon, 13 Jul 2020 09:15:34 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05EB660BF3;
 Mon, 13 Jul 2020 09:15:29 +0000 (UTC)
Date: Mon, 13 Jul 2020 11:15:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 2/3] hw/i386: Build apic_id from CpuInstanceProperties
Message-ID: <20200713111527.23bf98a8@redhat.com>
In-Reply-To: <159362466828.36204.14044362989991188460.stgit@naples-babu.amd.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
 <159362466828.36204.14044362989991188460.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 01 Jul 2020 12:31:08 -0500
Babu Moger <babu.moger@amd.com> wrote:

> Build apic_id from CpuInstanceProperties if numa configured.
> Use the node_id from user provided numa information. This
> will avoid conflicts between numa information and apic_id
> generated.
> 
> Re-arranged the code little bit to make sure CpuInstanceProperties
> is initialized before calling.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/i386/pc.c               |    6 +++++-
>  hw/i386/x86.c              |   19 +++++++++++++------
>  include/hw/i386/topology.h |   14 +++++++++++---
>  include/hw/i386/x86.h      |    6 ++++--
>  tests/test-x86-cpuid.c     |   39 ++++++++++++++++++++-------------------
>  5 files changed, 53 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d103b8c0ab..e613b2299f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -800,13 +800,17 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
>  void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
>  {
>      X86MachineState *x86ms = X86_MACHINE(ms);
> -    int64_t apic_id = x86_cpu_apic_id_from_index(x86ms, id);
> +    CpuInstanceProperties props;
> +    int64_t apic_id;
>      Error *local_err = NULL;
>  
>      if (id < 0) {
>          error_setg(errp, "Invalid CPU id: %" PRIi64, id);
>          return;
>      }
> +    props = ms->possible_cpus->cpus[id].props;
> +
> +    apic_id = x86_cpu_apic_id_from_index(x86ms, id, props);
>  
>      if (apic_id >= ACPI_CPU_HOTPLUG_ID_LIMIT) {
>          error_setg(errp, "Unable to add CPU: %" PRIi64
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 34229b45c7..7554416ae0 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -93,7 +93,8 @@ static void x86_set_epyc_topo_handlers(MachineState *machine)
>   * all CPUs up to max_cpus.
>   */
>  uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
> -                                    unsigned int cpu_index)
> +                                    unsigned int cpu_index,
> +                                    CpuInstanceProperties props)
>  {
>      X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
>      X86CPUTopoInfo topo_info;
> @@ -102,7 +103,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>  
>      init_topo_info(&topo_info, x86ms);
>  
> -    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
> +    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index, props);
>      if (x86mc->compat_apic_id_mode) {
>          if (cpu_index != correct_id && !warned && !qtest_enabled()) {
>              error_report("APIC IDs set in compatibility mode, "
> @@ -136,6 +137,8 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>      const CPUArchIdList *possible_cpus;
>      MachineState *ms = MACHINE(x86ms);
>      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
> +    CpuInstanceProperties props;
> +
>  
>      /* Check for apicid encoding */
>      if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
> @@ -144,6 +147,8 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>  
>      x86_cpu_set_default_version(default_cpu_version);
>  
> +    possible_cpus = mc->possible_cpu_arch_ids(ms);
> +
>      /*
>       * Calculates the limit to CPU APIC ID values
>       *
> @@ -152,13 +157,15 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>       *
>       * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_create().
>       */
> -    x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
> -                                                      ms->smp.max_cpus - 1) + 1;
> -    possible_cpus = mc->possible_cpu_arch_ids(ms);
> +    props = ms->possible_cpus->cpus[ms->smp.max_cpus - 1].props;
>  
> +    x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
> +                                                      ms->smp.max_cpus - 1,
> +                                                      props) + 1;
>      for (i = 0; i < ms->possible_cpus->len; i++) {
> +        props = ms->possible_cpus->cpus[i].props;
>          ms->possible_cpus->cpus[i].arch_id =
> -            x86_cpu_apic_id_from_index(x86ms, i);
> +            x86_cpu_apic_id_from_index(x86ms, i, props);
>      }
>  
>      for (i = 0; i < ms->smp.cpus; i++) {
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index 7cb21e9c82..a800fc905f 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -221,10 +221,17 @@ static inline void x86_init_topo_ids(X86CPUTopoInfo *topo_info,
>   * 'cpu_index' is a sequential, contiguous ID for the CPU.
>   */
>  static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *topo_info,
> -                                                     unsigned cpu_index)
> +                                                     unsigned cpu_index,
> +                                                     CpuInstanceProperties props)
>  {
>      X86CPUTopoIDs topo_ids;
> -    x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
> +
> +    if (props.has_node_id) {
> +        x86_init_topo_ids(topo_info, props, &topo_ids);
> +    } else {
> +        x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
why this branch is needed?

> +    }
> +
>      return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
>  }
>  /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> @@ -280,7 +287,8 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
>   * 'cpu_index' is a sequential, contiguous ID for the CPU.
>   */
>  static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
> -                                                unsigned cpu_index)
> +                                                unsigned cpu_index,
> +                                                CpuInstanceProperties props)
>  {
>      X86CPUTopoIDs topo_ids;
>      x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids);
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index b79f24e285..3109f39554 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -65,7 +65,8 @@ typedef struct {
>  
>      /* Apic id specific handlers */
>      uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
> -                                    unsigned cpu_index);
> +                                    unsigned cpu_index,
> +                                    CpuInstanceProperties props);
>      void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_info,
>                                   X86CPUTopoIDs *topo_ids);
>      apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info,
> @@ -93,7 +94,8 @@ typedef struct {
>  void init_topo_info(X86CPUTopoInfo *topo_info, const X86MachineState *x86ms);
>  
>  uint32_t x86_cpu_apic_id_from_index(X86MachineState *pcms,
> -                                    unsigned int cpu_index);
> +                                    unsigned int cpu_index,
> +                                    CpuInstanceProperties props);
>  
>  void x86_cpu_new(X86MachineState *pcms, int64_t apic_id, Error **errp);
>  void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
> diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
> index 049030a50e..a1308e214b 100644
> --- a/tests/test-x86-cpuid.c
> +++ b/tests/test-x86-cpuid.c
> @@ -29,6 +29,7 @@
>  static void test_topo_bits(void)
>  {
>      X86CPUTopoInfo topo_info = {0};
> +    CpuInstanceProperties props = {0};
>  
>      /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
>      topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
> @@ -37,10 +38,10 @@ static void test_topo_bits(void)
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
>  
>      topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 3), ==, 3);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0, props), ==, 0);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1, props), ==, 1);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2, props), ==, 2);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 3, props), ==, 3);
>  
>  
>      /* Test field width calculation for multiple values
> @@ -92,38 +93,38 @@ static void test_topo_bits(void)
>      g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
>  
>      topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0, props), ==, 0);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1, props), ==, 1);
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2, props), ==, 2);
>  
>      topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0, props), ==,
>                       (1 << 2) | 0);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1, props), ==,
>                       (1 << 2) | 1);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 2), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 2, props), ==,
>                       (1 << 2) | 2);
>  
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 0), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 0, props), ==,
>                       (2 << 2) | 0);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 1), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 1, props), ==,
>                       (2 << 2) | 1);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 2), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 2, props), ==,
>                       (2 << 2) | 2);
>  
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 0), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 0, props), ==,
>                       (5 << 2) | 0);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 1), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 1, props), ==,
>                       (5 << 2) | 1);
> -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 2), ==,
> +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 2, props), ==,
>                       (5 << 2) | 2);
>  
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
> -                     1 * 6 * 3 + 0 * 3 + 0), ==, (1 << 5));
> +                     1 * 6 * 3 + 0 * 3 + 0, props), ==, (1 << 5));
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
> -                     1 * 6 * 3 + 1 * 3 + 1), ==, (1 << 5) | (1 << 2) | 1);
> +                     1 * 6 * 3 + 1 * 3 + 1, props), ==, (1 << 5) | (1 << 2) | 1);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
> -                     3 * 6 * 3 + 5 * 3 + 2), ==, (3 << 5) | (5 << 2) | 2);
> +                     3 * 6 * 3 + 5 * 3 + 2, props), ==, (3 << 5) | (5 << 2) | 2);
>  }
>  
>  int main(int argc, char **argv)
> 


