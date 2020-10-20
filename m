Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F87C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9D221D6C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ASngUGYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9D221D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtWh-0007E8-VA
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kUtVv-0006hd-GB
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:25:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:49506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kUtVs-00082x-58
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:25:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1603207520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=byIJ7H2GQM28rhQ58AUzuLuWTqzT0jcoZiKUPJ9T9v0=;
 b=ASngUGYiGvJLr3yq3kN/+zzYymVXtAT8hDFSyfGvryPIlTRgho5doGpcM99Uk+SqIDI6l8
 aCagrmH3wC2fQzfdFpSWDgvXvZZ6/pODjMfeZx8Tm7Cen3k8HhhLQAqBXuVYA53mxiRsbU
 0fOgbe6mwRVt3wvz57u+V8YYM8kmoDg=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 80B49B2DE;
 Tue, 20 Oct 2020 15:25:20 +0000 (UTC)
From: Bruce Rogers <brogers@suse.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] roms/Makefile: Add qboot to .PHONY list
Date: Tue, 20 Oct 2020 09:25:12 -0600
Message-Id: <20201020152512.837769-1-brogers@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=brogers@suse.com;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 16:52:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kraxel@redhat.com, Bruce Rogers <brogers@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding qboot to the .PHONY directive will allow a
make -C roms qboot invocation to work as expected

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 roms/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/Makefile b/roms/Makefile
index 1489d47350..7045e374d3 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -102,7 +102,7 @@ build-seabios-config-%: config.%
 		OUT=$(CURDIR)/seabios/builds/$*/ all
 
 
-.PHONY: sgabios skiboot
+.PHONY: sgabios skiboot qboot
 sgabios:
 	$(MAKE) -C sgabios
 	cp sgabios/sgabios.bin ../pc-bios
-- 
2.28.0


