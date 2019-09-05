Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C10CC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 17:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F21B20828
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 17:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F21B20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5vKK-0006my-IJ
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 13:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i5vJh-0006LM-Sl
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 13:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i5vJf-0006Yf-DJ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 13:13:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i5vJf-0006Xz-5B
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 13:13:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B86DD745C9;
 Thu,  5 Sep 2019 17:13:01 +0000 (UTC)
Received: from work-vm (ovpn-117-197.ams2.redhat.com [10.36.117.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F382367626;
 Thu,  5 Sep 2019 17:12:51 +0000 (UTC)
Date: Thu, 5 Sep 2019 18:12:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190905171248.GP2700@work-vm>
References: <20190905152136.30637-1-stefanha@redhat.com>
 <20190905152136.30637-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905152136.30637-4-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 05 Sep 2019 17:13:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 3/3] virtiofsd: add virtiofsctl command-line
 management tool
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
> virtiofsctl can control a running virtiofsd process:
> 
>   usage: ./virtiofsctl COMMAND [args...]
> 
>   Commands:
>     get-log-level       - show current log level
>     set-log-level LEVEL - set current log level to one of
>                           "err", "warning", "info", "debug"
> 
> Make sure it is running in the same DBus session as virtiofsd.  This may
> require setting the DBUS_SESSION_BUS_ADDRESS environment variable to the
> same value as used by virtiofsd.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  Makefile                        |  3 ++
>  Makefile.objs                   |  1 +
>  contrib/virtiofsd/Makefile.objs |  3 ++
>  contrib/virtiofsd/virtiofsctl.c | 55 +++++++++++++++++++++++++++++++++
>  4 files changed, 62 insertions(+)
>  create mode 100644 contrib/virtiofsd/virtiofsctl.c
> 
> diff --git a/Makefile b/Makefile
> index 6b1af33348..d7ed9e7669 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -419,6 +419,7 @@ dummy := $(call unnest-vars,, \
>                  ivshmem-client-obj-y \
>                  ivshmem-server-obj-y \
>                  virtiofsd-obj-y \
> +                virtiofsctl-obj-y \
>                  rdmacm-mux-obj-y \
>                  libvhost-user-obj-y \
>                  vhost-user-scsi-obj-y \
> @@ -661,6 +662,8 @@ contrib/virtiofsd/gdbus_generated.c-timestamp: $(SRC_PATH)/contrib/virtiofsd/org
>  
>  virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
>  	$(call LINK, $^)
> +virtiofsctl$(EXESUF): $(virtiofsctl-obj-y)
> +	$(call LINK, $^)
>  endif
>  
>  vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) libqemuutil.a libqemustub.a
> diff --git a/Makefile.objs b/Makefile.objs
> index dfdd7d56ea..326a8abb8e 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -126,6 +126,7 @@ rdmacm-mux-obj-y = contrib/rdmacm-mux/
>  vhost-user-input-obj-y = contrib/vhost-user-input/
>  vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
>  virtiofsd-obj-y = contrib/virtiofsd/
> +virtiofsctl-obj-y = contrib/virtiofsd/
>  
>  ######################################################################
>  trace-events-subdirs =
> diff --git a/contrib/virtiofsd/Makefile.objs b/contrib/virtiofsd/Makefile.objs
> index d59ab60f3d..3f944d493e 100644
> --- a/contrib/virtiofsd/Makefile.objs
> +++ b/contrib/virtiofsd/Makefile.objs
> @@ -11,6 +11,9 @@ virtiofsd-obj-y = buffer.o \
>                    gdbus_generated.o \
>                    dbus.o
>  
> +virtiofsctl-obj-y = virtiofsctl.o \
> +                    gdbus_generated.o
> +
>  seccomp.o-cflags := $(SECCOMP_CFLAGS)
>  seccomp.o-libs := $(SECCOMP_LIBS)
>  
> diff --git a/contrib/virtiofsd/virtiofsctl.c b/contrib/virtiofsd/virtiofsctl.c
> new file mode 100644
> index 0000000000..39bee2b881
> --- /dev/null
> +++ b/contrib/virtiofsd/virtiofsctl.c
> @@ -0,0 +1,55 @@
> +#include <stdio.h>
> +#include "gdbus_generated.h"
> +
> +static void get_log_level(Virtiofsd *virtiofsd)
> +{
> +    const char *value = virtiofsd_get_log_level(virtiofsd);
> +
> +    printf("%s\n", value ? value : "(null)");
> +}
> +
> +static void set_log_level(Virtiofsd *virtiofsd, const char *value)
> +{
> +    virtiofsd_set_log_level(virtiofsd, value);
> +}
> +
> +static void usage(const char *progname)
> +{
> +    printf("usage: %s COMMAND [args...]\n", progname);
> +    printf("\n");
> +    printf("Commands:\n");
> +    printf("  get-log-level       - show current log level\n");
> +    printf("  set-log-level LEVEL - set current log level to one of\n");
> +    printf("                        \"err\", \"warning\", \"info\", \"debug\"\n");
> +    exit(0);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    Virtiofsd *virtiofsd;
> +    GError *error = NULL;
> +
> +    if (argc < 2) {
> +        usage(argv[0]);
> +    }
> +
> +    virtiofsd = virtiofsd_proxy_new_for_bus_sync(G_BUS_TYPE_SESSION,
> +            G_DBUS_PROXY_FLAGS_NONE, "org.qemu.virtiofsd",
> +            "/org/qemu/virtiofsd", NULL, &error);
> +    if (error) {
> +        fprintf(stderr, "%s\n", error->message);
> +        g_error_free(error);
> +        return 1;
> +    }
> +
> +    if (strcmp(argv[0], "get-log-level") == 0) {

This and the one below works a lot better with argv[1] !

(I wonder if a little python script would be better for these type of
wrappers).

Dave

> +        get_log_level(virtiofsd);
> +    } else if (strcmp(argv[0], "set-log-level") == 0) {

> +        if (argc != 3) {
> +            usage(argv[0]);
> +        }
> +        set_log_level(virtiofsd, argv[2]);
> +    }
> +    g_object_unref(virtiofsd);
> +    return 0;
> +}
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

