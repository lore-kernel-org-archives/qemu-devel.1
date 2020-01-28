Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41D1C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E9F207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqG0wcfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E9F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVpx-00006a-VJ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV74-0002da-NQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV73-0006Tq-Ms
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:22 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:37437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV73-0006RC-Fm
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:57:21 -0500
Received: by mail-wr1-x42d.google.com with SMTP id w15so17145343wru.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k3mJ+3xbycaGF5EBNxbpfTNlzaWWjYiUthUQwGdmtr0=;
 b=cqG0wcfvboa5eb+z713CbpJ7esdeOUVHRigroUR2VHfCVy4rubcimouwV9aRh4nWAA
 QQPDzpfT/jH78DDsPH2rmldPgkBzelDxGDDkwQtnUESwv5LW+03KlLsdKuemftJhhNcu
 i6EDjQOqa/WA44w3AmwsCVfWKg2hrS/z7eiy4sQdo/Cw7bEEJ9/8gi3UcZLb2RVsV4DI
 YsOL6Gxk2dHiTAjX7lgztIhdwUKtfq27HwJ8ERNFPT3Hg0RF9GfD9EhUArpErFhdroyz
 p4dUASx/eI0aqcjIUibDSUifjHaHSSX+MSGbiFgYGLcwOQ3U4Yni6kCA0i0MZ9lgdFjV
 EAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=k3mJ+3xbycaGF5EBNxbpfTNlzaWWjYiUthUQwGdmtr0=;
 b=Vun0XCC5msFBshaRgajwr3yi0h0CVHveGOlQKphuKmI0XQZKhepqFHa4OVNElVw5kI
 NYz/QBOB3WXKAaBTLC5H2YKwEizfyEsj0bQerapcblyMZYr6PE0K/+pr2XMCHJ6b5bnE
 tSTsZ33AdD/NtF5HrvIgT1MP05ZMycSDdx7/p1zqpFbc1SFkgCAY+PRtTs8PasRUzyHZ
 sT/aPimR4et/Laz1n2srkAatsypMJm/thhdQ7ilZauAb0iBoRMWwFUQPaR2lj7rvX+S/
 H1LpZB27+50Pa1PZZN656tW0MxJES+/1Nn/4Bdxa1d5vzQl5qMxIbNONNSnS/Lq6nHnH
 a8sw==
X-Gm-Message-State: APjAAAU8Y2amTmsAqo7cQxK/NLk2D+OvgOMRb096mxEqqA1RKhjQS96A
 R/CPjSp6e+fZtKnY3MRObxPtCJ8I
X-Google-Smtp-Source: APXvYqw3WO/W+0yH9VWdvh979uytDw/s3KNQ3M2yYSRVIS1osnZmyfk7kkjG7zHsngAug7sgQjximQ==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr30006823wrr.266.1580234240355; 
 Tue, 28 Jan 2020 09:57:20 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:57:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 090/142] meson: convert hw/rdma
Date: Tue, 28 Jan 2020 18:52:50 +0100
Message-Id: <20200128175342.9066-91-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs      |  1 -
 hw/meson.build        |  1 +
 hw/rdma/Makefile.objs |  3 ---
 hw/rdma/meson.build   | 10 ++++++++++
 4 files changed, 11 insertions(+), 4 deletions(-)
 delete mode 100644 hw/rdma/Makefile.objs
 create mode 100644 hw/rdma/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 951d451b77..d27c8f989d 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -19,7 +19,6 @@ devices-dirs-$(CONFIG_IPMI) += ipmi/
 devices-dirs-y += isa/
 devices-dirs-y += misc/
 devices-dirs-y += net/
-devices-dirs-y += rdma/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 0bdd6a2613..f704e51361 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -6,6 +6,7 @@ subdir('pci')
 subdir('pci-bridge')
 subdir('pci-host')
 subdir('pcmcia')
+subdir('rdma')
 subdir('rtc')
 subdir('scsi')
 subdir('sd')
diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
deleted file mode 100644
index 819bb12a35..0000000000
--- a/hw/rdma/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-$(CONFIG_VMW_PVRDMA) += rdma_utils.o rdma_backend.o rdma_rm.o rdma.o
-obj-$(CONFIG_VMW_PVRDMA) += vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o \
-                     vmw/pvrdma_qp_ops.o vmw/pvrdma_main.o
diff --git a/hw/rdma/meson.build b/hw/rdma/meson.build
new file mode 100644
index 0000000000..7325f40c32
--- /dev/null
+++ b/hw/rdma/meson.build
@@ -0,0 +1,10 @@
+specific_ss.add(when: 'CONFIG_VMW_PVRDMA', if_true: files(
+  'rdma.c',
+  'rdma_backend.c',
+  'rdma_rm.c',
+  'rdma_utils.c',
+  'vmw/pvrdma_cmd.c',
+  'vmw/pvrdma_dev_ring.c',
+  'vmw/pvrdma_main.c',
+  'vmw/pvrdma_qp_ops.c',
+))
-- 
2.21.0



