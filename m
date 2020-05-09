Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5C8C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2770621775
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMA+dOHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2770621775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXPMB-0002hC-Bs
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 09:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEk-00052e-SO; Sat, 09 May 2020 09:09:50 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEk-0007KQ-2k; Sat, 09 May 2020 09:09:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id d207so184525wmd.0;
 Sat, 09 May 2020 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FhXzEDZMFN7nI/HcObjzYIjU52XHskJ+5ArXsA4s8n0=;
 b=tMA+dOHPorUcef3Ii8plnVwx5/I0le3h8ZG+eca+U8AHmyZPa1SS3f3WuI15TwaqMj
 dp9D1WaZwrnsb5FDXqtTKtmj9ql7Ri9+E8lUya6BaANZi94a9jnQGJI6G4UF9TPdagy3
 OgmgfqIWppS9Pv6g6oO0G49S6T5H9O2kFz53VTuxNlRRSqGgB2PYtlmYAhUAAIgl/CYG
 HU4xvfI3vTtrbHl3Tih+sk24b+RCb6pHPSaM+TNWHXOX0xGVdE/7Gx1IYmx3SoM0UFHV
 VJQOMdVbuLbFyNLdR4Iii9ly1xsgPL8IN+1T7566Y3evQ9HqdPdME6aN9M/UwH5+GcKH
 jFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FhXzEDZMFN7nI/HcObjzYIjU52XHskJ+5ArXsA4s8n0=;
 b=O8iCxlCsqFws6bOvjOGDWHIrBjkPezLF/ik5kl+ewBKajosPnOhoZl2VZio1cK3YHL
 SYdR+xH5DEbXRjRlw+M714JqNuq1U9oNnfb9DGeKJiFPPy0A1yJxN8W7s9LTbE47NlPm
 zVmnNrLvifzh56Ao08sCsHo1pb61caUbaGWJjBCAT3jphIks3lMWZqRDlQQr9bKkYJBB
 9ns5v0OEQQ+fDAp9CMG6a4eOfNWxkWG+RhfzxPu25tNQN8sNz4lr31fvgRdlJl3mixhT
 RncLJM+N45goXFyL6WS+X5fDqHPRPOtTDn2fcbyX5+iOpO5glCi+2Gkhg7G5QHn6EG0v
 Fvwg==
X-Gm-Message-State: AGi0PubTgWopvLKhMmaA023Mfz/tcC7EXemDXMOS85J48Ssm24UGA7l7
 i4xnqGNXOtk7vVJLTLb05OVQoYL3n0Y=
X-Google-Smtp-Source: APiQypIPiOQOoy1QDhlipK4I1Af7DTsG6G0dwlgqBHdFcvssaN5XNM/0LHVECJmyi5GMwxGZeM77rg==
X-Received: by 2002:a7b:c118:: with SMTP id w24mr20571336wmi.173.1589029787021; 
 Sat, 09 May 2020 06:09:47 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m65sm1411410wmm.17.2020.05.09.06.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2020 06:09:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] exec/cpu-common: Poison hwaddr type in user-mode
 emulation
Date: Sat,  9 May 2020 15:09:10 +0200
Message-Id: <20200509130910.26335-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200509130910.26335-1-f4bug@amsat.org>
References: <20200509130910.26335-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'hwaddr' type is restricted to system-mode.
Declare it poisoned on user-mode emulation.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Checkpatch complains:

 WARNING: architecture specific defines should be avoided
 #10: FILE: include/exec/cpu-common.h:7:
 +#ifdef __GNUC__
---
 include/exec/cpu-common.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b47e5630e7..56cfce8153 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -3,9 +3,13 @@
 
 /* CPU interfaces that are target independent.  */
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_USER_ONLY
+#ifdef __GNUC__
+#pragma GCC poison hwaddr
+#endif /* __GNUC__ */
+#else
 #include "exec/hwaddr.h"
-#endif
+#endif /* CONFIG_USER_ONLY */
 
 /* The CPU list lock nests outside page_(un)lock or mmap_(un)lock */
 void qemu_init_cpu_list(void);
-- 
2.21.3


