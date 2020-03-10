Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B13C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2134E24677
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIT8vSoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2134E24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaCJ-0006Ld-B1
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jBaBN-00050q-LL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jBaBM-0002Ri-JX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:24:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49112
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jBaBM-0002Qj-Fy
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583828648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bMW7kf573hat9Op9zhPaTftoynNAJQS01+L97IyOcVk=;
 b=jIT8vSoeDrp7xFK4BnHEeWS1nbLQudkMYj4QO7A7Y/WLAASx++ngax7e9bgY2Lh5uid3lI
 sV6Q9G8rMIkHlzCwDHWefEByVal0nfrJQ1gSXQiRrOz8uk+Tvs1a91kZI0sRwJ8fGjWiv2
 p/9xCIw8KGhIOqWIQhKpcU0bhcGHe/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-Gj6N7tz6P96vPHuGGUGhJw-1; Tue, 10 Mar 2020 04:24:06 -0400
X-MC-Unique: Gj6N7tz6P96vPHuGGUGhJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACBD58017CC;
 Tue, 10 Mar 2020 08:24:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C46C95C1D4;
 Tue, 10 Mar 2020 08:24:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0EFF29DB6; Tue, 10 Mar 2020 09:24:02 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Usb 20200310 patches
Date: Tue, 10 Mar 2020 09:24:00 +0100
Message-Id: <20200310082402.22839-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 67f17e23baca5dd545fe98b01169cc351a70fe35=
:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into stagi=
ng (2020-03-06 17:15:36 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/usb-20200310-pull-request

for you to fetch changes up to e13a22db0d47012e19ad02c9dafacbe25f94e1b4:

  usb/hcd-ehci: Remove redundant statements (2020-03-09 11:12:55 +0100)

----------------------------------------------------------------
usb: bugfixes for ehci & serial.

----------------------------------------------------------------

Chen Qun (1):
  usb/hcd-ehci: Remove redundant statements

Jason Andryuk (1):
  usb-serial: wakeup device on input

 hw/usb/dev-serial.c | 6 +++++-
 hw/usb/hcd-ehci.c   | 3 ---
 2 files changed, 5 insertions(+), 4 deletions(-)

--=20
2.18.2


