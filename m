Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ED6C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032C720724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aAYKaD5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032C720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEkmY-00007w-6Z
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 22:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1jEkli-0007By-SL
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1jEklh-0000m0-Jh
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:18:46 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:37539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1jEklh-0000fN-Bm
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:18:45 -0400
Received: by mail-pj1-x102c.google.com with SMTP id ca13so287897pjb.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 19:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N1Zou9g3kOpovEPiLX1RjUrhPNeCP8eY2KNWCUQTCG4=;
 b=aAYKaD5hXQz4nJWmWdoEb5Skgi/qTb9l9vp+6LzCAZRNfaJe8kilk2IdLVZHFqQvsX
 xEMJNJezpcGfyHocz8a64j12ZNDFBnZRXEv41Hg4aXctgy4Jdk0vZ+46q+ygPv/g+AI7
 qcwpL4XBMW33MXM12kYQuh/1TgiT3ewv/29d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N1Zou9g3kOpovEPiLX1RjUrhPNeCP8eY2KNWCUQTCG4=;
 b=TqKG1YGxAwkb0qy0pWu+nmqPLB9qdXjdnuA4K3pynFnRuY/WLImdgctcPs/GH0s/zR
 TQmOqKxqNsrThFnzcYBuWJw+62BrEz0W3JXquSg9INHe4hRzHZAtCvX3x/6a76PSusia
 Rl/q/i6AGDw22dGkwhrSqJ+o2HCHBzUyUSGSf2IsFsMTWB9Fyk+gXtlrlVWuopTB5gbP
 zl54PAP1vZtaQ7yohCVrD5dhNPK/nUev2Kk8ZdUkC6GlYn0IfDzI47N0XnKoLGG48rx9
 PVfLDZr7duk6yA6bL4ONUZpcZKqUpgCzXOUkWGAx6VJSCCOXqYnDtMuCa2d+bppGP7aR
 DF6A==
X-Gm-Message-State: ANhLgQ2TA92a+PloTwyZbao0qOasn4GFBdu1mR7Z6ocuZxrB9m0iquPw
 9z1NoYaDkyYLLIdgW43NlB7Fng==
X-Google-Smtp-Source: ADFU+vtE7S8SgklW7D0s/jGCM8v62Wug2+KP+L5Qt3hs5eR8MSAtHC0RMzYyuHEp+K2oo2rbMWIgNQ==
X-Received: by 2002:a17:90a:7105:: with SMTP id
 h5mr1329758pjk.54.1584584324391; 
 Wed, 18 Mar 2020 19:18:44 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:30f2:7a9c:387e:6c7])
 by smtp.gmail.com with ESMTPSA id q9sm325194pgs.89.2020.03.18.19.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 19:18:44 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
To: virtio-comment@lists.oasis-open.org
Subject: [PATCH v4 2/2] virtio-gpu: add the ability to export resources
Date: Thu, 19 Mar 2020 11:18:23 +0900
Message-Id: <20200319021823.57219-3-stevensd@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200319021823.57219-1-stevensd@chromium.org>
References: <20200319021823.57219-1-stevensd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102c
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
Cc: Zach Reizner <zachr@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 David Stevens <stevensd@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 virtio-gpu.tex | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/virtio-gpu.tex b/virtio-gpu.tex
index af4ca61..e75aafa 100644
--- a/virtio-gpu.tex
+++ b/virtio-gpu.tex
@@ -35,6 +35,8 @@ \subsection{Feature bits}\label{sec:Device Types / GPU Device / Feature bits}
 \begin{description}
 \item[VIRTIO_GPU_F_VIRGL (0)] virgl 3D mode is supported.
 \item[VIRTIO_GPU_F_EDID  (1)] EDID is supported.
+\item[VIRTIO_GPU_F_RESOURCE_UUID (2)] assigning resources UUIDs for export
+  to other virtio devices is supported.
 \end{description}
 
 \subsection{Device configuration layout}\label{sec:Device Types / GPU Device / Device configuration layout}
@@ -181,6 +183,7 @@ \subsubsection{Device Operation: Request header}\label{sec:Device Types / GPU De
         VIRTIO_GPU_CMD_GET_CAPSET_INFO,
         VIRTIO_GPU_CMD_GET_CAPSET,
         VIRTIO_GPU_CMD_GET_EDID,
+        VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID,
 
         /* cursor commands */
         VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
@@ -192,6 +195,7 @@ \subsubsection{Device Operation: Request header}\label{sec:Device Types / GPU De
         VIRTIO_GPU_RESP_OK_CAPSET_INFO,
         VIRTIO_GPU_RESP_OK_CAPSET,
         VIRTIO_GPU_RESP_OK_EDID,
+        VIRTIO_GPU_RESP_OK_RESOURCE_UUID,
 
         /* error responses */
         VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -454,6 +458,32 @@ \subsubsection{Device Operation: controlq}\label{sec:Device Types / GPU Device /
 This detaches any backing pages from a resource, to be used in case of
 guest swapping or object destruction.
 
+\item[VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID] Creates an exported object from
+  a resource. Request data is \field{struct
+    virtio_gpu_resource_assign_uuid}.  Response type is
+  VIRTIO_GPU_RESP_OK_RESOURCE_UUID, response data is \field{struct
+    virtio_gpu_resp_resource_uuid}. Support is optional and negotiated
+    using the VIRTIO_GPU_F_RESOURCE_UUID feature flag.
+
+\begin{lstlisting}
+struct virtio_gpu_resource_assign_uuid {
+        struct virtio_gpu_ctrl_hdr hdr;
+        le32 resource_id;
+        le32 padding;
+};
+
+struct virtio_gpu_resp_resource_uuid {
+        struct virtio_gpu_ctrl_hdr hdr;
+        u8 uuid[16];
+};
+\end{lstlisting}
+
+The response contains a UUID which identifies the exported object created from
+the host private resource. Note that if the resource has an attached backing,
+modifications made to the host private resource through the exported object by
+other devices are not visible in the attached backing until they are transferred
+into the backing.
+
 \end{description}
 
 \subsubsection{Device Operation: cursorq}\label{sec:Device Types / GPU Device / Device Operation / Device Operation: cursorq}
-- 
2.25.1.481.gfbce0eb801-goog


