Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA62C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9300921655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEthxl0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9300921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNCi-00064u-Me
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ifNBq-0005bW-8l
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ifNBk-000870-Os
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:03:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25588
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ifNBk-00084Y-EL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576152203;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QuFS6+mRX2+WfrTwkxvvfi/WejC8Yu+u7P1HSYOXZEk=;
 b=eEthxl0HJS2c2YhG6rpRK6aHTW7oHupAW/1FQMbw6qydVte2zPUNtNOufI9Db3SvX2TtFz
 uBBZ+o4ruwoGT6szV8wOVyItvSdwjNqqCbyJW/Sn4ld/GHVc+NKoWCLQ5hCfW4aGyeqXjq
 bDGIUEczgVExZrDEn62x0zcz6BfGxqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-6Y9qI-CLO6SxWUD-75D0nw-1; Thu, 12 Dec 2019 07:03:22 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB08818552B4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 12:03:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61C015C1C3;
 Thu, 12 Dec 2019 12:03:17 +0000 (UTC)
Date: Thu, 12 Dec 2019 12:03:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v6 5/8] Add dbus-vmstate object
Message-ID: <20191212120315.GI1829331@redhat.com>
References: <20191211134506.1803403-1-marcandre.lureau@redhat.com>
 <20191211134506.1803403-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191211134506.1803403-6-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 6Y9qI-CLO6SxWUD-75D0nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Wed, Dec 11, 2019 at 05:45:03PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> When instantiated, this object will connect to the given D-Bus bus
> "addr". During migration, it will take/restore the data from
> org.qemu.VMState1 instances. See documentation for details.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS                   |   2 +
>  backends/Makefile.objs        |   4 +
>  backends/dbus-vmstate.c       | 496 ++++++++++++++++++++++++++++++++++
>  docs/interop/dbus-vmstate.rst |  74 +++++
>  docs/interop/dbus.rst         |   5 +
>  docs/interop/index.rst        |   1 +
>  6 files changed, 582 insertions(+)
>  create mode 100644 backends/dbus-vmstate.c
>  create mode 100644 docs/interop/dbus-vmstate.rst
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f08fb4f24e..7af80d0c1d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2202,9 +2202,11 @@ F: qapi/migration.json
>  D-Bus
>  M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>  S: Maintained
> +F: backends/dbus-vmstate.c
>  F: util/dbus.c
>  F: include/qemu/dbus.h
>  F: docs/interop/dbus.rst
> +F: docs/interop/dbus-vmstate.rst
> =20
>  Seccomp
>  M: Eduardo Otubo <otubo@redhat.com>
> diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> index f0691116e8..28a847cd57 100644
> --- a/backends/Makefile.objs
> +++ b/backends/Makefile.objs
> @@ -17,3 +17,7 @@ endif
>  common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_VIRTIO)) +=3D vhost=
-user.o
> =20
>  common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
> +
> +common-obj-$(CONFIG_GIO) +=3D dbus-vmstate.o
> +dbus-vmstate.o-cflags =3D $(GIO_CFLAGS)
> +dbus-vmstate.o-libs =3D $(GIO_LIBS)
> diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
> new file mode 100644
> index 0000000000..059dd420b8
> --- /dev/null
> +++ b/backends/dbus-vmstate.c
> @@ -0,0 +1,496 @@
> +/*
> + * QEMU dbus-vmstate
> + *
> + * Copyright (C) 2019 Red Hat Inc
> + *
> + * Authors:
> + *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/dbus.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "qapi/qmp/qerror.h"
> +#include "migration/vmstate.h"
> +
> +typedef struct DBusVMState DBusVMState;
> +typedef struct DBusVMStateClass DBusVMStateClass;
> +
> +#define TYPE_DBUS_VMSTATE "dbus-vmstate"
> +#define DBUS_VMSTATE(obj)                                \
> +    OBJECT_CHECK(DBusVMState, (obj), TYPE_DBUS_VMSTATE)
> +#define DBUS_VMSTATE_GET_CLASS(obj)                              \
> +    OBJECT_GET_CLASS(DBusVMStateClass, (obj), TYPE_DBUS_VMSTATE)
> +#define DBUS_VMSTATE_CLASS(klass)                                    \
> +    OBJECT_CLASS_CHECK(DBusVMStateClass, (klass), TYPE_DBUS_VMSTATE)
> +
> +struct DBusVMStateClass {
> +    ObjectClass parent_class;
> +};
> +

Not an objection to your patch here. This just reminds me that we
ought to follow GLib's lead and implement some helper macros to
automate all this tedious boilerplate. So we can just do something
simple like:

 QOM_DECLARE_FINAL_TYPE(DBusVMState, dbus_vmstate, DBUS_VMSATE, Object)

and an equiv to do the  TypeInfo declaration & registration.

> +struct DBusVMState {
> +    Object parent;
> +
> +    GDBusConnection *bus;
> +    char *dbus_addr;
> +    char *id_list;
> +
> +    uint32_t data_size;
> +    uint8_t *data;
> +};
> +
> +static const GDBusPropertyInfo vmstate_property_info[] =3D {
> +    { -1, (char *) "Id", (char *) "s",
> +      G_DBUS_PROPERTY_INFO_FLAGS_READABLE, NULL },
> +};
> +
> +static const GDBusPropertyInfo * const vmstate_property_info_pointers[] =
=3D {
> +    &vmstate_property_info[0],
> +    NULL
> +};
> +
> +static const GDBusInterfaceInfo vmstate1_interface_info =3D {
> +    -1,
> +    (char *) "org.qemu.VMState1",
> +    (GDBusMethodInfo **) NULL,
> +    (GDBusSignalInfo **) NULL,
> +    (GDBusPropertyInfo **) &vmstate_property_info_pointers,
> +    NULL,
> +};
> +
> +#define DBUS_VMSTATE_SIZE_LIMIT (1 * MiB)
> +
> +static GHashTable *
> +get_id_list_set(DBusVMState *self)
> +{
> +    g_auto(GStrv) ids =3D NULL;
> +    g_autoptr(GHashTable) set =3D NULL;
> +    int i;
> +
> +    if (!self->id_list) {
> +        return NULL;
> +    }
> +
> +    ids =3D g_strsplit(self->id_list, ",", -1);
> +    set =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free, NULL)=
;
> +    for (i =3D 0; ids[i]; i++) {
> +        g_hash_table_add(set, ids[i]);
> +        ids[i] =3D NULL;
> +    }
> +
> +    return g_steal_pointer(&set);
> +}
> +
> +static GHashTable *
> +dbus_get_proxies(DBusVMState *self, GError **err)
> +{
> +    g_autoptr(GHashTable) proxies =3D NULL;
> +    g_autoptr(GHashTable) ids =3D NULL;
> +    g_auto(GStrv) names =3D NULL;
> +    size_t i;
> +
> +    ids =3D get_id_list_set(self);
> +    proxies =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> +                                    g_free, g_object_unref);
> +
> +    names =3D qemu_dbus_get_queued_owners(self->bus, "org.qemu.VMState1"=
);
> +    if (!names) {
> +        return NULL;
> +    }
> +
> +    for (i =3D 0; names[i]; i++) {
> +        g_autoptr(GDBusProxy) proxy =3D NULL;
> +        g_autoptr(GVariant) result =3D NULL;
> +        g_autofree char *id =3D NULL;
> +        size_t size;
> +
> +        proxy =3D g_dbus_proxy_new_sync(self->bus, G_DBUS_PROXY_FLAGS_NO=
NE,
> +                    (GDBusInterfaceInfo *) &vmstate1_interface_info,
> +                    names[i],
> +                    "/org/qemu/VMState1",
> +                    "org.qemu.VMState1",
> +                    NULL, err);
> +        if (!proxy) {
> +            return NULL;
> +        }
> +
> +        result =3D g_dbus_proxy_get_cached_property(proxy, "Id");
> +        if (!result) {
> +            g_set_error_literal(err, G_IO_ERROR, G_IO_ERROR_FAILED,
> +                                "VMState Id property is missing.");
> +            return NULL;
> +        }
> +
> +        id =3D g_variant_dup_string(result, &size);
> +        if (ids && !g_hash_table_remove(ids, id)) {
> +            g_clear_pointer(&id, g_free);
> +            g_clear_object(&proxy);
> +            continue;
> +        }
> +        if (size =3D=3D 0 || size >=3D 256) {
> +            g_set_error(err, G_IO_ERROR, G_IO_ERROR_FAILED,
> +                        "VMState Id '%s' is invalid.", id);
> +            return NULL;
> +        }
> +
> +        if (!g_hash_table_insert(proxies, id, proxy)) {
> +            g_set_error(err, G_IO_ERROR, G_IO_ERROR_FAILED,
> +                        "Duplicated VMState Id '%s'", id);
> +            return NULL;
> +        }
> +        id =3D NULL;
> +        proxy =3D NULL;
> +
> +        g_clear_pointer(&result, g_variant_unref);
> +    }
> +
> +    if (ids) {
> +        g_autofree char **left =3D NULL;
> +
> +        left =3D (char **)g_hash_table_get_keys_as_array(ids, NULL);
> +        if (*left) {
> +            g_autofree char *leftids =3D g_strjoinv(",", left);
> +            g_set_error(err, G_IO_ERROR, G_IO_ERROR_FAILED,
> +                        "Required VMState Id are missing: %s", leftids);
> +            return NULL;
> +        }
> +    }
> +
> +    return g_steal_pointer(&proxies);
> +}
> +
> +static int
> +dbus_load_state_proxy(GDBusProxy *proxy, const uint8_t *data, size_t siz=
e)
> +{
> +    g_autoptr(GError) err =3D NULL;
> +    g_autoptr(GVariant) result =3D NULL;
> +    g_autoptr(GVariant) value =3D NULL;
> +
> +    value =3D g_variant_new_fixed_array(G_VARIANT_TYPE_BYTE,
> +                                      data, size, sizeof(char));
> +    result =3D g_dbus_proxy_call_sync(proxy, "Load",
> +                                    g_variant_new("(@ay)",
> +                                                  g_steal_pointer(&value=
)),
> +                                    G_DBUS_CALL_FLAGS_NO_AUTO_START,
> +                                    -1, NULL, &err);
> +    if (!result) {
> +        error_report("Failed to Load: %s", err->message);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int dbus_vmstate_post_load(void *opaque, int version_id)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(opaque);
> +    g_autoptr(GInputStream) m =3D NULL;
> +    g_autoptr(GDataInputStream) s =3D NULL;
> +    g_autoptr(GError) err =3D NULL;
> +    g_autoptr(GHashTable) proxies =3D NULL;
> +    uint32_t nelem;
> +
> +    proxies =3D dbus_get_proxies(self, &err);
> +    if (!proxies) {
> +        error_report("Failed to get proxies: %s", err->message);
> +        return -1;
> +    }
> +
> +    m =3D g_memory_input_stream_new_from_data(self->data, self->data_siz=
e, NULL);
> +    s =3D g_data_input_stream_new(m);
> +    g_data_input_stream_set_byte_order(s, G_DATA_STREAM_BYTE_ORDER_BIG_E=
NDIAN);
> +
> +    nelem =3D g_data_input_stream_read_uint32(s, NULL, &err);
> +    if (err) {
> +        goto error;
> +    }
> +
> +    while (nelem > 0) {
> +        GDBusProxy *proxy =3D NULL;
> +        uint32_t len;
> +        gsize bytes_read, avail;
> +        char id[256];
> +
> +        len =3D g_data_input_stream_read_uint32(s, NULL, &err);
> +        if (err) {
> +            goto error;
> +        }
> +        if (len >=3D 256) {
> +            error_report("Invalid DBus vmstate proxy name %u", len);
> +            return -1;
> +        }
> +        if (!g_input_stream_read_all(G_INPUT_STREAM(s), id, len,
> +                                     &bytes_read, NULL, &err)) {
> +            goto error;
> +        }
> +        g_return_val_if_fail(bytes_read =3D=3D len, -1);
> +        id[len] =3D 0;
> +
> +        proxy =3D g_hash_table_lookup(proxies, id);
> +        if (!proxy) {
> +            error_report("Failed to find proxy Id '%s'", id);
> +            return -1;
> +        }
> +
> +        len =3D g_data_input_stream_read_uint32(s, NULL, &err);
> +        avail =3D g_buffered_input_stream_get_available(
> +            G_BUFFERED_INPUT_STREAM(s));
> +
> +        if (len > DBUS_VMSTATE_SIZE_LIMIT || len > avail) {
> +            error_report("Invalid vmstate size: %u", len);
> +            return -1;
> +        }
> +
> +        if (dbus_load_state_proxy(proxy,
> +                g_buffered_input_stream_peek_buffer(G_BUFFERED_INPUT_STR=
EAM(s),
> +                                                    NULL),
> +                len) < 0) {
> +            error_report("Failed to restore Id '%s'", id);
> +            return -1;
> +        }
> +
> +        if (!g_seekable_seek(G_SEEKABLE(s), len, G_SEEK_CUR, NULL, &err)=
) {
> +            goto error;
> +        }
> +
> +        nelem -=3D 1;
> +    }
> +
> +    return 0;
> +
> +error:
> +    error_report("Failed to read from stream: %s", err->message);
> +    return -1;
> +}
> +
> +static void
> +dbus_save_state_proxy(gpointer key,
> +                      gpointer value,
> +                      gpointer user_data)
> +{
> +    GDataOutputStream *s =3D user_data;
> +    const char *id =3D key;
> +    GDBusProxy *proxy =3D value;
> +    g_autoptr(GVariant) result =3D NULL;
> +    g_autoptr(GVariant) child =3D NULL;
> +    g_autoptr(GError) err =3D NULL;
> +    const uint8_t *data;
> +    gsize size;
> +
> +    result =3D g_dbus_proxy_call_sync(proxy, "Save",
> +                                    NULL, G_DBUS_CALL_FLAGS_NO_AUTO_STAR=
T,
> +                                    -1, NULL, &err);
> +    if (!result) {
> +        error_report("Failed to Save: %s", err->message);
> +        return;
> +    }
> +
> +    child =3D g_variant_get_child_value(result, 0);
> +    data =3D g_variant_get_fixed_array(child, &size, sizeof(char));
> +    if (!data) {
> +        error_report("Failed to Save: not a byte array");
> +        return;
> +    }
> +    if (size > DBUS_VMSTATE_SIZE_LIMIT) {
> +        error_report("Too large vmstate data to save: %" G_GSIZE_FORMAT,=
 size);
> +        return;
> +    }
> +
> +    if (!g_data_output_stream_put_uint32(s, strlen(id), NULL, &err) ||
> +        !g_data_output_stream_put_string(s, id, NULL, &err) ||
> +        !g_data_output_stream_put_uint32(s, size, NULL, &err) ||
> +        !g_output_stream_write_all(G_OUTPUT_STREAM(s),
> +                                   data, size, NULL, NULL, &err)) {
> +        error_report("Failed to write to stream: %s", err->message);
> +    }

This is a bit of a bike-shed comment, but I'm curious if you
considered using GVariant for the serializing data vs the
data output stream ? I feel like GVariant is enforcing more
structure & safety on the data serialization process, which
could be appealing.

> +static int dbus_vmstate_pre_save(void *opaque)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(opaque);
> +    g_autoptr(GOutputStream) m =3D NULL;
> +    g_autoptr(GDataOutputStream) s =3D NULL;
> +    g_autoptr(GHashTable) proxies =3D NULL;
> +    g_autoptr(GError) err =3D NULL;
> +
> +    proxies =3D dbus_get_proxies(self, &err);
> +    if (!proxies) {
> +        error_report("Failed to get proxies: %s", err->message);
> +        return -1;
> +    }
> +
> +    m =3D g_memory_output_stream_new_resizable();
> +    s =3D g_data_output_stream_new(m);
> +    g_data_output_stream_set_byte_order(s, G_DATA_STREAM_BYTE_ORDER_BIG_=
ENDIAN);
> +
> +    if (!g_data_output_stream_put_uint32(s, g_hash_table_size(proxies),
> +                                         NULL, &err)) {
> +        error_report("Failed to write to stream: %s", err->message);
> +        return -1;
> +    }
> +
> +    g_hash_table_foreach(proxies, dbus_save_state_proxy, s);
> +
> +    if (g_memory_output_stream_get_size(G_MEMORY_OUTPUT_STREAM(m))
> +        > UINT32_MAX) {
> +        error_report("DBus vmstate buffer is too large");
> +        return -1;
> +    }
> +
> +    if (!g_output_stream_close(G_OUTPUT_STREAM(m), NULL, &err)) {
> +        error_report("Failed to close stream: %s", err->message);
> +        return -1;
> +    }
> +
> +    g_free(self->data);
> +    self->data_size =3D
> +        g_memory_output_stream_get_size(G_MEMORY_OUTPUT_STREAM(m));
> +    self->data =3D
> +        g_memory_output_stream_steal_data(G_MEMORY_OUTPUT_STREAM(m));
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription dbus_vmstate =3D {
> +    .name =3D TYPE_DBUS_VMSTATE,
> +    .version_id =3D 0,
> +    .pre_save =3D dbus_vmstate_pre_save,
> +    .post_load =3D dbus_vmstate_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(data_size, DBusVMState),
> +        VMSTATE_VBUFFER_ALLOC_UINT32(data, DBusVMState, 0, 0, data_size)=
,
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void
> +dbus_vmstate_complete(UserCreatable *uc, Error **errp)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(uc);
> +    GError *err =3D NULL;

Can use g_autoptr for this

> +    GDBusConnection *bus;
> +
> +    if (!object_resolve_path_type("", TYPE_DBUS_VMSTATE, NULL)) {
> +        error_setg(errp, "There is already an instance of %s",
> +                   TYPE_DBUS_VMSTATE);
> +        return;
> +    }
> +
> +    if (!self->dbus_addr) {
> +        error_setg(errp, QERR_MISSING_PARAMETER, "addr");
> +        return;
> +    }
> +
> +    bus =3D g_dbus_connection_new_for_address_sync(self->dbus_addr,
> +             G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT |
> +             G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION,
> +             NULL, NULL, &err);

Why not just use  self->bus directly.

> +    if (err) {
> +        error_setg(errp, "failed to connect to DBus: '%s'", err->message=
);
> +        g_clear_error(&err);

Missing return here, as we don't want to register vmstate handler
if we fail.

> +    }
> +
> +    self->bus =3D bus;
> +
> +    if (vmstate_register(VMSTATE_IF(self), -1, &dbus_vmstate, self) < 0)=
 {
> +        error_setg(errp, "Failed to register vmstate");
> +    }
> +}


> diff --git a/docs/interop/dbus-vmstate.rst b/docs/interop/dbus-vmstate.rs=
t
> new file mode 100644
> index 0000000000..8693891640
> --- /dev/null
> +++ b/docs/interop/dbus-vmstate.rst
> @@ -0,0 +1,74 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +D-Bus VMState
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The QEMU dbus-vmstate object's aim is to migrate helpers' data running
> +on a QEMU D-Bus bus. (refer to the :doc:`dbus` document for
> +recommendation on D-Bus usage)
> +
> +Upon migration, QEMU will go through the queue of
> +``org.qemu.VMState1`` D-Bus name owners and query their ``Id``. It
> +must be unique among the helpers.
> +
> +It will then save arbitrary data of each Id to be transferred in the
> +migration stream and restored/loaded at the corresponding destination
> +helper.
> +
> +The data amount to be transferred is limited to 1Mb. The state must be
> +saved quickly (a few seconds maximum). (D-Bus imposes a time limit on

A few seconds is too long IMHO. I think the expectation ought to
be a small fraction of a second.

Anything longer than that suggests there is some extra synchronization
work needing beyond serailizing state, which might suggest the need
for a separate DBus call.  eg a way to tell the backend to "quiesce"
itself perhaps

For now we can keep it simple and just say that this method should
not do anything except seriailize state in a fraction of a second.

> +reply anyway, and migration would fail if data isn't given quickly
> +enough.)
> +
> +dbus-vmstate object can be configured with the expected list of
> +helpers by setting its ``id-list`` property, with a comma-separated
> +``Id`` list.
> +
> +Interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +On object path ``/org/qemu/VMState1``, the following
> +``org.qemu.VMState1`` interface should be implemented:
> +
> +.. code:: xml
> +
> +  <interface name=3D"org.qemu.VMState1">
> +    <property name=3D"Id" type=3D"s" access=3D"read"/>
> +    <method name=3D"Load">
> +      <arg type=3D"ay" name=3D"data" direction=3D"in"/>
> +    </method>
> +    <method name=3D"Save">
> +      <arg type=3D"ay" name=3D"data" direction=3D"out"/>
> +    </method>
> +  </interface>
> +
> +"Id" property
> +-------------
> +
> +A string that identifies the helper uniquely. (maximum 256 bytes
> +including terminating NUL byte)
> +
> +.. note::
> +
> +   The helper ID namespace is a separate namespace. In particular, it is=
 not
> +   related to QEMU "id" used in -object/-device objects.

Are there any expectations here on a scheme ? I feel leaving it
unspecified is probably a mistake. Should it follow a DBUs like
reverse.domain.name.style ?

> +
> +Load(in u8[] bytes) method
> +--------------------------
> +
> +The method called on destination with the state to restore.
> +
> +The helper may be initially started in a waiting state (with
> +an --incoming argument for example), and it may resume on success.
> +
> +An error may be returned to the caller.
> +
> +Save(out u8[] bytes) method
> +---------------------------
> +
> +The method called on the source to get the current state to be
> +migrated. The helper should continue to run normally.
> +
> +An error may be returned to the caller.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


