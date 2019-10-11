Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24EBC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 02:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727AC20B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 02:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727AC20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIkj2-0003mi-Ip
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 22:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iIki9-0003Eb-3Z
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 22:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iIki7-0006WR-LS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 22:31:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iIki7-0006Uq-Cg
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 22:31:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 783713090FDF;
 Fri, 11 Oct 2019 02:31:18 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9115C1001B2C;
 Fri, 11 Oct 2019 02:31:13 +0000 (UTC)
Date: Thu, 10 Oct 2019 23:31:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [Qemu-devel] [RFC 2 PATCH 04/16] machine: Add SMP Sockets in
 CpuTopology
Message-ID: <20191011023112.GB29387@habkost.net>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779712350.21957.6312199085335942636.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156779712350.21957.6312199085335942636.stgit@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 11 Oct 2019 02:31:18 +0000 (UTC)
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

On Fri, Sep 06, 2019 at 07:12:04PM +0000, Moger, Babu wrote:
> Store the  smp Sockets in CpuTopology. Socket information
> is required to build the cpu topology in new epyc mode.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  hw/core/machine.c   |    1 +
>  hw/i386/pc.c        |    1 +
>  include/hw/boards.h |    2 ++
>  vl.c                |    1 +
>  4 files changed, 5 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c58a8e594e..4034b7e903 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -795,6 +795,7 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
>          ms->smp.cpus = cpus;
>          ms->smp.cores = cores;
>          ms->smp.threads = threads;
> +        ms->smp.sockets = sockets;
>      }
>  
>      if (ms->smp.cpus > 1) {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 95aab8e5e7..9e1c3f9f57 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1609,6 +1609,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
>          ms->smp.cpus = cpus;
>          ms->smp.cores = cores;
>          ms->smp.threads = threads;
> +        ms->smp.sockets = sockets;
>          pcms->smp_dies = dies;
>      }
>  
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a71d1a53a5..12eb5032a5 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -245,12 +245,14 @@ typedef struct DeviceMemoryState {
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
> index 711d2ae5da..473a688779 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3981,6 +3981,7 @@ int main(int argc, char **argv, char **envp)
>      current_machine->smp.max_cpus = machine_class->default_cpus;
>      current_machine->smp.cores = 1;
>      current_machine->smp.threads = 1;
> +    current_machine->smp.sockets = 1;
>  
>      machine_class->smp_parse(current_machine,
>          qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
> 

-- 
Eduardo

