Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42625C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A1F214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsZEWlB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A1F214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSivw-0007ll-0F
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSirN-0002hT-Ca
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSirM-0004bj-4v
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:34:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58918
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSirM-0004bU-1A
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573137243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BU5CTWObR/gc1QtVCNsoEt3My/ik3tUTSZr9Wb8faKA=;
 b=GsZEWlB0cu/AnaVTPb0Y3YvPmCFNFxRdOfketay4uiXbtrVYhVbmVMyyAlToH/jTPYIA3A
 vut8zGTIWb6IIxD9l7V8GxEOim0QyeKZNWO0Ktv6EpotMYl91v0ZDvcWitglwVyU2A3Bfd
 FEfVLphj8FA22Hb2iDvopI8P2Teo5u4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-5SOoTcD0Pg2JpSwwzghKjQ-1; Thu, 07 Nov 2019 09:34:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E47751800D6B;
 Thu,  7 Nov 2019 14:33:58 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83C2660BFB;
 Thu,  7 Nov 2019 14:33:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/3] Block patches for 4.2.0-rc0/4.1.1
Date: Thu,  7 Nov 2019 15:33:53 +0100
Message-Id: <20191107143356.579334-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 5SOoTcD0Pg2JpSwwzghKjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d0f90e1423b4f412adc620eee93e8bfef8af4117=
:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191106-pull-req=
uest' into staging (2019-11-07 09:21:52 +0000)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-11-07

for you to fetch changes up to b7cd2c11f76d27930f53d3cf26d7b695c78d613b:

  iotests: Add test for 4G+ compressed qcow2 write (2019-11-07 14:37:46 +01=
00)

----------------------------------------------------------------
Block patches for 4.2.0-rc0/4.1.1:
- Fix writing to compressed qcow2 images > 4 GB
- Fix size sanity check for qcow2 bitmaps

----------------------------------------------------------------
Max Reitz (2):
  qcow2: Fix QCOW2_COMPRESSED_SECTOR_MASK
  iotests: Add test for 4G+ compressed qcow2 write

Tuguoyi (1):
  qcow2-bitmap: Fix uint64_t left-shift overflow

 block/qcow2-bitmap.c       | 14 +++++--
 block/qcow2.h              |  2 +-
 tests/qemu-iotests/272     | 79 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/272.out | 10 +++++
 tests/qemu-iotests/group   |  1 +
 5 files changed, 102 insertions(+), 4 deletions(-)
 create mode 100755 tests/qemu-iotests/272
 create mode 100644 tests/qemu-iotests/272.out

--=20
2.23.0


