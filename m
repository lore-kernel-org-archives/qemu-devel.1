Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B71EC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202F42073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCuPPvpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202F42073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioquD-0000TU-Mh
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqT4-0004pS-5S
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqT3-0004q4-4U
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:08:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ioqT3-0004pR-0y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578409704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOdzojM+GpgPhoiQETD7c4Xg96ayK0KHATO9/8tmr94=;
 b=KCuPPvptdJSvZz5A2Sm7YGyT9azG167v1WKSHM5H4ZyBbj8BYu7Cm5x35rM0tTPkNuAN1C
 5JtD6OmMWp/V01MPrGVzcAaMe5x+qlI4z+vAclF+vAmjL2cVfge6LUNiwWyk8jmVmPbScL
 8ZIldR5mxJUt3LHt+nps2f3ICWODakE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-QuP8-4epO7G2v2ReyyThBw-1; Tue, 07 Jan 2020 10:08:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3DAA800592;
 Tue,  7 Jan 2020 15:08:20 +0000 (UTC)
Received: from localhost (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4CD95D9CA;
 Tue,  7 Jan 2020 15:08:11 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/37] mips: baudbase is 115200 by default
Date: Tue,  7 Jan 2020 19:04:23 +0400
Message-Id: <20200107150442.1727958-19-marcandre.lureau@redhat.com>
In-Reply-To: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
References: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: QuP8-4epO7G2v2ReyyThBw-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(The default value is set for TYPE_SERIAL in serial_properties)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 hw/mips/mips_mipssim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 5ee26108f5..3cd0e6eb33 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -223,7 +223,6 @@ mips_mipssim_init(MachineState *machine)
     if (serial_hd(0)) {
         DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
=20
-        qdev_prop_set_uint32(dev, "baudbase", 115200);
         qdev_prop_set_chr(dev, "chardev", serial_hd(0));
         qdev_set_legacy_instance_id(dev, 0x3f8, 2);
         qdev_init_nofail(dev);
--=20
2.25.0.rc1.20.g2443f3f80d


