Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FAEC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 22:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE80320674
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 22:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE80320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUeSp-0000gB-0c
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 17:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iUeRp-0000Ck-Oq
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iUeRn-00027s-NT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:15:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iUeRm-000274-3i
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:15:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xACMDAv7012681; Tue, 12 Nov 2019 17:15:34 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w81ykeywh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2019 17:15:34 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xACMEeU1024902;
 Tue, 12 Nov 2019 22:15:32 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma04wdc.us.ibm.com with ESMTP id 2w5n362nch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2019 22:15:32 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xACMFV1o28049916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Nov 2019 22:15:31 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7EBC28095;
 Tue, 12 Nov 2019 22:15:31 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 818A728086;
 Tue, 12 Nov 2019 22:15:31 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 12 Nov 2019 22:15:31 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <157359692712.3335.8086869808550970073@sif>
Subject: [ANNOUNCE] QEMU 4.2.0-rc1 is now available
Date: Tue, 12 Nov 2019 16:15:27 -0600
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-12_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120190
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
second release candidate for the QEMU 4.2 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-4.2.0-rc1.tar.xz
  http://download.qemu-project.org/qemu-4.2.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 4.2 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/4.2

Please add entries to the ChangeLog for the 4.2 release below:

  http://wiki.qemu.org/ChangeLog/4.2

Thank you to everyone involved!

Changes since rc0:

aa464db69b: Update version for v4.2.0-rc1 release (Peter Maydell)
0f1f2d4596: linux-user: remove host stime() syscall (Laurent Vivier)
c0cb880153: linux-user: fix missing break (Laurent Vivier)
c49a41b0b9: target/microblaze: Plug temp leak around eval_cond_jmp() (Edgar=
 E. Iglesias)
f91c60f0ca: target/microblaze: Plug temp leaks with delay slot setup (Edgar=
 E. Iglesias)
a633801526: target/microblaze: Plug temp leaks for loads/stores (Edgar E. I=
glesias)
3fb356cc86: tcg plugins: expose an API version concept (Alex Benn=C3=A9e)
05273a43af: .travis.yml: don't run make check with multiple jobs (Alex Benn=
=C3=A9e)
5b4b4865f4: tests/vm: support sites with sha512 checksums (Alex Benn=C3=A9e)
860eacec58: tests: only run ipmi-bt-test if CONFIG_LINUX (Alex Benn=C3=A9e)
2548b4a7d3: tests/vm: update netbsd to version 8.1 (Gerd Hoffmann)
00963aca8b: tests/vm: use console_consume for netbsd (Gerd Hoffmann)
6c4f0416be: tests/vm: add console_consume helper (Gerd Hoffmann)
af093bc937: tests/vm: netbsd autoinstall, using serial console (Gerd Hoffma=
nn)
5c62979ed5: ivshmem-server: Terminate also on SIGINT (Jan Kiszka)
0602a6166d: ivshmem-server: Clean up shmem on shutdown (Jan Kiszka)
88ed5db16c: numa: Add missing \n to error message (Greg Kurz)
d55e937d3e: qom: Fix error message in object_class_property_add() (Greg Kur=
z)
32eb2da326: Makefile: install bios-microvm like other binary blobs (Bruce R=
ogers)
cb974c95df: tcg/LICENSE: Remove out of date claim about TCG subdirectory li=
censing (Peter Maydell)
2552e30cba: tcg/ppc/tcg-target.opc.h: Add copyright/license (Peter Maydell)
2029bf7e52: tcg/i386/tcg-target.opc.h: Add copyright/license (Peter Maydell)
97105f2921: tcg/aarch64/tcg-target.opc.h: Add copyright/license (Peter Mayd=
ell)
45c078f163: hw/arm/boot: Set NSACR.{CP11, CP10} in dummy SMC setup routine =
(Clement Deschamps)
894d354fd8: Remove unassigned_access CPU hook (Peter Maydell)
af2a580f7e: ptimer: Remove old ptimer_init_with_bh() API (Peter Maydell)
623ef637a2: configure: Check bzip2 is available (Philippe Mathieu-Daud=C3=
=A9)
05dfa22b5b: configure: Only decompress EDK2 blobs for X86/ARM targets (Phil=
ippe Mathieu-Daud=C3=A9)
84b2c7e59a: tests/migration: Print some debug on bad status (Dr. David Alan=
 Gilbert)
611aa4d00d: MAINTAINERS: slirp: Remove myself as maintainer (Jan Kiszka)
741309136e: cpu-plug-test: fix leaks (Marc-Andr=C3=A9 Lureau)
36524a1a3d: qtest: fix qtest_qmp_device_add leak (Marc-Andr=C3=A9 Lureau)
c744cf7879: dp8393x: fix dp8393x_receive() (Laurent Vivier)
af9f0be36c: dp8393x: put the DMA buffer in the state structure (Laurent Viv=
ier)
1dfe2b91dc: usb-host: add option to allow all resets. (Gerd Hoffmann)


