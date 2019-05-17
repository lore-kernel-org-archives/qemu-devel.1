Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44510C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FD420833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FD420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44717 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYdf-0007Ik-6J
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:54:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRYVy-0001Ee-Fo
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRYVx-0000eS-HK
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:46:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hRYVx-0000e9-C2
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:46:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67B4D8666E;
	Fri, 17 May 2019 08:46:52 +0000 (UTC)
Received: from Igors-MacBook-Pro (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D3C4E4A8;
	Fri, 17 May 2019 08:46:46 +0000 (UTC)
Date: Fri, 17 May 2019 10:46:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190517104641.37c3e8fa@Igors-MacBook-Pro>
In-Reply-To: <1557131596-25403-2-git-send-email-like.xu@linux.intel.com>
References: <1557131596-25403-1-git-send-email-like.xu@linux.intel.com>
	<1557131596-25403-2-git-send-email-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Fri, 17 May 2019 08:46:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 01/10] hw/boards: add struct CpuTopology
 to MachineState
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	qemu-devel@nongnu.org, Alistair Francis <alistair23@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alex =?UTF-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  6 May 2019 16:33:07 +0800
Like Xu <like.xu@linux.intel.com> wrote:

> To remove usages of global smp variables arch by arch,
> a bisect friendly way is introduced to initialize struct
> CpuTopology with duplicate ones; no semantic changes.

well, commit message doesn't make any sense however many
times I've tried to read it. Pls rephrase.
 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  include/hw/boards.h | 15 +++++++++++++++
>  vl.c                |  5 +++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 6f7916f..dc89c6d 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -231,6 +231,20 @@ typedef struct DeviceMemoryState {
>  } DeviceMemoryState;
>  
>  /**
> + * CpuTopology:
> + * @cpus: the number of logical processors on the machine

s/of/of present/

> + * @cores: the number of cores in one package
> + * @threads: the number of threads in one core
> + * @max_cpus: the maximum number of logical processors on the machine
> + */
> +typedef struct CpuTopology {
> +    unsigned int cpus;
> +    unsigned int cores;
> +    unsigned int threads;
> +    unsigned int max_cpus;
> +} CpuTopology;
> +
> +/**
>   * MachineState:
>   */
>  struct MachineState {
> @@ -272,6 +286,7 @@ struct MachineState {
>      const char *cpu_type;
>      AccelState *accelerator;
>      CPUArchIdList *possible_cpus;
> +    CpuTopology smp;
>      struct NVDIMMState *nvdimms_state;
>  };
>  
> diff --git a/vl.c b/vl.c
> index d9fea0a..43fd247 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4099,6 +4099,11 @@ int main(int argc, char **argv, char **envp)
>  
>      smp_parse(qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
>  
> +    current_machine->smp.cpus = smp_cpus;
> +    current_machine->smp.max_cpus = max_cpus;
> +    current_machine->smp.cores = smp_cores;
> +    current_machine->smp.threads = smp_threads;
> +
>      /* sanity-check smp_cpus and max_cpus against machine_class */
>      if (smp_cpus < machine_class->min_cpus) {
>          error_report("Invalid SMP CPUs %d. The min CPUs "


