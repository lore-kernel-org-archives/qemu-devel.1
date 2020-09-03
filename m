Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1EAC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAF920897
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXI69Wve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAF920897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkY3-0004ll-To
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDkXA-00036P-Lp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:23:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDkX8-0008Qw-Hz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599121429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l3UbDiNqm8edXp9TpkJQGPhmVeIoFtmgU3sF3E7lLuE=;
 b=AXI69WveqgTiEIFyuYZSOM3AfzjC/SNMn12MTO9WJJWn9ApWxBIqNB1znmiQQ/AfzYUmJb
 q6mi7V5/0GRJ3i7hluRYQvPLYleZKO8Xzful1rtg5BKCwjRB3LQjUbbXr/H4Fm7BHrhB2s
 JHU9OPJOnJ4AzKmHw+dbBpnAK2GxIMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-SCmbI2XxNy2CU1W6zENSsA-1; Thu, 03 Sep 2020 04:23:47 -0400
X-MC-Unique: SCmbI2XxNy2CU1W6zENSsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6363A81F000;
 Thu,  3 Sep 2020 08:23:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 342FC1002D57;
 Thu,  3 Sep 2020 08:23:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B060C113865F; Thu,  3 Sep 2020 10:23:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] QAPI patches patches for 2020-09-03
Date: Thu,  3 Sep 2020 10:23:36 +0200
Message-Id: <20200903082344.1877175-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit ed215cec0fcaeaece064b0fdf37fe3bceb06d76c:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2020-09-02 15:26:38 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-09-03

for you to fetch changes up to 923fbd4cbd485dc72e9f2578cd891607ec43ac70:

  docs/qdev-device-use: Don't suggest -drive and -net can do USB (2020-09-03 09:58:39 +0200)

----------------------------------------------------------------
QAPI patches patches for 2020-09-03

----------------------------------------------------------------
Daniel P. Berrangé (1):
      qapi: enable use of g_autoptr with QAPI types

Kashyap Chamarthy (1):
      qapi/block-core.json: Remove stale description of 'blockdev-add'

Markus Armbruster (6):
      scripts/qmp/qom-fuse: Unbreak import of QEMUMonitorProtocol
      scripts/qmp/qom-fuse: Port to current Python module fuse
      scripts/qmp/qom-fuse: Fix getattr(), read() for files in /
      docs/interop/qmp-spec: Point to the QEMU QMP reference manual
      qapi: Document event VSERPORT_CHANGE is rate-limited
      docs/qdev-device-use: Don't suggest -drive and -net can do USB

 docs/devel/qapi-code-gen.txt       |   2 +
 docs/interop/qmp-spec.txt          |   9 ++--
 docs/qdev-device-use.txt           |  34 +++++++++++-
 qapi/block-core.json               |   4 +-
 qapi/char.json                     |   2 +
 include/crypto/block.h             |   2 -
 tests/test-qobject-input-visitor.c |  23 +++-----
 scripts/qapi/types.py              |   1 +
 scripts/qmp/qom-fuse               | 107 ++++++++++++++++++++-----------------
 9 files changed, 108 insertions(+), 76 deletions(-)

-- 
2.26.2


