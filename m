Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51023C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8E12146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 19:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8E12146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCqni-00072u-7J
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 15:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iCqkP-00058h-7m
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iCqkO-0004MT-0e
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:45:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iCqkN-0004ID-P9
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 15:45:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C57F8A1C82;
 Tue, 24 Sep 2019 19:45:13 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-0.rdu2.redhat.com
 [10.10.121.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C48B75D713;
 Tue, 24 Sep 2019 19:45:03 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] Acceptance tests: make better use of machine tags
Date: Tue, 24 Sep 2019 15:44:58 -0400
Message-Id: <20190924194501.9303-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 24 Sep 2019 19:45:13 +0000 (UTC)
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "arch" tags applied to acceptance tests, besides allowing a user
to select tests for one specific target architecture, also provides
the the feature of setting the arch to be used if none was given by a
parameter.

This series does the same thing for machine tags.  If a test is tagged
with "machine", its value will be set on the QEMUMachine instances
created/managed by the test.  Hopefully this will eliminate boiler
plate code, and make writing tests more straightforward.

Cleber Rosa (3):
  Acceptance test x86_cpu_model_versions: use default vm
  Acceptance tests: introduce utility method for tags unique vals
  Acceptance Tests: use avocado tags for machine type

 docs/devel/testing.rst                     |  18 +++
 tests/acceptance/avocado_qemu/__init__.py  |  24 +++-
 tests/acceptance/boot_linux_console.py     |  15 +--
 tests/acceptance/cpu_queries.py            |   2 +-
 tests/acceptance/linux_initrd.py           |   2 +-
 tests/acceptance/linux_ssh_mips_malta.py   |   5 -
 tests/acceptance/machine_m68k_nextcube.py  |  21 +---
 tests/acceptance/x86_cpu_model_versions.py | 137 ++++++++++++---------
 8 files changed, 122 insertions(+), 102 deletions(-)

--=20
2.21.0


