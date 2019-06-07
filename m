Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB08C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C58208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 18:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C58208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJir-0008AQ-0w
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 14:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49804)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hZI6F-0007SR-Nk
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hZI6D-0007t1-PI
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 12:52:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hZI68-0007g4-Ee; Fri, 07 Jun 2019 12:52:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA756308FF32;
 Fri,  7 Jun 2019 16:52:05 +0000 (UTC)
Received: from work-vm (ovpn-116-24.ams2.redhat.com [10.36.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 765375C730;
 Fri,  7 Jun 2019 16:52:02 +0000 (UTC)
Date: Fri, 7 Jun 2019 17:52:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190607165159.GR2631@work-vm>
References: <20190607135430.22149-1-kwolf@redhat.com>
 <20190607135430.22149-8-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607135430.22149-8-kwolf@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 07 Jun 2019 16:52:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 07/10] monitor: Create monitor_int.h
 with common definitions
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Before we can split monitor.c, we need to create a header file that
> contains the common definitions that will be used by multiple source
> files.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor/monitor_int.h | 147 ++++++++++++++++++++++++++++++++++++++++++
>  monitor/misc.c        | 110 +------------------------------
>  2 files changed, 148 insertions(+), 109 deletions(-)
>  create mode 100644 monitor/monitor_int.h
> 
> diff --git a/monitor/monitor_int.h b/monitor/monitor_int.h
> new file mode 100644
> index 0000000000..ab87013b6f
> --- /dev/null
> +++ b/monitor/monitor_int.h
> @@ -0,0 +1,147 @@
> +/*
> + * QEMU monitor
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef MONITOR_INT_H
> +#define MONITOR_INT_H
> +
> +#include "qemu-common.h"
> +#include "monitor/monitor.h"
> +
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/json-parser.h"
> +#include "qapi/qapi-commands.h"
> +
> +#include "qemu/readline.h"
> +#include "chardev/char-fe.h"
> +
> +/*
> + * Supported types:
> + *
> + * 'F'          filename
> + * 'B'          block device name
> + * 's'          string (accept optional quote)
> + * 'S'          it just appends the rest of the string (accept optional quote)
> + * 'O'          option string of the form NAME=VALUE,...
> + *              parsed according to QemuOptsList given by its name
> + *              Example: 'device:O' uses qemu_device_opts.
> + *              Restriction: only lists with empty desc are supported
> + *              TODO lift the restriction
> + * 'i'          32 bit integer
> + * 'l'          target long (32 or 64 bit)
> + * 'M'          Non-negative target long (32 or 64 bit), in user mode the
> + *              value is multiplied by 2^20 (think Mebibyte)
> + * 'o'          octets (aka bytes)
> + *              user mode accepts an optional E, e, P, p, T, t, G, g, M, m,
> + *              K, k suffix, which multiplies the value by 2^60 for suffixes E
> + *              and e, 2^50 for suffixes P and p, 2^40 for suffixes T and t,
> + *              2^30 for suffixes G and g, 2^20 for M and m, 2^10 for K and k
> + * 'T'          double
> + *              user mode accepts an optional ms, us, ns suffix,
> + *              which divides the value by 1e3, 1e6, 1e9, respectively
> + * '/'          optional gdb-like print format (like "/10x")
> + *
> + * '?'          optional type (for all types, except '/')
> + * '.'          other form of optional type (for 'i' and 'l')
> + * 'b'          boolean
> + *              user mode accepts "on" or "off"
> + * '-'          optional parameter (eg. '-f')
> + *
> + */
> +
> +typedef struct mon_cmd_t {
> +    const char *name;
> +    const char *args_type;
> +    const char *params;
> +    const char *help;
> +    const char *flags; /* p=preconfig */
> +    void (*cmd)(Monitor *mon, const QDict *qdict);
> +    /* @sub_table is a list of 2nd level of commands. If it does not exist,
> +     * cmd should be used. If it exists, sub_table[?].cmd should be
> +     * used, and cmd of 1st level plays the role of help function.
> +     */
> +    struct mon_cmd_t *sub_table;
> +    void (*command_completion)(ReadLineState *rs, int nb_args, const char *str);
> +} mon_cmd_t;
> +
> +struct Monitor {
> +    CharBackend chr;
> +    int reset_seen;
> +    int flags;
> +    int suspend_cnt;            /* Needs to be accessed atomically */
> +    bool skip_flush;
> +    bool use_io_thread;
> +
> +    gchar *mon_cpu_path;
> +    QTAILQ_ENTRY(Monitor) entry;
> +
> +    /*
> +     * The per-monitor lock. We can't access guest memory when holding
> +     * the lock.
> +     */
> +    QemuMutex mon_lock;
> +
> +    /*
> +     * Members that are protected by the per-monitor lock
> +     */
> +    QLIST_HEAD(, mon_fd_t) fds;
> +    QString *outbuf;
> +    guint out_watch;
> +    /* Read under either BQL or mon_lock, written with BQL+mon_lock.  */
> +    int mux_out;
> +};
> +
> +struct MonitorHMP {
> +    Monitor common;
> +    /*
> +     * State used only in the thread "owning" the monitor.
> +     * If @use_io_thread, this is @mon_iothread.
> +     * Else, it's the main thread.
> +     * These members can be safely accessed without locks.
> +     */
> +    ReadLineState *rs;
> +    mon_cmd_t *cmd_table;
> +};
> +
> +typedef struct {
> +    Monitor common;
> +    JSONMessageParser parser;
> +    /*
> +     * When a client connects, we're in capabilities negotiation mode.
> +     * @commands is &qmp_cap_negotiation_commands then.  When command
> +     * qmp_capabilities succeeds, we go into command mode, and
> +     * @command becomes &qmp_commands.
> +     */
> +    QmpCommandList *commands;
> +    bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
> +    bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
> +    /*
> +     * Protects qmp request/response queue.
> +     * Take monitor_lock first when you need both.
> +     */
> +    QemuMutex qmp_queue_lock;
> +    /* Input queue that holds all the parsed QMP requests */
> +    GQueue *qmp_requests;
> +} MonitorQMP;
> +
> +#endif
> diff --git a/monitor/misc.c b/monitor/misc.c
> index d964dd1969..6ae7561105 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -23,6 +23,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "monitor_int.h"
>  #include "qemu/units.h"
>  #include <dirent.h>
>  #include "cpu.h"
> @@ -91,55 +92,6 @@
>  #include "hw/s390x/storage-attributes.h"
>  #endif
>  
> -/*
> - * Supported types:
> - *
> - * 'F'          filename
> - * 'B'          block device name
> - * 's'          string (accept optional quote)
> - * 'S'          it just appends the rest of the string (accept optional quote)
> - * 'O'          option string of the form NAME=VALUE,...
> - *              parsed according to QemuOptsList given by its name
> - *              Example: 'device:O' uses qemu_device_opts.
> - *              Restriction: only lists with empty desc are supported
> - *              TODO lift the restriction
> - * 'i'          32 bit integer
> - * 'l'          target long (32 or 64 bit)
> - * 'M'          Non-negative target long (32 or 64 bit), in user mode the
> - *              value is multiplied by 2^20 (think Mebibyte)
> - * 'o'          octets (aka bytes)
> - *              user mode accepts an optional E, e, P, p, T, t, G, g, M, m,
> - *              K, k suffix, which multiplies the value by 2^60 for suffixes E
> - *              and e, 2^50 for suffixes P and p, 2^40 for suffixes T and t,
> - *              2^30 for suffixes G and g, 2^20 for M and m, 2^10 for K and k
> - * 'T'          double
> - *              user mode accepts an optional ms, us, ns suffix,
> - *              which divides the value by 1e3, 1e6, 1e9, respectively
> - * '/'          optional gdb-like print format (like "/10x")
> - *
> - * '?'          optional type (for all types, except '/')
> - * '.'          other form of optional type (for 'i' and 'l')
> - * 'b'          boolean
> - *              user mode accepts "on" or "off"
> - * '-'          optional parameter (eg. '-f')
> - *
> - */
> -
> -typedef struct mon_cmd_t {
> -    const char *name;
> -    const char *args_type;
> -    const char *params;
> -    const char *help;
> -    const char *flags; /* p=preconfig */
> -    void (*cmd)(Monitor *mon, const QDict *qdict);
> -    /* @sub_table is a list of 2nd level of commands. If it does not exist,
> -     * cmd should be used. If it exists, sub_table[?].cmd should be
> -     * used, and cmd of 1st level plays the role of help function.
> -     */
> -    struct mon_cmd_t *sub_table;
> -    void (*command_completion)(ReadLineState *rs, int nb_args, const char *str);
> -} mon_cmd_t;
> -
>  /* file descriptors passed via SCM_RIGHTS */
>  typedef struct mon_fd_t mon_fd_t;
>  struct mon_fd_t {
> @@ -182,66 +134,6 @@ typedef struct {
>      int64_t rate;       /* Minimum time (in ns) between two events */
>  } MonitorQAPIEventConf;
>  
> -struct Monitor {
> -    CharBackend chr;
> -    int reset_seen;
> -    int flags;
> -    int suspend_cnt;            /* Needs to be accessed atomically */
> -    bool skip_flush;
> -    bool use_io_thread;
> -
> -    gchar *mon_cpu_path;
> -    QTAILQ_ENTRY(Monitor) entry;
> -
> -    /*
> -     * The per-monitor lock. We can't access guest memory when holding
> -     * the lock.
> -     */
> -    QemuMutex mon_lock;
> -
> -    /*
> -     * Members that are protected by the per-monitor lock
> -     */
> -    QLIST_HEAD(, mon_fd_t) fds;
> -    QString *outbuf;
> -    guint out_watch;
> -    /* Read under either BQL or mon_lock, written with BQL+mon_lock.  */
> -    int mux_out;
> -};
> -
> -struct MonitorHMP {
> -    Monitor common;
> -    /*
> -     * State used only in the thread "owning" the monitor.
> -     * If @use_io_thread, this is @mon_iothread.
> -     * Else, it's the main thread.
> -     * These members can be safely accessed without locks.
> -     */
> -    ReadLineState *rs;
> -    mon_cmd_t *cmd_table;
> -};
> -
> -typedef struct {
> -    Monitor common;
> -    JSONMessageParser parser;
> -    /*
> -     * When a client connects, we're in capabilities negotiation mode.
> -     * @commands is &qmp_cap_negotiation_commands then.  When command
> -     * qmp_capabilities succeeds, we go into command mode, and
> -     * @command becomes &qmp_commands.
> -     */
> -    QmpCommandList *commands;
> -    bool capab_offered[QMP_CAPABILITY__MAX]; /* capabilities offered */
> -    bool capab[QMP_CAPABILITY__MAX];         /* offered and accepted */
> -    /*
> -     * Protects qmp request/response queue.
> -     * Take monitor_lock first when you need both.
> -     */
> -    QemuMutex qmp_queue_lock;
> -    /* Input queue that holds all the parsed QMP requests */
> -    GQueue *qmp_requests;
> -} MonitorQMP;
> -
>  /* Shared monitor I/O thread */
>  IOThread *mon_iothread;
>  
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

