Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DDCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D727C2073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szQjvNPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D727C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfrnv-00039H-S8
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 17:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfrmO-0001bu-2k
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:15:32 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:39295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfrmM-0006SP-8W
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:15:31 -0400
Received: by mail-pj1-x102e.google.com with SMTP id h95so389922pje.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Gw5m1x5Xbx58fV+wiK/fT00tZsNBDwX2ki+9aHXy5lw=;
 b=szQjvNPROIFpzZ+hAg6ifcsU1NrSdRftp9A9GejNYGsE1RRIwZeF0JAWjqmtoCTrzA
 GWgSL+g/MK7gWorSIUXEKEAmSCS0YhMbKZuDZzQrh6HO459brh5C77SvhSi8t0+uVPUR
 SWqtats+tFzDn6cFLr3fXA57N1pJNit3xWZdfXyKuWDQPohU15Q6y588B4HT1t9Vabtp
 8aDWwW4hFv78d7zC5r1ytKNf0DrJCiYnwZUqh0i0FMQNWZ+VtZq6riLMviyniB7KQ4T6
 RJjgkJXS7Yvx/vTpOuQeGtyZrwHOACK+xHfUYj5dZsGnFEk6Fx01BIF+E3m7EnU1sq01
 k5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Gw5m1x5Xbx58fV+wiK/fT00tZsNBDwX2ki+9aHXy5lw=;
 b=RdPQ69Dbe5zFFmdU8zxNErqw4nHAllWoJ7PCJYET81gzImDilib/I4pgz2Y6HVuifK
 Ca2kYO6X6GFqvY+VUYkiRcuwgbYDvSVPONHpsu7MYFnmVyPtuxiCsHDBxDx+pYgaolz+
 C0TO4CVElW1TZ3OjWQ7LI+gszuO5HObGanE7my1TeWv0nd2b1skqajxw48rH68RWxy2p
 ozZ9JmxofWqK+TGquJ7n4hdjjCTUomR/2L048+Kx8ryP8DZXjeFtaGQAMi8+VJUKBFeE
 hYwIlSRQcjBhZPQw9BVDCLylqkh7vgXxOj0AgccImZJnUKh57mkFRB6gMmw7naO3ZeGt
 841Q==
X-Gm-Message-State: AOAM531qbrDnfljWDmlfoiLFvsT+dXV3h9Gmv4irUGfp8IhpgFP6k4Sw
 4cj6NxiATUh6nJt3y9bv27f8n4g2WwwYBw==
X-Google-Smtp-Source: ABdhPJxm9Ek8fVPJepXKKnvmxkPpF/ngaU0xNXNegpMvuX45YNpQQR+v1iVZbNbkRqOYpFEgOxcWRA==
X-Received: by 2002:a17:902:7885:: with SMTP id
 q5mr22215535pll.320.1591046128130; 
 Mon, 01 Jun 2020 14:15:28 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:85d8:9a30:f0f7:b100])
 by smtp.gmail.com with ESMTPSA id j24sm330131pga.51.2020.06.01.14.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 14:15:27 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 0/9] tests/vm: Add support for aarch64 VMs
Date: Mon,  1 Jun 2020 17:14:12 -0400
Message-Id: <20200601211421.1277-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x102e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is version 9 of the patch series to
add support for aarch64 VMs in the vm-build infrastructure.
 - Ubuntu 18.04 aarch64 VM
 - CentOS 8 aarch64 VM

v8: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08458.html

Changes in v9:
- Fixed one bug/typo in configure for efi-aarch64.
- Fixed indentation of efi-aarch64 code in configure.
- Updated file header for ubuntuvm.py
- Few minor changes in ConsoleSocket
- Updated some comments in basevm.py around the call to 
  QEMUMachine regarding drain_console=True.

Robert Foley (9):
  tests/vm: pass args through to BaseVM's __init__
  tests/vm: Add configuration to basevm.py
  tests/vm: Added configuration file support
  tests/vm: Add common Ubuntu python module
  tests/vm: Added a new script for ubuntu.aarch64.
  tests/vm: Added a new script for centos.aarch64.
  tests/vm: change scripts to use self._config
  python/qemu: Add ConsoleSocket for optional use in QEMUMachine
  tests/vm: Add workaround to consume console

 configure                         |  29 ++++
 python/qemu/console_socket.py     | 110 +++++++++++++
 python/qemu/machine.py            |  23 ++-
 tests/vm/Makefile.include         |  22 +++
 tests/vm/aarch64vm.py             | 106 +++++++++++++
 tests/vm/basevm.py                | 256 ++++++++++++++++++++++++------
 tests/vm/centos-8-aarch64.ks      |  51 ++++++
 tests/vm/centos.aarch64           | 227 ++++++++++++++++++++++++++
 tests/vm/conf_example_aarch64.yml |  51 ++++++
 tests/vm/conf_example_x86.yml     |  50 ++++++
 tests/vm/fedora                   |  17 +-
 tests/vm/freebsd                  |  16 +-
 tests/vm/netbsd                   |  19 +--
 tests/vm/openbsd                  |  17 +-
 tests/vm/ubuntu.aarch64           |  68 ++++++++
 tests/vm/ubuntu.i386              |  46 ++----
 tests/vm/ubuntuvm.py              |  60 +++++++
 17 files changed, 1045 insertions(+), 123 deletions(-)
 create mode 100644 python/qemu/console_socket.py
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml
 create mode 100755 tests/vm/ubuntu.aarch64
 create mode 100644 tests/vm/ubuntuvm.py

-- 
2.17.1


