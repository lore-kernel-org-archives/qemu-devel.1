Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C628BC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8398720675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9sy3aEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8398720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52957 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSPH-0003fc-Hw
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:27:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHu-0005UU-OW
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSHt-0007Qx-GV
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:06 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSHt-0007Pg-9v
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:05 -0400
Received: by mail-pg1-x542.google.com with SMTP id t22so5716038pgi.10
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+/qY9GymWVw9Tgqaah5CkydYCEaLw/iJ0Pj5fe5qwlo=;
	b=a9sy3aEgGCerhkMJt5FtPjNy7lDtVevoCaD8WJaq57V0+wqBFkdo/A6n2/hHia9M+V
	xH7kf4rUMrVMQ0zDF232WAkao9E6eTgZ4IyVnZ0b+eBeIfIGmH5Ey5Xri5hkNWMSz/7O
	/iuC+UY6g5CexOSaNru9vKFlj8NGNX3/dAvfwoEhnZyQQ5Td2UrSAV7RubpyvFDmsdBi
	TKiKA0Ir6izpIDP/kPkpVROGWHKXRPjbl+F91Y2aGgI63mWuFrhAMCxQ4rJPljHHL4sz
	Ih9TpocUJCLF2bAm5mTdl/zw4lNj5s7HzAFsd1LXbuEgiuhikDhsxrNVWxKq+C9v+jtB
	kk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+/qY9GymWVw9Tgqaah5CkydYCEaLw/iJ0Pj5fe5qwlo=;
	b=OcAecolrGKRCKrggDSlUUiulZ0Dhl9mjJ28WAPmbkpKR/UjO8COLdiJMIQNo4F/OuR
	CE322NVQ4jTYvBDXzHwFdJ1tLX7ti+SxzoLxOdmsTh8i60H3Cxi5YEKgDbpu4MdTQ2fd
	WJVlAqMOGDovc1pDRo4zXYcJn1tz1WjujWm+j6R+Gx3pA/NElEGccg5ym0eTWNB8ag5l
	z0vMpLuOYNriHdhXk2hjtl4CXMRCaIMLVH2oX0U36P8Tz2X6IRnUYD7MGNT8R/1xhGWm
	iD1Ve3P3tDxrmyTKROTk6Bn9OID2ZRnVqxzsgg+qQLujrD8TpBLfzDzR8bh3KqjzvxCc
	tN2A==
X-Gm-Message-State: APjAAAXuf9SZGXFnTIU76iXPr017Vb3pCsym9Gs3xEX17wjDXDc1Z4eW
	o1NVITNsFRQ6Z70+Oq900BVlhTSK1Ew=
X-Google-Smtp-Source: APXvYqzC7MhZ/rMiTFjTKKxwHghN7ynVKKx0Dl5w2dCPtrPxKkrEl1KGcOPs4OiaWkrEkA2uxR3kjA==
X-Received: by 2002:a63:d652:: with SMTP id d18mr55026317pgj.112.1558297204034;
	Sun, 19 May 2019 13:20:04 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	e14sm18166264pff.60.2019.05.19.13.20.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:20:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:19:46 -0700
Message-Id: <20190519201953.20161-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519201953.20161-1-richard.henderson@linaro.org>
References: <20190519201953.20161-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH 06/13] linux-user/sparc: Use WREG constants in
 sparc/target_cpu.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes a naming bug wherein we used "UREG_FP" to access the
stack pointer.  OTOH, the "UREG_FP" constant was also defined
incorrectly such that it *did* reference the stack pointer.

Note that the kernel legitimately uses the name "FP", because it
utilizes the rolled stack window in processing the system call.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_cpu.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 52c9d8c7db..2c80db4889 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -45,15 +45,9 @@ static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
     env->gregs[7] = newtls;
 }
 
-#ifndef UREG_I6
-#define UREG_I6        6
-#endif
-#ifndef UREG_FP
-#define UREG_FP        UREG_I6
-#endif
-
 static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
 {
-    return state->regwptr[UREG_FP];
+    return state->regwptr[WREG_SP];
 }
+
 #endif
-- 
2.17.1


