Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC8AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC18121835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+Dk1KTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC18121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueEf-0005bY-2Q
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrK-0004tj-48
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrI-0003H3-Lc
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:21 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:44792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrI-0003Ge-F9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:20 -0500
Received: by mail-wr1-x42f.google.com with SMTP id q10so3116513wrm.11
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vJD0BoXFI1BC+rrhGs3A0H4XskjTico//vi5GiSKD8E=;
 b=n+Dk1KTNmi0db8PleazGqj6izocf777l+1xU5JfGNiuvhAmUncm5i1aFBvanUnIR3x
 Zrzpc2ZQBwrCiCnWQW5eA//DiexwgnVcOjxPiQhKTSIxEwl4KNK8uYsoBkVWAYrMczvZ
 JYs8m2/hp0lOfke7CMzMCBNWxRaQowWxP9x1ia9vyQgtZZ+iJS49Z5+TAm6QNgAydG9o
 r9M9OLVmo7W0ivWnA0rkb/W34ulPDG3vIhD2ku+LruAGkMI7v2AzOXY0ZrGcVpKltegE
 Gpzexh0UrWKOBzyU5vQo/pxA1wdeQYcFL9xH4L22piL1QGoackoJXAOW4M5SlhT19PhP
 fwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vJD0BoXFI1BC+rrhGs3A0H4XskjTico//vi5GiSKD8E=;
 b=S0IBckYiBPCzANEa5Krxesyj5AUfBm+2vet5DAyFsMdFy8JrTwzD96wVFbZhtikcJU
 Rfby4VBREH6iHWLBkugnAArjPlIXGxkSskPt+RDIw5vJJ/hBSjyXUE2298gUA2I6OmUZ
 ahUCcaADCKEwjFnNMeiXdvyLl6aPAGPkp9sQ9JWMoeimq1rTNkxe/7ROL45NMCnN8Ro2
 A2W9DvFGgdV+d8CuMn0NTSt7SQ0qCV9sn8n4O/dQmAM46EYNJxxFwiAXtYQDEjOW2ktT
 atQNzKpR7NBD1oYu4Z0fl0R55oN3dNPtJEgCXAZe9DRi3qLa+aTf1iRVhBZ3B7Unrwv8
 RIKQ==
X-Gm-Message-State: APjAAAU4JOolH2Sskpr3/hnhAMu3xQ2MjJ3V2CNZWED+SpsMGkYgy9S1
 ca7+cseA0Lpf2ltom5ENWNmliYET
X-Google-Smtp-Source: APXvYqwALekMVITrC7yIBH8eHz81gdkGCVSXKLfl3GYcOmYLIhnJBt+aD/YyKo7JP7H7sWZqIa2CBQ==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr17816376wrr.266.1579787359176; 
 Thu, 23 Jan 2020 05:49:19 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/59] Makefile: Restrict system emulation and tools objects
Date: Thu, 23 Jan 2020 14:48:17 +0100
Message-Id: <1579787342-27146-15-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Restrict all the system emulation and tools objects with a
Makefile IF (CONFIG_SOFTMMU OR CONFIG_TOOLS) check.

Using the same description over and over is not very helpful.
Use it once, just before the if() block.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200118140619.26333-4-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 5aae561..395dd1e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -4,15 +4,14 @@ stub-obj-y = stubs/
 util-obj-y = crypto/ util/ qobject/ qapi/
 qom-obj-y = qom/
 
-chardev-obj-y = chardev/
-
 #######################################################################
-# authz-obj-y is code used by both qemu system emulation and qemu-img
+# code used by both qemu system emulation and qemu-img
 
-authz-obj-y = authz/
+ifeq ($(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS)),y)
 
-#######################################################################
-# block-obj-y is code used by both qemu system emulation and qemu-img
+chardev-obj-y = chardev/
+
+authz-obj-y = authz/
 
 block-obj-y = nbd/
 block-obj-y += block.o blockjob.o job.o
@@ -22,16 +21,12 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 
 block-obj-m = block/
 
-#######################################################################
-# crypto-obj-y is code used by both qemu system emulation and qemu-img
-
 crypto-obj-y = crypto/
 
-#######################################################################
-# io-obj-y is code used by both qemu system emulation and qemu-img
-
 io-obj-y = io/
 
+endif # CONFIG_SOFTMMU or CONFIG_TOOLS
+
 ######################################################################
 # Target independent part of system emulation. The long term path is to
 # suppress *all* target specific code in case of system emulation, i.e. a
-- 
1.8.3.1



