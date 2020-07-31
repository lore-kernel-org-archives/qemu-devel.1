Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988A7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DE12084D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhM9QLPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DE12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Qpt-0004Vj-Iu
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 04:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k1Qou-0003IL-HZ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:55:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56767
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k1Qos-00088M-7N
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596185713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZnbpfmQwlyBxJrF0IB0tE2wAr4kk5J0FI76evJCVvIk=;
 b=QhM9QLPD82hZN6Vc3z4xmPFCERAc/hUD8VmMNvQxFb19KRQ54mKixSlB6CV1yJldm04M0h
 5TvYdM47qVxgH43RHQ7TnJemdNzA7v0EIxb98h5XSbnBW50x69uzeAQOZJGnQ0MNRWFmDW
 7azVLE6duVm/kGMdR5Xb8pcStbEF9P0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-3KYKdy_AOfed-_VbrBg-XA-1; Fri, 31 Jul 2020 04:55:09 -0400
X-MC-Unique: 3KYKdy_AOfed-_VbrBg-XA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B7C1106B245;
 Fri, 31 Jul 2020 08:55:08 +0000 (UTC)
Received: from localhost (ovpn-113-36.ams2.redhat.com [10.36.113.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17AED619C4;
 Fri, 31 Jul 2020 08:55:07 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/1] another s390x fix
Date: Fri, 31 Jul 2020 10:55:02 +0200
Message-Id: <20200731085503.9008-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 04:39:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 5772f2b1fc5d00e7e04e01fa28e9081d6550440a:

  Update version for v5.1.0-rc2 release (2020-07-28 21:51:03 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20200731

for you to fetch changes up to 148d25e0f6ad1dc3bd6aace092d65262d4217ec6:

  s390x/s390-virtio-ccw: fix off-by-one in loadparm getter (2020-07-30 16:53:34 +0200)

----------------------------------------------------------------
Fix a problem introduced in a recent fix.

----------------------------------------------------------------

Halil Pasic (1):
  s390x/s390-virtio-ccw: fix off-by-one in loadparm getter

 hw/s390x/s390-virtio-ccw.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
2.25.4


