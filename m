Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5056C0044D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 00:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA42206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 00:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5V6Dr5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA42206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE0Mk-0003RN-Re
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 20:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jE0IL-00045y-D0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jE0IJ-0005A0-EL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27687)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jE0II-00056K-Tg
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584405677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0We64aQWj81gfK4BjbGVkVQfRzyf3QTE+z185OEnM4=;
 b=L5V6Dr5Hxq7HmwDN08mEuIml2UgSoNrDUH91KnZVOtHM47iHrJXfJ3Pq03hNvn3Njdl58H
 jzMUAatQnbDPyqRW4yLEWgu7ovrjkafncbQMl11V0uzfqrKcFfgOjSH9grZa5YpJnqMuh7
 CFblBztJMCwn5hbS94qUUSzPhrPKAEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-dB8CC8YvOMWg0uqXm0WI_A-1; Mon, 16 Mar 2020 20:41:14 -0400
X-MC-Unique: dB8CC8YvOMWg0uqXm0WI_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF1488010C7;
 Tue, 17 Mar 2020 00:41:13 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 523F97A411;
 Tue, 17 Mar 2020 00:41:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 05/11] iotests: add pylintrc file
Date: Mon, 16 Mar 2020 20:40:59 -0400
Message-Id: <20200317004105.27059-6-jsnow@redhat.com>
In-Reply-To: <20200317004105.27059-1-jsnow@redhat.com>
References: <20200317004105.27059-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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


