Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11701C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8FD206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh20qtoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8FD206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZvx-00052u-1u
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZOP-00041y-Hw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24858
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZON-0001wo-Rj
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCyRlcLsLgVaRXnU5SLsAruLHHDQZWjPTIPP8PG6N8w=;
 b=Gh20qtoemgV0udipwT1ig7coYYRtMOhSZpavhuHzCzXluJGTTwK6Tc93zymzZhoDhlcSHU
 3OTJSHe9jXII1yfMzr0fTZrWXOduPdGiQzp8pwN8r4z3LBkm1AOOz43BukJSmwMEInG1t4
 9fRgiLJiHwAE/Cez8CFkChpGFngbHcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-_40xnGk-MuKe-J7Bqb9zjQ-1; Wed, 17 Jun 2020 10:50:15 -0400
X-MC-Unique: _40xnGk-MuKe-J7Bqb9zjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6C28100CCCB;
 Wed, 17 Jun 2020 14:50:13 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACAFD7CAB0;
 Wed, 17 Jun 2020 14:50:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 42/43] iotests/{190,291}: compat=0.10 is unsupported
Date: Wed, 17 Jun 2020 16:49:08 +0200
Message-Id: <20200617144909.192176-43-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

From: Max Reitz <mreitz@redhat.com>

Fixes: 5d72c68b49769c927e90b78af6d90f6a384b26ac
Fixes: cf2d1203dcfc2bf964453d83a2302231ce77f2dc
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200617104822.27525-6-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/190 | 2 ++
 tests/qemu-iotests/291 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index fe630918e9..c22d8d64f9 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -41,6 +41,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # See 178 for more extensive tests across more formats
 _supported_fmt qcow2
 _supported_proto file
+# compat=0.10 does not support bitmaps
+_unsupported_imgopts 'compat=0.10'
 
 echo "== Huge file without bitmaps =="
 echo
diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
index 404f8521f7..28e4fb9b4d 100755
--- a/tests/qemu-iotests/291
+++ b/tests/qemu-iotests/291
@@ -39,6 +39,8 @@ _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
 _require_command QEMU_NBD
+# compat=0.10 does not support bitmaps
+_unsupported_imgopts 'compat=0.10'
 
 echo
 echo "=== Initial image setup ==="
-- 
2.25.4


