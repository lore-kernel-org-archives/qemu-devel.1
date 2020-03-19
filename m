Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7BBC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27ADF20724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ab9aZhwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27ADF20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEkmT-0008OO-93
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 22:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1jEkld-00073M-N3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1jEklc-0000DA-7b
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:18:41 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1jEklc-00006Q-1R
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:18:40 -0400
Received: by mail-pg1-x542.google.com with SMTP id m5so355687pgg.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 19:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1C8jLhXuPfBb7h90RHOdI3Yy2sESPpspTtCUaNxuRxE=;
 b=ab9aZhwV8Ief16HW0MRvphHu2sqdH+8TGCXu2J/DZM2sTVAcH82y5neSsPEP+v4s/g
 kKOhY1f8E1gjgR7A75Y5DkfTT00HG+m9S9p44G5AO7UyphRi0nUwZXnpRcJ4/qBxtqM/
 gXiqeeT6GPF6I/JHU0G2kMo9Xp3OFyMnF8MB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1C8jLhXuPfBb7h90RHOdI3Yy2sESPpspTtCUaNxuRxE=;
 b=YNCOgi1HnPErZW/vbltWnVg5FglIrctdkEtlQWpscqZZpVNj1QQZjQaHj5epnUYe60
 LIzl9bcZtrg/UIuPE7nxowSezrkrIkfWvAwM2rX/udrsmcVCykz+20V0pRWj4ZJMB8Nm
 qWXacZcyoS92MlhUk1Ny/0YoxIBVHFqaUeGaVeoc2G7zGRXxpfHlqYjI33NT/5vCrNKY
 H6HT40LUbZ1THDuVCcTbBvraIT7/rW7SqKQnxXW6Dik7ImWZly7Lex4aUiVVLWdYEbMo
 6SU/8yQtJiN1PKqWLYV84JLoWN1YTqRYGL5VHF5MeMydWSXltvVE0BZoE29gSmJokyle
 Kh4w==
X-Gm-Message-State: ANhLgQ3d8sRddf7v4HFI3AoS4Kja3zX0ousNUSh++u0c8UXY2Va3C1O+
 rj2hR5nC4LxpNwq8szYPXdl09g==
X-Google-Smtp-Source: ADFU+vsA3Do93d+fKRKpI4+KnCX1CyGpYNhUlFZFW824PU6sMlngpOx8GyHpGZj6qH3Whemhlg7jTw==
X-Received: by 2002:aa7:870f:: with SMTP id b15mr1443454pfo.190.1584584318862; 
 Wed, 18 Mar 2020 19:18:38 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:30f2:7a9c:387e:6c7])
 by smtp.gmail.com with ESMTPSA id m18sm327988pgd.39.2020.03.18.19.18.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 19:18:38 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
To: virtio-comment@lists.oasis-open.org
Subject: [PATCH v4 1/2] content: define what an exported object is
Date: Thu, 19 Mar 2020 11:18:22 +0900
Message-Id: <20200319021823.57219-2-stevensd@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200319021823.57219-1-stevensd@chromium.org>
References: <20200319021823.57219-1-stevensd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

Define a mechanism for sharing objects between different virtio
devices.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 content.tex      | 12 ++++++++++++
 introduction.tex |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/content.tex b/content.tex
index b1ea9b9..c8a367b 100644
--- a/content.tex
+++ b/content.tex
@@ -373,6 +373,18 @@ \section{Driver Notifications} \label{sec:Virtqueues / Driver notifications}
 
 \input{shared-mem.tex}
 
+\section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Exporting Objects}
+
+When an object created by one virtio device needs to be
+shared with a seperate virtio device, the first device can
+export the object by generating a UUID which can then
+be passed to the second device to identify the object.
+
+What constitutes an object, how to export objects, and
+how to import objects are defined by the individual device
+types. It is RECOMMENDED that devices generate version 4
+UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
diff --git a/introduction.tex b/introduction.tex
index 40f16f8..fc2aa50 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -40,6 +40,10 @@ \section{Normative References}\label{sec:Normative References}
 	\phantomsection\label{intro:rfc2119}\textbf{[RFC2119]} &
 Bradner S., ``Key words for use in RFCs to Indicate Requirement
 Levels'', BCP 14, RFC 2119, March 1997. \newline\url{http://www.ietf.org/rfc/rfc2119.txt}\\
+	\phantomsection\label{intro:rfc4122}\textbf{[RFC4122]} &
+Leach, P., Mealling, M., and R. Salz, ``A Universally Unique
+IDentifier (UUID) URN Namespace'', RFC 4122, DOI 10.17487/RFC4122,
+July 2005. \newline\url{http://www.ietf.org/rfc/rfc4122.txt}\\
 	\phantomsection\label{intro:S390 PoP}\textbf{[S390 PoP]} & z/Architecture Principles of Operation, IBM Publication SA22-7832, \newline\url{http://publibfi.boulder.ibm.com/epubs/pdf/dz9zr009.pdf}, and any future revisions\\
 	\phantomsection\label{intro:S390 Common I/O}\textbf{[S390 Common I/O]} & ESA/390 Common I/O-Device and Self-Description, IBM Publication SA22-7204, \newline\url{http://publibfp.dhe.ibm.com/cgi-bin/bookmgr/BOOKS/dz9ar501/CCONTENTS}, and any future revisions\\
 	\phantomsection\label{intro:PCI}\textbf{[PCI]} &
-- 
2.25.1.481.gfbce0eb801-goog


