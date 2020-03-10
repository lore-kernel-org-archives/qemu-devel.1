Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC1AC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BE420727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yms+s4LZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BE420727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjbl-0005ix-Gg
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jBjal-0004R6-IO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jBjak-0001RM-6z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:26:59 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jBjak-0001Og-16
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:26:58 -0400
Received: by mail-pg1-x544.google.com with SMTP id u12so6675917pgb.10
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nrzh0Vy8XOLZcUSvtUSHG8edtZbHgxfhuR5ZP2r40nk=;
 b=yms+s4LZUz72EwOzhEZHkClxN89zv1UakkrTA9lnSneywbBFJDXPljDQNrNIIMUx9q
 pJB0TTNy0S5Hx2iAoiCAiAYl2+LAtQ+4wULWmclVCF/83xEciLrFhvVusTL37R0UY3tt
 lJwpFeCWrk/u2QAouCDXpNVjsiPCB5Uut1vM9ZNih2ZU2rnOQgttkqgNb5LviFJM5c1v
 LO8OTxPtOhagrTW8g0c0L+/LP4FV05mfhzhfMf2y3sIxhHh5KeqVDvmpojcAoJ1hgv09
 eB6MS+kNReCAgSKlZ071R/CIsARhmOQ3M0PCD7Aip5wJlHJdgjnc30vj7HKe5wMUuEiB
 S4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Nrzh0Vy8XOLZcUSvtUSHG8edtZbHgxfhuR5ZP2r40nk=;
 b=kwTkbYrn0lxp+0WDNdvwNfvYhe9cZJ1L6Pj9W5fAmPfyRv/muz6scFpy35zVmaqAPG
 YqWh0/KPDdX2eR+VJWZC5Ypip8JPlDe6QoJfxCKHNlbIE2OnndhoM5/R/2SZUolbpL0l
 Mjjp55cSXeUwnCc34yZsaULcAFWP3pHZWSw08Yu10/Ft1MxSIhKk+9czSk1Sy6T2q2le
 B+bhNT05BjrZowUuQOkpHyR33jm2d7Z8JHPixArjHMlWmT9EKzSPISkMjBtor7MqjN0m
 xoB6qbWMrwwFVDCWBVmgXb6DL6TJ+M4waiXLDxKy7NJhJvwYOomcPQgmywLGwOow+II0
 uxMw==
X-Gm-Message-State: ANhLgQ2tfj0FRY+46p1yfTx4RNHyQnQKwI6rprTR+cTJ168Isr+TLZ1b
 KZx+qwxhwMBwU4zPh5+ZYTCBBVtLC5k=
X-Google-Smtp-Source: ADFU+vu9pXMSPhe+78aNaGEZcFHlnUMyM98rBVFFIjoKsqUR3k0Y46KDCJkjTbY1vZ5dvUKWKDL+6Q==
X-Received: by 2002:aa7:91ce:: with SMTP id z14mr15283833pfa.62.1583864815098; 
 Tue, 10 Mar 2020 11:26:55 -0700 (PDT)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p1sm8730692pfq.114.2020.03.10.11.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 11:26:54 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/10] tests/vm: Add support for aarch64 VMs
Date: Tue, 10 Mar 2020 14:25:26 -0400
Message-Id: <20200310182536.11137-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

This is version 3 of the patch series to 
add support for aarch64 VMs in the vm-build infrastructure.
 - Ubuntu 18.04 aarch64 VM
 - CentOS 8 aarch64 VM

V2: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05310.html

Changes in V3.
- Most changes were around checking for dependencies
  needed for the aarch64 VMs (qemu-efi-aarch64) and 
  for the python3-yaml package.
  - Added checks to configure for dependencies of aarch64 VMs 
    as well as the python3-yaml dependency.
  - Also added checks in tests/vm/Makefile.include to check for 
    dependencies and output the appropriate text for vm-help.
- Moved the workaround for consuming the console to the end of the patch.
- Added patch to validate the target of vm-build operations.

Robert Foley (10):
  tests/vm: Add validation of target to Makefile.include
  tests/vm: Add configuration to basevm.py
  tests/vm: Added configuration file support
  tests/vm: add --boot-console switch
  tests/vm: Add ability to select QEMU from current build.
  tests/vm: allow wait_ssh() to specify command
  tests/vm: Added a new script for ubuntu.aarch64.
  tests/vm: Added a new script for centos.aarch64.
  tests/vm: change scripts to use self._config
  tests/vm: Add workaround to consume console

 configure                         |  25 +++
 python/qemu/console_socket.py     | 162 +++++++++++++++++++
 python/qemu/machine.py            |  12 +-
 tests/vm/Makefile.include         |  43 ++++-
 tests/vm/aarch64vm.py             | 100 ++++++++++++
 tests/vm/basevm.py                | 252 ++++++++++++++++++++++++------
 tests/vm/centos-8-aarch64.ks      |  51 ++++++
 tests/vm/centos.aarch64           | 226 +++++++++++++++++++++++++++
 tests/vm/conf_example_aarch64.yml |  51 ++++++
 tests/vm/conf_example_x86.yml     |  50 ++++++
 tests/vm/fedora                   |  17 +-
 tests/vm/freebsd                  |  16 +-
 tests/vm/netbsd                   |  19 +--
 tests/vm/openbsd                  |  17 +-
 tests/vm/ubuntu.aarch64           | 117 ++++++++++++++
 15 files changed, 1075 insertions(+), 83 deletions(-)
 create mode 100644 python/qemu/console_socket.py
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml
 create mode 100755 tests/vm/ubuntu.aarch64

-- 
2.17.1


