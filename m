Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF9AC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81112072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1/A1f6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81112072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57209 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izSLG-0001RZ-36
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1izSIu-00054H-E7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1izSIs-0005wS-HD
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:48 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:42988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1izSIs-0005uR-71
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:46 -0500
Received: by mail-pl1-x636.google.com with SMTP id e8so1400056plt.9
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 13:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i9gFd9OhGJDTI6P0fwPk9gfrY87Nod7OotY7LxwWUQo=;
 b=x1/A1f6BUb6yMPHmh3yZe7SIu/c+tdoS5tEQleH4o7FjyPMZK2Mu0YkElc1K/ZM+c2
 KugCSF944VgIfeaCtbGEyGrpzMUcHE63LZ0N/n8JJA96VHJWGbZXohAcG7CvlbXshH7D
 NRLz46ucS/qUykHiFg6tp7kbPqbUolsOhnkoq28wRA0q1N8F+QICnDqXWBWssPIZgtbt
 1QiFwDVHMkcCMh+PXda1fuVn/qnffz0uMLRPfpUTTUeEv7xuDop3tKEK7WoadkOHj5Ro
 wX3inws77mmZddDpg7guQhh+8w/k3ADvBRArki+57HdNzpNdYDcZYCEDO7khviC8WB/f
 9Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=i9gFd9OhGJDTI6P0fwPk9gfrY87Nod7OotY7LxwWUQo=;
 b=qAyTFOn7kt76MDfkPPYuqpovh4ULeyLlaCjUnOI16CWfk9H6pMMDDw5RpMGdd7y9uT
 rTu+ZhBDte9pxvCvt6fTDP1G0p2RRhsBL2+ISJohcBfikMTwqcm4g48PjNdGCJEba2e4
 L2GPDBmrcDRJu4geqykQLIphSMHJ/9cT5bbZReX+hsKa52CuQQOhuqCrf+yV7G3/8Hwl
 3ZpekTZHhIEnvX+bxS1o6qw70o3dEwxZKUFLif173tMBtm7Q8LLL8X4Lw4m0upcdNA91
 Na16HGRxhoDG6y3JUxNnQqNSEwQ1hhsrG9vVMRqLtmNmwK3d2wXRheHECizyAulJKv3G
 Ebtg==
X-Gm-Message-State: APjAAAUYF2QMOZ6uUQhodIZzQmyLFQN54IhOskoaJS2ONWddJJQ4L+Wk
 ttjLIYwf5Kph040ALes+QbBsckGCM/A=
X-Google-Smtp-Source: APXvYqyLl5pJkzKHDLiy6uzFqu6ZXhyc3l54dEQWpGXqzRFQ8zRCM14XIE0FSFj83w1TZ1YfI5SHSw==
X-Received: by 2002:a17:90a:9f83:: with SMTP id o3mr191303pjp.95.1580938423998; 
 Wed, 05 Feb 2020 13:33:43 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p4sm724576pgh.14.2020.02.05.13.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 13:33:43 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 00/14] tests/vm: Add support for aarch64 VMs
Date: Wed,  5 Feb 2020 16:29:06 -0500
Message-Id: <20200205212920.467-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
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

This is version 1 of the patch series to 
add support for 2 aarch64 VMs.  
 - Ubuntu 18.04 aarch64 VM
 - CentOS 8 aarch64 VM
 
Changes in version 1
- Added environment variable QEMU_LOCAL=1 which means
  use the appropriate QEMU binary from the current build.
- Improved support of aarch64 VMs to be backwards compatible
  by default with older versions of QEMU.
- Fixed a locale issue with ubuntu.aarch64 VM.
  The issue here was that we were not waiting for the cloud-init to finish,
  prior to rebooting the VM.
- Workaround of issue where the test hangs as QEMU is waiting for
  the consumption of character device data.  Workaround adds a 
  thread to the test framework to consume these characters and dump them
  to a file. The test then consumes these characters from the file instead of
  from the character device as it did previously.
  One advantage of this change is that there is now a log file which 
  contains the console output for debug.
- Change creation of aarch64 flash files to be in temp directory.
- Added changes to convert existing scripts to using self._config for
  SSH_KEY_PUB, GUEST_USER, GUEST_PASS, ROOT_PASS.
- Created example config file for x86, renamed existing 
  example file to aarch64.
- Make gen_cloud_init_iso() common to basevm.
- Updated wait_ssh() to only extend time when we are under TCG.
- Changed wait_ssh() to wait for root or wait for guest user, not both.
- Removed SSH_KEY global as it is no longer needed.
- Clarified use of ssh_key_file and ssh_pub_key_file,
  added tmp to the names to clarify, and added a comment to explain use here.
- Cleaned up handling of the boot_console option.
- Moved tweak to Makefile.include to a separate patch.
- Removed setting of tcg,thread=multi in aarch64 VMs.
- Moved the validation of ssh keys to a common location.
- Reworked the handling of the config file yaml to
  simply set the values into the config dictionary in one step.

More details on the patch in general:
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

Robert Foley (14):
  tests/vm: use $(PYTHON) consistently
  tests/vm: Debug mode shows ssh output.
  tests/vm: increased max timeout for vm boot.
  tests/vm: give wait_ssh() option to wait for root
  tests/vm: Added gen_cloud_init_iso() to basevm.py
  tests/vm: Add logging of console to file.
  tests/vm: Add configuration to basevm.py
  tests/vm: Added configuration file support
  tests/vm: add --boot-console switch
  tests/vm: Add ability to select QEMU from current build.
  tests/vm: allow wait_ssh() to specify command
  tests/vm: Added a new script for ubuntu.aarch64.
  tests/vm: Added a new script for centos.aarch64.
  tests/vm: change scripts to use self._config

 tests/vm/Makefile.include         |  16 +-
 tests/vm/aarch64vm.py             | 100 +++++++++
 tests/vm/basevm.py                | 324 +++++++++++++++++++++++++-----
 tests/vm/centos                   |  33 +--
 tests/vm/centos-8-aarch64.ks      |  51 +++++
 tests/vm/centos.aarch64           | 221 ++++++++++++++++++++
 tests/vm/conf_example_aarch64.yml |  51 +++++
 tests/vm/conf_example_x86.yml     |  50 +++++
 tests/vm/fedora                   |  17 +-
 tests/vm/freebsd                  |  16 +-
 tests/vm/netbsd                   |  19 +-
 tests/vm/openbsd                  |  17 +-
 tests/vm/socket_thread.py         |  73 +++++++
 tests/vm/ubuntu.aarch64           | 113 +++++++++++
 tests/vm/ubuntu.i386              |  37 +---
 15 files changed, 987 insertions(+), 151 deletions(-)
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml
 create mode 100644 tests/vm/socket_thread.py
 create mode 100755 tests/vm/ubuntu.aarch64

-- 
2.17.1


