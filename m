Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE822C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9899E20409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJSyJu8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9899E20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuI7-0004xB-PC
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtvm-0007kk-Fd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jDtvk-000303-5X
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:53:38 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jDtvj-0002qW-Q7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:53:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id a132so18689217wme.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yAqAa9sVkc8hcY/jmY7mUnM02j+UAzR9fxMYlucVpCE=;
 b=uJSyJu8M7mdOPe8Lff9G3SK8K/IcNvDYIhwZssxffA4fuz6O1XWlVvspBlw7WNaCeC
 FnsVdCIPsUJV0BV+mvazOQMCmIN1cxotD/U6YP/ys2AduHfZhBI8jZAObqD/3hABkUNx
 OErt6nN1++75dtMQ2W+R8ebf2mjIBhUbYrtttk3pNp0GY/XSpdiYxYcPVjH9bt9d49e8
 v6qno5nkYvCMyWeQO6sE41N4b4G4EdlDIJk+QJ4z1RiGIxf1FRopEH51hMZWxTedww63
 +yRbDpdoZ0GNPSHyBaw1r8CgtYxB08rp3CfbERO/8WqMVufrqlZ3cec1c62DWY6ENN3w
 V4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yAqAa9sVkc8hcY/jmY7mUnM02j+UAzR9fxMYlucVpCE=;
 b=ByXTlPvsyGXoFbiAjTX31lKTLYaWuOjz8pvGNKR6qPWq/P+/TuoFfSIgbm11ymAnh3
 ko5czP2vaEN9IEpTuoLqN+LwD/WO5xM/j3rn5aet0CAX7f3oFjotHROOZdv8kwxuX/wB
 Ji0NfykG+VoREcBub9zUwk4J8IkQKFBT/jMXlgcln2ig+6BY3uHL/vbDroIUdfnIBu5q
 EeTS+3L9SebigF+7VmYUHpHW6RErAdyXNq7uIcL6O2yb76HZIAZDGL974c5Rqe5CuWIS
 IM2tIN4kTThlIq0Q73tENrRy4AdJcnwANQ6cMV8iEHT151EGxVwZSlb1q2Fhu6TsvlAF
 rrow==
X-Gm-Message-State: ANhLgQ1Nwy635U2fkIPee8K69uqc3Xx1kOiPXUqHHE59yussXk+tTQ86
 BSv3GRdmC1qSCa3cM/occEOHUpmAS60oelKRb0U=
X-Google-Smtp-Source: ADFU+vuWRkMDbDAzPt/dfgKT0cWSQlWusF3mx3rlidarYSCPJuJDJSt89dOzP9vDcu7yswtq9eCCzlHTiDh6cxXuFls=
X-Received: by 2002:a7b:c153:: with SMTP id z19mr247782wmi.37.1584381213774;
 Mon, 16 Mar 2020 10:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-29-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-29-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Mar 2020 18:53:21 +0100
Message-ID: <CAJ+F1CLBSXK=hxSEd7odAjA3YKZfFk6+yb+kJSyOmpeC_sJrsg@mail.gmail.com>
Subject: Re: [PATCH v3 28/34] qapi: Implement deprecated-output=hide for QMP
 command results
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sun, Mar 15, 2020 at 4:11 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> This policy suppresses deprecated bits in output, and thus permits
> "testing the future".  Implement it for QMP command results.  Example:
> when QEMU is run with -compat deprecated-output=3Dhide, then
>
>     {"execute": "query-cpus-fast"}
>
> yields
>
>     {"return": [{"thread-id": 9805, "props": {"core-id": 0, "thread-id": =
0, "socket-id": 0}, "qom-path": "/machine/unattached/device[0]", "cpu-index=
": 0, "target": "x86_64"}]}
>
> instead of
>
>     {"return": [{"arch": "x86", "thread-id": 22436, "props": {"core-id": =
0, "thread-id": 0, "socket-id": 0}, "qom-path": "/machine/unattached/device=
[0]", "cpu-index": 0, "target": "x86_64"}]}
>
> Note the suppression of deprecated member "arch".
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qobject-output-visitor.h   |  9 ++++++
>  include/qapi/visitor-impl.h             |  3 ++
>  include/qapi/visitor.h                  |  9 ++++++
>  qapi/qapi-visit-core.c                  |  9 ++++++
>  qapi/qobject-output-visitor.c           | 19 +++++++++++
>  tests/test-qmp-cmds.c                   | 42 ++++++++++++++++++++++---
>  qapi/trace-events                       |  1 +
>  scripts/qapi/commands.py                |  2 +-
>  scripts/qapi/visit.py                   | 12 +++++++
>  tests/qapi-schema/qapi-schema-test.json | 17 +++++-----
>  tests/qapi-schema/qapi-schema-test.out  | 18 +++++------
>  11 files changed, 118 insertions(+), 23 deletions(-)
>
> diff --git a/include/qapi/qobject-output-visitor.h b/include/qapi/qobject=
-output-visitor.h
> index 2b1726baf5..29f4ea6aad 100644
> --- a/include/qapi/qobject-output-visitor.h
> +++ b/include/qapi/qobject-output-visitor.h
> @@ -53,4 +53,13 @@ typedef struct QObjectOutputVisitor QObjectOutputVisit=
or;
>   */
>  Visitor *qobject_output_visitor_new(QObject **result);
>
> +/*
> + * Create a QObject output visitor for @obj for use with QMP
> + *
> + * This is like qobject_output_visitor_new(), except it obeys the
> + * policy for handling deprecated management interfaces set with
> + * -compat.
> + */
> +Visitor *qobject_output_visitor_new_qmp(QObject **result);
> +
>  #endif
> diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
> index 8ccb3b6c20..a6b26b7a5b 100644
> --- a/include/qapi/visitor-impl.h
> +++ b/include/qapi/visitor-impl.h
> @@ -110,6 +110,9 @@ struct Visitor
>         The core takes care of the return type in the public interface. *=
/
>      void (*optional)(Visitor *v, const char *name, bool *present);
>
> +    /* Optional */
> +    bool (*deprecated)(Visitor *v, const char *name);
> +
>      /* Must be set */
>      VisitorType type;
>
> diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
> index c5b23851a1..c89d51b2a4 100644
> --- a/include/qapi/visitor.h
> +++ b/include/qapi/visitor.h
> @@ -449,6 +449,15 @@ void visit_end_alternate(Visitor *v, void **obj);
>   */
>  bool visit_optional(Visitor *v, const char *name, bool *present);
>
> +/*
> + * Should we visit deprecated member @name?
> + *
> + * @name must not be NULL.  This function is only useful between
> + * visit_start_struct() and visit_end_struct(), since only objects
> + * have deprecated members.
> + */
> +bool visit_deprecated(Visitor *v, const char *name);
> +
>  /*
>   * Visit an enum value.
>   *
> diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
> index 5365561b07..501b3ccdef 100644
> --- a/qapi/qapi-visit-core.c
> +++ b/qapi/qapi-visit-core.c
> @@ -137,6 +137,15 @@ bool visit_optional(Visitor *v, const char *name, bo=
ol *present)
>      return *present;
>  }
>
> +bool visit_deprecated(Visitor *v, const char *name)
> +{
> +    trace_visit_deprecated(v, name);
> +    if (v->deprecated) {
> +        return v->deprecated(v, name);
> +    }
> +    return true;
> +}
> +
>  bool visit_is_input(Visitor *v)
>  {
>      return v->type =3D=3D VISITOR_INPUT;
> diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.=
c
> index 26d7be5ec9..84cee17596 100644
> --- a/qapi/qobject-output-visitor.c
> +++ b/qapi/qobject-output-visitor.c
> @@ -13,6 +13,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qapi/compat-policy.h"
>  #include "qapi/qobject-output-visitor.h"
>  #include "qapi/visitor-impl.h"
>  #include "qemu/queue.h"
> @@ -31,6 +32,8 @@ typedef struct QStackEntry {
>
>  struct QObjectOutputVisitor {
>      Visitor visitor;
> +    CompatPolicyOutput deprecated_policy;
> +
>      QSLIST_HEAD(, QStackEntry) stack; /* Stack of unfinished containers =
*/
>      QObject *root; /* Root of the output visit */
>      QObject **result; /* User's storage location for result */
> @@ -198,6 +201,13 @@ static void qobject_output_type_null(Visitor *v, con=
st char *name,
>      qobject_output_add(qov, name, qnull());
>  }
>
> +static bool qobject_output_deprecated(Visitor *v, const char *name)
> +{
> +    QObjectOutputVisitor *qov =3D to_qov(v);
> +
> +    return qov->deprecated_policy !=3D COMPAT_POLICY_OUTPUT_HIDE;
> +}
> +
>  /* Finish building, and return the root object.
>   * The root object is never null. The caller becomes the object's
>   * owner, and should use qobject_unref() when done with it.  */
> @@ -247,6 +257,7 @@ Visitor *qobject_output_visitor_new(QObject **result)
>      v->visitor.type_number =3D qobject_output_type_number;
>      v->visitor.type_any =3D qobject_output_type_any;
>      v->visitor.type_null =3D qobject_output_type_null;
> +    v->visitor.deprecated =3D qobject_output_deprecated;
>      v->visitor.complete =3D qobject_output_complete;
>      v->visitor.free =3D qobject_output_free;
>
> @@ -255,3 +266,11 @@ Visitor *qobject_output_visitor_new(QObject **result=
)
>
>      return &v->visitor;
>  }
> +
> +Visitor *qobject_output_visitor_new_qmp(QObject **result)
> +{
> +    QObjectOutputVisitor *v =3D to_qov(qobject_output_visitor_new(result=
));
> +
> +    v->deprecated_policy =3D compat_policy.deprecated_output;
> +    return &v->visitor;
> +}
> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> index d12ff47e26..82d599630c 100644
> --- a/tests/test-qmp-cmds.c
> +++ b/tests/test-qmp-cmds.c
> @@ -1,4 +1,5 @@
>  #include "qemu/osdep.h"
> +#include "qapi/compat-policy.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/qnum.h"
> @@ -45,12 +46,17 @@ void qmp_user_def_cmd1(UserDefOne * ud1, Error **errp=
)
>  {
>  }
>
> -void qmp_test_features0(FeatureStruct0 *fs0, FeatureStruct1 *fs1,
> -                       FeatureStruct2 *fs2, FeatureStruct3 *fs3,
> -                       FeatureStruct4 *fs4, CondFeatureStruct1 *cfs1,
> -                       CondFeatureStruct2 *cfs2, CondFeatureStruct3 *cfs=
3,
> -                       Error **errp)
> +FeatureStruct1 *qmp_test_features0(bool has_fs0, FeatureStruct0 *fs0,
> +                                   bool has_fs1, FeatureStruct1 *fs1,
> +                                   bool has_fs2, FeatureStruct2 *fs2,
> +                                   bool has_fs3, FeatureStruct3 *fs3,
> +                                   bool has_fs4, FeatureStruct4 *fs4,
> +                                   bool has_cfs1, CondFeatureStruct1 *cf=
s1,
> +                                   bool has_cfs2, CondFeatureStruct2 *cf=
s2,
> +                                   bool has_cfs3, CondFeatureStruct3 *cf=
s3,
> +                                   Error **errp)
>  {
> +    return g_new(FeatureStruct1, 1);
>  }
>
>  void qmp_test_command_features1(Error **errp)
> @@ -271,6 +277,30 @@ static void test_dispatch_cmd_io(void)
>      qobject_unref(ret3);
>  }
>
> +static void test_dispatch_cmd_ret_deprecated(void)
> +{
> +    const char *cmd =3D "{ 'execute': 'test-features0' }";
> +    QDict *ret;
> +
> +    memset(&compat_policy, 0, sizeof(compat_policy));
> +
> +    /* default accept */
> +    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
> +    assert(ret && qdict_size(ret) =3D=3D 1);
> +    qobject_unref(ret);
> +
> +    compat_policy.has_deprecated_output =3D true;
> +    compat_policy.deprecated_output =3D COMPAT_POLICY_OUTPUT_ACCEPT;
> +    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
> +    assert(ret && qdict_size(ret) =3D=3D 1);
> +    qobject_unref(ret);
> +
> +    compat_policy.deprecated_output =3D COMPAT_POLICY_OUTPUT_HIDE;
> +    ret =3D qobject_to(QDict, do_qmp_dispatch(false, cmd));
> +    assert(ret && qdict_size(ret) =3D=3D 0);
> +    qobject_unref(ret);
> +}
> +
>  /* test generated dealloc functions for generated types */
>  static void test_dealloc_types(void)
>  {
> @@ -345,6 +375,8 @@ int main(int argc, char **argv)
>      g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
>      g_test_add_func("/qmp/dispatch_cmd_success_response",
>                      test_dispatch_cmd_success_response);
> +    g_test_add_func("/qmp/dispatch_cmd_ret_deprecated",
> +                    test_dispatch_cmd_ret_deprecated);
>      g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
>      g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
>
> diff --git a/qapi/trace-events b/qapi/trace-events
> index 5eb4afa110..eff1fbd199 100644
> --- a/qapi/trace-events
> +++ b/qapi/trace-events
> @@ -17,6 +17,7 @@ visit_start_alternate(void *v, const char *name, void *=
obj, size_t size) "v=3D%p n
>  visit_end_alternate(void *v, void *obj) "v=3D%p obj=3D%p"
>
>  visit_optional(void *v, const char *name, bool *present) "v=3D%p name=3D=
%s present=3D%p"
> +visit_deprecated(void *v, const char *name) "v=3D%p name=3D%s"
>
>  visit_type_enum(void *v, const char *name, int *obj) "v=3D%p name=3D%s o=
bj=3D%p"
>  visit_type_int(void *v, const char *name, int64_t *obj) "v=3D%p name=3D%=
s obj=3D%p"
> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> index bc30876c88..35b79c554d 100644
> --- a/scripts/qapi/commands.py
> +++ b/scripts/qapi/commands.py
> @@ -69,7 +69,7 @@ static void qmp_marshal_output_%(c_name)s(%(c_type)s re=
t_in, QObject **ret_out,
>      Error *err =3D NULL;
>      Visitor *v;
>
> -    v =3D qobject_output_visitor_new(ret_out);
> +    v =3D qobject_output_visitor_new_qmp(ret_out);
>      visit_type_%(c_name)s(v, "unused", &ret_in, &err);
>      if (!err) {
>          visit_complete(v, ret_out);
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 23d9194aa4..21df3abed2 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -56,6 +56,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
>                       c_type=3Dbase.c_name())
>
>      for memb in members:
> +        deprecated =3D 'deprecated' in [f.name for f in memb.features]
>          ret +=3D gen_if(memb.ifcond)
>          if memb.optional:
>              ret +=3D mcgen('''
> @@ -63,6 +64,12 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_nam=
e)s *obj, Error **errp)
>  ''',
>                           name=3Dmemb.name, c_name=3Dc_name(memb.name))
>              push_indent()
> +        if deprecated:
> +            ret +=3D mcgen('''
> +    if (visit_deprecated(v, "%(name)s")) {

Do you have a compelling case where the "name" would change the
deprecation policy? I think that could be more confusing than
necessary, say if x- name wouldn't follow the policy.

> +''',
> +                         name=3Dmemb.name)
> +            push_indent()
>          ret +=3D mcgen('''
>      visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, &err);
>      if (err) {
> @@ -71,6 +78,11 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_nam=
e)s *obj, Error **errp)
>  ''',
>                       c_type=3Dmemb.type.c_name(), name=3Dmemb.name,
>                       c_name=3Dc_name(memb.name))
> +        if deprecated:
> +            pop_indent()
> +            ret +=3D mcgen('''
> +    }
> +''')
>          if memb.optional:
>              pop_indent()
>              ret +=3D mcgen('''
> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
> index 6b1f05afa7..e4cce0d5b0 100644
> --- a/tests/qapi-schema/qapi-schema-test.json
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -297,14 +297,15 @@
>    'features': [ 'feature1' ] }
>
>  { 'command': 'test-features0',
> -  'data': { 'fs0': 'FeatureStruct0',
> -            'fs1': 'FeatureStruct1',
> -            'fs2': 'FeatureStruct2',
> -            'fs3': 'FeatureStruct3',
> -            'fs4': 'FeatureStruct4',
> -            'cfs1': 'CondFeatureStruct1',
> -            'cfs2': 'CondFeatureStruct2',
> -            'cfs3': 'CondFeatureStruct3' },
> +  'data': { '*fs0': 'FeatureStruct0',
> +            '*fs1': 'FeatureStruct1',
> +            '*fs2': 'FeatureStruct2',
> +            '*fs3': 'FeatureStruct3',
> +            '*fs4': 'FeatureStruct4',
> +            '*cfs1': 'CondFeatureStruct1',
> +            '*cfs2': 'CondFeatureStruct2',
> +            '*cfs3': 'CondFeatureStruct3' },
> +  'returns': 'FeatureStruct1',
>    'features': [] }
>
>  { 'command': 'test-command-features1',
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
> index 891b4101e0..cd53323abd 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -407,15 +407,15 @@ alternate FeatureAlternate1
>      case eins: FeatureStruct1
>      feature feature1
>  object q_obj_test-features0-arg
> -    member fs0: FeatureStruct0 optional=3DFalse
> -    member fs1: FeatureStruct1 optional=3DFalse
> -    member fs2: FeatureStruct2 optional=3DFalse
> -    member fs3: FeatureStruct3 optional=3DFalse
> -    member fs4: FeatureStruct4 optional=3DFalse
> -    member cfs1: CondFeatureStruct1 optional=3DFalse
> -    member cfs2: CondFeatureStruct2 optional=3DFalse
> -    member cfs3: CondFeatureStruct3 optional=3DFalse
> -command test-features0 q_obj_test-features0-arg -> None
> +    member fs0: FeatureStruct0 optional=3DTrue
> +    member fs1: FeatureStruct1 optional=3DTrue
> +    member fs2: FeatureStruct2 optional=3DTrue
> +    member fs3: FeatureStruct3 optional=3DTrue
> +    member fs4: FeatureStruct4 optional=3DTrue
> +    member cfs1: CondFeatureStruct1 optional=3DTrue
> +    member cfs2: CondFeatureStruct2 optional=3DTrue
> +    member cfs3: CondFeatureStruct3 optional=3DTrue
> +command test-features0 q_obj_test-features0-arg -> FeatureStruct1
>      gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
>  command test-command-features1 None -> None
>      gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
> --
> 2.21.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

