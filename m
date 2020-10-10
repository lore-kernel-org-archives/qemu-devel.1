Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD28FC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 09:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A74021D41
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 09:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efLiKUNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A74021D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRBf3-0004TT-Dl
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 05:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBau-0007dQ-8z
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBaq-0002hd-K6
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602323710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j3qcexFUolzlrwc+mmM+WRBXkPlIJqGdFzdwMj0Ljzc=;
 b=efLiKUNLLz+I+UL2ha0FBsbe4o3Z+UWmxc57wbZsu0TF2tSC3E/a++/NjY7vhljL2RXRbR
 4lH6KGyuryNVw1raiLScPjBGcnB2dskpgxA+u2y8Y5p9OvBrtDFZ5wd1MQrxUdLONYT+GU
 D72XSOUN03UvmW+6e9dy4hAgFVotFaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-oAf9xB8ONDSzSvjxMz1Qdw-1; Sat, 10 Oct 2020 05:55:07 -0400
X-MC-Unique: oAf9xB8ONDSzSvjxMz1Qdw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 869F2107AD94;
 Sat, 10 Oct 2020 09:55:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49C6D6EF58;
 Sat, 10 Oct 2020 09:55:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9696811329AE; Sat, 10 Oct 2020 11:55:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/34] QAPI patches patches for 2020-10-10
Date: Sat, 10 Oct 2020 11:54:30 +0200
Message-Id: <20201010095504.796182-1-armbru@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 4a7c0bd9dcb08798c6f82e55b5a3423f7ee669f1:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.2-20201009' into staging (2020-10-09 15:48:04 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-10-10

for you to fetch changes up to b4c0aa59aff520e2a55edd5fef393058ca6520de:

  qapi/visit.py: add type hint annotations (2020-10-10 11:37:49 +0200)

----------------------------------------------------------------
QAPI patches patches for 2020-10-10

----------------------------------------------------------------
John Snow (34):
      docs: repair broken references
      qapi: modify docstrings to be sphinx-compatible
      qapi-gen: Separate arg-parsing from generation
      qapi: move generator entrypoint into package
      qapi: Prefer explicit relative imports
      qapi: Remove wildcard includes
      qapi: enforce import order/styling with isort
      qapi: delint using flake8
      qapi: add pylintrc
      qapi/common.py: Remove python compatibility workaround
      qapi/common.py: Add indent manager
      qapi/common.py: delint with pylint
      qapi/common.py: Replace one-letter 'c' variable
      qapi/common.py: check with pylint
      qapi/common.py: add type hint annotations
      qapi/common.py: Convert comments into docstrings, and elaborate
      qapi/common.py: move build_params into gen.py
      qapi: establish mypy type-checking baseline
      qapi/events.py: add type hint annotations
      qapi/events.py: Move comments into docstrings
      qapi/commands.py: Don't re-bind to variable of different type
      qapi/commands.py: add type hint annotations
      qapi/source.py: add type hint annotations
      qapi/source.py: delint with pylint
      qapi/gen: Make _is_user_module() return bool
      qapi/gen.py: add type hint annotations
      qapi/gen.py: Remove unused parameter
      qapi/gen.py: update write() to be more idiomatic
      qapi/gen.py: delint with pylint
      qapi/types.py: add type hint annotations
      qapi/types.py: remove one-letter variables
      qapi/visit.py: assert tag_member contains a QAPISchemaEnumType
      qapi/visit.py: remove unused parameters from gen_visit_object
      qapi/visit.py: add type hint annotations

 docs/devel/multi-thread-tcg.rst |   2 +-
 docs/devel/testing.rst          |   2 +-
 scripts/qapi-gen.py             |  57 +++----------
 scripts/qapi/.flake8            |   2 +
 scripts/qapi/.isort.cfg         |   7 ++
 scripts/qapi/commands.py        |  90 ++++++++++++++------
 scripts/qapi/common.py          | 174 +++++++++++++++++++++-----------------
 scripts/qapi/events.py          |  58 +++++++++----
 scripts/qapi/expr.py            |   7 +-
 scripts/qapi/gen.py             | 180 +++++++++++++++++++++++++---------------
 scripts/qapi/introspect.py      |  16 +++-
 scripts/qapi/main.py            |  95 +++++++++++++++++++++
 scripts/qapi/mypy.ini           |  30 +++++++
 scripts/qapi/parser.py          |   6 +-
 scripts/qapi/pylintrc           |  70 ++++++++++++++++
 scripts/qapi/schema.py          |  33 ++++----
 scripts/qapi/source.py          |  35 +++++---
 scripts/qapi/types.py           | 125 +++++++++++++++++++---------
 scripts/qapi/visit.py           | 116 +++++++++++++++++++-------
 19 files changed, 764 insertions(+), 341 deletions(-)
 create mode 100644 scripts/qapi/.flake8
 create mode 100644 scripts/qapi/.isort.cfg
 create mode 100644 scripts/qapi/main.py
 create mode 100644 scripts/qapi/mypy.ini
 create mode 100644 scripts/qapi/pylintrc

-- 
2.26.2


