Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BA9C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE5C21973
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="AfGDjH/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE5C21973
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIofj-0001BE-V7
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoe1-0007ao-B0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:47:53 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIodz-0004nH-J1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:47:53 -0400
Received: by mail-pl1-x644.google.com with SMTP id k13so696886plk.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+C/GKper9Hc1Rp3TxABDngRg3jAp3GhgbcS73g/TxHk=;
 b=AfGDjH/3XB4SH/9e5HJ4ouEQk9W2QfTw3LLp4RSLCNTlvOtg0QiXlzBAzXB18ufAba
 2qHqH+88S1DCdnRftjj2rN1xEg+6vhkVtPCOWZqjEk+traQfKZZwfgE9/LC9i38rxyOM
 b1KC38T0toxTyPuyLxETCAKUzHae2pXx49kSVNeEX2MCN5XETzaV+fXMTRCWoZrZNe+c
 ueFxZLLs4z1e8+S9kQofBeosrUSrxAKB49r9S0zvaG0lSNSPKtU1Dv/aAUSx96UUtxZQ
 esjQB21jiudSZcwoH9H9vYViRDvQNrxskyyvjoeEeod7SJoKsDhiHQjLpEVwH7quW6QA
 PsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+C/GKper9Hc1Rp3TxABDngRg3jAp3GhgbcS73g/TxHk=;
 b=WS39KwQ1m2zsLglugOXSTNoEQuU8wMrY+8v7G/kULcKUnhC7kitwP9ZS2wcGfRjiqG
 vqZMtXpkDSJUv61cV8iMsRouC7Rv82alitVSGc06R9HXFv55yehRwnsadacKF///9XGk
 /rMPEFmLR/l5Jnvu/wZv5nZbgdSv1w8zvE53dYMph2n+V0DE2FK/0e73mTCIFM+O6UrQ
 W3LBtk0B7YRz10H5zlBCk86FFNEqyKYTJf9zZ5IhinChVwzUW3/2dk4MkMoCbC/3iSDh
 e3ZTAYNwCIL/63ygbKMln8N+n1BHyBrW1pyxgUAjLh1rJINgfuezlSUT+3/cPFzXB139
 e5qQ==
X-Gm-Message-State: AOAM531sMF+OFofEYmno2vpFeU3Ayh8sotZwSW8IjuNqIh9plpzaMp3c
 eDA7dcP6fLJq11O2oLc+ud4owupKbTpsIALb
X-Google-Smtp-Source: ABdhPJwxW4WoLqwhsBACVSHI3OZPt81p6C8JcmFkoz4zH0aTbjjWBznrbf9GAlfftibegNtQZQ4Yew==
X-Received: by 2002:a17:902:7896:b029:d0:b9dd:edae with SMTP id
 q22-20020a1709027896b02900d0b9ddedaemr26735880pll.0.1600328869760; 
 Thu, 17 Sep 2020 00:47:49 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id y3sm20572516pfb.18.2020.09.17.00.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 00:47:48 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 01/12] tests/acpi: mark addition of table DSDT.roothp for
 unit testing root pci hotplug
Date: Thu, 17 Sep 2020 13:17:21 +0530
Message-Id: <20200917074733.13612-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917074733.13612-1-ani@anisinha.ca>
References: <20200917074733.13612-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::644;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A new binary acpi table tests/data/acpi/pc/DSDT.roothp is added in order to
unit test the feature flag that can disable/enable root pci bus hotplug on
i440fx. This feature was added with the commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on
the root bus")

This change documents the fact that this new file addition was made as a part
of the unit test change.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..ac864fc982 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.roothp",
-- 
2.17.1


