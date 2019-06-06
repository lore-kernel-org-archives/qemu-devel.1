Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB308C28CC5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC592070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 03:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC592070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53672 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYisk-0007j9-Tc
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 23:16:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYirw-0007OC-41
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hYiru-0007mc-GW
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:15:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hYiru-0007iY-89
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 23:15:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CEA8308A968;
	Thu,  6 Jun 2019 03:15:09 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0D2F1104B511;
	Thu,  6 Jun 2019 03:15:07 +0000 (UTC)
Date: Thu, 6 Jun 2019 00:15:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190606031506.GU22416@habkost.net>
References: <20190520165056.175475-1-like.xu@linux.intel.com>
	<20190520165056.175475-4-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520165056.175475-4-like.xu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 06 Jun 2019 03:15:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/5] vl.c: Add -smp,
 dies=* command line support and update -smp doc
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
Cc: Andrew Jones <drjones@redhat.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Peter Crosthwaite <crosthwaite.peter@gmail.com>,
	Markus Armbruster <armbru@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Brice Goglin <Brice.Goglin@inria.fr>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 12:50:54AM +0800, Like Xu wrote:
> For PC target, users could configure the number of dies per one package
> via command line with this patch, such as "-smp dies=2,cores=4".
> 
> A new pc-specified pc_smp_parse() is introduced and to keep the interface
> consistent, refactoring legacy smp_parse() to __smp_parse() is necessary.
> 
> The parsing rules of new cpu-topology model obey the same restrictions/logic
> as the legacy socket/core/thread model especially on missing values computing.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  qemu-options.hx | 17 +++++-----
>  vl.c            | 89 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 97 insertions(+), 9 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5daa5a8fb0..7fad5b50ff 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -138,25 +138,26 @@ no incompatible TCG features have been enabled (e.g. icount/replay).
>  ETEXI
>  
>  DEF("smp", HAS_ARG, QEMU_OPTION_smp,
> -    "-smp [cpus=]n[,maxcpus=cpus][,cores=cores][,threads=threads][,sockets=sockets]\n"
> +    "-smp [cpus=]n[,maxcpus=cpus][,cores=cores][,threads=threads][,dies=dies][,sockets=sockets]\n"
>      "                set the number of CPUs to 'n' [default=1]\n"
>      "                maxcpus= maximum number of total cpus, including\n"
>      "                offline CPUs for hotplug, etc\n"
> -    "                cores= number of CPU cores on one socket\n"
> +    "                cores= number of CPU cores on one socket (for PC, it's on one die)\n"
>      "                threads= number of threads on one CPU core\n"
> +    "                dies= number of CPU dies on one socket (for PC only)\n"
>      "                sockets= number of discrete sockets in the system\n",
>          QEMU_ARCH_ALL)
>  STEXI
> -@item -smp [cpus=]@var{n}[,cores=@var{cores}][,threads=@var{threads}][,sockets=@var{sockets}][,maxcpus=@var{maxcpus}]
> +@item -smp [cpus=]@var{n}[,cores=@var{cores}][,threads=@var{threads}][,dies=dies][,sockets=@var{sockets}][,maxcpus=@var{maxcpus}]
>  @findex -smp
>  Simulate an SMP system with @var{n} CPUs. On the PC target, up to 255
>  CPUs are supported. On Sparc32 target, Linux limits the number of usable CPUs
>  to 4.
> -For the PC target, the number of @var{cores} per socket, the number
> -of @var{threads} per cores and the total number of @var{sockets} can be
> -specified. Missing values will be computed. If any on the three values is
> -given, the total number of CPUs @var{n} can be omitted. @var{maxcpus}
> -specifies the maximum number of hotpluggable CPUs.
> +For the PC target, the number of @var{cores} per die, the number of @var{threads}
> +per cores, the number of @var{dies} per packages and the total number of
> +@var{sockets} can be specified. Missing values will be computed.
> +If any on the three values is given, the total number of CPUs @var{n} can be omitted.
> +@var{maxcpus} specifies the maximum number of hotpluggable CPUs.
>  ETEXI
>  
>  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> diff --git a/vl.c b/vl.c
> index 8d92e2d209..66b577f447 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -63,6 +63,7 @@ int main(int argc, char **argv)
>  #include "sysemu/watchdog.h"
>  #include "hw/firmware/smbios.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/i386/pc.h"
>  #include "hw/xen/xen.h"
>  #include "hw/qdev.h"
>  #include "hw/loader.h"
> @@ -1248,6 +1249,9 @@ static QemuOptsList qemu_smp_opts = {
>          }, {
>              .name = "sockets",
>              .type = QEMU_OPT_NUMBER,
> +        }, {
> +            .name = "dies",
> +            .type = QEMU_OPT_NUMBER,
>          }, {
>              .name = "cores",
>              .type = QEMU_OPT_NUMBER,
> @@ -1262,7 +1266,7 @@ static QemuOptsList qemu_smp_opts = {
>      },
>  };
>  
> -static void smp_parse(QemuOpts *opts)
> +static void __smp_parse(QemuOpts *opts)
>  {
>      if (opts) {
>          unsigned cpus    = qemu_opt_get_number(opts, "cpus", 0);
> @@ -1334,6 +1338,89 @@ static void smp_parse(QemuOpts *opts)
>      }
>  }
>  
> +static void pc_smp_parse(QemuOpts *opts)
> +{
> +    PCMachineState *pcms = (PCMachineState *)
> +        object_dynamic_cast(OBJECT(current_machine), TYPE_PC_MACHINE);
> +
> +    unsigned cpus    = qemu_opt_get_number(opts, "cpus", 0);
> +    unsigned sockets = qemu_opt_get_number(opts, "sockets", 0);
> +    unsigned dies = qemu_opt_get_number(opts, "dies", 1);
> +    unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
> +    unsigned threads = qemu_opt_get_number(opts, "threads", 0);
> +
> +    /* compute missing values, prefer sockets over cores over threads */
> +    if (cpus == 0 || sockets == 0) {
> +        cores = cores > 0 ? cores : 1;
> +        threads = threads > 0 ? threads : 1;
> +        if (cpus == 0) {
> +            sockets = sockets > 0 ? sockets : 1;
> +            cpus = cores * threads * dies * sockets;
> +        } else {
> +            current_machine->smp.max_cpus =
> +                    qemu_opt_get_number(opts, "maxcpus", cpus);
> +            sockets = current_machine->smp.max_cpus / (cores * threads * dies);
> +        }
> +    } else if (cores == 0) {
> +        threads = threads > 0 ? threads : 1;
> +        cores = cpus / (sockets * dies * threads);
> +        cores = cores > 0 ? cores : 1;
> +    } else if (threads == 0) {
> +        threads = cpus / (cores * dies * sockets);
> +        threads = threads > 0 ? threads : 1;
> +    } else if (sockets * dies * cores * threads < cpus) {
> +        error_report("cpu topology: "
> +                        "sockets (%u) * dies (%u) * cores (%u) * threads (%u) < "
> +                        "smp_cpus (%u)",
> +                        sockets, dies, cores, threads, cpus);
> +        exit(1);
> +    }
> +
> +    current_machine->smp.max_cpus =
> +            qemu_opt_get_number(opts, "maxcpus", cpus);
> +
> +    if (current_machine->smp.max_cpus < cpus) {
> +        error_report("maxcpus must be equal to or greater than smp");
> +        exit(1);
> +    }
> +
> +    if (sockets * dies * cores * threads > current_machine->smp.max_cpus) {
> +        error_report("cpu topology: "
> +                        "sockets (%u) * dies (%u) * cores (%u) * threads (%u) > "
> +                        "maxcpus (%u)",
> +                        sockets, dies, cores, threads,
> +                        current_machine->smp.max_cpus);
> +        exit(1);
> +    }
> +
> +    if (sockets * dies * cores * threads != current_machine->smp.max_cpus) {
> +        warn_report("Invalid CPU topology deprecated: "
> +                    "sockets (%u) * dies (%u) * cores (%u) * threads (%u) "
> +                    "!= maxcpus (%u)",
> +                    sockets, dies, cores, threads,
> +                    current_machine->smp.max_cpus);
> +    }
> +
> +    current_machine->smp.cpus = cpus;
> +    current_machine->smp.cores = cores;
> +    current_machine->smp.threads = threads;
> +    pcms->smp_dies = dies;
> +
> +    if (current_machine->smp.cpus > 1) {
> +        Error *blocker = NULL;
> +        error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED, "smp");
> +        replay_add_blocker(blocker);
> +    }
> +}
> +
> +static void smp_parse(QemuOpts *opts)
> +{
> +    if (object_dynamic_cast(OBJECT(current_machine), TYPE_PC_MACHINE))
> +        pc_smp_parse(opts);

This is not exactly what I meant when I suggested creating a
pc_smp_parse() function.

The idea was to place the PC-specific function inside
hw/i386/pc.c, and have a MachineClass::smp_parse function pointer
that machine types could override.

The existing generic smp_parse() code, on the other hand, could
be moved to hw/core/machine.c, and be the default implementation
of MachineClass::smp_parse.

Suggestion: If you first create a copy of smp_parse() in one
patch, and then add CPU die support in another patch, it will be
much easier to review the changes you added to the pc_smp_parse()
code.


> +    else
> +        __smp_parse(opts);
> +}
> +
>  static void realtime_init(void)
>  {
>      if (enable_mlock) {
> -- 
> 2.21.0
> 
> 

-- 
Eduardo

