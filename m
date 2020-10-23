Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF36C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050FB20878
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amGjUqjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050FB20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVx0O-00028l-U2
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVwxe-0007oi-Ch; Fri, 23 Oct 2020 09:18:26 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVwxb-0000cb-A2; Fri, 23 Oct 2020 09:18:26 -0400
Received: by mail-wm1-x344.google.com with SMTP id d78so1428272wmd.3;
 Fri, 23 Oct 2020 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fU7Y32HpDHj3PStO+v0DuDWQ0XGm+AsKTwdd8p4UUQQ=;
 b=amGjUqjWwAU4MXDxBhfNkrUDOap6ERkQkjBiq0/mPykDeDRRx/EMSUdV4KkwiPP0+j
 wJtJMsrSrjFNPzdP4JUGIO/RKiA/+9vUV6f7ftKtOhhsOO71WM5dmu3ekX9flxwlnkA8
 33VhCnQzMBdf7fe1U6gUxeZJiEiwBuO0PbIsEyDgrKQm6Y6dFBqW/T1qfujcumQbgaNK
 XJZH/48TgUokE0FFOZR5euID0CwxqHpVbm01+hO5QubZ7101VUhxPHJO2p5kNiYZiWxL
 i3cczi8JnsxM5XPecW4haj4hz+VpuYjCD9LoVtN8L7KeHNfTtJng+Gm5bjx2cq2F6BU8
 03yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fU7Y32HpDHj3PStO+v0DuDWQ0XGm+AsKTwdd8p4UUQQ=;
 b=XvFjWuDGqLjBU+kv6dE8b1CtY+kjV0vdr/WXKEK9gx/VNyKAzLo4UtwzrbaE5QgY2W
 YsYpyd6cAKPZlHsIggqU+n5uA76Rqst9FkT6lU62Pet/tj8s8f8+JEn61M+WbbI1lWGr
 jCbGCy+ebL+5n+N6dBDV7KgPpHy86PnuXrTt5HyJH2Yu8SOv841YHqgER0i12lNP+AFd
 8gCRVa54b/EbJo6d6pwUfHjUr1wDBeVcs1qpxfOL2cTZBM/tdctXdvdwIAZ2o0rPnM0A
 IFOQWSu3Mkq1hEhKkMNrx8mLyRdbKoaltGvmfYAvyZdoq64K2RQzx7pZks2zGFuk6l1S
 Ng7g==
X-Gm-Message-State: AOAM531vBbmyYbhVNdrPwcSgpcziuVc0YbOiK0LgxhM/1drQX7w8u/kr
 TtTQ8x8ivCILDr2rckn/Da7GRBLrot8=
X-Google-Smtp-Source: ABdhPJyhggCQSJ8SrWYXVKwzOdii3WIc2tlpnrlyd9It3uXy1K0FXFNay8t8XIOcsXRAR5NdQbKhTA==
X-Received: by 2002:a7b:c349:: with SMTP id l9mr2262445wmj.148.1603459101252; 
 Fri, 23 Oct 2020 06:18:21 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id c18sm3059900wmk.36.2020.10.23.06.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 06:18:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/4] tests/acceptance: Allow running Orange Pi test using
 cached artifacts
Date: Fri, 23 Oct 2020 15:18:06 +0200
Message-Id: <20201023131808.3198005-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023131808.3198005-1-f4bug@amsat.org>
References: <20201023131808.3198005-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unfortunately the Armbian 19.11.3 image has been removed from the
dl.armbian.com file server. Developers having the artifact cached
can still run the test. Allow them to, until we find a proper
solution to share binaries with the whole community.

This avoids (when file manually added to cache):

  BootLinuxConsole.test_arm_orangepi_bionic_19_11: CANCEL: Missing asset https://dl.armbian.com/orangepipc/archive/Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z (1.06 s)

Reported-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 0118ed59156..032ac85978c 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -780,6 +780,8 @@ def test_arm_orangepi_sd(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
+                'Test artifacts fetched from unreliable dl.armbian.com')
     @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
     @skipUnless(P7ZIP_AVAILABLE, '7z not installed')
     def test_arm_orangepi_bionic(self):
-- 
2.26.2


