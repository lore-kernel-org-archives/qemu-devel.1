Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C0DC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DB62082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DB62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEzZo-0008ON-ED
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 13:02:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzSU-0001Zp-Vn
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzST-0008To-VO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:55:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hEzST-0008SE-N9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:55:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA752330255
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:55:20 +0000 (UTC)
Received: from work-vm (unknown [10.36.117.255])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E79155D6A9;
	Fri, 12 Apr 2019 16:55:19 +0000 (UTC)
Date: Fri, 12 Apr 2019 17:55:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190412165516.GH2906@work-vm>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411152520.10061-3-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 12 Apr 2019 16:55:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/17] trace: Simplify how
 st_print_trace_file_status() prints
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412165517.HC1GYKeBkicg0kEWhGOcfF8bQVwkNSrDJqpBlaFN8i0@z>

* Markus Armbruster (armbru@redhat.com) wrote:
> st_print_trace_file_status() takes an fprintf()-like callback and a
> FILE * to pass to it.
> 
> Its only caller hmp_trace_file() passes monitor_fprintf() and the
> current monitor cast to FILE *.  monitor_fprintf() casts it right
> back, and is otherwise identical to monitor_printf().  The
> type-punning is ugly.
> 
> Drop the callback, and call qemu_printf() instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor.c      | 2 +-
>  trace/simple.c | 7 ++++---
>  trace/simple.h | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 10be8bdb86..a3e66b7159 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1056,7 +1056,7 @@ static void hmp_trace_file(Monitor *mon, const QDict *qdict)
>      const char *arg = qdict_get_try_str(qdict, "arg");
>  
>      if (!op) {
> -        st_print_trace_file_status((FILE *)mon, &monitor_fprintf);
> +        st_print_trace_file_status();
>      } else if (!strcmp(op, "on")) {
>          st_set_trace_file_enabled(true);
>      } else if (!strcmp(op, "off")) {
> diff --git a/trace/simple.c b/trace/simple.c
> index ac904eca91..fc7106ec49 100644
> --- a/trace/simple.c
> +++ b/trace/simple.c
> @@ -16,6 +16,7 @@
>  #include "trace/control.h"
>  #include "trace/simple.h"
>  #include "qemu/error-report.h"
> +#include "qemu/qemu-print.h"
>  
>  /** Trace file header event ID, picked to avoid conflict with real event IDs */
>  #define HEADER_EVENT_ID (~(uint64_t)0)
> @@ -363,10 +364,10 @@ void st_set_trace_file(const char *file)
>      st_set_trace_file_enabled(true);
>  }
>  
> -void st_print_trace_file_status(FILE *stream, int (*stream_printf)(FILE *stream, const char *fmt, ...))
> +void st_print_trace_file_status(void)
>  {
> -    stream_printf(stream, "Trace file \"%s\" %s.\n",
> -                  trace_file_name, trace_fp ? "on" : "off");
> +    qemu_printf("Trace file \"%s\" %s.\n",
> +                trace_file_name, trace_fp ? "on" : "off");
>  }
>  
>  void st_flush_trace_buffer(void)
> diff --git a/trace/simple.h b/trace/simple.h
> index 9931808c05..5771a0634f 100644
> --- a/trace/simple.h
> +++ b/trace/simple.h
> @@ -11,7 +11,7 @@
>  #ifndef TRACE_SIMPLE_H
>  #define TRACE_SIMPLE_H
>  
> -void st_print_trace_file_status(FILE *stream, fprintf_function stream_printf);
> +void st_print_trace_file_status(void);
>  void st_set_trace_file_enabled(bool enable);
>  void st_set_trace_file(const char *file);
>  bool st_init(void);
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

