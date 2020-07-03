Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220D5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22F42073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 18:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elBU4wZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22F42073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrQm1-0004Lu-4s
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 14:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQl4-0002no-Kh; Fri, 03 Jul 2020 14:49:58 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrQl3-0007ad-3o; Fri, 03 Jul 2020 14:49:58 -0400
Received: by mail-wr1-x444.google.com with SMTP id o11so33756878wrv.9;
 Fri, 03 Jul 2020 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LiDVcNkiZIpvhf9IYFi6LwnSQAxblfs1gRRGoPgSiVY=;
 b=elBU4wZicGfrHFVANIx8dovHU/ctRQGy7SrELsU6x68r2UL/2W/7stWEfV93KhpVW0
 DNCgySdMBuabLzAHtKqATpKgjINJBFGsR8V6D9sBJNLlay/Zr8PPB5OyzLDfXsYbFI9X
 Kt3jRdlwArTkPq8Fh8XQLqHwzCTZ9+4AkTyNy2LDNKm8bZgvHtrgqs58QmS9uVw3N3br
 jcMO9TLqBWnU8W10x3Y2XvsA0FmPBTJn5R0eSSBxHgnN3nUlN83bysp07cMUAHMXef7U
 DUxvXUHHC1VxezMjJMrnbxs3zBn19+upDprlqtAoB4ny/gpEkT8HHRDykQPdtzvI15pO
 WUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=LiDVcNkiZIpvhf9IYFi6LwnSQAxblfs1gRRGoPgSiVY=;
 b=QCRXUSyBU9rglBqmJ7cr9qqAYojqRFnAjarkUpWjlkLUsz023VS91a4f1Z69x3tY6G
 yEBy1ZhUTVV5Rj2GmAlXO9Wm4Kja8CHgdw0lY+Kawqn29+dKWFUFdYLCdaGDvY1gdyQV
 QyKYEAZGMq1gAdb6srEuX/adqp/H73lg+uvSXg/m+mhRAHZlE3sfHN1Prj+Y3ViiF6It
 IzWlmsaNiyi5CUXDLkm74/a6d1xDu2L9rdmL5TWD7OzG2+lL7BGt6fuQdbBkhgoHDsNp
 55s2kNmdP0/cKVON7CWvRGOQ0e6eK0ygKwmQlkpb8xgBuoT0YimHQDHrQL1ZhwWIKP6a
 gJBQ==
X-Gm-Message-State: AOAM530e90NGLgIZCwrAluGEBQ5Y4lS504z7alj7Ncm5yuKnDJichAfq
 1g6DOrDi5MYSQZU/GxZjXine4EeWjLg=
X-Google-Smtp-Source: ABdhPJxB4O6/fRNm0zqn6DRHRiKB0qYaiYV34QkYkSU6V5xIZtmMkijo6fhTlp/pNJzKYc0Oig9UMQ==
X-Received: by 2002:a05:6000:ca:: with SMTP id
 q10mr39200668wrx.135.1593802194485; 
 Fri, 03 Jul 2020 11:49:54 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x11sm13778369wmc.26.2020.07.03.11.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 11:49:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw: Use TYPE_SYSBUS_OHCI instead of hardcoded string
Date: Fri,  3 Jul 2020 20:49:50 +0200
Message-Id: <20200703184952.4918-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial patches to use the TYPE_* definitions instead of
hardcoded names.

Philippe Mathieu-Daudé (2):
  hw/arm: Use TYPE_SYSBUS_OHCI instead of hardcoded string
  hw/ppc: Use TYPE_SYSBUS_OHCI instead of hardcoded string

 hw/arm/allwinner-h3.c | 9 +++++----
 hw/arm/pxa2xx.c       | 3 ++-
 hw/display/sm501.c    | 3 ++-
 hw/ppc/sam460ex.c     | 3 ++-
 4 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.21.3


