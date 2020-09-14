Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC395C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BA6216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsyRCmVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BA6216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHq8l-0004zD-8W
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHq4r-0000iE-Te
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:07:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHq4l-0000Dx-8y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:07:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id e17so387131wme.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o+QIQisstLv7dEECXFjFLhux+SH+QFhePF29ylUvIXs=;
 b=DsyRCmVmDZmupiVqhp4L8aRRxK62GCQ+y5tZV6je4u+tF1J0t6+pn7tOU8C/4tGdoi
 fypmfx6ZCWWacWb4isb+NPmpBzRLyQ2/uXarGy/O78Ce3q2AbJdiyCsD1l0vVoNX4URN
 EQcUhQZefREmAAV61Vwa61DShyh9mc9CRXdBughhPofeehyXuWfxhr2bAu09FoW5rOR+
 zXzhI6uNc212p3VseXSEumsLKUjqdfJItQZkO6NoSXJ3JyjkB6TBxhnqjSikKoqy2AlQ
 Hh2u5LTT20ngdmRmGKDks8UesO/yAErZbJDNG7wy69pJbLe/I9r/jBhTnZ79h3dSK1xV
 Idzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o+QIQisstLv7dEECXFjFLhux+SH+QFhePF29ylUvIXs=;
 b=DKCUQVBom8+OfTOSDNMeNcIcdAL6vWFrUQkEjXp4y8XeLYoxnhlXw0JyYlQ2zywcm2
 BzdkQMYXLMpLxJxKYTjQucq+uqXa8VYj3qQCVykOOLOTyQ5kVTx6lEUbcdcwxZ2hDONj
 ILp14l9GXMYIMiT3MOE/p0yhuDzIv0FA3xRyst6XUEAU33Mlf82hzr8swe/LEawWbS5P
 KHfcdZeM18XZv8R7LXlJNEic3MMwtnTJbSNLBAgPRJFhSflzO6+9JHaWNo68JvPjZhFH
 duj2Q7EtNuP0Y3gjqOsp1mC9LMlUKlsocRbGZETmDViAv2d51n0FnUSlPf8e2GPUgvxr
 n3pg==
X-Gm-Message-State: AOAM530efGflJcuptoJpqO0POl1nInnziRFwUtxaLj3Asz9ncnyaQ5zO
 s4P58Qd1CfrsB2W2klHBm1aULw==
X-Google-Smtp-Source: ABdhPJyHLLeEdTsCHqiE+JzKvearCGN5s+p7grshVV5O0nGd7D1QHnOUVJK/bAyNUaXKtIM8sFY11Q==
X-Received: by 2002:a05:600c:230f:: with SMTP id
 15mr15542360wmo.186.1600096045829; 
 Mon, 14 Sep 2020 08:07:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 59sm21436525wro.82.2020.09.14.08.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 08:07:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6C5841FF92;
 Mon, 14 Sep 2020 16:07:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 6/6] iotests: Work around failing readlink -f
Date: Mon, 14 Sep 2020 16:07:16 +0100
Message-Id: <20200914150716.10501-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914150716.10501-1-alex.bennee@linaro.org>
References: <20200914150716.10501-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
 Max Reitz <mreitz@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

On macOS, (out of the box) readlink does not have -f.  If the recent
"readlink -f" call introduced by b1cbc33a397 fails, just fall back to
the old behavior (which means you can run the iotests only from the
build tree, but that worked fine for six years, so it should be fine
still).

Keep any potential error message on stderr.  If users want to run the
iotests from outside the build tree, this may point them to what's wrong
(with their system).

Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
       ("iotests: Allow running from different directory")
Reported-by: Claudio Fontana <cfontana@suse.de>
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200914113809.63640-1-mreitz@redhat.com>
---
 tests/qemu-iotests/check | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e14a1f354dd9..75675e1a18f0 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -45,6 +45,10 @@ then
     fi
     source_iotests=$(cd "$source_iotests"; pwd) || _init_error "failed to enter source tree"
     build_iotests=$(readlink -f $(dirname "$0"))
+    if [ "$?" -ne 0 ]; then
+        # Perhaps -f is unsupported, revert to pre-b1cbc33a397 behavior
+        build_iotests=$PWD
+    fi
 else
     # called from the source tree
     source_iotests=$PWD
-- 
2.20.1


