Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1CDC2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E0120707
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSWQlUgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E0120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIrQ4-0006yS-7M
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kIrPC-0006Uj-Ng
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:44:46 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kIrPB-0007hV-1w
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:44:46 -0400
Received: by mail-wr1-x42e.google.com with SMTP id a17so1524013wrn.6
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oEFw8KBiLt1Cl43vN0KtRWsjfpEoB2OKby+GfRIbwzM=;
 b=SSWQlUgX/vxZwDWaiVRjbCKK2enCCc5z2lzrSdEEl7tvJpjU91HiRAeQ5hQnh6DCn4
 WdFb6hwoxQAEnQuI6ttwcU0T9c9ecOiNaIgA7SgsAoRMP2yAeBaBlnUCjUWynK9TA3jH
 H7jMSQSdCeSWt7RFC1hx9NdLBj+YgQcRe9njd9UMejWh9pm3MPcR7ngZS7wPVntRbj6H
 hxY/WDLsBQ3CtksnBhsNLeDa9qUgaZeN7pf1Px/gdxzkD7nylZuKIQzJad0bd/ga3m5w
 RkPJbzfmlB7oLTqMCahQANIWC2d8Ov0h4xqN04zx5+iQqhOgJR2MVRZtlrAA3FjuCDgg
 1NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=oEFw8KBiLt1Cl43vN0KtRWsjfpEoB2OKby+GfRIbwzM=;
 b=SIXYQa9OkYzAwHNGG3McZGpuxDQBi0+rT4JrUF9z3Arffzo5nu0p779wVFn1WAczgq
 BzCUGrerzqT/yyPq46FYPQCscfFJYVfGssTFTs+0ngkQFktoidz2jo0iB3fEXXUD+uL7
 sBIPti/H09Td9o/VP4RWf4pTV1LUo9v6eO6P4Z5Twucvs7H3XxZNhxeJCX0cN9zZpapU
 XrdGZZUPYGZZM4oJg/TtHjX+/xPN0+qcc9vCr+JHqR5IuN1FaZcrx/MAgk0vardW7pIe
 gkyc2iIFhIxR0bLM99v8O44UQ/xpvtxRHQ01V/AEAPaddCrklO2Bgpz4MqtLcS4TQQFs
 jX0g==
X-Gm-Message-State: AOAM530kVb+HkIYOvL8We1C9amjPJRTVGQ7nce9qUxByVty/8/mfcCZj
 Q0U7I6OvxyqTSM7aojibDrbAeLqWimU=
X-Google-Smtp-Source: ABdhPJyPRZIXo4PAXjFXsmlnTf15+HA+B4hYI0gwSMcMFladTmXChUtddD8Quw36eOWJRHW5/Cdr1w==
X-Received: by 2002:a5d:6407:: with SMTP id z7mr31170991wru.65.1600339482882; 
 Thu, 17 Sep 2020 03:44:42 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:d003:b94f:6314:4839])
 by smtp.gmail.com with ESMTPSA id
 c10sm10207298wmk.30.2020.09.17.03.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 03:44:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docker.py: always use --rm
Date: Thu, 17 Sep 2020 12:44:41 +0200
Message-Id: <20200917104441.31738-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid that containers pile up.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/Makefile.include | 1 -
 tests/docker/docker.py        | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3daabaa2fd..75704268ff 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -243,7 +243,6 @@ docker-run: docker-qemu-src
 		$(DOCKER_SCRIPT) run 					\
 			$(if $(NOUSER),,--run-as-current-user) 		\
 			--security-opt seccomp=unconfined		\
-			$(if $V,,--rm) 					\
 			$(if $(DEBUG),-ti,)				\
 			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=$(NETWORK)),--net=none) \
 			-e TARGET_LIST=$(subst $(SPACE),$(COMMA),$(TARGET_LIST))	\
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 356d7618f1..36b7868406 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -377,7 +377,7 @@ class Docker(object):
             if self._command[0] == "podman":
                 cmd.insert(0, '--userns=keep-id')
 
-        ret = self._do_check(["run", "--label",
+        ret = self._do_check(["run", "--rm", "--label",
                              "com.qemu.instance.uuid=" + label] + cmd,
                              quiet=quiet)
         if not keep:
@@ -616,7 +616,7 @@ class CcCommand(SubCommand):
         if argv and argv[0] == "--":
             argv = argv[1:]
         cwd = os.getcwd()
-        cmd = ["--rm", "-w", cwd,
+        cmd = ["-w", cwd,
                "-v", "%s:%s:rw" % (cwd, cwd)]
         if args.paths:
             for p in args.paths:
-- 
2.26.2


