Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F530C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D399520771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pP+LQmgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D399520771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsnYG-0003zm-2M
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 09:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsnXI-0002Yu-1N; Tue, 07 Jul 2020 09:21:24 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:43042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsnXG-00015A-DV; Tue, 07 Jul 2020 09:21:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id j4so42695991wrp.10;
 Tue, 07 Jul 2020 06:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ARpMuyjZGR3T8DdlnFDmHTd6JZAqkzgifdx/2GbovSw=;
 b=pP+LQmgEtCiKGnHcVRF4tCZ3ltxbPtot15gkkD0JhraCNBZY6+B6teXh+TPmtAh4X9
 wPvx4mpHyxZZ0LYAwXVw/WeZSk6L8FHIRZl2gxwhm4YlbkdnNlyO1Sp/zpSCvpJMcGE3
 HKQSRNaQHPwTMPtLX9K3pG3gFfjdDUk2grApyLcHtI95vmSWqul0IQwCgrBAzRyQXGQZ
 j4Rxfdhr46uzK/4ZjDOex54S7EdXaDGPUmJCMwUbA45tgQrXn/uNHAScJy74oQd2KrpR
 RQT/SfOHbAhvDmUcWFaDseNrP5pbz+zXpHMXqSiEKUV0W4ihG+vzbBdGaBhrlfndYocn
 79xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ARpMuyjZGR3T8DdlnFDmHTd6JZAqkzgifdx/2GbovSw=;
 b=Pnegwq8C/DXIdbjZkKm9lhIaYk8dKeUP7CAjZ7DnJ5mXTagQCRtUEbTJQx5t3TA4Oa
 E2QJgIyjvvGmRJQrWub9gKBGpJEHvqD4aiOvM7lrHzvNL6wFT2WF788vRt80nHXL1ogo
 oBxut6K65CcGyrK0y1nguczjnY48EUxW/0lxrgvs63ZcOkYZnxFHVvtHn0czolbS8FXn
 6IYLYU8WdyoddGxg2by+x6QhFKxi3GrbrxJcoyLVfs4eWYgpqY9O4gDF0hbh3HGJR5Kr
 dNtVNTueVQa4gvBt6aTpzmNy/uaxONNEq5TW4BrFVxJjNrzj6SmzSiPvFGrc5Ef0a+Bp
 Q1EA==
X-Gm-Message-State: AOAM530dapc7BElxjqczT1ccDkVEVoGGzI5ToRmpTXH5q3QVf2vRs6XN
 ZoatDn03a558KXxHPidhm3/zfj0X
X-Google-Smtp-Source: ABdhPJydKnwZP8BGgPBq/EVbfxgoTDE5UZInuVk6qYsiF6rO0JcHoXBVICd1HCCvvUvzhKIAGwlzJw==
X-Received: by 2002:adf:b608:: with SMTP id f8mr58327417wre.363.1594128080176; 
 Tue, 07 Jul 2020 06:21:20 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 1sm1040130wmf.0.2020.07.07.06.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 06:21:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/sd/sdcard: Fix CVE-2020-13253 (Do not allow invalid SD
 card sizes)
Date: Tue,  7 Jul 2020 15:21:14 +0200
Message-Id: <20200707132116.26207-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Part 1 is already reviewed:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg718150.html

However the CVE fix break Linux guests:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg720737.html

This series fixes that, by checking the SD card image size is
correct.

Based-on: <20200630133912.9428-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (2):
  tests/acceptance/boot_linux: Truncate SD card image to power of 2
  hw/sd/sdcard: Do not allow invalid SD card sizes

 hw/sd/sd.c                             | 16 ++++++++++++++++
 tests/acceptance/boot_linux_console.py | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.21.3


