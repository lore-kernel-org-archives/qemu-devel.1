Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7F7C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047A92251D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anRInmm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047A92251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPX1-0008Go-5R
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXPVg-0007Li-6S
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:55:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXPVc-00074M-JH
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:55:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51032
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXPVc-00074D-F7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574254499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PBtQW3JgtcXiZWsJbV2Q+KBMPeHyfg1D42PxExr6LsA=;
 b=anRInmm7xOeAP9stzx8WzUM5t+iRO0WV0oIey49UxXuhYO7ZVCfi/JHkonT5T5cp0PzR82
 Dw7dQA3SrLsGQpr+xbIOeg9PF07ma33eWygbNlu1CSqTW1H0xa4BACaUntKVUDkSvBKxNv
 irA+mq70M0KrSVLtqtpLPfwAQa2++PQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-egkVlXrCNaeAbveVTBmOPg-1; Wed, 20 Nov 2019 07:54:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31E9D107ACC5;
 Wed, 20 Nov 2019 12:54:53 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6702410375DC;
 Wed, 20 Nov 2019 12:54:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] RFC: CODING_STYLE: describe "self" variable convention
Date: Wed, 20 Nov 2019 16:54:44 +0400
Message-Id: <20191120125444.31365-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: egkVlXrCNaeAbveVTBmOPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following the discussion in thread "[PATCH v3 13/33] serial: start
making SerialMM a sysbus device", I'd like to recommend the usage of
"self" variable to reference to the OOP-style method instance, as
commonly done in various languages and in GObject world.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 CODING_STYLE.rst | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
index 427699e0e4..cb6635af71 100644
--- a/CODING_STYLE.rst
+++ b/CODING_STYLE.rst
@@ -102,12 +102,38 @@ Rationale:
 Naming
 =3D=3D=3D=3D=3D=3D
=20
-Variables are lower_case_with_underscores; easy to type and read.  Structu=
red
-type names are in CamelCase; harder to type but standing out.  Enum type
-names and function type names should also be in CamelCase.  Scalar type
-names are lower_case_with_underscores_ending_with_a_t, like the POSIX
-uint64_t and family.  Note that this last convention contradicts POSIX
-and is therefore likely to be changed.
+Variables are lower_case_with_underscores; easy to type and read.
+
+The most common naming for a variable is an abbreviation of the type
+name.  Some common examples:
+
+.. code-block:: c
+
+    Object *obj;
+    QVirtioSCSI *scsi;
+    SerialMM *smm;
+
+When writing QOM/OOP-style function, a "self" variable allows to refer
+without ambiguity to the instance of the method that is being
+implemented (this is not very common in QEMU code base, but it is
+often a good option to increase the readability and consistency,
+making further refactoring easier as well).  Example:
+
+.. code-block:: c
+
+    serial_mm_flush(SerialMM *self);
+
+    serial_mm_instance_init(Object *o) {
+        SerialMM *self =3D SERIAL_MM(o);
+        ..
+    }
+
+Structured type names are in CamelCase; harder to type but standing
+out.  Enum type names and function type names should also be in
+CamelCase.  Scalar type names are
+lower_case_with_underscores_ending_with_a_t, like the POSIX uint64_t
+and family.  Note that this last convention contradicts POSIX and is
+therefore likely to be changed.
=20
 When wrapping standard library functions, use the prefix ``qemu_`` to aler=
t
 readers that they are seeing a wrapped version; otherwise avoid this prefi=
x.
--=20
2.24.0


