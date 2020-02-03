Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B89C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D64D2086A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agEZ5zQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D64D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycV0-0003xD-4t
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iycUR-0003Iw-Si
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iycUP-0005AF-Nn
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:14:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iycUP-00059y-Jx
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580739252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZPa3F4My4Ne6fNlLkcylcGuupLx98vBFZJUAzjjHMws=;
 b=agEZ5zQhYINRY1CNNW6Wag3GRJRTmR4A3tQzlJiFixdu/B5KI+rxPxTrqSf7DaT0jej+yo
 yH+f9GKMDIrbZtmr/tbnebGUX7qJmCWKu7PdXmuxVPn6QbApr5XopsTi8p+wXIQQqFMOiX
 mCTjnLbnoHhVb7uK8th8H7qlsAeCcGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-VQX2dWeSMrWyQBtnqwIWHA-1; Mon, 03 Feb 2020 09:13:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A46A100CEA4;
 Mon,  3 Feb 2020 14:13:53 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8E3B60BE2;
 Mon,  3 Feb 2020 14:13:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [qemu-web PATCH v2] Update the documentation links to point to our
 generated docs
Date: Mon,  3 Feb 2020 15:13:46 +0100
Message-Id: <20200203141346.11790-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: VQX2dWeSMrWyQBtnqwIWHA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are now providing the generated QEMU documentation files directly
on our www.qemu.org webserver, so we should link to these files now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Do not link to qemu-doc anymore, use the index page instead

 _includes/footer.html |  2 +-
 documentation.md      | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/_includes/footer.html b/_includes/footer.html
index 1669ef7..b71663b 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -14,7 +14,7 @@
 =09=09</ul>
 =09=09<ul class=3D"style">
 =09=09=09<li><a href=3D"/documentation">Documentation</a></li>
-=09=09=09<li><a href=3D"https://qemu.weilnetz.de/qemu-doc.html">Manual</a>=
</li>
+=09=09=09<li><a href=3D"https://www.qemu.org/docs/master/">Main docs</a></=
li>
 =09=09=09<li><a href=3D"https://wiki.qemu.org/Category:Developer_documenta=
tion">Developer docs</a></li>
 =09=09=09<li><a href=3D"https://wiki.qemu.org/">Wiki</a></li>
 =09=09</ul>
diff --git a/documentation.md b/documentation.md
index f4ef9f4..bb3cc82 100644
--- a/documentation.md
+++ b/documentation.md
@@ -3,9 +3,14 @@ title: QEMU documentation
 permalink: /documentation/
 ---
=20
-The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be read=
 online, courtesy of Stefan Weil.
-More documentation is found in the <a href=3D"https://git.qemu.org/?p=3Dqe=
mu.git;a=3Dtree;f=3Ddocs;hb=3Dmaster">`docs`</a>
-directory of the QEMU git tree.
+The [main documentation section](https://www.qemu.org/docs/master/)
+is the first place to go in case you have questions about using QEMU.
+
+Most of the documentation is generated automatically from the QEMU git sou=
rce
+tree, however some text files have not been converted to the new format ye=
t.
+These documentation files can be browsed via the
+[git web interface](https://git.qemu.org/?p=3Dqemu.git;a=3Dtree;f=3Ddocs;h=
b=3Dmaster)
+instead.
=20
 The [QEMU wiki](https://wiki.qemu.org) contains more
 [user documentation](https://wiki.qemu.org/Category:User_documentation) an=
d
--=20
2.18.1


