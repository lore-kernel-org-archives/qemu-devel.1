Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA92C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 23:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0528E216F4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 23:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0528E216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hq43E-0003Yw-V4
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 19:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34162)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hq433-00036R-3B
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 19:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hq431-0002pq-AU
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 19:18:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hq431-0002p8-2L
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 19:18:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6NNHLQL056461; Tue, 23 Jul 2019 19:18:15 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tx97q57pq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 19:18:15 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6NNEYwv022521;
 Tue, 23 Jul 2019 23:18:14 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03dal.us.ibm.com with ESMTP id 2tx61n2163-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jul 2019 23:18:14 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6NNIDZC58261978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 23:18:13 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F30186E056;
 Tue, 23 Jul 2019 23:18:12 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4A486E052;
 Tue, 23 Jul 2019 23:18:12 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jul 2019 23:18:12 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <156391995184.11893.17276992491834493758@sif>
References: <156391995184.11893.17276992491834493758@sif>
Message-ID: <156392382152.16169.3678189577623009709@sif>
User-Agent: alot/0.7
Date: Tue, 23 Jul 2019 18:17:01 -0500
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230239
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.1.0-rc2 is now available
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

Quoting Michael Roth (2019-07-23 17:12:31)
> Hello,
> =

> On behalf of the QEMU Team, I'd like to announce the availability of the
> third release candidate for the QEMU 4.1 release.  This release is meant
> for testing purposes and should not be used in a production environment.
> =

>   http://download.qemu-project.org/qemu-4.1.0-rc2.tar.xz
>   http://download.qemu-project.org/qemu-4.1.0-rc2.tar.xz.sig
> =

> You can help improve the quality of the QEMU 4.1 release by testing this
> release and reporting bugs on Launchpad:
> =

>   https://bugs.launchpad.net/qemu/
> =

> The release plan, as well a documented known issues for release
> candidates, are available at:
> =

>   http://wiki.qemu.org/Planning/4.1
> =

> Please add entries to the ChangeLog for the 4.1 release below:
> =

>   http://wiki.qemu.org/ChangeLog/4.1
> =

> Thank you to everyone involved!
> =

> Changes since rc1:

Please disregard prior changelog, this is the corrected one:

bf8b024372: Update version for v4.1.0-rc2 release (Peter Maydell)
98808c3d0c: tests/docker: Refresh APT cache before installing new packages =
on Debian (Philippe Mathieu-Daud=C3=A9)
30edd9fa50: tests/qemu-iotests: Don't use 'seq' in the iotests (Thomas Huth)
4f01046172: tests/qemu-iotests/group: Remove some more tests from the "auto=
" group (Thomas Huth)
bf75d75275: tests/qemu-iotests/check: Allow tests without groups (Thomas Hu=
th)
2b0c4fa13f: tests/docker: invoke the DEBUG shell with --noprofile/--norc (A=
lex Benn=C3=A9e)
3a37c13f8c: travis: enable travis_retry for check phase (Alex Benn=C3=A9e)
6d314626cc: hw/i386: also turn off VMMOUSE is VMPORT is disabled (Alex Benn=
=C3=A9e)
e54ecc70c3: NSIS: Add missing firmware blobs (Philippe Mathieu-Daud=C3=A9)
5deb2de1d6: tests/docker: Let the test-mingw test generate a NSIS installer=
 (Philippe Mathieu-Daud=C3=A9)
b3ce38dcf9: buildsys: The NSIS Windows build requires qemu-nsis.bmp install=
ed (Philippe Mathieu-Daud=C3=A9)
f84f9f7584: buildsys: The NSIS Windows build requires the documentation ins=
talled (Philippe Mathieu-Daud=C3=A9)
10d7166e42: tests/docker: Install texinfo in the Fedora image (Philippe Mat=
hieu-Daud=C3=A9)
a88819edde: tests/docker: Set the correct cross-PKG_CONFIG_PATH in the MXE =
images (Philippe Mathieu-Daud=C3=A9)
c054f3f43a: tests/docker: Install the NSIS tools in the MinGW capable image=
s (Philippe Mathieu-Daud=C3=A9)
8d16a31028: tests/docker: Install Sphinx in the Debian images (Philippe Mat=
hieu-Daud=C3=A9)
7887289441: shippable: re-enable the windows cross builds (Alex Benn=C3=A9e)
67bd36beda: tests/dockerfiles: update the win cross builds to stretch (Alex=
 Benn=C3=A9e)
601b5575e2: tests/migration-test: don't spam the logs when we fail (Alex Be=
nn=C3=A9e)
56e89a310b: tests/docker: Install Ubuntu images noninteractively (Philippe =
Mathieu-Daud=C3=A9)
8109b7986a: tests/docker: Install Sphinx in the Fedora image (Philippe Math=
ieu-Daud=C3=A9)
6d7b9c8c06: tests/docker: Install Sphinx in the Ubuntu images (Philippe Mat=
hieu-Daud=C3=A9)
3c237b5c65: tests/docker: add test-misc for building tools & docs (Alex Ben=
n=C3=A9e)
84963b5bbf: archive-source: also create a stash for submodules (Marc-Andr=
=C3=A9 Lureau)
124e4cfaa4: hw/block/pflash_cfi02: Rewrite a fall through comment (Philippe=
 Mathieu-Daud=C3=A9)
3a283507c0: hw/block/pflash_cfi01: Add missing DeviceReset() handler (Phili=
ppe Mathieu-Daud=C3=A9)
5122958258: target/mips: Fix emulation of MSA pack instructions on big endi=
an hosts (Aleksandar Markovic)
45152d0502: target/mips: Add 'fall through' comments for handling nanoMips'=
 SHXS, SWXS (Aleksandar Markovic)
43eaaaef0e: block: Only the main loop can change AioContexts (Max Reitz)
65181d6381: block: Dec. drained_end_counter before bdrv_wakeup (Max Reitz)
258867d1dc: block/nvme: don't touch the completion entries (Maxim Levitsky)
118d1b6a81: block/nvme: support larger that 512 bytes sector devices (Maxim=
 Levitsky)
461bba04bf: block/nvme: fix doorbell stride (Maxim Levitsky)
ddb45afbfb: contrib/elf2dmp: Build download.o with CURL_CFLAGS (Peter Mayde=
ll)
a3e3b5217b: configure: Clarify URL to source downloads (Peter Maydell)
8f4821d77e: target/arm: Limit ID register assertions to TCG (Peter Maydell)
bc8c2ecfd0: hw/arm/fsl-imx6ul.c: Remove dead SMP-related code (Peter Maydel=
l)
9bbb4ef991: target/arm: Add missing break statement for Hypervisor Trap Exc=
eption (Philippe Mathieu-Daud=C3=A9)
d4b976c0a8: target/i386: sev: fix failed message typos (Jiri Slaby)
2924ab02c2: i386: indicate that 'pconfig' feature was removed intentionally=
 (Denis V. Lunev)
5cf42b1c1f: nbd: Initialize reply on failure (Eric Blake)
21e709aa07: build-sys: do no support modules on Windows (Marc-Andr=C3=A9 Lu=
reau)
3bf5de5240: qmp: don't emit the RESET event on wakeup (Nicholas Piggin)
8072aae377: hmp: Print if memory section is registered with an accelerator =
(Alexey Kardashevskiy)
2f950b1e44: test-bitmap: add test for bitmap_set (Wei Yang)
1849f297f5: scsi-generic: Check sense key before request snooping and patch=
ing (Shin'ichiro Kawasaki)
68fa7ca015: vhost-user-scsi: Call virtio_scsi_common_unrealize() when devic=
e realize failed (Xie Yongji)
934443c37b: vhost-scsi: Call virtio_scsi_common_unrealize() when device rea=
lize failed (Xie Yongji)
12e1dc4939: virtio-scsi: remove unused argument to virtio_scsi_common_reali=
ze (Paolo Bonzini)
1e44f3ab71: target/i386: skip KVM_GET/SET_NESTED_STATE if VMX disabled, or =
for SVM (Paolo Bonzini)
79a197ab18: target/i386: kvm: Demand nested migration kernel capabilities o=
nly when vCPU may have enabled VMX (Liran Alon)
b7cbb8741b: crypto: Fix LGPL information in the file headers (Thomas Huth)
4f24430821: doc: document that the monitor console is a privileged control =
interface (Daniel P. Berrang=C3=A9)
49278ec065: iotests: Test quitting with job on throttled node (Max Reitz)
e6f0ac4d52: vl: Drain before (block) job cancel when quitting (Max Reitz)
02f9135be6: configure: only link capstone to emulation targets (Daniel P. B=
errang=C3=A9)
f887849007: crypto: fix function signatures for nettle 2.7 vs 3 (Daniel P. =
Berrang=C3=A9)
e8e67ca4c1: crypto: switch to modern nettle AES APIs (Daniel P. Berrang=C3=
=A9)
86472071f4: iotests: Test commit with a filter on the chain (Max Reitz)
4687133b81: iotests: Add @has_quit to vm.shutdown() (Max Reitz)
61ad631cee: block: Loop unsafely in bdrv*drained_end() (Max Reitz)
2afdc790ec: tests: Extend commit by drained_end test (Max Reitz)
e037c09c78: block: Do not poll in bdrv_do_drained_end() (Max Reitz)
1b28565768: tests: Lock AioContexts in test-block-iothread (Max Reitz)
f4c8a43be0: block: Make bdrv_parent_drained_[^_]*() static (Max Reitz)
8e1da77e6e: block: Add @drained_end_counter (Max Reitz)
8e4428106a: tests: Add job commit by drained_end test (Max Reitz)
804db8ea00: block: Introduce BdrvChild.parent_quiesce_counter (Max Reitz)
a6862418fe: iotests: Set read-zeroes on in null block driver for Valgrind (=
Andrey Shinkevich)
6d5d5dde9a: linux-user: fix to handle variably sized SIOCGSTAMP with new ke=
rnels (Daniel P. Berrang=C3=A9)
fdd1bda4b4: hw/riscv: Load OpenSBI as the default firmware (Alistair Franci=
s)
91f3a2f0ce: roms: Add OpenSBI version 0.4 (Alistair Francis)
0acd4ab849: linux-user: check valid address in access_ok() (R=C3=A9mi Denis=
-Courmont)
efac5ae420: s390x/pci: add some fallthrough annotations (Cornelia Huck)
4ced996ffe: linux-user: Fix structure target_ucontext for MIPS (Aleksandar =
Markovic)

