Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5280C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 12:20:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7162089E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 12:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7162089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0m5C-0002Iv-K8
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 08:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i0m4O-0001kZ-CL
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 08:20:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i0m4K-0001di-A4
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 08:19:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i0m4J-0001dQ-Ue
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 08:19:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3591D3082B02
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 12:19:55 +0000 (UTC)
Received: from work-vm (ovpn-117-231.ams2.redhat.com [10.36.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E3975DE5C;
 Thu, 22 Aug 2019 12:19:52 +0000 (UTC)
Date: Thu, 22 Aug 2019 13:19:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190822121950.GH3277@work-vm>
References: <20190808150325.21939-1-marcandre.lureau@redhat.com>
 <20190808150325.21939-3-marcandre.lureau@redhat.com>
 <20190822105558.GF3277@work-vm>
 <CAMxuvayE_5yEzQzwGUUwDP6mCNqJHSuBRz7R=bd6eqUfbXO4GA@mail.gmail.com>
 <20190822114111.GG3277@work-vm>
 <CAMxuvayP62SJNBdFMF19Fg51DFOQDbBNuqtLEw9mc7d4+Lh1uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAMxuvayP62SJNBdFMF19Fg51DFOQDbBNuqtLEw9mc7d4+Lh1uQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 22 Aug 2019 12:19:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] Add dbus-vmstate object
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Hi
>=20
> On Thu, Aug 22, 2019 at 3:41 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> > > Hi
> > >
> > > On Thu, Aug 22, 2019 at 2:56 PM Dr. David Alan Gilbert
> > > <dgilbert@redhat.com> wrote:
> > > >
> > > > * Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> > > > > When instanciated, this object will connect to the given D-Bus
> > > > > bus. During migration, it will take the data from org.qemu.VMSt=
ate1
> > > > > instances.
> > > > >
> > > > > See documentation for further details.
> > > >
> > > > I'll leave the main review to someone who understands the details=
 of
> > > > DBUS, however from the migration side:
> > > >
> > > > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com=
>
> > > >
> > > > <snip>
> > > >
> > > > > +
> > > > > +static int
> > > > > +dbus_load_state(QEMUFile *f, void *opaque, int version_id)
> > > > > +{
> > > > > +    DBusVMState *self =3D DBUS_VMSTATE(opaque);
> > > > > +    uint8_t *data =3D NULL;
> > > > > +    int ret =3D -1;
> > > > > +    char id[256];
> > > > > +    unsigned int size;
> > > >
> > > > Higher level question; do you actually need a separate ID, or doe=
s
> > > > the ID that's stored by the migration code in the section name
> > > > give you enough uniqueness?
> > >
> > >
> > > The ID stored in migration section name is based on the handler ID:
> > > TYPE_DBUS_VMSTATE "-" handler_id
> > >
> > > By design, handler_id must be unique (and documented as such).
> > >
> > > Do you see a problem with that approach?
> >
> > OK, so if that's unique, why do you need an 'id' stored here?
>=20
> Oh I see, that's mostly a relic of v1, where multiple ID
> "sub-sections" would exist for each helper.
>=20
> However, if we want to allow having several "sub-sections" again, that
> might come handy to keep compatibility. It may be better to have a
> simple version field for that instead.

OK, that's fine

> >
> > > >
> > > > > +    if (qemu_get_counted_string(f, id) =3D=3D 0) {
> > > > > +        error_report("Invalid vmstate Id");
> > > > > +        goto end;
> > > >
> > > > I generally prefer to include something telling me where the erro=
r has
> > > > come from, just to make it easier to track down if I see the erro=
r in
> > > > a log; e.g. use __func__
> > >
> > > ok
> > >
> > > >
> > > > > +    }
> > > > > +
> > > > > +    if (g_strcmp0(id, self->id)) {
> > > > > +        error_report("Invalid vmstate Id: %s !=3D %s", id, sel=
f->id);
> > > > > +        goto end;
> > > > > +    }
> > > > > +
> > > > > +    size =3D qemu_get_be32(f);
> > > > > +    if (size > DBUS_VMSTATE_SIZE_LIMIT) {
> > > > > +        error_report("Invalid vmstate size: %u", size);
> > > > > +        goto end;
> > > > > +    }
> > > > > +
> > > > > +    data =3D g_malloc(size);
> > > > > +    if (qemu_get_buffer(f, data, size) !=3D size) {
> > > > > +        error_report("Failed to read %u bytes", size);
> > > > > +        goto end;
> > > > > +    }
> > > > > +
> > > > > +    if (dbus_load_state_proxy(self->proxy, data, size) < 0) {
> > > > > +        error_report("Failed to restore Id '%s'", id);
> > > > > +        goto end;
> > > > > +    }
> > > > > +
> > > > > +    ret =3D 0;
> > > > > +
> > > > > +end:
> > > > > +    g_clear_pointer(&data, g_free);
> > > > > +    return ret;
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +dbus_save_state(QEMUFile *f, void *opaque)
> > > > > +{
> > > > > +    DBusVMState *self =3D DBUS_VMSTATE(opaque);
> > > > > +    GVariant *result =3D NULL, *child =3D NULL;
> > > > > +    const uint8_t *data;
> > > > > +    size_t size;
> > > > > +    GError *err =3D NULL;
> > > > > +
> > > > > +    result =3D g_dbus_proxy_call_sync(self->proxy, "Save",
> > > > > +                                    NULL, G_DBUS_CALL_FLAGS_NO=
_AUTO_START,
> > > > > +                                    -1, NULL, &err);
> > > > > +    if (!result) {
> > > > > +        error_report("Failed to Save: %s", err->message);
> > > > > +        g_clear_error(&err);
> > > > > +        goto end;
> > > > > +    }
> > > > > +
> > > > > +    child =3D g_variant_get_child_value(result, 0);
> > > > > +    data =3D g_variant_get_fixed_array(child, &size, sizeof(ch=
ar));
> > > > > +    if (!data) {
> > > > > +        error_report("Failed to Save: not a byte array");
> > > > > +        goto end;
> > > > > +    }
> > > > > +    if (size > DBUS_VMSTATE_SIZE_LIMIT) {
> > > > > +        error_report("Too much vmstate data to save: %zu", siz=
e);
> > > > > +        goto end;
> > > > > +    }
> > > > > +
> > > > > +    qemu_put_counted_string(f, self->id);
> > > > > +    qemu_put_be32(f, size);
> > > > > +    qemu_put_buffer(f, data, size);
> > > > > +
> > > > > +end:
> > > > > +    g_clear_pointer(&child, g_variant_unref);
> > > > > +    g_clear_pointer(&result, g_variant_unref);
> > > > > +}
> > > > > +
> > > > > +static const SaveVMHandlers savevm_handlers =3D {
> > > > > +    .save_state =3D dbus_save_state,
> > > > > +    .load_state =3D dbus_load_state,
> > > > > +};
> > > > > +
> > > > > +static void
> > > > > +dbus_vmstate_complete(UserCreatable *uc, Error **errp)
> > > > > +{
> > > > > +    DBusVMState *self =3D DBUS_VMSTATE(uc);
> > > > > +    GError *err =3D NULL;
> > > > > +    GDBusConnection *bus =3D NULL;
> > > > > +    GDBusProxy *proxy =3D NULL;
> > > > > +    char *idstr =3D NULL;
> > > > > +
> > > > > +    if (!self->dbus_addr) {
> > > > > +        error_setg(errp, QERR_MISSING_PARAMETER, "addr");
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    bus =3D g_dbus_connection_new_for_address_sync(self->dbus_=
addr,
> > > > > +               G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT,
> > > > > +               NULL, NULL, &err);
> > > > > +    if (err) {
> > > > > +        error_setg(errp, "failed to connect to DBus: '%s'", er=
r->message);
> > > > > +        g_clear_error(&err);
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    self->bus =3D bus;
> > > > > +
> > > > > +    proxy =3D g_dbus_proxy_new_sync(bus,
> > > > > +                G_DBUS_PROXY_FLAGS_NONE,
> > > > > +                (GDBusInterfaceInfo *) &vmstate1_interface_inf=
o,
> > > > > +                NULL,
> > > > > +                "/org/qemu/VMState1",
> > > > > +                "org.qemu.VMState1",
> > > > > +                NULL, &err);
> > > > > +
> > > > > +    if (err) {
> > > > > +        error_setg(errp, "failed to create DBus proxy: '%s'", =
err->message);
> > > > > +        g_clear_error(&err);
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    self->proxy =3D proxy;
> > > > > +
> > > > > +    self->id =3D dbus_proxy_get_id(proxy, &err);
> > > > > +    if (!self->id) {
> > > > > +        error_setg(errp, "failed to get DBus Id: '%s'", err->m=
essage);
> > > > > +        g_clear_error(&err);
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    idstr =3D get_idstr(self);
> > > > > +    if (register_savevm_live(NULL, idstr, 0, 0,
> > > > > +                             &savevm_handlers, self) < 0) {
> > > > > +        error_setg(errp, "Failed to register savevm handler");
> > > > > +    }
> > > >
> > > > Can you try and avoid register_savevm_live if possible and just w=
ire a
> > > > vmsd onto the class like most other devices? We don't have many
> > > > register_savevm_live calls, and I'd like to get them down to just=
 the
> > > > iterative devices.
> > >
> > > Sure if I could, but it's not a device.
> > >
> > > Perhaps we could have a qom interface for vmsd users? I can try tha=
t eventually.
> >
> > Hmm, why isn't it a device?
>=20
> It doesn't need anything from Device (which is heavyweight), it is a
> simple user-creatable object that holds a dbus connection and reacts
> on migration events.
>=20
> If you take slirp helper process as an example, it's a "service" for a
> VM. Not a device. You could have the same helper for various devices
> etc, or more helpers for the same device.

I think you're better calling this a device; the slirp world doesn't fit
nicely either and it would be better if it was a device as well.

Dave

> >
> >
> > Dave
> >
> > > thanks
> > >
> > > > Dave
> > > >
> > > >
> > > > > +    g_free(idstr);
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +dbus_vmstate_finalize(Object *o)
> > > > > +{
> > > > > +    DBusVMState *self =3D DBUS_VMSTATE(o);
> > > > > +    char *idstr =3D get_idstr(self);
> > > > > +
> > > > > +    unregister_savevm(NULL, idstr, self);
> > > > > +
> > > > > +    g_clear_object(&self->bus);
> > > > > +    g_clear_object(&self->proxy);
> > > > > +    g_free(self->dbus_addr);
> > > > > +    g_free(self->id);
> > > > > +    g_free(idstr);
> > > > > +}
> > > > > +
> > > > > +static char *
> > > > > +get_dbus_addr(Object *o, Error **errp)
> > > > > +{
> > > > > +    DBusVMState *self =3D DBUS_VMSTATE(o);
> > > > > +
> > > > > +    return g_strdup(self->dbus_addr);
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +set_dbus_addr(Object *o, const char *str, Error **errp)
> > > > > +{
> > > > > +    DBusVMState *self =3D DBUS_VMSTATE(o);
> > > > > +
> > > > > +    g_free(self->dbus_addr);
> > > > > +    self->dbus_addr =3D g_strdup(str);
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +dbus_vmstate_class_init(ObjectClass *oc, void *data)
> > > > > +{
> > > > > +    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> > > > > +
> > > > > +    ucc->complete =3D dbus_vmstate_complete;
> > > > > +
> > > > > +    object_class_property_add_str(oc, "addr",
> > > > > +                                  get_dbus_addr, set_dbus_addr=
,
> > > > > +                                  &error_abort);
> > > > > +}
> > > > > +
> > > > > +static const TypeInfo dbus_vmstate_info =3D {
> > > > > +    .name =3D TYPE_DBUS_VMSTATE,
> > > > > +    .parent =3D TYPE_OBJECT,
> > > > > +    .instance_size =3D sizeof(DBusVMState),
> > > > > +    .instance_finalize =3D dbus_vmstate_finalize,
> > > > > +    .class_size =3D sizeof(DBusVMStateClass),
> > > > > +    .class_init =3D dbus_vmstate_class_init,
> > > > > +    .interfaces =3D (InterfaceInfo[]) {
> > > > > +        { TYPE_USER_CREATABLE },
> > > > > +        { }
> > > > > +    }
> > > > > +};
> > > > > +
> > > > > +static void
> > > > > +register_types(void)
> > > > > +{
> > > > > +    type_register_static(&dbus_vmstate_info);
> > > > > +}
> > > > > +
> > > > > +type_init(register_types);
> > > > > diff --git a/configure b/configure
> > > > > index 714e7fb6a1..e5b34f5ca7 100755
> > > > > --- a/configure
> > > > > +++ b/configure
> > > > > @@ -3665,10 +3665,16 @@ if $pkg_config --atleast-version=3D$gli=
b_req_ver gio-2.0; then
> > > > >      gio=3Dyes
> > > > >      gio_cflags=3D$($pkg_config --cflags gio-2.0)
> > > > >      gio_libs=3D$($pkg_config --libs gio-2.0)
> > > > > +    gdbus_codegen=3D$($pkg_config --variable=3Dgdbus_codegen g=
io-2.0)
> > > > >  else
> > > > >      gio=3Dno
> > > > >  fi
> > > > >
> > > > > +if $pkg_config --atleast-version=3D$glib_req_ver gio-unix-2.0;=
 then
> > > > > +    gio_cflags=3D"$gio_cflags $($pkg_config --cflags gio-unix-=
2.0)"
> > > > > +    gio_libs=3D"$gio_libs $($pkg_config --libs gio-unix-2.0)"
> > > > > +fi
> > > > > +
> > > > >  # Sanity check that the current size_t matches the
> > > > >  # size that glib thinks it should be. This catches
> > > > >  # problems on multi-arch where people try to build
> > > > > @@ -6830,6 +6836,7 @@ if test "$gio" =3D "yes" ; then
> > > > >      echo "CONFIG_GIO=3Dy" >> $config_host_mak
> > > > >      echo "GIO_CFLAGS=3D$gio_cflags" >> $config_host_mak
> > > > >      echo "GIO_LIBS=3D$gio_libs" >> $config_host_mak
> > > > > +    echo "GDBUS_CODEGEN=3D$gdbus_codegen" >> $config_host_mak
> > > > >  fi
> > > > >  echo "CONFIG_TLS_PRIORITY=3D\"$tls_priority\"" >> $config_host=
_mak
> > > > >  if test "$gnutls" =3D "yes" ; then
> > > > > diff --git a/docs/interop/dbus-vmstate.rst b/docs/interop/dbus-=
vmstate.rst
> > > > > new file mode 100644
> > > > > index 0000000000..4a32a183fb
> > > > > --- /dev/null
> > > > > +++ b/docs/interop/dbus-vmstate.rst
> > > > > @@ -0,0 +1,63 @@
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +DBus VMState
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +
> > > > > +Introduction
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +
> > > > > +Helper processes may have their state migrated with the help o=
f
> > > > > +QEMU "dbus-vmstate" objects.
> > > > > +
> > > > > +At this point, the connection to the helper is done in DBus
> > > > > +peer-to-peer mode (no initial Hello, and no bus name for
> > > > > +communication). The helper must be listening to the given addr=
ess.
> > > > > +
> > > > > +Helper may save arbitrary data to be transferred in the migrat=
ion
> > > > > +stream and restored/loaded on destination.
> > > > > +
> > > > > +The data amount to be transferred is limited to 1Mb. The state=
 must be
> > > > > +saved quickly (a few seconds maximum). (DBus imposes a time li=
mit on
> > > > > +reply anyway, and migration would fail if the data isn't given=
 quickly
> > > > > +enough)
> > > > > +
> > > > > +Interface
> > > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +
> > > > > +On /org/qemu/VMState1 object path:
> > > > > +
> > > > > +.. code:: xml
> > > > > +
> > > > > +  <interface name=3D"org.qemu.VMState1">
> > > > > +    <property name=3D"Id" type=3D"s" access=3D"read"/>
> > > > > +    <method name=3D"Load">
> > > > > +      <arg type=3D"ay" name=3D"data" direction=3D"in"/>
> > > > > +    </method>
> > > > > +    <method name=3D"Save">
> > > > > +      <arg type=3D"ay" name=3D"data" direction=3D"out"/>
> > > > > +    </method>
> > > > > +  </interface>
> > > > > +
> > > > > +"Id" property
> > > > > +-------------
> > > > > +
> > > > > +A utf8 encoded string that identifies the helper uniquely.
> > > > > +Must be <256 bytes.
> > > > > +
> > > > > +Load(in u8[] bytes) method
> > > > > +--------------------------
> > > > > +
> > > > > +The method called on destination with the state to restore.
> > > > > +
> > > > > +The helper may be initially started in a waiting state (with
> > > > > +an --incoming argument for example), and it may resume on load
> > > > > +success.
> > > > > +
> > > > > +An error may be returned to the caller.
> > > > > +
> > > > > +Save(out u8[] bytes) method
> > > > > +---------------------------
> > > > > +
> > > > > +The method called on the source to get the current state to be
> > > > > +migrated. The helper should continue to run normally.
> > > > > +
> > > > > +An error may be returned to the caller.
> > > > > diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> > > > > index b4bfcab417..6bb173cfa6 100644
> > > > > --- a/docs/interop/index.rst
> > > > > +++ b/docs/interop/index.rst
> > > > > @@ -13,6 +13,7 @@ Contents:
> > > > >     :maxdepth: 2
> > > > >
> > > > >     bitmaps
> > > > > +   dbus-vmstate
> > > > >     live-block-operations
> > > > >     pr-helper
> > > > >     vhost-user
> > > > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > > > index fd7fdb8658..2c610086a7 100644
> > > > > --- a/tests/Makefile.include
> > > > > +++ b/tests/Makefile.include
> > > > > @@ -157,7 +157,9 @@ check-qtest-pci-$(CONFIG_RTL8139_PCI) +=3D =
tests/rtl8139-test$(EXESUF)
> > > > >  check-qtest-pci-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXE=
SUF)
> > > > >  check-qtest-pci-$(CONFIG_HDA) +=3D tests/intel-hda-test$(EXESU=
F)
> > > > >  check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) +=3D tests/ivshmem-te=
st$(EXESUF)
> > > > > -
> > > > > +ifneq ($(GDBUS_CODEGEN),)
> > > > > +check-qtest-pci-$(CONFIG_GIO) +=3D tests/dbus-vmstate-test$(EX=
ESUF)
> > > > > +endif
> > > > >  check-qtest-i386-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-te=
st$(EXESUF)
> > > > >  check-qtest-i386-y +=3D tests/fdc-test$(EXESUF)
> > > > >  check-qtest-i386-y +=3D tests/ide-test$(EXESUF)
> > > > > @@ -618,6 +620,18 @@ tests/qapi-schema/doc-good.test.texi: $(SR=
C_PATH)/tests/qapi-schema/doc-good.jso
> > > > >       @mv tests/qapi-schema/doc-good-qapi-doc.texi $@
> > > > >       @rm -f tests/qapi-schema/doc-good-qapi-*.[ch] tests/qapi-=
schema/doc-good-qmp-*.[ch]
> > > > >
> > > > > +tests/dbus-vmstate1.h tests/dbus-vmstate1.c: tests/dbus-vmstat=
e1-gen-timestamp ;
> > > > > +tests/dbus-vmstate1-gen-timestamp: $(SRC_PATH)/tests/dbus-vmst=
ate1.xml
> > > > > +     $(call quiet-command,$(GDBUS_CODEGEN) $< \
> > > > > +             --interface-prefix org.qemu --generate-c-code tes=
ts/dbus-vmstate1, \
> > > > > +             "GEN","$(@:%-timestamp=3D%)")
> > > > > +     @>$@
> > > > > +
> > > > > +tests/dbus-vmstate1.o-cflags :=3D $(GIO_CFLAGS)
> > > > > +tests/dbus-vmstate1.o-libs :=3D $(GIO_LIBS)
> > > > > +
> > > > > +tests/dbus-vmstate-test.o: tests/dbus-vmstate1.h
> > > > > +
> > > > >  tests/test-string-output-visitor$(EXESUF): tests/test-string-o=
utput-visitor.o $(test-qapi-obj-y)
> > > > >  tests/test-string-input-visitor$(EXESUF): tests/test-string-in=
put-visitor.o $(test-qapi-obj-y)
> > > > >  tests/test-qmp-event$(EXESUF): tests/test-qmp-event.o $(test-q=
api-obj-y) tests/test-qapi-events.o
> > > > > @@ -820,6 +834,7 @@ tests/test-filter-mirror$(EXESUF): tests/te=
st-filter-mirror.o $(qtest-obj-y)
> > > > >  tests/test-filter-redirector$(EXESUF): tests/test-filter-redir=
ector.o $(qtest-obj-y)
> > > > >  tests/test-x86-cpuid-compat$(EXESUF): tests/test-x86-cpuid-com=
pat.o $(qtest-obj-y)
> > > > >  tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivsh=
mem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
> > > > > +tests/dbus-vmstate-test$(EXESUF): tests/dbus-vmstate-test.o te=
sts/dbus-vmstate1.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
> > > > >  tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(=
test-util-obj-y) libvhost-user.a
> > > > >  tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
> > > > >  tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
> > > > > @@ -1172,6 +1187,7 @@ check-clean:
> > > > >       rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y=
)
> > > > >       rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(c=
heck-qtest-$(target)-y)) $(check-qtest-generic-y))
> > > > >       rm -f tests/test-qapi-gen-timestamp
> > > > > +     rm -f tests/dbus-vmstate1-gen-timestamp
> > > > >       rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
> > > > >
> > > > >  clean: check-clean
> > > > > diff --git a/tests/dbus-vmstate-test.c b/tests/dbus-vmstate-tes=
t.c
> > > > > new file mode 100644
> > > > > index 0000000000..45d44916d2
> > > > > --- /dev/null
> > > > > +++ b/tests/dbus-vmstate-test.c
> > > > > @@ -0,0 +1,371 @@
> > > > > +#include "qemu/osdep.h"
> > > > > +#include <glib/gstdio.h>
> > > > > +#include <gio/gio.h>
> > > > > +#include "libqtest.h"
> > > > > +#include "qemu-common.h"
> > > > > +#include "dbus-vmstate1.h"
> > > > > +
> > > > > +static char *workdir;
> > > > > +
> > > > > +typedef struct TestServerId {
> > > > > +    const char *name;
> > > > > +    const char *data;
> > > > > +    size_t size;
> > > > > +} TestServerId;
> > > > > +
> > > > > +static const TestServerId idA =3D {
> > > > > +    "idA", "I'am\0idA!", sizeof("I'am\0idA!")
> > > > > +};
> > > > > +
> > > > > +static const TestServerId idB =3D {
> > > > > +    "idB", "I'am\0idB!", sizeof("I'am\0idB!")
> > > > > +};
> > > > > +
> > > > > +typedef struct TestServer {
> > > > > +    const TestServerId *id;
> > > > > +    bool save_called;
> > > > > +    bool load_called;
> > > > > +    GDBusObjectManagerServer *om;
> > > > > +    GDBusServer *server;
> > > > > +} TestServer;
> > > > > +
> > > > > +typedef struct Test {
> > > > > +    bool migrate_fail;
> > > > > +    TestServer srcA;
> > > > > +    TestServer dstA;
> > > > > +    TestServer srcB;
> > > > > +    TestServer dstB;
> > > > > +    GMainLoop *loop, *dbus_loop;
> > > > > +    QTestState *src_qemu;
> > > > > +} Test;
> > > > > +
> > > > > +GMutex mutex;
> > > > > +GCond cond;
> > > > > +
> > > > > +static gboolean
> > > > > +vmstate_load(VMState1 *object, GDBusMethodInvocation *invocati=
on,
> > > > > +             const gchar *arg_data, gpointer user_data)
> > > > > +{
> > > > > +    TestServer *h =3D user_data;
> > > > > +    GVariant *args, *var;
> > > > > +    const uint8_t *data;
> > > > > +    size_t size;
> > > > > +
> > > > > +    args =3D g_dbus_method_invocation_get_parameters(invocatio=
n);
> > > > > +    var =3D g_variant_get_child_value(args, 0);
> > > > > +    data =3D g_variant_get_fixed_array(var, &size, sizeof(char=
));
> > > > > +    g_assert_cmpuint(size, =3D=3D, h->id->size);
> > > > > +    g_assert(!memcmp(data, h->id->data, h->id->size));
> > > > > +    h->load_called =3D true;
> > > > > +    g_variant_unref(var);
> > > > > +
> > > > > +    g_dbus_method_invocation_return_value(invocation, g_varian=
t_new("()"));
> > > > > +    return TRUE;
> > > > > +}
> > > > > +
> > > > > +static gboolean
> > > > > +vmstate_save(VMState1 *object, GDBusMethodInvocation *invocati=
on,
> > > > > +             gpointer user_data)
> > > > > +{
> > > > > +    TestServer *h =3D user_data;
> > > > > +    GVariant *var;
> > > > > +
> > > > > +    var =3D g_variant_new_fixed_array(G_VARIANT_TYPE_BYTE,
> > > > > +                                    h->id->data, h->id->size, =
sizeof(char));
> > > > > +    g_dbus_method_invocation_return_value(invocation,
> > > > > +                                          g_variant_new("(@ay)=
", var));
> > > > > +    h->save_called =3D true;
> > > > > +
> > > > > +    return TRUE;
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +connection_closed(GDBusConnection *connection,
> > > > > +                  gboolean remote_peer_vanished,
> > > > > +                  GError *Error,
> > > > > +                  gpointer user_data)
> > > > > +{
> > > > > +    TestServer *h =3D user_data;
> > > > > +
> > > > > +    g_clear_object(&h->om);
> > > > > +    g_clear_object(&connection);
> > > > > +}
> > > > > +
> > > > > +static GDBusObjectManagerServer *
> > > > > +get_omserver(GDBusConnection *conn, gpointer user_data)
> > > > > +{
> > > > > +    TestServer *h =3D user_data;
> > > > > +    GDBusObjectManagerServer *om;
> > > > > +    GDBusObjectSkeleton *sk;
> > > > > +    VMState1 *v;
> > > > > +
> > > > > +    om =3D g_dbus_object_manager_server_new("/org/qemu");
> > > > > +    sk =3D g_dbus_object_skeleton_new("/org/qemu/VMState1");
> > > > > +
> > > > > +    v =3D vmstate1_skeleton_new();
> > > > > +    g_object_set(v, "id", h->id->name, NULL);
> > > > > +    g_signal_connect(v, "handle-load", G_CALLBACK(vmstate_load=
), user_data);
> > > > > +    g_signal_connect(v, "handle-save", G_CALLBACK(vmstate_save=
), user_data);
> > > > > +
> > > > > +    g_dbus_object_skeleton_add_interface(sk, G_DBUS_INTERFACE_=
SKELETON(v));
> > > > > +    g_dbus_object_manager_server_export(om, sk);
> > > > > +    g_dbus_object_manager_server_set_connection(om, conn);
> > > > > +
> > > > > +    g_clear_object(&v);
> > > > > +    g_clear_object(&sk);
> > > > > +
> > > > > +    return om;
> > > > > +}
> > > > > +
> > > > > +static gboolean
> > > > > +on_new_connection(GDBusServer *server,
> > > > > +                  GDBusConnection *connection,
> > > > > +                  gpointer user_data)
> > > > > +{
> > > > > +    TestServer *h =3D user_data;
> > > > > +
> > > > > +    g_object_ref(connection);
> > > > > +    g_signal_connect(connection, "closed",
> > > > > +                     G_CALLBACK(connection_closed), user_data)=
;
> > > > > +    h->om =3D get_omserver(connection, user_data);
> > > > > +
> > > > > +    return TRUE;
> > > > > +}
> > > > > +
> > > > > +static gboolean
> > > > > +allow_mechanism_cb(GDBusAuthObserver *observer,
> > > > > +                   const gchar *mechanism,
> > > > > +                   gpointer user_data)
> > > > > +{
> > > > > +    return g_strcmp0(mechanism, "EXTERNAL") =3D=3D 0;
> > > > > +}
> > > > > +
> > > > > +static gboolean
> > > > > +authorize_authenticated_peer_cb(GDBusAuthObserver *observer,
> > > > > +                                GIOStream *stream,
> > > > > +                                GCredentials *credentials,
> > > > > +                                gpointer user_data)
> > > > > +{
> > > > > +    gboolean authorized =3D FALSE;
> > > > > +
> > > > > +    if (credentials !=3D NULL) {
> > > > > +        GCredentials *own_credentials =3D g_credentials_new();
> > > > > +
> > > > > +        if (g_credentials_is_same_user(credentials, own_creden=
tials, NULL)) {
> > > > > +            authorized =3D TRUE;
> > > > > +        }
> > > > > +
> > > > > +        g_clear_object(&own_credentials);
> > > > > +    }
> > > > > +
> > > > > +    return authorized;
> > > > > +}
> > > > > +
> > > > > +static GDBusServer *
> > > > > +server_start(TestServer *h, const char *p, const TestServerId =
*id)
> > > > > +{
> > > > > +    GDBusAuthObserver *observer =3D NULL;
> > > > > +    GDBusServer *server =3D NULL;
> > > > > +    gchar *guid =3D NULL;
> > > > > +    GError *error =3D NULL;
> > > > > +    char *addr =3D NULL;
> > > > > +
> > > > > +    h->id =3D id;
> > > > > +    addr =3D g_strdup_printf("unix:path=3D%s/dbus-%s%s", workd=
ir, p, h->id->name);
> > > > > +    guid =3D g_dbus_generate_guid();
> > > > > +    observer =3D g_dbus_auth_observer_new();
> > > > > +    g_signal_connect(observer, "allow-mechanism",
> > > > > +                     G_CALLBACK(allow_mechanism_cb), h);
> > > > > +    g_signal_connect(observer, "authorize-authenticated-peer",
> > > > > +                     G_CALLBACK(authorize_authenticated_peer_c=
b), h);
> > > > > +
> > > > > +    server =3D g_dbus_server_new_sync(addr,
> > > > > +                                    G_DBUS_SERVER_FLAGS_NONE,
> > > > > +                                    guid,
> > > > > +                                    observer,
> > > > > +                                    NULL, /* GCancellable */
> > > > > +                                    &error);
> > > > > +    g_dbus_server_start(server);
> > > > > +    g_clear_object(&observer);
> > > > > +    g_free(guid);
> > > > > +
> > > > > +    if (server =3D=3D NULL) {
> > > > > +        g_printerr("Error creating server at address %s: %s\n"=
,
> > > > > +                   addr, error->message);
> > > > > +        g_error_free(error);
> > > > > +        return NULL;
> > > > > +    }
> > > > > +
> > > > > +    g_signal_connect(server, "new-connection",
> > > > > +                     G_CALLBACK(on_new_connection), h);
> > > > > +
> > > > > +    g_free(addr);
> > > > > +    return server;
> > > > > +}
> > > > > +
> > > > > +
> > > > > +static gpointer
> > > > > +dbus_thread(gpointer p)
> > > > > +{
> > > > > +    Test *test =3D p;
> > > > > +    GMainContext *context =3D g_main_context_new();
> > > > > +    GMainLoop *loop =3D g_main_loop_new(context, FALSE);
> > > > > +
> > > > > +    g_main_context_push_thread_default(context);
> > > > > +
> > > > > +    g_mutex_lock(&mutex);
> > > > > +    test->srcA.server =3D server_start(&test->srcA, "src", &id=
A);
> > > > > +    test->srcB.server =3D server_start(&test->srcB, "src", &id=
B);
> > > > > +    test->dstA.server =3D server_start(&test->dstA, "dst", &id=
A);
> > > > > +    test->dstB.server =3D server_start(&test->dstB, "dst", &id=
B);
> > > > > +    test->dbus_loop =3D loop;
> > > > > +    g_cond_signal(&cond);
> > > > > +    g_mutex_unlock(&mutex);
> > > > > +
> > > > > +    g_main_loop_run(loop);
> > > > > +
> > > > > +    g_main_loop_unref(loop);
> > > > > +    g_main_context_unref(context);
> > > > > +
> > > > > +    g_mutex_lock(&mutex);
> > > > > +    g_clear_object(&test->srcA.server);
> > > > > +    g_clear_object(&test->srcB.server);
> > > > > +    g_clear_object(&test->dstA.server);
> > > > > +    g_clear_object(&test->dstB.server);
> > > > > +    g_mutex_unlock(&mutex);
> > > > > +
> > > > > +    return NULL;
> > > > > +}
> > > > > +
> > > > > +static gboolean
> > > > > +wait_for_migration_complete(gpointer user_data)
> > > > > +{
> > > > > +    Test *test =3D user_data;
> > > > > +    QDict *rsp_return;
> > > > > +    bool stop =3D false;
> > > > > +    const char *status;
> > > > > +
> > > > > +    qtest_qmp_send(test->src_qemu, "{ 'execute': 'query-migrat=
e' }");
> > > > > +    rsp_return =3D qtest_qmp_receive_success(test->src_qemu, N=
ULL, NULL);
> > > > > +    status =3D qdict_get_str(rsp_return, "status");
> > > > > +    if (g_str_equal(status, "completed") || g_str_equal(status=
, "failed")) {
> > > > > +        stop =3D true;
> > > > > +        g_assert_cmpstr(status, =3D=3D,
> > > > > +                        test->migrate_fail ? "failed" : "compl=
eted");
> > > > > +    }
> > > > > +    qobject_unref(rsp_return);
> > > > > +
> > > > > +    if (stop) {
> > > > > +        g_main_loop_quit(test->loop);
> > > > > +    }
> > > > > +    return stop ? G_SOURCE_REMOVE : G_SOURCE_CONTINUE;
> > > > > +}
> > > > > +
> > > > > +static void migrate(QTestState *who, const char *uri)
> > > > > +{
> > > > > +    QDict *args, *rsp;
> > > > > +
> > > > > +    args =3D qdict_new();
> > > > > +    qdict_put_str(args, "uri", uri);
> > > > > +
> > > > > +    rsp =3D qtest_qmp(who, "{ 'execute': 'migrate', 'arguments=
': %p }", args);
> > > > > +
> > > > > +    g_assert(qdict_haskey(rsp, "return"));
> > > > > +    qobject_unref(rsp);
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +test_dbus_vmstate(Test *test)
> > > > > +{
> > > > > +    QTestState *src_qemu =3D NULL, *dst_qemu =3D NULL;
> > > > > +    char *src_qemu_args =3D NULL, *dst_qemu_args =3D NULL;
> > > > > +    char *uri =3D g_strdup_printf("unix:%s/migsocket", workdir=
);
> > > > > +    GThread *t =3D g_thread_new("dbus", dbus_thread, test);
> > > > > +
> > > > > +    g_mutex_lock(&mutex);
> > > > > +    while (!test->dbus_loop) {
> > > > > +        g_cond_wait(&cond, &mutex);
> > > > > +    }
> > > > > +
> > > > > +    src_qemu_args =3D
> > > > > +        g_strdup_printf("-object dbus-vmstate,id=3DdvA,addr=3D=
%s "
> > > > > +                        "-object dbus-vmstate,id=3DdvB,addr=3D=
%s",
> > > > > +                        g_dbus_server_get_client_address(test-=
>srcA.server),
> > > > > +                        g_dbus_server_get_client_address(test-=
>srcB.server));
> > > > > +
> > > > > +
> > > > > +    dst_qemu_args =3D
> > > > > +        g_strdup_printf("-object dbus-vmstate,id=3DdvA,addr=3D=
%s "
> > > > > +                        "-object dbus-vmstate,id=3DdvB,addr=3D=
%s "
> > > > > +                        "-incoming %s",
> > > > > +                        g_dbus_server_get_client_address(test-=
>dstA.server),
> > > > > +                        g_dbus_server_get_client_address(test-=
>dstB.server),
> > > > > +                        uri);
> > > > > +
> > > > > +    src_qemu =3D qtest_init(src_qemu_args);
> > > > > +    dst_qemu =3D qtest_init(dst_qemu_args);
> > > > > +
> > > > > +    test->loop =3D g_main_loop_new(NULL, TRUE);
> > > > > +
> > > > > +    migrate(src_qemu, uri);
> > > > > +    test->src_qemu =3D src_qemu;
> > > > > +    g_timeout_add_seconds(1, wait_for_migration_complete, test=
);
> > > > > +
> > > > > +    g_main_loop_run(test->loop);
> > > > > +    g_main_loop_unref(test->loop);
> > > > > +
> > > > > +    g_free(uri);
> > > > > +    qtest_quit(dst_qemu);
> > > > > +    qtest_quit(src_qemu);
> > > > > +    g_free(dst_qemu_args);
> > > > > +    g_free(src_qemu_args);
> > > > > +
> > > > > +    g_main_loop_quit(test->dbus_loop);
> > > > > +    g_mutex_unlock(&mutex);
> > > > > +
> > > > > +    g_thread_join(t);
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +check_migrated(TestServer *s, TestServer *d)
> > > > > +{
> > > > > +    assert(s->save_called);
> > > > > +    assert(!s->load_called);
> > > > > +    assert(!d->save_called);
> > > > > +    assert(d->load_called);
> > > > > +}
> > > > > +
> > > > > +static void
> > > > > +test_dbus_vmstate_migrate(void)
> > > > > +{
> > > > > +    Test test =3D { };
> > > > > +
> > > > > +    test_dbus_vmstate(&test);
> > > > > +
> > > > > +    check_migrated(&test.srcA, &test.dstA);
> > > > > +    check_migrated(&test.srcB, &test.dstB);
> > > > > +}
> > > > > +
> > > > > +int
> > > > > +main(int argc, char **argv)
> > > > > +{
> > > > > +    GError *err =3D NULL;
> > > > > +    int ret;
> > > > > +
> > > > > +    g_test_init(&argc, &argv, NULL);
> > > > > +
> > > > > +    workdir =3D g_dir_make_tmp("dbus-vmstate-test-XXXXXX", &er=
r);
> > > > > +    if (!workdir) {
> > > > > +        g_error("Unable to create temporary dir: %s\n", err->m=
essage);
> > > > > +    }
> > > > > +
> > > > > +    qtest_add_func("/dbus-vmstate/migrate",
> > > > > +                   test_dbus_vmstate_migrate);
> > > > > +
> > > > > +    ret =3D g_test_run();
> > > > > +
> > > > > +    rmdir(workdir);
> > > > > +    g_free(workdir);
> > > > > +
> > > > > +    return ret;
> > > > > +}
> > > > > diff --git a/tests/dbus-vmstate1.xml b/tests/dbus-vmstate1.xml
> > > > > new file mode 100644
> > > > > index 0000000000..cc8563be4c
> > > > > --- /dev/null
> > > > > +++ b/tests/dbus-vmstate1.xml
> > > > > @@ -0,0 +1,12 @@
> > > > > +<?xml version=3D"1.0"?>
> > > > > +<node name=3D"/" xmlns:doc=3D"http://www.freedesktop.org/dbus/=
1.0/doc.dtd">
> > > > > +  <interface name=3D"org.qemu.VMState1">
> > > > > +    <property name=3D"Id" type=3D"s" access=3D"read"/>
> > > > > +    <method name=3D"Load">
> > > > > +      <arg type=3D"ay" name=3D"data" direction=3D"in"/>
> > > > > +    </method>
> > > > > +    <method name=3D"Save">
> > > > > +      <arg type=3D"ay" name=3D"data" direction=3D"out"/>
> > > > > +    </method>
> > > > > +  </interface>
> > > > > +</node>
> > > > > --
> > > > > 2.23.0.rc1
> > > > >
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

