Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6B7C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2B021BE5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy2WTw8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2B021BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPAJT-0006th-Ip
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 15:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPAG5-0003Dw-DP
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPAG4-0004Sk-GM
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:33:09 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230]:45101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jPAG3-0004RL-3L
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:33:08 -0400
Received: by mail-lj1-x230.google.com with SMTP id v9so9071227ljk.12
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zq3krGXmJxvDyvr87mcZe/HEkON2jWxMreSJAsllYfA=;
 b=Dy2WTw8bZgWiFJ7BslQOBPhtskNX9H+MhqUHvFykqBOZ+flmSLtfwRd5+emCWXrJWZ
 OMHAprj5Aa8u8QmRkGZMZS2hPVYUljYjls8tDTXlefKsIBc9jLvTj0IKXe6Erm+bhAoW
 UxGt5R9nnCtPi2OoYcfOEVzRrM082eFcQkKXQtP1PJdmI87pzDAA19ZwH5m7RkoXaMSd
 WofmZ49GGX8uGWYFcFt1R+BIf2XNiru55GWTGtZiGA6cwt+9y6spatfhFpmlMydy7XCG
 bcssG6gEq/67X85pIMDVGSlZU4E2Qc4Snzx20FeMSxJ3rE6eZ2ezG5Lk2FArc3KILO9T
 wlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zq3krGXmJxvDyvr87mcZe/HEkON2jWxMreSJAsllYfA=;
 b=D15L4g59H7DgXETuhi0+WcLaGXizg3ztvlmdgy5Y+lRgbXvMoafsgIPncVZkLY1WMk
 WHPAVtEIHNtZiZtY2C8VdxldxhA18NDid1GPSrx55v5eVCT+2Skx/qW6sIHofXRe2O/D
 7nhy6pFWFTPs+m4cYhGt0OhRtYblFeJ5yN1yA7CssUiv+LJ7HGqDf420rD0W3wArpCFN
 W7rVdQoNESvgGXIRdVXAJZj8tMRFnby2OphKPjn+uWKTqHbGYwBF1KEyQvdYAXxVFOHf
 YCHcNLkAgSnzs8OimcqRq6V/FBHee7BNS9zMQN0g47zkkSe1j9LXjupDVNALPOAo88Zz
 fYhg==
X-Gm-Message-State: AGi0Pub/sKyL0ySBe2OyRxJ8hPFy7lVyyO6NjjsCjSvuVIFiM4tbNYxR
 N6ab3s0UZZyNpdDT1x3jgu1C1cxWOrTk0A==
X-Google-Smtp-Source: APiQypKmJxMxNSWCQAMi0AJ8pLk91G96cQDBwdL6VH/wT6chAJs37bdaFdPMHwZhuJdXcQW7BUjOUA==
X-Received: by 2002:a2e:86d9:: with SMTP id n25mr7453162ljj.92.1587065584930; 
 Thu, 16 Apr 2020 12:33:04 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id b16sm16012177lfj.2.2020.04.16.12.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 12:33:03 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 PATCH v1 0/1] tests: machine-none-test: Enable MicroBlaze
 testing
Date: Thu, 16 Apr 2020 21:33:02 +0200
Message-Id: <20200416193303.23674-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::230
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
Cc: lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This is to re-enable machine-none MicroBlaze testing.

Cheers,
Edgar

Edgar E. Iglesias (1):
  tests: machine-none-test: Enable MicroBlaze testing

 tests/qtest/machine-none-test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.20.1


