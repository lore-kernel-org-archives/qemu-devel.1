Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1B3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFA42311B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otA0agxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFA42311B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ffV-0000b9-83
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fea-0007mw-2k; Thu, 06 Aug 2020 09:09:52 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3feY-0007oU-B7; Thu, 06 Aug 2020 09:09:51 -0400
Received: by mail-wr1-x434.google.com with SMTP id p20so9044856wrf.0;
 Thu, 06 Aug 2020 06:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nxT41juG220lt8bThopkJ0qbVj3hX8fF3UdqUGUmWoM=;
 b=otA0agxuBK7D74CN53R9BjdfhAcbskwCVcXqxy3kVTd7BP+4cLsd2NF5bAYSs2aFdR
 DWxwEWS1qHwX0D9oaAnAVYnRZfvjOkoq3rzlshOJurDhskj9W8Qyue4B1ixq2p3uvtzF
 m+aLy0w+r8+r4PM2xd7D7n3M9KqERToLX6NU91zSAQw1nA20hX10To2HTTi1hIwRFpke
 L6tk8VUDCIpG+aBsD9lVYXxSzOqV0ibEbIKeNAYDCb4s7K5P2zMrRbLFsJOylwbpUTk4
 kzT7Z72wiFMwyn7/LoAXfBDqKATCJxzGMhOLAwb/T/jUmTiy7OwA5yX8XQzMx/M9OmFu
 WgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=nxT41juG220lt8bThopkJ0qbVj3hX8fF3UdqUGUmWoM=;
 b=k2fd50CIMSSB1S/3zk+R++3SLTbJrMzzPXiXRI/miNP0XcXhqsa3ykKuhfsmq6xlUK
 4CU96n8Kb1d5QoYD5muDlMom6xfBiN/Gv7Mxol7W/VerRJca4eGVkzrshVHlwDPydtdr
 ofMyRCcfMPEeCMJjUUG1myPrg5gov7Za/XOSd12k7ohvLFzrddbjNQC4jEGzVamkA2+W
 WmabMF4JKftIyBm4G9LcmDP696HjHHKHJZYHlManHWzS8BcrfdxEInpSndb8BwvCLRbL
 8OQly+g6uPifjYPrlZ2SidV9tNz8L2FGALzBmrDP/JJL8eu7hDlBbsn8ZUIlAwdZnEEZ
 HFMg==
X-Gm-Message-State: AOAM532/rCkPstSoxIxsfbIB+sDU1m0wAxVKbMGlUg+aPl1idy+jb8i4
 yw6+NTmq068wj/Mchzm/36y8j1pO
X-Google-Smtp-Source: ABdhPJxdDS31sIoEDnt55/QJBBYf0ij3LZ5bi+C2sKOwGfAyZQXc1Zn6GemSb8RybOAiEdWZxp5O5A==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr7563631wrw.148.1596719387813; 
 Thu, 06 Aug 2020 06:09:47 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w2sm7092799wre.5.2020.08.06.06.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 06:09:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 0/2] hw/core/sysbus: Trivial cleanup patches
Date: Thu,  6 Aug 2020 15:09:43 +0200
Message-Id: <20200806130945.21629-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a typo and assert sysbus_mmio_get_region() is called
with correct index.

Philippe Mathieu-Daudé (2):
  hw/core/sysbus: Fix a typo
  hw/core/sysbus: Assert memory region index is in range

 hw/core/sysbus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.21.3


