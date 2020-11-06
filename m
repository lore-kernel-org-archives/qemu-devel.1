Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8EFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 13:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D371E206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 13:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuR+tD8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D371E206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb1bL-0002jJ-RW
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 08:16:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kb1Y8-0007jg-Qg
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:13:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kb1Y7-0003oK-4J
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604668382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C0VsjSSDlbrIGHgAgyA7bh2fx8+Dy7/hp8H57Ig5gkc=;
 b=KuR+tD8DMlHrrX3fSrQbUKtZ8asT0b21VBZMArx4TFoqOGeRxcslcMQV7C6dZH0Lyez1AS
 AHsfyVhXrrRJTQ/+CE7irrdOnfvbAtkSaSJk2Kv6cEddvmObOMtcytwG+NHOZ9zAtpQaZH
 n/y4EBkvhOq4n8SKWYOck5XhWR5s/ik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-6eDzxm2wNPmXUUyh4E2lgg-1; Fri, 06 Nov 2020 08:12:57 -0500
X-MC-Unique: 6eDzxm2wNPmXUUyh4E2lgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C358107B47A;
 Fri,  6 Nov 2020 13:12:56 +0000 (UTC)
Received: from gondolin.redhat.com (ovpn-114-59.ams2.redhat.com [10.36.114.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F3CD9F63;
 Fri,  6 Nov 2020 13:12:55 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL for-5.2 0/4] s390x fixes
Date: Fri,  6 Nov 2020 14:12:48 +0100
Message-Id: <20201106131252.953499-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:30:30
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3d6e32347a3b57dac7f469a07c5f520e69bd070a:

  Update version for v5.2.0-rc0 release (2020-11-03 21:11:57 +0000)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20201106

for you to fetch changes up to 77280d33bc9cfdbfb5b5d462259d644f5aefe9b3:

  s390x: fix build for --without-default-devices (2020-11-05 13:04:07 +0100)

----------------------------------------------------------------
some s390x fixes, including a bios update

----------------------------------------------------------------

Cornelia Huck (2):
  pc-bios/s390: update s390-ccw bios binaries
  s390x: fix build for --without-default-devices

Jason J. Herne (1):
  s390-bios: Skip writing iplb location to low core for ccw ipl

Pavel Dovgalyuk (1):
  target/s390x: fix execution with icount

 hw/s390x/meson.build             |   2 +-
 include/hw/s390x/s390-pci-vfio.h |   3 +-
 pc-bios/s390-ccw.img             | Bin 42608 -> 46704 bytes
 pc-bios/s390-ccw/main.c          |   4 +-
 pc-bios/s390-netboot.img         | Bin 67232 -> 71328 bytes
 target/s390x/insn-data.def       |  70 +++++++++++++++----------------
 target/s390x/translate.c         |  15 +++++++
 7 files changed, 56 insertions(+), 38 deletions(-)

-- 
2.26.2


