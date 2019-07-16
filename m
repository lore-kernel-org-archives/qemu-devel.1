Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A44AC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBCE20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBCE20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnPuB-00067Q-Fc
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnPtv-0005QW-CF
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnPtt-0000L4-6G
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:01:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hnPtq-0000HT-Rv; Tue, 16 Jul 2019 12:01:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 91137308330C;
 Tue, 16 Jul 2019 16:01:53 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 643EC5C88D;
 Tue, 16 Jul 2019 16:01:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 18:01:41 +0200
Message-Id: <20190716160143.394-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 16 Jul 2019 16:01:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/2] pflash-next patches for v4.1.0-rc1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 697f59243f5a28b8a243ff5ad59e34bbecffca=
e1:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2019-07-16 15:08:29 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/pflash-next-20190716

for you to fetch changes up to 611c749c3b86fe377c94ea301feab3d9ce3bf617:

  hw/block/pflash_cfi01: Start state machine as READY to accept commands =
(2019-07-16 17:54:06 +0200)

----------------------------------------------------------------

Trivial pflash fixes for rc1.

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (2):
  hw/block/pflash_cfi02: Explicit switch fallthrough for ERASE commands
  hw/block/pflash_cfi01: Start state machine as READY to accept commands

 hw/block/pflash_cfi01.c | 2 +-
 hw/block/pflash_cfi02.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--=20
2.20.1


