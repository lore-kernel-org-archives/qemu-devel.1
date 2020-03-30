Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066A4C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C1820780
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R20AAIox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C1820780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyYE-0005DU-Ja
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jIyX2-0003ul-D0
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jIyX0-0002UR-VY
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:49:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jIyX0-0002TD-Q2
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585590541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BjRh3n7W9wCZ2T9AUJwwlBIhZbgIsaYAjAJZOwoDAbA=;
 b=R20AAIoxtE7T8r1zyd02zAPfBleCsMHuJJKD9nQFHLtm7fwKUKhO4zrHdO1hoiDtsN0s00
 MOXU9Hzt33ua7tuvnqw4CHUeJTesajVeaMXTdnPg375w1vIe37Pd64wkTkMH+SOGPhONqZ
 VxKm0lRqjjZER462u9B8xyzTZEKXeIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-9XMsZIGANm2PKOWLz9DXzA-1; Mon, 30 Mar 2020 13:48:58 -0400
X-MC-Unique: 9XMsZIGANm2PKOWLz9DXzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16F9D104FB6D
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 17:48:57 +0000 (UTC)
Received: from localhost (unknown [10.36.110.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E87E35DA66;
 Mon, 30 Mar 2020 17:48:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs/devel/migration: start a debugging section
Date: Mon, 30 Mar 2020 19:48:52 +0200
Message-Id: <20200330174852.456148-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Explain how to use analyze-migration.py, this may help.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/migration.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index e88918f7639..2eb08624fc3 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -50,6 +50,26 @@ All these migration protocols use the same infrastructur=
e to
 save/restore state devices.  This infrastructure is shared with the
 savevm/loadvm functionality.
=20
+Debugging
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The migration stream can be analyzed thanks to `scripts/analyze_migration.=
py`.
+
+Example usage:
+
+.. code-block:: shell
+
+  $ qemu-system-x86_64
+   (qemu) migrate "exec:cat > mig"
+  $ ./scripts/analyze_migration.py -f mig
+  {
+    "ram (3)": {
+        "section sizes": {
+            "pc.ram": "0x0000000008000000",
+  ...
+
+See also ``analyze_migration.py -h`` help for more options.
+
 Common infrastructure
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
--=20
2.26.0.rc2.42.g98cedd0233


