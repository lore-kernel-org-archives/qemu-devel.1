Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2CBC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61730205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZG/TUQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61730205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCVWe-0001s4-L4
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 17:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCVW4-0001Rp-5c
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCVW3-00089t-4H
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:37:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26429
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCVW3-00089g-0f
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584049038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XSLtg8+/hwx1FP2CBxks339VRaKsowB8UJ+IEyCg+AA=;
 b=eZG/TUQu2o53RDvWURyyBifJSFBw4Fg3oHXhHne0l5YRCgIKY9E3tzNX6s6A7DgTa2RLyz
 7YfAopBmpje4CTFq25hf/JXXFzabHDDBo9Zh0iLrbALAy1+667OnXxtTdQCtTCiBHygdA3
 zY2UQVYFYWK7cU7ox6mLI98PisalicY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-uIKBFSEZPzSDJKDyoEjjSA-1; Thu, 12 Mar 2020 17:37:17 -0400
X-MC-Unique: uIKBFSEZPzSDJKDyoEjjSA-1
Received: by mail-wr1-f72.google.com with SMTP id z16so3215818wrm.15
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 14:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iZUKff7bmGNZbqvkRQLIUE/XadVZPiKqPEvIfB3p32I=;
 b=CImU7tttO1PFaMPU28CGNiGLMzTbrc9iB5pV386nWzL4B1wzPZAth592UwNYFLlj98
 ISxYtRNlC36dDa9nNrHFBpgx768oS09/rqHtDdatkAp1uq/timwIocqMr6gwFxaNu2y2
 9o5DbVxcEmX9mj5nP/Fvae7AVQwyv7/YCAcqafyx7Qh2tcqTlQyrJ9SCH5jR2VuzS1d6
 vzha/hTrWZrbQ3PC4QUHp1AUw/yO9cHmvc3Jta2tWr3tIEJvVK+xYxBDLiUImaf2g6OS
 w7iylhjm1ypNfycGpUBIl0c+BimloLOHYWR40M0cX8GilbWwONMExjKOEpoXbxo4C8fw
 p2Hg==
X-Gm-Message-State: ANhLgQ3rvYAf28lTqPAKVhAkT5XFV60hWkS6mOewziRsbH4ex9fRpP8q
 /MFO85v+YqMHIFLMocxMmGoRuTY9LU6eFtEKM9RsZvhnhkyUbB+yrrARz+GNuuYz4joj4pfVq7m
 ADVhqjHxPGZG5xNk=
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr6733019wmb.8.1584049035003;
 Thu, 12 Mar 2020 14:37:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtd0yGnGm0j4uXuLvbdgZXGwh6gr9Wf+xTcZI6WAYwHyxl0mErLyTBBjS7yHzgjc26dzsQXRw==
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr6732996wmb.8.1584049034613;
 Thu, 12 Mar 2020 14:37:14 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id p10sm75905122wrx.81.2020.03.12.14.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 14:37:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/isa/superio: Correct the license text
Date: Thu, 12 Mar 2020 22:37:12 +0100
Message-Id: <20200312213712.16671-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The license is the 'GNU General Public License v2.0 or later',
not 'and':

  This program is free software; you can redistribute it and/ori
  modify it under the terms of the GNU General Public License as
  published by the Free Software Foundation; either version 2 of
  the License, or (at your option) any later version.

Fix the license comment.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/isa/superio.h   | 2 +-
 hw/isa/isa-superio.c       | 2 +-
 hw/isa/smc37c669-superio.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index b151dcd753..147cc0a7b7 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
  * See the COPYING file in the top-level directory.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index c4e391916c..180a8b9625 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2011-2012 Andreas F=C3=A4rber
  * Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
  * See the COPYING file in the top-level directory.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
index 901a9f8e65..18287741cb 100644
--- a/hw/isa/smc37c669-superio.c
+++ b/hw/isa/smc37c669-superio.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2018 Philippe Mathieu-Daud=C3=A9
  *
- * This code is licensed under the GNU GPLv2 and later.
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
  * See the COPYING file in the top-level directory.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
--=20
2.21.1


