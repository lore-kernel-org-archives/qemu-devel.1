Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5401EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11E8221E2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11E8221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJTi-0000J1-BH
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 09:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bofh@freebsd.org>) id 1ka6fx-0005RX-4p
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:29:21 -0500
Received: from mx2.freebsd.org ([2610:1c1:1:606c::19:2]:36728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bofh@freebsd.org>) id 1ka6fv-0003sm-1Z
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:29:20 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits)) (Client CN "mx1.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id A9E9575D4F
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:29:16 +0000 (UTC)
 (envelope-from bofh@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org
 [IPv6:2610:1c1:1:606c::24b:4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4CQnb03Hchz4g84;
 Wed,  4 Nov 2020 00:29:16 +0000 (UTC)
 (envelope-from bofh@freebsd.org)
Received: from mx.bofh.network (mx.bofh.network
 [IPv6:2001:19f0:5001:2b77:5400:2ff:fe7b:aa2c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mx.bofh.network",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 (Authenticated sender: bofh/mail)
 by smtp.freebsd.org (Postfix) with ESMTPSA id B920416A99;
 Wed,  4 Nov 2020 00:29:15 +0000 (UTC)
 (envelope-from bofh@freebsd.org)
Received: from pdr.bofh.network (<unknown> [2604:6800:0:162:0:1:0:1])
 by mx.bofh.network (OpenSMTPD) with ESMTPSA id 03473004
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 4 Nov 2020 00:29:13 +0000 (UTC)
From: Muhammad Moinur Rahman <bofh@freebsd.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] As FreeBSD ports MAINTAINER add myself for FreeBSD Hosted CI
Date: Wed,  4 Nov 2020 00:28:21 +0000
Message-Id: <20201104002821.49600-1-bofh@freebsd.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2610:1c1:1:606c::19:2;
 envelope-from=bofh@freebsd.org; helo=mx2.freebsd.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Nov 2020 09:07:47 -0500
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
Cc: emaste@freebsd.org, lwhsu@freebsd.org,
 Muhammad Moinur Rahman <bofh@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Muhammad Moinur Rahman <bofh@freebsd.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd16606bcd..89d6269888 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3137,6 +3137,7 @@ W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
 
 FreeBSD Hosted Continuous Integration
+M: Muhammad Moinur Rahman <bofh@freebsd.org>
 M: Ed Maste <emaste@freebsd.org>
 M: Li-Wen Hsu <lwhsu@freebsd.org>
 S: Maintained
-- 
2.24.3 (Apple Git-128)


