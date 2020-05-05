Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE6CC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910B6206D7
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vz5nR6PF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910B6206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxDG-0006h4-IJ
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9t-0001Et-Ir
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38263
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9s-0000m4-EZ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fm8XXGHUuXORUfzHemUsdHhurQve0/uqxYuruDz3q3E=;
 b=Vz5nR6PFFem9z22fIg7+v1IbG75J1bB+QklDoYyGQMVBIvGCbOVchrcxM+E/J5kqzSSUC6
 kHYTm84w9jkc00aGSt6VLfhuCsVweTF7sgO9ZI3Hbl7PVTTC+qsO+L97Fk+YZjYjWFxPkI
 DtS8o2o8fRKwezZNyKGWumRCef6wIww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-5-ksvQ0TPoa2HUrMHW4o2A-1; Tue, 05 May 2020 08:58:40 -0400
X-MC-Unique: 5-ksvQ0TPoa2HUrMHW4o2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F5CA835B42;
 Tue,  5 May 2020 12:58:39 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24A787054F;
 Tue,  5 May 2020 12:58:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/24] iotests: add pylintrc file
Date: Tue,  5 May 2020 14:58:07 +0200
Message-Id: <20200505125826.1001451-6-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

This allows others to get repeatable results with pylint. If you run
`pylint iotests.py`, you should see a 100% pass.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200331000014.11581-6-jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/pylintrc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 tests/qemu-iotests/pylintrc

diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
new file mode 100644
index 0000000000..daec2c4942
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
+        too-few-public-methods,
+        too-many-arguments,
+        too-many-branches,
+        too-many-lines,
+        too-many-locals,
+        too-many-public-methods,
+        # These are temporary, and should be removed:
+        line-too-long,
+        missing-docstring,
--=20
2.26.2


