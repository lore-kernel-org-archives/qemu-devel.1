Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219E0C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAB32072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRHtec+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAB32072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXvP-0000Ba-1U
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5L-0004Ba-Vj
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5K-0005PS-TU
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:39 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:39836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX5K-0005P0-Q6; Mon, 06 Jan 2020 13:26:38 -0500
Received: by mail-qt1-x841.google.com with SMTP id e5so43200983qtm.6;
 Mon, 06 Jan 2020 10:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q32rULKz3P9b6ke9olYLbvQa+p3xcZiLFsA6TSHCyN8=;
 b=YRHtec+6gQkyO8Q1QEPd+ZjMIctJswB2JVqUKy8ZpBSNA2A80anJziRw2RNP6+WROM
 QoROU0jmDp6ku7XfIg4pD24HFj9sLo6VSl0VrbSeD/Ap+frv60bejoO+C+Yu98UA2a+A
 8F8h6zufzf2ph6hPTGZ4EH4Cp3YLfAAiG7TmcC5d94390LAJGdE9cNNSbWrcYZfLATn8
 GzYExcQiXRUYClOHv3++nN0olVDFFY5nLy9B10rAneTb7n6Ytk7VRh1h8fJuT53epP0h
 /VNWudnyyBB16c/NxH3CO9RPOS3FosOtYxYOgNgn+p1J3W660+XHG8tTArQTZkbL2EB+
 r38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q32rULKz3P9b6ke9olYLbvQa+p3xcZiLFsA6TSHCyN8=;
 b=ukzEkCPUychoIhgZ+ngzJU14ut4+LJdur7dq10g8gUvIAat1gN+sSSnIDB4/uGTeFs
 z+49UShWXY4UAlhat4S6fSz74/8INrpT2aPlefp2R/GE+uUbMFtxZqO4bjs4Pxi7K/b6
 LQrQb7ELPAnpc9m2gNA8b8jUIsdPlN3f0f6fz8q+7hTMo3JolqrJHeCSryfxcY7SZ1Op
 hlqh8O+Urm1QfwoZ7E116YoOEdP0ePWKdIShYj++qXkS3bfdE3wDl2eDP0XbLFF38Ywj
 YH5QKeNxd1zvWtdARrQPZQczoiLiQUl2sT6m4seq46k2vxzPYWPRoZzt4sNJFYVU9UB2
 3jHA==
X-Gm-Message-State: APjAAAX5IfIlfTzzAFr6gI+ArmRplGlnBeDTF/RsgU06DxtJkDpq833M
 +M/faBGe2KgAEwYDrplDJVaGe/aP
X-Google-Smtp-Source: APXvYqxKlqxxWT1ZxGM41mk+ro9IEI89tdH9hwlP2posSHuazzXVALsjzFSUx8ZfFjAvmwaqbLc5Aw==
X-Received: by 2002:ac8:534b:: with SMTP id d11mr76351116qto.170.1578335198304; 
 Mon, 06 Jan 2020 10:26:38 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:38 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 59/59] linux-user/vm86.c: remove unneeded label in do_vm86()
Date: Mon,  6 Jan 2020 15:24:25 -0300
Message-Id: <20200106182425.20312-60-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' can be replaced by 'return' calls with the adequate
return value.

CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 linux-user/vm86.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/linux-user/vm86.c b/linux-user/vm86.c
index 2fa7a89edc..eceddd05df 100644
--- a/linux-user/vm86.c
+++ b/linux-user/vm86.c
@@ -403,16 +403,14 @@ int do_vm86(CPUX86State *env, long subfunction, abi_ulong vm86_addr)
     case TARGET_VM86_GET_IRQ_BITS:
     case TARGET_VM86_GET_AND_RESET_IRQ:
         gemu_log("qemu: unsupported vm86 subfunction (%ld)\n", subfunction);
-        ret = -TARGET_EINVAL;
-        goto out;
+        return -TARGET_EINVAL;
     case TARGET_VM86_PLUS_INSTALL_CHECK:
         /* NOTE: on old vm86 stuff this will return the error
            from verify_area(), because the subfunction is
            interpreted as (invalid) address to vm86_struct.
            So the installation check works.
             */
-        ret = 0;
-        goto out;
+        return 0;
     }
 
     /* save current CPU regs */
@@ -485,6 +483,5 @@ int do_vm86(CPUX86State *env, long subfunction, abi_ulong vm86_addr)
     LOG_VM86("do_vm86: cs:ip=%04x:%04x\n",
              env->segs[R_CS].selector, env->eip);
     /* now the virtual CPU is ready for vm86 execution ! */
- out:
     return ret;
 }
-- 
2.24.1


