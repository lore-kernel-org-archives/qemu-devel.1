Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429F9C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098EE20719
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSJoGXTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098EE20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGidn-00037t-7F
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGiZ5-00050l-PD
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGiZ3-0008GJ-UU
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:21:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57255)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGiZ2-0008FR-Qq
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585052505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B3kjy8ohvVygjtmlMo5608bl39AdOc5SHdkn12QMD1Y=;
 b=ZSJoGXTvq8xPGVdHq/cvYOjllpNi5zibF8/hmvLb2mt6WNaoGxJZ18x1BlxDopW4+Bm82S
 Nv2/f4UGBXpt/ggit7BM5kwWUptUFHxyjcrtAbp5wXMangm788Kcprp8KdoK2nf8dm/PGQ
 7AMIBd5Z1+PRwieZfjW0aNfET/QOka8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-pWgz4GC2OtODtbpEn4vPfQ-1; Tue, 24 Mar 2020 08:20:48 -0400
X-MC-Unique: pWgz4GC2OtODtbpEn4vPfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E8201005512;
 Tue, 24 Mar 2020 12:20:47 +0000 (UTC)
Received: from localhost (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17E6F5C1B2;
 Tue, 24 Mar 2020 12:20:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/6] Block patches for 5.0-rc0
Date: Tue, 24 Mar 2020 13:20:38 +0100
Message-Id: <20200324122044.1131326-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

The following changes since commit f1e748d27996e0cd8269db837a32e453dd55930a=
:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' i=
nto staging (2020-03-23 20:54:24 +0000)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-03-24

for you to fetch changes up to c264e5d2f9f5d73977eac8e5d084f727b3d07ea9:

  iotests/026: Move v3-exclusive test to new file (2020-03-24 12:05:31 +010=
0)

----------------------------------------------------------------
Block patches for 5.0-rc0:
- Use-after-free fix
- Fix for a memleak in an error path
- Preventative measures against other potential use-after-frees, and
  against NULL deferences at runtime
- iotest fixes

----------------------------------------------------------------
Eric Blake (1):
  block: Avoid memleak on qcow2 image info failure

Max Reitz (2):
  iotests: Fix cleanup path in some tests
  iotests/026: Move v3-exclusive test to new file

Philippe Mathieu-Daud=C3=A9 (1):
  block: Assert BlockDriver::format_name is not NULL

Vladimir Sementsov-Ogievskiy (2):
  block: bdrv_set_backing_bs: fix use-after-free
  block/qcow2: zero data_file child after free

 block.c                            |  3 +-
 block/qcow2.c                      |  3 +
 tests/qemu-iotests/026             | 31 -----------
 tests/qemu-iotests/026.out         |  6 --
 tests/qemu-iotests/026.out.nocache |  6 --
 tests/qemu-iotests/085             |  1 +
 tests/qemu-iotests/087             |  6 ++
 tests/qemu-iotests/279             |  2 +-
 tests/qemu-iotests/289             | 89 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/289.out         |  8 +++
 tests/qemu-iotests/group           |  1 +
 11 files changed, 111 insertions(+), 45 deletions(-)
 create mode 100755 tests/qemu-iotests/289
 create mode 100644 tests/qemu-iotests/289.out

--=20
2.25.1


