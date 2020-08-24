Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B98CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2475E206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="BMh2UdBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2475E206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAB23-00020T-DB
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 07:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=45nv=cc=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1kAAyW-0002cX-Pn
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:49:20 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:54836
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=45nv=cc=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1kAAyV-0003da-B9
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:49:20 -0400
Received: from MattGorko-Laptop.home
 (lfbn-idf1-1-1395-83.w90-79.abo.wanadoo.fr [90.79.87.83])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 18403410DA;
 Mon, 24 Aug 2020 13:49:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1598269758; bh=nQhKuNn3MwH4gOHTPOjyBvj9K5iVBhe1uEtgY1+8Dds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BMh2UdBDBRTCLH9JE6KNmq1jwO8SV/8t4zS41VqdiheLDoT2QwleB5IKfHVhNomiR
 JF/r4PeYTYISVolDRbOwuYzDdA1e9zeaYqkU6kYMdJqIkFKuSD+o7M/Mz19DJ1dlVP
 6VlXTKGB18ydaxZhxW5DmV9vtid1YSjDkuZx9DT0=
From: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/13] docs/system: Add U2F key to the USB devices examples
Date: Mon, 24 Aug 2020 13:48:23 +0200
Message-Id: <20200824114827.81623-10-cesar.belley@lse.epita.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824114827.81623-1-cesar.belley@lse.epita.fr>
References: <20200824114827.81623-1-cesar.belley@lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=45nv=cc=lse.epita.fr=cesar.belley@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 07:49:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
---
 docs/system/usb.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/system/usb.rst b/docs/system/usb.rst
index ddfa828d74..9a2f1927c4 100644
--- a/docs/system/usb.rst
+++ b/docs/system/usb.rst
@@ -81,6 +81,9 @@ option or the ``device_add`` monitor command. Available devices are:
 ``usb-audio``
    USB audio device
 
+``u2f-{emulated,passthru}``
+   Universal Second Factor device
+
 .. _host_005fusb_005fdevices:
 
 Using host USB devices on a Linux host
-- 
2.28.0


