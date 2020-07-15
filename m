Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5331C433E5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812B120657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyJ6+ZhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812B120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhro-00044t-Q5
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvhqq-0002np-Ej
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:53:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvhqo-0005Jf-Tr
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594821213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XglhuBI3Z6I92UoY4R/O53JynhwzokF4jeojs1T2xzM=;
 b=eyJ6+ZhVUxqlLSghx02Yg/h90qF1pVEH/3Ktm4c2ZjvOk2bHFw/zgd7dILS7iZzPlGXzah
 wv/hH4vXebQ3Se7eXYDYXE5BoYCXIgk4EL+hdsFd9Qs141KXZeM64lCZ4DHItPjPCsqV48
 YnY9IF0R6w8uAOAA1ySrkq3bIgbTecQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-sAqNsp_qPU2kW-xuEMJ8iA-1; Wed, 15 Jul 2020 09:53:25 -0400
X-MC-Unique: sAqNsp_qPU2kW-xuEMJ8iA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AA09E91C;
 Wed, 15 Jul 2020 13:53:25 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-28.pek2.redhat.com
 [10.72.12.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7A4661780;
 Wed, 15 Jul 2020 13:53:23 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 0/7] Net patches
Date: Wed, 15 Jul 2020 21:53:14 +0800
Message-Id: <1594821201-3708-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 673205379fb499d2b72f2985b47ec7114282f5fe:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/python-next-20200714' into staging (2020-07-15 13:04:27 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to a134321ef676723768973537bb9b49365ae2062e:

  ftgmac100: fix dblac write test (2020-07-15 21:00:13 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Andrew (1):
      hw/net: Added CSO for IPv6

Daniel P. Berrangé (1):
      net: detect errors from probing vnet hdr flag for TAP devices

Juan Quintela (1):
      virtio-net: fix removal of failover device

Laurent Vivier (1):
      net: check if the file descriptor is valid before using it

Zhang Chen (2):
      net/colo-compare.c: Expose compare "max_queue_size" to users
      qemu-options.hx: Clean up and fix typo for colo-compare

erik-smit (1):
      ftgmac100: fix dblac write test

 hw/net/ftgmac100.c     | 14 +++++++------
 hw/net/net_tx_pkt.c    | 15 ++++++++++---
 hw/net/virtio-net.c    |  1 +
 include/qemu/sockets.h |  1 +
 net/colo-compare.c     | 43 ++++++++++++++++++++++++++++++++++++-
 net/socket.c           |  9 ++++++--
 net/tap-bsd.c          |  2 +-
 net/tap-linux.c        |  8 ++++---
 net/tap-solaris.c      |  2 +-
 net/tap-stub.c         |  2 +-
 net/tap.c              | 50 +++++++++++++++++++++++++++++++++++--------
 net/tap_int.h          |  2 +-
 qemu-options.hx        | 33 +++++++++++++++--------------
 util/oslib-posix.c     | 26 ++++++++++++++++-------
 util/oslib-win32.c     | 57 ++++++++++++++++++++++++++++----------------------
 15 files changed, 188 insertions(+), 77 deletions(-)


