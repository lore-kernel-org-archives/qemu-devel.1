Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D6AC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5922F21848
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5922F21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFgQC-0001zC-2Z
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 11:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iFgMX-00008b-QL
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iFgMV-0007HC-Kc
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:16:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iFgMT-0007F3-M0
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:16:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA1F518CB910;
 Wed,  2 Oct 2019 15:16:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9883660BF4;
 Wed,  2 Oct 2019 15:16:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 20E7C113864A; Wed,  2 Oct 2019 17:16:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 6/7] qapi: Split up scripts/qapi/common.py
References: <20191001191514.11208-1-armbru@redhat.com>
 <20191001191514.11208-7-armbru@redhat.com>
 <f195452f-43f8-a1be-653b-e4d8d2d888e3@redhat.com>
Date: Wed, 02 Oct 2019 17:16:12 +0200
In-Reply-To: <f195452f-43f8-a1be-653b-e4d8d2d888e3@redhat.com> (Eric Blake's
 message of "Tue, 1 Oct 2019 16:19:42 -0500")
Message-ID: <87lfu3rxdv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 02 Oct 2019 15:16:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/1/19 2:15 PM, Markus Armbruster wrote:
>> The QAPI code generator clocks in at some 3100 SLOC in 8 source files.
>> Almost 60% of the code is in qapi/common.py.  Split it into more
>> focused modules:
>>
>> * Move QAPISchemaPragma and QAPISourceInfo to qapi/source.py.
>>
>> * Move QAPIError and its sub-classes to qapi/error.py.
>>
>> * Move QAPISchemaParser and QAPIDoc to parser.py.  Use the opportunity
>>    to put QAPISchemaParser first.
>>
>> * Move check_expr() & friends to qapi/expr.py.  Use the opportunity to
>>    put the code into a more sensible order.
>
> Code motion can be easier to review when it is 1:1 (using 'diff -u
> <(sed -n '/^-//p' patch) <(sed -n '/^\+//p'patch)', which is quite
> small if code moved wholesale).  Reordering things breaks that
> property.

True.  But see below.

>> * Move QAPISchema & friends to qapi/schema.py
>>
>> * Move QAPIGen and its sub-classes, ifcontext,
>>    QAPISchemaModularCVisitor, and QAPISchemaModularCVisitor to qapi/gen.=
py
>>
>> A number of helper functions remain in qapi/common.py.  I considered
>> moving the code generator helpers to qapi/gen.py, but decided not to.
>> Perhaps we should rewrite them as methods of QAPIGen some day.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>>   15 files changed, 2411 insertions(+), 2329 deletions(-)
>
> Sheesh. This one's big.  I'm half-tempted to ask you to split it
> further.  But here goes my review anyway...
>
>>   create mode 100644 scripts/qapi/error.py
>>   create mode 100644 scripts/qapi/expr.py
>>   create mode 100644 scripts/qapi/gen.py
>>   create mode 100644 scripts/qapi/parser.py
>>   create mode 100644 scripts/qapi/schema.py
>>   create mode 100644 scripts/qapi/source.py
>>
>> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
>> index 3d98ca2e0c..f93f3c7c23 100755
>> --- a/scripts/qapi-gen.py
>
>
>> +++ b/scripts/qapi/error.py
>> @@ -0,0 +1,42 @@
>> +#
>> +# QAPI error classes
>> +#
>> +# Copyright (c) 2017-2019 Red Hat Inc.
>> +#
>> +# Authors:
>> +#  Markus Armbruster <armbru@redhat.com>
>> +#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2.
>> +# See the COPYING file in the top-level directory.
>
> It's a shame the generator got stuck at GPLv2-only.  I don't know if
> that's worth cleaning up as part of refactoring, but if so, it would
> be best as a separate patch from the code motion.

When Anthony and Mike created QAPI, they licensed it v2-only.  I have no
idea why.

By now, precious little code from that version is left.  Almost all
current code has been written by myself, you, Marc-Andr=C3=A9, and Kevin.

Nevertheless, we're boxed into a v2-only corner.  I resent that.

I should've slapped "contributions after <today> are GPLv2+" on the
whole thing the day I accepted to maintain it, if not earlier (right
when I started rewriting the parts that cried for it).

In my opinion, we should reject contributions unless licensed GPLv2+ as
a matter of policy, with exceptions granted on a case-by-case basis.

>> +++ b/scripts/qapi/gen.py
>
>> +++ b/scripts/qapi/parser.py
>
>> +++ b/scripts/qapi/schema.py
>
>> +++ b/scripts/qapi/source.py
> I didn't see any obvious accidental changes in all that motion
> (although given the size, the review was more cursory of the form
> "does it look like an entire chunk of code moved from one file to
> another per the commit message" than "read every line").

Perhaps a bit of shell wizardry can increase your confidence.

Before this patch:

1. Split into classes and functions (crudely!):

    $ csplit scripts/qapi/common.py '/^\(class\|def\) /' '{*}'

2. Rename the parts:

    $ for i in xx*; do n=3D`sed -n '1s/^[a-z]* \([A-Za-z0-9_]*\).*/\1/p' $i=
`; [ "$n" ] && mv $i xx-$n; done

3. Stash them:

    $ mkdir o
    $ $ mv xx* o

After this patch:

1. Split:

    $ csplit <(cat scripts/qapi/{common,source,error,parser,expr,schema,gen=
}.py) '/^\(class\|def\) /' '{*}'

2. Rename:

    $ for i in xx*; do n=3D`sed -n '1s/^[a-z]* \([A-Za-z0-9_]*\).*/\1/p' $i=
`; [ "$n" ] && mv $i xx-$n; done

3. Stash & diff:

    $ mkdir n
    $ mv xx* n
    $ diff -rup o n

Output of diff appended for your reading pleasure.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


diff -rup o/xx-QAPIDoc n/xx-QAPIDoc
--- o/xx-QAPIDoc	2019-10-02 17:02:35.984552694 +0200
+++ n/xx-QAPIDoc	2019-10-02 17:06:17.930607336 +0200
@@ -273,5 +273,31 @@ class QAPIDoc(object):
                 self.info,
                 "the following documented members are not in "
                 "the declaration: %s" % ", ".join(bogus))
+#
+# Check (context-free) QAPI schema expression structure
+#
+# Copyright IBM, Corp. 2011
+# Copyright (c) 2013-2019 Red Hat Inc.
+#
+# Authors:
+#  Anthony Liguori <aliguori@us.ibm.com>
+#  Markus Armbruster <armbru@redhat.com>
+#  Eric Blake <eblake@redhat.com>
+#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+import re
+from collections import OrderedDict
+from qapi.common import c_name
+from qapi.error import QAPISemError
+
+
+# Names must be letters, numbers, -, and _.  They must start with letter,
+# except for downstream extensions which must start with __RFQDN_.
+# Dots are only valid in the downstream extension prefix.
+valid_name =3D re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
+                        '[a-zA-Z][a-zA-Z0-9_-]*$')
=20
=20
diff -rup o/xx-QAPIGen n/xx-QAPIGen
--- o/xx-QAPIGen	2019-10-02 17:02:35.987552655 +0200
+++ n/xx-QAPIGen	2019-10-02 17:06:17.932607309 +0200
@@ -43,4 +43,3 @@ class QAPIGen(object):
         f.close()
=20
=20
-@contextmanager
diff -rup o/xx-QAPIGenH n/xx-QAPIGenH
--- o/xx-QAPIGenH	2019-10-02 17:02:35.987552655 +0200
+++ n/xx-QAPIGenH	2019-10-02 17:06:17.933607296 +0200
@@ -7,3 +7,4 @@ class QAPIGenH(QAPIGenC):
         return guardend(self.fname)
=20
=20
+@contextmanager
diff -rup o/xx-QAPISchema n/xx-QAPISchema
--- o/xx-QAPISchema	2019-10-02 17:02:35.986552668 +0200
+++ n/xx-QAPISchema	2019-10-02 17:06:17.932607309 +0200
@@ -297,9 +297,26 @@ class QAPISchema(object):
                     visitor.visit_module(module)
                 entity.visit(visitor)
         visitor.visit_end()
-
-
 #
-# Code generation helpers
+# QAPI code generation
+#
+# Copyright (c) 2018-2019 Red Hat Inc.
+#
+# Authors:
+#  Markus Armbruster <armbru@redhat.com>
+#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
 #
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+
+import errno
+import os
+import re
+import sys
+from contextlib import contextmanager
+
+from qapi.common import *
+from qapi.schema import QAPISchemaVisitor
+
=20
diff -rup o/xx-QAPISchemaParser n/xx-QAPISchemaParser
--- o/xx-QAPISchemaParser	2019-10-02 17:02:35.984552694 +0200
+++ n/xx-QAPISchemaParser	2019-10-02 17:06:17.930607336 +0200
@@ -268,14 +268,3 @@ class QAPISchemaParser(object):
         raise QAPIParseError(self, "documentation comment must end with '#=
#'")
=20
=20
-#
-# Check (context-free) schema expression structure
-#
-
-# Names must be letters, numbers, -, and _.  They must start with letter,
-# except for downstream extensions which must start with __RFQDN_.
-# Dots are only valid in the downstream extension prefix.
-valid_name =3D re.compile(r'^(__[a-zA-Z0-9.-]+_)?'
-                        '[a-zA-Z][a-zA-Z0-9_-]*$')
-
-
diff -rup o/xx-QAPISemError n/xx-QAPISemError
--- o/xx-QAPISemError	2019-10-02 17:02:35.984552694 +0200
+++ n/xx-QAPISemError	2019-10-02 17:06:17.930607336 +0200
@@ -1,5 +1,27 @@
 class QAPISemError(QAPIError):
     def __init__(self, info, msg):
         QAPIError.__init__(self, info, None, msg)
+#
+# QAPI schema parser
+#
+# Copyright IBM, Corp. 2011
+# Copyright (c) 2013-2019 Red Hat Inc.
+#
+# Authors:
+#  Anthony Liguori <aliguori@us.ibm.com>
+#  Markus Armbruster <armbru@redhat.com>
+#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+#  Kevin Wolf <kwolf@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+import os
+import re
+import sys
+from collections import OrderedDict
+
+from qapi.error import QAPIParseError, QAPISemError
+from qapi.source import QAPISourceInfo
=20
=20
diff -rup o/xx-QAPISourceInfo n/xx-QAPISourceInfo
--- o/xx-QAPISourceInfo	2019-10-02 17:02:35.984552694 +0200
+++ n/xx-QAPISourceInfo	2019-10-02 17:06:17.930607336 +0200
@@ -40,5 +40,16 @@ class QAPISourceInfo(object):
=20
     def __str__(self):
         return self.include_path() + self.in_defn() + self.loc()
+#
+# QAPI error classes
+#
+# Copyright (c) 2017-2019 Red Hat Inc.
+#
+# Authors:
+#  Markus Armbruster <armbru@redhat.com>
+#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
=20
=20
diff -rup o/xx-build_params n/xx-build_params
--- o/xx-build_params	2019-10-02 17:02:35.987552655 +0200
+++ n/xx-build_params	2019-10-02 17:06:17.930607336 +0200
@@ -17,9 +17,17 @@ def build_params(arg_type, boxed, extra=3D
     if extra:
         ret +=3D sep + extra
     return ret if ret else 'void'
-
-
 #
-# Accumulate and write output
+# QAPI frontend source file info
+#
+# Copyright (c) 2019 Red Hat Inc.
 #
+# Authors:
+#  Markus Armbruster <armbru@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+import copy
+
=20
Only in o: xx-camel_case
diff -rup o/xx-check_exprs n/xx-check_exprs
--- o/xx-check_exprs	2019-10-02 17:02:35.985552681 +0200
+++ n/xx-check_exprs	2019-10-02 17:06:17.931607323 +0200
@@ -80,10 +80,28 @@ def check_exprs(exprs):
         check_flags(expr, info)
=20
     return exprs
-
-
 #
-# Schema compiler frontend
-# TODO catching name collisions in generated code would be nice
+# QAPI schema internal representation
+#
+# Copyright (c) 2015-2019 Red Hat Inc.
+#
+# Authors:
+#  Markus Armbruster <armbru@redhat.com>
+#  Eric Blake <eblake@redhat.com>
+#  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
 #
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+# TODO catching name collisions in generated code would be nice
+
+import os
+import re
+from collections import OrderedDict
+
+from qapi.common import c_name, pointer_suffix
+from qapi.error import QAPIError, QAPIParseError, QAPISemError
+from qapi.expr import check_exprs
+from qapi.parser import QAPISchemaParser
+
=20
diff -rup o/xx00 n/xx00
--- o/xx00	2019-10-02 17:02:35.983552708 +0200
+++ n/xx00	2019-10-02 17:06:17.929607349 +0200
@@ -11,19 +11,10 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
=20
-from __future__ import print_function
-from contextlib import contextmanager
-import copy
-import errno
-import os
 import re
 import string
-import sys
-from collections import OrderedDict
-
-
-#
-# Parsing the schema into expressions
-#
=20
=20
+# ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
+# ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAM=
E2
+# ENUM24_Name -> ENUM24_NAME

