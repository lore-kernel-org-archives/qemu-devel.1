Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D312C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259F020726
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMc6Gq5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259F020726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vrm-0000wu-A2
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpO-0004Rz-Na
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpN-0006qY-IG
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpN-0006qQ-Eb
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJjhiL1jL4z2tHRoIb8SPObvUXvwr23wJcik9StiPKU=;
 b=YMc6Gq5OBgf/keHSpjXrijqkWjOgfoeFWvCtEUPO+KWGKSdqb/aaDmuzZhxwPar7Uojc58
 3/OfR30mZ6t3PWulnIdD4YrhEYwiHtLtobVTsqdgfnDb3rMLyNwB3nAv1gITiRvKPdvQUP
 zbxk1bK7k/vMzHZMnU0PK8d/GO+MGhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-OVuLnBQ3PA-3G9HlK_Q8Jw-1; Sat, 15 Feb 2020 06:41:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8CD71005512;
 Sat, 15 Feb 2020 11:41:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9BB95C114;
 Sat, 15 Feb 2020 11:41:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4BC7C1136363; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/18] qapi/ui.json: Avoid `...' Texinfo style quoting
Date: Sat, 15 Feb 2020 12:41:29 +0100
Message-Id: <20200215114133.15097-15-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: OVuLnBQ3PA-3G9HlK_Q8Jw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Avoid Texinfo style quoting with `...', because we would like to
switch the doc comments to rST format, and rST treats it as a syntax
error. Use '...' instead, as we do in other doc comments. This looks
OK in Texinfo, and rST formats it as paired-quotation-marks.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200213175647.17628-13-peter.maydell@linaro.org>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/ui.json | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index e8b8b708c7..088a8680ef 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -12,16 +12,16 @@
 #
 # Sets the password of a remote display session.
 #
-# @protocol: `vnc' to modify the VNC server password
-#            `spice' to modify the Spice server password
+# @protocol: 'vnc' to modify the VNC server password
+#            'spice' to modify the Spice server password
 #
 # @password: the new password
 #
 # @connected: how to handle existing clients when changing the
-#             password.  If nothing is specified, defaults to `keep'
-#             `fail' to fail the command if clients are connected
-#             `disconnect' to disconnect existing clients
-#             `keep' to maintain existing clients
+#             password.  If nothing is specified, defaults to 'keep'
+#             'fail' to fail the command if clients are connected
+#             'disconnect' to disconnect existing clients
+#             'keep' to maintain existing clients
 #
 # Returns: Nothing on success
 #          If Spice is not enabled, DeviceNotFound
@@ -43,16 +43,16 @@
 #
 # Expire the password of a remote display server.
 #
-# @protocol: the name of the remote display protocol `vnc' or `spice'
+# @protocol: the name of the remote display protocol 'vnc' or 'spice'
 #
 # @time: when to expire the password.
-#        `now' to expire the password immediately
-#        `never' to cancel password expiration
-#        `+INT' where INT is the number of seconds from now (integer)
-#        `INT' where INT is the absolute time in seconds
+#        'now' to expire the password immediately
+#        'never' to cancel password expiration
+#        '+INT' where INT is the number of seconds from now (integer)
+#        'INT' where INT is the absolute time in seconds
 #
 # Returns: Nothing on success
-#          If @protocol is `spice' and Spice is not active, DeviceNotFound
+#          If @protocol is 'spice' and Spice is not active, DeviceNotFound
 #
 # Since: 0.14.0
 #
--=20
2.21.1


