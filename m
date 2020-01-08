Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293A7C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F0C206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B7I9lf3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F0C206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip7FH-0003hq-1s
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 04:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1ip7EF-0002Ur-9A
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:02:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1ip7EE-00060X-6F
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:02:15 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:45548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1ip7EE-00060C-2h
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:02:14 -0500
Received: by mail-qk1-x743.google.com with SMTP id x1so1928670qkl.12
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 01:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=YLJj0mJcsiWZwcGJQfC2/Am8KkGfccyx1B+T1mfpzBE=;
 b=B7I9lf3X8OH5s2QgLQ3VUszD2IKt6VUU85pFa9iNMdrEj2Pb0cry/HqqJQpH+smc2Q
 XWZzpInO4EfR2e6sPAErnlfGEfgLOJjoRhNbWmR1bf/PoNeaizCLcjabgqTUol9rlAYT
 ma76CbkvnWwjeFxZbl5yNP/fLZ1eyjohAIafU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=YLJj0mJcsiWZwcGJQfC2/Am8KkGfccyx1B+T1mfpzBE=;
 b=o8iCd2yOWnn0qAZpBPF3j3+zxGxVsvmbZNOefyfGguDJJvg9d8O+Dq543WcQI+xFmP
 +kDyVkGEiaJJZn49yUXpLlOzZ3gpuW07SHlskPYNxOcwojAtdiGwwqVyTNHG+AO0LPBS
 Zy1N7FTsJdf/EgDHYr5R4C7lrwYJbZ2u/fKR+BMz6A98GrLZJXRYnJ4jv01Poju1ootw
 3WVu1HpVwJACZeO2uXCMnCbkmpWxjXoFSrMDs1jXqbqxjLFu47hzPVIPKrWP/ENaROE0
 qqF4tAmgZbTeFm50bKYhDg9ucabtn5QlNTZKyr0ZPtTqfpmZrzgBkEP2ypx9Gh6eCwa9
 h6QA==
X-Gm-Message-State: APjAAAXJRriYfjy0G4vK8byetIniUE5TfsVMbcIWWBQ9c+9fDHUgE/z5
 uTuz3IzFpEMf/WcFaa5aOIWIV3rcijBwAy/7kX6nxw==
X-Google-Smtp-Source: APXvYqyOhO7E4NDMVSLVTTWbMjBEmnBCWdbVQupSDkJ7fdK3WLAPNZj4EXc3WCQxkYsMxMB5lMPtNcFY2kFCzAPiZ2w=
X-Received: by 2002:a05:620a:817:: with SMTP id
 s23mr3310134qks.391.1578474133357; 
 Wed, 08 Jan 2020 01:02:13 -0800 (PST)
MIME-Version: 1.0
From: David Stevens <stevensd@chromium.org>
Date: Wed, 8 Jan 2020 18:02:02 +0900
Message-ID: <CAD=HUj5U-TxqbPJiRRbyMHON21sht75q3nisvwvKrO+Bf=n8ng@mail.gmail.com>
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
 virtio-gpu.tex | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/virtio-gpu.tex b/virtio-gpu.tex
index af4ca61..522f478 100644
--- a/virtio-gpu.tex
+++ b/virtio-gpu.tex
@@ -186,12 +186,16 @@ \subsubsection{Device Operation: Request
header}\label{sec:Device Types / GPU De
         VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
         VIRTIO_GPU_CMD_MOVE_CURSOR,

+        /* misc commands */
+        VIRTIO_GPU_CMD_EXPORT_RESOURCE = 0x0400,
+
         /* success responses */
         VIRTIO_GPU_RESP_OK_NODATA = 0x1100,
         VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
         VIRTIO_GPU_RESP_OK_CAPSET_INFO,
         VIRTIO_GPU_RESP_OK_CAPSET,
         VIRTIO_GPU_RESP_OK_EDID,
+        VIRTIO_GPU_RESP_OK_EXPORT_RESOURCE,

         /* error responses */
         VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -454,6 +458,31 @@ \subsubsection{Device Operation:
controlq}\label{sec:Device Types / GPU Device /
 This detaches any backing pages from a resource, to be used in case of
 guest swapping or object destruction.

+\item[VIRTIO_GPU_CMD_EXPORT_RESOURCE] Exports a resource for use by other
+  virtio devices. Request data is \field{struct
+    virtio_gpu_export_resource}.  Response type is
+  VIRTIO_GPU_RESP_OK_EXPORT_RESOURCE, response data is \field{struct
+    virtio_gpu_resp_export_resource}.
+
+\begin{lstlisting}
+struct virtio_gpu_export_resource {
+        struct virtio_gpu_ctrl_hdr hdr;
+        le32 resource_id;
+        le32 padding;
+};
+
+struct virtio_gpu_resp_export_resource {
+        struct virtio_gpu_ctrl_hdr hdr;
+        le64 uuid_low;
+        le64 uuid_high;
+};
+\end{lstlisting}
+
+The response contains a uuid which identifies the host private resource to
+other virtio devices. Note that if the resource has an attached backing,
+modifications made to an exported resource by other devices are not visible
+in the attached backing until they are transferred into the backing.
+
 \end{description}

 \subsubsection{Device Operation: cursorq}\label{sec:Device Types /
GPU Device / Device Operation / Device Operation: cursorq}
-- 
2.24.1.735.g03f4e72817-goog

