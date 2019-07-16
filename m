Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AE7C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 23:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828032187F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 23:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828032187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnXAE-0004Qv-Ol
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 19:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37017)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hnXA2-0003yk-QT
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 19:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1hnXA0-00068x-Kk
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 19:47:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41328
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1hnXA0-000684-ET
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 19:47:04 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6GMbkrZ027065
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:47:00 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tspehkwfb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:47:00 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Wed, 17 Jul 2019 00:46:59 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Jul 2019 00:46:58 +0100
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6GNkvAn30540284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2019 23:46:57 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 073EF13604F;
 Tue, 16 Jul 2019 23:46:57 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C978B136055;
 Tue, 16 Jul 2019 23:46:56 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2019 23:46:56 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 18:46:51 -0500
X-TM-AS-GCONF: 00
x-cbid: 19071623-0016-0000-0000-000009CE6413
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011441; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01233210; UDB=6.00649780; IPR=6.01014521; 
 MB=3.00027750; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-16 23:46:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071623-0017-0000-0000-0000440A9F4B
Message-Id: <156332081108.5171.10105606970389101752@sif>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-16_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160261
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [ANNOUNCE] QEMU 4.1.0-rc1 is now available
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
second release candidate for the QEMU 4.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-4.1.0-rc1.tar.xz
  http://download.qemu-project.org/qemu-4.1.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 4.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/4.1

Please add entries to the ChangeLog for the 4.1 release below:

  http://wiki.qemu.org/ChangeLog/4.1

Thank you to everyone involved!

Changes since rc0:

0b18cfb8f1: Update version for v4.1.0-rc1 release (Peter Maydell)
611c749c3b: hw/block/pflash_cfi01: Start state machine as READY to accept c=
ommands (Philippe Mathieu-Daud=C3=A9)
2658594ff6: hw/block/pflash_cfi02: Explicit switch fallthrough for ERASE co=
mmands (Philippe Mathieu-Daud=C3=A9)
5d8866c898: s390x/cpumodel: change internal name of vxpdeh to match descrip=
tion (Christian Borntraeger)
0d4cb295db: s390x/cpumodel: also change name of vxbeh (Christian Borntraege=
r)
de6bb08570: s390x/cpumodel: remove esort from the default model (Christian =
Borntraeger)
45d8bc3ade: vl: make sure char-pty message displayed by moving setbuf to th=
e beginning (Wei Yang)
0d0304f2c4: target/mips: Add missing 'break' for certain cases of MTTR hand=
ling (Aleksandar Markovic)
f1fadbb27a: target/mips: Add missing 'break' for certain cases of MFTR hand=
ling (Aleksandar Markovic)
ab8c34105a: target/mips: Add missing 'break' for a case of MTHC0 handling (=
Aleksandar Markovic)
32481687e1: qemu-tech: Fix dangling @menu entries (Markus Armbruster)
6518331813: Makefile: Fix missing dependency of on qemu-tech.texi (Markus A=
rmbruster)
47ae060e75: Makefile: Fix "make install" when "make all" needs work (Markus=
 Armbruster)
3cae16db02: create_config: remove $(CONFIG_SOFTMMU) hack (Paolo Bonzini)
2d1794e956: Makefile: do not repeat $(CONFIG_SOFTMMU) in hw/Makefile.objs (=
Paolo Bonzini)
c363fd483c: hw/usb/Kconfig: USB_XHCI_NEC requires USB_XHCI (Philippe Mathie=
u-Daud=C3=A9)
a86588d6a9: hw/usb/Kconfig: Add CONFIG_USB_EHCI_PCI (Philippe Mathieu-Daud=
=C3=A9)
56e2ec9488: target/i386: sev: Do not unpin ram device memory region (Alex W=
illiamson)
874acb6f83: checkpatch: detect doubly-encoded UTF-8 (Paolo Bonzini)
19752e09b4: hw/lm32/Kconfig: Milkymist One provides a USB 1.1 Controller (P=
hilippe Mathieu-Daud=C3=A9)
0b1847bbc2: gluster: fix .bdrv_reopen_prepare when backing file is a JSON o=
bject (Stefano Garzarella)
0e4a0644bf: iotests: Add read-only test case to 030 (Max Reitz)
13658cd70b: iotests: Add new case to 030 (Max Reitz)
15427f63bc: iotests: Add @use_log to VM.run_job() (Max Reitz)
3f92d54c00: iotests: Compare error messages in 030 (Max Reitz)
7229e121fd: iotests: Fix throttling in 030 (Max Reitz)
3cf746b3f1: block: Deep-clear inherits_from (Max Reitz)
8441d82d51: block/stream: Swap backing file change order (Max Reitz)
17a7c39248: block/stream: Fix error path (Max Reitz)
e5182c1c57: block: Add BDS.never_freeze (Max Reitz)
95667c3be0: nvme: Set number of queues later in nvme_init() (Michal Privozn=
ik)
40c4d4a835: migration: always initial RAMBlock.bmap to 1 for new migration =
(Ivan Ren)
40277ca807: migration/postcopy: remove redundant cpu_synchronize_all_post_i=
nit (Wei Yang)
89dab31b27: migration/postcopy: fix document of postcopy_send_discard_bm_ra=
m() (Wei Yang)
b17fbbe55c: migration: allow private destination ram with x-ignore-shared (=
Peng Tao)
002cad6b16: migration: Split log_clear() into smaller chunks (Peter Xu)
ff4aa11419: kvm: Support KVM_CLEAR_DIRTY_LOG (Peter Xu)
36adac4934: kvm: Introduce slots lock for memory listener (Peter Xu)
9f4bf4baa8: kvm: Persistent per kvmslot dirty bitmap (Peter Xu)
4a12a11a39: kvm: Update comments for sync_dirty_bitmap (Peter Xu)
077874e01f: memory: Introduce memory listener hook log_clear() (Peter Xu)
5dea4079ad: memory: Pass mr into snapshot_and_clear_dirty (Peter Xu)
ad37f24d57: bitmap: Add bitmap_copy_with_{src|dst}_offset() (Peter Xu)
ae7a2bca8a: memory: Don't set migration bitmap when without migration (Pete=
r Xu)
267691b65c: migration: No need to take rcu during sync_dirty_bitmap (Peter =
Xu)
422314e751: migration/ram.c: reset complete_round when we gets a queued pag=
e (Wei Yang)
77568ea7f8: migration/multifd: sync packet_num after all thread are done (W=
ei Yang)
7c960d617a: cutils: remove one unnecessary pointer operation (Wei Yang)
ca35380390: migration/xbzrle: update cache and current_data in one place (W=
ei Yang)
b6526c4b21: migration/multifd: call multifd_send_sync_main when sending RAM=
_SAVE_FLAG_EOS (Wei Yang)
8f7798f191: migration-test: rename parameter to parameter_int (Juan Quintel=
a)
8ebad0f7a7: migration: fix multifd_recv event typo (Juan Quintela)
51c9122e92: target/arm: NS BusFault on vector table fetch escalates to NS H=
ardFault (Peter Maydell)
cb7cef8b32: target/arm: Set VFP-related MVFR0 fields for arm926 and arm1026=
 (Peter Maydell)
032cfe6a79: pl031: Correctly migrate state when using -rtc clock=3Dhost (Pe=
ter Maydell)
80734cbdca: hw/arm/virt: Fix non-secure flash mode (David Engraf)
a09ef50404: hw/display/xlnx_dp: Avoid crash when reading empty RX FIFO (Phi=
lippe Mathieu-Daud=C3=A9)
c0bccee9b4: hw/ssi/mss-spi: Avoid crash when reading empty RX FIFO (Philipp=
e Mathieu-Daud=C3=A9)
526668c734: hw/ssi/xilinx_spips: Avoid out-of-bound access to lqspi_buf[] (=
Philippe Mathieu-Daud=C3=A9)
936a236c4e: hw/ssi/xilinx_spips: Avoid AXI writes to the LQSPI linear memor=
y (Philippe Mathieu-Daud=C3=A9)
5937bd50d3: hw/ssi/xilinx_spips: Convert lqspi_read() to read_with_attrs (P=
hilippe Mathieu-Daud=C3=A9)
45b1a243b8: target/arm: report ARMv8-A FP support for AArch32 -cpu max (Ale=
x Benn=C3=A9e)
ea73f37062: Fix build error when VNC is configured out (Christophe de Dinec=
hin)
e9ed92bd8d: util: merge main-loop.c and iohandler.c (Paolo Bonzini)
f2b143a281: Fix broken build with WHPX enabled (Stefan Weil)
838ec1177c: memory: unref the memory region in simplify flatview (King Wang)
97fd1ea8c1: hw/i386: turn off vmport if CONFIG_VMPORT is disabled (Julio Mo=
ntes)
60ae0b91fe: rdmacm-mux: fix strcpy string warning (Marc-Andr=C3=A9 Lureau)
c2e8a52ca2: build-sys: remove slirp cflags from main-loop.o (Marc-Andr=C3=
=A9 Lureau)
8c460269aa: iscsi: base all handling of check condition on scsi_sense_to_er=
rno (Paolo Bonzini)
00e3cccdf4: iscsi: fix busy/timeout/task set full (Paolo Bonzini)
396ce7b94e: scsi: add guest-recoverable ZBC errors (Paolo Bonzini)
bdf9613b7f: scsi: explicitly list guest-recoverable sense codes (Paolo Bonz=
ini)
d31347f5ff: scsi-disk: pass sense correctly for guest-recoverable errors (S=
hinichiro Kawasaki)
52ba13f042: tcg: Release mmap_lock on translation fault (Richard Henderson)
2fbb2353ce: tcg: Remove duplicate #if !defined(CODE_ACCESS) (Richard Hender=
son)
6ad8307bdd: tcg: Remove cpu_ld*_code_ra (Richard Henderson)
08b97f7ff2: tcg: Introduce set/clear_helper_retaddr (Richard Henderson)
359896dfa4: include/qemu/atomic.h: Add signal_barrier (Richard Henderson)
1789d4274b: tcg/aarch64: Fix output of extract2 opcodes (Richard Henderson)
80f4d7c3ae: tcg: Fix constant folding of INDEX_op_extract2_i32 (Richard Hen=
derson)
207efa18ac: virtio pmem: remove transitional names (Pankaj Gupta)
7b8a847424: virtio pmem: remove memdev null check (Pankaj Gupta)
f37f471262: virtio pmem: fix wrong mem region condition (Pankaj Gupta)
7b9829bc6c: tests: acpi: do not skip tests when IASL is not installed (Igor=
 Mammedov)
ab31b3373e: tests: acpi: do not require IASL for dumping AML blobs (Igor Ma=
mmedov)
2bbadb08ce: virtio-balloon: fix QEMU 4.0 config size migration incompatibil=
ity (Stefan Hajnoczi)
4d90b7a0e4: pcie: consistent names for function args (Michael S. Tsirkin)
8e2e95ef04: xio3130_downstream: typo fix (Michael S. Tsirkin)
867eccfed8: file-posix: Use max transfer length/segment count only for SCSI=
 passthrough (Maxim Levitsky)
20ff903d52: iotests: Update 082 expected output (Eric Blake)
38298611d5: xics/kvm: Always set the MASKED bit if interrupt is masked (Gre=
g Kurz)
4493d430d0: pseries: Update SLOF firmware image (Alexey Kardashevskiy)
a7786bfb0e: docs/bitmaps: use QMP lexer instead of json (John Snow)
cd231e13bd: sphinx: add qmp_lexer (John Snow)
575e622628: docs/interop/bitmaps.rst: Fix typos (John Snow)
94b2a62bb6: gdbstub: revert to previous set_reg behaviour (Alex Benn=C3=A9e)
42a0959648: gdbstub: add some notes to the header comment (Alex Benn=C3=A9e)
ef860047b6: tests/tcg: fix diff-out pass to properly report failure (Alex B=
enn=C3=A9e)
bd2c0f67e1: tests/tcg: fix up test-i386-fprem.ref generation (Alex Benn=C3=
=A9e)


