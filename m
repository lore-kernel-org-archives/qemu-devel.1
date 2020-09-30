Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F95C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617292075A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yl7t86h4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617292075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNTsa-0000Ah-Iv
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 00:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTn5-0000rQ-RB
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNTn4-0000Y3-0q
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601440349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0HkGlH/S1G8I1HloqL7saGuuP/XHnYpyYBQxvhdOfUY=;
 b=Yl7t86h4dNjyoX+loIigdFTsmQ69CwiKfMjgpDAf/Grp26J1dYHd7REd0nXUleE1vHiz5U
 UQS1j9gLx6XoxhaNEVi2aTlI/HGSUc06kwkjvN3Ykgh4M/Z0X3A65M84bkIYWtf2QvcOZu
 ImQtr0plvwmZyGN/RK1k/RNZXQY70Xk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-PgqQ_vkMPtulj1zkN6_ZjQ-1; Wed, 30 Sep 2020 00:32:25 -0400
X-MC-Unique: PgqQ_vkMPtulj1zkN6_ZjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A39081DDFE;
 Wed, 30 Sep 2020 04:32:24 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58E8573678;
 Wed, 30 Sep 2020 04:32:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/46] qapi: add pylintrc
Date: Wed, 30 Sep 2020 00:31:17 -0400
Message-Id: <20200930043150.1454766-14-jsnow@redhat.com>
In-Reply-To: <20200930043150.1454766-1-jsnow@redhat.com>
References: <20200930043150.1454766-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using `pylint --generate-rcfile > pylintrc`, generate a skeleton
pylintrc file. Sections that are not presently relevant (by the end of
this series) are removed leaving just the empty section as a search
engine / documentation hint to future authors.

I am targeting pylint 2.6.0. In the future (and hopefully before 5.2 is
released), I aim to have gitlab CI running the specific targeted
versions of pylint, mypy, flake8, etc in a job.

2.5.x will work if you additionally pass --disable=bad-whitespace.
This warning was removed from 2.6.x, for lack of consistent support.

Right now, quite a few modules are ignored as they are known to fail as
of this commit. modules will be removed from the known-bad list
throughout this and following series as they are repaired.

Note: Normally, pylintrc would go in the folder above the module, but as
that folder is shared by many things, it is going inside the module
folder (for now). Due to a bug in pylint 2.5+, pylint does not
correctly recognize when it is being run from "inside" a package, and
must be run *outside* of the package.

Therefore, to run it, you must:

 > pylint scripts/qapi/ --rcfile=scripts/qapi/pylintrc

Signed-off-by: John Snow <jsnow@redhat.com>
Tested-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/pylintrc | 73 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 scripts/qapi/pylintrc

diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
new file mode 100644
index 00000000000..76d54c30f85
--- /dev/null
+++ b/scripts/qapi/pylintrc
@@ -0,0 +1,73 @@
+[MASTER]
+
+# Add files or directories matching the regex patterns to the ignore list.
+# The regex matches against base names, not paths.
+ignore-patterns=common.py,
+                error.py,
+                expr.py,
+                gen.py,
+                parser.py,
+                schema.py,
+                source.py,
+                types.py,
+                visit.py,
+
+
+[MESSAGES CONTROL]
+
+# Disable the message, report, category or checker with the given id(s). You
+# can either give multiple identifiers separated by comma (,) or put this
+# option multiple times (only on the command line, not in the configuration
+# file where it should appear only once). You can also use "--disable=all" to
+# disable everything first and then reenable specific checks. For example, if
+# you want to run only the similarities checker, you can use "--disable=all
+# --enable=similarities". If you want to run only the classes checker, but have
+# no Warning level messages displayed, use "--disable=all --enable=classes
+# --disable=W".
+disable=fixme,
+        missing-docstring,
+        too-many-arguments,
+        too-many-branches,
+        too-many-statements,
+        too-many-instance-attributes,
+
+[REPORTS]
+
+[REFACTORING]
+
+[MISCELLANEOUS]
+
+[LOGGING]
+
+[BASIC]
+
+# Good variable names which should always be accepted, separated by a comma.
+good-names=i,
+           j,
+           k,
+           ex,
+           Run,
+           _
+
+[VARIABLES]
+
+[STRING]
+
+[SPELLING]
+
+[FORMAT]
+
+[SIMILARITIES]
+
+# Ignore import statements themselves when computing similarities.
+ignore-imports=yes
+
+[TYPECHECK]
+
+[CLASSES]
+
+[IMPORTS]
+
+[DESIGN]
+
+[EXCEPTIONS]
-- 
2.26.2


