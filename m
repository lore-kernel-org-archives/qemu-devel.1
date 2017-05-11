Received: from eggs.gnu.org ([2001:4830:134:3::10]:34171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8p6S-0008AZ-JD
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8p6N-0003Q1-OB
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:30:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8p6N-0003Pf-AE
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:29:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15510624C5
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 14:29:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-5-marcandre.lureau@redhat.com>
Date: Thu, 11 May 2017 16:29:53 +0200
In-Reply-To: <20170509173559.31598-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 9 May 2017 20:35:46 +0300")
Message-ID: <8737cbv53y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/17] qapi: merge QInt and QFloat in QNum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> We would like to use a same QObject type to represent numbers, whether
> they are int, uint, or floats. getters will allow some compatibility

Please start your sentence with a capital letter ...

> between the various types if the number fits other representations

... and end them with a period.

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py                          |  30 +++----
>  scripts/qapi-visit.py                    |   2 +-
>  include/qapi/qmp/qdict.h                 |   3 +-
>  include/qapi/qmp/qfloat.h                |  29 -------
>  include/qapi/qmp/qint.h                  |  28 -------
>  include/qapi/qmp/qlist.h                 |   2 +-
>  include/qapi/qmp/qnum.h                  |  43 ++++++++++
>  include/qapi/qmp/types.h                 |   3 +-
>  include/qapi/qobject-input-visitor.h     |   2 +-
>  include/qapi/qobject-output-visitor.h    |   8 +-
>  block/blkdebug.c                         |   1 -
>  block/nbd.c                              |   1 -
>  block/nfs.c                              |   1 -
>  block/qapi.c                             |  13 ++-
>  block/quorum.c                           |   1 -
>  block/sheepdog.c                         |   1 -
>  block/ssh.c                              |   1 -
>  block/vvfat.c                            |   1 -
>  blockdev.c                               |   5 +-
>  hw/acpi/pcihp.c                          |   1 -
>  hw/i386/acpi-build.c                     |  15 ++--
>  hw/usb/xen-usb.c                         |   1 -
>  monitor.c                                |   2 +-
>  qapi/qobject-input-visitor.c             |  36 +++-----
>  qapi/qobject-output-visitor.c            |   6 +-
>  qga/commands.c                           |   2 +-
>  qga/main.c                               |   1 -
>  qobject/json-parser.c                    |  18 ++--
>  qobject/qdict.c                          |  38 ++++-----
>  qobject/qfloat.c                         |  62 --------------
>  qobject/qint.c                           |  61 --------------
>  qobject/qjson.c                          |  37 +--------
>  qobject/qnum.c                           | 138 +++++++++++++++++++++++++=
++++++
>  qobject/qobject.c                        |   3 +-
>  qom/object.c                             |  21 +++--
>  target/i386/cpu.c                        |   6 +-
>  tests/check-qdict.c                      |  23 +++---
>  tests/check-qfloat.c                     |  53 ------------
>  tests/check-qint.c                       |  87 -------------------
>  tests/check-qjson.c                      |  84 +++++++++----------
>  tests/check-qlist.c                      |  15 ++--
>  tests/check-qnum.c                       | 131 +++++++++++++++++++++++++=
++++
>  tests/test-keyval.c                      |   1 -
>  tests/test-qmp-commands.c                |   6 +-
>  tests/test-qmp-event.c                   |   7 +-
>  tests/test-qobject-input-visitor.c       |  30 +++----
>  tests/test-qobject-output-visitor.c      |  56 ++++++-------
>  tests/test-x86-cpuid-compat.c            |  13 ++-
>  ui/spice-core.c                          |   1 -
>  ui/vnc-enc-tight.c                       |   1 -
>  util/qemu-option.c                       |  20 ++---
>  MAINTAINERS                              |   3 +-
>  qobject/Makefile.objs                    |   2 +-
>  scripts/coccinelle/qobject.cocci         |   4 +-
>  tests/.gitignore                         |   3 +-
>  tests/Makefile.include                   |  13 ++-
>  tests/qapi-schema/comments.out           |   2 +-
>  tests/qapi-schema/doc-good.out           |   2 +-
>  tests/qapi-schema/empty.out              |   2 +-
>  tests/qapi-schema/event-case.out         |   2 +-
>  tests/qapi-schema/ident-with-escape.out  |   2 +-
>  tests/qapi-schema/include-relpath.out    |   2 +-
>  tests/qapi-schema/include-repetition.out |   2 +-
>  tests/qapi-schema/include-simple.out     |   2 +-
>  tests/qapi-schema/indented-expr.out      |   2 +-
>  tests/qapi-schema/qapi-schema-test.out   |   2 +-
>  66 files changed, 557 insertions(+), 639 deletions(-)

Nice diffstat :)

>  delete mode 100644 include/qapi/qmp/qfloat.h
>  delete mode 100644 include/qapi/qmp/qint.h
>  create mode 100644 include/qapi/qmp/qnum.h
>  delete mode 100644 qobject/qfloat.c
>  delete mode 100644 qobject/qint.c
>  create mode 100644 qobject/qnum.c
>  delete mode 100644 tests/check-qfloat.c
>  delete mode 100644 tests/check-qint.c
>  create mode 100644 tests/check-qnum.c
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 6c4d554165..01fd0027a5 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -21,18 +21,18 @@ from ordereddict import OrderedDict
>=20=20
>  builtin_types =3D {
>      'str':      'QTYPE_QSTRING',
> -    'int':      'QTYPE_QINT',
> -    'number':   'QTYPE_QFLOAT',
> +    'int':      'QTYPE_QNUM',
> +    'number':   'QTYPE_QNUM',
>      'bool':     'QTYPE_QBOOL',
> -    'int8':     'QTYPE_QINT',
> -    'int16':    'QTYPE_QINT',
> -    'int32':    'QTYPE_QINT',
> -    'int64':    'QTYPE_QINT',
> -    'uint8':    'QTYPE_QINT',
> -    'uint16':   'QTYPE_QINT',
> -    'uint32':   'QTYPE_QINT',
> -    'uint64':   'QTYPE_QINT',
> -    'size':     'QTYPE_QINT',
> +    'int8':     'QTYPE_QNUM',
> +    'int16':    'QTYPE_QNUM',
> +    'int32':    'QTYPE_QNUM',
> +    'int64':    'QTYPE_QNUM',
> +    'uint8':    'QTYPE_QNUM',
> +    'uint16':   'QTYPE_QNUM',
> +    'uint32':   'QTYPE_QNUM',
> +    'uint64':   'QTYPE_QNUM',
> +    'size':     'QTYPE_QNUM',
>      'any':      None,           # any QType possible, actually
>      'QType':    'QTYPE_QSTRING',
>  }
> @@ -1044,8 +1044,8 @@ class QAPISchemaType(QAPISchemaEntity):
>      def alternate_qtype(self):
>          json2qtype =3D {
>              'string':  'QTYPE_QSTRING',
> -            'number':  'QTYPE_QFLOAT',
> -            'int':     'QTYPE_QINT',
> +            'number':  'QTYPE_QNUM',
> +            'int':     'QTYPE_QNUM',
>              'boolean': 'QTYPE_QBOOL',
>              'object':  'QTYPE_QDICT'
>          }
> @@ -1507,9 +1507,9 @@ class QAPISchema(object):
>          self.the_empty_object_type =3D QAPISchemaObjectType(
>              'q_empty', None, None, None, [], None)
>          self._def_entity(self.the_empty_object_type)
> -        qtype_values =3D self._make_enum_members(['none', 'qnull', 'qint=
',
> +        qtype_values =3D self._make_enum_members(['none', 'qnull', 'qnum=
',
>                                                  'qstring', 'qdict', 'qli=
st',
> -                                                'qfloat', 'qbool'])
> +                                                'qbool'])
>          self._def_entity(QAPISchemaEnumType('QType', None, None,
>                                              qtype_values, 'QTYPE'))
>=20=20
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index 5737aefa05..cc447ecacc 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -164,7 +164,7 @@ def gen_visit_alternate(name, variants):
>      promote_int =3D 'true'
>      ret =3D ''
>      for var in variants.variants:
> -        if var.type.alternate_qtype() =3D=3D 'QTYPE_QINT':
> +        if var.type.alternate_qtype() =3D=3D 'QTYPE_QNUM':
>              promote_int =3D 'false'
>=20=20
>      ret +=3D mcgen('''

This conflicts with Eduardo's patch.  The current plan is to take yours
first.

> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
> index 188440a6a8..363e431106 100644
> --- a/include/qapi/qmp/qdict.h
> +++ b/include/qapi/qmp/qdict.h
> @@ -15,6 +15,7 @@
>=20=20
>  #include "qapi/qmp/qobject.h"
>  #include "qapi/qmp/qlist.h"
> +#include "qapi/qmp/qnum.h"
>  #include "qemu/queue.h"

We neglected to include qint.h even though we use qint_from_int() in a
macro.  Including its replacement qnum.h is a bit cleaner.  Good.

Aside: queue.h could be dropped, as qlist.h already includes it.

>=20=20
>  #define QDICT_BUCKET_MAX 512
> @@ -54,7 +55,7 @@ void qdict_destroy_obj(QObject *obj);
>=20=20
>  /* Helpers for int, bool, and string */
>  #define qdict_put_int(qdict, key, value) \
> -        qdict_put(qdict, key, qint_from_int(value))
> +        qdict_put(qdict, key, qnum_from_int(value))
>  #define qdict_put_bool(qdict, key, value) \
>          qdict_put(qdict, key, qbool_from_bool(value))
>  #define qdict_put_str(qdict, key, value) \
> diff --git a/include/qapi/qmp/qfloat.h b/include/qapi/qmp/qfloat.h
> deleted file mode 100644
> index b5d15836b5..0000000000
> --- a/include/qapi/qmp/qfloat.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/*
> - * QFloat Module
> - *
> - * Copyright IBM, Corp. 2009
> - *
> - * Authors:
> - *  Anthony Liguori   <aliguori@us.ibm.com>
> - *
> - * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> - * See the COPYING.LIB file in the top-level directory.
> - *
> - */
> -
> -#ifndef QFLOAT_H
> -#define QFLOAT_H
> -
> -#include "qapi/qmp/qobject.h"
> -
> -typedef struct QFloat {
> -    QObject base;
> -    double value;
> -} QFloat;
> -
> -QFloat *qfloat_from_double(double value);
> -double qfloat_get_double(const QFloat *qi);
> -QFloat *qobject_to_qfloat(const QObject *obj);
> -void qfloat_destroy_obj(QObject *obj);
> -
> -#endif /* QFLOAT_H */
> diff --git a/include/qapi/qmp/qint.h b/include/qapi/qmp/qint.h
> deleted file mode 100644
> index 3aaff768dd..0000000000
> --- a/include/qapi/qmp/qint.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/*
> - * QInt Module
> - *
> - * Copyright (C) 2009 Red Hat Inc.
> - *
> - * Authors:
> - *  Luiz Capitulino <lcapitulino@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> - * See the COPYING.LIB file in the top-level directory.
> - */
> -
> -#ifndef QINT_H
> -#define QINT_H
> -
> -#include "qapi/qmp/qobject.h"
> -
> -typedef struct QInt {
> -    QObject base;
> -    int64_t value;
> -} QInt;
> -
> -QInt *qint_from_int(int64_t value);
> -int64_t qint_get_int(const QInt *qi);
> -QInt *qobject_to_qint(const QObject *obj);
> -void qint_destroy_obj(QObject *obj);
> -
> -#endif /* QINT_H */
> diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
> index 5dc4ed9616..2f2c199632 100644
> --- a/include/qapi/qmp/qlist.h
> +++ b/include/qapi/qmp/qlist.h

You may want to include qnum.h here for the same reason you do in
qdict.h.

> @@ -31,7 +31,7 @@ typedef struct QList {
>=20=20
>  /* Helpers for int, bool, and string */
>  #define qlist_append_int(qlist, value) \
> -        qlist_append(qlist, qint_from_int(value))
> +        qlist_append(qlist, qnum_from_int(value))
>  #define qlist_append_bool(qlist, value) \
>          qlist_append(qlist, qbool_from_bool(value))
>  #define qlist_append_str(qlist, value) \
> diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
> new file mode 100644
> index 0000000000..0e51427821
> --- /dev/null
> +++ b/include/qapi/qmp/qnum.h
> @@ -0,0 +1,43 @@
> +/*
> + * QNum Module
> + *
> + * Copyright (C) 2009 Red Hat Inc.
> + *
> + * Authors:
> + *  Luiz Capitulino <lcapitulino@redhat.com>

Your chance to add yourself here :)

> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#ifndef QNUM_H
> +#define QNUM_H
> +
> +#include "qapi/qmp/qobject.h"
> +
> +typedef enum {
> +    QNUM_I64,
> +    QNUM_DOUBLE
> +} QNumType;

Not bool because you're going to add to it.  Good.

Suggest to call it QNumKind because we already have QType base.type.

> +
> +typedef struct QNum {
> +    QObject base;
> +    QNumType type;
> +    union {
> +        int64_t i64;
> +        double dbl;
> +    } u;
> +} QNum;
> +
> +QNum *qnum_from_int(int64_t value);
> +QNum *qnum_from_double(double value);
> +
> +int64_t qnum_get_int(const QNum *qi, Error **errp);

Let's call the paramter @qn like we do elsewhere.

> +double qnum_get_double(QNum *qn);
> +
> +char *qnum_to_string(QNum *qn);
> +
> +QNum *qobject_to_qnum(const QObject *obj);
> +void qnum_destroy_obj(QObject *obj);
> +
> +#endif /* QNUM_H */
> diff --git a/include/qapi/qmp/types.h b/include/qapi/qmp/types.h
> index 27cfbd84e5..a4bc662bfb 100644
> --- a/include/qapi/qmp/types.h
> +++ b/include/qapi/qmp/types.h
> @@ -14,8 +14,7 @@
>  #define QAPI_QMP_TYPES_H
>=20=20
>  #include "qapi/qmp/qobject.h"
> -#include "qapi/qmp/qint.h"
> -#include "qapi/qmp/qfloat.h"
> +#include "qapi/qmp/qnum.h"
>  #include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qapi/qmp/qdict.h"
> diff --git a/include/qapi/qobject-input-visitor.h b/include/qapi/qobject-=
input-visitor.h
> index b399285c43..5a6fe83f8f 100644
> --- a/include/qapi/qobject-input-visitor.h
> +++ b/include/qapi/qobject-input-visitor.h
> @@ -30,7 +30,7 @@ typedef struct QObjectInputVisitor QObjectInputVisitor;
>   * visit_type_FOO() creates an instance of QAPI type FOO.  The visited
>   * QObject must match FOO.  QDict matches struct/union types, QList
>   * matches list types, QString matches type 'str' and enumeration
> - * types, QInt matches integer types, QFloat matches type 'number',
> + * types, QNum matches integer and float types,
>   * QBool matches type 'bool'.  Type 'any' is matched by QObject.  A
>   * QAPI alternate type is matched when one of its member types is.
>   *

Refill the paragraph, please.  Yes, it makes the diff slightly harder to
read (one time pain), and messes a bit with git-blame (occasional pain),
but I'll gladly trade that for slightly more readable comments (avoid
recurring pain).

> diff --git a/include/qapi/qobject-output-visitor.h b/include/qapi/qobject=
-output-visitor.h
> index 9b990c318e..e5a3490812 100644
> --- a/include/qapi/qobject-output-visitor.h
> +++ b/include/qapi/qobject-output-visitor.h
> @@ -28,10 +28,10 @@ typedef struct QObjectOutputVisitor QObjectOutputVisi=
tor;
>   *
>   * visit_type_FOO() creates a QObject for QAPI type FOO.  It creates a
>   * QDict for struct/union types, a QList for list types, QString for
> - * type 'str' and enumeration types, QInt for integer types, QFloat
> - * for type 'number', QBool for type 'bool'.  For type 'any', it
> - * increments the QObject's reference count.  For QAPI alternate
> - * types, it creates the QObject for the member that is in use.
> + * type 'str' and enumeration types, QNum for integer and float
> + * types, QBool for type 'bool'.  For type 'any', it increments the
> + * QObject's reference count.  For QAPI alternate types, it creates
> + * the QObject for the member that is in use.
>   *
>   * visit_start_struct() ... visit_end_struct() visits a QAPI
>   * struct/union and creates a QDict.  Visits in between visit the
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index 3c088934db..b3032c3ad7 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -30,7 +30,6 @@
>  #include "qemu/module.h"
>  #include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qdict.h"
> -#include "qapi/qmp/qint.h"
>  #include "qapi/qmp/qstring.h"
>  #include "sysemu/qtest.h"
>=20=20
> diff --git a/block/nbd.c b/block/nbd.c
> index 975faab2c5..e946ea944d 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -37,7 +37,6 @@
>  #include "qapi/qobject-output-visitor.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qjson.h"
> -#include "qapi/qmp/qint.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qemu/cutils.h"
>=20=20
> diff --git a/block/nfs.c b/block/nfs.c
> index 848b2c0bb0..decefd15f1 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -36,7 +36,6 @@
>  #include "qemu/cutils.h"
>  #include "sysemu/sysemu.h"
>  #include "qapi/qmp/qdict.h"
> -#include "qapi/qmp/qint.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qapi-visit.h"
>  #include "qapi/qobject-input-visitor.h"
> diff --git a/block/qapi.c b/block/qapi.c
> index a40922ea26..2050df29e4 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -595,9 +595,11 @@ static void dump_qobject(fprintf_function func_fprin=
tf, void *f,
>                           int comp_indent, QObject *obj)
>  {
>      switch (qobject_type(obj)) {
> -        case QTYPE_QINT: {
> -            QInt *value =3D qobject_to_qint(obj);
> -            func_fprintf(f, "%" PRId64, qint_get_int(value));
> +        case QTYPE_QNUM: {
> +            QNum *value =3D qobject_to_qnum(obj);
> +            char *tmp =3D qnum_to_string(value);
> +            func_fprintf(f, "%s", tmp);
> +            g_free(tmp);
>              break;
>          }
>          case QTYPE_QSTRING: {

Becomes a bit awkward due to the dynamically allocated buffer.  Let's
ignore that for now.

Aside: I don't like that the block layer has its own dump_qobject().

> @@ -615,11 +617,6 @@ static void dump_qobject(fprintf_function func_fprin=
tf, void *f,
>              dump_qlist(func_fprintf, f, comp_indent, value);
>              break;
>          }
> -        case QTYPE_QFLOAT: {
> -            QFloat *value =3D qobject_to_qfloat(obj);
> -            func_fprintf(f, "%g", qfloat_get_double(value));
> -            break;
> -        }
>          case QTYPE_QBOOL: {
>              QBool *value =3D qobject_to_qbool(obj);
>              func_fprintf(f, "%s", qbool_get_bool(value) ? "true" : "fals=
e");
> diff --git a/block/quorum.c b/block/quorum.c
> index 1b2a8c3937..55ba916655 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -19,7 +19,6 @@
>  #include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qerror.h"
> -#include "qapi/qmp/qint.h"
>  #include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/qlist.h"
>  #include "qapi/qmp/qstring.h"
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index a18315a1ca..dea9000bdd 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -16,7 +16,6 @@
>  #include "qapi-visit.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
> -#include "qapi/qmp/qint.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qemu/uri.h"
>  #include "qemu/error-report.h"
> diff --git a/block/ssh.c b/block/ssh.c
> index 11203fc5a2..bac3453c3e 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -34,7 +34,6 @@
>  #include "qemu/sockets.h"
>  #include "qemu/uri.h"
>  #include "qapi-visit.h"
> -#include "qapi/qmp/qint.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/qobject-output-visitor.h"
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 9c82371360..6089bba774 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -29,7 +29,6 @@
>  #include "qemu/module.h"
>  #include "qemu/bswap.h"
>  #include "migration/migration.h"
> -#include "qapi/qmp/qint.h"
>  #include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qemu/cutils.h"

We got lots of stale #include directives...

> diff --git a/blockdev.c b/blockdev.c
> index 0b38c3df71..ed9b839dd2 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -334,8 +334,9 @@ static bool parse_stats_intervals(BlockAcctStats *sta=
ts, QList *intervals,
>              break;
>          }
>=20=20
> -        case QTYPE_QINT: {
> -            int64_t length =3D qint_get_int(qobject_to_qint(entry->value=
));
> +        case QTYPE_QNUM: {
> +            int64_t length =3D qnum_get_int(qobject_to_qnum(entry->value=
),
> +                                          &error_abort);

Before: if entry->value isn't QInt, qint_get_int() dereferences null.

After: if entr->value isn't QNum with QNUM_I64, qnum_get_int() aborts on
setting an error.

Good.

Same argument for similar changes below.

>              if (length > 0 && length <=3D UINT_MAX) {
>                  block_acct_add_interval(stats, (unsigned) length);
>              } else {
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 2b0f3e1bfb..3a531a4416 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -37,7 +37,6 @@
>  #include "hw/pci/pci_bus.h"
>  #include "qapi/error.h"
>  #include "qom/qom-qobject.h"
> -#include "qapi/qmp/qint.h"
>=20=20
>  //#define DEBUG
>=20=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2073108577..ec3ae7fa85 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -57,7 +57,6 @@
>=20=20
>  #include "hw/acpi/aml-build.h"
>=20=20
> -#include "qapi/qmp/qint.h"
>  #include "qom/qom-qobject.h"
>  #include "hw/i386/amd_iommu.h"
>  #include "hw/i386/intel_iommu.h"
> @@ -150,21 +149,21 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
>      /* Fill in optional s3/s4 related properties */
>      o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S3_DISABLED, NUL=
L);
>      if (o) {
> -        pm->s3_disabled =3D qint_get_int(qobject_to_qint(o));
> +        pm->s3_disabled =3D qnum_get_int(qobject_to_qnum(o), &error_abor=
t);

Aside: there should be a less heavyweight way to read an uint8_t
property than going through a QObject created with a QObject output
visitor.  Not your problem.

>      } else {
>          pm->s3_disabled =3D false;
>      }
>      qobject_decref(o);
>      o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_DISABLED, NUL=
L);
>      if (o) {
> -        pm->s4_disabled =3D qint_get_int(qobject_to_qint(o));
> +        pm->s4_disabled =3D qnum_get_int(qobject_to_qnum(o), &error_abor=
t);
>      } else {
>          pm->s4_disabled =3D false;
>      }
>      qobject_decref(o);
>      o =3D object_property_get_qobject(obj, ACPI_PM_PROP_S4_VAL, NULL);
>      if (o) {
> -        pm->s4_val =3D qint_get_int(qobject_to_qint(o));
> +        pm->s4_val =3D qnum_get_int(qobject_to_qnum(o), &error_abort);
>      } else {
>          pm->s4_val =3D false;
>      }
> @@ -500,7 +499,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
>=20=20
>      bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BS=
EL, NULL);
>      if (bsel) {
> -        int64_t bsel_val =3D qint_get_int(qobject_to_qint(bsel));
> +        int64_t bsel_val =3D qnum_get_int(qobject_to_qnum(bsel), &error_=
abort);
>=20=20
>          aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)=
));
>          notify_method =3D aml_method("DVNT", 2, AML_NOTSERIALIZED);
> @@ -610,7 +609,7 @@ static void build_append_pci_bus_devices(Aml *parent_=
scope, PCIBus *bus,
>=20=20
>      /* If bus supports hotplug select it and notify about local events */
>      if (bsel) {
> -        int64_t bsel_val =3D qint_get_int(qobject_to_qint(bsel));
> +        int64_t bsel_val =3D qnum_get_int(qobject_to_qnum(bsel), &error_=
abort);
>          aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")=
));
>          aml_append(method,
>              aml_call2("DVNT", aml_name("PCIU"), aml_int(1) /* Device Che=
ck */)
> @@ -2586,12 +2585,12 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>      if (!o) {
>          return false;
>      }
> -    mcfg->mcfg_base =3D qint_get_int(qobject_to_qint(o));
> +    mcfg->mcfg_base =3D qnum_get_int(qobject_to_qnum(o), &error_abort);
>      qobject_decref(o);
>=20=20
>      o =3D object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NUL=
L);
>      assert(o);
> -    mcfg->mcfg_size =3D qint_get_int(qobject_to_qint(o));
> +    mcfg->mcfg_size =3D qnum_get_int(qobject_to_qnum(o), &error_abort);
>      qobject_decref(o);
>      return true;
>  }
> diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
> index fe62183fe3..584a6f2442 100644
> --- a/hw/usb/xen-usb.c
> +++ b/hw/usb/xen-usb.c
> @@ -30,7 +30,6 @@
>  #include "hw/xen/xen_backend.h"
>  #include "monitor/qdev.h"
>  #include "qapi/qmp/qbool.h"
> -#include "qapi/qmp/qint.h"
>  #include "qapi/qmp/qstring.h"
>=20=20
>  #include "hw/xen/io/ring.h"
> diff --git a/monitor.c b/monitor.c
> index 078cba5c86..7a640f0f65 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -2972,7 +2972,7 @@ static QDict *monitor_parse_arguments(Monitor *mon,
>                      monitor_printf(mon, "Unknown unit suffix\n");
>                      goto fail;
>                  }
> -                qdict_put(qdict, key, qfloat_from_double(val));
> +                qdict_put(qdict, key, qnum_from_double(val));
>              }
>              break;
>          case 'b':
> diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
> index d0f0002317..78425a4369 100644
> --- a/qapi/qobject-input-visitor.c
> +++ b/qapi/qobject-input-visitor.c
> @@ -377,9 +377,6 @@ static void qobject_input_start_alternate(Visitor *v,=
 const char *name,
>      }
>      *obj =3D g_malloc0(size);
>      (*obj)->type =3D qobject_type(qobj);
> -    if (promote_int && (*obj)->type =3D=3D QTYPE_QINT) {
> -        (*obj)->type =3D QTYPE_QFLOAT;
> -    }
>  }
>=20=20

Never liked this one, glad to see it go.

>  static void qobject_input_type_int64(Visitor *v, const char *name, int64=
_t *obj,
> @@ -387,19 +384,19 @@ static void qobject_input_type_int64(Visitor *v, co=
nst char *name, int64_t *obj,
>  {
>      QObjectInputVisitor *qiv =3D to_qiv(v);
>      QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
> -    QInt *qint;
> +    QNum *qnum;
>=20=20
>      if (!qobj) {
>          return;
>      }
> -    qint =3D qobject_to_qint(qobj);
> -    if (!qint) {
> +    qnum =3D qobject_to_qnum(qobj);
> +    if (!qnum) {
>          error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
>                     full_name(qiv, name), "integer");
>          return;
>      }
>=20=20
> -    *obj =3D qint_get_int(qint);
> +    *obj =3D qnum_get_int(qnum, errp);

Compare the error message a few lines up

    Invalid parameter type for 'NAME', expected: integer

to the one we get here:

    The number is a float

Which number?  There can be quite a few in a QMP command.  We need to
pass @name to qnum_get_int() for a decent error message, like

    Parameter 'NAME' is not a 64 bit integer

>  }
>=20=20
>=20=20
> @@ -423,22 +420,22 @@ static void qobject_input_type_int64_keyval(Visitor=
 *v, const char *name,
>  static void qobject_input_type_uint64(Visitor *v, const char *name,
>                                        uint64_t *obj, Error **errp)
>  {
> -    /* FIXME: qobject_to_qint mishandles values over INT64_MAX */
> +    /* FIXME: qobject_to_qnum mishandles values over INT64_MAX */
>      QObjectInputVisitor *qiv =3D to_qiv(v);
>      QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
> -    QInt *qint;
> +    QNum *qnum;
>=20=20
>      if (!qobj) {
>          return;
>      }
> -    qint =3D qobject_to_qint(qobj);
> -    if (!qint) {
> +    qnum =3D qobject_to_qnum(qobj);
> +    if (!qnum) {
>          error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
>                     full_name(qiv, name), "integer");
>          return;
>      }
>=20=20
> -    *obj =3D qint_get_int(qint);
> +    *obj =3D qnum_get_int(qnum, errp);

Likewise.

>  }
>=20=20
>  static void qobject_input_type_uint64_keyval(Visitor *v, const char *nam=
e,
> @@ -533,21 +530,14 @@ static void qobject_input_type_number(Visitor *v, c=
onst char *name, double *obj,
>  {
>      QObjectInputVisitor *qiv =3D to_qiv(v);
>      QObject *qobj =3D qobject_input_get_object(qiv, name, true, errp);
> -    QInt *qint;
> -    QFloat *qfloat;
> +    QNum *qnum;
>=20=20
>      if (!qobj) {
>          return;
>      }
> -    qint =3D qobject_to_qint(qobj);
> -    if (qint) {
> -        *obj =3D qint_get_int(qobject_to_qint(qobj));
> -        return;
> -    }
> -
> -    qfloat =3D qobject_to_qfloat(qobj);
> -    if (qfloat) {
> -        *obj =3D qfloat_get_double(qobject_to_qfloat(qobj));
> +    qnum =3D qobject_to_qnum(qobj);
> +    if (qnum) {
> +        *obj =3D qnum_get_double(qnum);
>          return;
>      }
>=20=20
       error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                  full_name(qiv, name), "number");
   }

Let's clean this up to the more common

       if (!qnum) {
          error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
                     full_name(qiv, name), "number");
          return;
       }

       *obj =3D qnum_get_double(qnum);

Preferrably in another patch, though.

> diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
> index 871127079d..2ca5093b22 100644
> --- a/qapi/qobject-output-visitor.c
> +++ b/qapi/qobject-output-visitor.c
> @@ -144,7 +144,7 @@ static void qobject_output_type_int64(Visitor *v, con=
st char *name,
>                                        int64_t *obj, Error **errp)
>  {
>      QObjectOutputVisitor *qov =3D to_qov(v);
> -    qobject_output_add(qov, name, qint_from_int(*obj));
> +    qobject_output_add(qov, name, qnum_from_int(*obj));
>  }
>=20=20
>  static void qobject_output_type_uint64(Visitor *v, const char *name,
> @@ -152,7 +152,7 @@ static void qobject_output_type_uint64(Visitor *v, co=
nst char *name,
>  {
>      /* FIXME values larger than INT64_MAX become negative */
>      QObjectOutputVisitor *qov =3D to_qov(v);
> -    qobject_output_add(qov, name, qint_from_int(*obj));
> +    qobject_output_add(qov, name, qnum_from_int(*obj));
>  }
>=20=20
>  static void qobject_output_type_bool(Visitor *v, const char *name, bool =
*obj,
> @@ -177,7 +177,7 @@ static void qobject_output_type_number(Visitor *v, co=
nst char *name,
>                                         double *obj, Error **errp)
>  {
>      QObjectOutputVisitor *qov =3D to_qov(v);
> -    qobject_output_add(qov, name, qfloat_from_double(*obj));
> +    qobject_output_add(qov, name, qnum_from_double(*obj));
>  }
>=20=20
>  static void qobject_output_type_any(Visitor *v, const char *name,
> diff --git a/qga/commands.c b/qga/commands.c
> index 3333ed50b2..ff89e805cf 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -485,7 +485,7 @@ int ga_parse_whence(GuestFileWhence *whence, Error **=
errp)
>  {
>      /* Exploit the fact that we picked values to match QGA_SEEK_*. */
>      if (whence->type =3D=3D QTYPE_QSTRING) {
> -        whence->type =3D QTYPE_QINT;
> +        whence->type =3D QTYPE_QNUM;
>          whence->u.value =3D whence->u.name;
>      }
>      switch (whence->u.value) {

Aside: modifying *whence is unnecessarily dirty.

> diff --git a/qga/main.c b/qga/main.c
> index cc58d2b53d..405c1290f8 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -19,7 +19,6 @@
>  #endif
>  #include "qapi/qmp/json-streamer.h"
>  #include "qapi/qmp/json-parser.h"
> -#include "qapi/qmp/qint.h"
>  #include "qapi/qmp/qjson.h"
>  #include "qga/guest-agent-core.h"
>  #include "qemu/module.h"
> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
> index c18e48ab94..f431854ba1 100644
> --- a/qobject/json-parser.c
> +++ b/qobject/json-parser.c
> @@ -466,16 +466,16 @@ static QObject *parse_escape(JSONParserContext *ctx=
t, va_list *ap)
>      } else if (!strcmp(token->str, "%i")) {
>          return QOBJECT(qbool_from_bool(va_arg(*ap, int)));
>      } else if (!strcmp(token->str, "%d")) {
> -        return QOBJECT(qint_from_int(va_arg(*ap, int)));
> +        return QOBJECT(qnum_from_int(va_arg(*ap, int)));
>      } else if (!strcmp(token->str, "%ld")) {
> -        return QOBJECT(qint_from_int(va_arg(*ap, long)));
> +        return QOBJECT(qnum_from_int(va_arg(*ap, long)));
>      } else if (!strcmp(token->str, "%lld") ||
>                 !strcmp(token->str, "%I64d")) {
> -        return QOBJECT(qint_from_int(va_arg(*ap, long long)));
> +        return QOBJECT(qnum_from_int(va_arg(*ap, long long)));
>      } else if (!strcmp(token->str, "%s")) {
>          return QOBJECT(qstring_from_str(va_arg(*ap, const char *)));
>      } else if (!strcmp(token->str, "%f")) {
> -        return QOBJECT(qfloat_from_double(va_arg(*ap, double)));
> +        return QOBJECT(qnum_from_double(va_arg(*ap, double)));
>      }
>      return NULL;
>  }
> @@ -494,12 +494,12 @@ static QObject *parse_literal(JSONParserContext *ct=
xt)
>          /* A possibility exists that this is a whole-valued float where =
the
>           * fractional part was left out due to being 0 (.0). It's not a =
big
>           * deal to treat these as ints in the parser, so long as users o=
f the
> -         * resulting QObject know to expect a QInt in place of a QFloat =
in
> +         * resulting QObject know to expect a QNum in place of a QNum in
>           * cases like these.

Oopsie :)

>           *
>           * However, in some cases these values will overflow/underflow a
> -         * QInt/int64 container, thus we should assume these are to be h=
andled
> -         * as QFloats/doubles rather than silently changing their values.
> +         * QNum/int64 container, thus we should assume these are to be h=
andled
> +         * as QNums/doubles rather than silently changing their values.
>           *
>           * strtoll() indicates these instances by setting errno to ERANGE
>           */

The whole comment needs to be rephrased.

The comment is about two things.  One, explain why code expecting QFloat
must be prepared to accept and convert QInt.  No longer applies.  Two,
explain that we store apparent integers as floating-point numbers when
they don't fit into int64_t.  This is still relevant.

What about:

           /*
            * When a JSON_INTEGER can't be represented as QNUM_I64, use
            * QNUM_DOUBLE instead.  stroll() fails with ERANGE then.
            *
            * Code expecting QNUM_I64 must reject QNUM_DOUBLE as out of
            * range.  qnum_get_int() does, so simply call that.
            *
            * Code expecting QNUM_DOUBLE must also accept QNUM_I64.
            * qnum_get_double() does, so simply call that.
            */

> @@ -508,7 +508,7 @@ static QObject *parse_literal(JSONParserContext *ctxt)
>          errno =3D 0; /* strtoll doesn't set errno on success */
>          value =3D strtoll(token->str, NULL, 10);
>          if (errno !=3D ERANGE) {
> -            return QOBJECT(qint_from_int(value));
> +            return QOBJECT(qnum_from_int(value));
>          }
>          /* fall through to JSON_FLOAT */
>      }
> @@ -516,7 +516,7 @@ static QObject *parse_literal(JSONParserContext *ctxt)
>          /* FIXME dependent on locale; a pervasive issue in QEMU */
>          /* FIXME our lexer matches RFC 7159 in forbidding Inf or NaN,
>           * but those might be useful extensions beyond JSON */
> -        return QOBJECT(qfloat_from_double(strtod(token->str, NULL)));
> +        return QOBJECT(qnum_from_double(strtod(token->str, NULL)));
>      default:
>          abort();
>      }
> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index 88e2ecd658..ad5bab9572 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -11,8 +11,7 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> -#include "qapi/qmp/qint.h"
> -#include "qapi/qmp/qfloat.h"
> +#include "qapi/qmp/qnum.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qbool.h"
>  #include "qapi/qmp/qstring.h"
> @@ -180,37 +179,26 @@ size_t qdict_size(const QDict *qdict)
>  /**
>   * qdict_get_double(): Get an number mapped by 'key'
>   *
> - * This function assumes that 'key' exists and it stores a
> - * QFloat or QInt object.
> + * This function assumes that 'key' exists and it stores a QNum.
>   *
>   * Return number mapped by 'key'.
>   */
>  double qdict_get_double(const QDict *qdict, const char *key)
>  {
> -    QObject *obj =3D qdict_get(qdict, key);
> -
> -    assert(obj);
> -    switch (qobject_type(obj)) {
> -    case QTYPE_QFLOAT:
> -        return qfloat_get_double(qobject_to_qfloat(obj));
> -    case QTYPE_QINT:
> -        return qint_get_int(qobject_to_qint(obj));
> -    default:
> -        abort();
> -    }
> +    return qnum_get_double(qobject_to_qnum(qdict_get(qdict, key)));
>  }
>=20=20
>  /**
>   * qdict_get_int(): Get an integer mapped by 'key'
>   *
>   * This function assumes that 'key' exists and it stores a
> - * QInt object.
> + * QNum representable as int.
>   *
>   * Return integer mapped by 'key'.
>   */
>  int64_t qdict_get_int(const QDict *qdict, const char *key)
>  {
> -    return qint_get_int(qobject_to_qint(qdict_get(qdict, key)));
> +    return qnum_get_int(qobject_to_qnum(qdict_get(qdict, key)), &error_a=
bort);

Line is a bit long for my taste.

>  }
>=20=20
>  /**
> @@ -260,15 +248,25 @@ const char *qdict_get_str(const QDict *qdict, const=
 char *key)
>   * qdict_get_try_int(): Try to get integer mapped by 'key'
>   *
>   * Return integer mapped by 'key', if it is not present in
> - * the dictionary or if the stored object is not of QInt type
> + * the dictionary or if the stored object is not of QNum type

Actually "is not a QNum representing an integer".

>   * 'def_value' will be returned.
>   */
>  int64_t qdict_get_try_int(const QDict *qdict, const char *key,
>                            int64_t def_value)
>  {
> -    QInt *qint =3D qobject_to_qint(qdict_get(qdict, key));
> +    Error *err =3D NULL;
> +    QNum *qnum =3D qobject_to_qnum(qdict_get(qdict, key));
> +    int64_t val =3D def_value;
> +
> +    if (qnum) {
> +        val =3D qnum_get_int(qnum, &err);
> +    }
> +    if (err) {
> +        error_free(err);
> +        val =3D def_value;
> +    }

This is a bit inefficient: it creates and destroys an Error object.
Easily avoided with a predicate qnum_is_int().

>=20=20
> -    return qint ? qint_get_int(qint) : def_value;
> +    return val;
>  }
>=20=20
>  /**
> diff --git a/qobject/qfloat.c b/qobject/qfloat.c
> deleted file mode 100644
> index d5da847701..0000000000
> --- a/qobject/qfloat.c
> +++ /dev/null
> @@ -1,62 +0,0 @@
> -/*
> - * QFloat Module
> - *
> - * Copyright IBM, Corp. 2009
> - *
> - * Authors:
> - *  Anthony Liguori   <aliguori@us.ibm.com>
> - *
> - * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> - * See the COPYING.LIB file in the top-level directory.
> - *
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qapi/qmp/qfloat.h"
> -#include "qapi/qmp/qobject.h"
> -#include "qemu-common.h"
> -
> -/**
> - * qfloat_from_int(): Create a new QFloat from a float
> - *
> - * Return strong reference.
> - */
> -QFloat *qfloat_from_double(double value)
> -{
> -    QFloat *qf;
> -
> -    qf =3D g_malloc(sizeof(*qf));
> -    qobject_init(QOBJECT(qf), QTYPE_QFLOAT);
> -    qf->value =3D value;
> -
> -    return qf;
> -}
> -
> -/**
> - * qfloat_get_double(): Get the stored float
> - */
> -double qfloat_get_double(const QFloat *qf)
> -{
> -    return qf->value;
> -}
> -
> -/**
> - * qobject_to_qfloat(): Convert a QObject into a QFloat
> - */
> -QFloat *qobject_to_qfloat(const QObject *obj)
> -{
> -    if (!obj || qobject_type(obj) !=3D QTYPE_QFLOAT) {
> -        return NULL;
> -    }
> -    return container_of(obj, QFloat, base);
> -}
> -
> -/**
> - * qfloat_destroy_obj(): Free all memory allocated by a
> - * QFloat object
> - */
> -void qfloat_destroy_obj(QObject *obj)
> -{
> -    assert(obj !=3D NULL);
> -    g_free(qobject_to_qfloat(obj));
> -}
> diff --git a/qobject/qint.c b/qobject/qint.c
> deleted file mode 100644
> index d7d1b3021f..0000000000
> --- a/qobject/qint.c
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -/*
> - * QInt Module
> - *
> - * Copyright (C) 2009 Red Hat Inc.
> - *
> - * Authors:
> - *  Luiz Capitulino <lcapitulino@redhat.com>
> - *
> - * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> - * See the COPYING.LIB file in the top-level directory.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qapi/qmp/qint.h"
> -#include "qapi/qmp/qobject.h"
> -#include "qemu-common.h"
> -
> -/**
> - * qint_from_int(): Create a new QInt from an int64_t
> - *
> - * Return strong reference.
> - */
> -QInt *qint_from_int(int64_t value)
> -{
> -    QInt *qi;
> -
> -    qi =3D g_malloc(sizeof(*qi));
> -    qobject_init(QOBJECT(qi), QTYPE_QINT);
> -    qi->value =3D value;
> -
> -    return qi;
> -}
> -
> -/**
> - * qint_get_int(): Get the stored integer
> - */
> -int64_t qint_get_int(const QInt *qi)
> -{
> -    return qi->value;
> -}
> -
> -/**
> - * qobject_to_qint(): Convert a QObject into a QInt
> - */
> -QInt *qobject_to_qint(const QObject *obj)
> -{
> -    if (!obj || qobject_type(obj) !=3D QTYPE_QINT) {
> -        return NULL;
> -    }
> -    return container_of(obj, QInt, base);
> -}
> -
> -/**
> - * qint_destroy_obj(): Free all memory allocated by a
> - * QInt object
> - */
> -void qint_destroy_obj(QObject *obj)
> -{
> -    assert(obj !=3D NULL);
> -    g_free(qobject_to_qint(obj));
> -}
> diff --git a/qobject/qjson.c b/qobject/qjson.c
> index b2f3bfec53..2e0930884e 100644
> --- a/qobject/qjson.c
> +++ b/qobject/qjson.c
> @@ -132,12 +132,11 @@ static void to_json(const QObject *obj, QString *st=
r, int pretty, int indent)
>      case QTYPE_QNULL:
>          qstring_append(str, "null");
>          break;
> -    case QTYPE_QINT: {
> -        QInt *val =3D qobject_to_qint(obj);
> -        char buffer[1024];
> -
> -        snprintf(buffer, sizeof(buffer), "%" PRId64, qint_get_int(val));
> +    case QTYPE_QNUM: {
> +        QNum *val =3D qobject_to_qnum(obj);
> +        char *buffer =3D qnum_to_string(val);
>          qstring_append(str, buffer);
> +        g_free(buffer);
>          break;
>      }
>      case QTYPE_QSTRING: {
> @@ -234,34 +233,6 @@ static void to_json(const QObject *obj, QString *str=
, int pretty, int indent)
>          qstring_append(str, "]");
>          break;
>      }
> -    case QTYPE_QFLOAT: {
> -        QFloat *val =3D qobject_to_qfloat(obj);
> -        char buffer[1024];
> -        int len;
> -
> -        /* FIXME: snprintf() is locale dependent; but JSON requires
> -         * numbers to be formatted as if in the C locale. Dependence
> -         * on C locale is a pervasive issue in QEMU. */
> -        /* FIXME: This risks printing Inf or NaN, which are not valid
> -         * JSON values. */
> -        /* FIXME: the default precision of 6 for %f often causes
> -         * rounding errors; we should be using DBL_DECIMAL_DIG (17),
> -         * and only rounding to a shorter number if the result would
> -         * still produce the same floating point value.  */
> -        len =3D snprintf(buffer, sizeof(buffer), "%f", qfloat_get_double=
(val));
> -        while (len > 0 && buffer[len - 1] =3D=3D '0') {
> -            len--;
> -        }
> -
> -        if (len && buffer[len - 1] =3D=3D '.') {
> -            buffer[len - 1] =3D 0;
> -        } else {
> -            buffer[len] =3D 0;
> -        }
> -
> -        qstring_append(str, buffer);
> -        break;
> -    }
>      case QTYPE_QBOOL: {
>          QBool *val =3D qobject_to_qbool(obj);
>=20=20
> diff --git a/qobject/qnum.c b/qobject/qnum.c
> new file mode 100644
> index 0000000000..8e9dd38350
> --- /dev/null
> +++ b/qobject/qnum.c
> @@ -0,0 +1,138 @@
> +/*
> + * QNum Module
> + *
> + * Copyright (C) 2009 Red Hat Inc.
> + *
> + * Authors:
> + *  Luiz Capitulino <lcapitulino@redhat.com>
> + *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or=
 later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qnum.h"
> +#include "qapi/qmp/qobject.h"
> +#include "qemu-common.h"
> +
> +/**
> + * qnum_from_int(): Create a new QNum from an int64_t
> + *
> + * Return strong reference.
> + */
> +QNum *qnum_from_int(int64_t value)
> +{
> +    QNum *qn =3D g_new(QNum, 1);
> +
> +    qobject_init(QOBJECT(qn), QTYPE_QNUM);
> +    qn->type =3D QNUM_I64;
> +    qn->u.i64 =3D value;
> +
> +    return qn;
> +}
> +
> +/**
> + * qnum_from_double(): Create a new QNum from a double
> + *
> + * Return strong reference.
> + */
> +QNum *qnum_from_double(double value)
> +{
> +    QNum *qn =3D g_new(QNum, 1);
> +
> +    qobject_init(QOBJECT(qn), QTYPE_QNUM);
> +    qn->type =3D QNUM_DOUBLE;
> +    qn->u.dbl =3D value;
> +
> +    return qn;
> +}
> +
> +/**
> + * qnum_get_int(): Get an integer representation of the number
> + */
> +int64_t qnum_get_int(const QNum *qn, Error **errp)
> +{
> +    switch (qn->type) {
> +    case QNUM_I64:
> +        return qn->u.i64;
> +    case QNUM_DOUBLE:
> +        error_setg(errp, "The number is a float");
> +        return 0;
> +    }
> +
> +    g_assert_not_reached();

g_assert_not_reached() is problematic, see "[PATCH] checkpatch: Disallow
glib asserts in main code".

Message-Id: <20170427165526.19836-1-dgilbert@redhat.com>
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05499.html

More of the same below.

The function does the right thing for QNums created by the JSON parser,
which picks the QNumType carefully, in parse_literal():

* if the JSON number has neither a fractional nor an exponent part, and

  - fits into int64_t, use qnum_from_int()
  - fits into uint64_t, use qnum_from_uint()

  (if it fits both, qnum_from_int(), but that should not matter)

* else, use qnum_from_double().

For such a QNum, rejecting QNUM_DOUBLE here is correct, because the
value either had a fractional part, an exponent part, or didn't fit
int64_t.

Other code using qnum_from_int() and qnum_from_double() needs to be
similarly careful.

As discussed above, the function needs a @name parameter so it can
create better error message.

Could also try leave the Error business entirely to the caller, and only
return success / failure here.  Pick what you like better.

> +}
> +
> +/**
> + * qnum_get_double(): Get a float representation of the number
> + */
> +double qnum_get_double(QNum *qn)
> +{
> +    switch (qn->type) {
> +    case QNUM_I64:
> +        return qn->u.i64;
> +    case QNUM_DOUBLE:
> +        return qn->u.dbl;
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
> +char *qnum_to_string(QNum *qn)
> +{
> +    char *buffer;
> +    int len;
> +
> +    switch (qn->type) {
> +    case QNUM_I64:
> +        return g_strdup_printf("%" PRId64, qn->u.i64);
> +    case QNUM_DOUBLE:
> +        /* FIXME: snprintf() is locale dependent; but JSON requires
> +         * numbers to be formatted as if in the C locale. Dependence
> +         * on C locale is a pervasive issue in QEMU. */
> +        /* FIXME: This risks printing Inf or NaN, which are not valid
> +         * JSON values. */
> +        /* FIXME: the default precision of 6 for %f often causes
> +         * rounding errors; we should be using DBL_DECIMAL_DIG (17),
> +         * and only rounding to a shorter number if the result would
> +         * still produce the same floating point value.  */
> +        buffer =3D g_strdup_printf("%f" , qn->u.dbl);
> +        len =3D strlen(buffer);
> +        while (len > 0 && buffer[len - 1] =3D=3D '0') {
> +            len--;
> +        }
> +
> +        if (len && buffer[len - 1] =3D=3D '.') {
> +            buffer[len - 1] =3D 0;
> +        } else {
> +            buffer[len] =3D 0;
> +        }
> +
> +        return buffer;
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
> +/**
> + * qobject_to_qnum(): Convert a QObject into a QNum
> + */
> +QNum *qobject_to_qnum(const QObject *obj)
> +{
> +    if (!obj || qobject_type(obj) !=3D QTYPE_QNUM) {
> +        return NULL;
> +    }
> +    return container_of(obj, QNum, base);
> +}
> +
> +/**
> + * qnum_destroy_obj(): Free all memory allocated by a
> + * QNum object
> + */
> +void qnum_destroy_obj(QObject *obj)
> +{
> +    assert(obj !=3D NULL);
> +    g_free(qobject_to_qnum(obj));
> +}
> diff --git a/qobject/qobject.c b/qobject/qobject.c
> index fe4fa10989..b0cafb66f1 100644
> --- a/qobject/qobject.c
> +++ b/qobject/qobject.c
> @@ -14,11 +14,10 @@
>  static void (*qdestroy[QTYPE__MAX])(QObject *) =3D {
>      [QTYPE_NONE] =3D NULL,               /* No such object exists */
>      [QTYPE_QNULL] =3D NULL,              /* qnull_ is indestructible */
> -    [QTYPE_QINT] =3D qint_destroy_obj,
> +    [QTYPE_QNUM] =3D qnum_destroy_obj,
>      [QTYPE_QSTRING] =3D qstring_destroy_obj,
>      [QTYPE_QDICT] =3D qdict_destroy_obj,
>      [QTYPE_QLIST] =3D qlist_destroy_obj,
> -    [QTYPE_QFLOAT] =3D qfloat_destroy_obj,
>      [QTYPE_QBOOL] =3D qbool_destroy_obj,
>  };
>=20=20
> diff --git a/qom/object.c b/qom/object.c
> index c7b8079df6..c1644dbcb7 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -27,7 +27,6 @@
>  #include "qom/qom-qobject.h"
>  #include "qapi/qmp/qobject.h"
>  #include "qapi/qmp/qbool.h"
> -#include "qapi/qmp/qint.h"
>  #include "qapi/qmp/qstring.h"
>=20=20
>  #define MAX_INTERFACES 32
> @@ -1190,28 +1189,32 @@ bool object_property_get_bool(Object *obj, const =
char *name,
>  void object_property_set_int(Object *obj, int64_t value,
>                               const char *name, Error **errp)
>  {
> -    QInt *qint =3D qint_from_int(value);
> -    object_property_set_qobject(obj, QOBJECT(qint), name, errp);
> +    QNum *qnum =3D qnum_from_int(value);
> +    object_property_set_qobject(obj, QOBJECT(qnum), name, errp);
>=20=20
> -    QDECREF(qint);
> +    QDECREF(qnum);
>  }
>=20=20
>  int64_t object_property_get_int(Object *obj, const char *name,
>                                  Error **errp)
>  {
>      QObject *ret =3D object_property_get_qobject(obj, name, errp);
> -    QInt *qint;
> +    Error *err =3D NULL;
> +    QNum *qnum;
>      int64_t retval;
>=20=20
>      if (!ret) {
>          return -1;
>      }
> -    qint =3D qobject_to_qint(ret);
> -    if (!qint) {
> +    qnum =3D qobject_to_qnum(ret);
> +    if (qnum) {
> +        retval =3D qnum_get_int(qnum, &err);
> +    }
> +
> +    if (!qnum || err) {
>          error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "int");
> +        error_free(err);
>          retval =3D -1;
> -    } else {
> -        retval =3D qint_get_int(qint);
>      }
>=20=20

The error message could be improved, but that's outside your patch's
scope.

>      qobject_decref(ret);
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 13c0985f11..1e8a5b55c0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -29,11 +29,7 @@
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
>  #include "qapi/qmp/qerror.h"
> -#include "qapi/qmp/qstring.h"
> -#include "qapi/qmp/qdict.h"
> -#include "qapi/qmp/qbool.h"
> -#include "qapi/qmp/qint.h"
> -#include "qapi/qmp/qfloat.h"
> +#include "qapi/qmp/types.h"
>=20=20
>  #include "qapi-types.h"
>  #include "qapi-visit.h"
[Skipping tests in this first pass...]

I rather like the patch so far :)
