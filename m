Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E39C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673192467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQwhrNJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673192467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6uzM-0000VJ-Hd
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6uty-00010T-Bg
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6utx-0006v6-2s
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:54 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42301)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6utw-0006qU-PY
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:30:52 -0500
Received: by mail-wr1-x441.google.com with SMTP id p18so2525129wre.9
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IOCp7//xuJ1gvtqmOaoBWn6mtaBnhkwhAqap6W0CKnQ=;
 b=IQwhrNJA9jW8yckfcw7zuVAMlRzmkUobteW8Gw7OeYAtg4gV+dI6P7awspIcAT7WWD
 K9T/KjOQ9/HtwH1Au+qFlJ1BM9BTjkGaeYMzGn/3Nd/Hb6FTk0cHCJjTP6KRqw8ZwluQ
 2DmPoT7WGEUkhGzCdjFSjxE3yblPnyWfGBP74/nHfB8UCENVy32J8qqnQAzSKkXUxmYU
 eYjbAQUudXbey6/hjpMjQrbPS8pDlQtJsRpHb3I3Nx8Ncbxxz96g+M7QQi2MeIEZ2+6S
 PYGjzn8M2NPomHZej2dYCABy5ifXw+sAYGIFjazLYf2Rr5SWp5FvukWHpi70k59ZP0D2
 4TcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IOCp7//xuJ1gvtqmOaoBWn6mtaBnhkwhAqap6W0CKnQ=;
 b=qhhSBHriUB5MQtIwXz7VlD32Q5xfDSz7nhO0tf8pVWM/X3+HaKq2UYQKKxY8LFucBP
 btKgwUYVPhSvaYtkoDWJ2LwTRgaNunKTg6UF82mqG+Nt/EcI7PNP8LsLoD7V9u4YFvbv
 wP4DPiKDhzyGFr8Ym5SUpbqVcP1lYuNra8HLd3IX5B3h8Yby1QdaRjf7KMiTuPwKtYZK
 ekfHphbtkoTFcBxtJZkM+X1rFYjWyCIj887GiI02/9Z8YT3lYkOJHz84tRo1+JauWxmV
 LvxBJjx8CKJotdnf/8cYNbC/RjpjUytdgTR/x7f68C5zECFS4D8pLr6I6uxNaIfZQLD0
 yC9A==
X-Gm-Message-State: APjAAAXqkO7tGCCn5l5fmy4wSjsffIjlIlb+rhW5nD7xq/fpDtGrKj3j
 YOjWY72J+SW+nIpq3oyUBhC4V6N6
X-Google-Smtp-Source: APXvYqwxE+Itv2B03v9bK7V62+9qVRpL+zKnpTLSAnhu45n7WLk3r0yzo8uYThWcp9oeVYhCNu2l1Q==
X-Received: by 2002:adf:de12:: with SMTP id b18mr2290618wrm.268.1582716651381; 
 Wed, 26 Feb 2020 03:30:51 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id h128sm2628154wmh.33.2020.02.26.03.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 03:30:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/18] docs/system: convert managed startup to rST.
Date: Wed, 26 Feb 2020 12:30:32 +0100
Message-Id: <20200226113034.6741-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200226113034.6741-1-pbonzini@redhat.com>
References: <20200226113034.6741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Fix one typo in the process and format more option and
command names as literal text, but make no significant
changes to the content.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/index.rst           |  1 +
 docs/system/managed-startup.rst | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 docs/system/managed-startup.rst

diff --git a/docs/system/index.rst b/docs/system/index.rst
index d38addb2a0..b2263b70d8 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -13,4 +13,5 @@ Contents:
 
 .. toctree::
    :maxdepth: 2
+   managed-startup
    security
diff --git a/docs/system/managed-startup.rst b/docs/system/managed-startup.rst
new file mode 100644
index 0000000000..9bcf98ea79
--- /dev/null
+++ b/docs/system/managed-startup.rst
@@ -0,0 +1,35 @@
+Managed start up options
+========================
+
+In system mode emulation, it's possible to create a VM in a paused
+state using the ``-S`` command line option. In this state the machine
+is completely initialized according to command line options and ready
+to execute VM code but VCPU threads are not executing any code. The VM
+state in this paused state depends on the way QEMU was started. It
+could be in:
+
+- initial state (after reset/power on state)
+- with direct kernel loading, the initial state could be amended to execute
+  code loaded by QEMU in the VM's RAM and with incoming migration
+- with incoming migration, initial state will be amended with the migrated
+  machine state after migration completes
+
+This paused state is typically used by users to query machine state and/or
+additionally configure the machine (by hotplugging devices) in runtime before
+allowing VM code to run.
+
+However, at the ``-S`` pause point, it's impossible to configure options
+that affect initial VM creation (like: ``-smp``/``-m``/``-numa`` ...) or
+cold plug devices. The experimental ``--preconfig`` command line option
+allows pausing QEMU before the initial VM creation, in a "preconfig" state,
+where additional queries and configuration can be performed via QMP
+before moving on to the resulting configuration startup. In the
+preconfig state, QEMU only allows a limited set of commands over the
+QMP monitor, where the commands do not depend on an initialized
+machine, including but not limited to:
+
+- ``qmp_capabilities``
+- ``query-qmp-schema``
+- ``query-commands``
+- ``query-status``
+- ``x-exit-preconfig``
-- 
2.21.1



