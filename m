Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1779C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 04:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D62207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 04:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IunK8/yI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D62207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joJrB-0008Lt-U3
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 00:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1joJqE-0007Xs-SJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 00:50:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:37659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1joJqD-0006el-5W
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 00:50:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id o2so4534217wmh.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 21:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ifoVwE32l3CS8D8Fr5BuQy/Tt4d+KBAVO2IpK0AiFIc=;
 b=IunK8/yIn3Ym4wtVpKju0NUUKUGV3Dfhwm+MZDf7xgveSbEaxe3hKKWUrou0ScwXkz
 lYHHHLzNE/0U5Cpl3iGJnLSAQ+KRxbnJXVxPDwCLe8YG5JA8OjoQHb0nq1TrJTFlR71q
 p3zQnDMnq/j05z197FGbawhvGUwEjavROkmXbKZV64hWtuliFisgav0Bey49bBELknt4
 jVFeKVbTVwz6u9kYsDNgZyoZUjyBGc+cXah7asQ4yA6/9KIOQxSRgBEihyvmDg4M7W2e
 KmP6n2oDaPbnXbauuomZQKJcxciuew2vqXF0u/kA6N19lvoO3OAIelYr9lpeR3lnyJk3
 zo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ifoVwE32l3CS8D8Fr5BuQy/Tt4d+KBAVO2IpK0AiFIc=;
 b=KtYi10If1uhn32nzmA+OuIaT/E7KQmhS3ZkpAD8G7D9Gb5jpmT8WzyKZpaRcwBEd7W
 EGCuPTOO5ehtJICvmKrzyYYB4kjgYDjOmuI5u+aCiwG/sos7UJQwfWzhSQeKxHAmE66Q
 yeACa7rfZtxH+AVH+2CwUqetl73nL0aGuwlBbajQoBZslq3SoC42Mc/v2gEaMFM2Wr3j
 Dsi5ZbWl8GrBRd/7Ibqr3DJuM0heqWOvI9cgX3dIrlDPlafBKYDj4LHffVRBWKdLxwXc
 FHuHIOmRDiMI85BarOgCgTvUtugYHcd7A9cMqeKjbMhbd6Jae/RNyptPpMGVN8U5ala0
 utqg==
X-Gm-Message-State: AOAM5306Y4K3I/BgDvwc/nFsrlCyi39BIq5pmXslFHBafGk/D4CpyahB
 OowG9imK2hntsImOY/9LC/KCam48
X-Google-Smtp-Source: ABdhPJyhgXhfHut8uSvLMFw3xyD14Sm95ZkoTD5NnAOTDGls3HLSm1BOpLydJBK9lSWxJN+8hLNrqw==
X-Received: by 2002:a1c:9eca:: with SMTP id h193mr1327097wme.38.1593060623515; 
 Wed, 24 Jun 2020 21:50:23 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-64.inter.net.il. [84.229.155.64])
 by smtp.gmail.com with ESMTPSA id
 x7sm30684787wrr.72.2020.06.24.21.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 21:50:22 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] hyperv: vmbus: ACPI various corrections
Date: Thu, 25 Jun 2020 07:50:09 +0300
Message-Id: <20200625045011.1075314-1-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=arilou@gmail.com; helo=mail-wm1-x330.google.com
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

v4:
* Removed the patch which adds _ADR definition to the VMBus
* Correct the change which moves the VMBus under the SB

v3:
Removed accidental change for the dct submodule head

v2:
Renamed irq0 to irq now that there is a single IRQ required

Jon Doron (2):
  hyperv: vmbus: Remove the 2nd IRQ
  acpi: i386: Move VMBus DSDT entry to SB

 hw/hyperv/vmbus.c                |  3 +--
 hw/i386/acpi-build.c             | 16 ++++++++--------
 include/hw/hyperv/vmbus-bridge.h |  3 +--
 3 files changed, 10 insertions(+), 12 deletions(-)

-- 
2.24.1


