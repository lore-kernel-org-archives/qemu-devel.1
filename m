Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD79C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D8F206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D8F206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslIr-0003Gs-41
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDo-0001NW-LC; Tue, 07 Jul 2020 06:53:08 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDm-0000MU-3F; Tue, 07 Jul 2020 06:53:08 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MJVY8-1kCV1h2rAO-00JsDq; Tue, 07 Jul 2020 12:53:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 5/7] util/qemu-option: Document the get_opt_value() function
Date: Tue,  7 Jul 2020 12:52:53 +0200
Message-Id: <20200707105255.362318-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707105255.362318-1-laurent@vivier.eu>
References: <20200707105255.362318-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9oCtGKpKKzsIv9cTlg4Q4qrtDD+02QyzdTAM7K0KJVjmwVgjIB0
 YjA4owjy/8K63CYlHSCMIxC6r/yqE5XDbEeXVauhjo21iJRiJ3bK9JOlYGohopklAhxsfOk
 8dRQjr7HKydHU9JCuyKSRFMmBN3O8TW26Rd9rPjBXRPWxLXSnXUMDRHTdvBh+BA6SaDvEP+
 VM74WGwV+r89243yE7uZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JYFHMDF+G0A=:TaUbJbDIIicS7n5Y8PEHW5
 M/bB2QL24al2GWCr2KY033XOQ4QGwGLfjk0PmvaQqDjekaGqA+en49XwI67ZpCKl1QTU1z98l
 DnkPuibI/MUMyuVfv1SI4J/lOw3gy49dRGuStuPt8irhad/3c3GgzNSjsXw2rJaA6cEqNG6a5
 bP3857t5PMPb/Ut5/WtWyLftvRLCcTz3qacfLNC16kJzRV1I7lgTZAKa+4IBkIYeXcNcbUYhp
 NIiJJNXeVZ8uTed0/+XTKQden+COptlpfUH47+ynuYeK/xdksIE6jifbGk40D8gWxv8tI+eIm
 UObfQRdhWdKR24JbnvMyBPa0YBYCBv/TZVpzf6NnIbAt00xvvU59Uq0Qsb+kQxXNL/87UEqp9
 g6+RT8rdV34KUBKfCSgOwMokmVwjrJpWaJbLboTyQOBhmX3qjoUg84fJ3T7LykJJVIay21Kzy
 VKpIEu8b5AXvQqTLqhIwYCox/WhXv2lYfivaieA/QRhCdCb2lznkU6uT9MtbrHuSBpra3/6VX
 HpO//6DJVakNgI5j1H2/x9t6ALwrxcn9FhBtr0XaHQVsSKCKODOUdSqY/A+rYQXvpzuybVdQp
 tgKalg9ntaIqRkuRlEQNDdNw5neThIO7/5Vpex8/wluXqhvTV4J11DKHY10SA7UHsr3InUiVe
 Q23o/MsDjb0kkteixJdotaO6rBlyuxgcF5JB/NxEeURPs+p1YONMOqH5ETk/KfNgB4hFtOgra
 bXzLob61mF8rbDGhwD+vG3i1syye7pg/AwxTf79mITTARnTmiEll5WL0WP5xxgkTvz73dc1M4
 JdBN/sYX0K29yEKb2L9bM+GVeQoQHEjPwjiLVpVPWGsi2JrSYotNyu57jRSmp7+0ZxFz+8Z
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

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

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200629070858.19850-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/qemu/option.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index eb4097889d52..ac50d257746a 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -28,6 +28,19 @@
 
 #include "qemu/queue.h"
 
+/**
+ * get_opt_value
+ * @p: a pointer to the option name, delimited by commas
+ * @value: a non-NULL pointer that will received the delimited options
+ *
+ * The @value char pointer will be allocated and filled with
+ * the delimited options.
+ *
+ * Returns the position of the comma delimiter/zero byte after the
+ * option name in @p.
+ * The memory pointer in @value must be released with a call to g_free()
+ * when no longer required.
+ */
 const char *get_opt_value(const char *p, char **value);
 
 void parse_option_size(const char *name, const char *value,
-- 
2.26.2


