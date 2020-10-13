Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D80C3279D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8EB20878
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDmDQmt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8EB20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSRFf-0006gL-Jw
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSREi-0005hz-In
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:49:32 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSREh-0002ro-4e
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:49:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id s9so982573wro.8
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EhjQJ3Lk1hM5zr931AA8dIZN0ufWPqWagPZmbrV77Zo=;
 b=fDmDQmt+Y5PtWLW5oEchWmXhuD4V85YXMb8E7Yw7KUFK4lTBE07pVFqKCsG8UvS11Y
 YrP3USbBM6eMjE0RIWiG+TUHPL41hEWpHKw/IVRWgYZHbhDVWI15BW2uRFFOlfa6lch/
 LLrHT3iYkULVjeP1JnDlJbmLNvSM6sqpen50HJjGNyTJZil/kiG2iK2DzVsbv2vyg/FV
 r+bmQj1lbDIK0NTIBbv3pRgPuS4S96Jc4TDmYsa0LYXE7WqfKJTo9nDrwK5G741CgA2n
 DnDwk9iAV/xILSzyrk4R6xKOie6Ev8BnjwDQQLypKuPpsTyEYZIA6oW3rJtlb3AmSrSq
 yang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=EhjQJ3Lk1hM5zr931AA8dIZN0ufWPqWagPZmbrV77Zo=;
 b=XmI0uraF3SQFUyQYVFV1y3ImTszfWr+9NrnKY3rZABHLhMqDKjgNj25AI9dTOjZ9Sc
 IPKtDpLefjIjiqa2IQYJdavldcu3LjnLdjk744tyKK5D1KKEAylm8Tf47XCOJ2VvWBFQ
 KRXQpw1ZFrFg79jCropZ7yo0+H9QMqi74SyVYPJkkajRl5P15HL2CgiV2yzR2MxcbZQq
 9UdnOdOzpWb+hJ/k7w3O3cvmSs9ZPZjC2Rnfp9aVlp6A4Y7PlxDVmwMH5KhJt78Z/hnY
 phYsSPJIwbNBJOAuPQKg7TBV8cPEBl/JE0Hkizw7f6dAZ2Ufw8uFoPVoT+7xfyg6d4h6
 T7Eg==
X-Gm-Message-State: AOAM530YbJx/aj5NPvkJIrpkdtOi4Wvl409FFeO2aPA2wQYiioRlp6r0
 akqqnv1XKH1lUSUF205230sMlntXDVY=
X-Google-Smtp-Source: ABdhPJwZHGE0zweD1ERrnftUQgOXGHjCd/lan5tI0eXBzBaQ0t4Kt2cGsvWT40Y+XSEJzVd6qQ7X2A==
X-Received: by 2002:adf:cc82:: with SMTP id p2mr1625113wrj.177.1602622169239; 
 Tue, 13 Oct 2020 13:49:29 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l3sm176460wmg.32.2020.10.13.13.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 13:49:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] hw/misc/mac_via: Factor generic via_irq_request() out
Date: Tue, 13 Oct 2020 22:49:24 +0200
Message-Id: <20201013204927.3660030-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The same logic is used in 4 different places:=0D
- via1_irq_request()=0D
- via2_irq_request()=0D
- via1_VBL()=0D
- via1_one_second()=0D
=0D
Extract the common function and reuse it.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (3):=0D
  hw/misc/mac_via: Make generic via_irq_request() from=0D
    via1_irq_request()=0D
  hw/misc/mac_via: Replace via2_irq_request() with via_irq_request()=0D
  hw/misc/mac_via: Use via_irq_request() in via1_VBL(),=0D
    via1_one_second()=0D
=0D
 hw/misc/mac_via.c | 59 +++++++++++++++--------------------------------=0D
 1 file changed, 18 insertions(+), 41 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

