Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF55C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0812065D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGXJWryQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0812065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdHu-0007Vr-7i
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdES-00028H-CS
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:00 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:40557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEQ-0005oP-MT
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:00 -0400
Received: by mail-wr1-x429.google.com with SMTP id h5so23945925wrc.7
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KLxxBVgESg8+q++r/+fvnKLfCmcpFTynVpvVjZzQTYc=;
 b=fGXJWryQ2lB2psc9eeFMRSIN3DKGiQetKXI7zlHAk6i90uos8tgDmFBc3E2OOmEc7w
 m+ogh+EBgA1bYyzlxWR4aZlFLHcUNvdDlpMpQs/Z1p/W6cIsNFR6dcX+mj9ilrCHkTtB
 l8xb4VoyPkZC1SVe8n10Y4y8bIaPOXsn+htsf5NruypcjVGvxf6idP3wWN7GD3nj3ZPs
 sBntT076sltLoBv8pAfsxcLosKg6tCnvHBPvgxRv9PalLwS1ioTbJpTLkrOrVk27VpPT
 8U/wg/AaGzO815ER6H+NqhaPhRCjzk43k+03egQpvTupMgMkLzbDN2LQowvagd5+Au5L
 UQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KLxxBVgESg8+q++r/+fvnKLfCmcpFTynVpvVjZzQTYc=;
 b=OvU02tgZblIcuAV2iobvr2+sS633RHUVV5rgNK6OxnH2UOdL7kDm3g9j8N1EkB9TOI
 Lb/KGLQUTMBpHUduF4IvW8n+RbLWaNK6AjMTgRS7ZP8ZBcC4K+rw+gXIGOMi8bu3ode1
 IcVe7bz4YVEZXrrtyZChvi41TUVr95vDPNlRURWTQ+f8iBKSST+Hg4p8wRYZnvt5YzEm
 /ac+aPi6F7AYGdw2HNmPk8jw15bsB20SirpJ0HlFEvuYOruzPCglKZseqTqBcO+hHdIw
 21okgcvc/GWCEpC/frSVyX1h7i23jqWhdOo6nHE0dW1rewXFkDwnugwx+u8+94sqCBzl
 UV3w==
X-Gm-Message-State: AOAM532bGmXrF+TbBxUXeuyol2vzY3HIE4FhTEuqQt9dV4ZblQyQgYWk
 VoX4CBuiuAkqQl5Q+vijNg1Lcg==
X-Google-Smtp-Source: ABdhPJxNFvD93CDJv9jpFM+fRtRLAjhfL+HLRwR7w9yda627AY2LRi5zK6K7WOynVOs4rtNns7hoZw==
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr26230996wrt.119.1593611817031; 
 Wed, 01 Jul 2020 06:56:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v24sm9082410wrd.92.2020.07.01.06.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 06:56:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0D3341FF8C;
 Wed,  1 Jul 2020 14:56:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/40] iotests: Fix 051 output after qdev_init_nofail()
 removal
Date: Wed,  1 Jul 2020 14:56:14 +0100
Message-Id: <20200701135652.1366-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 John Snow <jsnow@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Commit 96927c744 replaced qdev_init_nofail() call by
isa_realize_and_unref() which has a different error
message. Update the test output accordingly.

Gitlab CI error after merging b77b5b3dc7:
https://gitlab.com/qemu-project/qemu/-/jobs/597414772#L4375

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200616154949.6586-1-philmd@redhat.com>
---
 tests/qemu-iotests/051.pc.out | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 0ea80d35f0e..da8ad871876 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -142,7 +142,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive if=ide
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Initialization of device ide-hd failed: Device needs media, but drive is empty
+(qemu) QEMU_PROG: Device needs media, but drive is empty
 
 Testing: -drive if=virtio
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -214,7 +214,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Initialization of device ide-hd failed: Block node is read-only
+(qemu) QEMU_PROG: Block node is read-only
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=virtio,readonly=on
 QEMU X.Y.Z monitor - type 'help' for more information
-- 
2.20.1


