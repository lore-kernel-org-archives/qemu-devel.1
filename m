Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEA9C49ED6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A75420872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A75420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ZoT-0006Ru-7o
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 02:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i7ZmO-0004kD-9f
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i7ZmL-0007hC-JK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i7ZmL-0007gc-Au
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31868C05AA72;
 Tue, 10 Sep 2019 06:37:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B6DD60925;
 Tue, 10 Sep 2019 06:37:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C87611655F0; Tue, 10 Sep 2019 08:37:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 08:37:12 +0200
Message-Id: <20190910063724.28470-5-armbru@redhat.com>
In-Reply-To: <20190910063724.28470-1-armbru@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 10 Sep 2019 06:37:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 04/16] docs/devel/qapi-code-gen: Minor
 specification fixes
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The specification claims "Each expression that isn't an include
directive may be preceded by a documentation block", but the code also
rejects them for pragma directives.  The code is correct.  Fix the
specification.

The specification reserves member names starting with 'has_', but the
code also reserves name 'u'.  Fix the specification.

The specification claims "The string 'max' is not allowed as an enum
value".  Untrue.  Fix the specification.  While there, delete the
naming advice, because it's redundant with the naming rules in section
"Schema overview"

The specification claims "No branch of the union can be named 'max',
as this would collide with the implicit enum".  Untrue.  Fix the
specification.

The specification claims "It is not allowed to name an event 'MAX',
since the generator also produces a C enumeration of all event names
with a generated _MAX value at the end."  Untrue.  Fix the
specification.

The specification claims "All branches of the union must be complex
types", but the code permits only struct types.  The code is correct.
Fix the specification.

The specification claims a command's return type "must be the string
name of a complex or built-in type, a one-element array containing the
name of a complex or built-in type" unless the command is in pragma
'returns-whitelist'.  The code does not permit built-in types.  Fix
the specification.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 3d3931fb7a..4ce67752a7 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -117,9 +117,9 @@ Example:
=20
 =3D=3D=3D=3D Expression documentation =3D=3D=3D=3D
=20
-Each expression that isn't an include directive may be preceded by a
-documentation block.  Such blocks are called expression documentation
-blocks.
+Expressions other than include and pragma directives may be preceded
+by a documentation block.  Such blocks are called expression
+documentation blocks.
=20
 When documentation is required (see pragma 'doc-required'), expression
 documentation blocks are mandatory.
@@ -243,8 +243,9 @@ underscore.
=20
 Event names should be ALL_CAPS with words separated by underscore.
=20
-Member names starting with 'has-' or 'has_' are reserved for the
-generator, which uses them for tracking optional members.
+Member name 'u' and names starting with 'has-' or 'has_' are reserved
+for the generator, which uses them for unions and for tracking
+optional members.
=20
 Any name (command, event, type, member, or enum value) beginning with
 "x-" is marked experimental, and may be withdrawn or changed
@@ -460,15 +461,14 @@ discriminator value, as in these examples:
=20
 The generated C code uses a struct containing a union. Additionally,
 an implicit C enum 'NameKind' is created, corresponding to the union
-'Name', for accessing the various branches of the union.  No branch of
-the union can be named 'max', as this would collide with the implicit
-enum.  The value for each branch can be of any type.
+'Name', for accessing the various branches of the union.  The value
+for each branch can be of any type.
=20
 A flat union definition avoids nesting on the wire, and specifies a
 set of common members that occur in all variants of the union.  The
 'base' key must specify either a type name (the type must be a
 struct, not a union), or a dictionary representing an anonymous type.
-All branches of the union must be complex types, and the top-level
+All branches of the union must be struct types, and the top-level
 members of the union dictionary on the wire will be combination of
 members from both the base type and the appropriate branch type (when
 merging two dictionaries, there must be no keys in common).  The
@@ -578,8 +578,8 @@ The 'returns' member describes what will appear in th=
e "return" member
 of a Client JSON Protocol reply on successful completion of a command.
 The member is optional from the command declaration; if absent, the
 "return" member will be an empty dictionary.  If 'returns' is present,
-it must be the string name of a complex or built-in type, a
-one-element array containing the name of a complex or built-in type.
+it must be the string name of a complex type, or a
+one-element array containing the name of a complex type.
 To return anything else, you have to list the command in pragma
 'returns-whitelist'.  If you do this, the command cannot be extended
 to return additional information in the future.  Use of
@@ -691,13 +691,11 @@ started with --preconfig.
 Usage: { 'event': STRING, '*data': COMPLEX-TYPE-NAME-OR-DICT,
          '*boxed': true }
=20
-Events are defined with the keyword 'event'.  It is not allowed to
-name an event 'MAX', since the generator also produces a C enumeration
-of all event names with a generated _MAX value at the end.  When
-'data' is also specified, additional info will be included in the
-event, with similar semantics to a 'struct' expression.  Finally there
-will be C API generated in qapi-events.h; when called by QEMU code, a
-message with timestamp will be emitted on the wire.
+Events are defined with the keyword 'event'.  When 'data' is also
+specified, additional info will be included in the event, with similar
+semantics to a 'struct' expression.  Finally there will be C API
+generated in qapi-events.h; when called by QEMU code, a message with
+timestamp will be emitted on the wire.
=20
 An example event is:
=20
--=20
2.21.0


