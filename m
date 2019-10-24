Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2499CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF3620679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IynQ4FYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF3620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNakj-0003xG-KN
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaOy-0000fm-Cc
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNaOx-0007o8-56
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:31:32 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:44278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNaOw-0007nk-UU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:31:31 -0400
Received: by mail-wr1-x432.google.com with SMTP id z11so2088849wro.11
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vLJ2YSmOllt3Q5f6C9bffaEhtm/oTDIY5U5spBdjavA=;
 b=IynQ4FYDONnMsz5gtrp5ovvxHbeVxB7m8vuB+mf4wn5MzvMIZxYCzsmk9MhK9kQGr9
 ZUOonUGnATWnZ0xgR5uADH7Q9tG2VWvZnXqkF2gselrAzZ4uviTsFB4vBHgbbvdHfOed
 hwkiqVe2Om2PVTqonOkOYdiNqQ7c/Ql7Ddcr7xlQrGJEdwnkYVALxyVsn/U4Bp5kJv4E
 BdFWuWZNUYidrX+YqNSXwng995edJEA7ax5j8u1Bw5zc9NXU5qC61jleN6zB6hKCIJu/
 /+3Z2PNj9jLZv5e+5k+a04QvmQlUOHx/4mJF3TLhEZrunF640NnzTyuS4pUOy0+CWtz8
 0Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vLJ2YSmOllt3Q5f6C9bffaEhtm/oTDIY5U5spBdjavA=;
 b=gfCKZbUUnOCYodVCm+DdQfr8+CIYnb4zfoCliCJkv3672yK6TMKuFVMVdl0xdfCwff
 TdRMsJgUlTvpQcNX/hRZqCJkYi8CSvU5RCCiZesjus4FqFN2E2p3xZ9M8LDH4k8VTPZI
 a/hmB/VwxEk+QIPWXFZqiUIfby9J6SS4+ySjIexujM2R3GZsE1y6jo5LyAWf+Iy9SYFf
 45m1RWwhnXVdKDq2rK502pNlBOHAh7S0G/iG5aQjOQSqe1eQvV6WRP2gcRNUDwLR+2HN
 OtjxQa1ThX80RcbmcIYclRPxDoruUdBoCaTApfYkJYNQAu2cGEGQYML9W79MshC6UaBp
 Qh/w==
X-Gm-Message-State: APjAAAWGW4X3X4k0T7rn2JbgmZ1ZURHCJU1RBVz+1DyM0payperddL95
 3CN6MGS2Ocv7j9QMLWJHLgMBFQ==
X-Google-Smtp-Source: APXvYqxt+KbmBIkYdPpMr+wwzIQ0NUup1m/uDBGyeRu6pAS/MDVbHREvQ0YgplYAkRyfafC8S8eQvQ==
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr3135437wrs.63.1571913089602; 
 Thu, 24 Oct 2019 03:31:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q14sm28691194wre.27.2019.10.24.03.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 03:31:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 568D11FF9B;
 Thu, 24 Oct 2019 11:22:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 11/17] tests/vm: Let subclasses disable IPv6
Date: Thu, 24 Oct 2019 11:22:34 +0100
Message-Id: <20191024102240.2778-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024102240.2778-1-alex.bennee@linaro.org>
References: <20191024102240.2778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

The mechanism will be used to work around issues related to IPv6
on the netbsd image builder.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191018181705.17957-3-ehabkost@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 4921e47f9f2..59bd1d31fbe 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -57,6 +57,8 @@ class BaseVM(object):
     arch = "#arch"
     # command to halt the guest, can be overridden by subclasses
     poweroff = "poweroff"
+    # enable IPv6 networking
+    ipv6 = True
     def __init__(self, debug=False, vcpus=None):
         self._guest = None
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
@@ -81,7 +83,8 @@ class BaseVM(object):
         self._args = [ \
             "-nodefaults", "-m", "4G",
             "-cpu", "max",
-            "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
+            "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22" +
+                       (",ipv6=no" if not self.ipv6 else ""),
             "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20"]
         if vcpus and vcpus > 1:
-- 
2.20.1


