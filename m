Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6095AC10F25
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5712073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eB+kGHv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5712073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAxS-0005CP-9y
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAs9-0003oW-PU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAAs7-0005EO-N9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:29 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAAs7-0005CE-Eo
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:10:27 -0500
Received: by mail-wr1-x441.google.com with SMTP id r7so1881713wro.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=35LJFplcENQkWTwhyASkVZwG6kWYY8alVYwNQMduLFs=;
 b=eB+kGHv7yj4DcoIHJsIcvOUXJHzKsXvIaRt886Duru0cupY2wpLZQJvsy60QDBaTRB
 AhxbeIFtqS60vFvPxvsuZDmcQe6FLNL0xeX7uUPZCvL/ZiL5y+GY6A/oa61otNgQBXf9
 RL9PZn6tPVQtzy9xuYaf+RhVi80Dbn4I5DJ7i4YKJ33oKH2LY+BezmK8vRMvs5A+S1OC
 cE/4X1UW1S/fQ9sn+nsHkfc/oCk9JHhy6L6e89XT5e5eyn75Jk5kBayxu1QyWdgA9kTy
 HeR1TwbfxH3FEClBa5InsGP4DyylXGfIXqj229vhNcu5D6UyvtAermxbKgVynlKrQ8hg
 Lebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=35LJFplcENQkWTwhyASkVZwG6kWYY8alVYwNQMduLFs=;
 b=Yd7Cmw1LaTwubkcVruWLBTXkd0vOjPGYFCgNh9DhZl9Z0KrpeNXCLszNc/juo2S3mx
 h1D83Yrff8Io1EIMJ/+omK2suHIot/3r+uNcamCPLTMuQbKgRleMpj3p20ZTiwVXQ4qL
 aAINucc3msVhpJbITaaAxxx+8Ywpgsf/T693U0EaqfAXGflRodNPrFp+Cf21aJ+cf8n4
 tKEjNTYHvh+MXOr+BCbjbzdKL6Sh8TmP73UU7AaVHthnhRIYpzh9HwQU/tDRPijBpgyp
 TroIknUPIiXS/DduTROamp7WYFvjQdg7OFLMyS4MsdNFkdtQ4fPYX5kgh2QC0inJLZv/
 xVFg==
X-Gm-Message-State: ANhLgQ3HZM/PpJawNXkRf/Ll47yxipPVDrR1D7UYXOxlKJEtwaDA0bTx
 ZginSqJ2Q9lIbg7LlMigOCYlJxBL3Oqmsg==
X-Google-Smtp-Source: ADFU+vuH1ViQxHy1KM9EC4Vx7sMyRjZkDw54kqgm+1KPd+kOIfxvra8tPrCcr94ccCMMyt/7qoMC2w==
X-Received: by 2002:adf:fa0f:: with SMTP id m15mr3739564wrr.392.1583493026138; 
 Fri, 06 Mar 2020 03:10:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm12553029wma.26.2020.03.06.03.10.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:10:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/33] docs/system: convert managed startup to rST.
Date: Fri,  6 Mar 2020 11:09:43 +0000
Message-Id: <20200306110959.29461-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
References: <20200306110959.29461-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix one typo in the process and format more option and
command names as literal text, but make no significant
changes to the content.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200228153619.9906-18-peter.maydell@linaro.org
Message-id: 20200226113034.6741-17-pbonzini@redhat.com
---
 docs/system/index.rst           |  2 +-
 docs/system/managed-startup.rst | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/managed-startup.rst

diff --git a/docs/system/index.rst b/docs/system/index.rst
index 5034f903407..d655344fffd 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -13,6 +13,6 @@ Contents:
 
 .. toctree::
    :maxdepth: 2
-
+   managed-startup
    security
    vfio-ap
diff --git a/docs/system/managed-startup.rst b/docs/system/managed-startup.rst
new file mode 100644
index 00000000000..9bcf98ea790
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
2.20.1


