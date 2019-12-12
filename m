Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064C7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33B2214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 11:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJQINrA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33B2214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifMo8-0001KJ-VX
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 06:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ifMnT-0000s7-84
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:38:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ifMnR-0004DK-Qa
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:38:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ifMnR-0004BS-Ki
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 06:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576150696;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eJ7IUMi27rUd57xFwuQrlMALvm0vF+qsIrHElMIUE4=;
 b=cJQINrA1IR9U9vjH85ZVxD1tsAMjBCt5jpFduvAzcj1NnSiDjiuxFsDl1VcqkBOSoNPsKw
 wmJNbrVFhVE3uCJCnPs61f+LLjVT3ZZTYGWlws6BHYyI3JPU0m2WpmwrTegsj3tsD7AT2P
 uKoo1wTAHGZTSA3KfLrvH/JADs1cT3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-INkESV-hN3Ktt4jb2AUSQA-1; Thu, 12 Dec 2019 06:38:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 530C3800D41
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 11:38:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FB1D60BCB;
 Thu, 12 Dec 2019 11:38:10 +0000 (UTC)
Date: Thu, 12 Dec 2019 11:38:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v6 4/8] util: add dbus helper unit
Message-ID: <20191212113808.GH1829331@redhat.com>
References: <20191211134506.1803403-1-marcandre.lureau@redhat.com>
 <20191211134506.1803403-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191211134506.1803403-5-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: INkESV-hN3Ktt4jb2AUSQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: mprivozn@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 11, 2019 at 05:45:02PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS         |  2 ++
>  include/qemu/dbus.h | 18 +++++++++++++++
>  util/Makefile.objs  |  3 +++
>  util/dbus.c         | 55 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 78 insertions(+)
>  create mode 100644 include/qemu/dbus.h
>  create mode 100644 util/dbus.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 19faa0e868..f08fb4f24e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2202,6 +2202,8 @@ F: qapi/migration.json
>  D-Bus
>  M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>  S: Maintained
> +F: util/dbus.c
> +F: include/qemu/dbus.h
>  F: docs/interop/dbus.rst
> =20
>  Seccomp
> diff --git a/include/qemu/dbus.h b/include/qemu/dbus.h
> new file mode 100644
> index 0000000000..efd74bef96
> --- /dev/null
> +++ b/include/qemu/dbus.h
> @@ -0,0 +1,18 @@
> +/*
> + * Helpers for using D-Bus
> + *
> + * Copyright (C) 2019 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#ifndef DBUS_H
> +#define DBUS_H
> +
> +#include <gio/gio.h>
> +
> +GStrv qemu_dbus_get_queued_owners(GDBusConnection *connection,
> +                                  const char *name);
> +
> +#endif /* DBUS_H */
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index df124af1c5..80b76352cd 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -55,5 +55,8 @@ util-obj-$(CONFIG_INOTIFY1) +=3D filemonitor-inotify.o
>  util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
>  util-obj-$(CONFIG_POSIX) +=3D drm.o
>  util-obj-y +=3D guest-random.o
> +util-obj-$(CONFIG_GIO) +=3D dbus.o
> +dbus.o-cflags =3D $(GIO_CFLAGS)
> +dbus.o-libs =3D $(GIO_LIBS)
> =20
>  stub-obj-y +=3D filemonitor-stub.o
> diff --git a/util/dbus.c b/util/dbus.c
> new file mode 100644
> index 0000000000..bb51870e54
> --- /dev/null
> +++ b/util/dbus.c
> @@ -0,0 +1,55 @@
> +/*
> + * Helpers for using D-Bus
> + *
> + * Copyright (C) 2019 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/dbus.h"
> +#include "qemu/error-report.h"
> +
> +/*
> + * qemu_dbus_get_queued_owners() - return the list of queued unique name=
s
> + * @connection: A GDBusConnection
> + * @name: a service name
> + *
> + * Return: a GStrv of unique names, or NULL on failure.
> + */
> +GStrv
> +qemu_dbus_get_queued_owners(GDBusConnection *connection, const char *nam=
e)
> +{
> +    g_autoptr(GDBusProxy) proxy =3D NULL;
> +    g_autoptr(GVariant) result =3D NULL;
> +    g_autoptr(GVariant) child =3D NULL;
> +    g_autoptr(GError) err =3D NULL;
> +
> +    proxy =3D g_dbus_proxy_new_sync(connection, G_DBUS_PROXY_FLAGS_NONE,=
 NULL,
> +                                  "org.freedesktop.DBus",
> +                                  "/org/freedesktop/DBus",
> +                                  "org.freedesktop.DBus",
> +                                  NULL, &err);
> +    if (!proxy) {
> +        error_report("Failed to create DBus proxy: %s", err->message);
> +        return NULL;
> +    }
> +
> +    result =3D g_dbus_proxy_call_sync(proxy, "ListQueuedOwners",
> +                                    g_variant_new("(s)", name),
> +                                    G_DBUS_CALL_FLAGS_NO_AUTO_START,
> +                                    -1, NULL, &err);
> +    if (!result) {
> +        if (g_error_matches(err,
> +                            G_DBUS_ERROR,
> +                            G_DBUS_ERROR_NAME_HAS_NO_OWNER)) {
> +            return g_new0(char *, 1);
> +        }
> +        error_report("Failed to call ListQueuedOwners: %s", err->message=
);

IMHO, helper code shouldn't be callling error_report, there should be
an Error **errp output parameter.

> +        return NULL;
> +    }
> +
> +    child =3D g_variant_get_child_value(result, 0);
> +    return g_variant_dup_strv(child, NULL);
> +}

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


