Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849C2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 06:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783A820781
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 06:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIg16IIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783A820781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2qf7-0006PY-FZ
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 02:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k2qdX-0005BH-4h
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 02:41:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49841
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k2qdV-0004Fh-05
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 02:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596523278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6I2cVDZBdUEMRxKWTxLd/WV/UDtYOb9i5EsSiSXkkjU=;
 b=ZIg16IIW1Fu4cf/Bn1q393uLyisqsfxp6JbwOolmBucNdQsFApXpIsTTm9dkotvXfjrVWu
 uOr5HgD2slxHU5TFhPJRcwkjzlLccSmJbTGiXIlefGaUQclNiLHRnlknoE1Mc05lgotG8H
 C87s43t+q0RCIo6ohmbN0UHtwOZJyIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-EfDCMU85OeqWketQ8rHYeQ-1; Tue, 04 Aug 2020 02:41:15 -0400
X-MC-Unique: EfDCMU85OeqWketQ8rHYeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E20C31005510;
 Tue,  4 Aug 2020 06:41:14 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-166.pek2.redhat.com
 [10.72.13.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 636E360BF4;
 Tue,  4 Aug 2020 06:41:13 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 0/2] Net patches
Date: Tue,  4 Aug 2020 14:41:08 +0800
Message-Id: <1596523270-5492-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 5c1c3e4f02e458cf280c677c817ae4fd1ed9bf10:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200803' into staging (2020-08-03 20:34:26 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 035e69b063835a5fd23cacabd63690a3d84532a8:

  hw/net/net_tx_pkt: fix assertion failure in net_tx_pkt_add_raw_fragment() (2020-08-04 14:14:48 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Lukas Straub (1):
      colo-compare: Remove superfluous NULL-pointer checks for s->iothread

Mauro Matteo Cascella (1):
      hw/net/net_tx_pkt: fix assertion failure in net_tx_pkt_add_raw_fragment()

 hw/net/net_tx_pkt.c | 5 ++++-
 net/colo-compare.c  | 8 ++------
 2 files changed, 6 insertions(+), 7 deletions(-)


