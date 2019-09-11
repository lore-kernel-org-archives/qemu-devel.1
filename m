Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704A7C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2ABA20644
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2ABA20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83ss-0002p9-0B
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i83jW-0000D1-MQ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i83jV-0000rn-HS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:36:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37008)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i83jR-0000ph-GE; Wed, 11 Sep 2019 10:36:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 623BD3098433;
 Wed, 11 Sep 2019 14:36:28 +0000 (UTC)
Received: from localhost (ovpn-116-185.ams2.redhat.com [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2577460852;
 Wed, 11 Sep 2019 14:36:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 16:36:11 +0200
Message-Id: <20190911143612.17881-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 11 Sep 2019 14:36:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/1] Block patches
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
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit cc6613e244e86c66f83467eab5284825d7057c=
ea:

  Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2019-09-03 11:06:09 +0100)

are available in the Git repository at:

  https://github.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to ebb6ff25cd888a52a64a9adc3692541c6d1d9a42:

  virtio-blk: Cancel the pending BH when the dataplane is reset (2019-09-=
03 16:11:18 +0100)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (1):
  virtio-blk: Cancel the pending BH when the dataplane is reset

 hw/block/dataplane/virtio-blk.c | 3 +++
 1 file changed, 3 insertions(+)

--=20
2.21.0


