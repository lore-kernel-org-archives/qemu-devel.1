Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC20C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F026206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5aUwiiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F026206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8tH-0007QE-Ev
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jE8sE-0005o6-3Z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jE8sD-0004in-5c
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:50:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jE8sD-0004hp-1C
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584438656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iNT+Bd2gIthuja6XmniMOc7Qy1RGTlw7UFm6Ai69ZTo=;
 b=J5aUwiiSJKxb6+3toFJuaZ4eoI5C5Aq/IRO2QTnTXulOr/w74gxYo6qfnOnzyiWRizzS+8
 thhZTbVfGpRTuZgWj6gRs9p9UT+G7LwD52af9g3g1AS/JMKZsYMDaEMxzOORVQkwtiJ6U4
 JmFZ4XQu8CNkSYyMD3R/+YZDISA0UBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-nTZ0WJAYMYWQIglwZuUdVg-1; Tue, 17 Mar 2020 05:50:54 -0400
X-MC-Unique: nTZ0WJAYMYWQIglwZuUdVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BFEE149C1;
 Tue, 17 Mar 2020 09:50:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6F0C10027A3;
 Tue, 17 Mar 2020 09:50:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EDA7F17535; Tue, 17 Mar 2020 10:50:49 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Usb 20200317 patches
Date: Tue, 17 Mar 2020 10:50:45 +0100
Message-Id: <20200317095049.28486-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 61c265f0660ee476985808c8aa7915617c44fd53=
:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-202003=
13a' into staging (2020-03-13 10:33:04 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/usb-20200317-pull-request

for you to fetch changes up to 647ee9877272d4359659e2595262db0e062c8ffc:

  usb-serial: Fix timeout closing the device (2020-03-17 09:05:34 +0100)

----------------------------------------------------------------
usb: bugfixes for usb-serial @ xhci.

----------------------------------------------------------------

Jason Andryuk (4):
  usb-serial: Move USB_TOKEN_IN into a helper function
  usb-serial: chunk data to wMaxPacketSize
  usb-serial: Increase receive buffer to 496
  usb-serial: Fix timeout closing the device

 hw/usb/dev-serial.c | 95 ++++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 36 deletions(-)

--=20
2.18.2


