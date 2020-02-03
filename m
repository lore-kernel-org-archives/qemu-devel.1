Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E753AC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68F620674
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNLTslPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68F620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybeO-0003Yg-Sn
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iybdg-000326-BQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iybde-0007i5-Fx
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:19:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iybde-0007ge-89
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580735981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YcmzjCJz74PmZ2mRWI2ZXmuykL60ouyYLjHRzWXGdaY=;
 b=gNLTslPpVyZacmR1LfF6E3SJZCO5XP9WMRZrn0xarjnQ8CW0nP2VikdpFQMthTB3qy7v14
 gR0aXzPVTCgEO0y9uAZQVed1TvLnKyLLuBCAlRsC7B/k8btgQg3yym/1vA/8cHDG79HO0B
 400dtjpljOr8X71cmarfVvEgo4w3rog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-X6RVlz0ZOLy4WxlmSJRpqw-1; Mon, 03 Feb 2020 08:19:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE30B13E5;
 Mon,  3 Feb 2020 13:19:26 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95DDD10013A7;
 Mon,  3 Feb 2020 13:19:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [qemu-web PATCH] Update the documentation links to point to our
 generated docs
Date: Mon,  3 Feb 2020 14:19:19 +0100
Message-Id: <20200203131919.9972-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: X6RVlz0ZOLy4WxlmSJRpqw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 _includes/footer.html |  2 +-
 documentation.md      | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/_includes/footer.html b/_includes/footer.html
index 1669ef7..e67ffd7 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -14,7 +14,7 @@
 =09=09</ul>
 =09=09<ul class=3D"style">
 =09=09=09<li><a href=3D"/documentation">Documentation</a></li>
-=09=09=09<li><a href=3D"https://qemu.weilnetz.de/qemu-doc.html">Manual</a>=
</li>
+=09=09=09<li><a href=3D"https://www.qemu.org/docs/master/qemu-doc.html">Us=
er manual</a></li>
 =09=09=09<li><a href=3D"https://wiki.qemu.org/Category:Developer_documenta=
tion">Developer docs</a></li>
 =09=09=09<li><a href=3D"https://wiki.qemu.org/">Wiki</a></li>
 =09=09</ul>
diff --git a/documentation.md b/documentation.md
index f4ef9f4..e96c39a 100644
--- a/documentation.md
+++ b/documentation.md
@@ -3,9 +3,17 @@ title: QEMU documentation
 permalink: /documentation/
 ---
=20
-The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be read=
 online, courtesy of Stefan Weil.
-More documentation is found in the <a href=3D"https://git.qemu.org/?p=3Dqe=
mu.git;a=3Dtree;f=3Ddocs;hb=3Dmaster">`docs`</a>
-directory of the QEMU git tree.
+The [QEMU user manual](https://www.qemu.org/docs/master/qemu-doc.html)
+is the first place to go in case you have questions about using QEMU.
+
+A lot of additional documentation can be found in our
+[documentation section](https://www.qemu.org/docs/master/)
+which is generated automatically from the QEMU git source tree.
+
+Some text files have not been converted to the new format yet, though.
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


