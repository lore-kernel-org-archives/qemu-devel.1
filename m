Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C0AC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 17:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE4E206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 17:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE4E206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5vaW-0003XQ-V2
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 13:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i5vXt-0001gl-CG
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 13:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i5vXr-0005I2-Tl
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 13:27:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38112)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i5vXr-0005Hq-L2
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 13:27:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B8EE1308302F;
 Thu,  5 Sep 2019 17:27:42 +0000 (UTC)
Received: from work-vm (ovpn-117-197.ams2.redhat.com [10.36.117.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E55F710001B7;
 Thu,  5 Sep 2019 17:27:34 +0000 (UTC)
Date: Thu, 5 Sep 2019 18:27:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190905172732.GQ2700@work-vm>
References: <20190905152136.30637-1-stefanha@redhat.com>
 <20190905152136.30637-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905152136.30637-3-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 05 Sep 2019 17:27:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 2/3] virtiofsd: add DBus server to handle log
 level changes
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
Cc: virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eryu Guan <eguan@linux.alibaba.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> Introduce a DBus server thread that runs alongside the other virtiofsd
> threads.  It processes changes to the /org/qemu/virtiofsd object which
> can be accessed at the org.qemu.virtiofsd location on the bus.
> 
> This code does not use locking because we are the only writer to the
> int current_log_level variable.  More advanced management commands would
> require locking to prevent race conditions with the other threads.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

OK, that is less complex than I'd feared.
I guess there's something probably nice to do with name/integer mapping
for warning levels that we could use from one of the libraries.

Dave

> ---
>  contrib/virtiofsd/Makefile.objs    |   3 +-
>  contrib/virtiofsd/dbus.h           |   9 ++
>  contrib/virtiofsd/dbus.c           | 162 +++++++++++++++++++++++++++++
>  contrib/virtiofsd/passthrough_ll.c |   8 +-
>  4 files changed, 180 insertions(+), 2 deletions(-)
>  create mode 100644 contrib/virtiofsd/dbus.h
>  create mode 100644 contrib/virtiofsd/dbus.c
> 
> diff --git a/contrib/virtiofsd/Makefile.objs b/contrib/virtiofsd/Makefile.objs
> index 9b2af1bc23..d59ab60f3d 100644
> --- a/contrib/virtiofsd/Makefile.objs
> +++ b/contrib/virtiofsd/Makefile.objs
> @@ -8,7 +8,8 @@ virtiofsd-obj-y = buffer.o \
>                    helper.o \
>                    passthrough_ll.o \
>                    seccomp.o \
> -                  gdbus_generated.o
> +                  gdbus_generated.o \
> +                  dbus.o
>  
>  seccomp.o-cflags := $(SECCOMP_CFLAGS)
>  seccomp.o-libs := $(SECCOMP_LIBS)
> diff --git a/contrib/virtiofsd/dbus.h b/contrib/virtiofsd/dbus.h
> new file mode 100644
> index 0000000000..aa18e47408
> --- /dev/null
> +++ b/contrib/virtiofsd/dbus.h
> @@ -0,0 +1,9 @@
> +#ifndef DBUS_H
> +#define DBUS_H
> +
> +#include <stdbool.h>
> +
> +bool setup_dbus(void);
> +void cleanup_dbus(void);
> +
> +#endif /* DBUS_H */
> diff --git a/contrib/virtiofsd/dbus.c b/contrib/virtiofsd/dbus.c
> new file mode 100644
> index 0000000000..bc2308e34b
> --- /dev/null
> +++ b/contrib/virtiofsd/dbus.c
> @@ -0,0 +1,162 @@
> +#include <assert.h>
> +#include <stdio.h>
> +#include <glib.h>
> +#include "fuse_log.h"
> +#include "dbus.h"
> +#include "gdbus_generated.h"
> +
> +static GThread *the_dbus_thread;
> +static GMainContext *the_dbus_context;
> +static GMainLoop *the_dbus_loop;
> +
> +/* Set the string property based on the current log level */
> +static void refresh_log_level(Virtiofsd *virtiofsd)
> +{
> +    switch (current_log_level) {
> +        case LOG_ERR:
> +            virtiofsd_set_log_level(virtiofsd, "err");
> +            break;
> +        case LOG_WARNING:
> +            virtiofsd_set_log_level(virtiofsd, "warning");
> +            break;
> +        case LOG_INFO:
> +            virtiofsd_set_log_level(virtiofsd, "info");
> +            break;
> +        case LOG_DEBUG:
> +            virtiofsd_set_log_level(virtiofsd, "debug");
> +            break;
> +    }
> +}
> +
> +/* Handle changes to Virtiofsd object properties */
> +static void notify(GObject *object, GParamSpec *pspec)
> +{
> +    Virtiofsd *virtiofsd = VIRTIOFSD(object);
> +
> +    fprintf(stderr, "%s %s\n", __func__, pspec->name);
> +
> +    if (strcmp(pspec->name, "log-level") == 0) {
> +        const char *s = virtiofsd_get_log_level(virtiofsd);
> +
> +        if (strcmp(s, "err") == 0) {
> +            current_log_level = LOG_ERR;
> +        } else if (strcmp(s, "warning") == 0) {
> +            current_log_level = LOG_WARNING;
> +        } else if (strcmp(s, "info") == 0) {
> +            current_log_level = LOG_INFO;
> +        } else if (strcmp(s, "debug") == 0) {
> +            current_log_level = LOG_DEBUG;
> +        } else {
> +            /* Invalid, reset the log level property */
> +            refresh_log_level(virtiofsd);
> +        }
> +    }
> +}
> +
> +typedef struct {
> +    Virtiofsd *virtiofsd;
> +    pthread_barrier_t *started;
> +} GBusOwnNameData;
> +
> +static void bus_acquired(GDBusConnection *connection, const gchar *name,
> +        gpointer user_data)
> +{
> +    GBusOwnNameData *data = user_data;
> +    GError *error = NULL;
> +
> +    if (!g_dbus_interface_skeleton_export(
> +                G_DBUS_INTERFACE_SKELETON(data->virtiofsd),
> +                connection, "/org/qemu/virtiofsd", &error)) {
> +        fuse_err("g_dbus_interface_skeleton_export: %s\n", error->message);
> +        g_error_free(error);
> +        exit(EXIT_FAILURE);
> +    }
> +}
> +
> +static void name_acquired(GDBusConnection *connection, const gchar *name,
> +        gpointer user_data)
> +{
> +    GBusOwnNameData *data = user_data;
> +
> +    pthread_barrier_wait(data->started);
> +}
> +
> +static void name_lost(GDBusConnection *connection, const gchar *name,
> +        gpointer user_data)
> +{
> +    if (connection) {
> +        fuse_err("unable to own dbus name\n");
> +    } else {
> +        fuse_err("unable to connect to dbus\n");
> +    }
> +    exit(EXIT_FAILURE);
> +}
> +
> +static gpointer dbus_thread(gpointer opaque)
> +{
> +    GBusOwnNameData data;
> +    Virtiofsd *virtiofsd;
> +    guint owner_id;
> +
> +    g_main_context_push_thread_default(the_dbus_context);
> +
> +    virtiofsd = virtiofsd_skeleton_new();
> +    refresh_log_level(virtiofsd);
> +    g_signal_connect(virtiofsd, "notify", G_CALLBACK(notify), NULL);
> +
> +    data.virtiofsd = virtiofsd;
> +    data.started = opaque;
> +
> +    owner_id = g_bus_own_name(G_BUS_TYPE_SESSION, "org.qemu.virtiofsd",
> +            G_BUS_NAME_OWNER_FLAGS_DO_NOT_QUEUE, bus_acquired, name_acquired,
> +            name_lost, &data, NULL);
> +
> +    g_main_loop_run(the_dbus_loop);
> +    g_bus_unown_name(owner_id);
> +    g_object_unref(virtiofsd);
> +
> +    g_main_context_pop_thread_default(the_dbus_context);
> +    return NULL;
> +}
> +
> +/**
> + * Start DBus server thread.
> + *
> + * Returns: true on success, false on failure
> + */
> +bool setup_dbus(void)
> +{
> +    pthread_barrier_t started;
> +
> +    assert(!the_dbus_thread);
> +
> +    fuse_info("Using dbus address %s\n",
> +              getenv("DBUS_SESSION_BUS_ADDRESS") ?: "(null)");
> +
> +    pthread_barrier_init(&started, NULL, 2);
> +
> +    the_dbus_context = g_main_context_new();
> +    the_dbus_loop = g_main_loop_new(the_dbus_context, FALSE);
> +    the_dbus_thread = g_thread_new("dbus-thread", dbus_thread, &started);
> +
> +    pthread_barrier_wait(&started);
> +    pthread_barrier_destroy(&started);
> +
> +    return true;
> +}
> +
> +/**
> + * Stop DBus server thread.
> + */
> +void cleanup_dbus(void)
> +{
> +    g_main_loop_quit(the_dbus_loop);
> +    g_thread_join(the_dbus_thread);
> +    the_dbus_thread = NULL;
> +
> +    g_main_loop_unref(the_dbus_loop);
> +    the_dbus_loop = NULL;
> +
> +    g_main_context_unref(the_dbus_context);
> +    the_dbus_context = NULL;
> +}
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthrough_ll.c
> index 0ef01b7e3f..0ddd7d280a 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -66,6 +66,7 @@
>  #include <gmodule.h>
>  #include "fuse_log.h"
>  #include "seccomp.h"
> +#include "dbus.h"
>  
>  /* Keep track of inode posix locks for each owner. */
>  struct lo_inode_plock {
> @@ -2989,6 +2990,9 @@ int main(int argc, char *argv[])
>  	if (fuse_session_mount(se) != 0)
>  	    goto err_out3;
>  
> +	if (!setup_dbus())
> +	    goto err_out4;
> +
>  	fuse_daemonize(opts.foreground);
>  
>  	if (lo.ireg_sock != -1) {
> @@ -2998,7 +3002,7 @@ int main(int argc, char *argv[])
>  		if (ret) {
>  			warnx("pthread_create: %s", strerror(ret));
>  			ret = 1;
> -			goto err_out4;
> +			goto err_out5;
>  		}
>  
>  		get_shared(&lo, &lo.root);
> @@ -3014,6 +3018,8 @@ int main(int argc, char *argv[])
>  	/* Block until ctrl+c or fusermount -u */
>          ret = virtio_loop(se);
>  
> +err_out5:
> +	cleanup_dbus();
>  err_out4:
>  	fuse_session_unmount(se);
>  err_out3:
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

