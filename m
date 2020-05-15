Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E172C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CDC20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXfHxPme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CDC20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZaFU-0006PL-9l
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjg-0003rP-07
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26980
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZjf-0002Un-2g
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYET/JmmLAnl/WTYWa1apJGjB/2lqVM4zBHV7dXbd7k=;
 b=YXfHxPme7g5ks6OfCR185kyj0n1xA+sGre/6Ceuyv0ZTeEK1gPcucFT9SjLxNGmkPg8ZQ9
 Ogz4n4Uw8gxO0HeowE5IdsZOr5Fah85JNZ+H605dMYT+F/OrVbLbxiGE7amD+m+2TeDn95
 VAhiGQjtxoZ+ZogUlreL0PjW/G1O9N8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-I3ZgNixwMP62oIOJbP119g-1; Fri, 15 May 2020 08:46:39 -0400
X-MC-Unique: I3ZgNixwMP62oIOJbP119g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65B5E835B40;
 Fri, 15 May 2020 12:46:38 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E1E52E024;
 Fri, 15 May 2020 12:46:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 49/51] iotests: log messages from notrun()
Date: Fri, 15 May 2020 14:45:19 +0200
Message-Id: <20200515124521.335403-50-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Shift the logging initialization up to occur prior to validation checks,
so that notrun() messages still get printed to console.

(Also, remove the "debugging messages active" message, because we don't
need to see that hundreds of times per iotest suite run.)

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20200514201614.19941-2-jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 1d7f6fd7cf..f20d90f969 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1168,18 +1168,17 @@ def execute_setup_common(supported_fmts: Sequence[str] = (),
         sys.stderr.write('Please run this test via the "check" script\n')
         sys.exit(os.EX_USAGE)
 
+    debug = '-d' in sys.argv
+    if debug:
+        sys.argv.remove('-d')
+    logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
+
     _verify_image_format(supported_fmts, unsupported_fmts)
     _verify_protocol(supported_protocols, unsupported_protocols)
     _verify_platform(supported=supported_platforms)
     _verify_cache_mode(supported_cache_modes)
     _verify_aio_mode(supported_aio_modes)
 
-    debug = '-d' in sys.argv
-    if debug:
-        sys.argv.remove('-d')
-    logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
-    logger.debug("iotests debugging messages active")
-
     return debug
 
 def execute_test(*args, test_function=None, **kwargs):
-- 
2.25.4


