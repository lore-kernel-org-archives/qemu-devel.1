Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A6FC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397132224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPYocz0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397132224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUT2s-0001FE-RV
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUT18-0008Ux-OJ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:07:54 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUT16-0003hx-OE
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:07:54 -0400
Received: by mail-wr1-x434.google.com with SMTP id t9so10878000wrq.11
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 04:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Pjt13CQmDgkRb8WxGkjM+BURG+rzrHKY/YQd4e1L7i4=;
 b=WPYocz0QYg5+a6596sPOQ626R6eNIsV4fKh+y08Etac4n6SFE7fZhHiqbx1dkt+vO4
 WaMKtPMWP1eo2Z80fIBrQwKIrPiGwB96E+y3wLr6LthVd1a/a7hsjCqmVegH++fpOxi8
 5CUSEG4msxEb7c1L1HtIsUZxZMWkv1L7mdgkbQENckisgf8uzfevDeqItsdVODxqY4Y4
 fXinbunR36R211mEctrDBiM3PpT4n4Pz0N/eoXvCxRwbZUQV+WNujx62kij+bLS4vtYR
 YYGFmKFR8ZBNSp1E3hUA1ln6QBqDUaIzDPNRzLnqR3chrT2MSj3HrJxiC1waLj3SKKer
 vEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Pjt13CQmDgkRb8WxGkjM+BURG+rzrHKY/YQd4e1L7i4=;
 b=HO7nl3t/1jz4izu1BLH1z0rAB8zCNmxDd3TY7sxaYzCc9nEkwKeaOlZmIRv0TeWnGO
 DE+Y/7Mc/M9tV4fwZ+QYhdpNGgJ2Gp+ecznkv121lWDrAGrA5PHzz5K9/NIGtIce81FW
 Bbug1igonk9MI4YM4EP8mYJQHRRbaeYQBePgoE4iyUynTJVdNYSB11+U4pWFgeumeOuL
 GjgQoa1yRoEWdLZPboTHPmiVVZQDCLke/Q6CyMy8x+IixMtp0iiTQSNL6VLcV3/2BOpN
 xSz1r9Vo/StbiNvFRVNzq8yqR0dTZcm6FuTxPOl7qaWg2xoYIsldIODQ7h05KW21NPPV
 id6g==
X-Gm-Message-State: AOAM533v/RTGiwXBHRdeteoIxeJF2LFVtISyj3aVFW6uulDTyWyZPm9N
 YkwWdQBw+ct9xvfyy4Pvb8fEoS8mgL8=
X-Google-Smtp-Source: ABdhPJxGew5exoWjN4gqwhZ+hQ6BnWu2d/WFREUbK3k4QgFjsdSR/sKOUaw5uBiQqN5qoLY6uL7lig==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr18783116wrq.129.1603105670889; 
 Mon, 19 Oct 2020 04:07:50 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id p9sm15876388wma.12.2020.10.19.04.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 04:07:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 0/1] tests/vm: Add Haiku VM
Date: Mon, 19 Oct 2020 13:07:48 +0200
Message-Id: <20201019110749.1635343-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Intent to not get Alexander's patch lost.=0D
=0D
Since v2:=0D
- No change, posted as single patch=0D
=0D
Since v1:=0D
- Addressed Thomas Huth review comments=0D
=0D
Alexander von Gluck IV (1):=0D
  tests/vm: Add Haiku test based on their vagrant images=0D
=0D
 tests/keys/vagrant        |  27 +++++++++=0D
 tests/keys/vagrant.pub    |   1 +=0D
 tests/vm/Makefile.include |   3 +-=0D
 tests/vm/basevm.py        |   5 +-=0D
 tests/vm/haiku.x86_64     | 116 ++++++++++++++++++++++++++++++++++++++=0D
 5 files changed, 149 insertions(+), 3 deletions(-)=0D
 create mode 100644 tests/keys/vagrant=0D
 create mode 100644 tests/keys/vagrant.pub=0D
 create mode 100755 tests/vm/haiku.x86_64=0D
=0D
-- =0D
2.26.2=0D
=0D

