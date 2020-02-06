Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1672CC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2FDE21775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8K2bkJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FDE21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izoaB-0007gp-Px
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoYx-0006KT-F7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoYu-0007Mq-4E
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:19:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20684
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoYt-0007GT-VT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581023986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qk+v4vbkMWrps2ZNsYgY3IDjrc0V6md3Z05H/jIOKgw=;
 b=F8K2bkJ+AKQZa+Eu9tTUv9l8pWlCbBZY05efuAMHvxP5SiPjE2eOPhA9zkuYPcHcso+egp
 BDve0i0ODElYGFXp1K7oAIaYT7TuXxLg2mUmj9/SMA/wla7QO9rJIwwsonS4pvDeXrjmGC
 RCf7MdSnZzE+FPG93sMDNRlZ1osC+Hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-k7VdWJmEMziWshOLSGnYdw-1; Thu, 06 Feb 2020 16:19:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4019140C
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 21:19:43 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79C1D60BEC;
 Thu,  6 Feb 2020 21:19:38 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/46] Python queue 2020-02-06
Date: Thu,  6 Feb 2020 22:18:50 +0100
Message-Id: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: k7VdWJmEMziWshOLSGnYdw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

I prepared this series on behalf of Eduardo and
Cleber (one of them will ack this cover).

Regards,

Phil.

The following changes since commit 418fa86dd465b4fd8394373cf83db8fa65d7611c=
:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-040220-1'=
 into staging (2020-02-04 18:55:06 +0000)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/python-next-20200206

for you to fetch changes up to 3e3481a5df933a26b47f08e5913821672d28d308:

  .readthedocs.yml: specify some minimum python requirements (2020-02-06 21=
:48:24 +0100)

----------------------------------------------------------------

- Python 3 cleanups:
  . Remove text about Python 2 in qemu-deprecated (Thomas)
  . Remove shebang header (Paolo, Philippe)
  . scripts/checkpatch.pl now allows Python 3 interpreter (Philippe)
  . Explicit usage of Python 3 interpreter in scripts (Philippe)
  . Fix Python scripts permissions (Paolo, Philippe)
  . Drop 'from __future__ import print_function' (Paolo)
  . Specify minimum python requirements in ReadTheDocs configuration (Alex)
- Test UNIX/EXEC transports with migration (Oksana)
- Added extract_from_rpm helper, improved extract_from_deb (Liam)
- Allow to use other serial consoles than default one (Philippe)
- Various improvements in QEMUMonitorProtocol (Wainer)
- Fix kvm_available() on ppc64le (Wainer)

----------------------------------------------------------------

Alex Benn=C3=A9e (1):
  .readthedocs.yml: specify some minimum python requirements

Denis Plotnikov (1):
  tests: rename virtio_seg_max_adjust to virtio_check_params

Liam Merwick (4):
  travis.yml: install rpm2cpio for acceptance tests
  tests/boot_linux_console: add extract_from_rpm method
  tests/boot_linux_console: use os.path for filesystem paths
  tests/boot_linux_console: fix extract_from_deb() comment

Luk=C3=A1=C5=A1 Doktor (1):
  python: Treat None-return of greeting cmd

Oksana Vohchana (4):
  tests/acceptance/migration: Factor out assert_migration()
  tests/acceptance/migration: Factor out do_migrate()
  tests/acceptance/migration: Test UNIX transport when migrating
  tests/acceptance/migration: Test EXEC transport when migrating

Paolo Bonzini (3):
  scripts/signrom: remove Python 2 support, add shebang
  make all Python scripts executable
  drop "from __future__ import print_function"

Philippe Mathieu-Daud=C3=A9 (24):
  python/qemu/machine: Allow to use other serial consoles than default
  Acceptance tests: Extract _console_interaction()
  Acceptance tests: Add interrupt_interactive_console_until_pattern()
  tests/boot_linux_console: Tag Emcraft Smartfusion2 as running 'u-boot'
  tests/acceptance/virtio_check_params: Improve exception logging
  tests/acceptance/virtio_check_params: List machine being tested
  tests/acceptance/virtio_check_params: Default to -nodefaults
  tests/acceptance/virtio_check_params: Disable the test
  tests/acceptance/boot_linux_console: Do not use VGA on Clipper machine
  tests/acceptance/version: Default to -nodefaults
  tests/acceptance/migration: Add the 'migration' tag
  tests/acceptance/migration: Default to -nodefaults
  scripts/checkpatch.pl: Only allow Python 3 interpreter
  tests/qemu-iotests/check: Allow use of python3 interpreter
  tests/qemu-iotests: Explicit usage of Python 3 (scripts with __main__)
  tests: Explicit usage of Python 3
  scripts: Explicit usage of Python 3 (scripts with __main__)
  scripts/minikconf: Explicit usage of Python 3
  scripts/tracetool: Remove shebang header
  tests/acceptance: Remove shebang header
  tests/vm: Remove shebang header
  tests/qemu-iotests: Explicit usage of Python3 (scripts without
    __main__)
  scripts: Explicit usage of Python 3 (scripts without __main__)
  tests/qemu-iotests/check: Only check for Python 3 interpreter

Thomas Huth (2):
  qemu-deprecated: Remove text about Python 2
  tests/acceptance: Add boot tests for some of the QEMU advent calendar
    images

Wainer dos Santos Moschetta (6):
  python/qemu: qmp: Replace socket.error with OSError
  python/qemu: Delint the qmp module
  python/qemu: qmp: Make accept()'s timeout configurable
  python/qemu: qmp: Make QEMUMonitorProtocol a context manager
  python/qemu: qmp: Remove unnused attributes
  python/qemu: accel: Fix kvm_available() on ppc64le

 qemu-deprecated.texi                          |   8 --
 .readthedocs.yml                              |  20 +++
 .travis.yml                                   |   3 +-
 python/qemu/accel.py                          |   3 +-
 python/qemu/machine.py                        |  10 +-
 python/qemu/qmp.py                            |  99 ++++++++++----
 scripts/analyse-9p-simpletrace.py             |   3 +-
 scripts/analyse-locks-simpletrace.py          |   3 +-
 scripts/checkpatch.pl                         |   6 +
 scripts/decodetree.py                         |   2 +-
 scripts/device-crash-test                     |   3 +-
 scripts/dump-guest-memory.py                  |   1 -
 scripts/kvm/kvm_flightrecorder                |   3 +-
 scripts/kvm/vmxcap                            |   1 -
 scripts/minikconf.py                          |   2 +-
 scripts/modules/module_block.py               |   1 -
 scripts/qapi-gen.py                           |   3 +-
 scripts/qapi/doc.py                           |   1 -
 scripts/qmp/qemu-ga-client                    |   3 +-
 scripts/qmp/qmp                               |   3 +-
 scripts/qmp/qmp-shell                         |   3 +-
 scripts/qmp/qom-fuse                          |   2 +-
 scripts/qmp/qom-get                           |   1 -
 scripts/qmp/qom-list                          |   1 -
 scripts/qmp/qom-set                           |   1 -
 scripts/qmp/qom-tree                          |   1 -
 scripts/render_block_graph.py                 |   2 +-
 scripts/replay-dump.py                        |   3 +-
 scripts/signrom.py                            |  11 +-
 scripts/simpletrace.py                        |   3 +-
 scripts/tracetool.py                          |   2 +-
 scripts/tracetool/__init__.py                 |   1 -
 scripts/tracetool/backend/__init__.py         |   1 -
 scripts/tracetool/backend/dtrace.py           |   1 -
 scripts/tracetool/backend/ftrace.py           |   1 -
 scripts/tracetool/backend/log.py              |   1 -
 scripts/tracetool/backend/simple.py           |   1 -
 scripts/tracetool/backend/syslog.py           |   1 -
 scripts/tracetool/backend/ust.py              |   1 -
 scripts/tracetool/format/__init__.py          |   1 -
 scripts/tracetool/format/c.py                 |   1 -
 scripts/tracetool/format/d.py                 |   1 -
 scripts/tracetool/format/h.py                 |   1 -
 scripts/tracetool/format/log_stap.py          |   1 -
 scripts/tracetool/format/simpletrace_stap.py  |   1 -
 scripts/tracetool/format/stap.py              |   1 -
 scripts/tracetool/format/tcg_h.py             |   1 -
 scripts/tracetool/format/tcg_helper_c.py      |   1 -
 scripts/tracetool/format/tcg_helper_h.py      |   1 -
 .../tracetool/format/tcg_helper_wrapper_h.py  |   1 -
 scripts/tracetool/format/ust_events_c.py      |   1 -
 scripts/tracetool/format/ust_events_h.py      |   1 -
 scripts/tracetool/transform.py                |   1 -
 scripts/tracetool/vcpu.py                     |   1 -
 scripts/vmstate-static-checker.py             |   3 +-
 tests/acceptance/avocado_qemu/__init__.py     |  59 +++++++--
 tests/acceptance/boot_linux_console.py        | 124 +++++++++++++++++-
 tests/acceptance/migration.py                 |  57 +++++---
 tests/acceptance/version.py                   |   1 +
 ...g_max_adjust.py =3D> virtio_check_params.py} |  16 ++-
 tests/acceptance/x86_cpu_model_versions.py    |   1 -
 tests/docker/travis.py                        |   3 +-
 tests/guest-debug/test-gdbstub.py             |   1 -
 tests/migration/guestperf/engine.py           |   1 -
 tests/migration/guestperf/plot.py             |   1 -
 tests/migration/guestperf/shell.py            |   1 -
 tests/qapi-schema/test-qapi.py                |   3 +-
 tests/qemu-iotests/030                        |   2 +-
 tests/qemu-iotests/040                        |   2 +-
 tests/qemu-iotests/041                        |   2 +-
 tests/qemu-iotests/044                        |   2 +-
 tests/qemu-iotests/045                        |   2 +-
 tests/qemu-iotests/055                        |   2 +-
 tests/qemu-iotests/056                        |   2 +-
 tests/qemu-iotests/057                        |   2 +-
 tests/qemu-iotests/065                        |   2 +-
 tests/qemu-iotests/093                        |   2 +-
 tests/qemu-iotests/096                        |   2 +-
 tests/qemu-iotests/118                        |   2 +-
 tests/qemu-iotests/124                        |   2 +-
 tests/qemu-iotests/129                        |   2 +-
 tests/qemu-iotests/132                        |   2 +-
 tests/qemu-iotests/136                        |   2 +-
 tests/qemu-iotests/139                        |   2 +-
 tests/qemu-iotests/147                        |   2 +-
 tests/qemu-iotests/148                        |   2 +-
 tests/qemu-iotests/149                        |   3 +-
 tests/qemu-iotests/151                        |   2 +-
 tests/qemu-iotests/152                        |   2 +-
 tests/qemu-iotests/155                        |   2 +-
 tests/qemu-iotests/163                        |   2 +-
 tests/qemu-iotests/165                        |   3 +-
 tests/qemu-iotests/169                        |   2 +-
 tests/qemu-iotests/194                        |   2 +-
 tests/qemu-iotests/196                        |   2 +-
 tests/qemu-iotests/199                        |   2 +-
 tests/qemu-iotests/202                        |   2 +-
 tests/qemu-iotests/203                        |   2 +-
 tests/qemu-iotests/205                        |   2 +-
 tests/qemu-iotests/206                        |   2 +-
 tests/qemu-iotests/207                        |   2 +-
 tests/qemu-iotests/208                        |   2 +-
 tests/qemu-iotests/209                        |   2 +-
 tests/qemu-iotests/210                        |   2 +-
 tests/qemu-iotests/211                        |   2 +-
 tests/qemu-iotests/212                        |   2 +-
 tests/qemu-iotests/213                        |   2 +-
 tests/qemu-iotests/216                        |   2 +-
 tests/qemu-iotests/218                        |   2 +-
 tests/qemu-iotests/219                        |   2 +-
 tests/qemu-iotests/222                        |   2 +-
 tests/qemu-iotests/224                        |   2 +-
 tests/qemu-iotests/228                        |   2 +-
 tests/qemu-iotests/234                        |   2 +-
 tests/qemu-iotests/235                        |   2 +-
 tests/qemu-iotests/236                        |   2 +-
 tests/qemu-iotests/237                        |   2 +-
 tests/qemu-iotests/238                        |   2 +-
 tests/qemu-iotests/242                        |   2 +-
 tests/qemu-iotests/245                        |   2 +-
 tests/qemu-iotests/246                        |   2 +-
 tests/qemu-iotests/248                        |   2 +-
 tests/qemu-iotests/254                        |   2 +-
 tests/qemu-iotests/255                        |   2 +-
 tests/qemu-iotests/256                        |   2 +-
 tests/qemu-iotests/257                        |   2 +-
 tests/qemu-iotests/258                        |   2 +-
 tests/qemu-iotests/260                        |   2 +-
 tests/qemu-iotests/262                        |   2 +-
 tests/qemu-iotests/264                        |   2 +-
 tests/qemu-iotests/266                        |   2 +-
 tests/qemu-iotests/277                        |   2 +-
 tests/qemu-iotests/280                        |   2 +-
 tests/qemu-iotests/281                        |   2 +-
 tests/qemu-iotests/check                      |   2 +-
 tests/qemu-iotests/iotests.py                 |   1 -
 tests/qemu-iotests/nbd-fault-injector.py      |   3 +-
 tests/qemu-iotests/qcow2.py                   |   3 +-
 tests/qemu-iotests/qed.py                     |   3 +-
 tests/vm/basevm.py                            |   2 -
 tests/vm/centos                               |   2 +-
 tests/vm/fedora                               |   2 +-
 tests/vm/freebsd                              |   2 +-
 tests/vm/netbsd                               |   2 +-
 tests/vm/openbsd                              |   2 +-
 tests/vm/ubuntu.i386                          |   2 +-
 146 files changed, 431 insertions(+), 233 deletions(-)
 create mode 100644 .readthedocs.yml
 mode change 100644 =3D> 100755 scripts/minikconf.py
 mode change 100644 =3D> 100755 scripts/signrom.py
 rename tests/acceptance/{virtio_seg_max_adjust.py =3D> virtio_check_params=
.py} (90%)
 mode change 100755 =3D> 100644
 mode change 100644 =3D> 100755 tests/qemu-iotests/222
 mode change 100644 =3D> 100755 tests/qemu-iotests/245
 mode change 100755 =3D> 100644 tests/vm/basevm.py

--=20
2.21.1


