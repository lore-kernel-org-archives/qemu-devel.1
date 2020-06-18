Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CD5C4345B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20671206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTude5kA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20671206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwf0-0003Bn-BM
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlwd9-0000hY-Bn
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:39:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33860
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlwd7-0008R1-6Y
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592494743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D8bZCXL6cAd47Myser6t+PbMIdsNoELu/cwifDR18jo=;
 b=bTude5kApBhEbWotL+8fXjtvZGlk4n+vSCkNpQu4x4GRl5067mWfbArQTaIQMCy/csig0s
 K6Q0UgdsePeAx8MzXFCQGs3rhtmFrTszBZdLWoS4QwKGc7HHgFMvTsxKk85Xnm1GAHllY+
 ebStgyACSciek4/1gyAfoWkdWIIW6c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-mFmfc_g8MQ27Yq1auvqlWA-1; Thu, 18 Jun 2020 11:38:59 -0400
X-MC-Unique: mFmfc_g8MQ27Yq1auvqlWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94858BFC3;
 Thu, 18 Jun 2020 15:38:58 +0000 (UTC)
Received: from localhost (ovpn-113-9.ams2.redhat.com [10.36.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C4E95D9E8;
 Thu, 18 Jun 2020 15:38:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/7] s390x update
Date: Thu, 18 Jun 2020 17:38:47 +0200
Message-Id: <20200618153854.271723-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 26bf4a29213b432eb390726c698a1915550a9cf9:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200617-pull-request' into staging (2020-06-17 16:24:24 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20200618

for you to fetch changes up to 458e056257e67254546e58158f3f74ce040c7ca1:

  docs/s390x: fix vfio-ap device_del description (2020-06-18 12:14:06 +0200)

----------------------------------------------------------------
s390x update:
- update Linux headers to 5.8-rc1 (for vfio-ccw path handling)
- vfio-ccw: add support for path handling
- documentation fix

----------------------------------------------------------------

Christian Borntraeger (1):
  docs/s390x: fix vfio-ap device_del description

Cornelia Huck (1):
  Linux headers: update

Eric Farman (3):
  vfio-ccw: Refactor cleanup of regions
  vfio-ccw: Refactor ccw irq handler
  s390x/css: Refactor the css_queue_crw() routine

Farhan Ali (2):
  vfio-ccw: Add support for the schib region
  vfio-ccw: Add support for the CRW region and IRQ

 docs/system/s390x/vfio-ap.rst                |   8 +-
 hw/s390x/css.c                               |  57 +++-
 hw/s390x/s390-ccw.c                          |  21 ++
 hw/vfio/ccw.c                                | 208 ++++++++++--
 include/hw/s390x/css.h                       |   4 +-
 include/hw/s390x/s390-ccw.h                  |   1 +
 include/standard-headers/asm-x86/kvm_para.h  |  17 +-
 include/standard-headers/drm/drm_fourcc.h    | 140 +++++++-
 include/standard-headers/linux/ethtool.h     |  16 +-
 include/standard-headers/linux/virtio_ids.h  |   1 +
 include/standard-headers/linux/virtio_mem.h  | 211 ++++++++++++
 include/standard-headers/linux/virtio_ring.h |  48 ++-
 linux-headers/asm-arm64/mman.h               |   8 +
 linux-headers/asm-generic/unistd.h           |   4 +-
 linux-headers/asm-mips/unistd_n32.h          |   1 +
 linux-headers/asm-mips/unistd_n64.h          |   1 +
 linux-headers/asm-mips/unistd_o32.h          |   1 +
 linux-headers/asm-powerpc/unistd_32.h        |   1 +
 linux-headers/asm-powerpc/unistd_64.h        |   1 +
 linux-headers/asm-s390/unistd_32.h           |   1 +
 linux-headers/asm-s390/unistd_64.h           |   1 +
 linux-headers/asm-x86/kvm.h                  |  20 +-
 linux-headers/asm-x86/unistd.h               |  11 +-
 linux-headers/asm-x86/unistd_32.h            |   1 +
 linux-headers/asm-x86/unistd_64.h            |   1 +
 linux-headers/asm-x86/unistd_x32.h           |   1 +
 linux-headers/linux/kvm.h                    |  18 +-
 linux-headers/linux/psp-sev.h                |   2 +
 linux-headers/linux/vfio.h                   | 322 +++++++++++++++++++
 linux-headers/linux/vfio_ccw.h               |  19 ++
 linux-headers/linux/vhost.h                  |   4 +
 target/s390x/ioinst.c                        |   3 +-
 32 files changed, 1075 insertions(+), 78 deletions(-)
 create mode 100644 include/standard-headers/linux/virtio_mem.h

-- 
2.25.4


