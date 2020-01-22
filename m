Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC0DC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD3D24125
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WUTU484r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD3D24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuAHV-0002UH-Up
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 02:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1iuAFr-0000sf-Gr
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1iuAFq-0003yf-EH
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:16:47 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:44820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1iuAFq-0003yZ-An
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:16:46 -0500
Received: by mail-qk1-x743.google.com with SMTP id v195so5307472qkb.11
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 23:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=ruTth2SibQcS4nk9Gf6g9LTfMVTSZKHhb1gYl0J71UE=;
 b=WUTU484rqARIGpOr209E6p6EtWXiw3rCoM/7LGnsB+Udc1fuDNKvJnxaPCf3xJct/0
 ZBr2o3wgiKDJ7evtT++c3Optb1vklYeurO5XXbe8X8ax3JjPYmIt6yeyEp0iCWiJWi5e
 1B/++Q55mz8TxogKqa0W09ib6Fmc8IK7oG1zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ruTth2SibQcS4nk9Gf6g9LTfMVTSZKHhb1gYl0J71UE=;
 b=XYtc7JlEkmYSnr70ZtkK1U/NlaMgzLanH57H2PTl6OB6Wm3RzrDuPWerOsq/MAY9/X
 lcjn0BeM7XEl8Y9FRG4SP84nuUs/+ggRynx5EQLIGth97d/Qwzap4hOhwdmHg5HFz0Dz
 QzfjKZ0alR0ZTniAxB3ZcPQrGbUcxH+3kce28lEWqyTe8YuoMkdTsV3vM3vh0TkFCv4+
 3Z9MkbKaQEd9HEn6F/jc8PRvijm52QNfI96nb1WKWVtMuM1SjrU9X0CsqCYW68c3rSlK
 Cd+tAasrqf1Ra7eU0qu3Efoan5CxilENsQpjCbtb+8uMY4BCvG7UMs8zhUoOqRmrEFDT
 Rz0w==
X-Gm-Message-State: APjAAAUd9VbkX1Aik3mzS/evLfidJ0T1+Ax9S4Pq2oKk9kIv7TNd7cTS
 BPYVPMfQJl8ZbuTumYkpaMVKjsheShccUJsXCG4sFg==
X-Google-Smtp-Source: APXvYqxMdoQBEZzRhyTMnhf8TLG9ar6fdpwRZltYldYlEOkgyU4Jw9cUYTNHnaqSyrJprSWLpXLpo2br6QqFcOdBoYQ=
X-Received: by 2002:a05:620a:101b:: with SMTP id
 z27mr8188226qkj.241.1579677405843; 
 Tue, 21 Jan 2020 23:16:45 -0800 (PST)
MIME-Version: 1.0
From: David Stevens <stevensd@chromium.org>
Date: Wed, 22 Jan 2020 16:16:35 +0900
Message-ID: <CAD=HUj7N8dpEvf0Be8fg-qpFFTQOqzZX_kVoFB=BWp8S4uEFvg@mail.gmail.com>
Subject: [virtio-dev][RFC PATCH v1 2/2] virtio-gpu: add the ability to export
 resources
To: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, 
 Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, 
 Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, 
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, 
 Pawel Osciak <posciak@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 virtio-gpu.tex | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/virtio-gpu.tex b/virtio-gpu.tex
index af4ca61..a1f0210 100644
--- a/virtio-gpu.tex
+++ b/virtio-gpu.tex
@@ -186,12 +186,16 @@ \subsubsection{Device Operation: Request
header}\label{sec:Device Types / GPU De
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
@@ -454,6 +458,32 @@ \subsubsection{Device Operation:
controlq}\label{sec:Device Types / GPU Device /
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
+        le64 uuid_low;
+        le64 uuid_high;
+};
+\end{lstlisting}
+
+The response contains a uuid which identifies the exported object created from
+the host private resource. Note that if the resource has an attached backing,
+modifications made to the host private resource through the exported object by
+other devices are not visible in the attached backing until they are
transferred
+into the backing.
+
 \end{description}

 \subsubsection{Device Operation: cursorq}\label{sec:Device Types /
GPU Device / Device Operation / Device Operation: cursorq}
-- 
2.25.0.341.g760bfbb309-goog

