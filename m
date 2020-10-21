Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9CAC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40D120872
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMYaPbF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40D120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVH63-0003Ge-KP
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVH1o-0006RZ-Jc
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:31:56 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVH1j-0005Zt-Kz
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:31:56 -0400
Received: by mail-wr1-x42a.google.com with SMTP id t9so3743279wrq.11
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FRvhEMuNKaDLPqTwPhbGTBegCupdj6TLas8iuvPTMFA=;
 b=fMYaPbF7NS16BxR6lGFI3Xe0Rnx94EOIRrW5uRmqmIK98HSz21IH+oHLcVNkF5ZO7U
 pojhtEwD1Q82KZZvvLoUdU2m3UqySF2OcIPbsc3MM2fjYvU0IPP/prVNhcOA4Nolg6Wb
 PDwRQBVyKhcdoWkBoYUE375pKwTgJTTBYyB9MCS9xgF6AccdV9tfqqS8VgH3n+pbpdJg
 Ppir9ju5npESfF0yQqF8HFWfOUkvYyVBXK/RHeLxojo+n5qcrDj5giO5Tg+If7riT96O
 Vo9KabaxNWGm+32S4nHY9hPlsVern2LIQHLkYdTxMs9jvGtCQ7c+b4pB/DCv2si9JazG
 K+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FRvhEMuNKaDLPqTwPhbGTBegCupdj6TLas8iuvPTMFA=;
 b=jN4dTdQS3mUW49HyT9OIvAwnJZ2v9+rm//h/UMjadog3mMscu3tTvgJkgMjXJQefAl
 F82zqK3GE9lmGekI3uLYacsX4JdmFL5eJwNdzu0HsQ7i/TbcUICRx7gOBy2AyIn9nX1K
 8Na0Hed+9JSFpWTlAnIAwFeCNnoRZ7YaUchOZPmMXCSW1h81biU2xlkp95Baq7oKqwkD
 dsXluPqWQGzQFjyPDO3ti0Ag8PzEKU9SEhFPryTZh/QFn2qJdUMXFIyhbyVVAbRDGayb
 o0FWpaVhEqmriw+S2qbYejt3KkN294rJuclAnvUFwoLXN1Mvw54CisjqIfK8tipFEy3c
 7pdw==
X-Gm-Message-State: AOAM532JttH0kjmDV5SxT1Exxmfwl+5/DTemjFujpBC8Y9NCHUBL0Ces
 skr6Nht0glgf/wdzTsNwva4wBQ==
X-Google-Smtp-Source: ABdhPJxSpujWnNfQOdMvHvejyRqq8Z5hAUO2na5UABRht9wkHJt0U44utkkAPOVbrZY3Ds9Y8sDklA==
X-Received: by 2002:adf:b19c:: with SMTP id q28mr5604241wra.119.1603297907836; 
 Wed, 21 Oct 2020 09:31:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a185sm3990375wmf.24.2020.10.21.09.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 09:31:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5EAF61FF92;
 Wed, 21 Oct 2020 17:31:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 6/6] tests/acceptance: pick a random gdb port for reverse
 debugging
Date: Wed, 21 Oct 2020 17:31:36 +0100
Message-Id: <20201021163136.27324-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201021163136.27324-1-alex.bennee@linaro.org>
References: <20201021163136.27324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the test randomly fails if you are using a shared machine
due to contention on the well known port 1234. We can ameliorate this
a bit by picking a random non-ephemeral port although it doesn't
totally avoid the problem. While we could use a totally unique socket
address for debugging it's impossible to probe for gdb support of the
feature which makes this a sub-optimal but less fiddly option.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/acceptance/reverse_debugging.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/reverse_debugging.py b/tests/acceptance/reverse_debugging.py
index b72fdf6cdc..f2e8245471 100644
--- a/tests/acceptance/reverse_debugging.py
+++ b/tests/acceptance/reverse_debugging.py
@@ -16,6 +16,7 @@ from avocado.utils import gdb
 from avocado.utils import process
 from avocado.utils.path import find_command
 from boot_linux_console import LinuxKernelTest
+from random import randrange
 
 class ReverseDebugging(LinuxKernelTest):
     """
@@ -43,7 +44,8 @@ class ReverseDebugging(LinuxKernelTest):
         else:
             logger.info('replaying the execution...')
             mode = 'replay'
-            vm.add_args('-s', '-S')
+            self.port = randrange(2048, 49152)
+            vm.add_args('-gdb', 'tcp::%d' % (self.port), '-S')
         vm.add_args('-icount', 'shift=%s,rr=%s,rrfile=%s,rrsnapshot=init' %
                     (shift, mode, replay_path),
                     '-net', 'none')
@@ -122,7 +124,7 @@ class ReverseDebugging(LinuxKernelTest):
         # replay and run debug commands
         vm = self.run_vm(False, shift, args, replay_path, image_path)
         logger.info('connecting to gdbstub')
-        g = gdb.GDBRemote('127.0.0.1', 1234, False, False)
+        g = gdb.GDBRemote('127.0.0.1', self.port, False, False)
         g.connect()
         r = g.cmd(b'qSupported')
         if b'qXfer:features:read+' in r:
-- 
2.20.1


