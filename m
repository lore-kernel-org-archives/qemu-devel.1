Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A76C28EB9
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0D5208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0D5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ1U7-0000iI-Nl
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 19:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40066)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZ1RY-0007N1-MJ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZ1PF-00011d-Ac
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:02:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZ1PF-00010g-3O
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:02:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B53586663;
 Thu,  6 Jun 2019 23:02:42 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-32.brq.redhat.com [10.40.204.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4037895BC;
 Thu,  6 Jun 2019 23:02:34 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
	qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 01:02:30 +0200
Message-Id: <20190606230232.9888-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 06 Jun 2019 23:02:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/2] mips: Add more Avocado tests
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
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

v3: Addressed issues reported by Cleber (only posting 3/4 and 4/4)
v2: Decorate slow tests with skipIf(CONTINUOUS_INTEGRATION):

  VENV    /home/travis/build/philmd/qemu/tests/venv
  PIP     /home/travis/build/philmd/qemu/tests/requirements.txt
  MKDIR   /home/travis/build/philmd/qemu/tests/results
  AVOCADO tests/acceptance
JOB ID     : 02a2b1c585c12aebfbd8db2f330ed9730a547ae0
JOB LOG    : /home/travis/build/philmd/qemu/tests/results/job-2019-05-23T=
16.05-02a2b1c/job.log
 (01/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc=
:  PASS (5.41 s)
 (02/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_malt=
a:  PASS (3.33 s)
 (03/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_mips64el_=
malta:  PASS (3.47 s)
 (04/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_mips_malt=
a_cpio:  PASS (15.09 s)
 (05/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_aarch64_v=
irt:  PASS (2.48 s)
 (06/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_virt:=
  PASS (7.25 s)
 (07/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_s390x_s39=
0_ccw_virtio:  PASS (4.66 s)
 (08/22) acceptance/boot_linux_console.py:BootLinuxConsole.test_alpha_cli=
pper:  PASS (3.37 s)
 (09/22) acceptance/cpu_queries.py:QueryCPUModelExpansion.test:  PASS (0.=
16 s)
 (10/22) acceptance/empty_cpu_model.py:EmptyCPUModel.test:  PASS (0.02 s)
 (11/22) acceptance/linux_initrd.py:LinuxInitrd.test_with_2gib_file_shoul=
d_exit_error_msg_with_linux_v3_6:  PASS (3.89 s)
 (12/22) acceptance/linux_initrd.py:LinuxInitrd.test_with_2gib_file_shoul=
d_work_with_linux_v4_16:  PASS (15.14 s)
 (13/22) acceptance/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta32eb_=
kernel3_2_0:  SKIP: Running on Travis-CI
 (14/22) acceptance/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta64el_=
kernel3_2_0:  SKIP: Running on Travis-CI
 (15/22) acceptance/migration.py:Migration.test_migration_with_tcp_localh=
ost:  PASS (0.23 s)
 (16/22) acceptance/version.py:Version.test_qmp_human_info_version:  PASS=
 (0.04 s)
 (17/22) acceptance/virtio_version.py:VirtioVersionCheck.test_conventiona=
l_devs:  PASS (1.20 s)
 (18/22) acceptance/virtio_version.py:VirtioVersionCheck.test_modern_only=
_devs:  PASS (0.41 s)
 (19/22) acceptance/vnc.py:Vnc.test_no_vnc:  PASS (0.03 s)
 (20/22) acceptance/vnc.py:Vnc.test_no_vnc_change_password:  PASS (0.04 s=
)
 (21/22) acceptance/vnc.py:Vnc.test_vnc_change_password_requires_a_passwo=
rd:  PASS (0.04 s)
 (22/22) acceptance/vnc.py:Vnc.test_vnc_change_password:  PASS (0.04 s)
RESULTS    : PASS 20 | ERROR 0 | FAIL 0 | SKIP 2 | WARN 0 | INTERRUPT 0 |=
 CANCEL 0
JOB TIME   : 68.64 s

Job output here:
https://travis-ci.org/philmd/qemu/jobs/536369687
"Ran for 16 min 26 sec"

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (2):
  BootLinuxConsoleTest: Test nanoMIPS kernels on the I7200 CPU
  BootLinuxConsoleTest: Run kerneltests BusyBox on Malta

 tests/acceptance/boot_linux_console.py | 102 +++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

--=20
2.20.1


