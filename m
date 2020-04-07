Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B610C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2583F2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTJvytgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2583F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46735 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLnWl-0003LE-BV
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jLnUA-0007Wj-3l
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jLnU0-0006dm-9l
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33942
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jLnU0-0006cm-4M
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586263054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wyIIBA16POVvuNvyqS0umZFedITpZnJEEqXlqCdfpok=;
 b=MTJvytgT+G//stUSDCRK0Y8MOeXY5Hlz1xZYHDfer1xOIsmDaOxVO7wcNv4J7RoHfim97b
 oF4dH2hD4vs3UWORQWpsjM+scSo2UPv7AJrn+6qXolRJmNzVGKiH7U/4l2HMXbKzbNWqvX
 Vb7/kgif2CQOG6/m6CEbB9yg4f88i0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249--_xzoFA5PIGVhTpZhVrn-g-1; Tue, 07 Apr 2020 08:37:30 -0400
X-MC-Unique: -_xzoFA5PIGVhTpZhVrn-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 990FE13F8;
 Tue,  7 Apr 2020 12:37:29 +0000 (UTC)
Received: from localhost (ovpn-114-84.ams2.redhat.com [10.36.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 129E75C28E;
 Tue,  7 Apr 2020 12:37:28 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 0/5] Block patches for 5.0-rc2
Date: Tue,  7 Apr 2020 14:37:22 +0200
Message-Id: <20200407123727.829933-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c250=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
406' into staging (2020-04-06 12:36:45 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-04-07

for you to fetch changes up to 36d883ba0de8a281072ded2b51e0a711fd002139:

  xen-block: Fix double qlist remove and request leak (2020-04-07 13:51:09 =
+0200)

----------------------------------------------------------------
Block patches for 5.0-rc2:
- Fix double QLIST_REMOVE() and potential request object leak in
  xen-block
- Prevent a potential assertion failure in qcow2's code for compressed
  clusters by rejecting invalid (unaligned) requests with -EIO
- Prevent discards on qcow2 v2 images from making backing data reappear
- Make qemu-img convert report I/O error locations by byte offsets
  consistently
- Fix for potential I/O test errors (accidental globbing due to missing
  quotes)

----------------------------------------------------------------
Alberto Garcia (2):
  qcow2: Forbid discard in qcow2 v2 images with backing files
  qcow2: Check request size in qcow2_co_pwritev_compressed_part()

Anthony PERARD (1):
  xen-block: Fix double qlist remove and request leak

Eric Blake (1):
  qemu-img: Report convert errors by bytes, not sectors

Max Reitz (1):
  iotests/common.pattern: Quote echos

 block/qcow2.c                     | 11 ++++
 hw/block/dataplane/xen-block.c    | 48 +++++----------
 qemu-img.c                        |  8 +--
 tests/qemu-iotests/046            | 10 ++--
 tests/qemu-iotests/046.out        | 12 ++--
 tests/qemu-iotests/060            | 12 ++--
 tests/qemu-iotests/060.out        |  2 -
 tests/qemu-iotests/177            |  5 +-
 tests/qemu-iotests/244.out        |  2 +-
 tests/qemu-iotests/290            | 97 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/290.out        | 61 +++++++++++++++++++
 tests/qemu-iotests/common.pattern | 22 +++----
 tests/qemu-iotests/group          |  1 +
 13 files changed, 224 insertions(+), 67 deletions(-)
 create mode 100755 tests/qemu-iotests/290
 create mode 100644 tests/qemu-iotests/290.out

--=20
2.25.1


