Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00191C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE35D20643
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 00:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVyQVLTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE35D20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipLOX-0008DK-RN
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 19:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipLKM-0003Ns-H2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipLKL-0007Ru-67
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:05:30 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ipLKK-0007P7-Tu
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 19:05:29 -0500
Received: by mail-wr1-x443.google.com with SMTP id d16so5362968wre.10
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 16:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z55IlfRBinV8LBpI2kGNYGpYx9irE64uvHL0yFKjFIk=;
 b=eVyQVLTcb8obItjiI/uZ0cKbQBsjbLJyFZL4XkMk3Dd2l+sFM6xtlhbkikcQT31UY2
 3Dbfrc4128rBpeSQvRyNi7Ytm3i2pXmXHeT+kUSXb22vPn/pee9lMTEB5T+87GeBJASo
 gAtYZPg7mfaIWWG214NmXKQ5yyIF3X5gcYmEM3QoagAlsZTdjSIsPhmE0WY8n4YH9xMe
 iT0ZyZ76f8N179kKSDNynDaGbJRMJIGgbGeRRE4yY6mec9k96IPx2zzQl56mEtkgc9Df
 H0tMelZjrj1S5jrXZPL2zrCt9ORMmgQ0TMVtEDIJgO6wCuFOHCFThIBqdgMGtEZxuMuc
 isww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Z55IlfRBinV8LBpI2kGNYGpYx9irE64uvHL0yFKjFIk=;
 b=hLGGK4+v7VQHwdVBwijKcz5N1Ww/DrxW2x0gqaKd0Gp/8KwyODzGjHnQTXqijIgT/c
 GLCQcLDFNr8MnjqPw4k1hc2YBUYf/oUIHx57qnip8xezJ2PBgvGlAe0COSKEVD+T4AE+
 AoKH98LbrjW6OA8LVgw2W7kjU9EUzKQyDYj2lsLkHiARu/0OGNdAWYFamNEu8VCH7/kj
 iBxFJrD0iL2wHI4oU/3P21vRFYGd2CqduGO3C9C/2olmTHMrZV1V4UsFKwky5FEIH979
 3arQV81Q3FUxh5PJHdRBqJNLtybO8nB7aar82Z5oFWDPhC1zWOVSMWos2HBZdACS+zBg
 xSCQ==
X-Gm-Message-State: APjAAAV3ynG3q1GRzQF/mgYOLzOlGKx8aflFIq9icbZriQAcuCE8VovI
 FoDNCS5T8RQ/p7t5HVMpYSg=
X-Google-Smtp-Source: APXvYqy4o2BN2RJtgUKG9Wrh4e78fP/gyUvXp8ApSmTPmVhxKT1yGMgbVdznqtEOWzCA1svoyWHAxA==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr7284173wrn.140.1578528327508; 
 Wed, 08 Jan 2020 16:05:27 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w13sm5947827wru.38.2020.01.08.16.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 16:05:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] hw/hppa/machine: Restrict the total memory size to 3GB
Date: Thu,  9 Jan 2020 01:05:22 +0100
Message-Id: <20200109000525.24744-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Following the discussion of Igor's patch "hppa: allow max
ram size upto 4Gb" [1] I tried to simplify the current
code so Igor's series doesn't change the CLI with this
machine.

v2: Simplify by limiting to 3GB (Helge review)

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg667903.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg669309.html

Philippe Mathieu-Daudé (3):
  hw/hppa/machine: Correctly check the firmware is in PDC range
  hw/hppa/machine: Restrict the total memory size to 3GB
  hw/hppa/machine: Map the PDC memory region with higher priority

 hw/hppa/machine.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.21.1


