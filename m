Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C15C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D0920728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/8DM8S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D0920728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRtly-0002iK-Ra
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 04:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRtkp-00029g-4t
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRtkb-0004Fm-59
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:32:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRtka-000451-KM
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587717114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2olGHbF3hIqN9XwNSRtM7q9Nwj0CY5NbWRJftaJXp8=;
 b=Y/8DM8S6bp+UiLtZudVJ83RiYAwg9G+w0EE4XJ3oHpyLCXC7oOaK1WILFrqTpz7n/GcE48
 ANIxQfb7R+CD2Jr1UTL3gCjP3enSkyHvRXVZxa7awvQudx+xAjdq6nLFD4f/YKIBGDUGSO
 Hb9SBovz6RJnpYW+JYH0eN7y69nkOkE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-zgvjBFHcOyWhEVOMGd3daQ-1; Fri, 24 Apr 2020 04:31:43 -0400
X-MC-Unique: zgvjBFHcOyWhEVOMGd3daQ-1
Received: by mail-wr1-f72.google.com with SMTP id s11so4422179wru.6
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 01:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qP+shrjP3Tzz96hvGQAWHxsLEIJs+QOof3+s4ooOPi8=;
 b=LzqWepttjyUSUPOb2GHnI9ixDIRkg/ME52oWkeRBNC62utZ7wSmTm6AdGEiSs1mvcg
 k69FiAsmPUteJJyX/ettLPNGlpVguVOIs+UL/yuVT0+w5eyWjdVhQeJx91B4b9cvFKhB
 JZFBWAsTfzoiEIUBRBvP/yUu9uFwp9W1LTeDEc6sFenxG+cchw2qEw9PwuSYOw9OREXA
 8LVrlPIyMhXRzi1ve2TTq27QjN8dSzVYQjUIxwMb43FAPtpOdQwAGptRxLZ7+0WVTq4Z
 tpEgMsYVuj9M6SJmL7yBUxO3yDN0HAdrMCFppnATSlnLg+CUBCuRO6nrb2b0dMnuCeb4
 THNg==
X-Gm-Message-State: AGi0PuZrnD4FxdEJ80FCr5jUUQkoGhuB7RPLedxXnkNHTRv9pfXhqYNW
 2yV3X7h4m51IkfWevGLjRNGxRoxMmTWF2YP5+BqLlnDg8BRCnFY+yVo2OoA7P0FF6cIwSxtF+t8
 v1vzJ7F/ROTbs8xU=
X-Received: by 2002:adf:f881:: with SMTP id u1mr9490789wrp.348.1587717101903; 
 Fri, 24 Apr 2020 01:31:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypKmjKOVhhGNE+modnVN23Cfo/mENDU6VUejtJtDJUiSxAJ6bk+bPTIhlXALoqlCmDsfXr6bJQ==
X-Received: by 2002:adf:f881:: with SMTP id u1mr9490759wrp.348.1587717101621; 
 Fri, 24 Apr 2020 01:31:41 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id i6sm7875367wrc.82.2020.04.24.01.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 01:31:40 -0700 (PDT)
Subject: Re: [PATCH 2/3] fuzz: Simplify how we compute available machines and
 types
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200424071142.3525-1-armbru@redhat.com>
 <20200424071142.3525-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f5b650a0-13cb-cceb-0064-304893808f35@redhat.com>
Date: Fri, 24 Apr 2020 10:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200424071142.3525-3-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: lvivier@redhat.com, thuth@redhat.com, alxndr@bu.edu, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 9:11 AM, Markus Armbruster wrote:
> apply_to_qlist(), apply_to_node() work with QObjects.  This is
> designed for use by tests/qtest/qos-test.c, which gets the data in
> that form via QMP.  Goes back to commit fc281c8020 "tests: qgraph API
> for the qtest driver framework".
>=20
> Commit 275ab39d86 "fuzz: add support for qos-assisted fuzz targets"
> added another user: qtest/fuzz/qos_fuzz.c.  To get the data as
> QObjects, it uses qmp_marshal_query_machines() and
> qmp_marshal_qom_list_types().
>=20
> All this code is rather cumbersome.  Switch to working with generated
> QAPI types instead:
>=20
> * Replace apply_to_qlist() & friends by machines_apply_to_node() and
>    types_apply_to_node().
>=20
> * Have qos_fuzz.c use qmp_query_machines() and qmp_qom_list_types()
>    instead.
>=20
> * Have qos_test.c convert from QObject to the QAPI types.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/qtest/libqos/qos_external.h |  8 +++-
>   tests/qtest/fuzz/qos_fuzz.c       | 34 ++++-----------
>   tests/qtest/libqos/qos_external.c | 70 +++++++++++--------------------
>   tests/qtest/qos-test.c            | 29 +++++++++----
>   4 files changed, 59 insertions(+), 82 deletions(-)
>=20
> diff --git a/tests/qtest/libqos/qos_external.h b/tests/qtest/libqos/qos_e=
xternal.h
> index 7b44930c55..f63388cb30 100644
> --- a/tests/qtest/libqos/qos_external.h
> +++ b/tests/qtest/libqos/qos_external.h
> @@ -20,8 +20,12 @@
>   #define QOS_EXTERNAL_H
>   #include "libqos/qgraph.h"
>  =20
> -void apply_to_node(const char *name, bool is_machine, bool is_abstract);
> -void apply_to_qlist(QList *list, bool is_machine);
> +#include "libqos/malloc.h"
> +#include "qapi/qapi-types-machine.h"
> +#include "qapi/qapi-types-qom.h"
> +
> +void machines_apply_to_node(MachineInfoList *mach_info);
> +void types_apply_to_node(ObjectTypeInfoList *type_info);
>   QGuestAllocator *get_machine_allocator(QOSGraphObject *obj);
>   void *allocate_objects(QTestState *qts, char **path, QGuestAllocator **=
p_alloc);
>  =20
> diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
> index af28c92866..87eadb0889 100644
> --- a/tests/qtest/fuzz/qos_fuzz.c
> +++ b/tests/qtest/fuzz/qos_fuzz.c
> @@ -36,7 +36,6 @@
>  =20
>   #include "qapi/qapi-commands-machine.h"
>   #include "qapi/qapi-commands-qom.h"
> -#include "qapi/qmp/qlist.h"
>  =20
>  =20
>   void *fuzz_qos_obj;
> @@ -45,34 +44,19 @@ QGuestAllocator *fuzz_qos_alloc;
>   static const char *fuzz_target_name;
>   static char **fuzz_path_vec;
>  =20
> -/*
> - * Replaced the qmp commands with direct qmp_marshal calls.
> - * Probably there is a better way to do this
> - */
>   static void qos_set_machines_devices_available(void)
>   {
> -    QDict *req =3D qdict_new();
> -    QObject *response;
> -    QDict *args =3D qdict_new();
> -    QList *lst;
> +    MachineInfoList *mach_info;
> +    ObjectTypeInfoList *type_info;
>  =20
> -    qmp_marshal_query_machines(NULL, &response, &error_abort);
> -    lst =3D qobject_to(QList, response);
> -    apply_to_qlist(lst, true);
> +    mach_info =3D qmp_query_machines(&error_abort);
> +    machines_apply_to_node(mach_info);
> +    qapi_free_MachineInfoList(mach_info);
>  =20
> -    qobject_unref(response);
> -
> -
> -    qdict_put_str(req, "execute", "qom-list-types");
> -    qdict_put_str(args, "implements", "device");
> -    qdict_put_bool(args, "abstract", true);
> -    qdict_put_obj(req, "arguments", (QObject *) args);
> -
> -    qmp_marshal_qom_list_types(args, &response, &error_abort);
> -    lst =3D qobject_to(QList, response);
> -    apply_to_qlist(lst, false);
> -    qobject_unref(response);
> -    qobject_unref(req);
> +    type_info =3D qmp_qom_list_types(true, "device", true, true,
> +                                   &error_abort);

Glad you had interest in cleaning this.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I tried to do a similar cleanup on the Python side, but didn't feel much=20
support and ended up disabling s390x/ppc tests instead.
https://www.mail-archive.com/qemu-devel@nongnu.org/msg675074.html

> +    types_apply_to_node(type_info);
> +    qapi_free_ObjectTypeInfoList(type_info);
>   }
>  =20
>   static char **current_path;
> diff --git a/tests/qtest/libqos/qos_external.c b/tests/qtest/libqos/qos_e=
xternal.c
> index 398556dde0..c707dac3b9 100644
> --- a/tests/qtest/libqos/qos_external.c
> +++ b/tests/qtest/libqos/qos_external.c
> @@ -29,62 +29,40 @@
>   #include "libqos/qgraph_internal.h"
>   #include "libqos/qos_external.h"
>  =20
> -
> -
> -void apply_to_node(const char *name, bool is_machine, bool is_abstract)
> +static void machine_apply_to_node(const char *name)
>   {
> -    char *machine_name =3D NULL;
> -    if (is_machine) {
> -        const char *arch =3D qtest_get_arch();
> -        machine_name =3D g_strconcat(arch, "/", name, NULL);
> -        name =3D machine_name;
> +    char *machine_name =3D g_strconcat(qtest_get_arch(), "/", name, NULL=
);
> +
> +    qos_graph_node_set_availability(machine_name, true);
> +    g_free(machine_name);
> +}
> +
> +void machines_apply_to_node(MachineInfoList *mach_info)
> +{
> +    MachineInfoList *tail;
> +
> +    for (tail =3D mach_info; tail; tail =3D tail->next) {
> +        machine_apply_to_node(tail->value->name);
> +        if (tail->value->alias) {
> +            machine_apply_to_node(tail->value->alias);
> +        }
>       }
> +}
> +
> +static void type_apply_to_node(const char *name, bool is_abstract)
> +{
>       qos_graph_node_set_availability(name, true);
>       if (is_abstract) {
>           qos_delete_cmd_line(name);
>       }
> -    g_free(machine_name);
>   }
>  =20
> -/**
> - * apply_to_qlist(): using QMP queries QEMU for a list of
> - * machines and devices available, and sets the respective node
> - * as true. If a node is found, also all its produced and contained
> - * child are marked available.
> - *
> - * See qos_graph_node_set_availability() for more info
> - */
> -void apply_to_qlist(QList *list, bool is_machine)
> +void types_apply_to_node(ObjectTypeInfoList *type_info)
>   {
> -    const QListEntry *p;
> -    const char *name;
> -    bool abstract;
> -    QDict *minfo;
> -    QObject *qobj;
> -    QString *qstr;
> -    QBool *qbool;
> +    ObjectTypeInfoList *tail;
>  =20
> -    for (p =3D qlist_first(list); p; p =3D qlist_next(p)) {
> -        minfo =3D qobject_to(QDict, qlist_entry_obj(p));
> -        qobj =3D qdict_get(minfo, "name");
> -        qstr =3D qobject_to(QString, qobj);
> -        name =3D qstring_get_str(qstr);
> -
> -        qobj =3D qdict_get(minfo, "abstract");
> -        if (qobj) {
> -            qbool =3D qobject_to(QBool, qobj);
> -            abstract =3D qbool_get_bool(qbool);
> -        } else {
> -            abstract =3D false;
> -        }
> -
> -        apply_to_node(name, is_machine, abstract);
> -        qobj =3D qdict_get(minfo, "alias");
> -        if (qobj) {
> -            qstr =3D qobject_to(QString, qobj);
> -            name =3D qstring_get_str(qstr);
> -            apply_to_node(name, is_machine, abstract);
> -        }
> +    for (tail =3D type_info; tail; tail =3D tail->next) {
> +        type_apply_to_node(tail->value->name, tail->value->abstract);
>       }
>   }
>  =20
> diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
> index ad193f43a5..3062a13557 100644
> --- a/tests/qtest/qos-test.c
> +++ b/tests/qtest/qos-test.c
> @@ -19,11 +19,12 @@
>   #include "qemu/osdep.h"
>   #include <getopt.h>
>   #include "libqtest-single.h"
> +#include "qapi/error.h"
>   #include "qapi/qmp/qdict.h"
> -#include "qapi/qmp/qbool.h"
> -#include "qapi/qmp/qstring.h"
>   #include "qemu/module.h"
> -#include "qapi/qmp/qlist.h"
> +#include "qapi/qobject-input-visitor.h"
> +#include "qapi/qapi-visit-machine.h"
> +#include "qapi/qapi-visit-qom.h"
>   #include "libqos/malloc.h"
>   #include "libqos/qgraph.h"
>   #include "libqos/qgraph_internal.h"
> @@ -51,13 +52,20 @@ static void qos_set_machines_devices_available(void)
>   {
>       QDict *response;
>       QDict *args =3D qdict_new();
> -    QList *list;
> +    QObject *ret;
> +    Visitor *v;
> +    MachineInfoList *mach_info;
> +    ObjectTypeInfoList *type_info;
>  =20
>       qtest_start("-machine none");
>       response =3D qmp("{ 'execute': 'query-machines' }");
> -    list =3D qdict_get_qlist(response, "return");
> +    ret =3D qdict_get(response, "return");
>  =20
> -    apply_to_qlist(list, true);
> +    v =3D qobject_input_visitor_new(ret);
> +    visit_type_MachineInfoList(v, NULL, &mach_info, &error_abort);
> +    visit_free(v);
> +    machines_apply_to_node(mach_info);
> +    qapi_free_MachineInfoList(mach_info);
>  =20
>       qobject_unref(response);
>  =20
> @@ -66,10 +74,13 @@ static void qos_set_machines_devices_available(void)
>  =20
>       response =3D qmp("{'execute': 'qom-list-types',"
>                      " 'arguments': %p }", args);
> -    g_assert(qdict_haskey(response, "return"));
> -    list =3D qdict_get_qlist(response, "return");
> +    ret =3D qdict_get(response, "return");
>  =20
> -    apply_to_qlist(list, false);
> +    v =3D qobject_input_visitor_new(ret);
> +    visit_type_ObjectTypeInfoList(v, NULL, &type_info, &error_abort);
> +    visit_free(v);
> +    types_apply_to_node(type_info);
> +    qapi_free_ObjectTypeInfoList(type_info);
>  =20
>       qtest_end();
>       qobject_unref(response);
>=20


