Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277E0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD5521534
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAUNvIDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD5521534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlaeF-0003mH-4f
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlacs-0002Hw-CV
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:09:22 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:33977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlacq-0008FD-S2
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:09:22 -0400
Received: by mail-ed1-x531.google.com with SMTP id w7so2429345edt.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C5IycSyFXqtzz8UxI4z3a3qRuqRkdx/XCkjWMguZYzU=;
 b=BAUNvIDDXX0GdK9evR9wuclOdJeOxrWdscYROjJzVbiGbhPeqyp0XeV6zwawH9TfXk
 eC1qkcBASW6vV+iOnbUnXNlLthbJaqBgYJzINHKM7KyFwXfmjnLPKi5RIJH/szpkHLki
 Zmi+sF6IieKWrP432QIzj910U/QhaIcpQR3RYMTbl71Gz2Oua2raKECwaW1pl6nd6gYp
 fkv2r5iocvkeKH8qcgJmTS6Oc4jQHn6DHmASYS1+bvQeDg8NzW8WNdcXsnKConw1hLR7
 KhuB4jL74HCDRWllI+ZwhtdL7kx3J/vo9lvoNWkmUUiZZMR1YQuBA/b/E1Uuyl42uudl
 ucgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C5IycSyFXqtzz8UxI4z3a3qRuqRkdx/XCkjWMguZYzU=;
 b=jf8fDgvCJnqmc1ugWl4H4Ji+vD8k+w/qVFLtesmkScj3FO6tKAtja7+E3BxqEMkhCE
 nMnEd3QbhSJlz34GjuzrShbIz5Vse5YC/GpY4jDlOXstvMqEbBEV2rw3snMUpDWdnixP
 N52OqrNq3Md97M1o4xpvWs2pxcdXMO4nrqIV5OFl+UOMHVn5+ozOODWvg5azpl0TV6P/
 7NE6mwtserToWD2e+olAs2BTnb61aXRNM6TiikHQ8eqmjwozxafRviDiBfeEcD4UnCLg
 0o2R4F6x1DBJ4mf/YRGrqIdXYpx6ELhm7tPKfSC0M/PEy3q+d1t6uxicmgzbuZarYg9u
 Ts3A==
X-Gm-Message-State: AOAM533IegkdAQSuMAA6x2OVmrbccf1Bh3uyvazkwQDy88naHVvYBYN0
 I2ILbXNQtw+W8g3q3xKdU5jvfJ2ZMvw=
X-Google-Smtp-Source: ABdhPJzT4/K0jXzZLvEYfqPAZelvnTHVD0iG4/NhxNRduQW22d8GoZvlC1TNoNOxhtdteKJTeSiiRA==
X-Received: by 2002:a05:6402:1243:: with SMTP id
 l3mr8246159edw.64.1592410159147; 
 Wed, 17 Jun 2020 09:09:19 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 bs1sm65365edb.43.2020.06.17.09.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 09:09:18 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] hyperv: vmbus: ACPI various corrections
Date: Wed, 17 Jun 2020 19:09:01 +0300
Message-Id: <20200617160904.681845-1-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=arilou@gmail.com; helo=mail-ed1-x531.google.com
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

v2:
Renamed irq0 to irq now that there is a single IRQ required

Jon Doron (3):
  hyperv: vmbus: Remove the 2nd IRQ
  i386: acpi: vmbus: Add _ADR definition
  acpi: i386: Move VMBus DSDT entry to SB

 dtc                              |  2 +-
 hw/hyperv/vmbus.c                |  3 +--
 hw/i386/acpi-build.c             | 17 +++++++++--------
 include/hw/hyperv/vmbus-bridge.h |  3 +--
 4 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.24.1


