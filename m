Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E997CC2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F56206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaEHl6Ds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F56206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igten-0003iV-DD
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFM-0005PX-R9
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFL-00083d-Ox
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:24 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFL-00081g-Ih
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:23 -0500
Received: by mail-wr1-x42f.google.com with SMTP id c14so8051676wrn.7
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SnbM4HZb29FsG4J6fiW5WwWfE0ShjwYvCK5bmD3CYRU=;
 b=DaEHl6Dsqm8hqfm/jR7fBK2BgKP4aL4GewQe8VRKGq9TnVDAijwRqRS+U3cErGC5AV
 H2Tj8sSg4aLxQibYzclCtybH6sI3zYF1wZicKkIA0X1SlsgUcIKwg3k4CtG52Mie+nHu
 NMjuNS5lsZ5q6vROnGXcuNJY3FQ9FYSby/LIVEH2KzX6r22BfxA71aFdqtd/WkUbv4pa
 /LNs+VqYtMH6wzsC4FCj7Ax8XaFPTpZCqJ7dZ72v/6DulSSilCUDkTO/33ri83cfPrMF
 eNqK5CnkeqHFMUfznnP90BmZW+5I6CqTo3JuwW19CiYNXL/qKo/Clgtoi4PufFWGIV2Z
 r+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SnbM4HZb29FsG4J6fiW5WwWfE0ShjwYvCK5bmD3CYRU=;
 b=rR9c3pmLQr9+8ie4EMybFmweIgyE+0GoQxhXEgX1t8R1HbqSY7tbxZiXuhcxKhQmN7
 6gW6OwbW2wI2C9/QY/WKFk52IVSejitIXmSkF1PePMYWCFMmBRB8NzY/DPNeA17r2V1e
 c5sE2ISiJPHBwjRQSp7EquWZ+pcfgBxUeLs8S0i5op62UC6i7dwjagtO69ExzPTJ3frn
 lmwuvKJeOUUxgb9oYMuq+9dZOeMQN2VHGbQuxYRkATYa+gkMw6SDq6A1Tf5Oxf6F2356
 ur1G90s/40anwrTOwBpunsC7Whf/x4bPkp/B5VzKP1kdvq7KpR7ip3xGF0rbJ67CKXx6
 ZSMw==
X-Gm-Message-State: APjAAAXvft40KR1/qqgfJoH6PwHr0SxJ+gYgRzk9u8L8y73ORER0m+H+
 PNhe+o/N80ua+UpQGIzbHiOnY1DY
X-Google-Smtp-Source: APXvYqzZL9J/EAk7mMIH+jiTbjn8r/Z25M/xhwObmbxfiCjduNR6n+peidQdfEVUqlEgHUCNmy5S3A==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr30044589wrw.373.1576513762427; 
 Mon, 16 Dec 2019 08:29:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/62] monitor: fix maybe-uninitialized
Date: Mon, 16 Dec 2019 17:28:19 +0100
Message-Id: <1576513726-53700-36-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../monitor/misc.c: In function ‘mon_get_cpu_sync’:
/home/elmarco/src/qq/include/sysemu/hw_accel.h:22:9: error: ‘cpu’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
   22 |         kvm_cpu_synchronize_state(cpu);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../monitor/misc.c:397:15: note: ‘cpu’ was declared here
  397 |     CPUState *cpu;
      |               ^~~

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/misc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/misc.c b/monitor/misc.c
index 3baa15f..a74cff3 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -394,7 +394,7 @@ int monitor_set_cpu(int cpu_index)
 /* Callers must hold BQL. */
 static CPUState *mon_get_cpu_sync(bool synchronize)
 {
-    CPUState *cpu;
+    CPUState *cpu = NULL;
 
     if (cur_mon->mon_cpu_path) {
         cpu = (CPUState *) object_resolve_path_type(cur_mon->mon_cpu_path,
@@ -411,6 +411,7 @@ static CPUState *mon_get_cpu_sync(bool synchronize)
         monitor_set_cpu(first_cpu->cpu_index);
         cpu = first_cpu;
     }
+    assert(cpu != NULL);
     if (synchronize) {
         cpu_synchronize_state(cpu);
     }
-- 
1.8.3.1



