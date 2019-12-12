Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A4BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB4C206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUtzDqmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB4C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNK1-0001BU-Um
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ifNJM-0000ja-1y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ifNJJ-0004u1-Pl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:11:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ifNJJ-0004tI-Hj
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576152672;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMEuB7KR38lfMU73IBaRhz55pemBH6tnc55Pn11AZgQ=;
 b=RUtzDqmt9XK6Y0jpekz0Tco3MCRyqaX4eR/BUhsZNJH340i2R1MI0NtNj2vAIUMxCblEWe
 idgV0MWpDwwkGT5wJDH/GUzBu9RZvRWU6AQNrZqPlht8fV8xnuZ3MEuQrsK0rOl6FSGVwd
 wNeGP/PIwlLJlbt8Sn3cJx5Lfvrn4x4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-aN81MR4qPiihr1c-zEy9HA-1; Thu, 12 Dec 2019 07:11:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 244ECDBA7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 12:11:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A76425D9C9;
 Thu, 12 Dec 2019 12:11:05 +0000 (UTC)
Date: Thu, 12 Dec 2019 12:11:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v6 8/8] tests: add dbus-vmstate-test
Message-ID: <20191212121103.GL1829331@redhat.com>
References: <20191211134506.1803403-1-marcandre.lureau@redhat.com>
 <20191211134506.1803403-9-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191211134506.1803403-9-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: aN81MR4qPiihr1c-zEy9HA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On Wed, Dec 11, 2019 at 05:45:06PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS                  |   1 +
>  tests/Makefile.include       |  22 +-
>  tests/dbus-vmstate-daemon.sh |  95 +++++++++
>  tests/dbus-vmstate-test.c    | 399 +++++++++++++++++++++++++++++++++++
>  tests/dbus-vmstate1.xml      |  12 ++
>  5 files changed, 528 insertions(+), 1 deletion(-)
>  create mode 100755 tests/dbus-vmstate-daemon.sh
>  create mode 100644 tests/dbus-vmstate-test.c
>  create mode 100644 tests/dbus-vmstate1.xml
>=20
> +write_config()
> +{
> +    CONF=3D"$1"
> +    cat > "$CONF" <<EOF
> +<busconfig>
> +  <type>session</type>
> +  <listen>unix:tmpdir=3D/tmp</listen>

I'd expect us to make it create any files in the builddir.
If we must use a global dir, then it should be a unique
temp dir created just for this test - can we subsitute
in the temp dir we create later on in this patch

> +
> +  <policy context=3D"default">
> +     <!-- Holes must be punched in service configuration files for
> +          name ownership and sending method calls -->
> +     <deny own=3D"*"/>
> +     <deny send_type=3D"method_call"/>
> +
> +     <!-- Signals and reply messages (method returns, errors) are allowe=
d
> +          by default -->
> +     <allow send_type=3D"signal"/>
> +     <allow send_requested_reply=3D"true" send_type=3D"method_return"/>
> +     <allow send_requested_reply=3D"true" send_type=3D"error"/>
> +
> +     <!-- All messages may be received by default -->
> +     <allow receive_type=3D"method_call"/>
> +     <allow receive_type=3D"method_return"/>
> +     <allow receive_type=3D"error"/>
> +     <allow receive_type=3D"signal"/>
> +
> +     <!-- Allow anyone to talk to the message bus -->
> +     <allow send_destination=3D"org.freedesktop.DBus"
> +            send_interface=3D"org.freedesktop.DBus" />
> +     <allow send_destination=3D"org.freedesktop.DBus"
> +            send_interface=3D"org.freedesktop.DBus.Introspectable"/>
> +     <allow send_destination=3D"org.freedesktop.DBus"
> +            send_interface=3D"org.freedesktop.DBus.Properties"/>
> +     <!-- But disallow some specific bus services -->
> +     <deny send_destination=3D"org.freedesktop.DBus"
> +           send_interface=3D"org.freedesktop.DBus"
> +           send_member=3D"UpdateActivationEnvironment"/>
> +     <deny send_destination=3D"org.freedesktop.DBus"
> +           send_interface=3D"org.freedesktop.DBus.Debug.Stats"/>
> +     <deny send_destination=3D"org.freedesktop.DBus"
> +           send_interface=3D"org.freedesktop.systemd1.Activator"/>
> +
> +     <allow own=3D"org.qemu.VMState1"/>
> +     <allow send_destination=3D"org.qemu.VMState1"/>
> +     <allow receive_sender=3D"org.qemu.VMState1"/>
> +
> +  </policy>
> +
> +  <include if_selinux_enabled=3D"yes"
> +   selinux_root_relative=3D"yes">contexts/dbus_contexts</include>
> +
> +</busconfig>
> +EOF
> +}
> +
> +ARGS=3D
> +for arg in "$@"
> +do
> +    case $arg in
> +        --config-file=3D*)
> +          CONF=3D"${arg#*=3D}"
> +          write_config "$CONF"
> +          ARGS=3D"$ARGS $1"
> +          shift
> +        ;;
> +        *)
> +          ARGS=3D"$ARGS $1"
> +          shift
> +        ;;
> +    esac
> +done
> +
> +exec dbus-daemon $ARGS
> diff --git a/tests/dbus-vmstate-test.c b/tests/dbus-vmstate-test.c
> new file mode 100644
> index 0000000000..34818c1e79
> --- /dev/null
> +++ b/tests/dbus-vmstate-test.c
> @@ -0,0 +1,399 @@
> +#include "qemu/osdep.h"
> +#include <glib/gstdio.h>
> +#include <gio/gio.h>
> +#include "libqtest.h"
> +#include "qemu-common.h"
> +#include "dbus-vmstate1.h"
> +
> +static char *workdir;
> +
> +typedef struct TestServerId {
> +    const char *name;
> +    const char *data;
> +    size_t size;
> +} TestServerId;
> +
> +static const TestServerId idA =3D {
> +    "idA", "I'am\0idA!", sizeof("I'am\0idA!")
> +};
> +
> +static const TestServerId idB =3D {
> +    "idB", "I'am\0idB!", sizeof("I'am\0idB!")
> +};
> +
> +typedef struct TestServer {
> +    const TestServerId *id;
> +    bool save_called;
> +    bool load_called;
> +} TestServer;
> +
> +typedef struct Test {
> +    const char *id_list;
> +    bool migrate_fail;
> +    bool without_dst_b;
> +    TestServer srcA;
> +    TestServer dstA;
> +    TestServer srcB;
> +    TestServer dstB;
> +    GMainLoop *loop;
> +    QTestState *src_qemu;
> +} Test;
> +
> +static gboolean
> +vmstate_load(VMState1 *object, GDBusMethodInvocation *invocation,
> +             const gchar *arg_data, gpointer user_data)
> +{
> +    TestServer *h =3D user_data;
> +    g_autoptr(GVariant) var =3D NULL;
> +    GVariant *args;
> +    const uint8_t *data;
> +    size_t size;
> +
> +    args =3D g_dbus_method_invocation_get_parameters(invocation);
> +    var =3D g_variant_get_child_value(args, 0);
> +    data =3D g_variant_get_fixed_array(var, &size, sizeof(char));
> +    g_assert_cmpuint(size, =3D=3D, h->id->size);
> +    g_assert(!memcmp(data, h->id->data, h->id->size));
> +    h->load_called =3D true;
> +
> +    g_dbus_method_invocation_return_value(invocation, g_variant_new("()"=
));
> +    return TRUE;
> +}
> +
> +static gboolean
> +vmstate_save(VMState1 *object, GDBusMethodInvocation *invocation,
> +             gpointer user_data)
> +{
> +    TestServer *h =3D user_data;
> +    GVariant *var;
> +
> +    var =3D g_variant_new_fixed_array(G_VARIANT_TYPE_BYTE,
> +                                    h->id->data, h->id->size, sizeof(cha=
r));
> +    g_dbus_method_invocation_return_value(invocation,
> +                                          g_variant_new("(@ay)", var));
> +    h->save_called =3D true;
> +
> +    return TRUE;
> +}
> +
> +static gboolean
> +wait_for_migration_complete(gpointer user_data)
> +{
> +    Test *test =3D user_data;
> +    QDict *rsp_return;
> +    bool stop =3D false;
> +    const char *status;
> +
> +    qtest_qmp_send(test->src_qemu, "{ 'execute': 'query-migrate' }");
> +    rsp_return =3D qtest_qmp_receive_success(test->src_qemu, NULL, NULL)=
;
> +    status =3D qdict_get_str(rsp_return, "status");
> +    if (g_str_equal(status, "completed") || g_str_equal(status, "failed"=
)) {
> +        stop =3D true;
> +        g_assert_cmpstr(status, =3D=3D,
> +                        test->migrate_fail ? "failed" : "completed");
> +    }
> +    qobject_unref(rsp_return);
> +
> +    if (stop) {
> +        g_main_loop_quit(test->loop);
> +    }
> +    return stop ? G_SOURCE_REMOVE : G_SOURCE_CONTINUE;
> +}
> +
> +static void migrate(QTestState *who, const char *uri)
> +{
> +    QDict *args, *rsp;
> +
> +    args =3D qdict_new();
> +    qdict_put_str(args, "uri", uri);
> +
> +    rsp =3D qtest_qmp(who, "{ 'execute': 'migrate', 'arguments': %p }", =
args);
> +
> +    g_assert(qdict_haskey(rsp, "return"));
> +    qobject_unref(rsp);
> +}
> +
> +typedef struct WaitNamed {
> +    GMainLoop *loop;
> +    bool named;
> +} WaitNamed;
> +
> +static void
> +named_cb(GDBusConnection *connection,
> +         const gchar *name,
> +         gpointer user_data)
> +{
> +    WaitNamed *t =3D user_data;
> +
> +    t->named =3D true;
> +    g_main_loop_quit(t->loop);
> +}
> +
> +static GDBusConnection *
> +get_connection(Test *test, guint *ownid)
> +{
> +    g_autofree gchar *addr =3D NULL;
> +    WaitNamed *wait;
> +    GError *err =3D NULL;
> +    GDBusConnection *c;
> +
> +    wait =3D g_new0(WaitNamed, 1);
> +    wait->loop =3D test->loop;
> +    addr =3D g_dbus_address_get_for_bus_sync(G_BUS_TYPE_SESSION, NULL, &=
err);
> +    g_assert_no_error(err);
> +
> +    c =3D g_dbus_connection_new_for_address_sync(
> +        addr,
> +        G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION |
> +        G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT,
> +        NULL, NULL, &err);
> +    g_assert_no_error(err);
> +    *ownid =3D g_bus_own_name_on_connection(c, "org.qemu.VMState1",
> +                                          G_BUS_NAME_OWNER_FLAGS_NONE,
> +                                          named_cb, named_cb, wait, g_fr=
ee);
> +    if (!wait->named) {
> +        g_main_loop_run(wait->loop);
> +    }
> +
> +    return c;
> +}
> +
> +static GDBusObjectManagerServer *
> +get_server(GDBusConnection *conn, TestServer *s, const TestServerId *id)
> +{
> +    g_autoptr(GDBusObjectSkeleton) sk =3D NULL;
> +    g_autoptr(VMState1Skeleton) v =3D NULL;
> +    GDBusObjectManagerServer *os;
> +
> +    s->id =3D id;
> +    os =3D g_dbus_object_manager_server_new("/org/qemu");
> +    sk =3D g_dbus_object_skeleton_new("/org/qemu/VMState1");
> +
> +    v =3D VMSTATE1_SKELETON(vmstate1_skeleton_new());
> +    g_object_set(v, "id", id->name, NULL);
> +
> +    g_signal_connect(v, "handle-load", G_CALLBACK(vmstate_load), s);
> +    g_signal_connect(v, "handle-save", G_CALLBACK(vmstate_save), s);
> +
> +    g_dbus_object_skeleton_add_interface(sk, G_DBUS_INTERFACE_SKELETON(v=
));
> +    g_dbus_object_manager_server_export(os, sk);
> +    g_dbus_object_manager_server_set_connection(os, conn);
> +
> +    return os;
> +}
> +
> +static void
> +set_id_list(Test *test, QTestState *s)
> +{
> +    if (!test->id_list) {
> +        return;
> +    }
> +
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(s,
> +        "{ 'execute': 'qom-set', 'arguments': "
> +        "{ 'path': '/objects/dv', 'property': 'id-list', 'value': %s } }=
",
> +        test->id_list)));
> +}
> +static void
> +test_dbus_vmstate(Test *test)
> +{
> +    g_autofree char *src_qemu_args =3D NULL;
> +    g_autofree char *dst_qemu_args =3D NULL;
> +    g_autoptr(GTestDBus) srcbus =3D NULL;
> +    g_autoptr(GTestDBus) dstbus =3D NULL;
> +    g_autoptr(GDBusConnection) srcconnA =3D NULL;
> +    g_autoptr(GDBusConnection) srcconnB =3D NULL;
> +    g_autoptr(GDBusConnection) dstconnA =3D NULL;
> +    g_autoptr(GDBusConnection) dstconnB =3D NULL;
> +    g_autoptr(GDBusObjectManagerServer) srcserverA =3D NULL;
> +    g_autoptr(GDBusObjectManagerServer) srcserverB =3D NULL;
> +    g_autoptr(GDBusObjectManagerServer) dstserverA =3D NULL;
> +    g_autoptr(GDBusObjectManagerServer) dstserverB =3D NULL;
> +    g_auto(GStrv) srcaddr =3D NULL;
> +    g_auto(GStrv) dstaddr =3D NULL;
> +    g_autofree char *uri =3D NULL;
> +    QTestState *src_qemu =3D NULL, *dst_qemu =3D NULL;
> +    guint ownsrcA, ownsrcB, owndstA, owndstB;
> +
> +    uri =3D g_strdup_printf("unix:%s/migsocket", workdir);
> +
> +    test->loop =3D g_main_loop_new(NULL, TRUE);
> +
> +    srcbus =3D g_test_dbus_new(G_TEST_DBUS_NONE);
> +    g_test_dbus_up(srcbus);
> +    srcconnA =3D get_connection(test, &ownsrcA);
> +    srcserverA =3D get_server(srcconnA, &test->srcA, &idA);
> +    srcconnB =3D get_connection(test, &ownsrcB);
> +    srcserverB =3D get_server(srcconnB, &test->srcB, &idB);
> +
> +    /* remove ,guid=3Dfoo part */
> +    srcaddr =3D g_strsplit(g_test_dbus_get_bus_address(srcbus), ",", 2);
> +    src_qemu_args =3D
> +        g_strdup_printf("-object dbus-vmstate,id=3Ddv,addr=3D%s", srcadd=
r[0]);
> +
> +    dstbus =3D g_test_dbus_new(G_TEST_DBUS_NONE);
> +    g_test_dbus_up(dstbus);
> +    dstconnA =3D get_connection(test, &owndstA);
> +    dstserverA =3D get_server(dstconnA, &test->dstA, &idA);
> +    if (!test->without_dst_b) {
> +        dstconnB =3D get_connection(test, &owndstB);
> +        dstserverB =3D get_server(dstconnB, &test->dstB, &idB);
> +    }
> +
> +    dstaddr =3D g_strsplit(g_test_dbus_get_bus_address(dstbus), ",", 2);
> +    dst_qemu_args =3D
> +        g_strdup_printf("-object dbus-vmstate,id=3Ddv,addr=3D%s -incomin=
g %s",
> +                        dstaddr[0], uri);
> +
> +    src_qemu =3D qtest_init(src_qemu_args);
> +    dst_qemu =3D qtest_init(dst_qemu_args);
> +    set_id_list(test, src_qemu);
> +    set_id_list(test, dst_qemu);
> +
> +    migrate(src_qemu, uri);
> +    test->src_qemu =3D src_qemu;
> +    g_timeout_add_seconds(1, wait_for_migration_complete, test);
> +
> +    g_main_loop_run(test->loop);
> +    g_main_loop_unref(test->loop);
> +
> +    if (test->migrate_fail) {
> +        qtest_set_expected_status(dst_qemu, 1);
> +    }
> +    qtest_quit(dst_qemu);
> +    qtest_quit(src_qemu);
> +    g_bus_unown_name(ownsrcA);
> +    g_bus_unown_name(ownsrcB);
> +    g_bus_unown_name(owndstA);
> +    if (!test->without_dst_b) {
> +        g_bus_unown_name(owndstB);
> +    }
> +}
> +
> +static void
> +check_not_migrated(TestServer *s, TestServer *d)
> +{
> +    assert(!s->save_called);
> +    assert(!s->load_called);
> +    assert(!d->save_called);
> +    assert(!d->load_called);
> +}
> +
> +static void
> +check_migrated(TestServer *s, TestServer *d)
> +{
> +    assert(s->save_called);
> +    assert(!s->load_called);
> +    assert(!d->save_called);
> +    assert(d->load_called);
> +}
> +
> +static void
> +test_dbus_vmstate_without_list(void)
> +{
> +    Test test =3D { 0, };
> +
> +    test_dbus_vmstate(&test);
> +
> +    check_migrated(&test.srcA, &test.dstA);
> +    check_migrated(&test.srcB, &test.dstB);
> +}
> +
> +static void
> +test_dbus_vmstate_with_list(void)
> +{
> +    Test test =3D { .id_list =3D "idA,idB" };
> +
> +    test_dbus_vmstate(&test);
> +
> +    check_migrated(&test.srcA, &test.dstA);
> +    check_migrated(&test.srcB, &test.dstB);
> +}
> +
> +static void
> +test_dbus_vmstate_only_a(void)
> +{
> +    Test test =3D { .id_list =3D "idA" };
> +
> +    test_dbus_vmstate(&test);
> +
> +    check_migrated(&test.srcA, &test.dstA);
> +    check_not_migrated(&test.srcB, &test.dstB);
> +}
> +
> +static void
> +test_dbus_vmstate_missing_src(void)
> +{
> +    Test test =3D { .id_list =3D "idA,idC", .migrate_fail =3D true };
> +
> +    /* run in subprocess to silence QEMU error reporting */
> +    if (g_test_subprocess()) {
> +        test_dbus_vmstate(&test);
> +        check_not_migrated(&test.srcA, &test.dstA);
> +        check_not_migrated(&test.srcB, &test.dstB);
> +        return;
> +    }
> +
> +    g_test_trap_subprocess(NULL, 0, 0);
> +    g_test_trap_assert_passed();
> +}
> +
> +static void
> +test_dbus_vmstate_missing_dst(void)
> +{
> +    Test test =3D { .id_list =3D "idA,idB",
> +                  .without_dst_b =3D true,
> +                  .migrate_fail =3D true };
> +
> +    /* run in subprocess to silence QEMU error reporting */
> +    if (g_test_subprocess()) {
> +        test_dbus_vmstate(&test);
> +        assert(test.srcA.save_called);
> +        assert(test.srcB.save_called);
> +        assert(!test.dstB.save_called);
> +        return;
> +    }
> +
> +    g_test_trap_subprocess(NULL, 0, 0);
> +    g_test_trap_assert_passed();
> +}
> +
> +int
> +main(int argc, char **argv)
> +{
> +    GError *err =3D NULL;
> +    g_autofree char *dbus_daemon =3D NULL;
> +    int ret;
> +
> +    dbus_daemon =3D g_build_filename(G_STRINGIFY(SRCDIR),
> +                                   "tests",
> +                                   "dbus-vmstate-daemon.sh",
> +                                   NULL);
> +    g_setenv("G_TEST_DBUS_DAEMON", dbus_daemon, true);
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    workdir =3D g_dir_make_tmp("dbus-vmstate-test-XXXXXX", &err);
> +    if (!workdir) {
> +        g_error("Unable to create temporary dir: %s\n", err->message);
> +        exit(1);
> +    }
> +
> +    qtest_add_func("/dbus-vmstate/without-list",
> +                   test_dbus_vmstate_without_list);
> +    qtest_add_func("/dbus-vmstate/with-list",
> +                   test_dbus_vmstate_with_list);
> +    qtest_add_func("/dbus-vmstate/only-a",
> +                   test_dbus_vmstate_only_a);
> +    qtest_add_func("/dbus-vmstate/missing-src",
> +                   test_dbus_vmstate_missing_src);
> +    qtest_add_func("/dbus-vmstate/missing-dst",
> +                   test_dbus_vmstate_missing_dst);
> +
> +    ret =3D g_test_run();
> +
> +    rmdir(workdir);
> +    g_free(workdir);
> +
> +    return ret;
> +}
> diff --git a/tests/dbus-vmstate1.xml b/tests/dbus-vmstate1.xml
> new file mode 100644
> index 0000000000..cc8563be4c
> --- /dev/null
> +++ b/tests/dbus-vmstate1.xml
> @@ -0,0 +1,12 @@
> +<?xml version=3D"1.0"?>
> +<node name=3D"/" xmlns:doc=3D"http://www.freedesktop.org/dbus/1.0/doc.dt=
d">
> +  <interface name=3D"org.qemu.VMState1">
> +    <property name=3D"Id" type=3D"s" access=3D"read"/>
> +    <method name=3D"Load">
> +      <arg type=3D"ay" name=3D"data" direction=3D"in"/>
> +    </method>
> +    <method name=3D"Save">
> +      <arg type=3D"ay" name=3D"data" direction=3D"out"/>
> +    </method>
> +  </interface>
> +</node>
> --=20
> 2.24.0.308.g228f53135a
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


