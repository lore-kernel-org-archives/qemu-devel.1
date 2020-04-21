Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DF3C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2102070B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba6iBy5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2102070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQs1X-0007jf-Ug
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrvJ-0006O9-4P
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrvE-0003DC-5L
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:22:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrvD-0003CW-Pt
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:22:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id u13so16240572wrp.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n8xqS8+iwJJS4G+A7w9hLBY8+3N4K2GeA+5U/w1gwfw=;
 b=Ba6iBy5Q+7L0KNpYd4TY5OOdQ5q1NpsRCHCf+/1cdHYBlBY+aV/gpvGrvR1GP+DV2I
 QLB6TzJ5Qipf7ZhcXXgt9YhUCRBdnFVgLLao6mZK8x4WivyjOdozztlpD/Uxq8Iokw8U
 hHNFIrmuJXXO821jPQtMfB5wW2PhTVst0thJQnm6L1W8rl2NCtceipxRswVVfJZCPuE6
 S+nG84JTUrhqS5F4V0HPI5Fo8JiHp85IucYLStHs25JqFiFZrDDi1u0iA9IKlfecHKti
 D8NryB5AX3J448Wb9f0UkyxY/Q5NxLSVJDHSusDbPrFMVnyZ22d77aYCZkHn8bfSybYt
 oL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=n8xqS8+iwJJS4G+A7w9hLBY8+3N4K2GeA+5U/w1gwfw=;
 b=sC09EbBZJ+Q3Z9AIWTHuig3LNRHILbO3DvM2sU6YSBhkAs+EzUEEGzz8oHviR0v4q3
 sN53NkIMRg5bb7WBaafPtVDRPpvTrhy3M1YAox0FEnP489nYWKC927TOeSRVaM/sizZL
 Dz8nJC7wo6hMaK3zmyO71WUT9nfyLhajdOHliMYxgtVohWM6Cfld2tx7yNTjALr0Etyy
 IOii2Zbqv2NvE7u9omq542dVSIKDB9RLIWDGN979UeoLCz/e7xIUwJzbogEKTMwanmPN
 Z1jO2C/cUoxK9QEqEISWtHw9hqQqL9Qf68Q2UI6GnTb6qDhxDSaR/2OFCw0MyuXtIHer
 1PhQ==
X-Gm-Message-State: AGi0Pub7A+IUA4BWU3DHCGvfABykv9+53ezw6tycPka7mbEhSNQ5uy0y
 IzfKFK1Mxsf9AgXQC7lA14M=
X-Google-Smtp-Source: APiQypJFxUQifoctCCquw/tcy4zvSwTdwTwyW3S7bivHH0y0ZUTx7XbneC2ohRT5QEPS/a+QQUinPA==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr26470399wro.347.1587471758034; 
 Tue, 21 Apr 2020 05:22:38 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z16sm3735369wrl.0.2020.04.21.05.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:22:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Keith Busch <kbusch@kernel.org>,
	qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Update Keith Busch's email address
Date: Tue, 21 Apr 2020 14:22:36 +0200
Message-Id: <20200421122236.24867-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

keith.busch@intel.com address is being rejected.
Replace by the email address Keith is actively using.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fac2b..5dbf48d22e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1731,7 +1731,7 @@ F: hw/virtio/virtio-crypto-pci.c
 F: include/hw/virtio/virtio-crypto.h
 
 nvme
-M: Keith Busch <keith.busch@intel.com>
+M: Keith Busch <kbusch@kernel.org>
 L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/nvme*
-- 
2.21.1


