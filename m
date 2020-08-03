Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E015EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC566206DA
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjE6fkjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC566206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2bCz-0002LZ-Ny
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 10:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k2bC6-0001QI-WD
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 10:12:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k2bC4-0002AY-Gb
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 10:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596463919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k84u7jVWYWXgn0pEoMmrFajwfMrJgZHWJv3zxJqt6G0=;
 b=XjE6fkjX+KNooVRopKd32/kUH5+rEou/Gj1qkkf3H4uR8TcutIwYfjhS4FlCeAPdZRejgD
 n1H0TIyL22lgAKp0kCjPDSDsQNwkDEwBkvDI8uv69mHsHowSFyyJNAP+hLEybIoLKDGPdo
 Ep4XCZpn8Y2fUgzuVtekSiHu2C7/Se0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-3zjNinnVOu-osu3ULeHieg-1; Mon, 03 Aug 2020 10:11:51 -0400
X-MC-Unique: 3zjNinnVOu-osu3ULeHieg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AB66102C80A
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 14:11:50 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-122.phx2.redhat.com [10.3.113.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 47BEE1001B0B
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 14:11:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] bitmaps patches for -rc3, 2020-08-03
Date: Mon,  3 Aug 2020 09:11:45 -0500
Message-Id: <20200803141147.88923-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 01:24:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 6c5dfc9ccb643a0d50fdec9f10806b14960571d1:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-08-03' into staging (2020-08-03 12:21:57 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-08-03

for you to fetch changes up to edadc99a2ee90daeaaf4fba21d623ec8efe7c8e6:

  iotests/169: Test source cont with backing bmap (2020-08-03 08:59:37 -0500)

----------------------------------------------------------------
bitmaps patches for 2020-08-03

- fix bitmap migration involving read-only bitmap from backing chain

----------------------------------------------------------------
Max Reitz (2):
      qcow2: Release read-only bitmaps when inactivated
      iotests/169: Test source cont with backing bmap

 block/qcow2-bitmap.c       | 23 ++++++++++++++---
 tests/qemu-iotests/169     | 64 +++++++++++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/169.out |  4 +--
 3 files changed, 84 insertions(+), 7 deletions(-)

-- 
2.28.0


