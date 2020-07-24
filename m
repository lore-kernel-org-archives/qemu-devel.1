Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6B5C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DC120748
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I02u5wJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DC120748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jysFk-0007P9-Uj
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 03:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jysEu-0006TD-QP
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:35:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jysEt-0007iM-6I
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:35:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id a15so7356009wrh.10
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/nVeHrs+IFFkRgjIADjEwV9dEpLKvbbwCYJXCwf1BeI=;
 b=I02u5wJBiLca+W3GZkg7t5P6RtnAv03uxG9xwridN7adS3XkOLjmzCU1Vb06MBo+bt
 ju2MI1WNCCxKx5tzVbBM2oQAVOsN/6Jnkwu1xjCRaJl2Wy+fte8WOEr+M4WsFYjIHrIg
 TASAJzF1C5UJfFCjGhnTPgPf3ik9JmakkS+7v4eHqdNKLnQRZ+bxFrMej3o9gLhymn1Z
 S6RrEA2XzW3AyYbzA6d2XWjg544qcaa6Miz35HAOm85orRSaGI3I+paHOa6pHlafdTnk
 OzWFU/Gzgj7ux++gAqiraqo+rPI04LPT5RX9+b0awwFKGS9T6x6zg3FKT34NEjbHhBBM
 +IIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/nVeHrs+IFFkRgjIADjEwV9dEpLKvbbwCYJXCwf1BeI=;
 b=DRmprG4UjRnO+AkMS3ARG/da1e519rK0N8zTl5Yj8Eb6yt0amYjGg2svivqJ+uozXJ
 bbVa4ZxzEm5W8MspPjjhIVH16i3pdt6+rSFlHKVMOOQx1fyIWk6UtjzPOHxTA2mEoBBq
 W+/KvPftnF2MhVP9bphUpW0cGcTQvM6lARP/5ZLBCuUe+ey/JPK7DcD9AsZKrL8Vm3vh
 nzwioip4v3EkteExmP1VBvb5+/12DJWt2R2kRb/Yp9lcpyNRSy6y6VzrfpUaxAo/QSQw
 JGtBUuis9pPtBMTQelcWWTQMKQ7j2WWLdzBUvoxMIg/bn4xWL+1piDT/HK2Ha9/6JdcV
 HAmA==
X-Gm-Message-State: AOAM533voDotrWv0Ap5tx6jR9aZ8sP8yMBewhqDaK0YHImlU33vENZRj
 EsqsiRpO7xyM2P5FU1bFfU9+Kx40siI=
X-Google-Smtp-Source: ABdhPJwWJd5KI2p8hLX/Fga/I+vhdouHT/rMnyPZw5xLqhyqclKNXFFfaMjPCRTRjgarIoFe0NIwvQ==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr7300577wro.314.1595576128853; 
 Fri, 24 Jul 2020 00:35:28 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y189sm7319431wmd.27.2020.07.24.00.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 00:35:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests: Exclude 'boot_linux.py' from fetch-acceptance rule
Date: Fri, 24 Jul 2020 09:35:24 +0200
Message-Id: <20200724073524.26589-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200724073524.26589-1-f4bug@amsat.org>
References: <20200724073524.26589-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <willianr@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The boot_linux.py file triggers an exception:

  $ make fetch-acceptance
  AVOCADO tests/acceptance
  Fetching assets from tests/acceptance/empty_cpu_model.py.
  Fetching assets from tests/acceptance/vnc.py.
  Fetching assets from tests/acceptance/boot_linux_console.py.
  Fetching assets from tests/acceptance/boot_linux.py.
  Traceback (most recent call last):
    File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/__main__.py", line 11, in <module>
      sys.exit(main.run())
    File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/core/app.py", line 91, in run
      return method(self.parser.config)
    File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py", line 291, in run
      success, fail = fetch_assets(test_file)
    File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py", line 200, in fetch_assets
      handler = FetchAssetHandler(test_file, klass, method)
    File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py", line 65, in __init__
      self.visit(self.tree)
    File "/usr/lib64/python3.7/ast.py", line 271, in visit
      return visitor(node)
    File "/usr/lib64/python3.7/ast.py", line 279, in generic_visit
      self.visit(item)
    File "/usr/lib64/python3.7/ast.py", line 271, in visit
      return visitor(node)
    File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py", line 139, in visit_ClassDef
      self.generic_visit(node)
    File "/usr/lib64/python3.7/ast.py", line 279, in generic_visit
      self.visit(item)
    File "/usr/lib64/python3.7/ast.py", line 271, in visit
      return visitor(node)
    File "/var/tmp/qemu-builddir/tests/venv/lib64/python3.7/site-packages/avocado/plugins/assets.py", line 171, in visit_Assign
      self.asgmts[cur_klass][cur_method][name] = node.value.s
  KeyError: 'launch_and_wait'
  make: *** [tests/Makefile.include:949: fetch-acceptance] Error 1

Exclude it for now. We will revert this commit once the script is
fixed.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 238974d8da..7c9cf7a818 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -950,7 +950,7 @@ fetch-acceptance: check-venv
             $(TESTS_VENV_DIR)/bin/python -m avocado \
             $(if $(V),--show=$(AVOCADO_SHOW)) \
             assets fetch \
-            $(wildcard tests/acceptance/*.py), \
+            $(filter-out tests/acceptance/boot_linux.py,$(wildcard tests/acceptance/*.py)), \
             "AVOCADO", "tests/acceptance")
 
 check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
-- 
2.21.3


