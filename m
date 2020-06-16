Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE8AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E85F20882
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkn0lArI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E85F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCpL-0000u9-P7
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQL-00038w-M7; Tue, 16 Jun 2020 10:18:49 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQJ-0006uX-Qk; Tue, 16 Jun 2020 10:18:49 -0400
Received: by mail-ot1-x341.google.com with SMTP id m2so16023049otr.12;
 Tue, 16 Jun 2020 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b1A+Yvt6udox+8JxoKh9t3OrmlBhYZ2sN0wsHf8qJP0=;
 b=gkn0lArI48mwgUWuK2lUwaq8YIcdR69Eb6WXJO4gAEn/QE+ELmEI3FgNxa2ei24S1R
 MR1QX6I/yJwea/NSQA49KoOqjOGs6XuLyVkc7i+VrueP5XgSbCKUzyG/1W7SnEQhYo2l
 128zFeUgXvl76xUEiS/+sMwRCenwbV0dYq8h+QVN68mzBi3E/xUifEgeSnVoSvhyHpQL
 CJWhW1M9qMI462WQice0MuFBho0NeEQdF1ds1DWEzLYO7iI79a+8cUfTuLCpBDhrngwt
 uX9jHP0p2IBPPZmssLfdAMfklz2m2m3MWD9PYOucw8cP9hRmpugvuumkK2ri+1fhxdZ4
 6JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=b1A+Yvt6udox+8JxoKh9t3OrmlBhYZ2sN0wsHf8qJP0=;
 b=mFoaj2OQ83bhumxM/8qvhpci/3gYnB3rs/JpYMI7RhJfww3YrVsBcTMapFWkfDR4xG
 ww2phKMFv8z9NZkqfkO0Ge89gL4vZiidLjDeb2/i2yxl14Dpmhdc6H7HTTmxfRa8PmrS
 hjzB7/EoX4K8SlzAryxHFJzcX88T9Op2EalXioeWV8ytDrsIYpV7915qQyGGnzUeh4+L
 L+jQNfnOH9hUarn23x3Z1aNEavnaZ6QcXLmr8YVFvGFLH2XyYm2qIIb7Fqtg0pxzWTJn
 tjAP8BP2n1A2mqKpaoScrcf2coOO4C4yxcoTuJq6gchLkzdiaXHLH1g6/hiYZkRicalN
 Ri2g==
X-Gm-Message-State: AOAM53023vflL2suYkgrjkPa0C97lkRL6eKqxu0827lZj6IL0sUyM2sq
 W5fA1n6B5MAxUi7F0BFaIIwSLHeH
X-Google-Smtp-Source: ABdhPJwQYjZpCpiZTe4/K1rUxNxKOO0B45x7HET+0mBUJ1O5eb75xkjr639EUko0c16CdxeMa3kmsA==
X-Received: by 2002:a05:6830:1dcb:: with SMTP id
 a11mr2692986otj.16.1592317125873; 
 Tue, 16 Jun 2020 07:18:45 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id b2sm4156905ooe.13.2020.06.16.07.18.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:43 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/78] qapi: better document NVMe blockdev @device parameter
Date: Tue, 16 Jun 2020 09:14:33 -0500
Message-Id: <20200616141547.24664-5-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

Mention that this is a PCI device address & give the format it is
expected in. Also mention that it must be first unbound from any
host kernel driver.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit ecaf647f300d69271c245a67adca9c3a89d9463a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qapi/block-core.json | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0cf68fea14..fcb52ec24f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2963,9 +2963,13 @@
 #
 # Driver specific block device options for the NVMe backend.
 #
-# @device:    controller address of the NVMe device.
+# @device:    PCI controller address of the NVMe device in
+#             format hhhh:bb:ss.f (host:bus:slot.function)
 # @namespace: namespace number of the device, starting from 1.
 #
+# Note that the PCI @device must have been unbound from any host
+# kernel driver before instructing QEMU to add the blockdev.
+#
 # Since: 2.12
 ##
 { 'struct': 'BlockdevOptionsNVMe',
-- 
2.17.1


