Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE542C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE44D206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jrn04ao4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE44D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ipn-00011D-Qi
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ije-0000X4-FJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijd-0002hH-7I
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:10 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ijd-0002g3-0r
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:09 -0500
Received: by mail-wr1-x443.google.com with SMTP id m16so7782756wrx.11
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yvaniTNaVZq0Mihik+Rp3oNaMwVKeXRTQ0KV3KgYMSs=;
 b=Jrn04ao4kz1sf2I87ukxuP+3d1j9SrtJLv/gX70tylZGk3nbluTBiJG8iiPoc0VZdu
 Sp9Fg8aFui1RlyaNvS+ih7zWN/DJeckphHjw1qeY4E9V3iE4zaRLythZ47YmFSpzx7JO
 mKUZsZLRwBuE4RHPtreWe3wtZHkt9LGLp+OB+AmssqzYe8SyQp+LnVboUcnajlSeAvH5
 jEAygADwIWTryf7exIKJsIczVvUfp1+cZ3eDpacb4H7tyhtOx6zZb4Gfpv731Y2Kp47K
 G+LE3SBRyRbRzo0AVNpnOj1CEgva4q8rxRvHvqEfTv+U1gwZZ4GhZ6WrEMJgNgLv/8Ng
 YVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yvaniTNaVZq0Mihik+Rp3oNaMwVKeXRTQ0KV3KgYMSs=;
 b=T4b1Sq0QcaCCUoF9vg/ln9T9GHD3pUdWtpI+uVkn4re0OpVXdFMFtsKailpfzqzTIL
 wqRQHwirl+N9gzcXDHRTJQst8X8ORe6rp3CVyTtoCR4BmfI0HOa7cNI0HnEznP4NT8W9
 LHLX4oFpEqODuvmb2gFEjQFyeb8rFSnUYgJZBVkKu7hX8hDP3btelUljhw0hUvdfF5br
 vQJjLslqrKk2o9n2Vg67kzO9bVAqeZHs3Hd1JhJiG6yClSWDXyuf/1qg6ZiIHt6VG8WL
 CwgIbI6J1QWUZ8XmV0l/t/Y8lQxvLjV8W4K/OxEE10jYpPFbhZGCxbBAVx/QxyP2p6hT
 MNwg==
X-Gm-Message-State: APjAAAWCeZ0k+AmWOTNShzaxs3Np/NRSd/iBxGRFuux5COxTfHVkeEcC
 5kzHLKP8qENMmruAd9laVXApjZ4HHcM=
X-Google-Smtp-Source: APXvYqxpcHid7/tGU+ylIuNZdLr8vJmCJh5CWcxleKKuxKKnkXDd7MgGf4Daf8Nrn3NL8JOQemGofQ==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr22439671wrj.261.1581616627772; 
 Thu, 13 Feb 2020 09:57:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/30] qapi/ui.json: Avoid `...' texinfo style quoting
Date: Thu, 13 Feb 2020 17:56:29 +0000
Message-Id: <20200213175647.17628-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid texinfo style quoting with `...', because rST treats it
as a syntax error. Use '...' instead, as we do in other
doc comments. This looks OK in texinfo, and rST formats it as
paired-quotation-marks.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/ui.json | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index e8b8b708c72..088a8680efb 100644
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
-- 
2.20.1


