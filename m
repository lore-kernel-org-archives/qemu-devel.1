Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B4C28E83
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48052071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ezece8Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48052071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDAGc-0004rp-1O
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDAFA-0003ai-Lq
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:38:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57278
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDAF7-00017B-8k
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598981927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sQYQSidBO7N43BNS1sVviasNmAhxxstpsjdr396dC+g=;
 b=Ezece8Rpb1Dl5FeB3L4nzsu3Usxvc6W0QMZ1pdFLPP17LT7/6JtAgd06xGarqbfj/KhGX7
 P2Xhx0adhS6uuMPniEws/TTFvYVhA/toNvrn1vSqyjfrqSmhnrIDbalOMnyqdCe1ONJa7s
 6vz+DldaN89JgyDSwmJk7c+NbNIlFmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-xXlzzz76OfaFxLIyRnMHhQ-1; Tue, 01 Sep 2020 13:38:44 -0400
X-MC-Unique: xXlzzz76OfaFxLIyRnMHhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 604E3425D1
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 17:38:43 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CB2F51C4F
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 17:38:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/26] Meson changes for 2020-09-01
Date: Tue,  1 Sep 2020 13:38:38 -0400
Message-Id: <20200901173842.5882-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:16:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d75:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31 19:39:13 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 9f5d95976895132976d9d6c14e7a35781d6f1e15:

  Makefile: Fix in-tree clean/distclean (2020-09-01 12:11:00 -0400)

v1->v2: add Greg's cscope patches, fix static build, fix option typo

----------------------------------------------------------------
meson fixes:
* bump submodule to 0.55.1
* SDL, pixman and zlib fixes
* firmwarepath fix
* fix firmware builds

meson related:
* move install to Meson
* move NSIS to Meson
* do not make meson use cmake
* add description to options

----------------------------------------------------------------
Greg Kurz (2):
      Makefile: Add back TAGS/ctags/cscope rules
      Makefile: Fix in-tree clean/distclean

Marc-André Lureau (14):
      meson: install pc-bios blobs
      meson: install scripts/qemu-trace-stap
      meson: install icons
      meson: install desktop file
      meson: install $localstatedir/run for qga
      build-sys: remove install target from Makefile
      configure: rename confsuffix option
      configure: always /-seperate directory from qemu_suffix
      configure: build docdir like other suffixed directories
      meson: pass qemu_suffix option
      meson: use meson datadir instead of qemu_datadir
      meson: pass docdir option
      meson: use meson mandir instead of qemu_mandir
      meson: add NSIS building

Paolo Bonzini (8):
      meson: bump submodule to 0.55.1
      block: always link with zlib
      meson: move zlib detection to meson
      meson: add pixman dependency to UI modules
      configure: do not include ${prefix} in firmwarepath
      meson: use pkg-config method to find dependencies
      build: fix recurse-all target
      meson: add description to options

Stefan Weil (1):
      meson: add pixman dependency to chardev/baum module

Volker Rümelin (1):
      meson: fix SDL2_image detection

 Makefile                           | 150 ++++++-------------------------------
 block/meson.build                  |   4 +-
 chardev/meson.build                |   2 +-
 configure                          |  65 +++++-----------
 contrib/vhost-user-gpu/meson.build |   2 +-
 docs/devel/build-system.rst        |  27 +++----
 docs/meson.build                   |   4 +-
 meson                              |   2 +-
 meson.build                        |  53 +++++++++----
 meson_options.txt                  |  33 +++++---
 pc-bios/descriptors/meson.build    |   2 +-
 pc-bios/keymaps/meson.build        |   6 +-
 pc-bios/meson.build                |  65 +++++++++++++++-
 pc-bios/optionrom/Makefile         |  10 +--
 pc-bios/s390-ccw/Makefile          |   3 +-
 qga/meson.build                    |   2 +
 scripts/meson.build                |   3 +
 scripts/nsis.py                    |  78 +++++++++++++++++++
 tools/virtiofsd/meson.build        |   2 +-
 trace/meson.build                  |   2 +-
 ui/icons/meson.build               |  13 ++++
 ui/meson.build                     |   9 ++-
 22 files changed, 303 insertions(+), 234 deletions(-)
 create mode 100644 scripts/meson.build
 create mode 100644 scripts/nsis.py
 create mode 100644 ui/icons/meson.build
-- 
2.26.2


