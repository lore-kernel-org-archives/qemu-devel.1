Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59A5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A515620657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8kPPTFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A515620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvd1j-0002ee-Vo
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 04:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jvd0y-0001Xw-1y
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:43:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jvd0v-0007AL-Um
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:43:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id b6so1480231wrs.11
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gwmeUmtRXVgAWc02llIn7SisvRZP7RHL7AHJlXQJ9A4=;
 b=R8kPPTFppE+OUwLkmGbHaLJF4aZ95G7DzxzPUnE1ZBTk42qWRL403AXFMR8Zgl1dQc
 PMiEUC0aVWMgTdvOsg0j4gsMtGUbTGQMaMIOhHVu75/GM3bxng3QUcBaeS/mrPvtcsPR
 b8X7mNP+40dcMDHucn/ODbxGb4CoOhMCSDAsrC5/wwVANtCo1T1lH47xlUQhKjyFGgPO
 xh9tlJYpPnM6hg0WQD5IlrTv9Vte5htPC8+I+h1J6l+yLxiMbtV/7n/0/zYer5zXneEz
 BTZmIf2gZvQO1SnbPxB54VCISRuE6HuPoYtihEylCE/7onK1ygsFzyrlhQue17fHMzqc
 SnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gwmeUmtRXVgAWc02llIn7SisvRZP7RHL7AHJlXQJ9A4=;
 b=DjMc3mjHslCT3xPdRqWaLta7cLaw5CUp5vBJR+YB0ZcpeN6uHn6bVJ7lAxbMDGLBx+
 oBJ3p24ZPT1wrcyfAGOgkWpe8YdKrxfmQIrZxqPJZ+RwIS4nt7YvN2VkuInyTcGUZRWX
 5rUgqZQWqW9C8c4jryiP59m9EXsmu3F9VnkAiSou8tAZY8nHVhX/lApggsSGuQ/6vg0U
 5EwZanhA/HQbXkqDaxbZbat18KmV/L6/yW/l5qFaI9xmS2vQnxc39w9JQ3yOHFjruY0n
 pIA4SvODNekpQaWnrYT2QCwkt54xYow0BIk72i7NmLxG4KSbeUztPyHkr4d6cgZRmRU2
 IINg==
X-Gm-Message-State: AOAM5308Qz7OBBSjpM89TMVNV4CeSGqHFDj8h0PqZK9LwxDBh62Bi18o
 tDu7HQaBhYzy/E/ABksvRKT5cyey1AM=
X-Google-Smtp-Source: ABdhPJx88lH3TOidOF/FMtJydxjWQ9Q71aSdpLeFhk3txkSFozbpsG27gX0yr83HnucNqExUBNkd5Q==
X-Received: by 2002:adf:8342:: with SMTP id 60mr9998128wrd.62.1594802619383;
 Wed, 15 Jul 2020 01:43:39 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-64.inter.net.il. [84.229.155.64])
 by smtp.gmail.com with ESMTPSA id
 g195sm2369386wme.38.2020.07.15.01.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 01:43:38 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/2] hyperv: vmbus: ACPI various corrections
Date: Wed, 15 Jul 2020 11:43:24 +0300
Message-Id: <20200715084326.678715-1-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=arilou@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v5:
* Rebased on latest master
* Added a patch to fix 32bit compliation on VMBus

v4:
* Removed the patch which adds _ADR definition to the VMBus
* Correct the change which moves the VMBus under the SB

v3:
Removed accidental change for the dct submodule head

v2:
Renamed irq0 to irq now that there is a single IRQ required

Jon Doron (2):
  acpi: i386: Move VMBus DSDT entry to SB
  hw: hyperv: vmbus: Fix 32bit compilation

 hw/hyperv/vmbus.c    |  3 ++-
 hw/i386/acpi-build.c | 12 +++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.24.1


