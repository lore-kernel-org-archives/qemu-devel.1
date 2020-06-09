Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032D2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF22206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hra+LfzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF22206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilRG-000237-0a
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 17:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilLj-0004mv-UY
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 17:00:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33707
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilLj-0006er-5v
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591736398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PMi+QVVtxtbqqz5H1Z6aFAZoS+iTz4UnfK/VKdImxfk=;
 b=Hra+LfzZUe1KbbOe2Kcwjjt3L8kNQgpN7WVPZYBdSu3kE2ZbFz+16rWMYT8bwo9jJJhszZ
 H1dfHLwfa4/EGQaTA3ijcXrdCclOPhd/ebmK9wuv/4eEi3sCg44zFI4bAANUARW2zBc1qd
 ehOtm1Fd2+HWnsdPO4JdiAVLCrQmYZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-ZWqlR1JHMp2O2xlK7R7UPQ-1; Tue, 09 Jun 2020 16:59:54 -0400
X-MC-Unique: ZWqlR1JHMp2O2xlK7R7UPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49DFF835B42;
 Tue,  9 Jun 2020 20:59:53 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5EAD1001901;
 Tue,  9 Jun 2020 20:59:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] iotests: Add copyright line in qcow2.py
Date: Tue,  9 Jun 2020 15:59:44 -0500
Message-Id: <20200609205944.3549240-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 16:46:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The file qcow2.py was originally contributed in 2012 by Kevin Wolf,
but was not given traditional boilerplate headers at the time.  The
missing license was just rectified (commit 16306a7b39) using the
project-default GPLv2+, but as Vladimir is not at Red Hat, he did not
add a Copyright line.  All earlier contributions have come from CC'd
authors, where all but Stefan used a Red Hat address at the time of
the contribution, and that copyright carries over to the split to
qcow2_format.py (d5262c7124).

CC: Kevin Wolf <kwolf@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>

---
Commit ids above assume my bitmaps pull request does not have to be respun...
Based-on: <20200609205245.3548257-1-eblake@redhat.com>
---
 tests/qemu-iotests/qcow2.py        | 2 ++
 tests/qemu-iotests/qcow2_format.py | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 8c187e9a7292..0910e6ac0705 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -2,6 +2,8 @@
 #
 # Manipulations with qcow2 image
 #
+# Copyright (C) 2012 Red Hat, Inc.
+#
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation; either version 2 of the License, or
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 0f65fd161d5b..cc432e7ae06c 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -1,6 +1,7 @@
 # Library for manipulations with qcow2 image
 #
 # Copyright (c) 2020 Virtuozzo International GmbH.
+# Copyright (C) 2012 Red Hat, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
-- 
2.27.0


