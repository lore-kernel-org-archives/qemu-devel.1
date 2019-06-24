Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635E9C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8FB20665
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8FB20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfT7c-0000ca-HY
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48837)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfSwn-0001Df-LQ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfSwl-0004wQ-FL
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:40:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfSwc-0004QO-Lp; Mon, 24 Jun 2019 13:39:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 118B93082B5A;
 Mon, 24 Jun 2019 17:39:50 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EB31600C0;
 Mon, 24 Jun 2019 17:39:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 24 Jun 2019 19:39:25 +0200
Message-Id: <20190624173935.25747-6-mreitz@redhat.com>
In-Reply-To: <20190624173935.25747-1-mreitz@redhat.com>
References: <20190624173935.25747-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 24 Jun 2019 17:39:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 05/14] qapi: Document default values for
 struct members
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 81 ++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index e8ec8ac1de..9dd7816701 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -334,11 +334,15 @@ Usage: { 'struct': STRING, 'data': DICT, '*base': S=
TRUCT-NAME }
 A struct is a dictionary containing a single 'data' key whose value is
 a dictionary; the dictionary may be empty.  This corresponds to a
 struct in C or an Object in JSON. Each value of the 'data' dictionary
-must be the name of a type, or a one-element array containing a type
-name.  An example of a struct is:
+must be the name of a type, a one-element array containing a type
+name, or a dictionary whose 'type' key gives a type name.  An example
+of a struct is:
=20
  { 'struct': 'MyType',
-   'data': { 'member1': 'str', 'member2': 'int', '*member3': 'str' } }
+   'data': { 'member1': 'str',
+             'member2': 'int',
+             '*member3': 'str',
+             '*member4': { 'type': 'bool' } } }
=20
 The use of '*' as a prefix to the name means the member is optional in
 the corresponding JSON protocol usage.
@@ -371,6 +375,21 @@ A structure that is used in both input and output of=
 various commands
 must consider the backwards compatibility constraints of both directions
 of use.
=20
+Instead of describing the default values for input structures' members
+in the documentation, it is possible to specify it explicitly in the
+struct definition.  In the following example, we let the optional
+'member4' of the above 'MyType' struct default to true:
+
+{ 'struct': 'MyType',
+   'data': { 'member1': 'str',
+             'member2': 'int',
+             '*member3': 'str',
+             '*member4': { 'type': 'bool', 'default': true } } }
+
+In the resulting C interface in QEMU 'member4' will then appear as
+non-optional.  If the client does not specify it, it will be
+automatically set to true.
+
 A struct definition can specify another struct as its base.
 In this case, the members of the base type are included as top-level mem=
bers
 of the new struct's dictionary in the Client JSON Protocol wire
@@ -472,8 +491,9 @@ All branches of the union must be complex types, and =
the top-level
 members of the union dictionary on the wire will be combination of
 members from both the base type and the appropriate branch type (when
 merging two dictionaries, there must be no keys in common).  The
-'discriminator' member must be the name of a non-optional enum-typed
-member of the base struct.
+'discriminator' member must be the name of an enum-typed member of the
+base struct.  If that member is optional, a default value must be
+given.
=20
 The following example enhances the above simple union example by
 adding an optional common member 'read-only', renaming the
@@ -504,6 +524,24 @@ In the resulting generated C data types, a flat unio=
n is
 represented as a struct with the base members included directly, and
 then a union of structures for each branch of the struct.
=20
+In the following example, the above BlockdevOptions struct is changed
+so it defaults to the 'file' driver is that field is omitted on the
+wire:
+
+ { 'union': 'BlockdevOptions',
+   'base': {
+       '*driver': { 'type': 'BlockdevDriver', 'default': 'file' },
+       '*read-only': 'bool'
+   },
+   'discriminator': 'driver',
+   'data': { 'file': 'BlockdevOptionsFile',
+             'qcow2': 'BlockdevOptionsQcow2' } }
+
+Now the 'file' JSON object can be abbreviated to:
+
+ { "read-only": true,
+   "filename": "/some/place/my-image" }
+
 A simple union can always be re-written as a flat union where the base
 class has a single member named 'type', and where each branch of the
 union has a struct with a single member named 'data'.  That is,
@@ -922,11 +960,11 @@ and "variants".
 "members" is a JSON array describing the object's common members, if
 any.  Each element is a JSON object with members "name" (the member's
 name), "type" (the name of its type), and optionally "default".  The
-member is optional if "default" is present.  Currently, "default" can
-only have value null.  Other values are reserved for future
-extensions.  The "members" array is in no particular order; clients
-must search the entire object when learning whether a particular
-member is supported.
+member is optional if "default" is present.  If "default" has any
+value but null, that value will be used as the default if the member
+is not specified.  The "members" array is in no particular order;
+clients must search the entire object when learning whether a
+particular member is supported.
=20
 Example: the SchemaInfo for MyType from section Struct types
=20
@@ -934,7 +972,8 @@ Example: the SchemaInfo for MyType from section Struc=
t types
       "members": [
           { "name": "member1", "type": "str" },
           { "name": "member2", "type": "int" },
-          { "name": "member3", "type": "str", "default": null } ] }
+          { "name": "member3", "type": "str", "default": null },
+          { "name": "member4", "type": "bool", "default": true } ] }
=20
 "tag" is the name of the common member serving as type tag.
 "variants" is a JSON array describing the object's variant members.
@@ -1052,7 +1091,9 @@ qmp_my_command(); everything else is produced by th=
e generator.
=20
     $ cat example-schema.json
     { 'struct': 'UserDefOne',
-      'data': { 'integer': 'int', '*string': 'str' } }
+      'data': { 'integer': 'int',
+                '*string': 'str',
+                '*defaultbool': { 'type': 'bool', 'default': true } } }
=20
     { 'command': 'my-command',
       'data': { 'arg1': ['UserDefOne'] },
@@ -1104,6 +1145,7 @@ Example:
         int64_t integer;
         bool has_string;
         char *string;
+        bool defaultbool;
     };
=20
     void qapi_free_UserDefOne(UserDefOne *obj);
@@ -1207,6 +1249,7 @@ Example:
     void visit_type_UserDefOne_members(Visitor *v, UserDefOne *obj, Erro=
r **errp)
     {
         Error *err =3D NULL;
+        bool has_optional;
=20
         visit_type_int(v, "integer", &obj->integer, &err);
         if (err) {
@@ -1218,6 +1261,14 @@ Example:
                 goto out;
             }
         }
+        if (visit_optional(v, "defaultbool", &has_optional)) {
+            visit_type_bool(v, "defaultbool", &obj->defaultbool, &err);
+            if (err) {
+                goto out;
+            }
+        } else {
+            obj->defaultbool =3D true;
+        }
=20
     out:
         error_propagate(errp, err);
@@ -1563,6 +1614,12 @@ Example:
                     { "type", QLIT_QSTR("str"), },
                     {}
                 })),
+                QLIT_QDICT(((QLitDictEntry[]) {
+                    { "default", QLIT_QBOOL(true), },
+                    { "name", QLIT_QSTR("defaultbool"), },
+                    { "type", QLIT_QSTR("bool"), },
+                    {}
+                })),
                 {}
             })), },
             { "meta-type", QLIT_QSTR("object"), },
--=20
2.21.0


