Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED68EC48BE7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 08:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE80F2064B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 08:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE80F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkPED-0003cy-Ue
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 04:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35447)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hkPDR-0003BL-NS
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 04:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hkPDP-0002Pv-RL
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 04:41:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39304)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hkPDP-0002PI-In
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 04:41:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DE8F58E23
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 08:41:38 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3546637DD;
 Mon,  8 Jul 2019 08:41:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
In-Reply-To: <20190708072437.3339-4-marcandre.lureau@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Mon, 8 Jul 2019 11:24:37 +0400")
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
 <20190708072437.3339-4-marcandre.lureau@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Mon, 08 Jul 2019 10:41:29 +0200
Message-ID: <87r270dikm.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 08 Jul 2019 08:41:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] Add dbus-vmstate object
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> When instanciated, this object will connect to the given D-Bus
> bus. During migration, it will take the data from org.qemu.VMState1
> instances.
>
> See documentation for further details.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> index 981e8e122f..dbbe12b225 100644
> --- a/backends/Makefile.objs
> +++ b/backends/Makefile.objs
> @@ -17,3 +17,7 @@ endif
>  common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_VIRTIO)) +=3D vhost=
-user.o
>=20=20
>  common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
> +
> +common-obj-$(CONFIG_GIO) +=3D dbus-vmstate.o
> +dbus-vmstate.o-cflags =3D $(GIO_CFLAGS)
> +dbus-vmstate.o-libs =3D $(GIO_LIBS)

I assume this only deppends of GIO, the variable that this patch
introduces is GDBUS_CODEGEN in configure.  I think it would be a good
idea to be able to disable this "feature" entirely.

Before anything, I have no clue about DBUS and not a lot about glib, so
don't expect anything else that questions on that front.

Several questions:

> +#define DBUS_VMSTATE_SIZE_LIMIT (1 << 20) /* 1mb */

What size do you expect in real life?  I am assuming that you have an
user case in mind.

> +#define DBUS_VMSTATE_SECTION 0x00

A section name of 0x00 is asking for trouble,  I would try a magic
number here?

> +#define DBUS_VMSTATE_EOF 0xff

You are doing:
- registering a savevm live subsection
  I don't understand why.  If this list is small enough, we would like
  probably preffer a normal device, and if it is big, are we expecting
  that the dbus source handle duplicates, etc, etc.

> +static GHashTable *
> +get_id_list_set(DBusVMState *self)
> +{
> +    char **ids;
> +    GHashTable *set;
> +    int i;
> +
> +    if (!self->id_list) {
> +        return NULL;
> +    }
> +
> +    ids =3D g_strsplit(self->id_list, ",", -1);
> +    set =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free, NULL);
> +    for (i =3D 0; ids[i]; i++) {
> +        g_hash_table_add(set, ids[i]);
> +        ids[i] =3D NULL;
> +    }

Why are we using a hash table here?

> +
> +    g_strfreev(ids);
> +    return set;
> +}
> +
> +static GHashTable *
> +dbus_get_proxies(DBusVMState *self, GError **err)
> +{
> +    GError *local_err =3D NULL;
> +    GHashTable *proxies =3D NULL;
> +    GVariant *result =3D NULL;
> +    char **names =3D NULL;
> +    char **left =3D NULL;
> +    GHashTable *ids =3D get_id_list_set(self);
> +    size_t i;
> +
> +    proxies =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> +                                    g_free, g_object_unref);
> +
> +    names =3D dbus_get_vmstate1_names(self, &local_err);
> +    if (!names) {
> +        if (g_error_matches(local_err,
> +                            G_DBUS_ERROR, G_DBUS_ERROR_NAME_HAS_NO_OWNER=
)) {
> +            return proxies;
> +        }
> +        g_propagate_error(err, local_err);
> +        goto err;
> +    }
> +
> +    for (i =3D 0; names[i]; i++) {
> +        GDBusProxy *proxy;
> +        char *id;
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
> +            goto err;
> +        }
> +
> +        result =3D g_dbus_proxy_get_cached_property(proxy, "Id");
> +        if (!result) {
> +            g_set_error_literal(err, G_IO_ERROR, G_IO_ERROR_FAILED,
> +                                "VMState Id property is missing.");
> +            g_clear_object(&proxy);
> +            goto err;
> +        }
> +
> +        id =3D g_variant_dup_string(result, &size);
> +        if (ids && !g_hash_table_remove(ids, id)) {
> +            g_free(id);
> +            g_clear_object(&proxy);
> +            continue;
> +        }
> +        if (size =3D=3D 0 || size >=3D 256) {

Why are we using 256 char limit here?  Is that a dbus thing, or it is
about this implementation?

> +            g_set_error(err, G_IO_ERROR, G_IO_ERROR_FAILED,
> +                        "VMState Id '%s' is invalid.", id);

                        "VMState Id '%s' has invalid size '%d", id, size); =
??

> +            g_free(id);
> +            g_clear_object(&proxy);
> +            goto err;
> +        }
> +
> +        if (!g_hash_table_insert(proxies, id, proxy)) {
> +            g_set_error(err, G_IO_ERROR, G_IO_ERROR_FAILED,
> +                        "Duplicated VMState Id '%s'", id);
> +            goto err;
> +        }
> +
> +        g_clear_pointer(&result, g_variant_unref);
> +    }
> +
> +    if (ids) {
> +        left =3D (char **)g_hash_table_get_keys_as_array(ids, NULL);
> +        if (*left) {
> +            char *leftids =3D g_strjoinv(",", left);
> +            g_set_error(err, G_IO_ERROR, G_IO_ERROR_FAILED,
> +                        "Required VMState Id are missing: %s", leftids);
> +            g_free(leftids);
> +            goto err;
> +        }
> +        g_free(left);
> +    }
> +
> +    g_clear_pointer(&ids, g_hash_table_unref);
> +    g_strfreev(names);
> +    return proxies;
> +
> +err:
> +    g_free(left);
> +    g_clear_pointer(&proxies, g_hash_table_unref);
> +    g_clear_pointer(&result, g_variant_unref);
> +    g_clear_pointer(&ids, g_hash_table_unref);
> +    g_strfreev(names);
> +    return NULL;
> +}
> +
> +static int
> +dbus_load_state_proxy(GDBusProxy *proxy, const uint8_t *data, size_t siz=
e)
> +{
> +    GError *err =3D NULL;
> +    GVariant *value, *result;
> +    int ret =3D -1;
> +
> +    value =3D g_variant_new_fixed_array(G_VARIANT_TYPE_BYTE,
> +                                      data, size, sizeof(char));
> +    result =3D g_dbus_proxy_call_sync(proxy, "Load",
> +                                    g_variant_new("(@ay)", value),
> +                                    G_DBUS_CALL_FLAGS_NO_AUTO_START,
> +                                    -1, NULL, &err);
> +    if (!resultp) {
> +        error_report("Failed to Load: %s", err->message);
> +        goto end;
> +    }
> +
> +    ret =3D 0;
> +
> +end:
> +    g_clear_pointer(&result, g_variant_unref);
> +    g_clear_error(&err);
> +    return ret;
> +}
> +
> +static int
> +dbus_load_state(QEMUFile *f, void *opaque, int version_id)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(opaque);
> +    GError *err =3D NULL;
> +    GHashTable *proxies =3D NULL;
> +    uint8_t *data =3D NULL;
> +    int ret =3D -1;
> +
> +    proxies =3D dbus_get_proxies(self, &err);
> +    if (!proxies) {
> +        error_report("Failed to get proxies: %s", err->message);
> +        goto end;
> +    }
> +
> +    while (qemu_get_byte(f) !=3D DBUS_VMSTATE_EOF) {

I know that there are other examples in qemu that uses this pattern:

while (more items)
  proccess aonther item;

But we are thing to move to a system that is:

for (numef of items)
  process item

I would expect that it would be better that you put a header with:
- a version
- number of elements
- total size

We would want at some point in the future to be able to introspect
inside the migration stream, that kind of things help.=20=20

What do you think?


> +        GDBusProxy *proxy =3D NULL;
> +        char id[256];
> +        unsigned int size;
> +
> +        if (qemu_get_counted_string(f, id) =3D=3D 0) {
> +            error_report("Invalid vmstate Id");
               error_report("Invalid vmstate Id: '%s'", id); ??

> +            goto end;
> +        }
> +
> +        proxy =3D g_hash_table_lookup(proxies, id);
> +        if (!proxy) {
> +            error_report("Failed to find proxy Id '%s'", id);
> +            goto end;
> +        }
> +
> +        size =3D qemu_get_be32(f);
> +        if (size > DBUS_VMSTATE_SIZE_LIMIT) {
> +            error_report("Invalid vmstate size: %u", size);
> +            goto end;
> +        }
> +
> +        data =3D g_malloc(size);
> +        if (qemu_get_buffer(f, data, size) !=3D size) {
> +            error_report("Failed to read %u bytes", size);
> +            goto end;
> +        }
> +
> +        if (dbus_load_state_proxy(proxy, data, size) < 0) {
> +            error_report("Failed to restore Id '%s'", id);
> +            goto end;
> +        }
> +
> +        g_clear_pointer(&data, g_free);
> +        g_hash_table_remove(proxies, id);
> +    }
> +
> +    if (g_hash_table_size(proxies) !=3D 0) {
> +        error_report("Missing DBus states from migration stream.");
> +        goto end;
> +    }
> +
> +    ret =3D 0;
> +
> +end:
> +    g_clear_pointer(&proxies, g_hash_table_unref);
> +    g_clear_pointer(&data, g_free);
> +    g_clear_error(&err);
> +    return ret;
> +}
> +
> +static void
> +dbus_save_state_proxy(gpointer key,
> +                      gpointer value,
> +                      gpointer user_data)
> +{
> +    QEMUFile *f =3D user_data;
> +    const char *id =3D key;
> +    GDBusProxy *proxy =3D value;
> +    GVariant *result =3D NULL, *child =3D NULL;
> +    const uint8_t *data;
> +    size_t size;
> +    GError *err =3D NULL;
> +
> +    result =3D g_dbus_proxy_call_sync(proxy, "Save",
> +                                    NULL, G_DBUS_CALL_FLAGS_NO_AUTO_STAR=
T,
> +                                    -1, NULL, &err);
> +    if (!result) {
> +        error_report("Failed to Save: %s", err->message);
> +        g_clear_error(&err);
> +        goto end;
> +    }
> +
> +    child =3D g_variant_get_child_value(result, 0);
> +    data =3D g_variant_get_fixed_array(child, &size, sizeof(char));
> +    if (!data) {
> +        error_report("Failed to Save: not a byte array");
> +        goto end;
> +    }
> +    if (size > DBUS_VMSTATE_SIZE_LIMIT) {
> +        error_report("Too much vmstate data to save: %lu", size);
> +        goto end;
> +    }
> +
> +    qemu_put_byte(f, DBUS_VMSTATE_SECTION);
> +    qemu_put_counted_string(f, id);
> +    qemu_put_be32(f, size);
> +    qemu_put_buffer(f, data, size);

We are just using vmstate to send an opaque chunk of data.  Normally we
are against this, we need a good explanation about why we want to put
this kind of handlers there.

> +
> +end:
> +    g_clear_pointer(&child, g_variant_unref);
> +    g_clear_pointer(&result, g_variant_unref);
> +}
> +
> +static void
> +dbus_save_state(QEMUFile *f, void *opaque)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(opaque);
> +    GHashTable *proxies;
> +    GError *err =3D NULL;
> +
> +    proxies =3D dbus_get_proxies(self, &err);
> +    if (!proxies) {
> +        error_report("Failed to get proxies: %s", err->message);
> +        goto end;
> +    }
> +
> +    /* TODO: how to report an error and cancel? */

This is basically where I would like to have some kind of header.

> +    g_hash_table_foreach(proxies, dbus_save_state_proxy, f);
> +    qemu_put_byte(f, DBUS_VMSTATE_EOF);
> +
> +end:
> +    g_clear_error(&err);
> +    g_clear_pointer(&proxies, g_hash_table_unref);
> +}
> +
> +static const SaveVMHandlers savevm_handlers =3D {
> +    .save_state =3D dbus_save_state,
> +    .load_state =3D dbus_load_state,
> +};
> +
> +static void
> +dbus_vmstate_complete(UserCreatable *uc, Error **errp)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(uc);
> +    GError *err =3D NULL;
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
> +    if (register_savevm_live(NULL, TYPE_DBUS_VMSTATE, 0, 0,
> +                             &savevm_handlers, self) < 0) {
> +        error_setg(errp, "Failed to register savevm handler");
> +        return;
> +    }
> +
> +    bus =3D g_dbus_connection_new_for_address_sync(self->dbus_addr,
> +             G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT |
> +             G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION,
> +             NULL, NULL, &err);
> +    if (err) {
> +        error_setg(errp, "failed to connect to DBus: '%s'", err->message=
);
> +        g_clear_error(&err);
> +    }
> +
> +    self->bus =3D bus;
> +}
> +
> +static void
> +dbus_vmstate_finalize(Object *o)
> +{
> +    DBusVMState *self =3D DBUS_VMSTATE(o);
> +
> +    unregister_savevm(NULL, TYPE_DBUS_VMSTATE, self);
> +    g_clear_object(&self->bus);
> +    g_free(self->dbus_addr);
> +    g_free(self->id_list);
> +}
> +

Documentation is nice.


> diff --git a/docs/interop/dbus-vmstate.rst b/docs/interop/dbus-vmstate.rst
> new file mode 100644
> index 0000000000..32d3475315
> --- /dev/null
> +++ b/docs/interop/dbus-vmstate.rst
> @@ -0,0 +1,64 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +DBus VMState
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Helper processes may have their state migrated with the help of the
> +QEMU object "dbus-vmstate".
> +
> +Upon migration, QEMU will go through the queue of "org.qemu.VMState1"
> +DBus name owners and query their "Id". It must be unique among the
> +helpers.
> +
> +It will then save arbitrary data of each Id to be transferred in the
> +migration stream and restored/loaded at the corresponding destination
> +helper.
> +
> +The data amount to be transferred is limited to 1Mb. The state must be
> +saved quickly (a few seconds maximum). (DBus imposes a time limit on
> +reply anyway, and migration would fail if data isn't given quickly
> +enough)

Seconds?  here?  We expect that the part of save_live to be clearly
under a second except if configured otherwise.

> +dbus-vmstate object can be configured with the expected list of
> +helpers by setting its "id-list" property, with a coma-separated Id
> +list.

Documentation is ok.

Test looks ok.

Later, Juan.

