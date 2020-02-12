Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CD8C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 21:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA00206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 21:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YN6Ik0YB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA00206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1z7S-0001sG-4p
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 16:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j1z5C-0007ib-DZ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j1z5B-0000Yj-5q
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:58:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35223
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j1z5A-0000YF-Ox
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581541084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pIA31GGHwnSVzhhgGJbBw/VxpPhisxi9uyc4TTNp6LY=;
 b=YN6Ik0YBoG7ZBQWHee2dJKh4AjIUsUK+TotIFnIsaSGU+tJ6zYoYiJVImyGyISoMP9LTi2
 2ZTx+y/Y7Etg6iwynay6Yx5iD0iap2jQC214X50TD9b3yOdjI7wgEB3ZDOgZN7mwy0ZK4m
 w0Yc+ST766OII9iKJo6uTh9vI3JIjP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-pm1Iv0k2MZ-iPJkbjrwkXA-1; Wed, 12 Feb 2020 15:58:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BAB9801E76
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 20:58:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3009360499;
 Wed, 12 Feb 2020 20:57:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2CC619CA7; Wed, 12 Feb 2020 21:57:57 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Usb 20200212 patches
Date: Wed, 12 Feb 2020 21:57:55 +0100
Message-Id: <20200212205757.5608-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: pm1Iv0k2MZ-iPJkbjrwkXA-1
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e18e5501d8ac692d32657a3e1ef545b14e72b730=
:

  Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-=
20200210' into staging (2020-02-10 18:09:14 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/usb-20200212-pull-request

for you to fetch changes up to 8ddcc43592f215a7523774704df6c60d12d9f647:

  uas: fix super speed bMaxPacketSize0 (2020-02-12 17:20:41 +0100)

----------------------------------------------------------------
usb: bugfixes

----------------------------------------------------------------

Gerd Hoffmann (2):
  usb-host: wait for cancel complete
  uas: fix super speed bMaxPacketSize0

 hw/usb/dev-uas.c     |  2 +-
 hw/usb/host-libusb.c | 17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

--=20
2.18.2


