Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0EDC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6637D22B43
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgSa9mOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6637D22B43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0CTp-0008U8-Ly
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 19:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k0CT2-0007Fj-5H
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 19:23:36 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:35516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k0CT0-00060G-Ka
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 19:23:35 -0400
Received: by mail-oi1-x22e.google.com with SMTP id k4so15854095oik.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 16:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ucNQHb5+qEkxz1CBTGPeVzSEnjAxJDTcCt7fEqPv3qo=;
 b=WgSa9mOZuf2H8Vuc88sJDsMgpi3N3TBE1w6PD3EWfCB0vZ3Hpj1HwToLtcr5Ok9xAb
 buvS026gkfDo8c+p94Ngc2FFGUoLoI7PNHBxL18mTywHzoXa/CcdhmrRmKZpX7KZX5Z9
 3WF3W66ilTugnql4iKv77O7hb38zQtYTCafZRy2NUCQPbUfJ/tAuXntG+XYbv3fb5Vvi
 FkokfOfMGFBgsMHOTZY+srjyr1GmcxqHIq6X9J6BzrgL9xSJ1Y2naUWXUHoj9gqoW6XW
 5YhAgb+MdAFQ4H0iQ5g5GX22MTDLbusLpnKmUz21XZnxstlxplTUnEkqetSh5yaTm/d3
 mCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ucNQHb5+qEkxz1CBTGPeVzSEnjAxJDTcCt7fEqPv3qo=;
 b=VqiInRiBfMZ4vNl+fvIOFNRrSiSz0c8sPMHB/bSSM8K8uBhdHfsn6oav7Z1U34YZtR
 2oi2YUuYybyUcQk2Mm11bSddEpHlDFhsoMF4MBMF5UqxuPptlXjUsZJWhsS3XWO5WSfV
 S/gDEs7HB7A6fu0SCK9NyE50BUmRvBjtCB3b4eXr2LwRpIfJKm2qISdfqozeZu9XvqkE
 eUz+CS3ToVuahh3GfcLzJKN6JlcQRFyMhSeMt580JHpu+Jv3W3JZzfXMH255iJkEyQ+g
 YT9uOhikm/PFchIb86vR3O57n41vckLhFQo6NWMeEh2A34CqN+pmgRpKOBoQAHItBMAl
 dZHA==
X-Gm-Message-State: AOAM533G+C1QGkdNLn7cTcUxgqeAQx2lwuySes+ovOErsUnsVneTvbq6
 671T0dpa7fwDHc9y7+bQfT2FR8yL
X-Google-Smtp-Source: ABdhPJxr4i4yxo8pMjqbIXZ/yAsCowNItDvCxKPKx8JwywrJjUMZrWcJM8ijiM0kr8W178edgz/C8w==
X-Received: by 2002:aca:784:: with SMTP id 126mr1415300oih.33.1595892213296;
 Mon, 27 Jul 2020 16:23:33 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id n189sm2353980oib.30.2020.07.27.16.23.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 27 Jul 2020 16:23:32 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.1 2/2] qga/qapi-schema: Document -1 for invalid PCI
 address fields
Date: Mon, 27 Jul 2020 18:22:37 -0500
Message-Id: <20200727232237.31024-3-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727232237.31024-1-mdroth@linux.vnet.ibm.com>
References: <20200727232237.31024-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x22e.google.com
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The "guest-get-fsinfo" could also be used for non-PCI devices in the
future. And the code in GuestPCIAddress() in qga/commands-win32.c seems
to be using "-1" for fields that it can not determine already. Thus
let's properly document "-1" as value for invalid PCI address fields.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/qapi-schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 4be9aad48e..408a662ea5 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -846,7 +846,7 @@
 ##
 # @GuestDiskAddress:
 #
-# @pci-controller: controller's PCI address
+# @pci-controller: controller's PCI address (fields are set to -1 if invalid)
 # @bus-type: bus type
 # @bus: bus id
 # @target: target id
-- 
2.17.1


