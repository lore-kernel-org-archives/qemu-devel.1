Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7D0C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 17:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4F321881
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 17:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKcRQMfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4F321881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2fOA-0001jI-Ev
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 13:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1i2fMd-0000mP-89
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 13:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1i2fMc-0002oC-6n
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 13:34:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:54179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1i2fMb-0002nf-WF; Tue, 27 Aug 2019 13:34:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id 10so36259wmp.3;
 Tue, 27 Aug 2019 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=msFfKZV8Erb4fZWRP/i15tZquii70gfmffWYLkM8fK0=;
 b=KKcRQMfU7vCBJIdKvx6/9jbP63WTm5rgOH5ueTNRA30/mdTWV/hhhgX52ymQxJ5B5r
 oo/9whsljZbSALS1Zl8volgAV5E/4rNENCsQYUdyw3Wcc20CvWLYiTeZzccf085GvScS
 bDLprFWEvUCQYCE/5JQCcuUzqR+Fy4hgr27nc8I5U8sWctR1BGrzOL0Lj6OGXyP61hCP
 RSEY2e6ymCs3tTl9TfSfakiPfAHdzfKEYIr+hwSlK8Zob0qd5VISUvFpH8xh4naLTP+O
 XGHSqnCjvOrA6yGoWRqBhesgFTN8HjmtWTgs/NqBkr/KzAOF2vdV/gqSLa7e0ASO1TUd
 kV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=msFfKZV8Erb4fZWRP/i15tZquii70gfmffWYLkM8fK0=;
 b=Sh3StbNWQH6LypOYTn1YBr/+gb8N87b3k8to5seb9/OR5gMSNRwWU/wiSEc3fJFaRc
 kUYQPtZxyAHSOTeu/haR85fGZP7gXTCBWSXm9v75ABbyf7f+BKwnkS5CYloqrINMInaO
 lw+yBqEtshtWdfSsZOVRyKX2p1yTPfip/Jt7SQvkLpWrqWCzl8kBLlC/jOA2DdXPUEbh
 vrab16bTUi2wtNojTuzv1vWMA/jh0wZHQKVtLyqgOBk8cVzVvk16aCvXzdFdWYW1sjeP
 w6c5otK+i8zP3Mw/VM6370wQLj9lTz6Bt+zuK93MLhbTs3o+MKqoBXNhX2KAWrZ98uEl
 kvPg==
X-Gm-Message-State: APjAAAW/MLfAvyMR0+Dxsmah9tb/1AnGt4JPxm38/LI5UXyBZSooC5mN
 vY0QnQBnG6pSiU/waL0CPP8hgNg6z6U=
X-Google-Smtp-Source: APXvYqzxkd0hk7xwoG90Z7EoehumFhXXPjjqEOXr8LyDPy7KIIEE1k99wBZea7P0aajzRPXRR+cd3w==
X-Received: by 2002:a1c:494:: with SMTP id 142mr88155wme.12.1566927276407;
 Tue, 27 Aug 2019 10:34:36 -0700 (PDT)
Received: from localhost.localdomain (109-186-142-128.bb.netvision.net.il.
 [109.186.142.128])
 by smtp.gmail.com with ESMTPSA id p9sm19993700wru.61.2019.08.27.10.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 10:34:35 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 20:34:32 +0300
Message-Id: <20190827173432.7656-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PATCH] iotests: Unify cache mode quoting
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting cache mode is not needed, and most tests use unquoted values.
Unify all test to use the same style.
---
 tests/qemu-iotests/026 | 4 ++--
 tests/qemu-iotests/039 | 4 ++--
 tests/qemu-iotests/052 | 2 +-
 tests/qemu-iotests/091 | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index e30243608b..ffb18ab6b5 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -41,8 +41,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Currently only qcow2 supports rebasing
 _supported_fmt qcow2
 _supported_proto file
-_default_cache_mode "writethrough"
-_supported_cache_modes "writethrough" "none"
+_default_cache_mode writethrough
+_supported_cache_modes writethrough none
 # The refcount table tests expect a certain minimum width for refcount entries
 # (so that the refcount table actually needs to grow); that minimum is 16 bits,
 # being the default refcount entry width.
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 0d4e963bd4..7c730d94a7 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -42,8 +42,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
-_default_cache_mode "writethrough"
-_supported_cache_modes "writethrough"
+_default_cache_mode writethrough
+_supported_cache_modes writethrough
 
 size=128M
 
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index 6e2ecbfe21..45a140910d 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -40,7 +40,7 @@ _supported_fmt generic
 _supported_proto file
 
 # Don't do O_DIRECT on tmpfs
-_supported_cache_modes "writeback" "writethrough" "unsafe"
+_supported_cache_modes writeback writethrough unsafe
 
 size=128M
 _make_test_img $size
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index d62ef18a02..f4b44659ae 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -46,8 +46,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
-_default_cache_mode "none"
-_supported_cache_modes "writethrough" "none" "writeback"
+_default_cache_mode none
+_supported_cache_modes writethrough none writeback
 
 size=1G
 
-- 
2.20.1


