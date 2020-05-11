Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EBAC54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544E72082E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+GDC1ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544E72082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBR7-0000C9-Bv
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYBPo-0007AR-KM
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:36:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYBPn-0000ty-UL
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589214987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wO+YUymWO2xZpEUK/rRoWwoysQCHu5X15XDv1KhBAJY=;
 b=U+GDC1qlj9c4CeuEuTcpowCzaUu46OffGgjX4oiFZZ2l54P0IxQOBbzftjLuMz/J8J5yq0
 9+2lTTmjb19ljUoRJnjm+WvNUR2jiVrx6wxO4IPgxN5hhQkdI/wGS5ez4u8LcvVCyg3b/i
 HfDo7jcV3R20NEW4/u/6txy9+1oeqss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-YRjM1LDFMU25D4LIRR-WmA-1; Mon, 11 May 2020 12:36:16 -0400
X-MC-Unique: YRjM1LDFMU25D4LIRR-WmA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 325EF8E5F1;
 Mon, 11 May 2020 16:35:41 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-142.ams2.redhat.com
 [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A6D05C1B5;
 Mon, 11 May 2020 16:35:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/2] iotests: Fix incomplete type declarations
Date: Mon, 11 May 2020 18:35:28 +0200
Message-Id: <20200511163529.349329-2-kwolf@redhat.com>
In-Reply-To: <20200511163529.349329-1-kwolf@redhat.com>
References: <20200511163529.349329-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to fix only a few places so that iotests.py can pass
mypy --disallow-incomplete-defs, which seems to be a desirable option to
have enabled in the long run.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 6c0e781af7..1d7f6fd7cf 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1040,7 +1040,7 @@ def _verify_cache_mode(supported_cache_modes: Sequence[str] = ()) -> None:
     if supported_cache_modes and (cachemode not in supported_cache_modes):
         notrun('not suitable for this cache mode: %s' % cachemode)
 
-def _verify_aio_mode(supported_aio_modes: Sequence[str] = ()):
+def _verify_aio_mode(supported_aio_modes: Sequence[str] = ()) -> None:
     if supported_aio_modes and (aiomode not in supported_aio_modes):
         notrun('not suitable for this aio mode: %s' % aiomode)
 
@@ -1087,7 +1087,8 @@ def skip_if_unsupported(required_formats=(), read_only=False):
     '''Skip Test Decorator
        Runs the test if all the required formats are whitelisted'''
     def skip_test_decorator(func):
-        def func_wrapper(test_case: QMPTestCase, *args, **kwargs):
+        def func_wrapper(test_case: QMPTestCase, *args: List[Any],
+                         **kwargs: Dict[str, Any]) -> None:
             if callable(required_formats):
                 fmts = required_formats(test_case)
             else:
@@ -1097,9 +1098,8 @@ def skip_if_unsupported(required_formats=(), read_only=False):
             if usf_list:
                 msg = f'{test_case}: formats {usf_list} are not whitelisted'
                 test_case.case_skip(msg)
-                return None
             else:
-                return func(test_case, *args, **kwargs)
+                func(test_case, *args, **kwargs)
         return func_wrapper
     return skip_test_decorator
 
-- 
2.25.3


