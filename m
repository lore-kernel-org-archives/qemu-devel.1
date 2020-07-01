Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFDAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA9B207BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjXFmiNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA9B207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdZx-0006Pw-Ke
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdL2-0005EV-HX
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdL0-0006rc-FP
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so23978658wrc.7
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/gJeXHauplrna/VI3tbE6Xj0DnjeaDUq+DWasMhuRYI=;
 b=mjXFmiNJuIrD339dJL3JR3q+25xfgxvOvhMjzHD8OylTSoNtwpQ3Bp6FJqyN3syuK7
 V9HhLGeNRPNBmwiJ3sLOAhwEHetuCMX1LfRuLrAw7RN1m/NcMBLslsp7raydeEpm79bA
 +AUKpSp07jDAaXiYKphqqJdAndAYF7mT27/h60Bz+4s46XNcc/O5osePuNWQww7IXke9
 xcCKEXEuIpPVQJp1xOKf/GJnuOk2aJZi3F6dJTSYHbFlGnFC+Z/q3iCpUcv2yLWW6Td2
 gAjePhPN7wRs9TeIIMgTr6YyAgzV/WpeHzb0w0rOghg8XXou3gaFnUjF6dJl0aTax25/
 akxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/gJeXHauplrna/VI3tbE6Xj0DnjeaDUq+DWasMhuRYI=;
 b=tfN9z/9J1BYMiYjPyGeslFgtc7GxPQlrQT6NvrFGYSFlyMv7RaQcPzG+UIwituXMJU
 O2LBJ9d1OedtOkxiqenz5y0V85snVEhRIe5l2DbnJ0vU9kBNsUfv/oACmbKUUSBmDQ5M
 d9sIXoGxbK0PUzJ2X4kyu1aXe6i874gQONRwPJgZR49IjzY5L2anulfq8WVwKnDrOmZl
 WfZCQlU7IPpvC8VNz9DupHbPU8bpqLgMEngJNIWNRNTL1zE1yWUKSFX2dcF/Oqsar0U6
 qKrshHn4GeV5CZPFcKbTEp1biusGCPn5lNs8A/LFTtwr/n50iul2cFeEkeqMMCSgpJkB
 2U0g==
X-Gm-Message-State: AOAM531NJckMxSBxTROcIhvKxmp3lkCLSYJBnbrzM0Y3008Ihi6BieAR
 glIOHNsBImu5QVd/9gL2CmhyKA==
X-Google-Smtp-Source: ABdhPJzpehlm16qbePZ7dOMrG31Ui8NdNOgpqRpytESW4YyFZh/LzDBG/ZiNz/aUiThLUE5HQwM59A==
X-Received: by 2002:adf:f889:: with SMTP id u9mr29569062wrp.149.1593612225169; 
 Wed, 01 Jul 2020 07:03:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h14sm7805319wrt.36.2020.07.01.07.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C4CC41FFA6;
 Wed,  1 Jul 2020 14:56:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 18/40] .gitignore: un-ignore .gitlab-ci.d
Date: Wed,  1 Jul 2020 14:56:30 +0100
Message-Id: <20200701135652.1366-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sooner we deprecate in-tree builds the sooner this mess of regexes
can be thrown away.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

---
v2
  - just use explicit !/.gitlab-ci.d
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 90acb4347d4..2992d15931a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -93,6 +93,7 @@
 *.tp
 *.vr
 *.d
+!/.gitlab-ci.d
 !/scripts/qemu-guest-agent/fsfreeze-hook.d
 *.o
 .sdk
-- 
2.20.1


