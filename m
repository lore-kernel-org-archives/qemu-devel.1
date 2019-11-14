Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800BFC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A6920709
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 21:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A6920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVMxI-0001zH-OR
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 16:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iVMuu-0000iQ-JE
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iVMus-0007Jy-TL
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 16:44:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64814
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iVMuo-0007Iq-NU; Thu, 14 Nov 2019 16:44:34 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xAELbmeV012834; Thu, 14 Nov 2019 16:44:31 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w9cn7n5du-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2019 16:44:30 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAELZZhL021981;
 Thu, 14 Nov 2019 21:44:29 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma01dal.us.ibm.com with ESMTP id 2w5n37afcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2019 21:44:29 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAELiTMu54722942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2019 21:44:29 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13721112062;
 Thu, 14 Nov 2019 21:44:29 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC72D112061;
 Thu, 14 Nov 2019 21:44:28 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 14 Nov 2019 21:44:28 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <157376786282.8295.5424159782656228513@sif>
Subject: [ANNOUNCE] QEMU 4.1.1 Stable released
Date: Thu, 14 Nov 2019 15:44:22 -0600
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-14_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140176
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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

Hi everyone,

I am pleased to announce that the QEMU v4.1.1 stable release is now
available:

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v4.1.1 is now tagged in the official qemu.git repository,
and the stable-4.1 branch has been updated accordingly:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-4.1

This update contains a number of fixes relating qcow2 and XFS corruption, a
security fix for LSI SCSI emulation (CVE-2019-12068), and general fixes for
various other subsystems.

Please see the changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

99c5874a9b: Update version for 4.1.1 release (Michael Roth)
e092a17d38: mirror: Keep mirror_top_bs drained after dropping permissions (=
Kevin Wolf)
088f1e8fd9: block/create: Do not abort if a block driver is not available (=
Philippe Mathieu-Daud=C3=A9)
145b562990: vhost: Fix memory region section comparison (Dr. David Alan Gil=
bert)
42b6571357: memory: Provide an equality function for MemoryRegionSections (=
Dr. David Alan Gilbert)
c0aca9352d: memory: Align MemoryRegionSections fields (Dr. David Alan Gilbe=
rt)
54c130493c: tests: make filemonitor test more robust to event ordering (Dan=
iel P. Berrang=C3=A9)
3d018ff3bd: block: posix: Always allocate the first block (Nir Soffer)
f0d3fa265d: file-posix: Handle undetectable alignment (Nir Soffer)
7db05c8a73: block/file-posix: Let post-EOF fallocate serialize (Max Reitz)
d9b88f7e0d: block: Add bdrv_co_get_self_request() (Max Reitz)
590cff8230: block: Make wait/mark serialising requests public (Max Reitz)
2e2ad02f2c: block/io: refactor padding (Vladimir Sementsov-Ogievskiy)
b3b76fc643: util/iov: improve qemu_iovec_is_zero (Vladimir Sementsov-Ogievs=
kiy)
cff024fe85: util/iov: introduce qemu_iovec_init_extended (Vladimir Sementso=
v-Ogievskiy)
40df4a1bf7: qcow2-bitmap: Fix uint64_t left-shift overflow (Tuguoyi)
b156178553: iotests: Add peek_file* functions (Max Reitz)
15f5e8c367: iotests: Add test for 4G+ compressed qcow2 write (Max Reitz)
405deba14f: qcow2: Fix QCOW2_COMPRESSED_SECTOR_MASK (Max Reitz)
01be50603b: virtio-blk: Cancel the pending BH when the dataplane is reset (=
Philippe Mathieu-Daud=C3=A9)
051c9b3cbc: scsi: lsi: exit infinite loop while executing script (CVE-2019-=
12068) (Paolo Bonzini)
b387531323: target/xtensa: regenerate and re-import test_mmuhifi_c3 core (M=
ax Filippov)
cdc6896659: target/arm: Allow reading flags from FPSCR for M-profile (Chris=
tophe Lyon)
c0b35d87de: hbitmap: handle set/reset with zero length (Vladimir Sementsov-=
Ogievskiy)
fcd7cba6ac: util/hbitmap: strict hbitmap_reset (Vladimir Sementsov-Ogievski=
y)
aea18ef938: COLO-compare: Fix incorrect `if` logic (Fan Yang)
4887acf574: virtio-net: prevent offloads reset on migration (Mikhail Sennik=
ovsky)
8010d3fce0: virtio: new post_load hook (Michael S. Tsirkin)
6705b9344f: ui: Fix hanging up Cocoa display on macOS 10.15 (Catalina) (Hik=
aru Nishida)
c0e2fbf124: mirror: Do not dereference invalid pointers (Max Reitz)
b077ac637d: iotests: Test large write request to qcow2 file (Max Reitz)
9e51c5306c: qcow2: Limit total allocation range to INT_MAX (Max Reitz)
aae0faa5d3: hw/core/loader: Fix possible crash in rom_copy() (Thomas Huth)
7b404cae7f: vhost-user: save features if the char dev is closed (Adrian Mor=
eno)
d868d30db6: iotests: Test internal snapshots with -blockdev (Kevin Wolf)
7a8aa6c734: block/snapshot: Restrict set of snapshot nodes (Kevin Wolf)
331c08d300: s390: PCI: fix IOMMU region init (Matthew Rosato)
fc5afb1a92: roms/Makefile.edk2: don't pull in submodules when building from=
 tarball (Michael Roth)
c5c9b1362d: make-release: pull in edk2 submodules so we can build it from t=
arballs (Michael Roth)
220816989c: hw/arm/boot.c: Set NSACR.{CP11,CP10} for NS kernel boots (Peter=
 Maydell)
783e7eb52c: block/backup: fix backup_cow_with_offload for last cluster (Vla=
dimir Sementsov-Ogievskiy)
e01ed1a1ae: block/backup: fix max_transfer handling for copy_range (Vladimi=
r Sementsov-Ogievskiy)
416a692e51: qcow2: Fix corruption bug in qcow2_detect_metadata_preallocatio=
n() (Kevin Wolf)
e9bb3d942e: coroutine: Add qemu_co_mutex_assert_locked() (Kevin Wolf)
84f22c7285: block/qcow2: Fix corruption introduced by commit 8ac0f15f335 (M=
axim Levitsky)
86b0f4022b: blockjob: update nodes head while removing all bdrv (Sergio Lop=
ez)
2d86df1f78: curl: Handle success in multi_check_completion (Max Reitz)
18e1b71937: curl: Report only ready sockets (Max Reitz)
0888ddac8e: curl: Pass CURLSocket to curl_multi_do() (Max Reitz)
4be97ef966: curl: Check completion in curl_multi_do() (Max Reitz)
78ea94e389: curl: Keep *socket until the end of curl_sock_cb() (Max Reitz)
3648493495: curl: Keep pointer to the CURLState in CURLSocket (Max Reitz)
0694c489cd: block/nfs: tear down aio before nfs_close (Peter Lieven)
c9ffb12754: qcow2: Fix the calculation of the maximum L2 cache size (Albert=
o Garcia)
28a9a3558a: libvhost-user: fix SLAVE_SEND_FD handling (Johannes Berg)
9027d3fba6: target/arm: Don't abort on M-profile exception return in linux-=
user mode (Peter Maydell)
38fb634853: target/arm: Free TCG temps in trans_VMOV_64_sp() (Peter Maydell)
ad95e0573e: iotests: Test blockdev-create for vpc (Max Reitz)
593beeaf81: iotests: Restrict nbd Python tests to nbd (Max Reitz)
eee776fbc0: iotests: Restrict file Python tests to file (Max Reitz)
819ba23575: iotests: Add supported protocols to execute_test() (Max Reitz)
4d9bdd3149: iotests: add testing shim for script-style python tests (John S=
now)
97c478c355: vpc: Return 0 from vpc_co_create() on success (Max Reitz)
725dfa851f: x86: do not advertise die-id in query-hotpluggbale-cpus if '-sm=
p dies' is not set (Igor Mammedov)
57fdf4a13f: pr-manager: Fix invalid g_free() crash bug (Markus Armbruster)
3361d03ff0: iotests: Test reverse sub-cluster qcow2 writes (Max Reitz)
6f1a94035b: block/file-posix: Reduce xfsctl() use (Max Reitz)
c12adfd8f6: xen-bus: check whether the frontend is active during device res=
et... (Paul Durrant)
b6cedc911e: xen-bus: Fix backend state transition on device reset (Anthony =
PERARD)
7ebcd375ad: pc: Don't make die-id mandatory unless necessary (Eduardo Habko=
st)
4bfd496be3: target/alpha: fix tlb_fill trap_arg2 value for instruction fetc=
h (Aurelien Jarno)
499a5d6bb4: s390x/tcg: Fix VERIM with 32/64 bit elements (David Hildenbrand)
73a5bf4729: Revert "ide/ahci: Check for -ECANCELED in aio callbacks" (John =
Snow)
fbde196c30: dma-helpers: ensure AIO callback is invoked after cancellation =
(Paolo Bonzini)


