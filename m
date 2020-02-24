Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457C4C35679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1311620661
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6p1YKVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1311620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j69GB-0002dd-7I
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 03:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j69FS-000291-FN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j69FR-0000qq-CT
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:37:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56424
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j69FR-0000qe-8S
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582533472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ximqjl6wzE6VBJRq59S74GmVSJzTYGk2aEABnEsZlWQ=;
 b=Q6p1YKVPgZdGTpLZQ4jawE+g8of4MTcU+6Dpte59cSY0r0+jp8VNnr9N9gDCuyE7lfB+JF
 WDkj0qSEcAykSCUNFzExgcpHJniUQG/o9nDscMpC0kZDey2pam+JBSGFCYLzcZ7YVs7Nms
 w4RQEWLIMAA/iSMOuiGFLKXvkugrlUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-yNjDLBTUNKSGqjrxqByTKA-1; Mon, 24 Feb 2020 03:37:49 -0500
X-MC-Unique: yNjDLBTUNKSGqjrxqByTKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2198B13E2;
 Mon, 24 Feb 2020 08:37:48 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19D201001902;
 Mon, 24 Feb 2020 08:37:43 +0000 (UTC)
Date: Mon, 24 Feb 2020 09:37:42 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 05/16] machine: Add SMP Sockets in CpuTopology
Message-ID: <20200224093742.1749ad0b@redhat.com>
In-Reply-To: <158161781807.48948.6804322747644119810.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161781807.48948.6804322747644119810.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On Thu, 13 Feb 2020 12:16:58 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Store the  smp sockets in CpuTopology. The socket information required to
> build the apic id in EPYC mode. Right now socket information is not passed
> to down when decoding the apic id. Add the socket information here.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/core/machine.c   |    1 +
>  hw/i386/pc.c        |    1 +
>  include/hw/boards.h |    2 ++
>  vl.c                |    1 +
>  4 files changed, 5 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 023548b4f3..ea03c25565 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -789,6 +789,7 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
>          ms->smp.cpus = cpus;
>          ms->smp.cores = cores;
>          ms->smp.threads = threads;
> +        ms->smp.sockets = sockets;
>      }
>  
>      if (ms->smp.cpus > 1) {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 9803413dd9..f13721ac43 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -978,6 +978,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
>          ms->smp.cpus = cpus;
>          ms->smp.cores = cores;
>          ms->smp.threads = threads;
> +        ms->smp.sockets = sockets;
>          x86ms->smp_dies = dies;
>      }
>  
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 24cbeecbae..a50a2d779e 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -256,12 +256,14 @@ typedef struct DeviceMemoryState {
>   * @cpus: the number of present logical processors on the machine
>   * @cores: the number of cores in one package
>   * @threads: the number of threads in one core
> + * @sockets: the number of sockets on the machine
>   * @max_cpus: the maximum number of logical processors on the machine
>   */
>  typedef struct CpuTopology {
>      unsigned int cpus;
>      unsigned int cores;
>      unsigned int threads;
> +    unsigned int sockets;
>      unsigned int max_cpus;
>  } CpuTopology;
>  
> diff --git a/vl.c b/vl.c
> index 94508300c3..3f6d396a95 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3819,6 +3819,7 @@ int main(int argc, char **argv, char **envp)
>      current_machine->smp.max_cpus = machine_class->default_cpus;
>      current_machine->smp.cores = 1;
>      current_machine->smp.threads = 1;
> +    current_machine->smp.sockets = 1;
>  
>      machine_class->smp_parse(current_machine,
>          qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
> 
> 


