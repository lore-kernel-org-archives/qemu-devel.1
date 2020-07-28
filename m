Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFDCC433F2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA3520759
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+lYWaeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA3520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Le3-0007N0-T9
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0Ld2-0006GG-HM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:10:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51936
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0Ld0-0007CH-Fc
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595927429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=6j23IAoPrbb8aGcSXff/ft1jrj0qn3P0QT0dUg8cv3A=;
 b=R+lYWaeYFWy73fO7Ga9ubQj46IPDiUgGz2IR1TR6oZBiCSB9ay9whlaclPI/LawT9E0zrT
 cFzFtteZBINRAyRwhYcpvuOc7z9XpsWPMkushx3dOCRB+XCk9eUiHA0Z99dsbEylbroekF
 8dBw6MoFz5RksQMyVjeXoD51k5yjpmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-OfOWkRe4Ok-Fw-Z-bnDF0w-1; Tue, 28 Jul 2020 05:10:27 -0400
X-MC-Unique: OfOWkRe4Ok-Fw-Z-bnDF0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A93351800D4A;
 Tue, 28 Jul 2020 09:10:26 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-214.pek2.redhat.com
 [10.72.12.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C53A90E62;
 Tue, 28 Jul 2020 09:10:23 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 0/3] Net patches
Date: Tue, 28 Jul 2020 17:10:16 +0800
Message-Id: <1595927419-27346-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 93ea484375ab473379dd9c836261ef484bd71ab1:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-07-27 21:00:01 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 22dc8663d9fc7baa22100544c600b6285a63c7a3:

  net: forbid the reentrant RX (2020-07-28 16:57:58 +0800)

----------------------------------------------------------------
Want to send earlier but most patches just come.

- fix vhost-vdpa issues when no peer
- fix virtio-pci queue enabling index value
- forbid reentrant RX

Changes from V1:

- drop the patch that has been merged

----------------------------------------------------------------
Jason Wang (2):
      virtio-net: check the existence of peer before accessing vDPA config
      net: forbid the reentrant RX

Yuri Benditovich (1):
      virtio-pci: fix wrong index in virtio_pci_queue_enabled

 hw/net/virtio-net.c    | 30 +++++++++++++++++++-----------
 hw/virtio/virtio-pci.c |  2 +-
 net/queue.c            |  3 +++
 3 files changed, 23 insertions(+), 12 deletions(-)


