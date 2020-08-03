Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE56C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4C3206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAC50EfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4C3206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2WVr-0006zr-AW
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2WUb-0005cs-Pi
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:10:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55187
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2WUZ-0003rC-TU
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596445846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OfUHSlTcHolMaYh22V4ZRK2yc8Uir+jB1rcXe6FnHBA=;
 b=XAC50EfN5UzM59iYRENCWHNKF/Dswr7QrpZGcpjFr89Bo5ZbTL/lG9OgiIGPdJpAHKuTNd
 wt39xr1IQTc3Gh5WBIOb42wdQYvPa/OMOnxYPdDEJ4pUE7+mMrxGkRL7/dSdWpMDSljmXm
 yYm1WFr0FzO2ugNhAsaEKZTaOMBbvA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-CyrhCNhhMx6xRjTeD9XvwQ-1; Mon, 03 Aug 2020 05:10:45 -0400
X-MC-Unique: CyrhCNhhMx6xRjTeD9XvwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C8208064AC;
 Mon,  3 Aug 2020 09:10:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1055574F58;
 Mon,  3 Aug 2020 09:10:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9BF621132FD2; Mon,  3 Aug 2020 11:10:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] QAPI patches patches for 2020-08-03
Date: Mon,  3 Aug 2020 11:10:39 +0200
Message-Id: <20200803091042.2920218-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:37:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit d74824cf7c8b352f9045e949dc636c7207a41eee:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200731' into staging (2020-07-31 10:28:13 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-08-03

for you to fetch changes up to f7160f32186b4ae1e1327e3bd05060fffec8f9ae:

  schemas: Add vim modeline (2020-08-03 08:28:08 +0200)

----------------------------------------------------------------
QAPI patches patches for 2020-08-03

----------------------------------------------------------------
Andrea Bolognani (1):
      schemas: Add vim modeline

Markus Armbruster (1):
      qapi: Delete unwanted indentation of top-level expressions

Peter Maydell (1):
      qapi/machine.json: Fix missing newline in doc comment

 docs/interop/firmware.json                |  1 +
 docs/interop/vhost-user.json              |  1 +
 qapi/authz.json                           |  1 +
 qapi/block-core.json                      | 27 ++++++++++++++-------------
 qapi/block.json                           |  1 +
 qapi/char.json                            |  1 +
 qapi/common.json                          |  1 +
 qapi/control.json                         |  1 +
 qapi/crypto.json                          |  1 +
 qapi/dump.json                            |  1 +
 qapi/error.json                           |  1 +
 qapi/introspect.json                      |  1 +
 qapi/job.json                             |  1 +
 qapi/machine-target.json                  |  1 +
 qapi/machine.json                         |  4 +++-
 qapi/migration.json                       |  1 +
 qapi/misc-target.json                     |  1 +
 qapi/misc.json                            |  1 +
 qapi/net.json                             |  1 +
 qapi/qapi-schema.json                     |  1 +
 qapi/qdev.json                            |  1 +
 qapi/qom.json                             |  1 +
 qapi/rdma.json                            |  1 +
 qapi/rocker.json                          |  1 +
 qapi/run-state.json                       |  1 +
 qapi/sockets.json                         |  1 +
 qapi/tpm.json                             |  1 +
 qapi/transaction.json                     |  1 +
 qapi/ui.json                              |  5 +++--
 qga/qapi-schema.json                      |  1 +
 storage-daemon/qapi/qapi-schema.json      |  1 +
 tests/qapi-schema/doc-good.json           |  2 ++
 tests/qapi-schema/include/sub-module.json |  1 +
 tests/qapi-schema/qapi-schema-test.json   |  1 +
 tests/qapi-schema/sub-sub-module.json     |  1 +
 35 files changed, 53 insertions(+), 16 deletions(-)

-- 
2.26.2


