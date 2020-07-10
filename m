Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A37C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06B520767
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKBfgPq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06B520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtw5m-00034m-8Q
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jtw0D-0001z0-An
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:35:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38414
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jtw0B-0000B9-PE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594398955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B0WA5cXZ1Z4wsOqNvn5OZV4PqMHW3J2C73QzCZtU1HQ=;
 b=eKBfgPq2RRndxiZYVk72CwcRmFZDtEMRAbSkmW5vmBs2pfScuHMsXbpBT8uJEJvXBHDDwG
 p00/YO4AvDs+Lhby20EA8XrNMNTH5JnEnmJ0BPGOyoCzxHVaHC2Z5L+z1yKoq8bMLbn1Ka
 Dd5yd+UAerRkiO1/Rs3XTgfFLjppP94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-STbG8QuyMUWWq0Etc-qXMQ-1; Fri, 10 Jul 2020 12:35:53 -0400
X-MC-Unique: STbG8QuyMUWWq0Etc-qXMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26F21800685;
 Fri, 10 Jul 2020 16:35:52 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-178.phx2.redhat.com [10.3.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD04C610F3;
 Fri, 10 Jul 2020 16:35:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] fixup! qemu-img: Deprecate use of -b without -F
Date: Fri, 10 Jul 2020 11:35:49 -0500
Message-Id: <20200710163549.1202360-1-eblake@redhat.com>
In-Reply-To: <20200709121713.283092-1-kwolf@redhat.com>
References: <20200709121713.283092-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Port to BSD truncate.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/114 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index 143683381334..d0609c499388 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -45,7 +45,7 @@ _unsupported_imgopts data_file
 # Intentionally specify backing file without backing format; demonstrate
 # the difference in warning messages when backing file could be probed.
 # Note that only a non-raw probe result will affect the resulting image.
-truncate --size=64M "$TEST_IMG.orig"
+truncate -s $((64 * 1024 * 1024)) "$TEST_IMG.orig"
 _make_test_img -b "$TEST_IMG.orig" 64M

 TEST_IMG="$TEST_IMG.base" _make_test_img 64M
-- 
2.27.0


