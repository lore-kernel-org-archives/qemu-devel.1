Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DDCC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA452464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNkfg+pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA452464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SlX-0002s4-8H
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j4SNf-0001Ub-5S
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j4SNd-0007EV-QY
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:22 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:41085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j4SNd-0007DU-ID
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:21 -0500
Received: by mail-pf1-x42e.google.com with SMTP id j9so318269pfa.8
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 08:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+sXaLRbgfWs+KG5a/pFiZ/MnZmujcMivIdyDGLfFfmA=;
 b=vNkfg+pvX52MmYfnqe5QS/Pe0+4d/pHFLm/PcKADmHew/sGdYfzNk121bYD2s3PQww
 1yseRE89Wpvma4NW9ndBDsCxX4kasrYCt/AcGSqfyzWr+sxX/+7SogFT20/9wg3D3Gb9
 kmC4CK4NdaCvBU6dBk9hr10Z9YIiPMT4+dmg9SZXm+LXsaydFKKYRctg/bUKDDyWIN2e
 DTmZXvpcj4AuonIvcnv3aLlyjNtRUKNht1LQ0rjiw8HYshgkl++uYHt0A4eJqjrWGCxf
 p9njpiKDPHnpSlqSjBkHqLBEHaRhckwsmZnqGh1WtZPi+r6ArM4h+OxLv3rQjCHfz39d
 86VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+sXaLRbgfWs+KG5a/pFiZ/MnZmujcMivIdyDGLfFfmA=;
 b=Jbm3M6zu+T8aGT/UWWL70gGaVVmZeiGPq6OAJyFl3ATMCwAo40f87F3pzMSvOLBsme
 4e+5/8pwwhya+H6Fzew1upT0/1GiXgHPDe53nhcB7fC5md+yBKYhoeP8tnjWL8/+yqyq
 c8uaP2x8HM0YuVd7YGUhcAjCbrihTIuoIJWAJnheYknGXXU3DW7B+66qgfWCIOL4SXe4
 sXazf+y0jpHDDkmpFrFiKleY3TD4GTH8+ip14P7j8akOaXSJE3NLZUXQ55whHsqhxeFZ
 3J/HUiEXKLbveeewxHT9S2XmjADAUknG1laGxobuATrVISSMAfFhJ7CwY8uIbpu0o0io
 aVuQ==
X-Gm-Message-State: APjAAAVVRWx5KEGHQyWyTl4031lIZgtpYS5Wod25JZcSU9dSv35fGvQ1
 wSMDLYwNb7wmjn9pwlMijErV9cdBLsI=
X-Google-Smtp-Source: APXvYqxT887kXZzpuXgArF4tSnRn5cqnxrpJVd1tn6Ql9PtQnNP5vINKuB8uzv2OFwB+PCFPFSYx+A==
X-Received: by 2002:a65:4305:: with SMTP id j5mr29900100pgq.315.1582130359613; 
 Wed, 19 Feb 2020 08:39:19 -0800 (PST)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:3cc2:5eb7:e248:ad23])
 by smtp.gmail.com with ESMTPSA id a69sm112362pfa.129.2020.02.19.08.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:39:18 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/14] tests/vm: Add support for aarch64 VMs
Date: Wed, 19 Feb 2020 11:35:23 -0500
Message-Id: <20200219163537.22098-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
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

This is version 2 of the patch series to 
add support for aarch64 VMs.  
 - Ubuntu 18.04 aarch64 VM
 - CentOS 8 aarch64 VM

V1: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg01180.html

Changes in version 2
- Most changes relate to the patch: "Add workaround to consume console".
   - We changed this patch to make it cleaner.
   - We added a ConsoleSocket, which slots in for the current console socket
     with the difference being that we drain this socket in the background on a
     callback basis.  
   - We also made the logging of the console to file optional
 - Relocated the log file path and name. For example:
   ~/.cache/qemu-vm/ubuntu.aarch64.install.log 
- Made one fix for a hang issue we were seeing.
  - The issue was a timing problem around a reboot where the
     ubuntu.aarch64 script assumed the reboot guaranteed that 
     the next successful command would occur after the reboot.
   - The fix is to simply make it more deterministic by shutting down the
     VM and restarting it instead of issuing the reboot.
- Made a few changes to CentOS VM to update its dependencies properly.
- We made a few changes related to latin1 vs utf-8.
  We found in some cases the latin1 is needed for chars coming out of the i
  socket which do not have a utf-8 equivalent.

Robert Foley (14):
  tests/vm: use $(PYTHON) consistently
  tests/vm: Debug mode shows ssh output.
  tests/vm: increased max timeout for vm boot.
  tests/vm: give wait_ssh() option to wait for root
  tests/vm: Added gen_cloud_init_iso() to basevm.py
  tests/vm: Add workaround to consume console
  tests/vm: Add configuration to basevm.py
  tests/vm: Added configuration file support
  tests/vm: add --boot-console switch
  tests/vm: Add ability to select QEMU from current build.
  tests/vm: allow wait_ssh() to specify command
  tests/vm: Added a new script for ubuntu.aarch64.
  tests/vm: Added a new script for centos.aarch64.
  tests/vm: change scripts to use self._config

 python/qemu/console_socket.py     | 162 ++++++++++++++++
 python/qemu/machine.py            |  12 +-
 tests/vm/Makefile.include         |  20 +-
 tests/vm/aarch64vm.py             | 100 ++++++++++
 tests/vm/basevm.py                | 294 +++++++++++++++++++++++++-----
 tests/vm/centos                   |  33 +---
 tests/vm/centos-8-aarch64.ks      |  51 ++++++
 tests/vm/centos.aarch64           | 224 +++++++++++++++++++++++
 tests/vm/conf_example_aarch64.yml |  51 ++++++
 tests/vm/conf_example_x86.yml     |  50 +++++
 tests/vm/fedora                   |  17 +-
 tests/vm/freebsd                  |  16 +-
 tests/vm/netbsd                   |  19 +-
 tests/vm/openbsd                  |  17 +-
 tests/vm/ubuntu.aarch64           | 117 ++++++++++++
 tests/vm/ubuntu.i386              |  37 +---
 16 files changed, 1069 insertions(+), 151 deletions(-)
 create mode 100644 python/qemu/console_socket.py
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml
 create mode 100755 tests/vm/ubuntu.aarch64

-- 
2.17.1


