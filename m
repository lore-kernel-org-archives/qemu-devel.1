Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFD8CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F77620862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F77620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPai8-00066p-Ow
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaU3-0000S3-Kt
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaU2-0004DN-DR
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaU2-0004CR-0q
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:02 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32055C058CA4
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:01:01 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id l32so521325qtk.9
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nXqJo2N6krLPlsmVICbK9BFQvUyjLuOzQw6gEq62j5U=;
 b=jT84P2EYUhCrPVm7UyntjcCb1zb/Cl333CkUUz/7eHWMgw+w1mG+KdyDRL/R7E8Nph
 o1kK3IV++uXlc3Q3K94mWT6VyTIunqyRSLiJBBqhFslNPjay27UuGJQ8p/jyxDNbMGwF
 LsbSLZTL7ZhU7gtynitvb3r9SjDVFie3mW8/FvuGSEqCkv5syyBAKYGu6pG54aWd8QN6
 v0R+y39dycbKZOWFFtKCMpNrWGXtrhBqh7QpKkElcta+bSG0TqW3cNmCcu9MAD3XApDU
 VUP6Sl1Yfe/BeDcH07RDd5QUE9RNsvMOWqgSFithUzteF6ersXBZNhHkflp4kc7otjt3
 gm6Q==
X-Gm-Message-State: APjAAAVDKKR/iZDb6pS9LhEalXbaXJOvj38TJiGQf1OAykQOPzucNE+o
 nHMlHxOEEFz0U/G2y0s919tu3BlIKgTP1fvJjuYMJvhUI10NjlMt/ET4xI6vbXVWWPNFfw0zhaz
 INEY6CHkW9NoBUHE=
X-Received: by 2002:a05:6214:1109:: with SMTP id
 e9mr8074896qvs.129.1572390060148; 
 Tue, 29 Oct 2019 16:01:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzv7t4sEPsB3INjZpjonLSyl7MxE64WcjeUoDgQm7aVZmTf66dTEDKUGbMDRSJxmrJKCOorpQ==
X-Received: by 2002:a05:6214:1109:: with SMTP id
 e9mr8074876qvs.129.1572390059953; 
 Tue, 29 Oct 2019 16:00:59 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id x22sm96314qtq.15.2019.10.29.16.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:00:59 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:00:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/14] libqos: tolerate wait-unplug migration state
Message-ID: <20191029225932.14585-10-mst@redhat.com>
References: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jens Freimann <jfreimann@redhat.com>

Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Message-Id: <20191029114905.6856-10-jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/libqos/libqos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
index d71557c5cb..f229eb2cb8 100644
--- a/tests/libqos/libqos.c
+++ b/tests/libqos/libqos.c
@@ -125,7 +125,8 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
             break;
         }
 
-        if ((strcmp(st, "setup") == 0) || (strcmp(st, "active") == 0)) {
+        if ((strcmp(st, "setup") == 0) || (strcmp(st, "active") == 0)
+            || (strcmp(st, "wait-unplug") == 0)) {
             qobject_unref(rsp);
             g_usleep(5000);
             continue;
-- 
MST


