Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8175EC388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A401223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOd7BtOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A401223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka76X-0002XD-5i
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nK-0006S4-V6
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nD-0004qW-DL
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=McaAvtGLW0Lxx0emY5hblWCCh4ECxYbmLwQZTo/NtfY=;
 b=eOd7BtOzVESWR5VunSq4oQ5t19foP5gYjmrX9ZyilStVm+lIEvuwvyi4j/6kisYBroq94Y
 fb58oMWYim5hGcjPqBjjKZDbygCB1lZIG5t5QDrDoMPoByoy0nB8bxnBsu4t5yHXiMYAwJ
 ERuPyBjV5t5bwDIrVDZz7Dxzc6eimV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-M0T4-NZpM_K_ZOzAOUZWhA-1; Tue, 03 Nov 2020 19:36:46 -0500
X-MC-Unique: M0T4-NZpM_K_ZOzAOUZWhA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 737C3806B21
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:37 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B135255766;
 Wed,  4 Nov 2020 00:36:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 21/72] scripts/qemu-ga-client: add module docstring
Date: Tue,  3 Nov 2020 19:35:11 -0500
Message-Id: <20201104003602.1293560-22-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Turn that nice usage comment into a docstring.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qemu-ga-client | 65 +++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index 73d262e8beb4..1061d2eb1437 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -1,41 +1,42 @@
 #!/usr/bin/env python3
 
-# QEMU Guest Agent Client
-#
 # Copyright (C) 2012 Ryota Ozaki <ozaki.ryota@gmail.com>
 #
 # This work is licensed under the terms of the GNU GPL, version 2.  See
 # the COPYING file in the top-level directory.
-#
-# Usage:
-#
-# Start QEMU with:
-#
-# # qemu [...] -chardev socket,path=/tmp/qga.sock,server,nowait,id=qga0 \
-#   -device virtio-serial \
-#   -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
-#
-# Run the script:
-#
-# $ qemu-ga-client --address=/tmp/qga.sock <command> [args...]
-#
-# or
-#
-# $ export QGA_CLIENT_ADDRESS=/tmp/qga.sock
-# $ qemu-ga-client <command> [args...]
-#
-# For example:
-#
-# $ qemu-ga-client cat /etc/resolv.conf
-# # Generated by NetworkManager
-# nameserver 10.0.2.3
-# $ qemu-ga-client fsfreeze status
-# thawed
-# $ qemu-ga-client fsfreeze freeze
-# 2 filesystems frozen
-#
-# See also: https://wiki.qemu.org/Features/QAPI/GuestAgent
-#
+
+"""
+QEMU Guest Agent Client
+
+Usage:
+
+Start QEMU with:
+
+# qemu [...] -chardev socket,path=/tmp/qga.sock,server,nowait,id=qga0 \
+  -device virtio-serial \
+  -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
+
+Run the script:
+
+$ qemu-ga-client --address=/tmp/qga.sock <command> [args...]
+
+or
+
+$ export QGA_CLIENT_ADDRESS=/tmp/qga.sock
+$ qemu-ga-client <command> [args...]
+
+For example:
+
+$ qemu-ga-client cat /etc/resolv.conf
+# Generated by NetworkManager
+nameserver 10.0.2.3
+$ qemu-ga-client fsfreeze status
+thawed
+$ qemu-ga-client fsfreeze freeze
+2 filesystems frozen
+
+See also: https://wiki.qemu.org/Features/QAPI/GuestAgent
+"""
 
 import argparse
 import base64
-- 
2.26.2


