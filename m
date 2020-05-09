Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A51EC28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BE5214D8
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSXhQonq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BE5214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXPFd-0006vX-Eo
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 09:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEK-0003kq-U3; Sat, 09 May 2020 09:09:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEK-0002sO-4g; Sat, 09 May 2020 09:09:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id h9so5152172wrt.0;
 Sat, 09 May 2020 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FsKgzNtj0JOKlhy4WvhLDnKHvG30g1UF9KO56LbtNlA=;
 b=QSXhQonqNvr9y6aJqookdYR2z9b+6/7vg30IC+CtmajxekI8w5NmMlHOd8VP9kSOXr
 3Qt3QFOzv4yBJ4DGsuoRdGjckHFFKV2+oYWuRHO4ZL1BvRcXWzkNNaJcwIOnxzpee3ty
 yIaPH41DahTx2g9qjWcaj2Jjwy+dsB3j8dfh3h7p3Wfmpl/a963139QKsbxPurlFs4+O
 CYC58AlfyyOs/noYt3dYHtc2uWKEuyQ7R2FMftMs/KgfrwtoCNVJ07ZoHD1/8CkUMGE4
 c+v6IOUFGGHAQVVSLlNlLI8Atgc/Am63e3IoSXUkWgYWi507/sXOv+M+JJK/Fz8751RN
 DkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=FsKgzNtj0JOKlhy4WvhLDnKHvG30g1UF9KO56LbtNlA=;
 b=XMsItHBim3QC6N5ec7bWTwUXrmVpNtu75cT7Tq9UJmGvLju0Z9t0j1piHMZic74xHo
 X3ZXAH4hckyPVlMJZmIE81J7Q1vM+KiOYH3TQtgd1qvU6oLW7yFYCr7cT5G9pNhTAKWS
 keM/uiYddrZpCMd0DbrVknxlS6fd56K0ukNhbs7v5oaCPQn1TaUHJTvlKMO0UGzSZvIz
 b0I5vSxPjMPEMjqYqGojkcQE0tJYGQmaw70V3KBcsl3hSgNwakO4g5y9eFir/gURJNtl
 OwbamPPU9rteah1PaP5UuYHm4e1wvSKoGoxm3UNCoSqL9Yt0Zt+bRtaqxCVsyrksxrqX
 gGdg==
X-Gm-Message-State: AGi0PuYe1V4pdRjthSnd7iWXxPU+AOMeBx7dtLAkYQrUzwNp2F4NFzY4
 Faso1GBIwtNyMstOzjIb9X3dd2n+8z8=
X-Google-Smtp-Source: APiQypJsKW0QaSa4nLUBm/QYXRV1pBW3RL2/LwqZFzcRqs467g/ETRp/URxzLlFFHMMH6bHXqUtvBQ==
X-Received: by 2002:a5d:6712:: with SMTP id o18mr9021292wru.115.1589029761168; 
 Sat, 09 May 2020 06:09:21 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m65sm1411410wmm.17.2020.05.09.06.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2020 06:09:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/11] sysemu/accel: Restrict machine methods to system-mode
Date: Sat,  9 May 2020 15:09:01 +0200
Message-Id: <20200509130910.26335-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200509130910.26335-1-f4bug@amsat.org>
References: <20200509130910.26335-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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

Restrict init_machine(), setup_post() and has_memory()
to system-mode.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/sysemu/accel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 47e5788530..e08b8ab8fa 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -37,10 +37,12 @@ typedef struct AccelClass {
     /*< public >*/
 
     const char *name;
+#ifndef CONFIG_USER_ONLY
     int (*init_machine)(MachineState *ms);
     void (*setup_post)(MachineState *ms, AccelState *accel);
     bool (*has_memory)(MachineState *ms, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
+#endif
     bool *allowed;
     /*
      * Array of global properties that would be applied when specific
-- 
2.21.3


