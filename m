Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA660C04AAD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 08:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF6C216B7
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 08:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF6C216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33416 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOIPY-0000Pz-PO
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 04:58:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOINj-0007T9-VI
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOINj-0002wA-16
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:56:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOINi-0002uX-QL
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:56:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D16B3086216;
	Wed,  8 May 2019 08:56:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A37A3DBE;
	Wed,  8 May 2019 08:56:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id C7DE8A1E2; Wed,  8 May 2019 10:56:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 10:56:35 +0200
Message-Id: <20190508085645.11595-4-kraxel@redhat.com>
In-Reply-To: <20190508085645.11595-1-kraxel@redhat.com>
References: <20190508085645.11595-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 08 May 2019 08:56:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 03/13] tests/vm: send locale environment
 variables over ssh
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Needed for unicode tests.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/basevm.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 6b46674f4497..20eec5420dbf 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -43,6 +43,20 @@ class BaseVM(object):
         "http_proxy",
         "ftp_proxy",
         "no_proxy",
+        "LANG",
+        "LC_CTYPE",
+        "LC_NUMERIC",
+        "LC_TIME",
+        "LC_COLLATE",
+        "LC_MONETARY",
+        "LC_MESSAGES",
+        "LC_PAPER",
+        "LC_NAME",
+        "LC_ADDRESS",
+        "LC_TELEPHONE",
+        "LC_MEASUREMENT",
+        "LC_IDENTIFICATION",
+        "LC_ALL",
     ]
 
     # The script to run in the guest that builds QEMU
-- 
2.18.1


