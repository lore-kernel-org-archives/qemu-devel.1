Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E7BC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC6020883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 10:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXpsMMhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC6020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60298 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVZ66-000838-2E
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 06:12:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYth-0006Np-AC
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYtg-0005Zl-25
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:59:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYtf-0005YJ-RN
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:59:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id v22so2129422wml.1
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=s7/le6C6BEubNb8PXV+L9VQYmxXcdbVuj4/GnWwcUzo=;
	b=eXpsMMhrdMmnrAl2h3MvZubp1LnZCOuFyfGZVlNCGQdbSFi2OLh3yXSgJDg8FuvM67
	mVUgTJykkf2vEJnuKyGz+mBnFAhu4XIPgGPunwGC3Y7QnmXhc4Fr4jxpNrLVTXDMon4l
	Ty91gzK2Be8K9EL3KZAjsI1w4mHBTY+liS3bdxuqqM+5ViHsBht3KqCyeQ/6zHj8mcri
	R1f/rJ6HowYpp2E/m1voOR0NRPoQz2V++OQZwcoWtlz2SXF1gN/WOKIgA/62/REqpOgq
	x9McWv4VgFZ1n+fGM1GnqqY8HzfIoLzE+hvwODYm2w9FnzpqpMBegLdMOjkMA+aQpxlf
	zPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=s7/le6C6BEubNb8PXV+L9VQYmxXcdbVuj4/GnWwcUzo=;
	b=r0/OLB5Y0fgDk7QnHTj8ZLyKOCgywPMlhi86WEpbr6mJ6U1DXlCNtIMiBY1AYJVC2H
	8IUfU5uiJIgCMuXKOt5INhdvEq5AUj8x5FDJaXLnXGXtfaxg4ECfrJfViFAGq7ng9Cuo
	udigoI34136A3npooIodiCL+VvsKnVDr65Abe8gdU0VbPMfqgGHDHL4ARV6b5cd2wqb/
	ppC8LJiwlNhsrHiNl/54uXmg5AQ01QLSGgZhjdsYCZ9KHGlAlZRDirt88ashEJ6AiAqH
	d49SOLCidrK6DIIqXi/QiqRDjFSV3tquE/wG+xBVXZ4/4o7Rwt8IHxaJ+sMDIFxPTFkP
	SrXg==
X-Gm-Message-State: APjAAAW8iiHayvnbGiJ4oA0VrNlfPClp8NR4R/FddRzEgSUoqqDkEIwE
	8GFC9rvjgfdjAKQVrrvc3w/PnQ==
X-Google-Smtp-Source: APXvYqzzHKD4dpFUfpAr3XklrXEMYXSWAC4+Lu0GpGmWXo1c/C1/tH+FiQpKEqLbEAaJ3r9hNFzldw==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr2276027wmi.61.1559037594695; 
	Tue, 28 May 2019 02:59:54 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	65sm24238165wro.85.2019.05.28.02.59.50
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:59:51 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 7D4AE1FFAA;
	Tue, 28 May 2019 10:49:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:48 +0100
Message-Id: <20190528094953.14898-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 23/28] Makefile: fix coverage-report reference
 to BUILD_DIR
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 337f2311f actually claimed to do this in the commit log but
didn't actually. Oops.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/Makefile b/Makefile
index e02b88bcb11..73370874841 100644
--- a/Makefile
+++ b/Makefile
@@ -1009,7 +1009,7 @@ $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
 %/coverage-report.html:
 	@mkdir -p $*
 	$(call quiet-command,\
-		gcovr -r $(SRC_PATH) --object-directory $(BUILD_PATH) \
+		gcovr -r $(SRC_PATH) --object-directory $(BUILD_DIR) \
 		-p --html --html-details -o $@, \
 		"GEN", "coverage-report.html")
 
-- 
2.20.1


