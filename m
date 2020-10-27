Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223DDC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D9D22263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duDSUSo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D9D22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXM4N-0007av-FH
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXM2d-0006dv-4b
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXM2Y-0006kj-8b
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603793832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iMWIBbcBQZu+bsW3tJ+hmmdRyvVbI+80tcqo2QZP1OI=;
 b=duDSUSo9CnoAcp7OUytS2sqRMCyUhel3aZXG682r5VbSP1zNKfrKcOpAT2hjpQ7HYDngNQ
 6yuHH6QyAWdeUvNSIM4NY4AHU+Qdgy6lPqZAQ4b7gF9iCK4ufERZ4vjWw5K66Nl8eX+wjC
 n8k/j7vzPZis4rzmm3rVY6PEdgzYPNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-KrgJaDJfMIGvOSCG4KpDaA-1; Tue, 27 Oct 2020 06:17:10 -0400
X-MC-Unique: KrgJaDJfMIGvOSCG4KpDaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 214DB186842E;
 Tue, 27 Oct 2020 10:17:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8F5B60C07;
 Tue, 27 Oct 2020 10:17:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8371B113865F; Tue, 27 Oct 2020 11:17:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] QMP patches patches for 2020-10-27
Date: Tue, 27 Oct 2020 11:17:05 +0100
Message-Id: <20201027101707.2988553-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 1dc887329a10903940501b43e8c0cc67af7c06d5:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-20201026' into staging (2020-10-26 17:19:26 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qmp-2020-10-27

for you to fetch changes up to 36006046675228cf2fec904e717d96ca816cc21a:

  scripts/qmp: delete 'qmp' script (2020-10-27 11:11:06 +0100)

----------------------------------------------------------------
QMP patches patches for 2020-10-27

----------------------------------------------------------------
David Edmondson (1):
      qmp-shell: Sort by key when pretty-printing

John Snow (1):
      scripts/qmp: delete 'qmp' script

 scripts/qmp/qmp       | 131 +++-----------------------------------------------
 scripts/qmp/qmp-shell |   2 +-
 2 files changed, 8 insertions(+), 125 deletions(-)

-- 
2.26.2


