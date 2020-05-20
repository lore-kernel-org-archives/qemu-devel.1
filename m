Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AC2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB25207D4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Px0ECHj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB25207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPRM-0000Ts-Op
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM5-0000Aw-Mh
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:57 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:43045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM4-0001z9-0o
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:57 -0400
Received: by mail-ed1-x544.google.com with SMTP id g9so3163979edw.10
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sKR6q5Rw9VEFb3A0dJqchg5Eh5EneIbh7z8JPrBYd9A=;
 b=Px0ECHj9eowUQxmO4+i+eHa76wcPHGUG4sI98PHR+lxiuyvOlZPwizeOIZZlSdQ69u
 TmXOTKm+Ajw/NZ0zzXagykvbQ1gryE35h17wsKCbXal7Zy7U8ttt3NlNS5HphgGaSvqb
 CYYwsQo3skGaqF62R6VBu3NREu7EGCznLoj3J5GxGozx1ZRMWwsslp4eYkzQRaUb+6kz
 V5NBJCjE992qvhFjW9Te8W6N1EXU8qb3OgowVOijudUCkPofIwrclH9E6/NPDlSXu6Vs
 VyQRXZI/OOR+SiEK2ZsiyhnR6Hi7QwyAcTUFWehBwaf++O1CyMszL4hTpVlELN+THMfb
 a0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sKR6q5Rw9VEFb3A0dJqchg5Eh5EneIbh7z8JPrBYd9A=;
 b=JzntNJLN6J/ehHV6QBeSbZw74xxWC2O/olNAVpwHGwofep05JtnSIu7NqgBIZxKxuI
 FUTW3TAJ3LRIcrfQY6EKPGRAtzDSm16Jt/po/kET2QLvQYS/6p2T896sQPFHG8IIcNJO
 bhF+IUb+R02lOn9g9aJPynmVbk7sozy3KKtM/7mFSwb4UCuiO52cNj7Cqdi2Wg5sFFfl
 OXZs+AX9jT9EgznMSxbQvjyK8YNHEEY6vXh4Stf8DVSMeB7JhwkCDStxFs5dgE5qxJ0q
 i++5f7Jd+p1l2zEYW8ZOIdEBdGSo7NnSrHvn6RMr26thLB6wAenHqzV1hIqBFRqMu6gG
 jq+g==
X-Gm-Message-State: AOAM531KQhb584ihNGr/wx8PO7BV0UtVOtkcC/GSWj7ImxEVIQ7Qa6rZ
 DH1ykJrGuXCC9LW74JODYlufPNx4PaI=
X-Google-Smtp-Source: ABdhPJzqCOOwTHtihwy1xlG3olT6s4pUOVeL/3LWrKYmqbmWYKGPLhVsZ8tysPjwzY61BLyNrq9q2Q==
X-Received: by 2002:aa7:d590:: with SMTP id r16mr1627020edq.304.1589983554663; 
 Wed, 20 May 2020 07:05:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x8sm1998151edj.53.2020.05.20.07.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CBB751FF93;
 Wed, 20 May 2020 15:05:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 07/15] tests/tcg: better detect confused gdb which can't
 connect
Date: Wed, 20 May 2020 15:05:33 +0100
Message-Id: <20200520140541.30256-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x544.google.com
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
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we may gamely give the right information it can still confuse
the wide range of GDBs out there. For example ppc64abi32-linux-user
reports:

  warning: Selected architecture powerpc:common is not compatible with reported target architecture powerpc:common64
  warning: Architecture rejected target-supplied description

but still connects. Add a test for a 0 pc and exit early if that is
the case. This may actually be a bug we need to fix?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>
---
 tests/tcg/multiarch/gdbstub/sha1.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/tcg/multiarch/gdbstub/sha1.py b/tests/tcg/multiarch/gdbstub/sha1.py
index 734553b98bb..2bfde49633c 100644
--- a/tests/tcg/multiarch/gdbstub/sha1.py
+++ b/tests/tcg/multiarch/gdbstub/sha1.py
@@ -65,6 +65,10 @@ except (gdb.error, AttributeError):
     print("SKIPPING (not connected)", file=sys.stderr)
     exit(0)
 
+if gdb.parse_and_eval('$pc') == 0:
+    print("SKIP: PC not set")
+    exit(0)
+
 try:
     # These are not very useful in scripts
     gdb.execute("set pagination off")
-- 
2.20.1


