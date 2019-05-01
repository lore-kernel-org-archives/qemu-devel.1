Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18533C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 10:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE92820835
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 10:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE92820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54203 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLmjw-0004NJ-46
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 06:45:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hLmj6-0003pi-F6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hLmj3-0001X4-4w
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:44:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>)
	id 1hLmiz-0001Mh-BD; Wed, 01 May 2019 06:44:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53DF13082E57;
	Wed,  1 May 2019 10:44:18 +0000 (UTC)
Received: from work-vm (ovpn-116-152.ams2.redhat.com [10.36.116.152])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C18877192A;
	Wed,  1 May 2019 10:44:16 +0000 (UTC)
Date: Wed, 1 May 2019 11:44:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190501104413.GA2873@work-vm>
References: <20190501053522.10967-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190501053522.10967-1-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 01 May 2019 10:44:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] monitor: Add dump-stack command
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
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501104414.FiwkIJ6SXSWr6VvPpD-QHMOB8yXa6lnxXTqFoZYgN4M@z>

* Suraj Jitindar Singh (sjitindarsingh@gmail.com) wrote:
> Add a monitor command "dump-stack" to be used to dump the stack for the
> current cpu.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

OK, and for a debug-only command that's OK for HMP.

> ---
>  hmp-commands.hx   | 13 +++++++++++++
>  hmp.h             |  1 +
>  include/qom/cpu.h | 10 ++++++++++
>  monitor.c         | 12 ++++++++++++
>  qom/cpu.c         | 10 ++++++++++
>  5 files changed, 46 insertions(+)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 9b4035965c..965ccdea28 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -862,6 +862,19 @@ ETEXI
>      },
>  
>  STEXI
> +@item dump-stack
> +@findex dump-stack
> +dump stack of the cpu
> +ETEXI
> +    {
> +        .name           = "dump-stack",
> +        .args_type      = "",
> +        .params         = "",
> +        .help           = "dump stack",
> +        .cmd            = hmp_dumpstack,
> +    },
> +
> +STEXI
>  @item pmemsave @var{addr} @var{size} @var{file}
>  @findex pmemsave
>  save to disk physical memory dump starting at @var{addr} of size @var{size}.
> diff --git a/hmp.h b/hmp.h
> index 43617f2646..e6edf1215c 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -51,6 +51,7 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict);
>  void hmp_cpu(Monitor *mon, const QDict *qdict);
>  void hmp_memsave(Monitor *mon, const QDict *qdict);
>  void hmp_pmemsave(Monitor *mon, const QDict *qdict);
> +void hmp_dumpstack(Monitor *mon, const QDict *qdict);
>  void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
>  void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
>  void hmp_cont(Monitor *mon, const QDict *qdict);
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 08abcbd3fe..f2e83e9918 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -181,6 +181,7 @@ typedef struct CPUClass {
>      int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
>                             uint8_t *buf, int len, bool is_write);
>      void (*dump_state)(CPUState *cpu, FILE *, int flags);
> +    void (*dump_stack)(CPUState *cpu, FILE *f);
>      GuestPanicInformation* (*get_crash_info)(CPUState *cpu);
>      void (*dump_statistics)(CPUState *cpu, int flags);
>      int64_t (*get_arch_id)(CPUState *cpu);
> @@ -568,6 +569,15 @@ enum CPUDumpFlags {
>  void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>  
>  /**
> + * cpu_dump_stack:
> + * @cpu: The CPU whose stack is to be dumped.
> + * @f: If non-null, dump to this stream, else to current print sink.
> + *
> + * Dumps CPU stack.
> + */
> +void cpu_dump_stack(CPUState *cpu, FILE *f);
> +
> +/**
>   * cpu_dump_statistics:
>   * @cpu: The CPU whose state is to be dumped.
>   * @flags: Flags what to dump.
> diff --git a/monitor.c b/monitor.c
> index 9b5f10b475..dbec2e4376 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1299,6 +1299,18 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
>      }
>  }
>  
> +void hmp_dumpstack(Monitor *mon, const QDict *qdict)
> +{
> +    CPUState *cs = mon_get_cpu();
> +
> +    if (!cs) {
> +        monitor_printf(mon, "No CPU available\n");
> +        return;
> +    }
> +
> +    cpu_dump_stack(cs, NULL);
> +}
> +
>  #ifdef CONFIG_TCG
>  static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>  {
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 3c5493c96c..0dc10004f4 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -230,6 +230,16 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
>      }
>  }
>  
> +void cpu_dump_stack(CPUState *cpu, FILE *f)
> +{
> +    CPUClass *cc = CPU_GET_CLASS(cpu);
> +
> +    if (cc->dump_stack) {

Can you make this print a message if there's no implementation for the
current CPU type; since you've just done PPC, everyone else will wonder
why the command doesn't work for them.

> +        cpu_synchronize_state(cpu);
> +        cc->dump_stack(cpu, f);

Are you sure you need this 'f' parameter for the file descriptor?

See Markus's series:
  http://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03271.html
where he removes most places that the FILE* is passed.


Dave

> +    }
> +}
> +
>  void cpu_dump_statistics(CPUState *cpu, int flags)
>  {
>      CPUClass *cc = CPU_GET_CLASS(cpu);
> -- 
> 2.13.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

