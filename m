Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD15AC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77767206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DYbgTGSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77767206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip7GR-0005Dd-E5
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 04:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1ip7EA-0002QF-Gk
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1ip7E9-0005xS-I2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:02:10 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d]:38756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1ip7E9-0005x2-EJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:02:09 -0500
Received: by mail-qk1-x72d.google.com with SMTP id k6so1975688qki.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 01:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=MvBXFmubHjfTSZqX6gGxSDOdnp6QUUqOLQUXD/uSqGE=;
 b=DYbgTGSP4mdzTCAqDQe0ONLDdXBCvCrs3Gf/qEYQ3nonNazP44qqR3UAJhoN3bcQWX
 bQ2M/rSn1WnKbQ+SA+qoy1OFUAwukrU7HbG4Inels53VYSIMMPYpRV2TcKUFdlz7IZ+s
 BlgcIAJI+EA2lI+1aLJOK0EB7NrpI9sWVCWq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=MvBXFmubHjfTSZqX6gGxSDOdnp6QUUqOLQUXD/uSqGE=;
 b=srTivzQIdwS5mo6kbZo/6SJPfF6dV2NrQ/spSKkOnddinMfc1ZtgdFJiVZWO/uXago
 qDVRxbwKWBdnOUIS012bOsyQJaDO3iKmz18PCkO9g715Hjwp/kkAVw4HKOLcUIOhrJKS
 3+3bZc+yWwpL0HPxzs/7ZUcZS4Q42qy8rcqlpvh7iGOTGAr2j8GhLZq5As8dZsUHBvOT
 D+HttlJSRRGmnmW/R+5GQ0HnKZO1wuVypx0KSNm/mGlNa16fbjFpdGX+8TTOZJsEivEx
 Y3mGlVepwKRlK9VKHudrfdEu056cnp+ua6MZp39Xu3hOIydhG2erbQYuBe+AMofwwcFm
 JFjw==
X-Gm-Message-State: APjAAAUTwDbrlpFg/V7kwmxztL3xeJau9uBOOsMfe75XR/1eZ1vntf9f
 OPacis5nQSp+Vx1zNE7J1oEPq5TOSFzyHleMOniuGg==
X-Google-Smtp-Source: APXvYqweJlXV88c+PKT192DC2KihUtPe6TwZU6GCiLW50z8aM6eR4XRmfbWIQhisZ6FPS+0icbkxvHNLUyZA9fpTYc4=
X-Received: by 2002:a05:620a:101b:: with SMTP id
 z27mr3076885qkj.241.1578474128857; 
 Wed, 08 Jan 2020 01:02:08 -0800 (PST)
MIME-Version: 1.0
From: David Stevens <stevensd@chromium.org>
Date: Wed, 8 Jan 2020 18:01:58 +0900
Message-ID: <CAD=HUj6FA3VoTJqNa+gmAgVOv9zS7Qk9pdg46EY9NvtJOdz5_A@mail.gmail.com>
Subject: [virtio-dev][RFC PATCH v1 1/2] content: define what exporting a
 resource is
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
X-Received-From: 2607:f8b0:4864:20::72d
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

Define a mechanism for sharing resources between different virtio
devices.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 content.tex | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/content.tex b/content.tex
index b1ea9b9..73bd28e 100644
--- a/content.tex
+++ b/content.tex
@@ -373,6 +373,24 @@ \section{Driver Notifications}
\label{sec:Virtqueues / Driver notifications}

 \input{shared-mem.tex}

+\section{Exporting Resources}\label{sec:Basic Facilities of a Virtio
Device / Exporting Resources}
+
+When a resource created by one virtio device needs to be
+shared with a seperate virtio device, the first device can
+export the resource by generating a \field{uuid} which the
+guest can pass to the second device to identify the resource.
+
+What constitutes a resource, how to export resources, and
+how to import resources are defined by the individual device
+types. The generation method of a \field{uuid} is dependent
+upon the implementation of the exporting device.
+
+Whether a particular exported resource can be imported into
+a device is dependent upon the implementations of the exporting
+and importing devices. Generally speaking, the guest should
+have some knowledge of the host configuration before trying to
+use exported resources.
+
 \chapter{General Initialization And Device
Operation}\label{sec:General Initialization And Device Operation}

 We start with an overview of device initialization, then expand on the
-- 
2.24.1.735.g03f4e72817-goog

