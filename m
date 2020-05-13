Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D868CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF494204EF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SamZR3jq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF494204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYsBv-00065v-JF
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYsAq-0004UF-Sr
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:15:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60120
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYsAq-0006Ds-2u
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589379351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZyT1yzrAcGo92UpOOatnrmXEXssToUD9g1ZIiWcHJ50=;
 b=SamZR3jq2CMhA8ukn1ovKft0bEJxCNrDL1O8iVqLqNNK7DQ1E+vrTfGosgaM2wIBZ3i7hR
 HqcHdkysfMVOust5aFX5FzQ8zhaYYJ+IwNnCnPK5/K89/bzjeXc+g7wKgJJIVveE0V+CrG
 5d6EzM2Xhjn3X2OuqGguu6DdInB3az0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-aQzTXvUKOuS-htK3Szwe6Q-1; Wed, 13 May 2020 10:15:48 -0400
X-MC-Unique: aQzTXvUKOuS-htK3Szwe6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 361FC18FF662;
 Wed, 13 May 2020 14:15:47 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BECA010013D9;
 Wed, 13 May 2020 14:15:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/5] Block patches
Date: Wed, 13 May 2020 16:15:39 +0200
Message-Id: <20200513141544.1459069-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 03:05:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The following changes since commit d5c75ec500d96f1d93447f990cd5a4ef5ba27fae:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2020-05-08-1' into staging (2020-05-12 17:00:10 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-05-13

for you to fetch changes up to fc9aefc8c0d3c6392656ea661ce72c1583b70bbd:

  block/block-copy: fix use-after-free of task pointer (2020-05-13 14:20:31 +0200)

----------------------------------------------------------------
Block patches:
- zstd compression for qcow2
- Fix use-after-free

----------------------------------------------------------------
Denis Plotnikov (4):
  qcow2: introduce compression type feature
  qcow2: rework the cluster compression routine
  qcow2: add zstd cluster compression
  iotests: 287: add qcow2 compression type test

Vladimir Sementsov-Ogievskiy (1):
  block/block-copy: fix use-after-free of task pointer

 docs/interop/qcow2.txt           |   1 +
 configure                        |   2 +-
 qapi/block-core.json             |  23 ++-
 block/qcow2.h                    |  20 ++-
 include/block/block_int.h        |   1 +
 block/block-copy.c               |   2 +-
 block/qcow2-threads.c            | 240 +++++++++++++++++++++++++++++--
 block/qcow2.c                    | 120 ++++++++++++++++
 tests/qemu-iotests/031.out       |  14 +-
 tests/qemu-iotests/036.out       |   4 +-
 tests/qemu-iotests/049.out       | 102 ++++++-------
 tests/qemu-iotests/060.out       |   1 +
 tests/qemu-iotests/061.out       |  34 +++--
 tests/qemu-iotests/065           |  28 ++--
 tests/qemu-iotests/080           |   2 +-
 tests/qemu-iotests/082.out       |  48 ++++++-
 tests/qemu-iotests/085.out       |  38 ++---
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +-
 tests/qemu-iotests/198.out       |   2 +
 tests/qemu-iotests/206.out       |   5 +
 tests/qemu-iotests/242.out       |   5 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/274.out       |  49 ++++---
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/287           | 152 ++++++++++++++++++++
 tests/qemu-iotests/287.out       |  67 +++++++++
 tests/qemu-iotests/common.filter |   3 +-
 tests/qemu-iotests/group         |   1 +
 30 files changed, 825 insertions(+), 163 deletions(-)
 create mode 100755 tests/qemu-iotests/287
 create mode 100644 tests/qemu-iotests/287.out

-- 
2.26.2


