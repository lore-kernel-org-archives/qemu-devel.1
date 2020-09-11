Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627DDC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D8822207
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqNWKWQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D8822207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGoJd-0002ex-S4
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGoHk-0001d1-Jh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:00:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36657
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGoHh-0004gL-G4
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599850832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XSvY/FMC9iPMRNxbOr77WkAMG8qF644PTBES28gnbMI=;
 b=FqNWKWQbZ4gIpyBi1vvGMzYkIgwGcr24jSrQjY9311U57iqz4nWGhc+fywx38NpO++/gmd
 L2wQC9k0NPqo/nkRvJ4hwRS7iSyYd8oVbLPHOfR2G2ip+jrVnJgE6+2NtUHG1JCG2qQk3w
 HVtJSP844dvNWdAdzlHQPaB26EuNBLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-CPJdIYfxM1ae2zXx2ZlB0Q-1; Fri, 11 Sep 2020 15:00:28 -0400
X-MC-Unique: CPJdIYfxM1ae2zXx2ZlB0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E7831084D61;
 Fri, 11 Sep 2020 19:00:27 +0000 (UTC)
Received: from work-vm (ovpn-113-52.ams2.redhat.com [10.36.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 874105D9E8;
 Fri, 11 Sep 2020 19:00:12 +0000 (UTC)
Date: Fri, 11 Sep 2020 20:00:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 17/32] util: env var helpers
Message-ID: <20200911190009.GC3311@work-vm>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-18-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-18-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 09:43:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Steve Sistare (steven.sistare@oracle.com) wrote:
> Add functions for saving fd's and ram extents in the environment via
> setenv, and for reading them back via getenv.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>

This is an awful lot of env stuff - how about dumping
all this stuff into a file and reloading it?

Dave

> ---
>  MAINTAINERS           |   7 +++
>  include/qemu/cutils.h |   1 +
>  include/qemu/env.h    |  31 ++++++++++++
>  util/Makefile.objs    |   2 +-
>  util/env.c            | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 172 insertions(+), 1 deletion(-)
>  create mode 100644 include/qemu/env.h
>  create mode 100644 util/env.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3395abd..8d377a7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3115,3 +3115,10 @@ Performance Tools and Tests
>  M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
>  S: Maintained
>  F: scripts/performance/
> +
> +Environment variable helpers
> +M: Steve Sistare <steven.sistare@oracle.com>
> +M: Mark Kanda <mark.kanda@oracle.com>
> +S: Maintained
> +F: include/qemu/env.h
> +F: util/env.c
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index eb59852..d4c7d70 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -1,6 +1,7 @@
>  #ifndef QEMU_CUTILS_H
>  #define QEMU_CUTILS_H
>  
> +#include "qemu/env.h"
>  /**
>   * pstrcpy:
>   * @buf: buffer to copy string into
> diff --git a/include/qemu/env.h b/include/qemu/env.h
> new file mode 100644
> index 0000000..53cc121
> --- /dev/null
> +++ b/include/qemu/env.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright (c) 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef QEMU_ENV_H
> +#define QEMU_ENV_H
> +
> +#define FD_PREFIX "QEMU_FD_"
> +#define ADDR_PREFIX "QEMU_ADDR_"
> +#define LEN_PREFIX "QEMU_LEN_"
> +#define BOOL_PREFIX "QEMU_BOOL_"
> +
> +typedef int (*walkenv_cb)(const char *name, const char *val, void *handle);
> +
> +bool getenv_ram(const char *name, void **addrp, size_t *lenp);
> +void setenv_ram(const char *name, void *addr, size_t len);
> +void unsetenv_ram(const char *name);
> +int getenv_fd(const char *name);
> +void setenv_fd(const char *name, int fd);
> +void unsetenv_fd(const char *name);
> +bool getenv_bool(const char *name);
> +void setenv_bool(const char *name, bool val);
> +void unsetenv_bool(const char *name);
> +int walkenv(const char *prefix, walkenv_cb cb, void *handle);
> +void printenv(void);
> +
> +#endif
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index cc5e371..d357932 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -1,4 +1,4 @@
> -util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
> +util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o env.o
>  util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
>  util-obj-$(CONFIG_POSIX) += aio-posix.o
>  util-obj-$(CONFIG_POSIX) += fdmon-poll.o
> diff --git a/util/env.c b/util/env.c
> new file mode 100644
> index 0000000..0cc4a9f
> --- /dev/null
> +++ b/util/env.c
> @@ -0,0 +1,132 @@
> +/*
> + * Copyright (c) 2020 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/env.h"
> +
> +static uint64_t getenv_ulong(const char *prefix, const char *name, bool *found)
> +{
> +    char var[80], *val;
> +    uint64_t res;
> +
> +    snprintf(var, sizeof(var), "%s%s", prefix, name);
> +    val = getenv(var);
> +    if (val) {
> +        *found = true;
> +        res = strtol(val, 0, 10);
> +    } else {
> +        *found = false;
> +        res = 0;
> +    }
> +    return res;
> +}
> +
> +static void setenv_ulong(const char *prefix, const char *name, uint64_t val)
> +{
> +    char var[80], val_str[80];
> +    snprintf(var, sizeof(var), "%s%s", prefix, name);
> +    snprintf(val_str, sizeof(val_str), "%"PRIu64, val);
> +    setenv(var, val_str, 1);
> +}
> +
> +static void unsetenv_ulong(const char *prefix, const char *name)
> +{
> +    char var[80];
> +    snprintf(var, sizeof(var), "%s%s", prefix, name);
> +    unsetenv(var);
> +}
> +
> +bool getenv_ram(const char *name, void **addrp, size_t *lenp)
> +{
> +    bool found1, found2;
> +    *addrp = (void *) getenv_ulong(ADDR_PREFIX, name, &found1);
> +    *lenp = getenv_ulong(LEN_PREFIX, name, &found2);
> +    assert(found1 == found2);
> +    return found1;
> +}
> +
> +void setenv_ram(const char *name, void *addr, size_t len)
> +{
> +    setenv_ulong(ADDR_PREFIX, name, (uint64_t)addr);
> +    setenv_ulong(LEN_PREFIX, name, len);
> +}
> +
> +void unsetenv_ram(const char *name)
> +{
> +    unsetenv_ulong(ADDR_PREFIX, name);
> +    unsetenv_ulong(LEN_PREFIX, name);
> +}
> +
> +int getenv_fd(const char *name)
> +{
> +    bool found;
> +    int fd = getenv_ulong(FD_PREFIX, name, &found);
> +    if (!found) {
> +        fd = -1;
> +    }
> +    return fd;
> +}
> +
> +void setenv_fd(const char *name, int fd)
> +{
> +    setenv_ulong(FD_PREFIX, name, fd);
> +}
> +
> +void unsetenv_fd(const char *name)
> +{
> +    unsetenv_ulong(FD_PREFIX, name);
> +}
> +
> +bool getenv_bool(const char *name)
> +{
> +    bool found;
> +    bool val = getenv_ulong(BOOL_PREFIX, name, &found);
> +    if (!found) {
> +        val = -1;
> +    }
> +    return val;
> +}
> +
> +void setenv_bool(const char *name, bool val)
> +{
> +    setenv_ulong(BOOL_PREFIX, name, val);
> +}
> +
> +void unsetenv_bool(const char *name)
> +{
> +    unsetenv_ulong(BOOL_PREFIX, name);
> +}
> +
> +int walkenv(const char *prefix, walkenv_cb cb, void *handle)
> +{
> +    char *str, name[128];
> +    char **envp = environ;
> +    size_t prefix_len = strlen(prefix);
> +
> +    while (*envp) {
> +        str = *envp++;
> +        if (!strncmp(str, prefix, prefix_len)) {
> +            char *val = strchr(str, '=');
> +            str += prefix_len;
> +            strncpy(name, str, val - str);
> +            name[val - str] = 0;
> +            if (cb(name, val + 1, handle)) {
> +                return 1;
> +            }
> +        }
> +    }
> +    return 0;
> +}
> +
> +void printenv(void)
> +{
> +    char **ptr = environ;
> +    while (*ptr) {
> +        puts(*ptr++);
> +    }
> +}
> -- 
> 1.8.3.1
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


