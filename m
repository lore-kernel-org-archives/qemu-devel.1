Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5DCC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8555327396
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIJWHYfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8555327396
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqgc-00006y-L2
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:23:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUU-0007TW-DZ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUT-0004c6-AU
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUQ-0003wn-3B
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id m3so12922809wrv.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id:in-reply-to:references;
	bh=24E6ZqLnqNyFbdN4STnHa0w5tRYTyGrJT58JpATqj/Q=;
	b=ZIJWHYfB5JDi1cw/7BIxAxai/lsUauuk3KCy4a695HtVfh/5qm3dRxO1ipHCTqRPW8
	/Do33tXSHArmS3rxDjP9ykk6slDHZJiEI8DCX4mhb8//9DhiqjxyOUFNFOGp9pWtwMIV
	32zUaxPSn2aCyZl1MTD6a7v/nMQQPbIm3SBEkh/pN2+MesWKRWNMkaw22X85D8+y6fx0
	ugP+os07uDAOWy95qH8MtmVigjssi9TKDpD0gb6qeww+MJSxzLxTS2V3Rrnfxhr8gEbm
	sOXLn4RzOlq/QDesyDsxYM5vFoCjqJLUTyL/10cHSipndBAVYSpEAaiMaOc5co2hWElX
	HjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id
	:in-reply-to:references;
	bh=24E6ZqLnqNyFbdN4STnHa0w5tRYTyGrJT58JpATqj/Q=;
	b=H5YmINDLc6q0E1ECi5BZ3EF+vkDIElgpV0tAYfHEy9yKiu31m01Yvh7LKc9roC+mHg
	7+CySiMYKK2rT4Ci7SY7pcNq5INFxnbiv7xAJcMw43kxiRYkXot+WRhtnuc1ztR8InfH
	K/iIZ8wj/F5rNo28BdtT0NOXQgiPhJrs5QXd+OLV5ftyePCLNDUbplFJOrY+PbkT4Cbs
	Q+9x4/+mfyje+1rHjFeLY6/2kPRNv2uVrCzfwOZKl+PrhgXyhKNS3mqBKypgs3qGo+ws
	XWkIm2PsowmnN9pu6dvK4Dn2SAV4EakqRjU4Zr88d68TeTjhvF6qxlPfqiaBk/i3wHWB
	bYTw==
X-Gm-Message-State: APjAAAWhqHv+pKbrvBS8smwBtWsOb+BhbHKIy/1adFpYjAlKSSJjldgv
	1RKZ52pQbsnU/TXoTLcOH4tzJTMT
X-Google-Smtp-Source: APXvYqzUR22i7jPDd+2pZxwtSV7aDyYaSnwiCLNNeum1e0fylxBJC671UgObR5MxxrFsxnLvvebndA==
X-Received: by 2002:adf:ba47:: with SMTP id t7mr16704771wrg.175.1559581855824; 
	Mon, 03 Jun 2019 10:10:55 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.10.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:10:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:29 +0200
Message-Id: <1559581843-3968-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 10/24] qgraph: fix qos_node_contains with options
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, if qos_node_contains was passed options, it would still
create an edge without any options.  Instead, in that case
NULL acts as a terminator.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/libqos/qgraph.c | 12 ++++++++----
 tests/libqos/qgraph.h | 15 +++++++++------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/tests/libqos/qgraph.c b/tests/libqos/qgraph.c
index b149caa..7a7ae2a 100644
--- a/tests/libqos/qgraph.c
+++ b/tests/libqos/qgraph.c
@@ -632,15 +632,19 @@ void qos_node_create_driver(const char *name, QOSCreateDriverFunc function)
 }
 
 void qos_node_contains(const char *container, const char *contained,
-                       ...)
+                       QOSGraphEdgeOptions *opts, ...)
 {
     va_list va;
-    va_start(va, contained);
-    QOSGraphEdgeOptions *opts;
 
+    if (opts == NULL) {
+        add_edge(container, contained, QEDGE_CONTAINS, NULL);
+        return;
+    }
+
+    va_start(va, opts);
     do {
-        opts = va_arg(va, QOSGraphEdgeOptions *);
         add_edge(container, contained, QEDGE_CONTAINS, opts);
+        opts = va_arg(va, QOSGraphEdgeOptions *);
     } while (opts != NULL);
 
     va_end(va);
diff --git a/tests/libqos/qgraph.h b/tests/libqos/qgraph.h
index e799095..3a25dda 100644
--- a/tests/libqos/qgraph.h
+++ b/tests/libqos/qgraph.h
@@ -453,14 +453,16 @@ void qos_node_create_machine_args(const char *name,
 void qos_node_create_driver(const char *name, QOSCreateDriverFunc function);
 
 /**
- * qos_node_contains(): creates an edge of type QEDGE_CONTAINS and
- * adds it to the edge list mapped to @container in the
+ * qos_node_contains(): creates one or more edges of type QEDGE_CONTAINS
+ * and adds them to the edge list mapped to @container in the
  * edge hash table.
  *
- * This edge will have @container as source and @contained as destination.
+ * The edges will have @container as source and @contained as destination.
  *
- * It also has the possibility to add optional NULL-terminated
- * @opts parameters (see %QOSGraphEdgeOptions)
+ * If @opts is NULL, a single edge will be added with no options.
+ * If @opts is non-NULL, the arguments after @contained represent a
+ * NULL-terminated list of %QOSGraphEdgeOptions structs, and an
+ * edge will be added for each of them.
  *
  * This function can be useful when there are multiple devices
  * with the same node name contained in a machine/other node
@@ -480,7 +482,8 @@ void qos_node_create_driver(const char *name, QOSCreateDriverFunc function);
  * For contains, op1.arg and op1.size_arg represent the arg to pass
  * to @contained constructor to properly initialize it.
  */
-void qos_node_contains(const char *container, const char *contained, ...);
+void qos_node_contains(const char *container, const char *contained,
+                       QOSGraphEdgeOptions *opts, ...);
 
 /**
  * qos_node_produces(): creates an edge of type QEDGE_PRODUCES and
-- 
1.8.3.1



