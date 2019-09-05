Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8A3C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 20:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0F320692
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 20:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0F320692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5xzP-0004dN-Ct
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 16:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1i5xyc-0004BC-V3
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 16:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1i5xyb-0002M5-75
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 16:03:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1i5xya-0002LR-VZ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 16:03:29 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 537168535C
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 20:03:27 +0000 (UTC)
Received: by mail-oi1-f200.google.com with SMTP id g204so1648826oif.14
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 13:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3cktYCYISHOCqTUPXgN85eKDe/k6NvMksb0O90iekwQ=;
 b=s9zGTAqQYhTjs/rGyeXRn/s374wWnWqgxMKOwOflZRv5Vn3hc9CIOm5MFZdzXYpneC
 VjnXrfR+OvQCK6zYPlsC+ccVAtotyy7uIUnwu0wL9DnyZ3VLlYh4FMJykL6XwgJyHhEG
 Xq6jrT4C4uUYnGeDsj9Y/TmFSU0j8mXSZxSOH9Eg54CrCGHNEOjH0K/Zm9SPZ3+OHuu0
 0Bfzj0dYIHD8KwpyZheXapD5Ie0vHGxJvSu+sbY8xXMyhjOWQH7WKoAfntSHB0sJmWx/
 BX1C5T0+pRRuU6e8mS7Tqs6lFnHNls02akOI5PRyO8imJeiNpGfBwVDysXXxkyUBuLUl
 2usA==
X-Gm-Message-State: APjAAAWdHlmevu7AisGlZEBnZfsM8lv6V3PDCvgSHbI7VpGI6yohEDdp
 01k27x9g712hs2v6D02PZm//cQz0GyfyfOOy/mFtk8TCOev6oFnKn+PvLCQbOPCd+guNYPEV20F
 fVuDcAdGMdD8+LRlESGi1aZ1lWoxbeiw=
X-Received: by 2002:a9d:1cf:: with SMTP id e73mr4090912ote.38.1567713806565;
 Thu, 05 Sep 2019 13:03:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxRlGnuSBW83wZO0B2djsQaRAnO3imspeV/25EcFlEqUmfx0wTEWjB9GSv2sypayDhgvKXqRrsS+yJn409tWJs=
X-Received: by 2002:a9d:1cf:: with SMTP id e73mr4090895ote.38.1567713806334;
 Thu, 05 Sep 2019 13:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190905152136.30637-1-stefanha@redhat.com>
 <20190905152136.30637-4-stefanha@redhat.com>
 <20190905171248.GP2700@work-vm>
In-Reply-To: <20190905171248.GP2700@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 6 Sep 2019 00:03:15 +0400
Message-ID: <CAMxuvaw_Vyy8Xya9dCP_K9acqZmmUCK7-=GcJJJ_mv7CZiM3wQ@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: virtio-fs@redhat.com, Eryu Guan <eguan@linux.alibaba.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Sep 5, 2019 at 9:13 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > virtiofsctl can control a running virtiofsd process:
> >
> >   usage: ./virtiofsctl COMMAND [args...]
> >
> >   Commands:
> >     get-log-level       - show current log level
> >     set-log-level LEVEL - set current log level to one of
> >                           "err", "warning", "info", "debug"
> >
> > Make sure it is running in the same DBus session as virtiofsd.  This may
> > require setting the DBUS_SESSION_BUS_ADDRESS environment variable to the
> > same value as used by virtiofsd.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  Makefile                        |  3 ++
> >  Makefile.objs                   |  1 +
> >  contrib/virtiofsd/Makefile.objs |  3 ++
> >  contrib/virtiofsd/virtiofsctl.c | 55 +++++++++++++++++++++++++++++++++
> >  4 files changed, 62 insertions(+)
> >  create mode 100644 contrib/virtiofsd/virtiofsctl.c
> >
> > diff --git a/Makefile b/Makefile
> > index 6b1af33348..d7ed9e7669 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -419,6 +419,7 @@ dummy := $(call unnest-vars,, \
> >                  ivshmem-client-obj-y \
> >                  ivshmem-server-obj-y \
> >                  virtiofsd-obj-y \
> > +                virtiofsctl-obj-y \
> >                  rdmacm-mux-obj-y \
> >                  libvhost-user-obj-y \
> >                  vhost-user-scsi-obj-y \
> > @@ -661,6 +662,8 @@ contrib/virtiofsd/gdbus_generated.c-timestamp: $(SRC_PATH)/contrib/virtiofsd/org
> >
> >  virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
> >       $(call LINK, $^)
> > +virtiofsctl$(EXESUF): $(virtiofsctl-obj-y)
> > +     $(call LINK, $^)
> >  endif
> >
> >  vhost-user-gpu$(EXESUF): $(vhost-user-gpu-obj-y) $(libvhost-user-obj-y) libqemuutil.a libqemustub.a
> > diff --git a/Makefile.objs b/Makefile.objs
> > index dfdd7d56ea..326a8abb8e 100644
> > --- a/Makefile.objs
> > +++ b/Makefile.objs
> > @@ -126,6 +126,7 @@ rdmacm-mux-obj-y = contrib/rdmacm-mux/
> >  vhost-user-input-obj-y = contrib/vhost-user-input/
> >  vhost-user-gpu-obj-y = contrib/vhost-user-gpu/
> >  virtiofsd-obj-y = contrib/virtiofsd/
> > +virtiofsctl-obj-y = contrib/virtiofsd/
> >
> >  ######################################################################
> >  trace-events-subdirs =
> > diff --git a/contrib/virtiofsd/Makefile.objs b/contrib/virtiofsd/Makefile.objs
> > index d59ab60f3d..3f944d493e 100644
> > --- a/contrib/virtiofsd/Makefile.objs
> > +++ b/contrib/virtiofsd/Makefile.objs
> > @@ -11,6 +11,9 @@ virtiofsd-obj-y = buffer.o \
> >                    gdbus_generated.o \
> >                    dbus.o
> >
> > +virtiofsctl-obj-y = virtiofsctl.o \
> > +                    gdbus_generated.o
> > +
> >  seccomp.o-cflags := $(SECCOMP_CFLAGS)
> >  seccomp.o-libs := $(SECCOMP_LIBS)
> >
> > diff --git a/contrib/virtiofsd/virtiofsctl.c b/contrib/virtiofsd/virtiofsctl.c
> > new file mode 100644
> > index 0000000000..39bee2b881
> > --- /dev/null
> > +++ b/contrib/virtiofsd/virtiofsctl.c
> > @@ -0,0 +1,55 @@
> > +#include <stdio.h>
> > +#include "gdbus_generated.h"
> > +
> > +static void get_log_level(Virtiofsd *virtiofsd)
> > +{
> > +    const char *value = virtiofsd_get_log_level(virtiofsd);
> > +
> > +    printf("%s\n", value ? value : "(null)");
> > +}
> > +
> > +static void set_log_level(Virtiofsd *virtiofsd, const char *value)
> > +{
> > +    virtiofsd_set_log_level(virtiofsd, value);
> > +}
> > +
> > +static void usage(const char *progname)
> > +{
> > +    printf("usage: %s COMMAND [args...]\n", progname);
> > +    printf("\n");
> > +    printf("Commands:\n");
> > +    printf("  get-log-level       - show current log level\n");
> > +    printf("  set-log-level LEVEL - set current log level to one of\n");
> > +    printf("                        \"err\", \"warning\", \"info\", \"debug\"\n");
> > +    exit(0);
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    Virtiofsd *virtiofsd;
> > +    GError *error = NULL;
> > +
> > +    if (argc < 2) {
> > +        usage(argv[0]);
> > +    }
> > +
> > +    virtiofsd = virtiofsd_proxy_new_for_bus_sync(G_BUS_TYPE_SESSION,
> > +            G_DBUS_PROXY_FLAGS_NONE, "org.qemu.virtiofsd",
> > +            "/org/qemu/virtiofsd", NULL, &error);
> > +    if (error) {
> > +        fprintf(stderr, "%s\n", error->message);
> > +        g_error_free(error);
> > +        return 1;
> > +    }
> > +
> > +    if (strcmp(argv[0], "get-log-level") == 0) {
>
> This and the one below works a lot better with argv[1] !
>
> (I wonder if a little python script would be better for these type of
> wrappers).

Or just plain gdbus/busctl calls (which already has bash completion
fwiw), and/or eventually a shell script.

>
> Dave
>
> > +        get_log_level(virtiofsd);
> > +    } else if (strcmp(argv[0], "set-log-level") == 0) {
>
> > +        if (argc != 3) {
> > +            usage(argv[0]);
> > +        }
> > +        set_log_level(virtiofsd, argv[2]);
> > +    }
> > +    g_object_unref(virtiofsd);
> > +    return 0;
> > +}
> > --
> > 2.21.0
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

