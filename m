Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EABC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 06:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C92C20866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 06:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C92C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbg3A-0005wm-Ig
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 02:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58006)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hbfzV-0004LT-3H
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hbfzP-0004qF-Qr
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:47:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hbfzI-0004jw-51; Fri, 14 Jun 2019 02:47:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B0BF0882F2;
 Fri, 14 Jun 2019 06:46:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43B7E5DD7A;
 Fri, 14 Jun 2019 06:46:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF3EE11386A6; Fri, 14 Jun 2019 08:46:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
 <20190613153405.24769-11-kwolf@redhat.com>
Date: Fri, 14 Jun 2019 08:46:56 +0200
In-Reply-To: <20190613153405.24769-11-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 13 Jun 2019 17:34:00 +0200")
Message-ID: <87d0jghden.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 14 Jun 2019 06:46:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 10/15] monitor: Split out monitor/qmp.c
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Move QMP infrastructure from monitor/misc.c to monitor/qmp.c. This is
> code that can be shared for all targets, so compile it only once.
>
> The amount of function and particularly extern variables in
> monitor_int.h is probably a bit larger than it needs to be, but this way
> no non-trivial code modifications are needed. The interfaces between QMP
> and the monitor core can be cleaned up later.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  monitor/monitor-internal.h |  29 +++
>  monitor/misc.c             | 397 +-----------------------------------
>  monitor/qmp.c              | 405 +++++++++++++++++++++++++++++++++++++
>  Makefile.objs              |   1 +
>  monitor/Makefile.objs      |   1 +
>  monitor/trace-events       |   4 +-
>  6 files changed, 448 insertions(+), 389 deletions(-)
>  create mode 100644 monitor/qmp.c
>
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 17a632b0ad..0a26f702dd 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -145,4 +145,33 @@ typedef struct {
>      GQueue *qmp_requests;
>  } MonitorQMP;
>  
> +/**
> + * Is @mon a QMP monitor?
> + */
> +static inline bool monitor_is_qmp(const Monitor *mon)
> +{
> +    return (mon->flags & MONITOR_USE_CONTROL);

checkpatch.pl complains:

    ERROR: return is not a function, parentheses are not required

Can touch up in my tree.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Two reminders for myself below.

[...]
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> new file mode 100644
> index 0000000000..31fbcd59f7
> --- /dev/null
> +++ b/monitor/qmp.c
> @@ -0,0 +1,405 @@
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
> +#include "qemu/osdep.h"
> +
> +#include "chardev/char-io.h"
> +#include "monitor-internal.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-commands-misc.h"
> +#include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qstring.h"
> +#include "qapi/qmp/qlist.h"
> +#include "trace.h"
> +
> +struct QMPRequest {
> +    /* Owner of the request */
> +    MonitorQMP *mon;
> +    /*
> +     * Request object to be handled or Error to be reported
> +     * (exactly one of them is non-null)
> +     */
> +    QObject *req;
> +    Error *err;
> +};
> +typedef struct QMPRequest QMPRequest;

Note to self: consider fusing these two in a follow-up patch.

> +
> +QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
> +
> +static bool qmp_oob_enabled(MonitorQMP *mon)
> +{
> +    return mon->capab[QMP_CAPABILITY_OOB];
> +}
> +
> +static void monitor_qmp_caps_reset(MonitorQMP *mon)
> +{
> +    memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
> +    memset(mon->capab, 0, sizeof(mon->capab));
> +    mon->capab_offered[QMP_CAPABILITY_OOB] = mon->common.use_io_thread;
> +}
> +
> +static void qmp_request_free(QMPRequest *req)
> +{
> +    qobject_unref(req->req);
> +    error_free(req->err);
> +    g_free(req);
> +}
> +
> +/* Caller must hold mon->qmp.qmp_queue_lock */
> +static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
> +{
> +    while (!g_queue_is_empty(mon->qmp_requests)) {
> +        qmp_request_free(g_queue_pop_head(mon->qmp_requests));
> +    }
> +}
> +
> +static void monitor_qmp_cleanup_queues(MonitorQMP *mon)
> +{
> +    qemu_mutex_lock(&mon->qmp_queue_lock);
> +    monitor_qmp_cleanup_req_queue_locked(mon);
> +    qemu_mutex_unlock(&mon->qmp_queue_lock);
> +}
> +
> +void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
> +{
> +    const QObject *data = QOBJECT(rsp);
> +    QString *json;
> +
> +    json = mon->common.flags & MONITOR_USE_PRETTY ?
> +           qobject_to_json_pretty(data) : qobject_to_json(data);
> +    assert(json != NULL);
> +
> +    qstring_append_chr(json, '\n');
> +    monitor_puts(&mon->common, qstring_get_str(json));
> +
> +    qobject_unref(json);
> +}
> +
> +/*
> + * Emit QMP response @rsp with ID @id to @mon.
> + * Null @rsp can only happen for commands with QCO_NO_SUCCESS_RESP.
> + * Nothing is emitted then.
> + */
> +static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
> +{
> +    if (rsp) {
> +        qmp_send_response(mon, rsp);
> +    }
> +}

Note to self: of the two callers, only one can pass null @rsp.
Eliminate this function.

[...]

