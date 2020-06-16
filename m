Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5720BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2734420DD4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wcLnPqJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2734420DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlB6y-0005Gq-4R
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5p-0003hK-Ab
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB5n-00005Z-Gg
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:32 -0400
Received: by mail-wm1-x334.google.com with SMTP id g10so2765023wmh.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yu7So6FOt3zgC+swdRyT2svHaq8QqhchApYzxWsdT8M=;
 b=wcLnPqJB4I64Ln13dgD4TtZnO32YG0nVQe4f8OUei2MwjSWiyl2FMPUa/vWJU2G+81
 WTEAoWL4hJNAQKm9WWjbEzpPTZUXA+5qpjcTvcY1dg4BaL7oUSWmmobBSTLOVOMuhKjo
 VlKhhdtsCQzp2QnUoRUr+A978gbg66arA/frEJSMBcImLoxvEI6iFpptkFW3jrB94LQ2
 1vEiET1i/j2rOwk0EvbJTM26SzRgbw68jT+AuJJfTuQPmMbmtAVypsp6voL2RZMOEYg6
 D/oLbaQtATYd0XCEgfhHPQ8Jbx7VSJkL/lugTwWVbzYe+OYae8SY3YNIYQGViXElr15z
 gAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yu7So6FOt3zgC+swdRyT2svHaq8QqhchApYzxWsdT8M=;
 b=rb+ST5s5CurQ9XZr/0TBVSayGT7HifV90jJb2BhjPFXQc3Hy3OJ04lDbeFNrloUrOI
 rKlDagFox0H49XAVw+OsTgc7DeCgd9bg7KGT35SSFnzZ+4qR7rGufVI20SgHDsVg5zJa
 Vnrig4aNYqwnwi4lttHYDOVER8aJ97nd8iBkPB819de5UY1e1Lk/hmjbV7kNn2aUCEi9
 f3Q7IkeatY+Ud/TD6IkM0sxlnsNR7jaa5HdqHYyH0XfssBiOBmHhAO+jj9gBXw6bwxHT
 1zacErtQ4gPw52t306ZmQu1lvLGG6S4zo6GC2jqBZ8OWIx4qrOEeWM3WrDybO47Ix9ia
 F+7Q==
X-Gm-Message-State: AOAM532av4NxL/xpxEj1w9brlCweUk7Bo0XDJ6sHyYEkMIop6CoKJPze
 UBH5s3Cm1lN/fRTSTnH7JmPR4Q==
X-Google-Smtp-Source: ABdhPJxS+CUmf8X3F1NnqWU0YnZ1BnGNh5tE3n2t2rVlx5FyYPL75YOua8bXyEunquv0oGrREuRzow==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr2996924wmh.37.1592312009551; 
 Tue, 16 Jun 2020 05:53:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j4sm4193024wma.7.2020.06.16.05.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 05:53:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8C62B1FF8F;
 Tue, 16 Jun 2020 13:53:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/21] Makefile: remove old compatibility gunks
Date: Tue, 16 Jun 2020 13:53:06 +0100
Message-Id: <20200616125324.19045-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616125324.19045-1-alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200518160319.18861-3-cfontana@suse.de>
Message-Id: <20200612190237.30436-4-alex.bennee@linaro.org>

diff --git a/Makefile b/Makefile
index 895410fbf9c..48f23aa9786 100644
--- a/Makefile
+++ b/Makefile
@@ -562,12 +562,6 @@ slirp/all: .git-submodule-status
 		CC="$(CC)" AR="$(AR)" 	LD="$(LD)" RANLIB="$(RANLIB)"	\
 		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)")
 
-# Compatibility gunk to keep make working across the rename of targets
-# for recursion, to be removed some time after 4.1.
-subdir-dtc: dtc/all
-subdir-capstone: capstone/all
-subdir-slirp: slirp/all
-
 $(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y)
 
-- 
2.20.1


