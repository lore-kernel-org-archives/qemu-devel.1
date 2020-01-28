Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221BBC32771
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 01:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD0921739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 01:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4OQY5mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD0921739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwFMW-0003OV-3Z
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 20:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iwFLZ-0002CL-Sr
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 20:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iwFLX-0003PO-Dc
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 20:07:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59275
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iwFLX-0003Nn-3k
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 20:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580173634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n1UklUiJv/QvsBb5Zzu1vuZ3Eah/gvOHogFSRqXz4hQ=;
 b=b4OQY5mjqk/vgGlcBwy2bdOh+BKd+HDCUrx5ylWNkPItxM+n3nra25b7xqOGCDqWWs8RYM
 srIqQgp9oMJopvT0aPYZY6x0za+Veh5VYaFOWj7LEajwmyvynVDf6AKB2S6Lj5lh8R5+TT
 bgYuBHQAXfgJjCYEJfcsGT2bimiaHqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-AOtwYHtkNemJ-DL1_fbPlA-1; Mon, 27 Jan 2020 20:07:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 714F6477;
 Tue, 28 Jan 2020 01:07:11 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-116.bos.redhat.com [10.18.17.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 156DF5D9CA;
 Tue, 28 Jan 2020 01:07:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 0/2] Ide patches
Date: Mon, 27 Jan 2020 20:07:05 -0500
Message-Id: <20200128010707.19572-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: AOtwYHtkNemJ-DL1_fbPlA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 105b07f1ba462ec48b27e5cb74ddf81c6a79364c=
:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200127' into st=
aging (2020-01-27 13:02:36 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to 59805ae92dfe4f67105e36b539d567caec4f8304:

  tests/ide-test: Create a single unit-test covering more PRDT cases (2020-=
01-27 17:07:31 -0500)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Alexander Popov (2):
  ide: Fix incorrect handling of some PRDTs in ide_dma_cb()
  tests/ide-test: Create a single unit-test covering more PRDT cases

 hw/ide/core.c          |  30 +++++--
 tests/qtest/ide-test.c | 176 ++++++++++++++++++-----------------------
 2 files changed, 97 insertions(+), 109 deletions(-)

--=20
2.21.0


