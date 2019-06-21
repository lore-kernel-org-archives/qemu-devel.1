Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC70BC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 00:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C16E2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 00:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCWvDoH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C16E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53702 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he7rK-000496-QZ
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 20:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32870)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sjitindarsingh@gmail.com>) id 1he7mA-0001Fn-0Z
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 20:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sjitindarsingh@gmail.com>) id 1he7m7-0001xp-6k
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 20:51:33 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
 id 1he7m3-0001nv-3F; Thu, 20 Jun 2019 20:51:31 -0400
Received: by mail-pf1-x441.google.com with SMTP id a186so2628599pfa.5;
 Thu, 20 Jun 2019 17:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qbJW3MwJ+ybqPZ79n+26e2vL0JDpJ7h5nwLnxi4cgzg=;
 b=PCWvDoH7A1OYUihcznHiZQyWk4Z7edJUzrTz+vMTPYVYyIHBbEZSnNQFqdJ5qeMvUA
 kccqtNeQ1Kd75jayk29j+X27BickHxkWGYi7fJtyD9Ojh3VpCrpGuC4vrNCKV7c+/pXM
 Af7LK9b9hR5tGXV5e4zEN5BbjqA9nEHWj0qyRQ5OzIGNVnLlpsA0U/PtNQRUrkWc+dZH
 esEX9yveE+Q68RtVadlVh43eV+w5kOSJdoS5ZMC0wgqIIoRnUW2xMey8T3ne01AXbwle
 ildNIrqU3fjNKusGbdaOD5cYeOOXvWv/Q/68oIxGTdKW2bOWmH7d3KeORxPdY7hQ3saB
 BiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qbJW3MwJ+ybqPZ79n+26e2vL0JDpJ7h5nwLnxi4cgzg=;
 b=iAtTcFVv9ilgplk3S/FlJ+7POFnrym1mzEfFJoA9/bLmAIPuq7oLyQtJnua8YXRRDj
 iLtR7TV2Ii2UEXoDOjkUf7XyzLFdgjRR+8+nRukvCPvtWg6S1ABCjcuHXUjV+fGfVHDW
 Iilybaq7nutfAmkRVzylFkZxrnBMw/y9jDGvusyybhkLuTucXWI1qPrcXBfOkF0q2wtS
 bJY3VkSjirC1coejl0fSJYMJdygW3ZoeckMZ/2zuHgzWDXfQKYTlvTwuoP+eRjuwKLrm
 8lRaNKAkFRcwAkYS63etddr5PcpOOh06Xy2IlXOKEFraPIpxQxMba72iX4o2AYkAJfrX
 Cj4w==
X-Gm-Message-State: APjAAAWTh+jXE3XUqqVPkCbfgUefaW9B052FuXyTybjBR37ELPksGPVL
 suowM6/oeJs/UQHeOAlFrgCuILYv
X-Google-Smtp-Source: APXvYqyErdoadSOqoQ0Fqw6SY+cikCev6/kqcYdeqbQ3phjmds3fjyVlyyRur8Htd5fGLXfUWu6CLQ==
X-Received: by 2002:a63:d24f:: with SMTP id t15mr13781727pgi.301.1561078272611; 
 Thu, 20 Jun 2019 17:51:12 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id w1sm888642pjt.30.2019.06.20.17.51.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Jun 2019 17:51:11 -0700 (PDT)
Message-ID: <1561078267.4771.6.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 10:51:07 +1000
In-Reply-To: <20190501053522.10967-1-sjitindarsingh@gmail.com>
References: <20190501053522.10967-1-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 1/2] monitor: Add dump-stack command
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
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, dgilbert@redhat.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-05-01 at 15:35 +1000, Suraj Jitindar Singh wrote:
> Add a monitor command "dump-stack" to be used to dump the stack for
> the
> current cpu.

To summarise the discussion which occured on this patch,

- It looks like it's ok to duplicate this functionality as it provides
an easier method to achieve this in the field and also for development.
- It's ok for this to remain as a separate command and to not place it
as a subcommand under info.

I'll rework based on the comments on 2/2 of the series and resend.

Thanks,
Suraj

> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
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
>  save to disk physical memory dump starting at @var{addr} of size
> @var{size}.
> diff --git a/hmp.h b/hmp.h
> index 43617f2646..e6edf1215c 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -51,6 +51,7 @@ void hmp_announce_self(Monitor *mon, const QDict
> *qdict);
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
> @@ -1299,6 +1299,18 @@ static void hmp_info_registers(Monitor *mon,
> const QDict *qdict)
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
> @@ -230,6 +230,16 @@ void cpu_dump_state(CPUState *cpu, FILE *f, int
> flags)
>      }
>  }
>  
> +void cpu_dump_stack(CPUState *cpu, FILE *f)
> +{
> +    CPUClass *cc = CPU_GET_CLASS(cpu);
> +
> +    if (cc->dump_stack) {
> +        cpu_synchronize_state(cpu);
> +        cc->dump_stack(cpu, f);
> +    }
> +}
> +
>  void cpu_dump_statistics(CPUState *cpu, int flags)
>  {
>      CPUClass *cc = CPU_GET_CLASS(cpu);

