Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACE7C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3675218A3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3675218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hib5Q-0006Wc-NP
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51497)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapn-0006CZ-F0
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapk-0007Ky-3o
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:47 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:36617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiaph-0007Df-Tv
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:42 -0400
Received: by mail-lj1-f178.google.com with SMTP id i21so1492539ljj.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=tqiS7O8nKvNing+E8WwiszCtPiLlK33kP79Ar4czLaU=;
 b=XMLfHGCYw5UAQ5yX2onh+kJ+QOcniH01mWV4GoEtkS5IEl7/WABfJraTvJU9F0DOld
 1yGQAxS/NyO+o9pSftVHkz5jEbp06Bl9ezUqmuRFeKLkDIVjk9elTTrIfngG/OUuak30
 w/w/pEMA+eFshaTK852NiKFCSM00aChO0UrgfOwjQrdK47gDcDvWg/jt949D9F5MB5Cc
 bFw082bdhTavXMqQNaHKFB5pxW1c7wVY7VCKV1mk9ZmFBfBCex2FqUn2JncudNitzAZr
 g3ki5SW9ZKvqFg3lFOuFKLQD8Btn3Cd5JXnLI10q7l9NwMcRIP4+NA6kI6yVawijgLqh
 8X/Q==
X-Gm-Message-State: APjAAAUr76aBZjWcxJH1iHjK8EwS4PrsrI0dNgb7GfN7upKfESsj3vBu
 8O+djZJPdGoLevcLCbE/PQZpUQeUwARkNw==
X-Google-Smtp-Source: APXvYqzMQ1VFo+cbMrLyUbBoftTk+g7bRkLXh+Slkuy2FOPprNvGFydsxwJzyhKRzbmkGFl0vSfCbw==
X-Received: by 2002:a2e:900c:: with SMTP id h12mr19569565ljg.197.1562143299976; 
 Wed, 03 Jul 2019 01:41:39 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id o74sm291723lff.46.2019.07.03.01.41.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:39 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:33 -0700
Message-Id: <20190703084048.6980-18-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.178
Subject: [Qemu-devel] [PULL 17/32] qemu-deprecated.texi: Deprecate the
 RISC-V privledge spec 1.09.1
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Deprecate the RISC-V privledge spec version 1.09.1 in favour of the new
1.10.0 and the ratified 1.11.0.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 qemu-deprecated.texi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index df04f2840bd9..97ea4ef3001a 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -144,6 +144,14 @@ The ``acl_show'', ``acl_reset'', ``acl_policy'', ``acl_add'', and
 ``acl_remove'' commands are deprecated with no replacement. Authorization
 for VNC should be performed using the pluggable QAuthZ objects.
 
+@section Guest Emulator ISAs
+
+@subsection RISC-V ISA privledge specification version 1.09.1 (since 4.1)
+
+The RISC-V ISA privledge specification version 1.09.1 has been deprecated.
+QEMU supports both the newer version 1.10.0 and the ratified version 1.11.0, these
+should be used instead of the 1.09.1 version.
+
 @section System emulator CPUS
 
 @subsection RISC-V ISA CPUs (since 4.1)
-- 
2.21.0


