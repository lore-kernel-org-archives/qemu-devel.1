Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE2C32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4818C20709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4BeJ1J7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4818C20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2Gg-00059j-BD
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iv2Fr-0003cS-MH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iv2Fq-0002uu-30
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:23 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:51818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iv2Fp-0002tj-SA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:22 -0500
Received: by mail-pj1-x102b.google.com with SMTP id d15so74554pjw.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=P3FjDLSvY6klGr+XZZEP0o2JxToDunv0eh5czGMlPCg=;
 b=c4BeJ1J7+/Fys2NcB5SK42oqUNo9hxOM9wr6TXer2HWdjyyzRLbD+GYGc4kKHCReNA
 doUhKhaFfZS8qBnRpxiRhrGZ3uk4mZEcI9rNgDQNotSWQwKgAKRyeYM0/fR0WsqaTJPY
 8/YuLEcyOLmhcN3RJHQkJiOfRo3qEypJiUONZbhvjwmpZknNyWexUkQsC9UzQoM8/MB8
 GCX5cNLn0suPEoL7Hj9OeXpA71xV9+o5++anemDWZ1RthP9nSa35FHsn482M7/7FG9PN
 zXw1t1BaIZIviNbbj5jXlou37yHNB5aQYQiDdNuafV83+T0ZxkIJsSwbp4a7TMT5Ba5J
 z5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=P3FjDLSvY6klGr+XZZEP0o2JxToDunv0eh5czGMlPCg=;
 b=SH2g3g/yr5Jr7bw2ML9FnTSpQrIouJqnFSnkfSQvxLql4tvgMv5x4qg/Kk2fro6AuH
 2TqVkD9mTIsrC20QwBunTZFXtOYHSi5C8Uko9kujkpmQDAUOSepqDz1d1bAIAefWwA8P
 m0LDBj3v2LR4JIitLG5W/R4RxHZ2ZNbaeqnlM3BIoxsIWSNNTdIPZzQaseT2nBNn2nW2
 LJRBxao6g/5KkKw8Cy6YVOd8eNKmrSmV+L7c6s112e9P85X8FhT5wBydD5egZKZFX4H0
 gPilK/jpJiPMcgk8aBqmH6sFxzFh6ykMPhxw1WEljxnEMht4z27pQhMV2cEhQ2ZEN5kS
 TjHw==
X-Gm-Message-State: APjAAAV9W42vC7lCzZZP3VJFXjxqJb+zQQ68hObLISiHvpAsFXt2x6pa
 iesQ6F0HhriF7+qM8Vi+xu8qcBuOFtk=
X-Google-Smtp-Source: APXvYqzU6GVKHffP7hlD7pCEMC5ZNWa+VWKGuGvFA6eMcl8OxRLc7ABuK9lToZkC384aiYWDr0mKAQ==
X-Received: by 2002:a17:90a:c78f:: with SMTP id
 gn15mr189519pjb.88.1579884979757; 
 Fri, 24 Jan 2020 08:56:19 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id l10sm6969953pjy.5.2020.01.24.08.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:56:19 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] tests/vm: Add support for aarch64 VMs
Date: Fri, 24 Jan 2020 11:53:27 -0500
Message-Id: <20200124165335.422-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102b
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds support for 2 aarch64 VMs.  
 - Ubuntu 18.04 aarch64 VM
 - CentOS 8 aarch64 VM

In order to add support for the two new aarch64 VMs, we
generalized and parameterized basevm.py.  
We added a new concept of a configuration, which is really just a 
set of parameters which define how to configure the VM.  
Some examples of parameters are "machine", "memory" and "cpu".
We preserved current default parameters.
Current configuration of pre-existing VMs is supported by default
without need to override default parameters.
 
For example, previously only the 'pc' machine was supported in basevm.py. 
The new aarch64 VMs will override machine to use virt. 
There are a few other examples where we needed to add parameters 
in order to add support for these aarch64 VMs.
In some other cases we added parameters that we thought would be useful
in general, for example username/password, ssh keys, 

In the case of the aarch64 VMs, they override certain parameters
by default.  However, it is also of value to be able to 
dynamically specify other values for these parameters.
Take the case where you create a new VM using vm-build,
but then want to test it using various hardware configurations
such as for example different NUMA topologies. 
Or maybe you want to use a different amount of memory or a different cpu type.

In order to support these use cases we added support
for a configuration .yml file, which allows the user to
specify certain values dynamically such as:
 - machine
 - cpu
 - memory size
 - other qemu args, which allow configuring alternate
   hardware topologies such as NUMA nodes.
 - username, password
 - ssh keys
 For an example of a .yml file, see the included config_example.yml
 
The main use case for using this config.yml file is for where we
are testing/debugging with qemu (vm-build), and need to configure
the VM differently.  However, there is another use case we have
developed, which is a project called lisa-qemu 
(https://github.com/rf972/lisa-qemu).  
This project is an integration between the LISA tool and QEMU.  
This project uses the VMs created by
QEMU's vm-build scripts for use in testing with LISA.  
This use case is similar to the vm-build case in that,
the VM gets created once, and we want to launch the VM with different
configurations (memory, cpu, etc.).
 
As part of developing the scripts for these VMs, we implemented
a few enhancements to help with testing.
For example, we added support for allowing debug mode to
show the ssh output.
We also added support for a new --boot-console option which
will show the boot console as the VM boots up to aid in 
debugging problems during VM boot.

Robert Foley (8):
  tests/vm: Debug mode shows ssh output.
  tests/vm: increased max timeout for vm boot.
  tests/vm: change wait_ssh to optionally wait for root.
  tests/vm: Add configuration to basevm.py
  tests/vm: Added configuration file support
  tests/vm: add --boot-console switch
  tests/vm: Added a new script for ubuntu.aarch64.
  tests/vm: Added a new script for centos.aarch64.

 tests/vm/Makefile.include    |   8 +-
 tests/vm/aarch64vm.py        |  41 +++++++
 tests/vm/basevm.py           | 192 +++++++++++++++++++++++++-----
 tests/vm/centos-8-aarch64.ks |  52 +++++++++
 tests/vm/centos.aarch64      | 218 +++++++++++++++++++++++++++++++++++
 tests/vm/config_example.yml  |  52 +++++++++
 tests/vm/ubuntu.aarch64      | 144 +++++++++++++++++++++++
 7 files changed, 675 insertions(+), 32 deletions(-)
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64
 create mode 100644 tests/vm/config_example.yml
 create mode 100755 tests/vm/ubuntu.aarch64

-- 
2.17.1


