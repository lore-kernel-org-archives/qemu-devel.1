Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4DCC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC732224F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhddRTI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC732224F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWeJ-0004eJ-9e
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWW-0002JT-Dk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:26:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWU-000598-Qn
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:26:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id s13so2581611wmh.4
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o+BmWQys2U5N6/XRUBJCW26L7A6dDeAULPOl97vv6H4=;
 b=MhddRTI7+azoCLnyzX+ujdxLfLpURrJ0F/5LI+hgVuE7/QeYhvmfKeYh73ucrNBJT7
 r+tfmWmA0KX4fCG8/4nVEMDPGo+HbHPhAM6V15ZJemMELM2v1VFvtx7u6BSO7iJfqFrF
 EXWNLs95nDx8+oMnTDiMkJcMqfor5A1xwMWX3kMLObhGZXL2wVtbMfNp7nFDW9p79rMO
 vU0W4RL4UvisyfgRbENvhjbDIbGZBVtCvIh5+qU+g1W7MK59IzZ9HtsApgo11tPwXlKZ
 0qNaTumffSeUZLxuOXGjke9n1JYGyHnsQnhKASNN7fZMRst3TwtzLA/L+dLDsScIqBBD
 NyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o+BmWQys2U5N6/XRUBJCW26L7A6dDeAULPOl97vv6H4=;
 b=jxaNIiytxJ39/CstT/aA/lv3r3iC6kWGWdtVgoJKLkN8uz/E9PDemz0Bw2jxEtHdSp
 x+OmbeCR15NgvTP6dwrv2aMTZ0gHlDFLsxAFI/QzvkNrP2yU1NXoKLxjk/vI1LvnjT2B
 +tpqxC63YZFw0LGNZ5pk5urFcKPypAYU3zA2NSJ5WWKBRXm7GPxw/gpEZn92LSx21LFS
 IeAomtw6jcikApwIexUaLmaVeBC1tT+qqT3Ik28Gs8HmQk+HDskNFWytvD3l2PVVrz7J
 hVR6npsL1f0iskH+cyavYkBE5kBLVmdKYDaBftq8cY8R21eT5bIPHBKbYKfo2GhY+SUp
 JCjQ==
X-Gm-Message-State: AOAM532WmeKpwklXZ6OZn4ATPL+nWo8UtlDU3Gfh8RyPO9xRXuXFwGiW
 0AHhNp9NGS2KG4GBioUC6J8OUw==
X-Google-Smtp-Source: ABdhPJx9X5MpyMQxRmL3/f3WUQIBnSjCq3nTjlcKPiTraI8scdkXDNKv75aLdwkeUnayGyaadJX2DA==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr4214006wmk.29.1600259213370;
 Wed, 16 Sep 2020 05:26:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o4sm32958317wru.55.2020.09.16.05.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:26:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A29D21FF8C;
 Wed, 16 Sep 2020 13:26:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 2/8] iotests: Drop readlink -f
Date: Wed, 16 Sep 2020 13:26:42 +0100
Message-Id: <20200916122648.17468-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200916122648.17468-1-alex.bennee@linaro.org>
References: <20200916122648.17468-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

On macOS, (out of the box) readlink does not have -f.  We do not really
need readlink here, though, it was just a replacement for realpath
(which is not available on our BSD test systems), which we needed to
make the $(dirname) into an absolute path.

Instead of using either, just use "cd; pwd" like is done for
$source_iotests.

       ("iotests: Allow running from different directory")

Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
Reported-by: Claudio Fontana <cfontana@suse.de>
Reported-by: Thomas Huth <thuth@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200914145606.94620-1-mreitz@redhat.com>
Message-Id: <20200915134317.11110-3-alex.bennee@linaro.org>

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e14a1f354dd9..678b6e49103a 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -44,7 +44,7 @@ then
         _init_error "failed to obtain source tree name from check symlink"
     fi
     source_iotests=$(cd "$source_iotests"; pwd) || _init_error "failed to enter source tree"
-    build_iotests=$(readlink -f $(dirname "$0"))
+    build_iotests=$(cd "$(dirname "$0")"; pwd)
 else
     # called from the source tree
     source_iotests=$PWD
-- 
2.20.1


