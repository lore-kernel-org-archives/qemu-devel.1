Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF7C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94BF920767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuQCjolE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94BF920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5Ie-0003fd-R2
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD5I2-0003Gt-PO
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:21:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37589
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kD5I0-0006ob-Pb
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598962887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lbqchzx/yU/aqfqMNL4bEUivK3aLfdFG3TTobFht4UY=;
 b=cuQCjolEjZeCgahqQAPEZMk/cxCKrLoB047YbLDRuBZb0YHT0ke62jWB4EmCDyOPDrEHrX
 qlGrVuczA42ihmJhVt+3Lwoitex4Wiin45lWUUDYmRzcuMlFnYm/D1zJnPk3YXbf8ThIYN
 2/QCltqMxaHZGDUrBBGnnwhdxtDFhLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-DRcRKAL7Mqag_yvr5cNTmQ-1; Tue, 01 Sep 2020 08:21:26 -0400
X-MC-Unique: DRcRKAL7Mqag_yvr5cNTmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEAD710ABDA8;
 Tue,  1 Sep 2020 12:21:24 +0000 (UTC)
Received: from imammedo-mac (unknown [10.40.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C0B619C59;
 Tue,  1 Sep 2020 12:21:20 +0000 (UTC)
Date: Tue, 1 Sep 2020 14:21:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 08/10] Revert "hw/i386: Update structures to save the
 number of nodes per package"
Message-ID: <20200901142118.645937d6@imammedo-mac>
In-Reply-To: <159889937478.21294.4192291354416942986.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
 <159889937478.21294.4192291354416942986.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 13:42:54 -0500
Babu Moger <babu.moger@amd.com> wrote:

> This reverts commit c24a41bb53c0854d22c96b30d57cfcaa543c409d.
> 
> Remove the EPYC specific apicid decoding and use the generic
> default decoding.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c               |    1 -
>  hw/i386/x86.c              |    1 -
>  include/hw/i386/topology.h |    1 -
>  target/i386/cpu.c          |    1 -
>  target/i386/cpu.h          |    1 -
>  tests/test-x86-cpuid.c     |   40 ++++++++++++++++++++--------------------
>  6 files changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 0677d6a272..d11daacc23 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1501,7 +1501,6 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      init_topo_info(&topo_info, x86ms);
>  
>      env->nr_dies = x86ms->smp_dies;
> -    env->nr_nodes = topo_info.nodes_per_pkg;
>  
>      /*
>       * If APIC ID is not set,
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 727c4a0f1d..c1954db152 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -62,7 +62,6 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
>  {
>      MachineState *ms = MACHINE(x86ms);
>  
> -    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
>      topo_info->dies_per_pkg = x86ms->smp_dies;
>      topo_info->cores_per_die = ms->smp.cores;
>      topo_info->threads_per_core = ms->smp.threads;
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index b9593b9905..81573f6cfd 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -53,7 +53,6 @@ typedef struct X86CPUTopoIDs {
>  } X86CPUTopoIDs;
>  
>  typedef struct X86CPUTopoInfo {
> -    unsigned nodes_per_pkg;
>      unsigned dies_per_pkg;
>      unsigned cores_per_die;
>      unsigned threads_per_core;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 256bfa669f..ba4667b33c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7023,7 +7023,6 @@ static void x86_cpu_initfn(Object *obj)
>      FeatureWord w;
>  
>      env->nr_dies = 1;
> -    env->nr_nodes = 1;
>      cpu_set_cpustate_pointers(cpu);
>  
>      object_property_add(obj, "family", "int",
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 5ff8ad8427..d3097be6a5 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1629,7 +1629,6 @@ typedef struct CPUX86State {
>      TPRAccess tpr_access_type;
>  
>      unsigned nr_dies;
> -    unsigned nr_nodes;
>  } CPUX86State;
>  
>  struct kvm_msrs;
> diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
> index 049030a50e..bfabc0403a 100644
> --- a/tests/test-x86-cpuid.c
> +++ b/tests/test-x86-cpuid.c
> @@ -31,12 +31,12 @@ static void test_topo_bits(void)
>      X86CPUTopoInfo topo_info = {0};
>  
>      /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
>  
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 1};
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
> @@ -45,39 +45,39 @@ static void test_topo_bits(void)
>  
>      /* Test field width calculation for multiple values
>       */
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 2};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 1);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 3};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 3};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 4};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 4};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
>  
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 14};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 14};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 15};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 15};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 16};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 16};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 1, 17};
> +    topo_info = (X86CPUTopoInfo) {1, 1, 17};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 5);
>  
>  
> -    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 30, 2};
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 31, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 31, 2};
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 32, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 32, 2};
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
> -    topo_info = (X86CPUTopoInfo) {0, 1, 33, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 33, 2};
>      g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
>  
> -    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {1, 30, 2};
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
> -    topo_info = (X86CPUTopoInfo) {0, 2, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {2, 30, 2};
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
> -    topo_info = (X86CPUTopoInfo) {0, 3, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {3, 30, 2};
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
> -    topo_info = (X86CPUTopoInfo) {0, 4, 30, 2};
> +    topo_info = (X86CPUTopoInfo) {4, 30, 2};
>      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
>  
>      /* build a weird topology and see if IDs are calculated correctly
> @@ -85,18 +85,18 @@ static void test_topo_bits(void)
>  
>      /* This will use 2 bits for thread ID and 3 bits for core ID
>       */
> -    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
> +    topo_info = (X86CPUTopoInfo) {1, 6, 3};
>      g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
>      g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
>      g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
>      g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
>  
> -    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
> +    topo_info = (X86CPUTopoInfo) {1, 6, 3};
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
>  
> -    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
> +    topo_info = (X86CPUTopoInfo) {1, 6, 3};
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
>                       (1 << 2) | 0);
>      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,
> 


