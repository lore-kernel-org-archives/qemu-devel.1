Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC34C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309F820727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IeIkiApf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309F820727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZe9H-0005LL-9r
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZe8S-0003Zt-IV
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:28:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZe8R-00016a-OX
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:28:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id h17so4426555wrc.8
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mvfZ9b5X++pjGPlHODQLP+73HAFs/zH+An8fEoHT3r0=;
 b=IeIkiApfP6i+lGX3MJNMI4e/b36mNVFBzOue+cc6pwEx31lVWwqxADFGK8fSh27jiQ
 QPcgcv6qhwczA5pakRhLeWcrnZ/CQCcQ21l4qcDoUwXilNfqNT19+XlMj4Yo38gcPlDt
 DRovQ7jRJ+Ik4ToPWqkSawOcZT0bw4kqpAGQrvuxWtIPDow2QywmPTXWKutXuJ+BKZo3
 0LZv8Kpdx7LHBiJpJit0HF/X6bBNGvXl7x895D6GSl35vNw/RBErMn8ZED7g+ZmNFiMJ
 OR3zw+kJMULqpM16KO7/bumHev9PV/Y2MXJw0CSy72BXkQTj/Q2iq8R2M4qcC7wpCGj3
 Y9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mvfZ9b5X++pjGPlHODQLP+73HAFs/zH+An8fEoHT3r0=;
 b=IUuusz+9r1WoLu1QlLH+s78X8nq04mQMSMesDf0LUF1/65TAe0P7kPUojE3DG1NSlQ
 vSVrpjQqeFnm6VS8lisUQ7Eq1h/mMXCaQeCQxju/8d/vZgqohOumsKawj4fYzsQdimZg
 xL1WLjeF5NnEMkh1gM3z5KrN79nljt127cKSItLGIk4QH4+lMps1wfmbB31Z+5WLVKNR
 lYs8ezwORLUsjmWFb4EWuDSDi18lB91y4dda5LJzoAY/ej9C7ouTxoTYT5PQC5QEwHjz
 P1mcFYWZOtwSaNJl12PLW6EyBRy9Pqe+k1Kzti8uw4J3IuVKc27lt+jUAYzRbj1IptYb
 fC8Q==
X-Gm-Message-State: AOAM531+VJju4TRC+ESlRBO9Y8dfA59kIRDstz+v3gPoT3E48d/iS3oM
 PpxiZFHV+JBVlXhfjUUVxJDiBq5y0OY=
X-Google-Smtp-Source: ABdhPJwjorA+SUg5VRXOkorgGRrlK+QIT0kZIaKRdvIDyTtM9VmTOkAObxFtMtJm3DOSR176oYTxtQ==
X-Received: by 2002:a5d:4041:: with SMTP id w1mr5355182wrp.245.1589563714314; 
 Fri, 15 May 2020 10:28:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o26sm4716722wro.83.2020.05.15.10.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 10:28:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4849E1FF87;
 Fri, 15 May 2020 18:28:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/2] configure: add alternate binary for genisoimage
Date: Fri, 15 May 2020 18:28:30 +0100
Message-Id: <20200515172831.8439-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515172831.8439-1-alex.bennee@linaro.org>
References: <20200515172831.8439-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all distros ship genisoimage which is a Debian fork from the
original cdrtools. As the options are pretty much the same support it
as a fallback binary.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 26084fc53ad..a574250524f 100755
--- a/configure
+++ b/configure
@@ -941,7 +941,7 @@ done
 
 # Check for ancillary tools used in testing
 genisoimage=
-for binary in genisoimage
+for binary in genisoimage mkisofs
 do
     if has $binary
     then
-- 
2.20.1


