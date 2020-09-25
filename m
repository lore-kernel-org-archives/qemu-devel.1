Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CE7C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537B520756
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBJZ7pcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537B520756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnPO-0007hX-Ui
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJj-0002aU-VH
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:16 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnJg-0002H4-FG
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:59:15 -0400
Received: by mail-wr1-x431.google.com with SMTP id c18so3486009wrm.9
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pVKBS48AbwRPMB8Nsn3vDh4qlhS4C2TzgyypcYvasXA=;
 b=ZBJZ7pcJqJAVmUAbL4bU66vcIwVRIBqHWOASZ/moE0vV9ZZ33zqzmEXlFz4PpHxyJj
 Uaz50G84KCnXXDED5db8v/So/HcoT41z/5o6kTlmVpJeGh9K1osiMIDL+9ePs+osyjtw
 ILIJ4EmKoiyejWgBu8wQq6abQvntQ8CYDjEe2HFSomOfk4gmh26KOujkWs9BaIO1BKUR
 Z1Uh1k1BlhWT/C+rmkcVZk7X5PcR9R/g/YTXKLN7lFCNJhPdxGR+HfwTM8xnlyqrvzDG
 a+1tkSxfjFM2zda9K6l23VMm3E+YHLGwoij5h5DI9k3dvIDSp0NyuCjHuEyXrR0ZUmiP
 c69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pVKBS48AbwRPMB8Nsn3vDh4qlhS4C2TzgyypcYvasXA=;
 b=fR5KJ/Cu7kIcb6U5JabxCnHRARqZAXFNnWU2YvtsrIp8mHAWTjExXo3lg03vLcE0mn
 Im5CKDyJrfB6526d4I4ApURoBMcNoNwCVQ1W9yX8x3jWW3Zr5XfcU9JSMj5j8AmwwVxJ
 seZXqPH0Dxqc1ru4W3zr6pUvNsE8l7BCkZVfjxFjHCq1P6TPUDpvvdqyoY9Wk4Lz91qK
 8zaAQoI7rKmVl5ozYYUziZyu+ybDbiwp+9xGl4wRutYKt7hJCpaQx3kSxwCLE1yCqtvV
 bCO1spty42A1HGDHgN77kXCQjs0+z92vg0nXPubpoicB298zqihoiPui+QUA8flOG/Su
 8AIg==
X-Gm-Message-State: AOAM531/SLnR/XthWJHigYxhLZFtlQD6Rl4nf826oJIb4Tl0tk2uNoPQ
 18X20V5bN35QkFQE4hY5hARGWQ==
X-Google-Smtp-Source: ABdhPJwCqES0abvcUL6qZHv6FfjWwPBI3DLs8hO10nQV8cxdXD+ajQvsKcdNDT3JetUMn+NKAOi/PQ==
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr4416288wrt.122.1601038750650; 
 Fri, 25 Sep 2020 05:59:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e1sm2891195wrp.49.2020.09.25.05.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:59:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 064BC1FF7E;
 Fri, 25 Sep 2020 13:51:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH  19/19] docs: add a man page for vhost-user-rpmb
Date: Fri, 25 Sep 2020 13:51:47 +0100
Message-Id: <20200925125147.26943-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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
Cc: jean-philippe@linaro.org, takahiro.akashi@linaro.org,
 virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Basic usage and example invocation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/tools/index.rst           |   1 +
 docs/tools/vhost-user-rpmb.rst | 102 +++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 docs/tools/vhost-user-rpmb.rst

diff --git a/docs/tools/index.rst b/docs/tools/index.rst
index 232ce9f3e463..488784b3bf1f 100644
--- a/docs/tools/index.rst
+++ b/docs/tools/index.rst
@@ -15,3 +15,4 @@ Contents:
    qemu-trace-stap
    virtfs-proxy-helper
    virtiofsd
+   vhost-user-rpmb
diff --git a/docs/tools/vhost-user-rpmb.rst b/docs/tools/vhost-user-rpmb.rst
new file mode 100644
index 000000000000..40d5d3bceb7c
--- /dev/null
+++ b/docs/tools/vhost-user-rpmb.rst
@@ -0,0 +1,102 @@
+QEMU vhost-user-rpmb - rpmb emulation backend
+=============================================
+
+Synopsis
+--------
+
+**vhost-user-rpmb** [*OPTIONS*]
+
+Description
+-----------
+
+This program is a vhost-user backed that emulates a VirtIO Replay
+Protected Memory Block device. These are usually special partitions
+that are part of a flash device that offer protection against reply
+attacks. They are used to store secure information in a way that is
+hard to tamper with.
+
+This program is designed to work with QEMU's ``--device
+vhost-user-rpmb-pci`` but should work with any virtual machine
+monitor (VMM) that supports vhost-user. See the Examples section
+below.
+
+This program requires a backing store to persist any data programmed
+into the device. The spec supports devices up 32Mb in size. For the
+daemon this is simply a raw file of the appropriate size. To program
+the device it needs to have a key. This can either be programmed by
+the guest at the start or come from a key file supplied to the daemon.
+
+Options
+-------
+
+.. program:: vhost-user-rpmb
+
+.. option:: -h, --help
+
+  Print help.
+
+.. option:: -V, --version
+
+  Print version.
+
+.. option:: -v, --verbose
+
+   Increase verbosity of output
+            
+.. option:: --debug
+
+  Enable debug output.
+
+.. option:: --socket-path=PATH
+
+  Listen on vhost-user UNIX domain socket at PATH. Incompatible with --fd.
+
+.. option:: --fd=FDNUM
+
+  Accept connections from vhost-user UNIX domain socket file descriptor FDNUM.
+  The file descriptor must already be listening for connections.
+  Incompatible with --socket-path.
+
+.. option:: --flash-path=PATH
+
+  Path to the backing store for the flash image, can be up to 32Mb in size.
+
+.. option:: --key-path=PATH
+
+  Path to the backing store for the key of 32 bytes.
+            
+.. option:: --key-set
+
+  Treat the value of key-path as set meaning the key cannot be
+  reprogrammed by the guest.
+
+.. option:: --initial-counter=N
+
+  Set the initial value of the devices write count. It is
+  incremented by each write operation. 
+
+Examples
+--------
+
+The daemon should be started first:
+
+::
+
+  host# vhost-user-rpmb --socket-path=vrpmb.sock \
+   --flash-path=flash.img \
+   --key-path=key --key-set \
+   --initial-counter=1234
+
+The QEMU invocation needs to create a chardev socket the device can
+use to communicate as well as share the guests memory over a memfd.
+
+::
+
+  host# qemu-system \
+      -chardev socket,path=vrpmb.sock,id=vrpmb \
+      -device vhost-user-rpmb-pci,chardev=vrpmb,id=rpmb \
+      -m 4096 \
+      -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
+      -numa node,memdev=mem \
+      ...
+
-- 
2.20.1


