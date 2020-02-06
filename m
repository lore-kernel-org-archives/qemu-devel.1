Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4CAC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC67B20659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tV33zF9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC67B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlAD-0006fX-QE
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:42:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzz-0006lQ-I6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzv-0006IJ-1V
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:30 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzt-00064u-5P
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:26 -0500
Received: by mail-wr1-x442.google.com with SMTP id y11so8207609wrt.6
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GvBOG5pDxbUJVtePJMB2qE/bWoG9oTyZ0L26Rr3bxAo=;
 b=tV33zF9/Gr6SLw1w+P1Ch8ja8VKEeNslcRmhwOXEgmKQCewKKxBwFpGjvJd3PtLPdg
 hUdWYPeKM6vhkUpINmHj2X4iz7xKjCAZHerqPxETYOg25niyeBJnKpMvr7b2Gs63jPmk
 UfOsaL1LMfy/pWm3MmM1kn62sAJaxv8WRyrWu1NsL0ryaEOArSZ2ktt9pmdw9ePu+PTc
 uwNklCyZwlKBRlheR7CXjKJtPsd0SsBdX6d1j7nvVxdMUSFVQKQtfrjLHuPgIj9bopn3
 6tY4o5TsaF4VujoSCxzmTWaOdgifjejHowYl/WLV5ImbAVDVuud3VPCpZ/5EvPPzOM77
 Zz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GvBOG5pDxbUJVtePJMB2qE/bWoG9oTyZ0L26Rr3bxAo=;
 b=fjVnO31RJQeRYV6UrGuTqmzK97ICesXyWekkmJVA2/mg7h01AMBrA4haX/uGzeTpWj
 +OVIHMtM+fiIDCQePpNMWCARD6PYyBpBqhpraTrDOWiGLlho3G6PskqTXJl0JVUb0cH2
 PSQfhXshtyn9MRKPPzWmrAGiACb58Ah5swxOECJ7eunVkV6Xwf8nydTS/Amd+ShmfeVV
 oxB9MFjpBphpz0mlTNdUwdLyaBs/0P/7H20HhsytYCa1GBx1k2SxwlAAPBgst+K7DD/B
 JCXAamNr1WPpL+m7/JERdRaToO2YK6O5Q0JfjKmiC7utLCPGoVTqq+yCP7eewvY8gMWu
 T/3g==
X-Gm-Message-State: APjAAAUe218QJY5F6N8YTKsUEAdVVGWXxlOg+O6z9V8YoLHdBx59qWTp
 v7qVIfgvH4jP7vfMc14Mv2CcMSB6h2Q=
X-Google-Smtp-Source: APXvYqwMe5LTKGyKGtD4KA3RPu7CkrzpAPNrmdiwAY4sxX2kedeDwPVjMdWMksBjR5zvEcwwnJs8lA==
X-Received: by 2002:adf:fd43:: with SMTP id h3mr4820080wrs.169.1581010283004; 
 Thu, 06 Feb 2020 09:31:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/29] qapi/ui.json: Use explicit bulleted lists
Date: Thu,  6 Feb 2020 17:30:26 +0000
Message-Id: <20200206173040.17337-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

A JSON block comment like this:
 Returns: nothing on success
          If @node is not a valid block device, DeviceNotFound
          If @name is not found, GenericError with an explanation

renders in the HTML and manpage like this:

 Returns: nothing on success If node is not a valid block device,
 DeviceNotFound If name is not found, GenericError with an explanation

because whitespace is not significant.

Use an actual bulleted list, so that the formatting is correct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/ui.json | 63 +++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 92d409c32c8..f527bbdc26e 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -12,8 +12,8 @@
 #
 # Sets the password of a remote display session.
 #
-# @protocol: 'vnc' to modify the VNC server password
-#            'spice' to modify the Spice server password
+# @protocol: - 'vnc' to modify the VNC server password
+#            - 'spice' to modify the Spice server password
 #
 # @password: the new password
 #
@@ -23,8 +23,8 @@
 #             'disconnect' to disconnect existing clients
 #             'keep' to maintain existing clients
 #
-# Returns: Nothing on success
-#          If Spice is not enabled, DeviceNotFound
+# Returns: - Nothing on success
+#          - If Spice is not enabled, DeviceNotFound
 #
 # Since: 0.14.0
 #
@@ -46,13 +46,14 @@
 # @protocol: the name of the remote display protocol 'vnc' or 'spice'
 #
 # @time: when to expire the password.
-#        'now' to expire the password immediately
-#        'never' to cancel password expiration
-#        '+INT' where INT is the number of seconds from now (integer)
-#        'INT' where INT is the absolute time in seconds
 #
-# Returns: Nothing on success
-#          If @protocol is 'spice' and Spice is not active, DeviceNotFound
+#        - 'now' to expire the password immediately
+#        - 'never' to cancel password expiration
+#        - '+INT' where INT is the number of seconds from now (integer)
+#        - 'INT' where INT is the absolute time in seconds
+#
+# Returns: - Nothing on success
+#          - If @protocol is 'spice' and Spice is not active, DeviceNotFound
 #
 # Since: 0.14.0
 #
@@ -201,9 +202,10 @@
 # @tls-port: The SPICE server's TLS port number.
 #
 # @auth: the current authentication type used by the server
-#        'none'  if no authentication is being used
-#        'spice' uses SASL or direct TLS authentication, depending on command
-#                line options
+#
+#        - 'none'  if no authentication is being used
+#        - 'spice' uses SASL or direct TLS authentication, depending on command
+#          line options
 #
 # @mouse-mode: The mode in which the mouse cursor is displayed currently. Can
 #              be determined by the client or the server, or unknown if spice
@@ -433,27 +435,28 @@
 # @host: The hostname the VNC server is bound to.  This depends on
 #        the name resolution on the host and may be an IP address.
 #
-# @family: 'ipv6' if the host is listening for IPv6 connections
-#                    'ipv4' if the host is listening for IPv4 connections
-#                    'unix' if the host is listening on a unix domain socket
-#                    'unknown' otherwise
+# @family: - 'ipv6' if the host is listening for IPv6 connections
+#          - 'ipv4' if the host is listening for IPv4 connections
+#          - 'unix' if the host is listening on a unix domain socket
+#          - 'unknown' otherwise
 #
 # @service: The service name of the server's port.  This may depends
 #           on the host system's service database so symbolic names should not
 #           be relied on.
 #
 # @auth: the current authentication type used by the server
-#        'none' if no authentication is being used
-#        'vnc' if VNC authentication is being used
-#        'vencrypt+plain' if VEncrypt is used with plain text authentication
-#        'vencrypt+tls+none' if VEncrypt is used with TLS and no authentication
-#        'vencrypt+tls+vnc' if VEncrypt is used with TLS and VNC authentication
-#        'vencrypt+tls+plain' if VEncrypt is used with TLS and plain text auth
-#        'vencrypt+x509+none' if VEncrypt is used with x509 and no auth
-#        'vencrypt+x509+vnc' if VEncrypt is used with x509 and VNC auth
-#        'vencrypt+x509+plain' if VEncrypt is used with x509 and plain text auth
-#        'vencrypt+tls+sasl' if VEncrypt is used with TLS and SASL auth
-#        'vencrypt+x509+sasl' if VEncrypt is used with x509 and SASL auth
+#
+#        - 'none' if no authentication is being used
+#        - 'vnc' if VNC authentication is being used
+#        - 'vencrypt+plain' if VEncrypt is used with plain text authentication
+#        - 'vencrypt+tls+none' if VEncrypt is used with TLS and no authentication
+#        - 'vencrypt+tls+vnc' if VEncrypt is used with TLS and VNC authentication
+#        - 'vencrypt+tls+plain' if VEncrypt is used with TLS and plain text auth
+#        - 'vencrypt+x509+none' if VEncrypt is used with x509 and no auth
+#        - 'vencrypt+x509+vnc' if VEncrypt is used with x509 and VNC auth
+#        - 'vencrypt+x509+plain' if VEncrypt is used with x509 and plain text auth
+#        - 'vencrypt+tls+sasl' if VEncrypt is used with TLS and SASL auth
+#        - 'vencrypt+x509+sasl' if VEncrypt is used with x509 and SASL auth
 #
 # @clients: a list of @VncClientInfo of all currently connected clients
 #
@@ -841,8 +844,8 @@
 # @hold-time: time to delay key up events, milliseconds. Defaults
 #             to 100
 #
-# Returns: Nothing on success
-#          If key is unknown or redundant, InvalidParameter
+# Returns: - Nothing on success
+#          - If key is unknown or redundant, InvalidParameter
 #
 # Since: 1.3.0
 #
-- 
2.20.1


