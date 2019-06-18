Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D472DC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE33E20673
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE33E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdG6O-00079e-SL
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 11:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40153)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hdFID-0004Ei-B8
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hdFIC-0001nK-9O
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:41:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hdFI8-0001W9-Li
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:40:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ECC5AA836;
 Tue, 18 Jun 2019 14:40:25 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AA537D506;
 Tue, 18 Jun 2019 14:40:25 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Date: Tue, 18 Jun 2019 11:40:13 -0300
Message-Id: <20190618144013.6537-3-ehabkost@redhat.com>
In-Reply-To: <20190618144013.6537-1-ehabkost@redhat.com>
References: <20190618144013.6537-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 18 Jun 2019 14:40:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] Travis: print acceptance tests logs in case
 of job failure
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

Because Travis doesn't allow us to keep files produced during tests
(such as log files), let's print the complete job log to the "console"
in case of job failures.

This is a debugging aid, and given that there's been some timeouts
happening on some tests, we absolutely needs the logs to have a proper
action.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20190607152223.9467-2-crosa@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 2f1658602e..aeb9b211cd 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -233,6 +233,8 @@ matrix:
     - env:
         - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-so=
ftmmu,alpha-softmmu"
         - TEST_CMD=3D"make check-acceptance"
+      after_failure:
+        - cat tests/results/latest/job.log
       addons:
         apt:
           packages:
--=20
2.18.0.rc1.1.g3f1ff2140


