Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657C3C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F4520644
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2ZFtd/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F4520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40353 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqYi-0008QW-CC
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:27:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hTqQP-0002Ny-Ra
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hTqQO-0006So-Oj
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:18:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hTqQO-0006S7-I4
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:18:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id d18so6947177wrs.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=PQoPoJzk2ivYqURW0C+PAzwPBu3uVIBbVKjfgdnrsJM=;
	b=W2ZFtd/oviQG/N9pv0sfdId7LBBN7OvEX5bAdLq1Nc3Hzid2lPg/gdnjgjuO3GdbCO
	CO9U9kVpTOtT/D8jCi0ZeryadBjOrZkAFbPyh9+ur2aW3rHODVV+IIve0obA2+6ASh6m
	MT9ZnXHmWXDzuB42X9AZMnQ6sEqPdiJByWBWM7eGLP89EK5LStvu4Nhh8CmljMLG/QJy
	fjmi/bziE0/dyn2FKFBHX3JJI6MxdO2EH1ybDgB6SfQz5S+MrshxDvoo2hXnHFgydkGx
	HBtCAyBSNxkPdjLn5ySwEbAx6CVjT5lW38ynBd74xVYJ87yG1/92dnDqqAFmGwnZDTPD
	xdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=PQoPoJzk2ivYqURW0C+PAzwPBu3uVIBbVKjfgdnrsJM=;
	b=cbUSTztOMF4xhiYRPLQ4ytA4Wg8eWNe5c3tIV/CUvPvFricyedxps1rAUTwxUA1iBG
	hRAsRXfMeAljaFD6vb/6Uy4+FZJBqyChUrimPtC0eLeLYtVeTJV/SDGV0NgAX1lBJXtD
	mDstQuJx+9ZA9NbUrbEe0zcm6jTkjqfHT1/8S9XP25Qd1KHo8d2bWrDBYc61CNDm3F2J
	AWObr70QoFXzx3XF4AKStrW4SoBboFLPaAALQL4277tItvyCsFUH8w8GqxoVCvtKazqi
	vxUPmU4n16lfmy50iT1kPxcN0SHDzrTcVO7YlCN/kPWM/iO9GmH8oJ7Z35bTQXcyzNZf
	knuA==
X-Gm-Message-State: APjAAAWCrIMwxn89pGjdyZ6kr0ZocpYypVunonpjK+T9dtIRflG9Gbdf
	YYgJHvGVqFcBbOV5S34Ce2I=
X-Google-Smtp-Source: APXvYqxRjLx74WG5lcMl2qRZOKBJ+7dRmW7aicEEZcCjwa9Y3ibtnbyniGv7ewS47qDkFV0T39wxZQ==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr17937048wru.12.1558628314888; 
	Thu, 23 May 2019 09:18:34 -0700 (PDT)
Received: from x1.local (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	q16sm10273222wmj.17.2019.05.23.09.18.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 09:18:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>
Date: Thu, 23 May 2019 18:18:28 +0200
Message-Id: <20190523161832.22490-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 0/4] mips: Add more Avocado tests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

It was a rainy week-end here, so I invested it to automatize some
of my MIPS tests.

The BootLinuxSshTest is not Global warming friendly, it is not
meant to run on a CI system but rather on a workstation previous
to post a pull request.
It can surely be improved, but it is a good starting point.

v2: Decorate slow tests with skipIf(CONTINUOUS_INTEGRATION):

  VENV    /home/travis/build/philmd/qemu/tests/venv
  PIP     /home/travis/build/philmd/qemu/tests/requirements.txt
  MKDIR   /home/travis/build/philmd/qemu/tests/results
  AVOCADO tests/acceptance
JOB ID     : 02a2b1c585c12aebfbd8db2f330ed9730a547ae0
JOB LOG    : /home/travis/build/philmd/qemu/tests/results/job-2019-05-23T16.05-02a2b1c/job.log
 (01/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:  PASS (5.41 s)
 (02/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_malta:  PASS (3.33 s)
 (03/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_mips64el_malta:  PASS (3.47 s)
 (04/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_malta_cpio:  PASS (15.09 s)
 (05/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_aarch64_virt:  PASS (2.48 s)
 (06/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_virt:  PASS (7.25 s)
 (07/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_s390x_s390_ccw_virtio:  PASS (4.66 s)
 (08/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_alpha_clipper:  PASS (3.37 s)
 (09/22) acceptance/cpu_queries.py:QueryCPUModelExpansion.test:  PASS (0.16 s)
 (10/22) acceptance/empty_cpu_model.py:EmptyCPUModel.test:  PASS (0.02 s)
 (11/22) acceptance/linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_exit_error_msg_with_linux_v3_6:  PASS (3.89 s)
 (12/22) acceptance/linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16:  PASS (15.14 s)
 (13/22) acceptance/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta32eb_kernel3_2_0:  SKIP: Running on Travis-CI
 (14/22) acceptance/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta64el_kernel3_2_0:  SKIP: Running on Travis-CI
 (15/22) acceptance/migration.py:Migration.test_migration_with_tcp_localhost:  PASS (0.23 s)
 (16/22) acceptance/version.py:Version.test_qmp_human_info_version:  PASS (0.04 s)
 (17/22) acceptance/virtio_version.py:VirtioVersionCheck.test_conventional_devs:  PASS (1.20 s)
 (18/22) acceptance/virtio_version.py:VirtioVersionCheck.test_modern_only_devs:  PASS (0.41 s)
 (19/22) acceptance/vnc.py:Vnc.test_no_vnc:  PASS (0.03 s)
 (20/22) acceptance/vnc.py:Vnc.test_no_vnc_change_password:  PASS (0.04 s)
 (21/22) acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_password:  PASS (0.04 s)
 (22/22) acceptance/vnc.py:Vnc.test_vnc_change_password:  PASS (0.04 s)
RESULTS    : PASS 20 | ERROR 0 | FAIL 0 | SKIP 2 | WARN 0 | INTERRUPT 0 | CANCEL 0
JOB TIME   : 68.64 s

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  BootLinuxConsoleTest: Let extract_from_deb handle various compressions
  BootLinuxConsoleTest: Test nanoMIPS kernels on the I7200 CPU
  BootLinuxConsoleTest: Run kerneltests BusyBox on Malta
  BootLinuxSshTest: Test some userspace commands on Malta

 MAINTAINERS                              |   1 +
 tests/acceptance/boot_linux_console.py   | 113 ++++++++++-
 tests/acceptance/linux_ssh_mips_malta.py | 230 +++++++++++++++++++++++
 tests/requirements.txt                   |   1 +
 4 files changed, 343 insertions(+), 2 deletions(-)
 create mode 100644 tests/acceptance/linux_ssh_mips_malta.py

-- 
2.19.1


