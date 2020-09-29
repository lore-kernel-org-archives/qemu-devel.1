Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4CFC47423
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBDF2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1ztcqGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBDF2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMF5-0005j4-RN
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6D-0001rZ-71
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM62-0003UN-Ns
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RAh/+Z79QZE+7tQXu1BHzxDmVPA050uB6hwncY90Umk=;
 b=S1ztcqGOpm2DR+8v6RgK/snCLLGeBEG7wurD9C+1aqjW3igTh2uDcxyGw39R57hz+tQNq5
 7hF2dq0nqoSRYniodFw0I5KuCcKhLYlGoanxUiVgRKloygImz8oxlyTzX87+O+KTsmRlnp
 WxDTlJya6vmbZOK1z8qEnbQgGJVUM10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-ao7UIYEcMEeUh0c1nC9znw-1; Tue, 29 Sep 2020 16:19:29 -0400
X-MC-Unique: ao7UIYEcMEeUh0c1nC9znw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5713910BBECD;
 Tue, 29 Sep 2020 20:19:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02D6D7366D;
 Tue, 29 Sep 2020 20:19:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8CBDC113864A; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/29] QAPI patches patches for 2020-09-29
Date: Tue, 29 Sep 2020 22:18:57 +0200
Message-Id: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b150cb8f67bf491a49a1cb1c7da151eeacbdbcc9:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-09-29 13:18:54 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-09-29

for you to fetch changes up to 7cd77fb02b9a2117a56fed172f09a1820fcd6b0b:

  Remove texinfo dependency from docker and CI configs (2020-09-29 17:55:39 +0200)

----------------------------------------------------------------
QAPI patches patches for 2020-09-29

----------------------------------------------------------------
Peter Maydell (21):
      qapi: Fix doc comment indentation again
      qapi/block.json: Add newline after "Example:" for block-latency-histogram-set
      tests/qapi/doc-good.json: Prepare for qapi-doc Sphinx extension
      scripts/qapi: Move doc-comment whitespace stripping to doc.py
      scripts/qapi/parser.py: improve doc comment indent handling
      qapi/machine.json: Escape a literal '*' in doc comment
      docs/sphinx: Add new qapi-doc Sphinx extension
      docs/interop: Convert qemu-ga-ref to rST
      docs/interop: Convert qemu-qmp-ref to rST
      qapi: Use rST markup for literal blocks
      qga/qapi-schema.json: Add some headings
      tests/qapi-schema: Convert doc-good.json to rST-style strong/emphasis
      meson.build: Move SPHINX_ARGS to top level meson.build file
      meson.build: Make manuals depend on source to Sphinx extensions
      tests/qapi-schema: Add test of the rST QAPI doc-comment output
      scripts/qapi: Remove texinfo generation support
      docs/devel/qapi-code-gen.txt: Update to new rST backend conventions
      scripts/texi2pod: Delete unused script
      Remove Texinfo related line from git.orderfile
      configure: Drop texinfo requirement
      Remove texinfo dependency from docker and CI configs

Philippe Mathieu-Daudé (8):
      qapi: Restrict LostTickPolicy enum to machine code
      qapi: Correct balloon documentation
      qapi: Restrict balloon-related commands to machine code
      qapi: Restrict query-vm-generation-id command to machine code
      qapi: Restrict query-uuid command to machine code
      qapi: Restrict device memory commands to machine code
      qapi: Extract ACPI commands to 'acpi.json'
      qapi: Extract PCI commands to 'pci.json'

 docs/conf.py                               |   6 +-
 docs/devel/qapi-code-gen.txt               | 106 ++--
 docs/index.html.in                         |   2 -
 docs/interop/conf.py                       |   4 +
 docs/interop/index.rst                     |   2 +
 docs/interop/qemu-ga-ref.rst               |  13 +
 docs/interop/qemu-ga-ref.texi              |  80 ---
 docs/interop/qemu-qmp-ref.rst              |  13 +
 docs/interop/qemu-qmp-ref.texi             |  80 ---
 docs/meson.build                           |  12 +-
 docs/sphinx/qapidoc.py                     | 549 +++++++++++++++++++
 tests/qapi-schema/doc-good.rst             |   5 +
 configure                                  |  12 +-
 Makefile                                   |   2 +-
 meson.build                                | 103 +---
 qapi/acpi.json                             | 141 +++++
 qapi/block-core.json                       |  20 +-
 qapi/block.json                            |  12 +-
 qapi/machine.json                          | 392 +++++++++++++-
 qapi/migration.json                        | 108 ++--
 qapi/misc.json                             | 820 -----------------------------
 qapi/pci.json                              | 316 +++++++++++
 qapi/qapi-schema.json                      |   8 +-
 qga/qapi-schema.json                       |   8 +-
 include/hw/acpi/acpi_dev_interface.h       |   2 +-
 include/hw/mem/memory-device.h             |   2 +-
 include/hw/rtc/mc146818rtc.h               |   2 +-
 include/hw/virtio/virtio-pmem.h            |   2 +-
 include/sysemu/balloon.h                   |   2 +-
 block/iscsi.c                              |   2 +-
 hw/acpi/core.c                             |   2 +-
 hw/acpi/cpu.c                              |   2 +-
 hw/acpi/memory_hotplug.c                   |   3 +-
 hw/acpi/vmgenid.c                          |   2 +-
 hw/core/qdev-properties.c                  |   1 +
 hw/i386/kvm/i8254.c                        |   2 +-
 hw/pci/pci-stub.c                          |   2 +-
 hw/pci/pci.c                               |   2 +-
 hw/virtio/virtio-balloon.c                 |   2 +-
 hw/virtio/virtio-mem-pci.c                 |   1 +
 monitor/hmp-cmds.c                         |   2 +
 monitor/qmp-cmds.c                         |   1 +
 softmmu/balloon.c                          |   2 +-
 stubs/uuid.c                               |   2 +-
 stubs/vmgenid.c                            |   2 +-
 .travis.yml                                |   1 -
 MAINTAINERS                                |   6 +-
 qapi/meson.build                           |   6 +-
 qga/meson.build                            |   3 +-
 scripts/checkpatch.pl                      |   2 +-
 scripts/coverity-scan/coverity-scan.docker |   1 -
 scripts/git.orderfile                      |   1 -
 scripts/qapi-gen.py                        |   2 -
 scripts/qapi/doc.py                        | 301 -----------
 scripts/qapi/gen.py                        |   7 -
 scripts/qapi/parser.py                     | 105 +++-
 scripts/texi2pod.pl                        | 536 -------------------
 storage-daemon/qapi/meson.build            |   2 +-
 tests/docker/dockerfiles/debian10.docker   |   1 -
 tests/docker/dockerfiles/fedora.docker     |   1 -
 tests/docker/dockerfiles/ubuntu.docker     |   1 -
 tests/docker/dockerfiles/ubuntu1804.docker |   1 -
 tests/docker/dockerfiles/ubuntu2004.docker |   1 -
 tests/qapi-schema/doc-bad-indent.err       |   1 +
 tests/qapi-schema/doc-bad-indent.json      |   8 +
 tests/qapi-schema/doc-bad-indent.out       |   0
 tests/qapi-schema/doc-good.json            |  27 +-
 tests/qapi-schema/doc-good.out             |  24 +-
 tests/qapi-schema/doc-good.texi            | 319 -----------
 tests/qapi-schema/doc-good.txt             | 288 ++++++++++
 tests/qapi-schema/meson.build              |  63 ++-
 71 files changed, 2113 insertions(+), 2449 deletions(-)
 create mode 100644 docs/interop/qemu-ga-ref.rst
 delete mode 100644 docs/interop/qemu-ga-ref.texi
 create mode 100644 docs/interop/qemu-qmp-ref.rst
 delete mode 100644 docs/interop/qemu-qmp-ref.texi
 create mode 100644 docs/sphinx/qapidoc.py
 create mode 100644 tests/qapi-schema/doc-good.rst
 create mode 100644 qapi/acpi.json
 create mode 100644 qapi/pci.json
 delete mode 100644 scripts/qapi/doc.py
 delete mode 100755 scripts/texi2pod.pl
 create mode 100644 tests/qapi-schema/doc-bad-indent.err
 create mode 100644 tests/qapi-schema/doc-bad-indent.json
 create mode 100644 tests/qapi-schema/doc-bad-indent.out
 delete mode 100644 tests/qapi-schema/doc-good.texi
 create mode 100644 tests/qapi-schema/doc-good.txt

-- 
2.26.2


