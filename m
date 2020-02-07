Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA98BC2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9733A20726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a00yJ7l+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9733A20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyGl-0001Ba-PZ
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1izyFy-0008QJ-1K
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1izyFw-0006wc-Ka
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:40:53 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1izyFw-0006uP-EA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:40:52 -0500
Received: by mail-pl1-x642.google.com with SMTP id e8so644988plt.9
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 23:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/SnnhcW9j2w0zXhHNiNCZH/SGhNXDWdjF8vo2ZrVttU=;
 b=a00yJ7l+XBLCb3bGDzVE/7Cae2c+1+r8yoXH5HGStzsUPSEHocsZz2/dejlhicpLGF
 OtRvZikkIRdcMddH34OfDmCSeHAgBewdVkOXTYFnnI6TST3iF8/rIcFpxcJck8wHLf2I
 algCQguq+ktDwj+91ZQBRqDdqfmfc07yADtus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/SnnhcW9j2w0zXhHNiNCZH/SGhNXDWdjF8vo2ZrVttU=;
 b=A9IAfP/+1w3fNrq/YmhkRXM4vDLsZ6i74dKWmmsQ0AaUV1ZuTVydlIfYAUOXnnqIDQ
 e+8vV+1Tg7bAGW7AKED6tHk+9d31RMUcpRphood06FA5DFlBwNCaQwBO4EYN+pXYb5SD
 xjX5B4XNUSXNGiIRIbQJeke0Pp/npcTgf6aM0721RfHTI4K7QLOIY0zQx/LarlZE3KD4
 KtQOHgTYeJO6Tf+F95UBf15s0CmqeXYqIB4hzmGm/UzTjcoUnASGc726uV8RsuXPpBI3
 kSx45yEpusMTz1+/vb7LTmIPwfSvFJWpzFLelc/ao9vXCDGDQ28Gad51l9xqTd0yHGL+
 /fuQ==
X-Gm-Message-State: APjAAAWzFcvA+Sb551RU0lpP2UHr+XgWen2OsrpYw/27i9dI5PvxIC1Y
 Dxwb1B4Tdnkh/yAAVTxpn0Z1ag==
X-Google-Smtp-Source: APXvYqw8ntnBPknPgSFy1QDLWy+btnUDt57+Zj0AU/BkHGN0s4uqX8z+48phCu7XPf9wd2i7CfbRTg==
X-Received: by 2002:a17:90a:bc41:: with SMTP id
 t1mr2269084pjv.137.1581061251505; 
 Thu, 06 Feb 2020 23:40:51 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1f16:51f4:8631:68b2])
 by smtp.gmail.com with ESMTPSA id u13sm1474937pjn.29.2020.02.06.23.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 23:40:51 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
To: virtio-comment@lists.oasis-open.org
Subject: [RFC PATCH v3 1/2] content: define what an exported object is
Date: Fri,  7 Feb 2020 16:40:32 +0900
Message-Id: <20200207074033.172289-2-stevensd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200207074033.172289-1-stevensd@chromium.org>
References: <20200207074033.172289-1-stevensd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
index b1ea9b9..ad3723c 100644
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
2.25.0.341.g760bfbb309-goog


