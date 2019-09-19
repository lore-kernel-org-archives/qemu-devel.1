Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1FCC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F00C20644
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F00C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzID-0002cd-66
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 12:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iAzGx-0001NC-Nz
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iAzGv-0008WF-JP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:27:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iAzGv-0008Vm-EU
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:27:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A38F30860CF;
 Thu, 19 Sep 2019 16:27:08 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-123-8.rdu2.redhat.com
 [10.10.123.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 388405D9CC;
 Thu, 19 Sep 2019 16:27:00 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/2] Python (acceptance tests) queue, 2019-09-19
Date: Thu, 19 Sep 2019 12:26:56 -0400
Message-Id: <20190919162658.27442-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 19 Sep 2019 16:27:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f8c3db33a5e863291182f8862ddf81618a7c61=
94:

  target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:=
00 +0100)

are available in the Git repository at:

  git://github.com/clebergnu/qemu.git tags/python-next-pull-request

for you to fetch changes up to 471c97a6938bda16f6e10e33437d96241482f580:

  BootLinuxSshTest: Only run the tests when explicitly requested (2019-09=
-19 09:53:39 -0400)

----------------------------------------------------------------

These are simple usability fixes for running acceptance tests on
non-x86 hosts, and were tested primarily on ppc64le.

----------------------------------------------------------------

David Gibson (1):
  tests/acceptance: Specify arch for QueryCPUModelExpansion

Philippe Mathieu-Daud=C3=A9 (1):
  BootLinuxSshTest: Only run the tests when explicitly requested

 tests/acceptance/cpu_queries.py          |  3 +++
 tests/acceptance/linux_ssh_mips_malta.py | 10 +++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

--=20
2.21.0


