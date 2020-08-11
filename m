Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298AAC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75B520774
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuoCgAIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75B520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Qhq-0001KQ-5N
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k5Qge-00009Q-Qh
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:35:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60083
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k5Qgb-0001DU-48
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597138512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3X1yIDN/LqNfY7EMNjv87P4b1lHKGv3jW5s4svdstqs=;
 b=CuoCgAIlR1+FdYk1Uyo+KlLIDiKSAwv/vm5utckfMfK2L88oV+myoXffEpaDSnpCdf7po2
 SlOBq+FKqYeEmPMaPqOEW9r2WWDIOp6ef9lsJ4FrhtLmAEqoydspJIL+ORvjfHVYq4d+9F
 g7WU1htSRtqiJTtmF5ZVKfgbS8+GguM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-mDuqCDPoP5ySB28dr0xgpA-1; Tue, 11 Aug 2020 05:35:08 -0400
X-MC-Unique: mDuqCDPoP5ySB28dr0xgpA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C88C79EC1;
 Tue, 11 Aug 2020 09:35:07 +0000 (UTC)
Received: from localhost (ovpn-113-152.ams2.redhat.com [10.36.113.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B29F87C0F5;
 Tue, 11 Aug 2020 09:35:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/2] Block patches for 5.1.0-rc4
Date: Tue, 11 Aug 2020 11:35:03 +0200
Message-Id: <20200811093505.972894-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:41:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

There is a bug in the backup job that breaks backups from images whose
size is not aligned to the job's cluster size (i.e., qemu crashes
because of a failed assertion).  If this bug makes it into the release,
it would be a regression from 5.0.

On one hand, this is probably a rare configuration that should not
happen in practice.  On the other, it is a regression, and the fix
(patch 1) is simple.  So I think it would be good to have this in 5.1.


The following changes since commit e1d322c40524d2c544d1fcd37b267d106d16d328:

  Update version for v5.1.0-rc3 release (2020-08-05 17:37:17 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-08-11

for you to fetch changes up to 1f3765b652930a3b485f1a67542c2410c3774abe:

  iotests: add test for unaligned granularity bitmap backup (2020-08-11 09:29:31 +0200)

----------------------------------------------------------------
Block patches for 5.1.0-rc4:
- Fix abort when running a backup job on an image whose size is not
  aligned to the backup job's cluster size

----------------------------------------------------------------
Stefan Reiter (2):
  block/block-copy: always align copied region to cluster size
  iotests: add test for unaligned granularity bitmap backup

 block/block-copy.c         |  3 ++
 tests/qemu-iotests/304     | 60 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/304.out |  2 ++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 66 insertions(+)
 create mode 100755 tests/qemu-iotests/304
 create mode 100644 tests/qemu-iotests/304.out

-- 
2.26.2


