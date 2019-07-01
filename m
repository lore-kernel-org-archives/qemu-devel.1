Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C70C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA51206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA51206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8MI-0004bl-9U
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33865)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hi4of-0005Fe-J1
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hi4ob-00008t-7P
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:30:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hi4oG-00087m-JZ; Mon, 01 Jul 2019 18:30:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A9E287FDF4;
 Mon,  1 Jul 2019 22:29:19 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B5E818386;
 Mon,  1 Jul 2019 22:29:13 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Date: Mon,  1 Jul 2019 19:29:08 -0300
Message-Id: <20190701222912.4703-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 01 Jul 2019 22:29:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/4] Python queue, 2019-07-01
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7=
c6:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull=
-request' into staging (2019-07-01 17:40:32 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/python-next-pull-request

for you to fetch changes up to e5abf59eae5990296c243202f95f801495c52e76:

  Deprecate Python 2 support (2019-07-01 19:02:10 -0300)

----------------------------------------------------------------
Python queue, 2019-07-01

* Deprecate Python 2 support (Eduardo Habkost)
* qemu/__init__.py refactor (John Snow)
* make qmp-shell work with python3 (Igor Mammedov)

----------------------------------------------------------------

Eduardo Habkost (1):
  Deprecate Python 2 support

Igor Mammedov (1):
  qmp: make qmp-shell work with python3

John Snow (2):
  python/qemu: split QEMUMachine out from underneath __init__.py
  machine.py: minor delinting

 configure                                 |   8 +
 scripts/render_block_graph.py             |   2 +-
 python/qemu/__init__.py                   | 502 +-------------------
 python/qemu/machine.py                    | 531 ++++++++++++++++++++++
 python/qemu/qtest.py                      |   2 +-
 qemu-deprecated.texi                      |   8 +
 scripts/device-crash-test                 |   2 +-
 scripts/qmp/qmp-shell                     |   5 +-
 tests/acceptance/avocado_qemu/__init__.py |   2 +-
 tests/acceptance/virtio_version.py        |   2 +-
 tests/migration/guestperf/engine.py       |  24 +-
 tests/qemu-iotests/235                    |   2 +-
 tests/vm/basevm.py                        |   3 +-
 13 files changed, 572 insertions(+), 521 deletions(-)
 create mode 100644 python/qemu/machine.py

--=20
2.18.0.rc1.1.g3f1ff2140


