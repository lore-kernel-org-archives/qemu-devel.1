Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749F9CA9EC0
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 02:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DF520862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 02:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6e3maeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DF520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPHSZ-0007ai-Vd
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 22:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iPHPb-0004jN-UT
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 22:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iPHOH-0002Uo-LK
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 22:37:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59304
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iPHOH-0002UT-HV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 22:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572316668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1jd1f2O8sxtOFtcALRFCkZLP7AimjnDt3MIB598W/yg=;
 b=h6e3maeWCDBxj0yO2VjrhJ+epTXPkrqOLz2PxGd4Y4jsxXyHsWq/5rirYbKRL+FkhiF+e2
 i8J6rUt9Hm5g4m9oloyTFkmQfEERKeHxR76B+S30ym9t49eivcGhKXCNs814cYEbkEwZSF
 2qvn+QhZP8WSjb+NdNHRPaffd3PoC1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-gqJ-9mzOOzi23K9cTR7l7Q-1; Mon, 28 Oct 2019 22:37:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60A1381A334;
 Tue, 29 Oct 2019 02:37:45 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-230.pek2.redhat.com
 [10.72.12.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09AA619C77;
 Tue, 29 Oct 2019 02:37:43 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL V2 0/4] Net patches
Date: Tue, 29 Oct 2019 10:37:37 +0800
Message-Id: <1572316661-20043-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gqJ-9mzOOzi23K9cTR7l7Q-1
X-Mimecast-Spam-Score: 0
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
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 187f35512106501fe9a11057f4d8705431e0026d=
:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-2510=
19-3' into staging (2019-10-26 10:13:48 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 1e907a32b77e5d418538453df5945242e43224fa:

  COLO-compare: Fix incorrect `if` logic (2019-10-29 10:28:07 +0800)

----------------------------------------------------------------

Changes from V1:

- Fix compling issue

----------------------------------------------------------------
Fan Yang (1):
      COLO-compare: Fix incorrect `if` logic

Michael S. Tsirkin (1):
      virtio: new post_load hook

Mikhail Sennikovsky (1):
      virtio-net: prevent offloads reset on migration

Sven Schnelle (1):
      net: add tulip (dec21143) driver

 MAINTAINERS                    |    6 +
 hw/net/Kconfig                 |    5 +
 hw/net/Makefile.objs           |    1 +
 hw/net/trace-events            |   14 +
 hw/net/tulip.c                 | 1029 ++++++++++++++++++++++++++++++++++++=
++++
 hw/net/tulip.h                 |  267 +++++++++++
 hw/net/virtio-net.c            |   27 +-
 hw/virtio/virtio.c             |    7 +
 include/hw/pci/pci_ids.h       |    1 +
 include/hw/virtio/virtio-net.h |    2 +
 include/hw/virtio/virtio.h     |    6 +
 net/colo-compare.c             |    6 +-
 12 files changed, 1365 insertions(+), 6 deletions(-)
 create mode 100644 hw/net/tulip.c
 create mode 100644 hw/net/tulip.h



