Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F79C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 08:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA43214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 08:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1Ir995o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA43214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39893 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSdcK-0004P5-DE
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 03:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iSdZq-00032e-2C
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iSdZl-0003f1-QC
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:55:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28305
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iSdZl-0003Xz-DD
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573116932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eklATHbWkq1nMVfnu3npMkZo+XmNw796PHherA3stfg=;
 b=g1Ir995on02+0Usap2ybMy1Y5Wrsox7wxJnMh3KxlroqfXaDoyR8PGqyrpH1t/X+Cv2n/y
 dqfXs31UHG/PRBJIbhvLLhA0iDdL8NOhFRJ/R40LE33MY9Nsx/l6JLPOocorxRXOT/v5wU
 qjTSEqvge6YpJ4VJdXvkiTB/DdHb8OE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-egXdbbwnOFWzfF8A0hhMtg-1; Thu, 07 Nov 2019 03:55:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DD7E477
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 08:55:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4374B5DA2C;
 Thu,  7 Nov 2019 08:55:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 26E8717535; Thu,  7 Nov 2019 09:55:25 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Usb 20191107 patches
Date: Thu,  7 Nov 2019 09:55:24 +0100
Message-Id: <20191107085525.30902-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: egXdbbwnOFWzfF8A0hhMtg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 412fbef3d076c43e56451bacb28c4544858c66a3=
:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-next-pull=
-request' into staging (2019-11-05 20:17:11 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/usb-20191107-pull-request

for you to fetch changes up to 1dfe2b91dcb1633d0ba450a8139d53006e700a9b:

  usb-host: add option to allow all resets. (2019-11-06 13:26:04 +0100)

----------------------------------------------------------------
usb: fix for usb-host

----------------------------------------------------------------

Gerd Hoffmann (1):
  usb-host: add option to allow all resets.

 hw/usb/host-libusb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--=20
2.18.1


