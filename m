Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DFCCA9ED0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 22:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2550821A4A
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 22:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B72gvyWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2550821A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iROKn-0005XT-21
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 17:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iROJO-0004Qh-1v
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 17:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iROJL-0002Ph-Ji
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 17:25:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47218
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iROJL-0002Nt-3k
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 17:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572819924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N9A+BLewkhKcu78u2ct6sMnSMqXi7cZfOEqC5Ts2pp4=;
 b=B72gvyWMA9ZI8+RFmQ2A1uBvseAF/xaKHVO5RvoHJSd0egr9czo0GevQGNOae3W/R346pd
 EEvbR4L6QD4qsyiZsLm8osAO34ZotsO8niC/Tzf8AbJHLgfSoN2xDeHrFo1t7uUIMNOtGq
 iQRBSTm5wdSV17yRNF3JBbNe1Eimjsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-u_Vuau8dMk6XFUXK5ifr4Q-1; Sun, 03 Nov 2019 17:25:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3F51180496F
 for <qemu-devel@nongnu.org>; Sun,  3 Nov 2019 22:25:21 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-75.brq.redhat.com [10.40.204.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD438600C1;
 Sun,  3 Nov 2019 22:25:14 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] fw_cfg for-4.2-soft-freeze patches
Date: Sun,  3 Nov 2019 23:25:09 +0100
Message-Id: <20191103222511.17478-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: u_Vuau8dMk6XFUXK5ifr4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

One fw_cfg fix from David Gilbert.

The following changes since commit f3cad9c6dbd4b9877232c44bf2dd877353a73209=
:

  iotests: Remove 130 from the "auto" group (2019-10-31 11:04:10 +0000)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/fw_cfg-next-pull-request

for you to fetch changes up to eda4e62cc2f5d12fcedcf799a5a3f9eba855ad77:

  tests/fw_cfg: Test 'reboot-timeout=3D-1' special value (2019-11-01 19:19:=
24 +0100)

----------------------------------------------------------------
Fix the fw_cfg reboot-timeout=3D-1 special value, add a test for it.

----------------------------------------------------------------

Dr. David Alan Gilbert (1):
  fw_cfg: Allow reboot-timeout=3D-1 again

Philippe Mathieu-Daud=C3=A9 (1):
  tests/fw_cfg: Test 'reboot-timeout=3D-1' special value

 hw/nvram/fw_cfg.c   |  7 ++++---
 tests/fw_cfg-test.c | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

--=20
2.21.0


