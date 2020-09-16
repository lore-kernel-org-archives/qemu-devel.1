Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569C3C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5FC20872
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="mOjw/OVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5FC20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISmO-0000em-T7
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kISfS-0000As-Pj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:19:54 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:33316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kISfR-0004pX-25
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:19:54 -0400
Received: by mail-pj1-x1041.google.com with SMTP id md22so1154236pjb.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fmZ0zShxvpsHgpLnoq8aruXTkYTNo4xgCabQ1KXMZUo=;
 b=mOjw/OVWW6RlQ/E6LT06/1FXEY5J6GfDy6Ii/SFXFVT0un0xOh3E+WqiaFjne2t8dd
 0k9wfA1XGuY/3Ks+E0YLgGeFuAt0TbpAovcJXldCRS0amZ164KZdi9ktZ4ciCPwy35lE
 /rUsjyMbHKVg5R2jNVaHGs5Ou0fXcrdNHXt/WW7unhqun8u41Dslpw6jMMDHcclB7INX
 cJSUMLPW/QnjBw3mSk1NL+6u59XAb+0573yoPb1SlWpa4+7PVGrA1JVHO8+fIm+leZCK
 5RJeF/NDOTnHJZoQS9PoHA36hVF/nbk6bhDp9BSddycyzNbetw2nXy4VOj+5lNuZzYYb
 pMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fmZ0zShxvpsHgpLnoq8aruXTkYTNo4xgCabQ1KXMZUo=;
 b=nGOeke6BF0jqEBzWHQaMpAm/9j8mF/j9/huvMtoig/peawHaf2DoErFYzII92Um/Pm
 7P9eXRjfOEdy4mzkrsnytRg2rTx/FxBdaQBbKBH49iF7+5Vc9bLwKZFErfiWqS1dDXJ3
 AmXF/ijopfRl3QPqBDG0hC7kM8qhaePogkSUK6c6AL8Wn91o6Uz1A+n1XKr5aezx/pzS
 7Y+JKR2gQILNDhr2L6jpauO2BxMtvCGkbLWa8zqaYu4MQlUPo61RLVCkbcu6tNf2S7wf
 xUJGNGeOffT/iPkDONOFsRn4OO7GP4kMkZVgTDXxls6ZQPbgY+9z8+7GPy7kCAGLLTi4
 uXSg==
X-Gm-Message-State: AOAM5302thy7069ByyZJvXWzhYJM/TWnP1VerM1Y+jX8mws8TzQ7jDVD
 wubDAKsU8EfA8+Fy0EasKWPTyOF1nwywRwhq
X-Google-Smtp-Source: ABdhPJx4cx0P2zN5xxbYYG5B8YcNbXyUq9KR6oU3m9ImVIi744th8Hkio8u+2ZC2rdoG2ciVBHdAqQ==
X-Received: by 2002:a17:90a:df0b:: with SMTP id
 gp11mr2924979pjb.64.1600244391361; 
 Wed, 16 Sep 2020 01:19:51 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id nl10sm1658254pjb.11.2020.09.16.01.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 01:19:50 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/11] tests/acpi: list added acpi table binary file for
 pci bridge hotplug test
Date: Wed, 16 Sep 2020 13:49:05 +0530
Message-Id: <20200916081910.977-7-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916081910.977-1-ani@anisinha.ca>
References: <20200916081910.977-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1041;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1041.google.com
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

The file 'tests/data/acpi/pc/DSDT.hpbridge' is a newly added acpi table file for
testing the pci bridge option 'acpi-pci-hotplug-with-bridge-support' under i440fx.
This change documents this fact.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..96a9237355 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.hpbridge",
-- 
2.17.1


