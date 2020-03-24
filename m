Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D2EC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304B920409
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuOpLZqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304B920409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGswa-0000XI-Bg
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 19:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jGsrz-0007OL-Fa
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jGsry-0001um-Ez
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35141)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jGsry-0001uN-BB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585092122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6th2KXUCkzQob2JQhRnRr1jEfvNjxfK+wSIvI61wEd4=;
 b=MuOpLZqF7ZNMj8S93CtLeIsZbJ4HRV2El02Bdm3iWH4hIRnYkvtecJ4CkwUd3q6/aH2+ju
 3DG9pLh7TqmzV9KooQHBPz50AwPaWIEW4qUr4GV0Bd7OU/53H1HhbO5dxYACKclRJ8Ng9X
 MjrSEk5uY+ATrqfN7kRXLAzNAQUJ69Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-zMaBxFDnNVyawznrXGs11w-1; Tue, 24 Mar 2020 19:21:58 -0400
X-MC-Unique: zMaBxFDnNVyawznrXGs11w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD832801F76;
 Tue, 24 Mar 2020 23:21:48 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1E205D9C5;
 Tue, 24 Mar 2020 23:21:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 05/14] iotests: add pylintrc file
Date: Tue, 24 Mar 2020 19:20:54 -0400
Message-Id: <20200324232103.4195-6-jsnow@redhat.com>
In-Reply-To: <20200324232103.4195-1-jsnow@redhat.com>
References: <20200324232103.4195-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows others to get repeatable results with pylint. If you run
`pylint iotests.py`, you should see a 100% pass.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/pylintrc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 tests/qemu-iotests/pylintrc

diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
new file mode 100644
index 0000000000..8720b6a0de
--- /dev/null
+++ b/tests/qemu-iotests/pylintrc
@@ -0,0 +1,22 @@
+[MESSAGES CONTROL]
+
+# Disable the message, report, category or checker with the given id(s). Y=
ou
+# can either give multiple identifiers separated by comma (,) or put this
+# option multiple times (only on the command line, not in the configuratio=
n
+# file where it should appear only once). You can also use "--disable=3Dal=
l" to
+# disable everything first and then reenable specific checks. For example,=
 if
+# you want to run only the similarities checker, you can use "--disable=3D=
all
+# --enable=3Dsimilarities". If you want to run only the classes checker, b=
ut have
+# no Warning level messages displayed, use "--disable=3Dall --enable=3Dcla=
sses
+# --disable=3DW".
+disable=3Dinvalid-name,
+        no-else-return,
+        too-many-lines,
+        too-few-public-methods,
+        too-many-arguments,
+        too-many-locals,
+        too-many-branches,
+        too-many-public-methods,
+        # These are temporary, and should be removed:
+        missing-docstring,
+        line-too-long,
--=20
2.21.1


