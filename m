Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4840DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 01:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4B4206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 01:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Djyvh7+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4B4206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jipOE-0003Wc-8x
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 21:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jipMr-0001ii-QY
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 21:17:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31494
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jipMp-00033Q-Ic
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 21:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591751842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n6lotWdLf4ltCetajrmOFyT35jl6W1Oes2U+PXQF368=;
 b=Djyvh7+GOvUB+Ductk+L7V5pKmDi/E8j5a5r1C5QOqFbUOawSSSp9BW48Fkk0OwMBh038D
 NPQx+AqVnSVEbYbX8JeKJZ2Ky2L6m4m94RM9LRe3Vc0sTWOcpU4zHKe4uZZGjx9Ls+kKI/
 biROILlzwd5nK2+AHGdpBvAN9xf2qRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-t9Gr5zjsPB6kxUtML59ygQ-1; Tue, 09 Jun 2020 21:17:17 -0400
X-MC-Unique: t9Gr5zjsPB6kxUtML59ygQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD1A58014D4
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 01:17:16 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99B4C5C1BD
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 01:17:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] NBD patches through 2020-06-09
Date: Tue,  9 Jun 2020 20:17:10 -0500
Message-Id: <20200610011713.3687895-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

The following changes since commit 31d321c2b3574dcc74e9f6411af06bca6b5d10f4:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sparc-next-20200609' into staging (2020-06-09 17:29:47 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-06-09

for you to fetch changes up to 2886df0c75c1c5f6aed054c54f4ad48aeee04bfd:

  block: Call attention to truncation of long NBD exports (2020-06-09 17:05:50 -0500)

----------------------------------------------------------------
NBD patches for 2020-06-09

- fix iotest 194 race
- fix CVE-2020-10761: server DoS from assertion on long NBD error messages

----------------------------------------------------------------
Eric Blake (2):
      nbd/server: Avoid long error message assertions CVE-2020-10761
      block: Call attention to truncation of long NBD exports

Vladimir Sementsov-Ogievskiy (1):
      iotests: 194: wait for migration completion on target too

 block.c                    |  7 +++++--
 block/nbd.c                | 21 +++++++++++++--------
 nbd/server.c               | 28 +++++++++++++++++++++++++---
 tests/qemu-iotests/143     |  4 ++++
 tests/qemu-iotests/143.out |  2 ++
 tests/qemu-iotests/194     | 10 ++++++++++
 tests/qemu-iotests/194.out |  5 +++++
 7 files changed, 64 insertions(+), 13 deletions(-)

-- 
2.27.0


