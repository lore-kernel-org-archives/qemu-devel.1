Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34EFC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784FA207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784FA207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAu0g-0006Ah-NU
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAtzw-0005ht-Sc
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAtzv-0004Yg-Q4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:49:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55128)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAtzv-0004YL-KS
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:49:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ADF7C4E4E6
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:49:14 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-74.brq.redhat.com [10.40.204.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44589608C2;
 Thu, 19 Sep 2019 10:49:09 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 12:49:07 +0200
Message-Id: <20190919104907.18005-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 19 Sep 2019 10:49:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] util/qemu-option: Document the get_opt_value()
 function
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity noticed commit 950c4e6c94 introduced a dereference before
null check in get_opt_value (CID1391003):

  In get_opt_value: All paths that lead to this null pointer
  comparison already dereference the pointer earlier (CWE-476)

We fixed this in commit 6e3ad3f0e31, but relaxed the check in commit
0c2f6e7ee99 because "No callers of get_opt_value() pass in a NULL
for the 'value' parameter".

Since this function is publicly exposed, it risks new users to do
the same error again. Avoid that documenting the 'value' argument
must not be NULL.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/qemu/option.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index 844587cab3..141d6a883d 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -28,6 +28,18 @@
=20
 #include "qemu/queue.h"
=20
+/**
+ * get_opt_value
+ * @p: a pointer to the option name, delimited by commas
+ * @value: a non-NULL pointer that will received the delimited options
+ *
+ * The @value char pointer will be allocated and filled with
+ * the delimited options.
+ * It is an error to pass a non-NULL @value parameter.
+ *
+ * Returns the position of the comma delimiter/zero byte after the
+ * option name in @p.
+ */
 const char *get_opt_value(const char *p, char **value);
=20
 void parse_option_size(const char *name, const char *value,
--=20
2.20.1


