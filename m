Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A23FC352BE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41D620678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+Vob9kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41D620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOPFW-0005Zv-Tt
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 13:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOP1L-0007a6-GC
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOP1K-0006o1-BK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 13:06:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40598
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOLfA-0008Kd-Bi
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586871100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sp8SzHLCDmolhv1WuiLlsIvFgsrHTJti0rZsOPUJPyM=;
 b=N+Vob9krwCKOimUmtELkT+ceW5juhZCEe8tn455q7ofep3e5aMGFaa5lkcuC2T0ryRNfFs
 Bc2w6yMUNoUPTDawAWNP3RA3/BtPBKHR2LozuwXDZgNV/jFzxLdwShDT+O/OdWXvPw+w1E
 bKy/s0iqSx/albh89N7lolzlt/Wv4o8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-lhnjZcTPPweyx_9poJXKgA-1; Tue, 14 Apr 2020 09:31:37 -0400
X-MC-Unique: lhnjZcTPPweyx_9poJXKgA-1
Received: by mail-wr1-f70.google.com with SMTP id o12so5624730wra.14
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 06:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tNX3//qXDnRxcPpWRn8QtDnslzojVakNKy5THztVse4=;
 b=uiy49fAn5d7RVhgC1iZY76apypPNmQ31qu317/C3iMTAXq1DZRHlgWDaW8HpfrOlAC
 tg/n7n2a6q07mP7vXiIX4PYOFi3OaRiEUH3MUnFHXrR838u8tMMxmr7iDXWtDaUVkGDM
 EqJB3X2mHXcoEBwU8QBlgCTal20TXEu7Q/Zued1xe6sOgYaskHr672UftS1JwcgwUe/m
 F5tFAkgQ5TBq/8y/JoLWh7vcgV4dc2xIrQXb1fE63/chfoljrYJuLzJFTFHkcFzeZPsB
 S26lNvfkLihceBY9PPzs64XGgjGGWN1/kUZHOdCBRVD0dxsHGKci6x7kHzbanscoantq
 UjbQ==
X-Gm-Message-State: AGi0PuYaEzYvU7YuLJCEvBYtbPwCx/nPNBGLzI88uSaWNlWs3TUy8wwT
 t5IZx+XR802w0qZMf+iYtO/9WG9vY0Rtmlbeu9cmXi2/0QDieiUx+/bM5pOvgUq+jmBfj0+4Li4
 mJ1g3Ons/qxKjT4I=
X-Received: by 2002:a5d:460b:: with SMTP id t11mr21176976wrq.319.1586871096166; 
 Tue, 14 Apr 2020 06:31:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypIv9RBVDEd3xw1GEDZI6IhmUZJUQ1PGjXeX5+q1aweflnJmMAgLsdEz4/QVZsnGZyoClpC5sg==
X-Received: by 2002:a5d:460b:: with SMTP id t11mr21176965wrq.319.1586871095937; 
 Tue, 14 Apr 2020 06:31:35 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id t13sm2952131wre.70.2020.04.14.06.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 06:31:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 08/12] hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit
 accesses
Date: Tue, 14 Apr 2020 15:30:48 +0200
Message-Id: <20200414133052.13712-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414133052.13712-1-philmd@redhat.com>
References: <20200414133052.13712-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The Plug & Play region of the AHB/APB bridge can be accessed
by various word size, however the implementation is clearly
restricted to 32-bit:

  static uint64_t grlib_ahb_pnp_read(void *opaque, hwaddr offset, unsigned =
size)
  {
      AHBPnp *ahb_pnp =3D GRLIB_AHB_PNP(opaque);

      return ahb_pnp->regs[offset >> 2];
  }

Similarly to commit 0fbe394a64 with the APB PnP registers,
set the MemoryRegionOps::impl min/max fields to 32-bit, so
memory.c::access_with_adjusted_size() can adjust when the
access is not 32-bit.

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20200331105048.27989-4-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/misc/grlib_ahb_apb_pnp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
index 72a8764776..d22ed00206 100644
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -146,6 +146,10 @@ static const MemoryRegionOps grlib_ahb_pnp_ops =3D {
     .read       =3D grlib_ahb_pnp_read,
     .write      =3D grlib_ahb_pnp_write,
     .endianness =3D DEVICE_BIG_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+    },
 };
=20
 static void grlib_ahb_pnp_realize(DeviceState *dev, Error **errp)
--=20
2.21.1


