Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FC6C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BDC2075A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 20:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ih3a/Vbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BDC2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jelrR-0006sU-47
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 16:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jelqG-0005CL-OU
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:43:00 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jelqF-0000V8-Cz
 for qemu-devel@nongnu.org; Fri, 29 May 2020 16:43:00 -0400
Received: by mail-pg1-x542.google.com with SMTP id d10so477720pgn.4
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OpkqySJ2UWknivaVvWru7lRhHenDyIjLkmIyDYeODKY=;
 b=Ih3a/VbqvNCorNFDtAaBsYYrCADdVUE0sfaXIG2/3LUFIDlbEH9IwEvtpAMI0v1GqH
 reHVplAGTfrF583XNxmhAQxuzaaD7mdWl/gRJoqWiwdDO42j3KJ3qOsFS5kLDafntkHc
 XChUf+ebR+fLrQfGQ4DtFdRg0PHI9Fj7TjMviFQrlB/wS3k9RodwRlVWFPNng2KLWwba
 lFg2xA5dS5SeYbAlP8648mMrFx1UKI3taspLX/SiQbZ1xbF3isoA29yztkF8q3VCfNzB
 Xv6MEXEzvvpjClqa9lIWjHesSn9AJrCde+BS4jB9ekHLQGENYAG+yijhUV6uswXsuFtH
 XBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OpkqySJ2UWknivaVvWru7lRhHenDyIjLkmIyDYeODKY=;
 b=sA0YdPGneGXo0K5jQOqrmd0fM6WnvMWgVFut7jOqvFCrVH2gmmzjZvjO3IPmmVu/Dl
 skkxXpgjFqS0+NCBB+xMdqt26kXvtJJvQ+VZ+ZF1gjSE8GLpm/tZ1nI9JmAi3O9/zkXt
 /gcgUB319oaartaoBWAZwXx6YpdjMMW8sP+pa93cVK6fE1l8XymVohqlASuf0uFdK303
 CCz6vzSqKbT6WEvi3mHq8+Mc9WGy6AnWa6GruSKlY7zBwOQCJzEjedV1mSXydTUySVcp
 8TIcRX8HO4oj4+y9UCgP+vc4LFjmMaAQD70IeYY0eeLMutMGYp8+APIaPm8yZWLxUdFV
 4bfA==
X-Gm-Message-State: AOAM530ByP7zcpgvnOGqansYDMpO4qpCL6S7NekJhYxVQqjrxrtPuX7p
 TX8jLfo3ClJh+VE7nbAHdRgeZQEAYKj1UA==
X-Google-Smtp-Source: ABdhPJzuj05qQL0Dv6fk7IfFb01yQUVU5y1pPjRXmTfnFz2OQDAv8T/LFPePa5SnhJuRS0qB0WU7yg==
X-Received: by 2002:a63:cd0d:: with SMTP id i13mr9987873pgg.292.1590784977367; 
 Fri, 29 May 2020 13:42:57 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id t12sm282839pjf.3.2020.05.29.13.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 13:42:56 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 00/12] tests/vm: Add support for aarch64 VMs
Date: Fri, 29 May 2020 16:34:46 -0400
Message-Id: <20200529203458.1038-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x542.google.com
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

This is version 8 of the patch series to
add support for aarch64 VMs in the vm-build infrastructure.
 - Ubuntu 18.04 aarch64 VM
 - CentOS 8 aarch64 VM

v7: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05286.html

Changes in v8:
- Added Ubuntu common module in tests/vm.
- Changed ubuntu.i386 and ubuntu.aarch64 to use new common module.
- Split out ConsoleSocket addition (python/qemu) to separate patch
  from changes to use it in tests/vm.
- Adjustments in configure when checking for aarch64 efi images.
- Remove use of QEMU_LOCAL in basevm.py.  We will use the
  presence of the --build-path argument instead.

Robert Foley (12):
  tests/vm: pass args through to BaseVM's __init__
  tests/vm: Add configuration to basevm.py
  tests/vm: Added configuration file support
  tests/vm: Pass --debug through for vm-boot-ssh.
  tests/vm: Add ability to select QEMU from current build.
  tests/vm: allow wait_ssh() to specify command
  tests/vm: Add common Ubuntu python module
  tests/vm: Added a new script for ubuntu.aarch64.
  tests/vm: Added a new script for centos.aarch64.
  tests/vm: change scripts to use self._config
  python/qemu: Add ConsoleSocket for optional use in QEMUMachine
  tests/vm: Add workaround to consume console

 configure                         |  29 +++
 python/qemu/console_socket.py     | 118 +++++++++++++
 python/qemu/machine.py            |  23 ++-
 tests/vm/Makefile.include         |  27 +++
 tests/vm/aarch64vm.py             | 106 +++++++++++
 tests/vm/basevm.py                | 284 +++++++++++++++++++++++-------
 tests/vm/centos-8-aarch64.ks      |  51 ++++++
 tests/vm/centos.aarch64           | 227 ++++++++++++++++++++++++
 tests/vm/conf_example_aarch64.yml |  51 ++++++
 tests/vm/conf_example_x86.yml     |  50 ++++++
 tests/vm/fedora                   |  17 +-
 tests/vm/freebsd                  |  16 +-
 tests/vm/netbsd                   |  19 +-
 tests/vm/openbsd                  |  17 +-
 tests/vm/ubuntu.aarch64           |  68 +++++++
 tests/vm/ubuntu.i386              |  46 ++---
 tests/vm/ubuntuvm.py              |  58 ++++++
 17 files changed, 1077 insertions(+), 130 deletions(-)
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


