Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C9CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B780F20874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbK81xCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B780F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOqZ-0002jX-FZ
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iPOeC-0005U2-8w
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iPOeB-0001Ag-4W
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iPOeB-0001AH-0A
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572344562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a+fRf+3erE8+48yu1hfN6R/KqPIH/A3PzMRXUb2aQnk=;
 b=PbK81xChpiP8t/cy4iD//lq97Zppi3/mdgl+KHDDVud7QkPr1K6MnzW+5txsIbWlyBStO7
 jxkNR5NRqKT2xyaYT+CB/wxy58bZq59tEJ3TjvaV98eTIELqbr8DbhDP8z4Fd+ZFfou6Bh
 fjDAnpyFA+Kd8iOJdq/FI45FVlTeT8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-of8pGXh8PamXd7pm3CUQBA-1; Tue, 29 Oct 2019 06:22:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C43E801E64
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BA9B60863
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 10:22:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 86B541132E8F; Tue, 29 Oct 2019 11:22:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/19] tests/qapi-schema: Cover alternate documentation comments
Date: Tue, 29 Oct 2019 11:22:12 +0100
Message-Id: <20191029102228.20740-4-armbru@redhat.com>
In-Reply-To: <20191029102228.20740-1-armbru@redhat.com>
References: <20191029102228.20740-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: of8pGXh8PamXd7pm3CUQBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20191024110237.30963-4-armbru@redhat.com>
---
 tests/qapi-schema/doc-good.texi | 17 +++++++++++++++++
 tests/qapi-schema/doc-good.json |  8 ++++++++
 tests/qapi-schema/doc-good.out  | 12 ++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.t=
exi
index d6ecdac94f..98aa78e1fb 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -170,6 +170,23 @@ One of @t{"one"}, @t{"two"}
 @end deftp
=20
=20
+
+@deftp {Alternate} Alternate
+
+
+
+@b{Members:}
+@table @asis
+@item @code{i: int}
+an integer
+@code{b} is undocumented
+@item @code{b: boolean}
+Not documented
+@end table
+
+@end deftp
+
+
 @subsection Another subsection
=20
=20
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son
index 1ae6c3a9da..df50a877e3 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -98,6 +98,14 @@
 { 'union': 'SugaredUnion',
   'data': { 'one': 'Variant1', 'two': { 'type': 'Variant2', 'if': 'IFTWO' =
} } }
=20
+##
+# @Alternate:
+# @i: an integer
+# @b is undocumented
+##
+{ 'alternate': 'Alternate',
+  'data': { 'i': 'int', 'b': 'bool' } }
+
 ##
 # =3D=3D Another subsection
 ##
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t
index a8fc39d288..b0e99f2110 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -42,6 +42,10 @@ object SugaredUnion
     case one: q_obj_Variant1-wrapper
     case two: q_obj_Variant2-wrapper
         if ['IFTWO']
+alternate Alternate
+    tag type
+    case i: int
+    case b: bool
 object q_obj_cmd-arg
     member arg1: int optional=3DFalse
     member arg2: str optional=3DTrue
@@ -133,6 +137,14 @@ doc symbol=3DSugaredUnion
=20
     arg=3Dtype
=20
+doc symbol=3DAlternate
+    body=3D
+
+    arg=3Di
+an integer
+@b is undocumented
+    arg=3Db
+
 doc freeform
     body=3D
 =3D=3D Another subsection
--=20
2.21.0


