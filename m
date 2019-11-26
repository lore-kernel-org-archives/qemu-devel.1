Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D07C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99B820722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99B820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZjaS-0006tq-Td
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 17:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iZjZD-0006Cy-Mz
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iZjZB-0007Qj-8n
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:44:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iZjZ9-0007OZ-CM
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:44:16 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAQMcDie104653; Tue, 26 Nov 2019 17:44:12 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2whcxpr8a6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Nov 2019 17:44:12 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAQMenbY003427;
 Tue, 26 Nov 2019 22:44:12 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03dal.us.ibm.com with ESMTP id 2wevd6q62a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Nov 2019 22:44:12 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAQMiAtd59703762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2019 22:44:10 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A11D6BE053;
 Tue, 26 Nov 2019 22:44:10 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ABC7BE04F;
 Tue, 26 Nov 2019 22:44:10 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 26 Nov 2019 22:44:10 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <157480824614.4193.78264727333377290@sif>
Subject: [ANNOUNCE] QEMU 4.2.0-rc3 is now available
Date: Tue, 26 Nov 2019 16:44:06 -0600
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_07:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911260192
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
fourth release candidate for the QEMU 4.2 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-4.2.0-rc3.tar.xz
  http://download.qemu-project.org/qemu-4.2.0-rc3.tar.xz.sig

A note from the maintainer:

  Unless any release-critical bugs are found in the next week, we
  will make the final 4.2.0 release on Tuesday 3rd December;
  otherwise we'll have an rc4 on the 3rd and make the final
  release the week after on the 10th.

You can help improve the quality of the QEMU 4.2 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/4.2

Please add entries to the ChangeLog for the 4.2 release below:

  http://wiki.qemu.org/ChangeLog/4.2

Thank you to everyone involved!

Changes since rc2:

1a61a081ac: Update version for v4.2.0-rc3 release (Peter Maydell)
6a4ef4e5d1: target/arm: Honor HCR_EL2.TID3 trapping requirements (Marc Zyng=
ier)
7cf95aed53: target/arm: Fix ISR_EL1 tracking when executing at EL2 (Marc Zy=
ngier)
f0138990ce: hw/arm: versal: Add the CRP as unimplemented (Edgar E. Iglesias)
f900b1e5b0: target/arm: Fix handling of cortex-m FTYPE flag in EXCRET (Jean=
-Hugues Desch=C3=AAnes)
d8130f4c42: iotests: add new test cases to bitmap migration (Vladimir Semen=
tsov-Ogievskiy)
a505475b95: block/qcow2-bitmap: fix bitmap migration (Vladimir Sementsov-Og=
ievskiy)
b3b9a433b0: tests/vm/ubuntu: update i386 image to 18.04 (Alex Benn=C3=A9e)
b4eca581b9: tests/vm/ubuntu: include language pack to silence locale warnin=
gs (Alex Benn=C3=A9e)
6cd7b60848: tests/vm/centos: fix centos build target (Alex Benn=C3=A9e)
e37aa8b0e4: hvf: more accurately match SDM when setting CR0 and PDPTE regis=
ters (Cameron Esfahani)
8c3b0e9e67: hvf: correctly handle REX prefix in relation to legacy prefixes=
 (Cameron Esfahani)
9fedbbeeee: hvf: remove TSC synchronization code because it isn't fully com=
plete (Cameron Esfahani)
fbafbb6db7: hvf: non-RAM, non-ROMD memory ranges are now correctly mapped i=
n (Cameron Esfahani)
c6f3215ffa: target/i386: add two missing VMX features for Skylake and Casca=
deLake Server (Paolo Bonzini)
59d0533b85: ppc/spapr_events: fix potential NULL pointer dereference in rta=
s_event_log_dequeue (PanNengyuan)
6cf80f90c4: mos6522: update counters when timer interrupts are off (Laurent=
 Vivier)
b14848f5d7: spapr: Work around spurious warnings from vfio INTx initializat=
ion (David Gibson)
e532e1d93c: spapr: Handle irq backend changes with VFIO PCI devices (David =
Gibson)
c5478fea27: vfio/pci: Respond to KVM irqchip change notifier (David Gibson)
ad54dbd89d: vfio/pci: Split vfio_intx_update() (David Gibson)
3607715a30: kvm: Introduce KVM irqchip change notifier (David Gibson)
454590916c: pseries: fix migration-test and pxe-test (Laurent Vivier)
e8d0ac5801: vmstate-static-checker: Fix for current python (Dr. David Alan =
Gilbert)
6478dd745d: hw/riscv: Add optional symbol callback ptr to riscv_load_kernel=
() (Zhuang, Siwei (Data61, Kensington NSW))
9c0fb20c4b: RISC-V: virt: This is a "sifive,test1" test finisher (Palmer Da=
bbelt)
4d0e59ace2: net/virtio: return error when device_opts arg is NULL (Jens Fre=
imann)
150ab54aa6: net/virtio: fix re-plugging of primary device (Jens Freimann)
117378bf03: net/virtio: return early when failover primary alread added (Je=
ns Freimann)
284f42a520: net/virtio: fix dev_unplug_pending (Jens Freimann)
d1e2670741: linux-user: fix translation of statx structures (Ariadne Conill)
e48929c787: intel_iommu: TM field should not be in reserved bits (Qi, Yadon=
g)
ce586f3b8d: intel_iommu: refine SL-PEs reserved fields checking (Qi, Yadong)
509ec36c1e: virtio-input: fix memory leak on unrealize (Marc-Andr=C3=A9 Lur=
eau)
25f74087c6: util/cutils: Fix incorrect integer->float conversion caught by =
clang (Fangrui Song)
68d654daee: 9pfs: Fix divide by zero bug (Dan Schatzberg)
02fa60d101: i386: Add -noTSX aliases for hle=3Doff, rtm=3Doff CPU models (E=
duardo Habkost)
9ab2237f19: i386: Add new versions of Skylake/Cascadelake/Icelake without T=
SX (Eduardo Habkost)
2a9758c51e: target/i386: add support for MSR_IA32_TSX_CTRL (Paolo Bonzini)
0723cc8a55: target/i386: add VMX features to named CPU models (Paolo Bonzin=
i)
c55c974486: ui/gtk: fix gettext message's charset. (yanminhui)
0f6ed883e7: display: xlnx_dp: Provide sufficient bytes for silent audio cha=
nnel (Sai Pavan Boddu)
22c30b2d20: tests/tcg: modify multiarch tests to work with clang (Taylor Si=
mpson)
6e98888041: .travis.yml: drop 32 bit systems from MAIN_SOFTMMU_TARGETS (Ale=
x Benn=C3=A9e)
5c6ecbdc83: docs/devel: update tcg-plugins.rst with API versioning details =
(Alex Benn=C3=A9e)
8ea6abf0d0: docs/devel: rename plugins.rst to tcg-plugins.rst (Alex Benn=C3=
=A9e)
bcc388df07: tests/vm: make --interactive (and therefore DEBUG=3D1) uncondit=
ional (Alex Benn=C3=A9e)
6c77aa909e: tests: acpi: always retain dumped ACPI tables in case of error =
(Igor Mammedov)
ec244b1739: vhost-user-input: use free(elem) instead of g_free(elem) (Stefa=
n Hajnoczi)
d9b3ade54e: libvhost-user: Zero memory allocated for VuVirtqInflightDesc (X=
ie Yongji)
7ffc90f3ae: audio: fix audio recording (Volker R=C3=BCmelin)


