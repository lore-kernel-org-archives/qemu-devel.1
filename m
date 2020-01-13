Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F082C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91B02081E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 13:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVWbU1sB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91B02081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqzRr-0005Rh-J3
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 08:08:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iqzQk-0004SC-UT
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iqzQj-0006WR-R2
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:06:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50296
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iqzQi-0006VN-UA
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 08:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578920812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/vvS1LFepCtSC0rf1h2R0qpiEZRjeYg6F2aq8PgEhVs=;
 b=MVWbU1sB54oCT5rqQcJH+pcyqFoBZRVhd3ag9dbuk6lP0W5QgXa4WYaPSZ6hxJAvPvG3sR
 1+YVCstYFlV6/VxnHmjicsau0nS1t8Ycv91aghKUxKApCD69th6ekUjlFgZ864XbrjIY37
 b73VJHs3zu1cWcA8W3Zvl9fSR0ratvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-Ud2Y5qh7Pp2iWtLKgb7vzQ-1; Mon, 13 Jan 2020 08:06:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3096A801FB2;
 Mon, 13 Jan 2020 13:06:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 025067C456;
 Mon, 13 Jan 2020 13:06:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 37400784F; Mon, 13 Jan 2020 14:06:46 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Usb 20200113 patches
Date: Mon, 13 Jan 2020 14:06:41 +0100
Message-Id: <20200113130646.30099-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Ud2Y5qh7Pp2iWtLKgb7vzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit dc65a5bdc9fa543690a775b50d4ffbeb22c56d6d=
:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.0-20200108' =
into staging (2020-01-10 16:15:04 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/usb-20200113-pull-request

for you to fetch changes up to 236846a019c4f7aa3111026fc9a1fe09684c8978:

  xhci: recheck slot status (2020-01-13 14:05:55 +0100)

----------------------------------------------------------------
usb: bugfixes for xhci, usb pass-through and usb redirection.

----------------------------------------------------------------

Chen Qun (1):
  xhci: Fix memory leak in xhci_kick_epctx when poweroff GuestOS

Dr. David Alan Gilbert (1):
  usbredir: Prevent recursion in usbredir_write

Gerd Hoffmann (1):
  xhci: recheck slot status

Yuri Benditovich (2):
  usb-host: remove 'remote wakeup' flag from configuration descriptor
  usb-redir: remove 'remote wakeup' flag from configuration descriptor

 hw/core/machine.c    |  2 ++
 hw/usb/hcd-xhci.c    | 16 +++++++++++++---
 hw/usb/host-libusb.c | 20 ++++++++++++++++++++
 hw/usb/redirect.c    | 29 +++++++++++++++++++++++++++++
 hw/usb/trace-events  |  1 +
 5 files changed, 65 insertions(+), 3 deletions(-)

--=20
2.18.1


