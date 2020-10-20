Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18713C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6566A22253
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="FEr/WzXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6566A22253
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoVK-0001KM-Aq
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kUoTt-00082N-NR
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:03:01 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:49467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kUoTo-0007Dz-KY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1603188176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DivzlSEYGx5djsY+aVmVgrz7JhYnipPXWYC1o2Q+IOY=;
 b=FEr/WzXe3IEdzhU5CFheOwPm1dhK6+rPue/oXtp039q2qXw8wq16nZnx
 AmMLPWRtJs6Gfuw7JbV440XRXoXhj/tBN4fAVv8eIylMX6CNsWv7FOAph
 x1YWY8dnSmmRPsSeadZGaKw9hvaDXo/88w0PSKgIl2RG25D4NR0X/EUoy c=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: KOdXoYAQ7gfB2dkNWG5ae5SEjLEq9NRTtwCY4ufZRI37zY+J8r7ho/vqPKxH0MwI8k/zQ/2cuK
 316I9BBk+J9K5JsikXoMVDU4LQdqniPqfZooJ56q1g9/cptOpPRF2T/FKx9pQmu3l39VS+dzj7
 h1rH7td9o8tlttUIBqjh90ByMgp6llet3jYPnrFwmnXA3J0o/9WPTUen3SNpt75yG/LOD9rmFq
 d3uU9BLY9vRAH4ylvAas39y1Nyfbh1wMtp5uDwqG2M/KT+WfNcTOHFVzunVrFZH+Pvx0HqnQpS
 bi4=
X-SBRS: None
X-MesageID: 30419945
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,396,1596513600"; d="scan'208";a="30419945"
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost
 <ehabkost@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>
Subject: [PULL 2/4] xen: Rename XENBACKEND_DEVICE to XENBACKEND
Date: Tue, 20 Oct 2020 11:02:37 +0100
Message-ID: <20201020100239.272748-3-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020100239.272748-1-anthony.perard@citrix.com>
References: <20201020100239.272748-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=anthony.perard@citrix.com; helo=esa4.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 06:02:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20200902224311.1321159-58-ehabkost@redhat.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 include/hw/xen/xen-legacy-backend.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index ba7a3c59bbcc..be281e1f38eb 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -11,7 +11,7 @@
 #define TYPE_XENBACKEND "xen-backend"
 
 typedef struct XenLegacyDevice XenLegacyDevice;
-DECLARE_INSTANCE_CHECKER(XenLegacyDevice, XENBACKEND_DEVICE,
+DECLARE_INSTANCE_CHECKER(XenLegacyDevice, XENBACKEND,
                          TYPE_XENBACKEND)
 
 /* variables */
-- 
Anthony PERARD


