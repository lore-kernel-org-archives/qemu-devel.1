Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A222FC76194
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 18:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED262084D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 18:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED262084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpztz-0005oN-I0
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 14:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46059)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpzth-0004mk-BH
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 14:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hpztg-0006hM-11
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 14:52:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21110
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hpztc-0006et-U7; Tue, 23 Jul 2019 14:52:21 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NIqJLF133226; Tue, 23 Jul 2019 14:52:20 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tx6114ns4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 14:52:19 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6NIo4mJ022553;
 Tue, 23 Jul 2019 18:52:15 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma03dal.us.ibm.com with ESMTP id 2tx61n0m66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 18:52:15 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NIqERa44564912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 18:52:14 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82298124055;
 Tue, 23 Jul 2019 18:52:14 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 653B4124052;
 Tue, 23 Jul 2019 18:52:14 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 18:52:14 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
References: <20190723170104.4327-1-mdroth@linux.vnet.ibm.com>
Message-ID: <156390781777.16169.2703233729883705323@sif>
User-Agent: alot/0.7
Date: Tue, 23 Jul 2019 13:50:17 -0500
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230190
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 00/36] Patch Round-up for
 stable 3.1.1, freeze on 2019-07-29
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Michael Roth (2019-07-23 12:00:28)
> Hi everyone,                                                             =
                                 =

> =

> The following new patches are queued for QEMU stable v3.1.1:
> =

>   https://github.com/mdroth/qemu/commits/stable-3.1-staging
> =

> The release is planned for 2019-08-01:
> =

>   https://wiki.qemu.org/Planning/3.1
> =

> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
> =

> Note that this update falls outside the normal stable release support
> window (~1 development cycle), but is being released now since it was
> delayed from its intended release date.
> =

> Thanks!
> =


Forgot to include the usual patch list:

----------------------------------------------------------------
BALATON Zoltan (1):
      i2c: Move typedef of bitbang_i2c_interface to i2c.h

Christian Borntraeger (2):
      iotests: make 235 work on s390 (and others)
      s390x/cpumodel: ignore csske for expansion

Christophe Fergeau (1):
      json: Fix % handling when not interpolating

Corey Minyard (1):
      pc:piix4: Update smbus I/O space after a migration

Cornelia Huck (1):
      vfio-ap: flag as compatible with balloon

Dan Streetman (1):
      do not call vhost_net_cleanup() on running net from char user event

Daniel Henrique Barboza (1):
      qga: update docs with systemd suspend support info

Daniel P. Berrang=C3=A9 (1):
      qemu-img: fix error reporting for -object

Eric Blake (1):
      cutils: Fix size_to_str() on 32-bit platforms

Gerd Hoffmann (1):
      usb-mtp: use O_NOFOLLOW and O_CLOEXEC.

Janosch Frank (1):
      s390x: Return specification exception for unimplemented diag 308 subc=
odes

Kevin Wolf (3):
      block: Fix invalidate_cache error path for parent activation
      qcow2: Avoid COW during metadata preallocation
      block: Fix AioContext switch for bs->drv =3D=3D NULL

Li Hangjing (1):
      vhost: fix vhost_log size overflow during migration

Liam Merwick (1):
      tpm_tis: fix loop that cancels any seizure by a lower locality

Marcel Apfelbaum (1):
      hw/rdma: another clang compilation fix

Mark Cave-Ayland (2):
      mac_oldworld: use node name instead of alias name for hd device in FW=
PathProvider
      mac_newworld: use node name instead of alias name for hd device in FW=
PathProvider

Max Reitz (3):
      iotests: Filter second BLOCK_JOB_ERROR from 229
      block/file-posix: Unaligned O_DIRECT block-status
      iotests: Test unaligned raw images with O_DIRECT

Michael Roth (1):
      qga-win: include glib when building VSS DLL

Paolo Bonzini (1):
      i386: remove the 'INTEL_PT' CPUID bit from named CPU models

Paul A. Clarke (1):
      Changes requirement for "vsubsbs" instruction

Peter Lieven (1):
      megasas: fix mapped frame size

Peter Maydell (2):
      linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0
      exec.c: Don't reallocate IOMMUNotifiers that are in use

Robert Hoo (1):
      i386: remove the new CPUID 'PCONFIG' from Icelake-Server CPU model

Stefan Berger (2):
      tpm: Make sure new locality passed to tpm_tis_prep_abort() is valid
      tpm: Make sure the locality received from backend is valid

Thomas Huth (1):
      hw/s390x: Fix bad mask in time2tod()

Thomas Petazzoni (1):
      configure: improve usbfs check

William Bowling (1):
      slirp: check sscanf result when emulating ident

Zheng Xiang (1):
      pcie: set link state inactive/active after hot unplug/plug

 block.c                            | 13 +++----------
 block/file-posix.c                 | 16 ++++++++++++++++
 block/qcow2.c                      |  3 ++-
 configure                          | 19 +++++++++++++++++--
 exec.c                             | 10 ++++++----
 hw/acpi/piix4.c                    |  1 +
 hw/i2c/bitbang_i2c.h               |  2 --
 hw/pci/pcie.c                      | 12 ++++++++++++
 hw/ppc/mac_newworld.c              |  4 ++--
 hw/ppc/mac_oldworld.c              |  4 ++--
 hw/rdma/rdma_rm_defs.h             |  4 ++--
 hw/scsi/megasas.c                  |  2 +-
 hw/tpm/tpm_tis.c                   |  8 ++++++--
 hw/usb/dev-mtp.c                   | 13 +++++++++----
 hw/vfio/ap.c                       |  8 ++++++++
 hw/virtio/vhost.c                  | 10 ++++++++++
 include/hw/i2c/i2c.h               |  2 ++
 include/hw/i2c/ppc4xx_i2c.h        |  3 ---
 include/hw/s390x/tod.h             |  2 +-
 linux-user/syscall.c               | 22 ++++++++++++++++++----
 net/vhost-user.c                   |  1 -
 qemu-img.c                         | 26 +++++++++++++-------------
 qga/qapi-schema.json               | 25 ++++++++++++++-----------
 qga/vss-win32/Makefile.objs        |  2 +-
 qobject/json-parser.c              | 10 ++++++----
 slirp/tcp_subr.c                   | 10 +++++-----
 target/i386/cpu.c                  | 11 ++++-------
 target/ppc/translate/vmx-ops.inc.c |  2 +-
 target/s390x/cpu_models.c          |  2 ++
 target/s390x/diag.c                |  2 +-
 tests/check-qjson.c                |  5 +++++
 tests/qemu-iotests/221             |  4 ++++
 tests/qemu-iotests/229             |  6 +++++-
 tests/qemu-iotests/229.out         |  1 -
 tests/qemu-iotests/235             |  4 +++-
 tests/qemu-iotests/253             | 84 ++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/253.out         | 14 ++++++++++++++
 tests/qemu-iotests/group           |  1 +
 util/cutils.c                      |  2 +-
 39 files changed, 282 insertions(+), 88 deletions(-)
 create mode 100755 tests/qemu-iotests/253
 create mode 100644 tests/qemu-iotests/253.out


