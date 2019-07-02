Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B41C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDECD21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDECD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiA75-0003ER-70
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50374)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi8aG-0004jE-Mt
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi8aE-0003cv-Rl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi8aD-0003YI-6o
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59DC130860B7;
 Tue,  2 Jul 2019 02:31:40 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-232.pek2.redhat.com
 [10.72.12.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BA34BA4D;
 Tue,  2 Jul 2019 02:31:38 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 10:31:15 +0800
Message-Id: <1562034689-6539-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 02 Jul 2019 02:31:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 03/17] ftgmac100: do not link to netdev
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

qdev_set_nic_properties() is already used in the Aspeed SoC level to
bind the ftgmac100 device to the netdev.

This is fixing support for multiple net devices.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/ftgmac100.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index eb76047..d2cded5 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1017,8 +1017,6 @@ static void ftgmac100_realize(DeviceState *dev, Err=
or **errp)
     sysbus_init_irq(sbd, &s->irq);
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
=20
-    s->conf.peers.ncs[0] =3D nd_table[0].netdev;
-
     s->nic =3D qemu_new_nic(&net_ftgmac100_info, &s->conf,
                           object_get_typename(OBJECT(dev)), DEVICE(dev)-=
>id,
                           s);
--=20
2.5.0


