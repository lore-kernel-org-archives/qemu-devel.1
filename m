Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D127C55ABD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DD520719
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rym4zP1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DD520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3nb-00075p-Pp
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc3kQ-0004Sm-F3
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:46:02 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kc3kO-00038b-TT
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:46:02 -0500
Received: by mail-wr1-x442.google.com with SMTP id c17so7928050wrc.11
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 01:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OUYrJMZKmRU5gfzMdZni/PewvUwFGv/yOXLZtLqq/rA=;
 b=Rym4zP1Gy212Y6DC8Ti9e67ZFiG8o9H/mun5p3eVP/l4unpQXp/SCMc0Y8PVbSUN98
 kAb8p6pKNT39Bdaw9Lok8Pk8clFS3Z5J6eHks8SHPVayOLB19Ew8ryEUY0GfP6Q6Pzov
 Ef8y87K0rjeWrtgyqSe1EcCDTpZ3F9fNmcXZBk4xV6+Naf7HzsJfdTa4kp+/0Tpqso2z
 Xjo3yVR8AA9FhhZaUtmfJhvq2yJ3rYPEHtjoAbOkDgK+j0IuzzbszzVOJ1TgcCQidyX0
 GXnXmusnOxIw/+DdU5w5yeYNDNsoz66Vr35hL6TJ74Rfztu3EgQpoX1/wPqWe9foe3BJ
 ocqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OUYrJMZKmRU5gfzMdZni/PewvUwFGv/yOXLZtLqq/rA=;
 b=JoTyPYznjO7hWTH3iHWTGY8FIoFOJQxhYevZflJ3RX4DHToxYpJyOUGqVP08zbYzUL
 cSwDVwQ1P7M6njZTNXUUly0+c7JyK4rII+nE+SW1oWCDpb1jRqrHIO70UcaeBPXGHY3f
 cPqmbxIKUA4jTAamMlLOFqP4+gYgdaD7IMp/p2WzTaQNVBbxXAsiVTafSH65A5u14MqC
 4E0FPnQ+pcKg9GXwFizmwDtvutE3EuBTJP452JupoUC9Bl3hpl4g7MVdOSoJHVnzMNc6
 YXzS2k8COK7sdn2WIJsrFq2WW8lknOmq1Eu2MzW7L9T3o48dMvWL+MmsVsryYMhFF3F3
 Sk7A==
X-Gm-Message-State: AOAM530ntKM0TGL6sNHwDPic/X/rmr8lxd98hBh9tNADEov5Da9joruh
 f150mqsdUuNkkE9R5T+xPyu/JgtdRmg=
X-Google-Smtp-Source: ABdhPJxt5z9bdv9Mv9Zt4CoeM7KloJcC+UEmkeSWlobZoei3yRhyzsB5igE5vQS+QtJ4sEWc1Ys7xg==
X-Received: by 2002:adf:8465:: with SMTP id 92mr16122883wrf.50.1604915159327; 
 Mon, 09 Nov 2020 01:45:59 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id a17sm12837504wra.61.2020.11.09.01.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 01:45:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] accel/stubs: Restrict system-mode emulation stubs
Date: Mon,  9 Nov 2020 10:45:46 +0100
Message-Id: <20201109094547.2456385-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109094547.2456385-1-f4bug@amsat.org>
References: <20201109094547.2456385-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This system-mode emulation stubs are not require
in user-mode binaries. Restrict them to system-mode
binaries.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 accel/stubs/meson.build | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 12dd1539afa..a83408bc0a7 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -1,4 +1,8 @@
-specific_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
-specific_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
-specific_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-specific_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
+accel_stubs_ss = ss.source_set()
+
+accel_stubs_ss.add(when: 'CONFIG_HAX', if_false: files('hax-stub.c'))
+accel_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
+accel_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
+accel_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
+
+specific_ss.add_all(when: ['CONFIG_SOFTMMU'], if_true: accel_stubs_ss)
-- 
2.26.2


