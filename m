Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F37C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7A320578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmQr3i04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7A320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJMt-0005zM-Ir
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBJMG-0005Yc-Vl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBJMF-0007xQ-B8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:26:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23832
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBJMF-0007wY-7D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583763974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9VRyuhQMGzYFLB31ZfivqIQMelakRKO2AHyD3WjBaCw=;
 b=MmQr3i04OKs74yAD1j1mNuBYPjc9K96YUXp6YOOPwXR0YurnhVoKB8lkYvpfUtfn3SGrfe
 e121/FrzLkXtCobSZr7iV1FYgDHpgnwYsnaTQmB/t7cyK8U018azmek3Oa4uZrd6On5dUS
 LqbUOgNJSn5oyr320Lw3VHGV7oA3f+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-rNFGds2EPVOSLyE6nsmlAg-1; Mon, 09 Mar 2020 10:26:12 -0400
X-MC-Unique: rNFGds2EPVOSLyE6nsmlAg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4507E800D53;
 Mon,  9 Mar 2020 14:26:11 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-206-77.brq.redhat.com [10.40.206.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6723860BEE;
 Mon,  9 Mar 2020 14:26:06 +0000 (UTC)
Date: Mon, 9 Mar 2020 15:26:03 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 06/16] hw/i386: Update structures to save the number
 of nodes per package
Message-ID: <20200309152603.44ae5e11@Igors-MacBook-Pro>
In-Reply-To: <158326545066.40452.2744012199788458115.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326545066.40452.2744012199788458115.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Tue, 03 Mar 2020 13:57:30 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Update structures X86CPUTopoIDs and CPUX86State to hold the number of
> nodes per package. This is required to build EPYC mode topology.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c               |    1 +
>  hw/i386/x86.c              |    1 +
>  include/hw/i386/topology.h |    1 +
>  target/i386/cpu.c          |    1 +
>  target/i386/cpu.h          |    1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 68bf08f285..3d13cd46d6 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1526,6 +1526,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      init_topo_info(&topo_info, x86ms);
>  
>      env->nr_dies = x86ms->smp_dies;
> +    env->nr_nodes = topo_info.nodes_per_pkg;
>  
>      /*
>       * If APIC ID is not set,
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 79badcc4ec..929b80c9c7 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -62,6 +62,7 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
>  {
>      MachineState *ms = MACHINE(x86ms);
>  
> +    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
>      topo_info->dies_per_pkg = x86ms->smp_dies;
>      topo_info->cores_per_die = ms->smp.cores;
>      topo_info->threads_per_core = ms->smp.threads;
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index ba52d49079..04f01e2a09 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -53,6 +53,7 @@ typedef struct X86CPUTopoIDs {
>  } X86CPUTopoIDs;
>  
>  typedef struct X86CPUTopoInfo {
> +    unsigned nodes_per_pkg;
>      unsigned dies_per_pkg;
>      unsigned cores_per_die;
>      unsigned threads_per_core;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1263271edd..40670f8aca 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6829,6 +6829,7 @@ static void x86_cpu_initfn(Object *obj)
>      FeatureWord w;
>  
>      env->nr_dies = 1;
> +    env->nr_nodes = 1;
>      cpu_set_cpustate_pointers(cpu);
>  
>      object_property_add(obj, "family", "int",
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 576f309bbf..20abbda647 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1607,6 +1607,7 @@ typedef struct CPUX86State {
>      TPRAccess tpr_access_type;
>  
>      unsigned nr_dies;
> +    unsigned nr_nodes;
>  } CPUX86State;
>  
>  struct kvm_msrs;
> 


