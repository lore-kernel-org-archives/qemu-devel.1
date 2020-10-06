Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5075AC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0464206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qthoGYAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0464206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpAg-0005XF-Sv
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 11:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPp7M-0003hS-RU
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:43:09 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPp7J-000056-Np
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:43:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id j136so3609843wmj.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jwTWURE/eDrPEvo24EEaW5PvQHWcRQAeKjfZiY++ilU=;
 b=qthoGYAKTo0dQJAG1T3Kx2lmANdfA1BWauNjM9bWd0PxaIwVXV3pIABkX60KLACr+q
 V5NpQtXMxVgpYHFM6/W5gX+OPrvq3QPiw4CqcaJBGjDIJUwPV5GUcnei6/1ogZVdDzrv
 awDVUHBHs2zzTU4K3TjglRnYEOF/i/tVAROWdcbq1qe8v8cxdW9vXN/QTIAktxb3Pfus
 dQqxbu6dQZTCxuvSVKZDqD2G0XDJ24k6ijG883oo4eB5Y7cefGaWsss7szhDvYY9zhKF
 XrIJxd+lfOjCRUT9ehzyITI2WgsfhBTiXTfT/8NoADG6kSPuVeY0X0GMQ6F6c+fk6AhV
 C3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jwTWURE/eDrPEvo24EEaW5PvQHWcRQAeKjfZiY++ilU=;
 b=jTn17OFCokJHxV9pfwIds5rvGDFqJY58ma5Gjcy5qeiBzGA8mcoh+3TXbp6RozpVsJ
 WbTKpt7Fx9/+ETWpzDdoQOwEp50RaoYcBtEMh5jjktHFfdp3yynvAqLw5UZB1wcuMOi/
 uuM/tqeyXQMxlVzdHmaNUzCCPFsibM85L/ErTxp1lkk3kOUJlq8/F6jYg1wkHrmtmAJU
 j0CEBdKzB/E7I4jujRG775MJ2ANZCLZ/yvWkWq6qdB7DEy3sxXdx96db9UKUwt65o6an
 9bzfSTVER/xl/nWknmc2GHPs+T4kfs+021ehremptz/bhqvIndU73oicdc277GwfX/Pp
 DgwA==
X-Gm-Message-State: AOAM533QlHx+QGyyDFGMAcsQPgD1302dEZFcB+tkP0IfFgkvJwHcHg8h
 efjAl8QbpM6dwdLX91/6RjfxhA==
X-Google-Smtp-Source: ABdhPJw/65NWn+8ikmIW8naqbci9Bow00qqGqtDo9mROFRXt8baDx1dpT2W3kXg7+tvrYrYrZq+Uyg==
X-Received: by 2002:a1c:e48b:: with SMTP id b133mr5382275wmh.0.1601998981960; 
 Tue, 06 Oct 2020 08:43:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v9sm5601133wrv.35.2020.10.06.08.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 08:43:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 267C11FF7E;
 Tue,  6 Oct 2020 16:43:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/ide/ahci: silence a compiler warning
Date: Tue,  6 Oct 2020 16:42:56 +0100
Message-Id: <20201006154256.17392-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:IDE" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When built with -Og -ggdb with gcc 8.3 the compiler gets confused
reporting:

  ../../hw/ide/ahci.c: In function ‘ahci_populate_sglist’:
  ../../hw/ide/ahci.c:965:58: error: ‘tbl_entry_size’ may be used uninitialized in this function [-Werror=maybe-uninitialized]

As prdtl being > 0 is a prerequisite for running the code which
guarantees we execute the loop at least once although not necessarily
resetting off_pos/off_idx which should short-circuit the test anyway.

To save grey hair initialise the value to zero and move the variable
to the local block so future changes can't accidentally use it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/ide/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 680304a24c..f5c20c7d55 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -925,7 +925,6 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
     uint64_t sum = 0;
     int off_idx = -1;
     int64_t off_pos = -1;
-    int tbl_entry_size;
     IDEBus *bus = &ad->port;
     BusState *qbus = BUS(bus);
 
@@ -952,6 +951,7 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
     /* Get entries in the PRDT, init a qemu sglist accordingly */
     if (prdtl > 0) {
         AHCI_SG *tbl = (AHCI_SG *)prdt;
+        int tbl_entry_size = 0;
         sum = 0;
         for (i = 0; i < prdtl; i++) {
             tbl_entry_size = prdt_tbl_entry_size(&tbl[i]);
-- 
2.20.1


