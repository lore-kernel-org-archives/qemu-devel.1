Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76024C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 02:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ABF720B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 02:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABF720B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIkhk-0002dm-2r
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 22:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iIkgZ-000298-CF
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 22:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iIkgV-0004Sg-7l
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 22:29:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51104)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iIkgV-0004Pn-23
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 22:29:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1B8DD356C9;
 Fri, 11 Oct 2019 02:29:37 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECBD819D70;
 Fri, 11 Oct 2019 02:29:33 +0000 (UTC)
Date: Thu, 10 Oct 2019 23:29:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [Qemu-devel] [RFC 2 PATCH 03/16] hw/i386: Introduce
 X86CPUTopoInfo to contain topology info
Message-ID: <20191011022932.GA29387@habkost.net>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779711572.21957.10722611828264773686.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156779711572.21957.10722611828264773686.stgit@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 11 Oct 2019 02:29:37 +0000 (UTC)
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

On Fri, Sep 06, 2019 at 07:11:57PM +0000, Moger, Babu wrote:
> This is an effort to re-arrange few data structure for better
> readability. Add X86CPUTopoInfo which will have all the topology
> informations required to build the cpu topology. There is no
> functional changes.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/i386/pc.c               |   40 +++++++++++++++++++++++++++-------------
>  include/hw/i386/topology.h |   40 ++++++++++++++++++++++++++--------------
>  2 files changed, 53 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ada445f8f3..95aab8e5e7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -930,11 +930,15 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
>  {
>      MachineState *ms = MACHINE(pcms);
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +    X86CPUTopoInfo topo_info;
>      uint32_t correct_id;
>      static bool warned;
>  
> -    correct_id = x86_apicid_from_cpu_idx(pcms->smp_dies, ms->smp.cores,
> -                                         ms->smp.threads, cpu_index);
> +    topo_info.nr_dies = pcms->smp_dies;
> +    topo_info.nr_cores = ms->smp.cores;
> +    topo_info.nr_threads = ms->smp.threads;
> +
> +    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);

If you are using the struct in function calls, please make sure
all fields are filled correctly, so we won't introduce bugs
accidentally if we start using the new fields inside the topology
functions.

Alternatively, you can leave the struct without the numa_nodes
and nr_sockets fields by now (because they are unused), and add
the fields in another patch.

Except for this, the patch looks good.  However, I don't
understand yet the use case for the `numa_nodes` field yet.  I
will probably comment on the `numa_nodes` field once I see the
patches that use the new field.

-- 
Eduardo

