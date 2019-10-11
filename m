Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE61C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 04:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6FD2196E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 04:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6FD2196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iImA2-0000pQ-0H
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 00:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iIm9M-0000Nz-1v
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 00:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iIm9K-0000vo-Nh
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 00:03:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iIm9K-0000va-Hy
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 00:03:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24EA088382D;
 Fri, 11 Oct 2019 04:03:29 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CE735C1B2;
 Fri, 11 Oct 2019 04:03:26 +0000 (UTC)
Date: Fri, 11 Oct 2019 01:03:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [Qemu-devel] [RFC 2 PATCH 15/16] i386: Fix pkg_id offset for
 epyc mode
Message-ID: <20191011040325.GI29387@habkost.net>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779720146.21957.9036938076017885210.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156779720146.21957.9036938076017885210.stgit@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 11 Oct 2019 04:03:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ssg.sos.staff" <ssg.sos.staff@amd.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 07:13:22PM +0000, Moger, Babu wrote:
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c |   24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f25491a029..f8b1fc5c07 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4094,9 +4094,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                     uint32_t *eax, uint32_t *ebx,
>                     uint32_t *ecx, uint32_t *edx)
>  {
> +    MachineState *ms = MACHINE(qdev_get_machine());
>      X86CPU *cpu = env_archcpu(env);
>      CPUState *cs = env_cpu(env);
> -    uint32_t die_offset;
> +    uint32_t die_offset, pkg_offset;
>      uint32_t limit;
>      uint32_t signature[3];
>  
> @@ -4119,6 +4120,21 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          index = env->cpuid_level;
>      }
>  
> +    if (ms->epyc) {
> +        X86CPUTopoInfo topo_info = {
> +            .numa_nodes = nb_numa_nodes,
> +            .nr_sockets = ms->smp.sockets,
> +            .nr_cores = ms->smp.cores,
> +            .nr_threads = ms->smp.threads,
> +        };

Why aren't you using initialize_topo_info() here?

> +        unsigned nodes = nodes_in_pkg(&topo_info);
> +        pkg_offset = apicid_pkg_offset_epyc(nodes, MAX_CCX, MAX_CORES_IN_CCX,
> +                                            cs->nr_threads);
> +    } else {
> +        pkg_offset = apicid_pkg_offset(env->nr_dies, cs->nr_cores,
> +                                       cs->nr_threads);
> +    }

I think we won't need this at all if we simply:

1) Add nodes_per_pkg to X86CPUTopoInfo;
2) make nodes_per_pkg configurable;
3) just use topo->nr_dies and topo->nr_cores instead of those
   constants.

-- 
Eduardo

