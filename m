Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDFEC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985FB2098B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Goej/G5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985FB2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBZSS-0002Cd-U1
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 04:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBZRT-0000Wk-SN
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBZRP-0003R4-Fr
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598602134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pj6QbpvhXb4xod3nciQRVD0Eay61+3ZfpSS93t0PtVU=;
 b=Goej/G5E5nhemz0RTtPemK/GbNNzEoR65RpTgeFiO0erVTfmbkgR/cCKw8wDSVqDXiIu2l
 IB+DGJeRpr5v6OwNffUCGfUe6f4iR/IoSCRqIAxXmS53oYOK8eikCmdG/NAS+Tw9MEI1kX
 NQ19v2TBBF77GXBWz+kPEILW4RXd8mU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-WSeYchRlPlimvSTgJRHlDg-1; Fri, 28 Aug 2020 04:08:52 -0400
X-MC-Unique: WSeYchRlPlimvSTgJRHlDg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D0C9801AC2;
 Fri, 28 Aug 2020 08:08:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3D84747BD;
 Fri, 28 Aug 2020 08:08:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6561031E7F; Fri, 28 Aug 2020 10:08:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/18] docs/qdev-device-use.txt: Add USB U2F key to the QDEV
 devices examples
Date: Fri, 28 Aug 2020 10:08:40 +0200
Message-Id: <20200828080845.28287-14-kraxel@redhat.com>
In-Reply-To: <20200828080845.28287-1-kraxel@redhat.com>
References: <20200828080845.28287-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 02:09:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: César Belley <cesar.belley@lse.epita.fr>

Signed-off-by: César Belley <cesar.belley@lse.epita.fr>
Message-id: 20200826114209.28821-10-cesar.belley@lse.epita.fr
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/qdev-device-use.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/qdev-device-use.txt b/docs/qdev-device-use.txt
index f8d0d2fe297a..9889521e3c07 100644
--- a/docs/qdev-device-use.txt
+++ b/docs/qdev-device-use.txt
@@ -325,6 +325,7 @@ The new way is -device DEVNAME,DEV-OPTS...  Details depend on DRIVER:
 * mouse           -device usb-mouse
 * tablet          -device usb-tablet
 * wacom-tablet    -device usb-wacom-tablet
+* u2f             -device u2f-{emulated,passthru}
 * braille         See "Character Devices"
 
 === Watchdog Devices ===
-- 
2.27.0


