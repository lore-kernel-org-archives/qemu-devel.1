Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13431208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KfFU1PT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13431208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPJZ-0000Yy-9k
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxd-0005qr-HR
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:49 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxb-0005px-T7
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:49 -0400
Received: by mail-wr1-x42d.google.com with SMTP id z15so22145677wrl.8
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=luKuvfhrZOGh/JqYuKRFnEkYbiDld7fNdcxPvlNM2+o=;
 b=KfFU1PT88rojyerKlPjDqbXpYIAMdqIf18WjQu5A9jR4K3DMgi+40a/yEijmRscYoZ
 xZEvl3UwoMqNwK6nkDWurZCDuXSXHgoAaj+H7pjunCuh1iapt7PwXrxTsoydHtyvHtpB
 0Z+bBUY18+LowfTens+nlR7angCd9g8aGzw1lLQ0zikzGIwZ3Ps1v6C/DKuYEXGzjMIE
 k4pueW68Hxgfj1d4iRLhEroDhAMQHtljvE1azU5w6EdLHmX0ClQlBuIjKKggIpblAx8+
 aEkGF/uQDHXPLJlFXGgfmpAW4W/9pNxeLHBp1YGxxOU57V9FWN+EPRfesNk4lau3vNKt
 Shxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=luKuvfhrZOGh/JqYuKRFnEkYbiDld7fNdcxPvlNM2+o=;
 b=t1T7p8rxESHYyIc3lfsy2e2FGgKJy3gLnRHVLc9UDoT9nLGHfGqis/oxnQRVNrK2Tr
 dg8l0GbKxfy7JxMpvu6dnFxC/FBWdxqNLvlb05DOpC9oXKcZh6B35SVMDZUjpxJolF9y
 aVuBGL1QirX2mDdaPIO58i54cPbwEEHC/BWlB/M8aNwyqltkBgzt2sjmmo6JX84LZdrw
 ocrRtzn3tcNjXBXv0qVuK8wvKOhTxLksBeFmM/3pPnvflWmAE6m8GMngQkGD4jJGcM8j
 UahVJhzGh/pfq27mj4pcwndqBDG0cHC/zBxNbqoyGLrEYFgQ9SxQP3uwOQBJkmYAXZ/V
 NSkg==
X-Gm-Message-State: AOAM533tGZEMtv35DQ+D+1L2W7CQMguHeO27A2PX6CKzjnn4oiQmNOAx
 nbjyn/4Q+f8b7xWJ7cGO/7m7oEAveCtL1Q==
X-Google-Smtp-Source: ABdhPJwd00mKk9n8JhQg7E9QP5ZbKYGNS60cgl+RsnHgWIyHCHtVD5w1/anL5p9gQeOG0v9emogLUA==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr37685451wrr.391.1593795286336; 
 Fri, 03 Jul 2020 09:54:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/34] Deprecate TileGX port
Date: Fri,  3 Jul 2020 17:54:05 +0100
Message-Id: <20200703165405.17672-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Deprecate our TileGX target support:
 * we have no active maintainer for it
 * it has had essentially no contributions (other than tree-wide cleanups
   and similar) since it was first added
 * the Linux kernel dropped support in 2018, as has glibc

Note the deprecation in the manual, but don't try to print a warning
when QEMU runs -- printing unsuppressable messages is more obtrusive
for linux-user mode than it would be for system-emulation mode, and
it doesn't seem worth trying to invent a new suppressible-error
system for linux-user just for this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20200619154831.26319-1-peter.maydell@linaro.org
---
 docs/system/deprecated.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 843ae71fc61..47f84be8e09 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -404,6 +404,17 @@ The above, converted to the current supported format::
 
   json:{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"}
 
+linux-user mode CPUs
+--------------------
+
+``tilegx`` CPUs (since 5.1.0)
+'''''''''''''''''''''''''''''
+
+The ``tilegx`` guest CPU support (which was only implemented in
+linux-user mode) is deprecated and will be removed in a future version
+of QEMU. Support for this CPU was removed from the upstream Linux
+kernel in 2018, and has also been dropped from glibc.
+
 Related binaries
 ----------------
 
-- 
2.20.1


