Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB37CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CF52064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVkOwReJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CF52064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpAl-0003ai-7M
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iMp1n-0002rz-8R
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iMp1l-0005vS-Qn
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49513
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iMp1l-0005um-Me
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571730985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axLsgmy+P8UU3qRtVgP1KKwlZjmV0UyPzLCHh5P7Wfc=;
 b=UVkOwReJ7gvZ1nYHP63sDeTLhLPKhq4GIpITBEgN3sr4lnfVAsjXIFlIyyabawset6GWvH
 yKTT0or5PGuuV0tg3MWMXIqikv/q9yWn8QbjAtMDc2gL4HPuahunoCypjwZUrNcX2ru7ne
 bUsTS7csSBimuVLQyhZQi9OtO9p3khk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-9pR6NL3rPxSEpWexXeLfWQ-1; Tue, 22 Oct 2019 03:56:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33C15107AD31
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 07:56:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAFD66012C;
 Tue, 22 Oct 2019 07:56:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F54C113294D; Tue, 22 Oct 2019 09:56:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] tests/qapi-schema: Cover feature documentation comments
Date: Tue, 22 Oct 2019 09:56:14 +0200
Message-Id: <20191022075615.956-12-armbru@redhat.com>
In-Reply-To: <20191022075615.956-1-armbru@redhat.com>
References: <20191022075615.956-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 9pR6NL3rPxSEpWexXeLfWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 8aa3a33e44 "tests/qapi-schema: Test for good feature lists in
structs" neglected to cover documentation comments, and the previous
commit followed its example.  Make up for them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191018081454.21369-5-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qapi-schema/doc-good.texi | 22 ++++++++++++++++++++++
 tests/qapi-schema/doc-good.json | 17 +++++++++++++++--
 tests/qapi-schema/doc-good.out  |  5 +++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.t=
exi
index 2526abc6d9..2ce8b883c9 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -122,6 +122,12 @@ Not documented
 @*@b{If:} @code{defined(IFSTR)}
 @end table
=20
+@b{Features:}
+@table @asis
+@item @code{variant1-feat}
+a feature
+@end table
+
 @end deftp
=20
=20
@@ -182,6 +188,14 @@ argument
 Not documented
 @end table
=20
+@b{Features:}
+@table @asis
+@item @code{cmd-feat1}
+a feature
+@item @code{cmd-feat2}
+another feature
+@end table
+
 @b{Note:}
 @code{arg3} is undocumented
=20
@@ -227,6 +241,14 @@ If you're bored enough to read this, go see a video of=
 boxed cats
=20
 @b{Arguments:} the members of @code{Object}
=20
+@b{Features:}
+@table @asis
+@item @code{cmd-feat1}
+a feature
+@item @code{cmd-feat2}
+another feature
+@end table
+
 @b{Example:}
 @example
 -> in
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son
index f7fb48af38..7dc21e58a3 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -71,8 +71,12 @@
 # A paragraph
 #
 # Another paragraph (but no @var: line)
+#
+# Features:
+# @variant1-feat: a feature
 ##
 { 'struct': 'Variant1',
+  'features': [ 'variant1-feat' ],
   'data': { 'var1': { 'type': 'str', 'if': 'defined(IFSTR)' } } }
=20
 ##
@@ -104,6 +108,10 @@
 #
 # @arg2: the second
 # argument
+#
+# Features:
+# @cmd-feat1: a feature
+# @cmd-feat2: another feature
 # Note: @arg3 is undocumented
 # Returns: @Object
 # TODO: frobnicate
@@ -123,11 +131,15 @@
 ##
 { 'command': 'cmd',
   'data': { 'arg1': 'int', '*arg2': 'str', 'arg3': 'bool' },
-  'returns': 'Object' }
+  'returns': 'Object',
+  'features': [ 'cmd-feat1', 'cmd-feat2' ] }
=20
 ##
 # @cmd-boxed:
 # If you're bored enough to read this, go see a video of boxed cats
+# Features:
+# @cmd-feat1: a feature
+# @cmd-feat2: another feature
 # Example:
 #
 # -> in
@@ -135,4 +147,5 @@
 # <- out
 ##
 { 'command': 'cmd-boxed', 'boxed': true,
-  'data': 'Object' }
+  'data': 'Object',
+  'features': [ 'cmd-feat1', 'cmd-feat2' ] }
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t
index 6562e1f412..f78fdef6a9 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -20,6 +20,7 @@ object Base
 object Variant1
     member var1: str optional=3DFalse
         if ['defined(IFSTR)']
+    feature variant1-feat
 object Variant2
 object Object
     base Base
@@ -47,8 +48,12 @@ object q_obj_cmd-arg
     member arg3: bool optional=3DFalse
 command cmd q_obj_cmd-arg -> Object
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
+    feature cmd-feat1
+    feature cmd-feat2
 command cmd-boxed Object -> None
     gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
+    feature cmd-feat1
+    feature cmd-feat2
 doc freeform
     body=3D
 =3D Section
--=20
2.21.0


