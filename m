Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7AAC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B24208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B24208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWvR-0000SX-5l
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33015)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHW-0003A6-P4
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHU-00004y-I2
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:50 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:44341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWHT-0006yB-Ij
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:25:47 -0400
Received: by mail-pf1-f182.google.com with SMTP id t16so1392669pfe.11
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=tqiS7O8nKvNing+E8WwiszCtPiLlK33kP79Ar4czLaU=;
 b=oUYwonsvbtOehNAPCc68VsyeA2dwF6jwT+lb6sMmuWMp3RsYD9XbrgsgudmFazrTOM
 ob7/TukO2BryuC7WYb11tDtN6Glc1a3l8fOllp+bz1Vvc4bVSQ+9XIeFt5FWLpNWlRwR
 SuvIoKtU28XeVi/a2O/nEyUC35CNyALTC/24SBxolmw/kqiJ5jgaeQea756lx7Xz2xuv
 +sK2MNIgA/4anvCFPxKWIrnur0LjT7myXu156JzqCj8KpvpPtau5YwTu82l34OTISd6l
 TnxO6Z4qRE2WwKfFDaWOVAirb6FTxwEotioOY3VO5/ErEmPUZevHSpWWKpQFe7Y3v/ox
 ZuCg==
X-Gm-Message-State: APjAAAXplIesir/UCCuKjuzmQlN2qdURR3f4KBZIQr9AFZHQbR09t872
 F/bKjpQ4DhbiP2uj/Rl/WgALygmsLACGsg==
X-Google-Smtp-Source: APXvYqz4HgwfLHomu9GYtfbmHFaxeAkcApncvVLSSz0rgVyDrt/RXlulYvCVWYc0EhsHxAUulnhFYA==
X-Received: by 2002:a63:1462:: with SMTP id 34mr4283972pgu.417.1561649044358; 
 Thu, 27 Jun 2019 08:24:04 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id d123sm3437041pfc.144.2019.06.27.08.24.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:24:03 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:19:54 -0700
Message-Id: <20190627152011.18686-18-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.182
Subject: [Qemu-devel] [PULL 17/34] qemu-deprecated.texi: Deprecate the
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


