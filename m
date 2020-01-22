Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FE3C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC5824125
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P8ugtCzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC5824125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuAHH-00028r-C7
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 02:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1iuAFg-0000eb-TD
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1iuAFf-0003fT-Ta
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:16:36 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d]:38814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1iuAFf-0003fN-Q3
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:16:35 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id t6so2774864qvs.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 23:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=IvHhZTaEUivWZW7zpZ8DN7CQvbWtXPcmSa5wCq98Ixw=;
 b=P8ugtCzbkP+LO9jzvfAgOeaiG9+8w6QYuAgDVCuEBVTCjwol8ntvM1zLsctTH4ueyf
 9ROg+UEB9idsIrOVHCdx+ihRYEXdd9tF4dqyB9jChAibTKSNlWptCgmckOb+qppc2lIa
 qWFGBnuG8IwjSCQ6c0YWH7PbgvLOLfzGR/ddM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=IvHhZTaEUivWZW7zpZ8DN7CQvbWtXPcmSa5wCq98Ixw=;
 b=q6a9ovvIJEp9yWkiasd65HC0BzvVeIxrAjFI0UvV4Que+sTtC07UbigEBa7oTdCM2z
 Qu0VuXsT6kKvthjjDuCK8v2qiNhq883QGvgeqs6OICGokyY/ZONKP6ct7eHVia1xt9c/
 xBnhtMIZXSL3mmg4zKrq9GastiOL2YVoEZ0OQsXpY/MBJxwzHXhOv59Lp3+74RsK3Vr2
 9GCvJQejWcaAgFTj5waY0/Qw7h/EkYjjihEFBQn9AvG5njrYLsPeHtB7KHX89y/gtd4I
 18lSIyESgQKEdnDl9EshkgZxgLQZnxEdyDHZ9+eeAvJV07+fr6v75BKS8gIzdHeeIu6T
 p+NA==
X-Gm-Message-State: APjAAAXoyGkOvzUqpaUYWsEfen4YdAEHjaB9HeenAdOnAxyKHv8Rqgv4
 Nn0hiro4XDJ9aEFcqMXfh7FhEbACDj1c82YbfMqytA==
X-Google-Smtp-Source: APXvYqx4RcN53n670UPjMJvlSwx4cAxbVDFWfbUJ+hfzwTe5JQ7PUS6PtSim2s67oYcZ7Rgpqyh668b+ckkT+d6OFio=
X-Received: by 2002:a05:6214:10c1:: with SMTP id
 r1mr9111779qvs.70.1579677395313; 
 Tue, 21 Jan 2020 23:16:35 -0800 (PST)
MIME-Version: 1.0
From: David Stevens <stevensd@chromium.org>
Date: Wed, 22 Jan 2020 16:16:24 +0900
Message-ID: <CAD=HUj640QfNwO4J_tdcSx36YOVAVT_dZUXYuKPaCKvZVWeHsg@mail.gmail.com>
Subject: [virtio-dev][RFC PATCH v1 1/2] content: define what an exported
 object is
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
X-Received-From: 2607:f8b0:4864:20::f2d
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

Define a mechanism for sharing objects between different virtio
devices.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 content.tex | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/content.tex b/content.tex
index b1ea9b9..6c6dd59 100644
--- a/content.tex
+++ b/content.tex
@@ -373,6 +373,24 @@ \section{Driver Notifications}
\label{sec:Virtqueues / Driver notifications}

 \input{shared-mem.tex}

+\section{Exporting Objects}\label{sec:Basic Facilities of a Virtio
Device / Exporting Objects}
+
+When an object created by one virtio device needs to be
+shared with a seperate virtio device, the first device can
+export the object by generating a \field{uuid} which the
+guest can pass to the second device to identify the object.
+
+What constitutes an object, how to export objects, and
+how to import objects are defined by the individual device
+types. The generation method of a \field{uuid} is dependent
+upon the implementation of the exporting device.
+
+Whether a particular exported object can be imported into
+a device is dependent upon the implementations of the exporting
+and importing devices. Generally speaking, the guest should
+have some knowledge of the host configuration before trying to
+use exported objects.
+
 \chapter{General Initialization And Device
Operation}\label{sec:General Initialization And Device Operation}

 We start with an overview of device initialization, then expand on the
-- 
2.25.0.341.g760bfbb309-goog

