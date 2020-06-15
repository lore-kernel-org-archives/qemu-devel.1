Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46554C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150EE2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIAQ4MxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150EE2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqqW-0007B1-7B
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jkqpA-0005bj-SS
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:15:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31640
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jkqp8-0008Ht-Cs
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592234097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rBHlIv+H7s9GOlLKUoP1sXG1Kd0bDsRwbBCuGDo/eSI=;
 b=AIAQ4MxNWFgDOn4S5n4N0LuMH3GbuaGMNjePlNUvUIBYRcw8XB6pvHld/5O2RN7sjhUHqE
 e2ABvC1y6Zk3uVhx/Toe8p/qnqfK4Bxal0IqIo/7Ui/IL1ij+TOz/3qrZbzuesa07ucZXF
 LZq0thjBYjkdsDlGnjWYzU5lYIIbN2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-6EShsEOvOnWEonAhgtwf_w-1; Mon, 15 Jun 2020 11:14:54 -0400
X-MC-Unique: 6EShsEOvOnWEonAhgtwf_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B32FB18A2663;
 Mon, 15 Jun 2020 15:14:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9BC160BF1;
 Mon, 15 Jun 2020 15:14:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 76F8017449; Mon, 15 Jun 2020 17:14:49 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Vga 20200615 patches
Date: Mon, 15 Jun 2020 17:14:45 +0200
Message-Id: <20200615151449.19818-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 11:02:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/vga-20200615-pull-request

for you to fetch changes up to fca0b885417497a973c56e6d4e0d88f9f7a0e71b:

  sm501: Optimise 1 pixel 2d ops (2020-06-15 10:52:53 +0200)

----------------------------------------------------------------
vga: sm501 fixes and optimizations.

----------------------------------------------------------------

BALATON Zoltan (4):
  sm501: Fix bounds checks
  sm501: Drop unneded variable
  sm501: Ignore no-op blits
  sm501: Optimise 1 pixel 2d ops

 hw/display/sm501.c | 58 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 10 deletions(-)

-- 
2.18.4


