Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622D1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296A722CBB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xrc0ecms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296A722CBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGuq-0006CO-DW
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kBGu1-00054o-9Y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:21:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34545
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kBGtv-0003YL-Kr
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598530866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9mcSnuakDcYSbNzV58vokaNxe46FlQjiIbX9vMmYmCc=;
 b=Xrc0ecmsuVdoEUEbgpu2THKbV1vi7WEX4BzdYUjVWhA1MChhMc/S7R8zxfxD9+4e1q8DOl
 QVj3DCvicmy0qYrgfV85KfkYDK5vTy9BnCdeRG3CUG1pJP28sHMJtizoORVBjiF88q5N5j
 Z3Ih4TYpB7uUp3uIwInBrBubtfBU5jQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-246Rt82OMrGsM6g7PyUGOw-1; Thu, 27 Aug 2020 08:21:03 -0400
X-MC-Unique: 246Rt82OMrGsM6g7PyUGOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22FAB189E60D;
 Thu, 27 Aug 2020 12:21:02 +0000 (UTC)
Received: from localhost (ovpn-113-237.ams2.redhat.com [10.36.113.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A746F19930;
 Thu, 27 Aug 2020 12:21:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/3] s390x patches
Date: Thu, 27 Aug 2020 14:20:54 +0200
Message-Id: <20200827122057.232662-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 8e49197ca5e76fdb8928833b2649ef13fc5aab2f:

  Merge remote-tracking branch 'remotes/hdeller/tags/target-hppa-v3-pull-request' into staging (2020-08-26 22:23:53 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20200827

for you to fetch changes up to 0216b18b79c432585b9cc49532c6223d766d552f:

  hw/vfio/ap: Plug memleak in vfio_ap_get_group() (2020-08-27 12:37:03 +0200)

----------------------------------------------------------------
- document s390x boot devices
- bug fixes

----------------------------------------------------------------

Cornelia Huck (1):
  virtio-ccw-input: fix description

Pan Nengyuan (1):
  hw/vfio/ap: Plug memleak in vfio_ap_get_group()

Thomas Huth (1):
  docs/system/s390x: Add a chapter about s390x boot devices

 docs/system/s390x/bootdevices.rst | 82 +++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst      |  1 +
 hw/s390x/virtio-ccw-input.c       |  2 +-
 hw/vfio/ap.c                      |  1 +
 4 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/s390x/bootdevices.rst

-- 
2.25.4


