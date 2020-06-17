Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D2FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB8920897
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4f7W71p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB8920897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZy4-0007QE-TJ
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZOS-00049J-91
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20871
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZOP-0001xW-9V
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QBRyIk7B7xmT8l1t42vYAaOZtJ4LS49ba0oQDJ/xDdY=;
 b=P4f7W71pYRXnZg+rUl2WayEAar54TLbW0PkoKv4N5h6Z/GlgrAGwY84VzhcuOvZkzkkT+d
 Om3dWyrkJAjr4zcckT/mOHVHIn7yRCxIy2BqPh+FPEh4kYXWYQqd4em2h8TfBPOcamMYI4
 CxOK3KUCzJ3uz08A0zAvLHkSM2eM1LU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-gr3tsLZTPxSsQh31q23HHA-1; Wed, 17 Jun 2020 10:50:15 -0400
X-MC-Unique: gr3tsLZTPxSsQh31q23HHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8B32100CCCE;
 Wed, 17 Jun 2020 14:50:13 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEF977CAD9;
 Wed, 17 Jun 2020 14:50:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 43/43] iotests: Add copyright line in qcow2.py
Date: Wed, 17 Jun 2020 16:49:09 +0200
Message-Id: <20200617144909.192176-44-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

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
Message-Id: <20200609205944.3549240-1-eblake@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/qcow2.py        | 2 ++
 tests/qemu-iotests/qcow2_format.py | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 8c187e9a72..0910e6ac07 100755
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
index 0f65fd161d..cc432e7ae0 100644
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
2.25.4


