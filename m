Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF15C07542
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDA221019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDA221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVs9O-0003OZ-0t
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:33:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVs4m-0000aJ-8H
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hVs4l-0004eA-4t
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:28:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hVs4k-0004dU-Cj
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 708753D37;
	Wed, 29 May 2019 06:28:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com
	[10.36.116.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C0A9C1001DDD;
	Wed, 29 May 2019 06:28:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 20EF017524; Wed, 29 May 2019 08:28:33 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 08:28:27 +0200
Message-Id: <20190529062832.26483-5-kraxel@redhat.com>
In-Reply-To: <20190529062832.26483-1-kraxel@redhat.com>
References: <20190529062832.26483-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 29 May 2019 06:28:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/9] usb-hub: tweak feature names
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add dashes, so they don't look like two separate things when printed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190524070310.4952-2-kraxel@redhat.com
---
 hw/usb/dev-hub.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 7e9339b8a83d..9b04b6a6ec2d 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -287,11 +287,11 @@ static const char *feature_name(int feature)
         [PORT_POWER]         =3D "power",
         [PORT_LOWSPEED]      =3D "lowspeed",
         [PORT_HIGHSPEED]     =3D "highspeed",
-        [PORT_C_CONNECTION]  =3D "change connection",
-        [PORT_C_ENABLE]      =3D "change enable",
-        [PORT_C_SUSPEND]     =3D "change suspend",
-        [PORT_C_OVERCURRENT] =3D "change overcurrent",
-        [PORT_C_RESET]       =3D "change reset",
+        [PORT_C_CONNECTION]  =3D "change-connection",
+        [PORT_C_ENABLE]      =3D "change-enable",
+        [PORT_C_SUSPEND]     =3D "change-suspend",
+        [PORT_C_OVERCURRENT] =3D "change-overcurrent",
+        [PORT_C_RESET]       =3D "change-reset",
         [PORT_TEST]          =3D "test",
         [PORT_INDICATOR]     =3D "indicator",
     };
--=20
2.18.1


