Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4EDC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 06:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3FC20870
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 06:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3FC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0gzY-0000sD-MC
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 02:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0gxk-0007Ih-Un
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0gxj-0004dV-KB
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:52:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0gxj-0004ae-9c
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 02:52:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD58C36899
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 06:52:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 314AF5D6B0;
 Thu, 22 Aug 2019 06:52:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 701E411AAF; Thu, 22 Aug 2019 08:52:42 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 08:52:37 +0200
Message-Id: <20190822065242.12496-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 22 Aug 2019 06:52:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/5] Usb 20190822 patches
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

The following changes since commit 17dc57990320edaad52ac9ea808be9719c91ce=
a6:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-08-20' into staging (2019-08-20 14:14:20 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/usb-20190822-pull-request

for you to fetch changes up to 1be344b7ad25d572dadeee46d80f0103354352b2:

  ehci: fix queue->dev null ptr dereference (2019-08-22 06:55:29 +0200)

----------------------------------------------------------------
usb: bugfixes and minor improvements.

----------------------------------------------------------------

Gerd Hoffmann (1):
  ehci: fix queue->dev null ptr dereference

Hikaru Nishida (1):
  xhci: Add No Op Command

Marc-Andr=C3=A9 Lureau (1):
  usbredir: fix buffer-overflow on vmload

Martin Cerveny (1):
  usb-redir: merge interrupt packets

Stefan Hajnoczi (1):
  usb: reword -usb command-line option and mention xHCI

 hw/usb/hcd-ehci.c |  3 ++
 hw/usb/hcd-xhci.c |  3 ++
 hw/usb/redirect.c | 76 +++++++++++++++++++++++++++++++++--------------
 qemu-options.hx   |  7 +++--
 4 files changed, 65 insertions(+), 24 deletions(-)

--=20
2.18.1


