Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCD5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C89020792
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tg0H8+9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C89020792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsQh-0007WF-F6
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jxsPn-0006cY-Rj
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:34:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53053
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jxsPl-0004Vd-4P
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595338476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=qnTucw7BkcLXUJP/7CrLrTeBEzH21ANWvhKnPBOY8/k=;
 b=Tg0H8+9BHOdvK0ajAyVvt0Z34oqAQ8n5R8Zi7VtDl6Xpr+pTJ1q8ElW4EVJu/gSqfLVHzA
 SafUNJafkj/xjDVGhuekhAF3Lk0pYQZ9YkWF+UDumrGiQMzURa0kLPfxQd5NPtduocPEvc
 eIwGMa3BhdZoZ0NR2rkwxdQrQsy6aNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-aQt9KT7vMz2TIj6SGhABZw-1; Tue, 21 Jul 2020 09:34:32 -0400
X-MC-Unique: aQt9KT7vMz2TIj6SGhABZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 546DE107ACCA;
 Tue, 21 Jul 2020 13:34:31 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-193.pek2.redhat.com
 [10.72.12.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBC8F87B0D;
 Tue, 21 Jul 2020 13:34:29 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 0/2] Net patches
Date: Tue, 21 Jul 2020 21:34:25 +0800
Message-Id: <1595338467-19556-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
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
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 90218a9a393c7925f330e7dcc08658e2a01d3bd4:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-07-21' into staging (2020-07-21 10:24:38 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 5519724a13664b43e225ca05351c60b4468e4555:

  hw/net/xgmac: Fix buffer overflow in xgmac_enet_send() (2020-07-21 21:30:39 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Andrew (1):
      hw/net: Added plen fix for IPv6

Mauro Matteo Cascella (1):
      hw/net/xgmac: Fix buffer overflow in xgmac_enet_send()

 hw/net/net_tx_pkt.c | 23 +++++++++++++++++++++++
 hw/net/net_tx_pkt.h | 14 ++++++++++++++
 hw/net/xgmac.c      | 14 ++++++++++++--
 include/net/eth.h   |  1 +
 4 files changed, 50 insertions(+), 2 deletions(-)


