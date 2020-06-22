Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2124C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAB7206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnRIQ+Qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAB7206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnO7k-0001Qt-Op
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnO6H-0007MM-4x
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:11:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60847
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnO6F-0005wM-5h
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592838666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2eyYJnn1jZN8C028f1bHv2kGJKwMqrLXxZhkkmNYgBs=;
 b=UnRIQ+QdZz2GpluuGo5bXej91oMdEjosQrQ3XuGOHKEj7/LljjqPsJFVnryRPFFYptWQH/
 /pk8bJcMWYVHbhuXJG9gD26qRSYbfKssO2N4W3iA727jd8lR62kQ2hneXVe5Z1W+Ja88/I
 phGGoDj0dck+S91p9cWtlj2cJCZ12Ck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-xAozSzdCNb2YKIgfWRvT1w-1; Mon, 22 Jun 2020 11:11:02 -0400
X-MC-Unique: xAozSzdCNb2YKIgfWRvT1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A6BE107ACF9;
 Mon, 22 Jun 2020 15:11:01 +0000 (UTC)
Received: from localhost (ovpn-114-85.ams2.redhat.com [10.36.114.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BA875BADB;
 Mon, 22 Jun 2020 15:11:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/18] Block patches
Date: Mon, 22 Jun 2020 17:10:41 +0200
Message-Id: <20200622151059.921191-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit bae31bfa48b9caecee25da3d5333901a126a06b4:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20200619-pull-request' into staging (2020-06-19 22:56:59 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-06-22

for you to fetch changes up to 74c55e4142a7bb835c38d3770c74210cbb1e4fab:

  iotests: don't test qcow2.py inside 291 (2020-06-22 16:05:23 +0200)

----------------------------------------------------------------
Block patches:
- Support modifying a LUKS-encrypted image's keyslots
- iotest fixes

----------------------------------------------------------------
Max Reitz (1):
  iotests: Make _filter_img_create more active

Maxim Levitsky (14):
  iotests: filter few more luks specific create options
  qcrypto/core: add generic infrastructure for crypto options amendment
  qcrypto/luks: implement encryption key management
  block/amend: add 'force' option
  block/amend: separate amend and create options for qemu-img
  block/amend: refactor qcow2 amend options
  block/crypto: rename two functions
  block/crypto: implement the encryption key management
  block/qcow2: extend qemu-img amend interface with crypto options
  iotests: qemu-img tests for luks key management
  block/core: add generic infrastructure for x-blockdev-amend qmp
    command
  block/crypto: implement blockdev-amend
  block/qcow2: implement blockdev-amend
  iotests: add tests for blockdev-amend

Philippe Mathieu-Daudé (1):
  iotests: Fix 051 output after qdev_init_nofail() removal

Vladimir Sementsov-Ogievskiy (2):
  block/block-copy: block_copy_dirty_clusters: fix failure check
  iotests: don't test qcow2.py inside 291

 docs/tools/qemu-img.rst          |   5 +-
 qapi/block-core.json             |  68 +++++
 qapi/crypto.json                 |  73 +++++-
 qapi/job.json                    |   4 +-
 block/crypto.h                   |  37 +++
 crypto/blockpriv.h               |   8 +
 include/block/block.h            |   1 +
 include/block/block_int.h        |  24 +-
 include/crypto/block.h           |  22 ++
 block.c                          |   4 +-
 block/amend.c                    | 113 +++++++++
 block/block-copy.c               |   4 +-
 block/crypto.c                   | 206 +++++++++++++--
 block/qcow2.c                    | 332 +++++++++++++-----------
 crypto/block-luks.c              | 416 ++++++++++++++++++++++++++++++-
 crypto/block.c                   |  29 +++
 qemu-img.c                       |  44 +++-
 block/Makefile.objs              |   2 +-
 qemu-img-cmds.hx                 |   4 +-
 tests/qemu-iotests/049.out       | 102 ++++----
 tests/qemu-iotests/051.pc.out    |   4 +-
 tests/qemu-iotests/061.out       |  12 +-
 tests/qemu-iotests/082.out       | 185 ++++----------
 tests/qemu-iotests/085.out       |  38 +--
 tests/qemu-iotests/087.out       |   6 +-
 tests/qemu-iotests/112.out       |   2 +-
 tests/qemu-iotests/134.out       |   2 +-
 tests/qemu-iotests/141           |   2 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/153           |   9 +-
 tests/qemu-iotests/158.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +-
 tests/qemu-iotests/188.out       |   2 +-
 tests/qemu-iotests/189.out       |   4 +-
 tests/qemu-iotests/198.out       |   4 +-
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/263.out       |   4 +-
 tests/qemu-iotests/274.out       |  46 ++--
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/284.out       |   6 +-
 tests/qemu-iotests/291           |   4 -
 tests/qemu-iotests/291.out       |  33 ---
 tests/qemu-iotests/293           | 207 +++++++++++++++
 tests/qemu-iotests/293.out       |  99 ++++++++
 tests/qemu-iotests/294           |  90 +++++++
 tests/qemu-iotests/294.out       |  30 +++
 tests/qemu-iotests/295           | 279 +++++++++++++++++++++
 tests/qemu-iotests/295.out       |  40 +++
 tests/qemu-iotests/296           | 234 +++++++++++++++++
 tests/qemu-iotests/296.out       |  33 +++
 tests/qemu-iotests/common.filter |  93 +++++--
 tests/qemu-iotests/group         |   4 +
 53 files changed, 2482 insertions(+), 516 deletions(-)
 create mode 100644 block/amend.c
 create mode 100755 tests/qemu-iotests/293
 create mode 100644 tests/qemu-iotests/293.out
 create mode 100755 tests/qemu-iotests/294
 create mode 100644 tests/qemu-iotests/294.out
 create mode 100755 tests/qemu-iotests/295
 create mode 100644 tests/qemu-iotests/295.out
 create mode 100755 tests/qemu-iotests/296
 create mode 100644 tests/qemu-iotests/296.out

-- 
2.26.2


