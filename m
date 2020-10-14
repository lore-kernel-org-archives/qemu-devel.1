Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED725C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E7D212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbE/Socd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E7D212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShvP-0005P7-Nb
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kShnb-0004i4-Se
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:30:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kShnW-0005hP-9V
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602685833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E3NHgH3d9qhP9kacPIeOuw4V9zMO7jc2KDOxJfQ7kNk=;
 b=TbE/Socd75c7OQHPjFIfR6t/9FAZzMXhuq7qwhxihswjeXb8HiSYB9zbWBEpWWMI1SwSpZ
 IUOImfPxjBp53D79X2NiSOtJk8u77u4Q7iVOkUt+DttER9WY0H7JY//Uw9O3FiZFSTbFNE
 +mWWBRhBQaL/Z9HgztgxBQjduUIlaGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-PXR7pZREPFWQ4uY2Of8XRA-1; Wed, 14 Oct 2020 10:30:30 -0400
X-MC-Unique: PXR7pZREPFWQ4uY2Of8XRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25119ADC22;
 Wed, 14 Oct 2020 14:30:28 +0000 (UTC)
Received: from scv.redhat.com (ovpn-117-231.rdu2.redhat.com [10.10.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D06C76649;
 Wed, 14 Oct 2020 14:30:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/15] python: move pylintrc into setup.cfg
Date: Wed, 14 Oct 2020 10:29:49 -0400
Message-Id: <20201014142957.763624-8-jsnow@redhat.com>
In-Reply-To: <20201014142957.763624-1-jsnow@redhat.com>
References: <20201014142957.763624-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben@bwidawsk.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Delete the empty settings now that it's sharing a home with settings for
other tools.

pylint can now be run from this folder as "pylint qemu".
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/core/pylintrc | 58 ---------------------------------------
 python/setup.cfg          | 29 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 58 deletions(-)
 delete mode 100644 python/qemu/core/pylintrc

diff --git a/python/qemu/core/pylintrc b/python/qemu/core/pylintrc
deleted file mode 100644
index 3f69205000..0000000000
--- a/python/qemu/core/pylintrc
+++ /dev/null
@@ -1,58 +0,0 @@
-[MASTER]
-
-[MESSAGES CONTROL]
-
-# Disable the message, report, category or checker with the given id(s). You
-# can either give multiple identifiers separated by comma (,) or put this
-# option multiple times (only on the command line, not in the configuration
-# file where it should appear only once). You can also use "--disable=all" to
-# disable everything first and then reenable specific checks. For example, if
-# you want to run only the similarities checker, you can use "--disable=all
-# --enable=similarities". If you want to run only the classes checker, but have
-# no Warning level messages displayed, use "--disable=all --enable=classes
-# --disable=W".
-disable=too-many-arguments,
-        too-many-instance-attributes,
-        too-many-public-methods,
-
-[REPORTS]
-
-[REFACTORING]
-
-[MISCELLANEOUS]
-
-[LOGGING]
-
-[BASIC]
-
-# Good variable names which should always be accepted, separated by a comma.
-good-names=i,
-           j,
-           k,
-           ex,
-           Run,
-           _,
-           fd,
-           c,
-[VARIABLES]
-
-[STRING]
-
-[SPELLING]
-
-[FORMAT]
-
-[SIMILARITIES]
-
-# Ignore imports when computing similarities.
-ignore-imports=yes
-
-[TYPECHECK]
-
-[CLASSES]
-
-[IMPORTS]
-
-[DESIGN]
-
-[EXCEPTIONS]
diff --git a/python/setup.cfg b/python/setup.cfg
index 260f7f4e94..a65802d85e 100755
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -17,3 +17,32 @@ classifiers =
 [options]
 python_requires = >= 3.6
 packages = find_namespace:
+
+[pylint.messages control]
+# Disable the message, report, category or checker with the given id(s). You
+# can either give multiple identifiers separated by comma (,) or put this
+# option multiple times (only on the command line, not in the configuration
+# file where it should appear only once). You can also use "--disable=all" to
+# disable everything first and then reenable specific checks. For example, if
+# you want to run only the similarities checker, you can use "--disable=all
+# --enable=similarities". If you want to run only the classes checker, but have
+# no Warning level messages displayed, use "--disable=all --enable=classes
+# --disable=W".
+disable=too-many-arguments,
+        too-many-instance-attributes,
+        too-many-public-methods,
+
+[pylint.basic]
+# Good variable names which should always be accepted, separated by a comma.
+good-names=i,
+           j,
+           k,
+           ex,
+           Run,
+           _,
+           fd,
+           c,
+
+[pylint.similarities]
+# Ignore imports when computing similarities.
+ignore-imports=yes
-- 
2.26.2


