Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448D1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F111208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL4o0vdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F111208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVsV-0007aZ-B5
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 07:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlVql-0005go-Dm
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 07:03:23 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:34772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlVqh-0005Jj-Rk
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 07:03:22 -0400
Received: by mail-ej1-x631.google.com with SMTP id l27so1870700ejc.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3HBU+L9bmUiI3U0wtFQXI8oHAYJ2pCtOFRR8zu1jSBA=;
 b=iL4o0vdLrbiEh60FMogacBZcVIJC81a2nG//HETOih9o9HpsuhEZwo2C7wmPogm7Vs
 Nd6w9tssCjPiYo2ag2xp91CYgRCRwITJtvm80dC1Au3LY3n8CQLtsvOUVg44lnKUABhP
 RfDVUdRiJ3ISpJ4bq0+1foWpgbhfvCVJ8w1UkGljr4ICwFWpgJpLZpRdFiL2zM6thyBu
 a0Ym68UXOvkjNNIaQb3s/lkW9J6UXCrmtXxZbgM3si/oqRrYwUsAXQGnbgGFenfRLbab
 6tfO135U2UTbVO5SbOLjOfTMLRLQDMH7G9dgJ63pfLGz0akH5fQwD4UmLcRns+KCkVJI
 BPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3HBU+L9bmUiI3U0wtFQXI8oHAYJ2pCtOFRR8zu1jSBA=;
 b=WkcAlazj/us9z1Q7uAhZYMRtcSEPZENfzfRghzZe5NENRFgDz7j/APJJMIYpcZaDqf
 3gbPRnBNQIQ84LrdyUiFlzrMIUPuhC4U36n3qnHGVOrqtM19XlFqnk90j8cqPdE6ralw
 /Pf7/1a3dljr+okwOIVbduGIjqmjKC2F1hM0kYxFd/Jtx/r+9kT+s1AJPT+eKjrSq+uo
 AWclAB/4htpt95ZqeGP2O+mZXa7WamiG9T4nOz1R6P69J8KY94auh71yk8KiHx7qfMBy
 526WTwjKPH/A0GZzYKHfulp73BYWJGDHl9/h92u1xhcVOMWAOm7iX36N4X5Jy7+eVw6X
 Zfww==
X-Gm-Message-State: AOAM530Vr25jZNGyFBHQwiqIR3wFdU1l8LVI01LUc8tJoocBsK1SB8x/
 c0UYah/jvPQAaxO5KQCIkhEPfVWm
X-Google-Smtp-Source: ABdhPJx8O5WyeHz1A507TWeNhCgehNHHQzOR0Pblnz+xTxCEhl9ZzCioETEAJNQxTtHJ+eIXnJ0FNA==
X-Received: by 2002:a17:907:1104:: with SMTP id
 qu4mr6713774ejb.382.1592391797886; 
 Wed, 17 Jun 2020 04:03:17 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 dc8sm11835806edb.10.2020.06.17.04.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 04:03:17 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/3] hyperv: vmbus: ACPI various corrections
Date: Wed, 17 Jun 2020 14:03:01 +0300
Message-Id: <20200617110304.636666-1-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x631.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mail@maciej.szmigiero.name, Jon Doron <arilou@gmail.com>,
 rvkagan@yandex-team.ru, imammedo@redhat.com, pbonzini@redhat.com,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After doing further tests and looking at the latest HyperV ACPI DSDT.
Do minor fix to our VMBus ACPI entry.

Jon Doron (3):
  hyperv: vmbus: Remove the 2nd IRQ
  i386: acpi: vmbus: Add _ADR definition
  acpi: i386: Move VMBus DSDT entry to SB

 hw/hyperv/vmbus.c                |  1 -
 hw/i386/acpi-build.c             | 15 ++++++++-------
 include/hw/hyperv/vmbus-bridge.h |  1 -
 3 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.24.1


