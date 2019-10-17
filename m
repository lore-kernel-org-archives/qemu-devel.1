Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECECECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA15E21D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA15E21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLEA2-0003U7-Rd
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iLE9K-0002wp-KL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iLE9I-0007WY-Gf
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:21:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iLE9E-0007VH-8q; Thu, 17 Oct 2019 18:21:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9HMHTbS140315; Thu, 17 Oct 2019 18:21:31 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vq0hks0cb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 18:21:31 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9HMFaCn003472;
 Thu, 17 Oct 2019 22:21:30 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma01dal.us.ibm.com with ESMTP id 2vq0brgb3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Oct 2019 22:21:29 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9HMLT9c54002102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2019 22:21:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36CF7B20A2;
 Thu, 17 Oct 2019 22:21:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05707B20A3;
 Thu, 17 Oct 2019 22:21:29 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 17 Oct 2019 22:21:28 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <157135088187.11473.6203817274726226536@sif>
Subject: [ANNOUNCE] QEMU 4.0.1 Stable released
Date: Thu, 17 Oct 2019 17:21:21 -0500
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-17_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170194
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi everyone,

I am pleased to announce that the QEMU v4.0.1 stable release is now
available:

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v4.0.1 is now tagged in the official qemu.git repository,
and the stable-4.0 branch has been updated accordingly:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-4.0

This update contains security fixes for CVE-2019-12068 (LSI SCSI emulation)
and CVE-2019-14378/CVE-2019-15890 (slirp), as well as a broad range of
general fixes for various subsystems and machine types.

Also note that this update introduces a new default machine type for Q35
guests, pc-q35-4.0.1, which should be used in favor of pc-q35-4.0 for
any configurations involving VFIO passthrough. See commit 92fa1b1a28 for
more details.

Please see the changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

23967e5b2a: Update version for 4.0.1 release (Michael Roth)
a678cd4d30: xen-bus: check whether the frontend is active during device res=
et... (Paul Durrant)
6341bef468: virtio-blk: Cancel the pending BH when the dataplane is reset (=
Philippe Mathieu-Daud=C3=A9)
35d6458d6a: migration: Fix use-after-free during process exit (Yury Kotov)
306ecc0d24: hw/nvram/fw_cfg: Store 'reboot-timeout' as little endian (Li Qi=
ang)
1e821a0abc: hw/display/xlnx_dp: Avoid crash when reading empty RX FIFO (Phi=
lippe Mathieu-Daud=C3=A9)
96389e9061: hw/ssi/mss-spi: Avoid crash when reading empty RX FIFO (Philipp=
e Mathieu-Daud=C3=A9)
535b8d00c1: nvme: Set number of queues later in nvme_init() (Michal Privozn=
ik)
a81a7fc22e: pc-dimm: fix crash when invalid slot number is used (Igor Mamme=
dov)
b65e78320b: scsi: lsi: exit infinite loop while executing script (CVE-2019-=
12068) (Paolo Bonzini)
4f1c6cb2f9: hw/core/loader: Fix possible crash in rom_copy() (Thomas Huth)
a8f24b6bdf: s390: PCI: fix IOMMU region init (Matthew Rosato)
b27192be13: slirp: ip_reass: Fix use after free (Michael Roth)
c2e03e2aa4: slirp: Fix heap overflow in ip_reass on big packet input (Micha=
el Roth)
4e5fe75422: curl: Check curl_multi_add_handle()'s return code (Max Reitz)
6739c97bde: curl: Handle success in multi_check_completion (Max Reitz)
deea66dc61: curl: Report only ready sockets (Max Reitz)
076796fd39: curl: Pass CURLSocket to curl_multi_do() (Max Reitz)
2aba40a2c8: curl: Check completion in curl_multi_do() (Max Reitz)
06b178eb61: curl: Keep *socket until the end of curl_sock_cb() (Max Reitz)
c4134c9c46: curl: Keep pointer to the CURLState in CURLSocket (Max Reitz)
b9405afb09: blockjob: update nodes head while removing all bdrv (Sergio Lop=
ez)
6cb3e9e4f1: block/nfs: tear down aio before nfs_close (Peter Lieven)
c24d971c13: block/create: Do not abort if a block driver is not available (=
Philippe Mathieu-Daud=C3=A9)
ce9c8f6767: libvhost-user: fix SLAVE_SEND_FD handling (Johannes Berg)
e40124c487: iotests: Test blockdev-create for vpc (Max Reitz)
491bf15671: iotests: Restrict nbd Python tests to nbd (Max Reitz)
f949655dd3: iotests: Restrict file Python tests to file (Max Reitz)
89e4faa9ca: iotests: Add supported protocols to execute_test() (Max Reitz)
43143d5d91: vpc: Return 0 from vpc_co_create() on success (Max Reitz)
88a2ea5a48: iotests: add testing shim for script-style python tests (John S=
now)
83f9b84c8b: pr-manager: Fix invalid g_free() crash bug (Markus Armbruster)
434a15214f: xen-bus: Fix backend state transition on device reset (Anthony =
PERARD)
0570d468b7: target/arm: Don't abort on M-profile exception return in linux-=
user mode (Peter Maydell)
53c641048e: dma-helpers: ensure AIO callback is invoked after cancellation =
(Paolo Bonzini)
cb7630af20: qcow2: Fix the calculation of the maximum L2 cache size (Albert=
o Garcia)
107018c4fd: Revert "ide/ahci: Check for -ECANCELED in aio callbacks" (John =
Snow)
7d4b467790: block/backup: disable copy_range for compressed backup (Vladimi=
r Sementsov-Ogievskiy)
5a35dbf228: iotests: Test unaligned blocking mirror write (Max Reitz)
d65d02614b: mirror: Only mirror granularity-aligned chunks (Max Reitz)
f69d8f2347: iotests: Test incremental backup after truncation (Max Reitz)
fc5c701636: util/hbitmap: update orig_size on truncate (Vladimir Sementsov-=
Ogievskiy)
c430d7684e: iotests: Test backup job with two guest writes (Max Reitz)
70353442db: backup: Copy only dirty areas (Max Reitz)
872b7b8ef9: block/backup: refactor: split out backup_calculate_cluster_size=
 (Vladimir Sementsov-Ogievskiy)
54d45c8251: block/backup: unify different modes code path (Vladimir Sements=
ov-Ogievskiy)
87851171b4: block/backup: refactor and tolerate unallocated cluster skippin=
g (Vladimir Sementsov-Ogievskiy)
3f6c00eb61: block/backup: move to copy_bitmap with granularity (Vladimir Se=
mentsov-Ogievskiy)
0b55b27908: block/backup: simplify backup_incremental_init_copy_bitmap (Vla=
dimir Sementsov-Ogievskiy)
6210ff6aa2: tpm_emulator: Translate TPM error codes to strings (Stefan Berg=
er)
0647727e47: tpm: Exit in reset when backend indicates failure (Stefan Berge=
r)
d7e9b19f0b: i386/acpi: fix gint overflow in crs_range_compare (Evgeny Yakov=
lev)
c4ac494578: virtio-balloon: free pbp more aggressively (Michael S. Tsirkin)
f18bce29e1: virtio-balloon: don't track subpages for the PBP (David Hildenb=
rand)
8e20acad63: virtio-balloon: Use temporary PBP only (David Hildenbrand)
d0444b1ee3: virtio-balloon: Rework pbp tracking data (David Hildenbrand)
b50aab6b83: virtio-balloon: Better names for offset variables in inflate/de=
flate code (David Hildenbrand)
2c743c8522: virtio-balloon: Simplify deflate with pbp (David Hildenbrand)
04e35fe3c4: virtio-balloon: Fix QEMU crashes on pagesize > BALLOON_PAGE_SIZ=
E (David Hildenbrand)
912440beb5: virtio-balloon: Fix wrong sign extension of PFNs (David Hildenb=
rand)
eeb25956e7: i386/acpi: show PCI Express bus on pxb-pcie expanders (Evgeny Y=
akovlev)
d25b37247d: ioapic: kvm: Skip route updates for masked pins (Jan Kiszka)
5ad70231d3: hw/ssi/xilinx_spips: Avoid out-of-bound access to lqspi_buf[] (=
Philippe Mathieu-Daud=C3=A9)
804a0ae6c0: hw/ssi/xilinx_spips: Avoid AXI writes to the LQSPI linear memor=
y (Philippe Mathieu-Daud=C3=A9)
255325da13: hw/ssi/xilinx_spips: Convert lqspi_read() to read_with_attrs (P=
hilippe Mathieu-Daud=C3=A9)
e11cd43f24: docs/bitmaps: use QMP lexer instead of json (John Snow)
22a03c48e7: sphinx: add qmp_lexer (John Snow)
e653d5ed18: docs/interop/bitmaps.rst: Fix typos (John Snow)
a6fe4a3aa8: virtio-balloon: fix QEMU 4.0 config size migration incompatibil=
ity (Stefan Hajnoczi)
e86e620656: usbredir: fix buffer-overflow on vmload (Marc-Andr=C3=A9 Lureau)
32e8ac8a28: virtio-pci: fix missing device properties (Marc-Andr=C3=A9 Lure=
au)
8da804f4f9: docs: recommend use of md-clear feature on all Intel CPUs (Dani=
el P. Berrang=C3=A9)
7427060f98: target/i386: define md-clear bit (Paolo Bonzini)
41e1564fb5: target/i386: add MDS-NO feature (Paolo Bonzini)
8e29c657ca: vl: Fix -drive / -blockdev persistent reservation management (M=
arkus Armbruster)
92fa1b1a28: q35: Revert to kernel irqchip (Alex Williamson)
75f83e7c4a: target/ppc: Fix lxvw4x, lxvh8x and lxvb16x (Anton Blanchard)
b6159fc9a6: target/ppc: Fix vsum2sws (Anton Blanchard)
da3bd13802: target/ppc: Fix xxbrq, xxbrw (Anton Blanchard)
fd72de9047: target/ppc: Fix xvxsigdp (Anton Blanchard)
14c9bbab09: target/ppc: Fix xvabs[sd]p, xvnabs[sd]p, xvneg[sd]p, xvcpsgn[sd=
]p (Anton Blanchard)
1cf90f8a97: vhost: fix vhost_log size overflow during migration (Li Hangjin=
g)
3a87d07722: migration/dirty-bitmaps: change bitmap enumeration method (John=
 Snow)
07cc0a207f: iotests: add iotest 256 for testing blockdev-backup across ioth=
read contexts (John Snow)
32097f14fc: iotests.py: rewrite run_job to be pickier (John Snow)
2ab69df8db: iotests.py: Fix VM.run_job (Max Reitz)
c7b4a73541: QEMUMachine: add events_wait method (John Snow)
94a14e6f2a: iotests.py: do not use infinite waits (John Snow)
7415a83e9b: iotests: Test commit job start with concurrent I/O (Kevin Wolf)
627fadfa1c: block: Drain source node in bdrv_replace_node() (Kevin Wolf)
2429dc4eea: blockdev-backup: don't check aio_context too early (John Snow)
f8d98e2b6d: s390x/cpumodel: ignore csske for expansion (Christian Borntraeg=
er)
d8328a3ca5: iotests: Test unaligned raw images with O_DIRECT (Max Reitz)
241d89b760: block/file-posix: Unaligned O_DIRECT block-status (Max Reitz)
665218cc08: usb-tablet: fix serial compat property (Gerd Hoffmann)
a68ab7c88f: kbd-state: fix autorepeat handling (Gerd Hoffmann)
ffabb55ec2: spapr/xive: fix EQ page addresses above 64GB (C=C3=A9dric Le Go=
ater)
2974d63658: docs/interop/bitmaps: rewrite and modernize doc (John Snow)
da436b77d8: Makefile: add nit-picky mode to sphinx-build (John Snow)
48025d942e: cutils: Fix size_to_str() on 32-bit platforms (Eric Blake)
626a95f4aa: block: Fix AioContext switch for bs->drv =3D=3D NULL (Kevin Wol=
f)
774f013111: qcow2: Fix qcow2_make_empty() with external data file (Kevin Wo=
lf)
173e30de4c: megasas: fix mapped frame size (Peter Lieven)
4382e8da22: qcow2: Fix full preallocation with external data file (Kevin Wo=
lf)
e628c14be4: qcow2: Add errp to preallocate_co() (Kevin Wolf)
5669ef1e6c: qcow2: Avoid COW during metadata preallocation (Kevin Wolf)

