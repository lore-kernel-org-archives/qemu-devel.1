Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20984C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2A9D20578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXgi87CV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A9D20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKca-0005qM-Um
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBKFL-0002L4-Uf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBKFI-0004UR-7a
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:23:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38101
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBKFI-0004Te-33
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583767387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3T3ZNbTF9E9t2diUqMgtTS0H0dhU31gFBmlNw2If3Q=;
 b=KXgi87CVKWYXR7ZUDWHkj4Tgl0hzMgHoOEmH2FgGDcvtXBK1I94m4w7ra+GeipropekhZF
 adafeLa4qbCLoipoGrwb2Lhj0JUkU4djw993ALC/KTFCFLd8QIeiULFqkz8fL0wsUqdaTM
 xjvvkjyls13vWuWNMgxa1r38ylDjgZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-nY0MEOAZOJ-EXvLzkuKzFA-1; Mon, 09 Mar 2020 11:23:03 -0400
X-MC-Unique: nY0MEOAZOJ-EXvLzkuKzFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD27E800D50;
 Mon,  9 Mar 2020 15:23:02 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-206-77.brq.redhat.com [10.40.206.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6600E9008F;
 Mon,  9 Mar 2020 15:22:58 +0000 (UTC)
Date: Mon, 9 Mar 2020 16:22:56 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 15/16] i386: Fix pkg_id offset for EPYC cpu models
Message-ID: <20200309162256.018da8a8@Igors-MacBook-Pro>
In-Reply-To: <158326551090.40452.9028312447486758348.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326551090.40452.9028312447486758348.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Tue, 03 Mar 2020 13:58:30 -0600
Babu Moger <babu.moger@amd.com> wrote:

> If the system is numa configured the pkg_offset needs
> to be adjusted for EPYC cpu models. Fix it calling the
> model specific handler.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c      |    1 +
>  target/i386/cpu.c |    4 ++--
>  target/i386/cpu.h |    1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c600ba0432..b6237a3a14 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1527,6 +1527,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>  
>      env->nr_dies = x86ms->smp_dies;
>      env->nr_nodes = topo_info.nodes_per_pkg;
> +    env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
>  
>      /*
>       * If APIC ID is not set,
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f870f7c55b..9b160cbdd1 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5503,7 +5503,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
>              break;
>          case 1:
> -            *eax = apicid_pkg_offset(&topo_info);
> +            *eax = env->pkg_offset;
>              *ebx = cs->nr_cores * cs->nr_threads;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
>              break;
> @@ -5537,7 +5537,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
>              break;
>          case 2:
> -            *eax = apicid_pkg_offset(&topo_info);
> +            *eax = env->pkg_offset;
>              *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
>              break;
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 34f0d994ef..aac86af5cf 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1608,6 +1608,7 @@ typedef struct CPUX86State {
>  
>      unsigned nr_dies;
>      unsigned nr_nodes;
> +    unsigned pkg_offset;
>  } CPUX86State;
>  
>  struct kvm_msrs;
> 


