Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CD8C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579162068D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 06:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgNbPsTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579162068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFXXa-0002vN-QG
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 02:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFXWM-0001Dm-2N
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFXWJ-0008CU-Ni
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 02:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599548062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TbgPnC0RB6++cy0U2XdZXeGeXxQTq5qzijx+WooElJo=;
 b=XgNbPsTpp0ZnOYrfYIfDlRrIJCydkOW9SzEFigTMNpN07MG9ahLX2tNxZXGxwcecJDSv0f
 wJCSlQ0af1Ttbfv4VgXYODfW02tjWQTo7wSna7Ijcz7h6j/97UMimr8Ta3VrcMfskKP8JN
 fSrCcY8D0qU3TUbJWr1bxISRwowNL6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-Uk8U6Xu7Mj-IpfBk2VLjwQ-1; Tue, 08 Sep 2020 02:54:20 -0400
X-MC-Unique: Uk8U6Xu7Mj-IpfBk2VLjwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8748418BE164;
 Tue,  8 Sep 2020 06:54:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EF205C1BB;
 Tue,  8 Sep 2020 06:54:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 82DAD1132B59; Tue,  8 Sep 2020 08:54:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] QAPI patches patches for 2020-09-08
Date: Tue,  8 Sep 2020 08:54:12 +0200
Message-Id: <20200908065417.3158250-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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

The following changes since commit 62f9256052df85194faa33137bbe0afb1c95b6e6:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200904-pull-request' into staging (2020-09-07 13:27:20 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-09-08

for you to fetch changes up to 6b306786cafd6ff939f1c831f0065c136105dca7:

  qapi/block-core.json: Fix nbd-server-start docs (2020-09-07 17:13:30 +0200)

----------------------------------------------------------------
QAPI patches patches for 2020-09-08

----------------------------------------------------------------
Markus Armbruster (2):
      qapi: Reject section markup in definition documentation
      qapi: Make section headings start a new doc comment block

Peter Maydell (3):
      qapi/migration.json: Fix indentation
      qapi: Fix indentation, again
      qapi/block-core.json: Fix nbd-server-start docs

 docs/devel/qapi-code-gen.txt           |  2 +
 qapi/audio.json                        | 12 +++---
 qapi/block-core.json                   | 14 +++----
 qapi/control.json                      |  4 +-
 qapi/machine.json                      |  6 +--
 qapi/migration.json                    | 68 +++++++++++++++++-----------------
 qapi/misc.json                         |  4 +-
 qapi/net.json                          |  2 +-
 scripts/qapi/parser.py                 | 24 ++++++++----
 tests/qapi-schema/doc-bad-section.err  |  1 +
 tests/qapi-schema/doc-bad-section.json |  3 +-
 tests/qapi-schema/doc-bad-section.out  | 24 ------------
 tests/qapi-schema/doc-good.out         |  3 +-
 13 files changed, 78 insertions(+), 89 deletions(-)

-- 
2.26.2


