Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795ADC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435A12077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRbLtdco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435A12077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOdt-0007Ar-TJ
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNya-0003rI-6G
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyZ-0007Cs-4P
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:52 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:40438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyY-0007BE-Tn
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:51 -0500
Received: by mail-wr1-x42e.google.com with SMTP id c14so2607694wrn.7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YBMtW7/slCFp25JbxpbTiSSPBB6bO91AS1uGQxrTq6o=;
 b=sRbLtdcohVktZDlC8bzgVvCOoBdiq7J74UytyJTT7QlzCuIA+4lKU3RnJUzEHNH4NS
 D++iKB7idrW9magoQRpKMQGfYoMvIXCVVNo6R0FL8eGAGYT65OH0lk0/08i5pJt+uuiZ
 YUm/tbwg88rGZVLJQMclVstop6cBuW7JH5q9JlaJkxd7QGdu1Z+OnAJT5xynuMiFkv/v
 Qme5IMgwihSjlRW599rto5J7bvSAax+TEkxYQWerxw50/whv7609gP0mxkI5SdHonohj
 t6lsvmiIQeTqsb2oK97Ug3z6YCXKdb5lApSKABTPGZZq9youonx0kJXzteICyW32n/BZ
 DCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YBMtW7/slCFp25JbxpbTiSSPBB6bO91AS1uGQxrTq6o=;
 b=FFA/IoX0G2MthOkf8O9KAiyfXwZmsBgMJS4uHEEJMY7LYJ2GpQw/OA2tq6D41UUuvb
 UDTNbtkew9fT9PtDsDRgs45/t/fR68bMxJzlw9RwTM7hYp0WdNVMbKkX1ywJ2Kf/sPVG
 sFd7htRXyMGyiNpjTDtCr3ScGw+aAtaUnPb8wZLVvuhPqYV3ZAS56UpigwhmwKId5YKW
 63eEplq6gL7fGp0Zl9SB51GTOVklEs7BhvlL09MtG161+Si+HFDfnTWfL0Ncv8mjrf0h
 bNixGNXkE7/8PbyIzMO8CP8dAWm0LoiERy5x6Z0vlCg0myPJCU/1U+utiayyAfaOknWy
 cS2w==
X-Gm-Message-State: APjAAAV6hbQ1q9rqzLTzzsEqOn28+HQmc1lAcrsj+Yo2WKJ8rwcN3Fmi
 oBW32OeDmU6gLAX9OXFZjO1kzlBC
X-Google-Smtp-Source: APXvYqw5xypLEGV3TVhCj8N0rTEZbwggGr+/p64I3ER0d3FHMlY7yIZT2oLIA0wMNdx6PJCbss/+0w==
X-Received: by 2002:adf:d848:: with SMTP id k8mr5982149wrl.328.1576155229697; 
 Thu, 12 Dec 2019 04:53:49 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 052/132] meson: convert block/
Date: Thu, 12 Dec 2019 13:51:36 +0100
Message-Id: <1576155176-2464-53-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile.objs       | 3 +--
 block/Makefile.objs | 1 -
 block/meson.build   | 2 ++
 3 files changed, 3 insertions(+), 3 deletions(-)
 delete mode 100644 block/Makefile.objs

diff --git a/Makefile.objs b/Makefile.objs
index 0bc9167..4c7ae48 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -35,8 +35,7 @@ qom-obj-y = qom/libqom.fa
 # single QEMU executable should support all CPUs and machines.
 
 ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-y = block/
-common-obj-y += dump/
+common-obj-y = dump/
 common-obj-y += monitor/
 common-obj-y += net/
 common-obj-$(CONFIG_LINUX) += fsdev/
diff --git a/block/Makefile.objs b/block/Makefile.objs
deleted file mode 100644
index 83e87b3..0000000
--- a/block/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-common-obj-y += stream.o
diff --git a/block/meson.build b/block/meson.build
index a68689b..ca62992 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -98,4 +98,6 @@ module_block_h = custom_target('module_block.h',
                                command: [module_block_py, '@OUTPUT0@', modsrc])
 block_ss.add(module_block_h)
 
+softmmu_ss.add(files('stream.c'))
+
 modules += {'block': block_modules}
-- 
1.8.3.1



