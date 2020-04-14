Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615DFC352BE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B122076B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9qKX8lZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B122076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33977 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOPT-0006yW-7O
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOH-00056X-7x
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOB-00079j-Kn
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOOOB-00079J-EN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id b11so3681776wrs.6
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6N7F/VqKmbYnLDIg9jtfPkCRYuB7XZyhZjr0Akis3f0=;
 b=h9qKX8lZo0wdP1+4dNosaxnySI5/WifsBOPoiUsv27MzgZQ7CWmm+GkaIn6IpepZ3a
 wba7SFeCMtWcFkBFaGLpBInFTTCp5FE0KlkcK2PCiTK4qR27+1hV40wU3LDxiovrSJYy
 aqkpI57yKpCPWOX+sfAiCkX0sa548gj23+duxEYggaZltcnZkITnmW0Wmm7IEA13Fari
 OcxbY7vj8+d5ohkXPU1F4wars6YfY7PT/jxAkl6BNQd4fRDfr1BuFGMIC7wMVGeEjLUC
 GU1q2FmJqzWwwzDfnFIXOrctoqGTbaMK1VSjLGImH597YulVd2A5fBRDDBHBya+HxvM+
 OlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6N7F/VqKmbYnLDIg9jtfPkCRYuB7XZyhZjr0Akis3f0=;
 b=bQWwEZzBy0W95FJGFYJyj6XDuKfIG/qPCiwu1L/B5d+mtmS8r9M8ESWwE5w+zx8shp
 rIB+DORoC2l/2v5d2lG1/udnvvpeyoJ+6DVMoUOVUlbLPTqXK2dVo1gBr0p5jfpR8MUN
 9OykAoJG54aZhlRHG8QRmVqrhsI3bKa579qSOeLJjLpkkE042gUg8Es/myrdnLrtYQad
 Q7jPKlW2I0LyTUToisJz1412+4+5hbmeaH4XGTw81dcg/gRYJhRcmGkpMt4J/s2srIOB
 5Vmhb4aqk1gYnYJWwDJUv0TeQQlZScmbABDqtrAF4nq+tIsz24Zl+qc7HwHrlDIXTeaF
 2XLg==
X-Gm-Message-State: AGi0PuargmSGuAwb+r/r72l7nJ+bW/H5pL3ki4Ec/Ur2GKJ2vlsPLHGd
 y0mdZJXTyvjEhCjKCwZciieZ50Pvrdg+YQ==
X-Google-Smtp-Source: APiQypJ7n670ydIoxkKZYWjfjjFIJclfhs7zQ1X6TYQskYyOvXBvgSfJJ6N/MXOJQdK3VMQyUynsFg==
X-Received: by 2002:a5d:48cc:: with SMTP id p12mr26037990wrs.170.1586881578020; 
 Tue, 14 Apr 2020 09:26:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i129sm20003802wmi.20.2020.04.14.09.26.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:26:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] thread.h: Fix Coverity version of qemu_cond_timedwait()
Date: Tue, 14 Apr 2020 17:26:03 +0100
Message-Id: <20200414162613.4479-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414162613.4479-1-peter.maydell@linaro.org>
References: <20200414162613.4479-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

For Coverity's benefit, we provide simpler versions of functions like
qemu_mutex_lock(), qemu_cond_wait() and qemu_cond_timedwait().  When
we added qemu_cond_timedwait() in commit 3dcc9c6ec4ea, a cut and
paste error meant that the Coverity version of qemu_cond_timedwait()
was using the wrong _impl function, which makes the Coverity parser
complain:

"/qemu/include/qemu/thread.h", line 159: warning #140: too many arguments in
          function call
      return qemu_cond_timedwait(cond, mutex, ms);
             ^

"/qemu/include/qemu/thread.h", line 159: warning #120: return value type does
          not match the function type
      return qemu_cond_timedwait(cond, mutex, ms);
             ^

"/qemu/include/qemu/thread.h", line 156: warning #1563: function
          "qemu_cond_timedwait" not emitted, consider modeling it or review
          parse diagnostics to improve fidelity
  static inline bool (qemu_cond_timedwait)(QemuCond *cond, QemuMutex *mutex,
                      ^

These aren't fatal, but reduce the scope of the analysis. Fix the error.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200319193323.2038-3-peter.maydell@linaro.org
---
 include/qemu/thread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 047db0307e7..10262c63f58 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -67,7 +67,7 @@ extern QemuCondTimedWaitFunc qemu_cond_timedwait_func;
 #define qemu_cond_wait(c, m)                                            \
             qemu_cond_wait_impl(c, m, __FILE__, __LINE__);
 #define qemu_cond_timedwait(c, m, ms)                                   \
-            qemu_cond_wait_impl(c, m, ms, __FILE__, __LINE__);
+            qemu_cond_timedwait_impl(c, m, ms, __FILE__, __LINE__);
 #else
 #define qemu_mutex_lock(m) ({                                           \
             QemuMutexLockFunc _f = atomic_read(&qemu_mutex_lock_func);  \
-- 
2.20.1


