Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7972DC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42EC208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYT+Qdap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42EC208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ9cD-0004g3-UJ
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 07:59:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hQ9aM-0003Vc-KX
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hQ9aL-0001Qi-OZ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:57:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hQ9aL-0001Pj-Ig
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:57:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id d12so14894531wrm.8
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 04:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=MoE+JKJdpwVeIACEygP3lal8LOZs4wKZHXNGiScJVqc=;
	b=CYT+QdapX0uALOxz1H6mzWCfDoWIcibvei1zbGOrF9L3qluHYcyVxNEjfFMEEU6lYG
	2dOHGGN7wGj6kAb1XYHhLuwC1azaYSDVdsNenCcteCQ5uZq/LDjx5XFboIWTi8z+6y0k
	QHk1IHGJprpIOhpTuHg1fx82AwObPNZs/tuItuuEXcTDZoacn1/8JwhblVqPsiPEcHlQ
	ltpzTXRDdYbFvl2DgMIe/eQLu4hvbNDg9e0NsYb0SounM3clhOyOManhFUNxqL2GBte7
	kHjRmLPee9zLT3zKc4//ve33vuv7UPR9I8KWVIEeA3XUz2rpK8XCYHCNLMIeZMpj02jS
	yEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=MoE+JKJdpwVeIACEygP3lal8LOZs4wKZHXNGiScJVqc=;
	b=tHlp4Xy2wZ4RmSzrXdpppMm8xEyQjCGqqViU579tahZmaehlkCDo1lEoMf5GrhIjrJ
	DZjZAYXu8V26qMyxZAJFjgk8QZ81wfu2tkb7RrAPWLbQN0xZM9seSgvQ4D65NRfs+gu8
	caZzLpyhie4D26QNhNR2s/S+PqNeKam0lQwW+i1XPFQetV4r8OwXR7IIRwTiGdanYDyD
	CxqXJYfZQgRzRb86X9O76xvOthxxQ8oKHCpmiwvx2un/X0NCuIvalEL0hIcOWZRbo6ma
	4NP2+iK3mvOhVj2XK8snnbekej4IAMBXmDhyE1cCxmrvTS9QQ/RQswrt0cJ0OS0KD1XK
	ddeg==
X-Gm-Message-State: APjAAAV3yrUzu+2qtm+fvOUkLt+2bP1EvROxrgu2V2oWy64+FtPYtqPH
	XIrsE65aBP/E7QvBIhPyzbVB3mXj
X-Google-Smtp-Source: APXvYqxNxqX/1EyDxvdw3CwVchNfkhjCbPWs8fhWzZ8FG7QnVGCc1Sdm8ITRbRwW6FkMPjFbZ0tgsQ==
X-Received: by 2002:adf:8184:: with SMTP id 4mr18137139wra.27.1557748654814;
	Mon, 13 May 2019 04:57:34 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id z5sm5238554wmi.34.2019.05.13.04.57.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 13 May 2019 04:57:33 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 14:57:28 +0300
Message-Id: <20190513115731.17588-1-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel]  [PATCH V3 0/3] ramfb improvements
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.williamson@redhat.com, kraxel@redhat.com, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please see the description in each patch.

Qiming, thanks for taking the time to upstream your patches!
Marcel

V2 - V3:
 - rebase to latest master
 - send as new series
 - use QEMU coding conventions
 - fixed malformed patches (maybe I didn't import them right)

Hou Qiming (3):
  hw/display/ramfb: fix guest memory un-mapping
  hw/display/ramfb: lock guest resolution after it's set
  hw/display/ramfb: initialize fw-config space with xres/ yres

 hw/display/ramfb-standalone.c | 12 ++++-
 hw/display/ramfb.c            | 89 ++++++++++++++++++++++++++++-------
 hw/vfio/display.c             |  4 +-
 include/hw/display/ramfb.h    |  2 +-
 stubs/ramfb.c                 |  2 +-
 5 files changed, 88 insertions(+), 21 deletions(-)

-- 
2.17.1


