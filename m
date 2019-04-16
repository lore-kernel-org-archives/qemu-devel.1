Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E337AC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5A920674
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A9vP0bpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5A920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36524 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNsO-0007Z2-SP
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:11:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfQ-0004y1-Ob
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfN-0001Ph-P6
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfL-0001Na-Mv
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id y13so26979473wrd.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=tbRH/Ezbfxbs3Pgygk5ZQu6eKyrO+ofFIElvSltfNOo=;
	b=A9vP0bpklygXGRW0rxA0JfeHZRuzpet/z9aiLVI13QTur7CangcXFT15WZhWyGz4rD
	vcshJX0Yb6E6KhAPvL+/Sylnc0izQHA21p8aWkNDjephbziESyRc5Y/wUCi/OprmbyZ/
	kdcfm55GuNrIPMLEqMoPTzNpmsowRD5O4Ra5Xi8+11DyxiGcAl5t4lHcLVLJfT/JFJ5+
	2q/6+5IxTb7163KpS0l3U17skby3qtc7JBxfKcjtiFbBh0bAWvjqmyiD4kRjt+nH5Wo6
	YbJKse8K5Bf7YYph8nNNlnc+ovkCFS9bbUJsO/JV4eVTutCDj3I1cIBFFvazHbmezZ6I
	R1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=tbRH/Ezbfxbs3Pgygk5ZQu6eKyrO+ofFIElvSltfNOo=;
	b=bkp8VbZEV8d5mpUp32TiSBTp/SBu10EUBIWmAayyOEp3Z+7k7vv5FrJ2JEtGr9lwy+
	P3T5E9UmKtX6sdaaxpIfqygGEia8qegVuWTUIrnaS1yht3PpPTjF5lUJkP7+3BWUiHBq
	GBZ9W0+A/vy2mNezqS41ODVkyC/M63oWZZcgiZGduwJoi6QNyf9rsVUeP3TRjrHayOEk
	pDUX3SYuy+IgY1l+IMonWyN0ai8n/41WZbEr3D1cNvhC4V9Wef6rBcXe1krBg5Mj3QXk
	PZXRE/pt+GrxXV/jOUEPjZqmoJFWATQKq6glGgZjouPG/qJh0Trt4ZcjpRZhqKikOjgi
	dMJg==
X-Gm-Message-State: APjAAAVNz1CDUk1ie4iqFE/JNMIQUbNjh3seWtcgR4Pd6+94IsMVyIhU
	lj/MmA6bhQL7wPzux/9WP0OfwtDYBZc=
X-Google-Smtp-Source: APXvYqxSkPDEd2caSBKIaLh1p9TG26HbNa+sKD0jXmnYtpijNzsNIimzvnMqVhgMYo4OZTzDmDPUTg==
X-Received: by 2002:adf:efc1:: with SMTP id i1mr51646257wrp.199.1555419502123; 
	Tue, 16 Apr 2019 05:58:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:34 +0100
Message-Id: <20190416125744.27770-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 16/26] target/arm: Move NS TBFLAG from bit 19
 to bit 6
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125734.QHz7OF2O8fwCy1YQo1dvDXevUPY6XMrFmgwmsscRHho@z>

Move the NS TBFLAG down from bit 19 to bit 6, which has not
been used since commit c1e3781090b9d36c60 in 2015, when we
started passing the entire MMU index in the TB flags rather
than just a 'privilege level' bit.

This rearrangement is not strictly necessary, but means that
we can put M-profile-only bits next to each other rather
than scattered across the flag word.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0e0cb6b2271..c436f628987 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3139,6 +3139,12 @@ FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
 FIELD(TBFLAG_A32, THUMB, 0, 1)
 FIELD(TBFLAG_A32, VECLEN, 1, 3)
 FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)
+/*
+ * Indicates whether cp register reads and writes by guest code should access
+ * the secure or nonsecure bank of banked registers; note that this is not
+ * the same thing as the current security state of the processor!
+ */
+FIELD(TBFLAG_A32, NS, 6, 1)
 FIELD(TBFLAG_A32, VFPEN, 7, 1)
 FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
 FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
@@ -3146,11 +3152,6 @@ FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
  * checks on the other bits at runtime
  */
 FIELD(TBFLAG_A32, XSCALE_CPAR, 17, 2)
-/* Indicates whether cp register reads and writes by guest code should access
- * the secure or nonsecure bank of banked registers; note that this is not
- * the same thing as the current security state of the processor!
- */
-FIELD(TBFLAG_A32, NS, 19, 1)
 /* For M profile only, Handler (ie not Thread) mode */
 FIELD(TBFLAG_A32, HANDLER, 21, 1)
 /* For M profile only, whether we should generate stack-limit checks */
-- 
2.20.1


