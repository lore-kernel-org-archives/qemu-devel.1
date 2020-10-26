Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CD5C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D050922242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaRk4O9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D050922242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzdr-0006W8-OW
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPP-00036S-2r
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPN-0006nc-2u
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEYlJQc8unISlHVYrQcVwNIoZboimZpudB3FA//629w=;
 b=VaRk4O9O5mIgAKEtbSjNatwJqCXr4+y5DKaZ/BKfkg7dL1b8N6Yl71uqNP0Z9YHnJ5zgpH
 w/3NNYy3XHmGuqKVkcqa5YDMI5WdxPOKElM5UqoJ4FcTr3X+zeVP6XQZS04FjexayOpo56
 32Oe4SPL9FFJMpKvLJ3rddsTc04HEVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-Ze2GltQrPFKWkSzIN6G_2w-1; Mon, 26 Oct 2020 06:07:18 -0400
X-MC-Unique: Ze2GltQrPFKWkSzIN6G_2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1014A0C07;
 Mon, 26 Oct 2020 10:07:16 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4C108B840;
 Mon, 26 Oct 2020 10:07:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 27/31] test/acceptance: Remove the CONTINUOUS_INTEGRATION tags
Date: Mon, 26 Oct 2020 11:06:28 +0100
Message-Id: <20201026100632.212530-28-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are not running the acceptance tests on Travis anymore, so these
checks can be removed now.

Message-Id: <20201023073351.251332-3-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/acceptance/ppc_prep_40p.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_40p.py
index e82755c9cf..96ba13b894 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -22,7 +22,6 @@ class IbmPrep40pMachine(Test):
     # All rights reserved.
     # U.S. Government Users Restricted Rights - Use, duplication or disclosure
     # restricted by GSA ADP Schedule Contract with IBM Corp.
-    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_factory_firmware_and_netbsd(self):
         """
@@ -61,7 +60,6 @@ class IbmPrep40pMachine(Test):
         wait_for_console_pattern(self, '>> Memory: 192M')
         wait_for_console_pattern(self, '>> CPU type PowerPC,604')
 
-    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
     def test_openbios_and_netbsd(self):
         """
         :avocado: tags=arch:ppc
-- 
2.18.2


