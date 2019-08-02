Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2032C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 17:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88EA21773
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 17:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88EA21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htblZ-0002kD-PP
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 13:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55135)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1htbhA-0001Ud-7J
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1htbh5-0002ag-Lr
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:50:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1htbh5-0002ST-AA
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 13:50:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x72HlQEV124362
 for <qemu-devel@nongnu.org>; Fri, 2 Aug 2019 13:50:13 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u4s999nb8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 13:50:13 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
 Fri, 2 Aug 2019 18:50:12 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 2 Aug 2019 18:50:10 +0100
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x72Ho9MA60293600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Aug 2019 17:50:09 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D44F0C6070;
 Fri,  2 Aug 2019 17:50:08 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEF61C606D;
 Fri,  2 Aug 2019 17:50:08 +0000 (GMT)
Received: from localhost (unknown [9.53.179.212])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri,  2 Aug 2019 17:50:08 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Date: Fri, 02 Aug 2019 12:50:01 -0500
X-TM-AS-GCONF: 00
x-cbid: 19080217-0004-0000-0000-000015320C9F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011538; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01241111; UDB=6.00654524; IPR=6.01022542; 
 MB=3.00028012; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-02 17:50:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080217-0005-0000-0000-00008CB8E0C7
Message-Id: <156476820179.5178.16916748630705802997@sif>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-02_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020186
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.1.1 Stable released
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

I am pleased to announce that the QEMU v3.1.1 stable release is now
available:

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v3.1.1 is now tagged in the official qemu.git repository,
and the stable-3.1 branch has been updated accordingly:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-3.1

This update contains a fix for CVE-2018-16872 (usb-mtp) and bug/security
fixes for a number of areas.

Please see the changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

71049d2a74: Update version for 3.1.1 release (Michael Roth)
03d7712b4b: qemu-bridge-helper: restrict interface name to IFNAMSIZ (Prasad=
 J Pandit)
4482258130: block: Fix hangs in synchronous APIs with iothreads (Kevin Wolf)
41dd30ff63: pvrdma: release ring object in case of an error (Prasad J Pandi=
t)
a1001760ab: pvrdma: check return value from pvrdma_idx_ring_has_ routines (=
Prasad J Pandit)
2a0e6f1369: pvrdma: check number of pages when creating rings (Prasad J Pan=
dit)
017f271f7a: device_tree: Fix integer overflowing in load_device_tree() (Mar=
kus Armbruster)
5149630fed: device_tree.c: Don't use load_image() (Peter Maydell)
59a823017a: sun4u: add power_mem_read routine (Prasad J Pandit)
3be7eb2f47: qxl: check release info object (Prasad J Pandit)
576964bf2a: seccomp: don't kill process for resource control syscalls (Dani=
el P. Berrang=C3=A9)
4c7f4c4bbb: i2c-ddc: fix oob read (Gerd Hoffmann)
4e74e7a867: slirp: check data length while emulating ident function (Prasad=
 J Pandit)
375667af78: scsi-generic: avoid possible out-of-bounds access to r->buf (Pa=
olo Bonzini)
bceff528ba: pvrdma: add uar_read routine (Prasad J Pandit)
1549e3a54a: pvrdma: release device resources in case of an error (Prasad J =
Pandit)
86d4f40141: gluster: the glfs_io_cbk callback function pointer adds pre/pos=
t stat args (Niels de Vos)
37867211d9: gluster: Handle changed glfs_ftruncate signature (Prasanna Kuma=
r Kalever)
43a3a1b694: hw/block/pflash_cfi01: Add missing DeviceReset() handler (Phili=
ppe Mathieu-Daud=C3=A9)
ddacb784b3: hw: Use PFLASH_CFI0{1,2} and TYPE_PFLASH_CFI0{1,2} (Markus Armb=
ruster)
03f130c682: pflash: Rename *CFI_PFLASH* to *PFLASH_CFI* (Markus Armbruster)
10b1d6070a: pflash_cfi01: Log use of flawed "write to buffer" (Markus Armbr=
uster)
e634054c9d: pflash_cfi01: Do not exit() on guest aborting "write to buffer"=
 (Markus Armbruster)
13cb31ce08: pflash: Rename pflash_t to PFlashCFI01, PFlashCFI02 (Markus Arm=
bruster)
d0cb440280: block/pflash_cfi02: Fix memory leak and potential use-after-fre=
e (Stephen Checkoway)
21e5c69b85: hw/display/xlnx_dp: Avoid crash when reading empty RX FIFO (Phi=
lippe Mathieu-Daud=C3=A9)
e2ec206ea9: hw/ssi/mss-spi: Avoid crash when reading empty RX FIFO (Philipp=
e Mathieu-Daud=C3=A9)
1f30e35861: hw/ssi/xilinx_spips: Avoid out-of-bound access to lqspi_buf[] (=
Philippe Mathieu-Daud=C3=A9)
19f55e7ab5: target/m68k: Fix a tcg_temp leak (Philippe Mathieu-Daud=C3=A9)
c6b77a64b4: virtio-balloon: free pbp more aggressively (Michael S. Tsirkin)
0965d5583e: virtio-balloon: don't track subpages for the PBP (David Hildenb=
rand)
14d9028a7d: virtio-balloon: Use temporary PBP only (David Hildenbrand)
2aa5009412: virtio-balloon: Rework pbp tracking data (David Hildenbrand)
46275f9091: virtio-balloon: Better names for offset variables in inflate/de=
flate code (David Hildenbrand)
b0d6feca99: virtio-balloon: Simplify deflate with pbp (David Hildenbrand)
07026c30c3: virtio-balloon: Fix QEMU crashes on pagesize > BALLOON_PAGE_SIZ=
E (David Hildenbrand)
11dd808dc0: virtio-balloon: Fix wrong sign extension of PFNs (David Hildenb=
rand)
f8364784f0: virtio-balloon: Restore MADV_WILLNEED hint on balloon deflate (=
David Gibson)
38e8e9007d: virtio-balloon: Fix possible guest memory corruption with infla=
tes & deflates (David Gibson)
80c96a7b60: virtio-balloon: Don't mismatch g_malloc()/free (CID 1399146) (D=
avid Gibson)
118112024d: virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page siz=
e (David Gibson)
83cddbaadf: virtio-balloon: Use ram_block_discard_range() instead of raw ma=
dvise() (David Gibson)
89b0e359bc: virtio-balloon: Rework ballon_page() interface (David Gibson)
b260cdec21: virtio-balloon: Corrections to address verification (David Gibs=
on)
7a31a0af31: virtio-balloon: Remove unnecessary MADV_WILLNEED on deflate (Da=
vid Gibson)
f0a334345b: hw/virtio/virtio-balloon: zero-initialize the virtio_balloon_co=
nfig struct (Peter Maydell)
fc6c2bce38: i386/acpi: show PCI Express bus on pxb-pcie expanders (Evgeny Y=
akovlev)
11665ca918: i386/acpi: fix gint overflow in crs_range_compare (Evgeny Yakov=
lev)
df42bc4897: ioapic: kvm: Skip route updates for masked pins (Jan Kiszka)
c00635946f: tpm_emulator: Translate TPM error codes to strings (Stefan Berg=
er)
51ce84e119: tpm: Exit in reset when backend indicates failure (Stefan Berge=
r)
0318166a9f: vhost: fix vhost_log size overflow during migration (Li Hangjin=
g)
261d7f653a: iotests: Test unaligned raw images with O_DIRECT (Max Reitz)
044b0bcedf: block/file-posix: Unaligned O_DIRECT block-status (Max Reitz)
1742e3c74e: iotests: Filter second BLOCK_JOB_ERROR from 229 (Max Reitz)
f173a43a6d: megasas: fix mapped frame size (Peter Lieven)
2157938f7b: s390x/cpumodel: ignore csske for expansion (Christian Borntraeg=
er)
f56e70ee4f: do not call vhost_net_cleanup() on running net from char user e=
vent (Dan Streetman)
8a5aaad6c2: block: Fix AioContext switch for bs->drv =3D=3D NULL (Kevin Wol=
f)
3c9e488dbe: cutils: Fix size_to_str() on 32-bit platforms (Eric Blake)
c627cc38be: qcow2: Avoid COW during metadata preallocation (Kevin Wolf)
b443db97c1: qemu-img: fix error reporting for -object (Daniel P. Berrang=C3=
=A9)
6b29db871d: usb-mtp: use O_NOFOLLOW and O_CLOEXEC. (Gerd Hoffmann)
6c77b5ab35: qga: update docs with systemd suspend support info (Daniel Henr=
ique Barboza)
11cd30e71a: mac_newworld: use node name instead of alias name for hd device=
 in FWPathProvider (Mark Cave-Ayland)
4a25ba2e2b: mac_oldworld: use node name instead of alias name for hd device=
 in FWPathProvider (Mark Cave-Ayland)
847fe10828: configure: improve usbfs check (Thomas Petazzoni)
f3a70a4ae1: qga-win: include glib when building VSS DLL (Michael Roth)
d7cae05bf5: json: Fix % handling when not interpolating (Christophe Fergeau)
d03c389511: i386: remove the 'INTEL_PT' CPUID bit from named CPU models (Pa=
olo Bonzini)
02d735c274: i386: remove the new CPUID 'PCONFIG' from Icelake-Server CPU mo=
del (Robert Hoo)
821314aec3: vfio-ap: flag as compatible with balloon (Cornelia Huck)
7c693f0c3f: tpm_tis: fix loop that cancels any seizure by a lower locality =
(Liam Merwick)
83cd9ed3d7: slirp: check sscanf result when emulating ident (William Bowlin=
g)
c6f25642e0: hw/rdma: another clang compilation fix (Marcel Apfelbaum)
27df37c1ea: block: Fix invalidate_cache error path for parent activation (K=
evin Wolf)
fe87edd5ed: tpm: Make sure the locality received from backend is valid (Ste=
fan Berger)
27b0c099fd: tpm: Make sure new locality passed to tpm_tis_prep_abort() is v=
alid (Stefan Berger)
00d0932e0b: exec.c: Don't reallocate IOMMUNotifiers that are in use (Peter =
Maydell)
2e5502300e: s390x: Return specification exception for unimplemented diag 30=
8 subcodes (Janosch Frank)
8ec7368c8f: linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0=
 (Peter Maydell)
85bfce130a: hw/s390x: Fix bad mask in time2tod() (Thomas Huth)
98cf1bb872: pc:piix4: Update smbus I/O space after a migration (Corey Minya=
rd)
5363028d1f: pcie: set link state inactive/active after hot unplug/plug (Zhe=
ng Xiang)
0d6b9ce17c: Changes requirement for "vsubsbs" instruction (Paul A. Clarke)
def04278d1: iotests: make 235 work on s390 (and others) (Christian Borntrae=
ger)
08c410e390: i2c: Move typedef of bitbang_i2c_interface to i2c.h (BALATON Zo=
ltan)


