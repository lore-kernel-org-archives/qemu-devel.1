Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B528C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043BF2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVSdebq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043BF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFi3w-0002hc-4B
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrE-0005Gw-LT
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrD-0003GI-JK
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:08 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrD-0003FS-D0
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:07 -0400
Received: by mail-wm1-x342.google.com with SMTP id 5so7993482wmg.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ouS0dB8g9W/9/ob84vsKA1eSX6rKfJNGsZsisdoDFcw=;
 b=YVSdebq9N+VVNwzMRuujIk64rU+jbNcFM+zQO9E94CTzXFjGJw2ni4cb6BKk5WFJxB
 hV1h3UJOg0n/0Deix9IKGq2eKPlRF2RCYu23qC4nYuYY9GizZeCUQyMohqkhI2W4JjJJ
 EZcXoKOA0KFPRbFH7D84LBUYgxuhrpIPdI2gb6LmPLAdD9lxxsjrrI/xfF1E/1wBlRXT
 1cVggENFn0XcoNh7qhWkOdZCoB1/iuxhTCUIC7VjiPh0wXIG7qWjdG/YzLWAAG3Xfh9u
 mxAfX2mtQjrS4EcsTBiIKdVTDtaybXBTQvNN7CwDLv8PevW0WOgkk4Sgrdq8gK4bVmKb
 DuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ouS0dB8g9W/9/ob84vsKA1eSX6rKfJNGsZsisdoDFcw=;
 b=ckgHTl1sMH6gBHW/0ClqxIECkOvj0U1o6Vb4iRALBvyLT7ehzGCtxu1ALHvTfNI1tn
 922JJN250ck9Lyh/X0N/9USB6hM7vwe7DLdzWhXGO1BX3KJsG6mIvwIrWd6S3KgJfeLP
 fT3VLEkzHp2oC6flJpNIuBaznC/I9p1vSh6vDBeMLFLuBxp7H5dJlP5S60oeqjen2mma
 xOt4MlCOAxAguGbUTbQICEIlSzB+nYbFr/iOXQI79Iecmn/Mt7li2HUAdAEeJXVoaXoL
 VdhnBNR6UzxefNRqqU5eganUmzdy6fpJb8CGH1NK6l/Rb6UL2rU13Y/XCDDlp+DXUJlm
 WRnQ==
X-Gm-Message-State: APjAAAVE4Aborg+7AQdfiux51PhFh10QsFJCP/jyfljbSL9hx4PEeP2k
 PHLYpYqwjfko6Nj7IexQwi++LV1G
X-Google-Smtp-Source: APXvYqxP0f5RPNxZaxPFgXrXHZCUj6EEUEHThXWyQWYA0eZAYxwmJq4FLR8OybW6GZgyp8yG/5oiOA==
X-Received: by 2002:a1c:1b14:: with SMTP id b20mr3407087wmb.122.1570035126229; 
 Wed, 02 Oct 2019 09:52:06 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/30] replay: don't synchronize memory operations in replay
 mode
Date: Wed,  2 Oct 2019 18:51:34 +0200
Message-Id: <1570035113-56848-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>

Commit 9458a9a1df1a4c719e24512394d548c1fc7abd22 added synchronization
of vCPU and migration operations through calling run_on_cpu operation.
However, in replay mode this synchronization is unneeded, because
I/O and vCPU threads are already synchronized.
This patch disables such synchronization for record/replay mode.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
---
 exec.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index 8a0a661..1d6e4d8 100644
--- a/exec.c
+++ b/exec.c
@@ -2959,8 +2959,17 @@ static void tcg_log_global_after_sync(MemoryListener *listener)
      * by pushing the migration thread's memory read after the vCPU thread has
      * written the memory.
      */
-    cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
-    run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
+    if (replay_mode == REPLAY_MODE_NONE) {
+        /*
+         * VGA can make calls to this function while updating the screen.
+         * In record/replay mode this causes a deadlock, because
+         * run_on_cpu waits for rr mutex. Therefore no races are possible
+         * in this case and no need for making run_on_cpu when
+         * record/replay is not enabled.
+         */
+        cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
+        run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
+    }
 }
 
 static void tcg_commit(MemoryListener *listener)
-- 
1.8.3.1



