Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C72C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A209B2084A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeYOPHxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A209B2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he8ly-00062G-NW
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 21:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41115)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a3-0006bI-W4
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a2-0006b1-7B
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8Zz-0006Pc-Sm
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 207so4810400wma.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a3VGuwnoGM9LiZBZHhLPfux9Kyat183XzMS8uuGHjKk=;
 b=AeYOPHxi8fq9FXqQUBTvliOB04XlMVLB/x+r/TsI1u6gUoNUYC4Gw5hnXgXVrnhsuZ
 W2Sx4PMlN+RtDWyKh5G9SUyX/np6w2UjO3FWgulU5PSQSKjCuWyNYnwsUMLgyxlJpVB3
 Xrj4L18uTqECbIzpQEl9feekjpo91S8BzfF+gBGI0SSuMXwFjsbE6Es+2Vjjvmea5ANL
 gKYMy/q59ueQiiFZ0F1IZOR3GSzeyeVvTdpa8RRtlrAZzhZd+2XfMqmdm28PdiliUGIb
 u1u1YwN5nIWy9M776y/007M+gXbYAfK3KA6grVYggYkzaS5wq7SRVqGB4+NquFw2Am22
 xO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=a3VGuwnoGM9LiZBZHhLPfux9Kyat183XzMS8uuGHjKk=;
 b=Ad3C7W4V93RKBOdGrVmWznngf0oOHnkT5ZN6dNVkRo+7V9V+RrItJWM8t3vG1qYYlt
 nCPhFtcxogIl64cw0uu8qy7hr9+UGsBVJeiN+D+Tq59jDGl2JUmQ1fOweCCAEeYXUE9o
 I/PSC6G/xRduh0Uv0mOkI6GVyrpxH6WYoTPFQ3rw4YFD1FUhyryb0tW3s7vvN1P2+0sS
 OalaWce0BcmQsp5QKQbpW7FKpXcO2SBVa+SBCn9/MbUTeLby9R8UZZjwTknGGD5N5bZA
 jwUezfVxjCjfDre6IDNftIVHXj/AFQiRAsbHxcDBVuGpM12OcDC1tu9cYpU8eiRMBUob
 mDCw==
X-Gm-Message-State: APjAAAUm/4jnnz1O0tvyD7lDq1fiEyHdd0rxo9EDWrScxwH7ckRuI2bE
 vD96UQjCqfxBSenOd5+A9NIZ3C/d
X-Google-Smtp-Source: APXvYqxNeBYzhhmIQ+GM6rRBgXcBm7+EfdxziZXDakqoQshueOoT7i+FdGi8kWJ0OIPSFX9EIL6Qhw==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr1401715wmq.74.1561081376683; 
 Thu, 20 Jun 2019 18:42:56 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:29 +0200
Message-Id: <1561081350-3723-25-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PULL 24/25] util/main-loop: Fix incorrect assertion
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
Cc: Lidong Chen <lidong.chen@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lidong Chen <lidong.chen@oracle.com>

The check for poll_fds in g_assert() was incorrect. The correct assertion
should check "n_poll_fds + w->num <= ARRAY_SIZE(poll_fds)" because the
subsequent for-loop is doing access to poll_fds[n_poll_fds + i] where i
is in [0, w->num).  This could happen with a very high number of file
descriptors and/or wait objects.

Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <ded30967982811617ce7f0222d11228130c198b7.1560806687.git.lidong.chen@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/main-loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/main-loop.c b/util/main-loop.c
index e1e349c..a9f4e8d 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -422,7 +422,7 @@ static int os_host_main_loop_wait(int64_t timeout)
     g_main_context_prepare(context, &max_priority);
     n_poll_fds = g_main_context_query(context, max_priority, &poll_timeout,
                                       poll_fds, ARRAY_SIZE(poll_fds));
-    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));
+    g_assert(n_poll_fds + w->num <= ARRAY_SIZE(poll_fds));
 
     for (i = 0; i < w->num; i++) {
         poll_fds[n_poll_fds + i].fd = (DWORD_PTR)w->events[i];
-- 
1.8.3.1



