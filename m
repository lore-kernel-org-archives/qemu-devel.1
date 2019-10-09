Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21A6C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B4421929
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B4421929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJPc-0008Ht-S0
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iIHw5-0007G9-Mx
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iIHw4-0003eZ-Ci
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:47:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iIHw1-0003d0-2w; Wed, 09 Oct 2019 15:47:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 43BB518CB904;
 Wed,  9 Oct 2019 19:47:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-151.rdu2.redhat.com
 [10.10.122.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 124311001DC0;
 Wed,  9 Oct 2019 19:47:42 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] qemu-iotests: remove bash shebang from library files
Date: Wed,  9 Oct 2019 15:47:37 -0400
Message-Id: <20191009194740.8079-2-crosa@redhat.com>
In-Reply-To: <20191009194740.8079-1-crosa@redhat.com>
References: <20191009194740.8079-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 09 Oct 2019 19:47:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Due to not being able to find a reason to have shebangs on files that
are not executable.

While at it, add a mode hint to emacs, which would be clueless or
plain wrong about these containing shell code.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/common.config  | 2 +-
 tests/qemu-iotests/common.filter  | 2 +-
 tests/qemu-iotests/common.nbd     | 3 +--
 tests/qemu-iotests/common.pattern | 2 +-
 tests/qemu-iotests/common.qemu    | 2 +-
 tests/qemu-iotests/common.rc      | 2 +-
 tests/qemu-iotests/common.tls     | 2 +-
 7 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common=
.config
index 9bd1a5a6fc..b85a6a6f96 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+# -*- emacs mode: sh -*-
 #
 # Copyright (C) 2009 Red Hat, Inc.
 # Copyright (c) 2000-2003,2006 Silicon Graphics, Inc.  All Rights Reserv=
ed.
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
index 9f418b4881..a0b52b0ac8 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+# -*- emacs mode: sh -*-
 #
 # Copyright (C) 2009 Red Hat, Inc.
 # Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nb=
d
index 24b01b60aa..a98d05d404 100644
--- a/tests/qemu-iotests/common.nbd
+++ b/tests/qemu-iotests/common.nbd
@@ -1,5 +1,4 @@
-#!/usr/bin/env bash
-# -*- shell-script-mode -*-
+# -*- emacs mode: sh -*-
 #
 # Helpers for NBD server related config
 #
diff --git a/tests/qemu-iotests/common.pattern b/tests/qemu-iotests/commo=
n.pattern
index 4f5e5bcea0..4028b32c54 100644
--- a/tests/qemu-iotests/common.pattern
+++ b/tests/qemu-iotests/common.pattern
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+# -*- emacs mode: sh -*-
 #
 # Copyright (C) 2009 Red Hat, Inc.
 #
diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.q=
emu
index 8d2021a7eb..66569f6bdd 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+# -*- emacs mode: sh -*-
 #
 # This allows for launching of multiple QEMU instances, with independent
 # communication possible to each instance.
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index e45cdfa66b..aa4a7fcc11 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+# -*- emacs mode: sh -*-
 #
 # Copyright (C) 2009 Red Hat, Inc.
 # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.tl=
s
index 54c331d7a5..759a3d6d71 100644
--- a/tests/qemu-iotests/common.tls
+++ b/tests/qemu-iotests/common.tls
@@ -1,4 +1,4 @@
-#!/usr/bin/env bash
+# -*- emacs mode: sh -*-
 #
 # Helpers for TLS related config
 #
--=20
2.21.0


