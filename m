Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E62C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271F520836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="odO2m+38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271F520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot45-0002WI-Bd
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot05-0003QP-Jn
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:22:57 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot03-0004zr-Tg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:22:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id k6so10393668wrn.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XJD1GL90UWNycRg4BT4TsZXTpQO4+SzPpVo+RlIQlho=;
 b=odO2m+38GY5u7jBkBHfu0ZWgdDU5ejLgMHLEgYFNqxahB5OP8i7nia7avZlcG5WhWm
 aF28c+8eGrmdrAfiIHr8VD/64AoPSoUYNRW2fBeoEgpOELh0kkegyy9CTV6Ohc+gUHDQ
 kxXi4dUgoJOg0/Z4sV0jATsHYdw07yXK/aDEBTMhV/L1TIXvWcmg7hUwn9MjyRMxjEud
 GTJ008o1/IiJ7UNLDflSv5LYIPvaONFS0v12cqEMzTvcmwN4jWswJk9OShkezNSSjgPG
 nQP/aDkl8DCkNFeVzLERM4VmNFbjKlH/05DVcrl4eeyjFPGQUYVyfRHZP7E4pNDvEI5v
 lixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XJD1GL90UWNycRg4BT4TsZXTpQO4+SzPpVo+RlIQlho=;
 b=g1gSWpIua1y8yF9aelbDt66Q1PU/N4Qb/FHhmrruJO1EPQgQFT0sswHN6rN3Ioq3xl
 r1MDDPx3KZq2I9SW4snMGQLxo8Z5qrd/EjN0v5Gtp8P2HrnDs3OPwT2nDg9MhecEKyST
 xq3iWLBqSD+dd50T+IBpFbte4IN4g8//UeeqgshL5dac3wTEIr5/qTTsZzsCXid5Ww8q
 rRjeDtIfzabxjoMV1ErcNSQtyGtV6Qxo4QK1td+tzf4OHFuCTavHimkcuii2UBnNVk7Q
 RlpiRtxtcmFBNboAIVa0OcqJT0JDxQ+T3FxsZsUmouTDJL5aWlgs39bxhUXQ4055ErNg
 pI6A==
X-Gm-Message-State: AOAM530k5t0WwzBqKZ9cZFWxA0P095lyzi6lSTh5GogEObN+ekDz/v2j
 UAuZAX/2U0Qa+aF9Gl+uDoM6Ag==
X-Google-Smtp-Source: ABdhPJytYf7XWhpaQeoZaimqMjDB5fzY1VFO8bHaLaSUiRXfLH9CzrO7Zm0i1aPr69JhpDcwUClmDQ==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr4951864wrj.113.1593195773822; 
 Fri, 26 Jun 2020 11:22:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c65sm17980560wme.8.2020.06.26.11.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:22:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3DFA81FF87;
 Fri, 26 Jun 2020 19:14:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 16/30] .gitignore: un-ignore .gitlab-ci.d
Date: Fri, 26 Jun 2020 19:13:43 +0100
Message-Id: <20200626181357.26211-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sooner we deprecate in-tree builds the sooner this mess of regexes
can be thrown away.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


