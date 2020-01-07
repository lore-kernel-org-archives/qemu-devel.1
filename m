Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8013DC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9742146E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxJw+SuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9742146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqGz-0002W8-D0
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iopIJ-0008W7-Mf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iopII-0002Fb-Jr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:15 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iopII-0002F1-D7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:14 -0500
Received: by mail-wm1-x344.google.com with SMTP id u2so19475548wmc.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lR6zZgUbeB9M7mMQSx/isyy16o8djCqNWEtK8LZ6lNQ=;
 b=kxJw+SuKbtoibzGzNCfs2MEzoG452iIpwVC71N/xfTpBZpPQ+a3bkRkVSXuKwXx544
 JlhPrIF2JzZPFVyDfBkM+N8A1SDIlgUmH9TpYCvK/DpicM5Wnp/4yAc6w05DVXesyIqb
 qTDfWsiOKf8kq0bG5iBjVmnbbY9Vi72oZxy30qaQtOAo21wd+zLgIOwAg3CjTyef7vBv
 cMCXJ2i0eMPiBm72kRMJguT8w32Ia0OaClGuHEM2J40q4DEoD65z52VzHX7BEHl1DoMh
 T7nwQYk+njnsTiO5Y3nrDJdQE6CajrhbA38yGO53RSbrcfrZNUOjkWZUAlNbXBS9loMR
 C6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lR6zZgUbeB9M7mMQSx/isyy16o8djCqNWEtK8LZ6lNQ=;
 b=bTBbIaSc5BFMm59ERYyzNgp6WRqWuVoFIb6VeWjFuQvdYZMFJYZTTAw1NIX5r3oyMX
 UDkALXvR6Ntw1RCyIHxN9EypR0Ueo34w1L7On7znuFmMq/98KEqZSGZWNFpSzoMwUN8u
 boZ5ds1X6y4GoPs34Rw7XH+fiepAQMfkE8Vku3HzYRFUTYwpeod5gDoF9najLpU5RFe/
 uoy4yPFP3nrhMFoD+8uoYTynEks7oxu5tFDOtpnSt8Y7C8dJaEHqdXxA0/XBDUyJZ1wB
 4suGe5vUJx9mSNXUCpVM9hM9STZxaKEhh/Juy52j4Eq7Er5aw5JHogkw+KJKvMGQWm+T
 QEVA==
X-Gm-Message-State: APjAAAVo19P1ObUFLsbkOdShL4mbP1qorutPP9x+PEJQHgge5GDHY3xI
 XEBifDsp5YdIVf6D2USC4oFifw==
X-Google-Smtp-Source: APXvYqyZHPThF8/MiG5jwxPfKS86cN5+Ae2YRjPCnzIFMpfI+LySHsPO/Xbk225tHMUxddqVLhPLlg==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr40304219wme.40.1578405193005; 
 Tue, 07 Jan 2020 05:53:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s1sm27661001wmc.23.2020.01.07.05.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 05:53:11 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 30FB21FF8C;
 Tue,  7 Jan 2020 13:53:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/6] hw/i386/x86-iommu: Add missing stubs
Date: Tue,  7 Jan 2020 13:53:06 +0000
Message-Id: <20200107135311.5215-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107135311.5215-1-alex.bennee@linaro.org>
References: <20200107135311.5215-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In commit 6c730e4af9 we introduced a stub to build the MicroVM
machine without Intel IOMMU. This stub is incomplete for the
other PC machines. Add the missing stubs.

Fixes: 6c730e4af9
Reported-by: Travis-CI
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20191220154225.25879-1-philmd@redhat.com>
---
 hw/i386/x86-iommu-stub.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
index 03576cdccb4..c5ba077f9d1 100644
--- a/hw/i386/x86-iommu-stub.c
+++ b/hw/i386/x86-iommu-stub.c
@@ -32,3 +32,12 @@ X86IOMMUState *x86_iommu_get_default(void)
     return NULL;
 }
 
+bool x86_iommu_ir_supported(X86IOMMUState *s)
+{
+    return false;
+}
+
+IommuType x86_iommu_get_type(void)
+{
+    abort();
+}
-- 
2.20.1


