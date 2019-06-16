Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA7FC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C630420679
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C630420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccrY-0000MY-2O
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40929)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hccoz-0006cb-6D
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hccox-0006VA-HY
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:16 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:36672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hccox-0006Tj-9h
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:15 -0400
Received: by mail-qt1-f174.google.com with SMTP id p15so8596216qtl.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=I4w4sFILnilKuWZLM4vU3UtnjzTR4HneobhQLc7gBII=;
 b=U9WLdJ+THIwED7RcGQwk9eejk4LaN4fSN99UpRm1yAGL+RxdZIsGUb1VbtlR16Z38c
 vdSYqHWKbtfrAFLP7tYCl+hVPHtQ7I2ji5Y0XDFUoVzIEJMnk/Y7ijkHfOPyz7RYzSXt
 rK3CzyA1aihLbedmFWl1VIH+w21etnQLK9IoUm8ko0CzvNajsOJoaHlhL43szZUTV/+2
 ezO6TO18ARN8U7LHA92aZO1/sK1V36exVpInyHjQ59b42ZQJfPPT73v53LFtEErT4DwE
 /51InR5408tXy0Mex+Sy8EgXlBJ2zrYTNw/vNan6o6nm+jRCSCVtiERR9KI9RxHAc/v3
 s13g==
X-Gm-Message-State: APjAAAVSoYWmaLZtRdYf4dEqzIZifwZtYlTBgyVAtg5r/RRZ/BiR+dc3
 OYFq+jG9Ds79IfjuuPhlwHmKLfxiZWc=
X-Google-Smtp-Source: APXvYqwGOIRtHPa8suEl1PX1quDhtVQfnYEnQ8b3cd8VdFF2RerGnyiSCmJPSmR9ZDg3f7JBX7zKaA==
X-Received: by 2002:a0c:b59c:: with SMTP id g28mr18880635qve.244.1560720974345; 
 Sun, 16 Jun 2019 14:36:14 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id s66sm5197210qkh.17.2019.06.16.14.36.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:36:13 -0700 (PDT)
Date: Sun, 16 Jun 2019 17:36:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190605145829.7674-6-marcandre.lureau@redhat.com>
References: <20190616213540.20430-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190616213540.20430-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.174
Subject: [Qemu-devel] [PULL 05/11] vhost-user-gpu: initialize msghdr & iov
 at declaration
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190616213612.sFMeQ_2mdotRPoQ_XMTaa6m-Tmn08HAiqNLr0dau5Xc@z>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This should fix uninitialized fields found by coverity CID 1401762.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190605145829.7674-6-marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/vhost-user-gpu/main.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/contrib/vhost-user-gpu/main.c b/contrib/vhost-user-gpu/main.c
index 0ef649ffaa..04b753046f 100644
--- a/contrib/vhost-user-gpu/main.c
+++ b/contrib/vhost-user-gpu/main.c
@@ -138,22 +138,20 @@ static int
 vg_sock_fd_write(int sock, const void *buf, ssize_t buflen, int fd)
 {
     ssize_t ret;
-    struct msghdr msg;
-    struct iovec iov;
+    struct iovec iov = {
+        .iov_base = (void *)buf,
+        .iov_len = buflen,
+    };
+    struct msghdr msg = {
+        .msg_iov = &iov,
+        .msg_iovlen = 1,
+    };
     union {
         struct cmsghdr cmsghdr;
         char control[CMSG_SPACE(sizeof(int))];
     } cmsgu;
     struct cmsghdr *cmsg;
 
-    iov.iov_base = (void *)buf;
-    iov.iov_len = buflen;
-
-    msg.msg_name = NULL;
-    msg.msg_namelen = 0;
-    msg.msg_iov = &iov;
-    msg.msg_iovlen = 1;
-
     if (fd != -1) {
         msg.msg_control = cmsgu.control;
         msg.msg_controllen = sizeof(cmsgu.control);
@@ -164,9 +162,6 @@ vg_sock_fd_write(int sock, const void *buf, ssize_t buflen, int fd)
         cmsg->cmsg_type = SCM_RIGHTS;
 
         *((int *)CMSG_DATA(cmsg)) = fd;
-    } else {
-        msg.msg_control = NULL;
-        msg.msg_controllen = 0;
     }
 
     do {
-- 
MST


