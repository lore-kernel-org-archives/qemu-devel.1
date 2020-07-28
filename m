Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B959BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D2A20663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUKw9WsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D2A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0PzP-0001BH-QG
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0PyL-00085c-1e
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:48:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32396
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0PyJ-0003sm-Eg
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595944126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pDWT/1NcFsCuzsPcKwknTSgKGkHgGCJI4DZONXyXSKw=;
 b=UUKw9WsWjRQyHCnyKXoC+7DhdO/V21aW1U8U0/NKG+Z8dECAYglEaUQLLCtUEvVTbxhXZN
 wtQStpS5tQfvUWDwl7fSjZAR0eZ3xHbImpYj0Pny35sLcBaBgCgSl+BKAp0XbZa3tvpZxM
 mwIN9GfQ8xXW30FtzPNkoyl7rKWvpko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-3BvCYnvSMOGB1iaXexXOjQ-1; Tue, 28 Jul 2020 09:48:43 -0400
X-MC-Unique: 3BvCYnvSMOGB1iaXexXOjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47123100A623;
 Tue, 28 Jul 2020 13:48:42 +0000 (UTC)
Received: from localhost (ovpn-112-145.ams2.redhat.com [10.36.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE08E19C4F;
 Tue, 28 Jul 2020 13:48:41 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/3] Block patches for 5.1.0-rc2?
Date: Tue, 28 Jul 2020 15:48:37 +0200
Message-Id: <20200728134840.1557546-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Sorry for the very late pull request.  The iotest issue only appeared
today, and the I/O path issue was only tracked down today.  We need the
fixes for the latter in 5.1, so if they do not make it into rc2, we will
need them in rc3.


The following changes since commit 23ae28783f4674e98f7539d1c05d793166c2fc12:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-07-27' into staging (2020-07-28 09:15:44 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-07-28

for you to fetch changes up to afac471b71da92d91cc56fb64c0719b8a4a2d96b:

  iotests/197: Fix for non-qcow2 formats (2020-07-28 15:28:56 +0200)

----------------------------------------------------------------
Block patches for 5.1.0:
- Fix block I/O for split transfers
- Fix iotest 197 for non-qcow2 formats

----------------------------------------------------------------
Max Reitz (3):
  block: Fix bdrv_aligned_p*v() for qiov_offset != 0
  iotests/028: Add test for cross-base-EOF reads
  iotests/197: Fix for non-qcow2 formats

 block/io.c                 | 10 ++++++----
 tests/qemu-iotests/028     | 19 +++++++++++++++++++
 tests/qemu-iotests/028.out | 11 +++++++++++
 tests/qemu-iotests/197     |  8 +++++---
 tests/qemu-iotests/197.out |  2 +-
 5 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.26.2


