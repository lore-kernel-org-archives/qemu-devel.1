Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38E6C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC2F214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC2F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58372 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiaL-00021r-VU
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34051)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfiUo-0005qA-7g
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfiUm-0007Uh-Uc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:16:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfiUm-00074G-PM
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:16:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C97D368E6;
 Tue, 25 Jun 2019 10:15:41 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF73A5D70D;
 Tue, 25 Jun 2019 10:15:26 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 12:15:19 +0200
Message-Id: <20190625101524.13447-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 25 Jun 2019 10:15:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/5] tests/acceptance: Add bFLT loader
 linux-user test
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series refactor the current avocado_qemu Test class to allow
MachineTest and LinuxUserTest classes.
We can then add linux-user tests.
A simple/quick one is added as example, it runs a STM32 busybox
binary (in the bFLT format) on Travis-CI.
The same test can be used to confirm LP bug 1833668 [*] is fixed.

Regards,

Phil.

[*] https://bugs.launchpad.net/qemu/+bug/1833668

Philippe Mathieu-Daud=C3=A9 (5):
  tests/acceptance: Rename avocado_qemu.Test as MachineTest
  tests/acceptance: Make pick_default_qemu_bin() more generic
  tests/acceptance: Introduce LinuxUserTest base class
  tests/acceptance: Add bFLT loader linux-user test
  .travis.yml: Let the avocado job run linux-user tests

 .travis.yml                               |  2 +-
 docs/devel/testing.rst                    |  8 ++--
 tests/acceptance/avocado_qemu/__init__.py | 26 +++++++++---
 tests/acceptance/boot_linux_console.py    |  4 +-
 tests/acceptance/cpu_queries.py           |  4 +-
 tests/acceptance/empty_cpu_model.py       |  4 +-
 tests/acceptance/linux_initrd.py          |  4 +-
 tests/acceptance/linux_ssh_mips_malta.py  |  4 +-
 tests/acceptance/load_bflt.py             | 52 +++++++++++++++++++++++
 tests/acceptance/migration.py             |  4 +-
 tests/acceptance/version.py               |  4 +-
 tests/acceptance/virtio_version.py        |  4 +-
 tests/acceptance/vnc.py                   |  4 +-
 13 files changed, 95 insertions(+), 29 deletions(-)
 create mode 100644 tests/acceptance/load_bflt.py

--=20
2.20.1


