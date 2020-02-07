Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC07C2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7C020726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B2H2rs1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7C020726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyGs-0001Qf-FE
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1izyG3-00006I-OH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1izyG2-0007Ny-KM
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:40:59 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1izyG2-0007K6-EK
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:40:58 -0500
Received: by mail-pj1-x1042.google.com with SMTP id gv17so566020pjb.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 23:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K+lFsZ3D7frtdDjFKWe1aGa1gg1H8Ao5Is0znK6p0IQ=;
 b=B2H2rs1re6i1nnY3F52J+pN3K0qSaFUTXsvR/kHlXEC5q+GAsTwamOojZKavCOw06J
 04YDv8/X7jlq0QULXSIqHNVvk6xXg36c/FTbd9jONol/F0ACmVj6f4tkeKEHk4K1ZkIG
 u5j152fRtHwRIWFWySh1j5lmLHd7OmXZ2TQpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K+lFsZ3D7frtdDjFKWe1aGa1gg1H8Ao5Is0znK6p0IQ=;
 b=pbgkTg6HbUgqLiGTpUVDFd3Nbzfe2K6v+4ybWkDWSj8xxn+65C3XATXi/Kw1yYuUjm
 1ZTG4Xj9suNK2N/F4Wq/gaORxtFwp3W5iuhszEWjxfxs61cghkJ11LYYRsVcyH2tFBhw
 73iWfdKvovdiMNgMEjEGctUdW5D8EvRmgQjzGe7VN7nByXrvUk6ErpGnCPiC1iMfHiHx
 Q8G45A01PVoR1J4OQsgnbKtXEbajmbyFIpfmufjev78WAgXd5iuT865B04zyhwYJJZFy
 U903mhff98pft7bpD83dttV4cm8w3f8X/nEIrzzPlKMmZZFM6qFYXZ+0BeEMPhF3CVLN
 x/OA==
X-Gm-Message-State: APjAAAU+3Sm/3h1HMi1GYqhU5ujPIclQZD4HcY56xbgLqfYOrCIgglDa
 zsNaYI8SvYsvCgME5LWqiW24QA==
X-Google-Smtp-Source: APXvYqwUsuQh7DqVB3QPoHA+aQLMvwcNFHiiFLQVrPJb+M5Yxl0A/kd6Svz1dKsbIQlkD43XLUSFhQ==
X-Received: by 2002:a17:90a:a385:: with SMTP id
 x5mr2366982pjp.102.1581061257481; 
 Thu, 06 Feb 2020 23:40:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1f16:51f4:8631:68b2])
 by smtp.gmail.com with ESMTPSA id dw10sm1482749pjb.11.2020.02.06.23.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 23:40:57 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
To: virtio-comment@lists.oasis-open.org
Subject: [RFC PATCH v3 2/2] virtio-gpu: add the ability to export resources
Date: Fri,  7 Feb 2020 16:40:33 +0900
Message-Id: <20200207074033.172289-3-stevensd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200207074033.172289-1-stevensd@chromium.org>
References: <20200207074033.172289-1-stevensd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
 virtio-gpu.tex | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/virtio-gpu.tex b/virtio-gpu.tex
index af4ca61..e950ad3 100644
--- a/virtio-gpu.tex
+++ b/virtio-gpu.tex
@@ -186,12 +186,16 @@ \subsubsection{Device Operation: Request header}\label{sec:Device Types / GPU De
         VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
         VIRTIO_GPU_CMD_MOVE_CURSOR,
 
+        /* misc commands */
+        VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID = 0x0400,
+
         /* success responses */
         VIRTIO_GPU_RESP_OK_NODATA = 0x1100,
         VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
         VIRTIO_GPU_RESP_OK_CAPSET_INFO,
         VIRTIO_GPU_RESP_OK_CAPSET,
         VIRTIO_GPU_RESP_OK_EDID,
+        VIRTIO_GPU_RESP_OK_RESOURCE_ASSIGN_UUID,
 
         /* error responses */
         VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -454,6 +458,31 @@ \subsubsection{Device Operation: controlq}\label{sec:Device Types / GPU Device /
 This detaches any backing pages from a resource, to be used in case of
 guest swapping or object destruction.
 
+\item[VIRTIO_GPU_CMD_RESOURCE_ASSIGN_UUID] Creates an exported object from
+  a resource. Request data is \field{struct
+    virtio_gpu_resource_assign_uuid}.  Response type is
+  VIRTIO_GPU_RESP_OK_RESOURCE_ASSIGN_UUID, response data is \field{struct
+    virtio_gpu_resp_resource_assign_uuid}.
+
+\begin{lstlisting}
+struct virtio_gpu_resource_assign_uuid {
+        struct virtio_gpu_ctrl_hdr hdr;
+        le32 resource_id;
+        le32 padding;
+};
+
+struct virtio_gpu_resp_resource_assign_uuid {
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
2.25.0.341.g760bfbb309-goog


