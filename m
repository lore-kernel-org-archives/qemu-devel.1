Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7492C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0DE20692
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0DE20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MHs-0002te-Oi
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i8MDt-0007O6-1S
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i8MDr-000837-7H
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:21:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i8MDq-00082o-VZ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:21:07 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8CAHTfN088018
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 06:21:05 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uyk7mtcb4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 06:21:05 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Thu, 12 Sep 2019 11:21:03 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Sep 2019 11:21:00 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8CAKxQP30474472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2019 10:20:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9625B42041;
 Thu, 12 Sep 2019 10:20:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34B964204B;
 Thu, 12 Sep 2019 10:20:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.221])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 12 Sep 2019 10:20:58 +0000 (GMT)
Date: Thu, 12 Sep 2019 15:50:55 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
References: <20190912093056.4516-1-bala24@linux.ibm.com>
 <b27c56a5-1401-09f3-4d5d-9ff4843c8f26@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b27c56a5-1401-09f3-4d5d-9ff4843c8f26@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19091210-0008-0000-0000-00000314BDD4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091210-0009-0000-0000-00004A332CC9
Message-Id: <20190912102055.GA3964@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-12_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909120109
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x8CAHTfN088018
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v3 0/4] add Homer/OCC common area emulation
 for PowerNV
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
Cc: maddy@linux.vnet.ibm.com, groug@kaod.org, qemu-devel@nongnu.org,
 anju@linux.vnet.ibm.com, qemu-ppc@nongnu.org, hari@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 12, 2019 at 11:54:00AM +0200, C=E9dric Le Goater wrote:
> On 12/09/2019 11:30, Balamuruhan S wrote:
> > Hi All,
> >=20
> > This is follow-up patch that implements HOMER and OCC SRAM device
> > models to emulate homer memory and occ common area access for pstate
> > table, occ sensors, runtime data and slw.
>=20
> So, now, we can write directly to the OCC SRAM memory region from the

I think you are referring to the other part of RFC where we can feed/
write data dynamically to the memory region with Qemu monitor interface
that you have suggested to adopt instead of python API interface. I
am working with Hariharan to enable it and I would need some time for
it.

> QEMU monitor. How will skiboot pick up the changes ? =20

with current changes, we do create device tree with the base address of
Homer and OCC region and skiboot picks up, initializes it during PowerNV
emulated host boots up and tries to start dereferring the pstate table,
occ sensor data, runtime data etc., with offsets for which we have define=
d
in Qemu and Qemu returns some default value so that skiboot doesn't
invalidate/error it. Additionally once we get this patchset merged we sho=
uld
get the skiboot patches in for enabling the code path of homer/occ if
skiboot detects Qemu. For reference we can see below boot log of Qemu
emulated PowerNV host,

[    0.029304612,5] OPAL 165b3829-root-dirty-d7b62c6 starting...
[    0.030088822,7] initial console log level: memory 7, driver 5
[    0.030147011,6] CPU: P9 generation processor (max 4 threads/core)
[    0.030178089,7] CPU: Boot CPU PIR is 0x0000 PVR is 0x004e1200
[    0.030367773,7] OPAL table: 0x30106930 .. 0x30106ea0, branch table: 0=
x30002000
[    0.030639657,7] Assigning physical memory map table for nimbus
[    0.030954762,7] FDT: Parsing fdt @0x1000000
[    0.034344285,5] CHIP: Detected Qemu simulator
[    0.034586944,6] CHIP: Initialised chip 0 from xscom@603fc00000000
[    0.035083506,6] P9 DD2.00 detected
[    0.035109773,5] CHIP: Chip ID 0000 type: P9N DD2.00
[    0.035126551,7] XSCOM: Base address: 0x603fc00000000
[    0.035161363,7] XSTOP: ibm,sw-checkstop-fir prop not found
[    0.035274093,6] MFSI 0:0: Initialized
[    0.035291808,6] MFSI 0:2: Initialized
[    0.035308832,6] MFSI 0:1: Initialized
[    0.036009709,6] LPC: LPC[000]: Initialized
[    0.036024631,7] LPC: access via MMIO @0x6030000000000
[    0.036075678,7] LPC: Default bus on chip 0x0
[    0.036201881,7] CPU: New max PIR set to 0x3
[    0.036901816,7] MEM: parsing reserved memory from reserved-names/-ran=
ges properties
[    0.037012392,7] HOMER: Init chip 0
[    0.037060772,7]   PBA BAR0 : 0x0000203ffd800000
[    0.037076462,7]   PBA MASK0: 0x0000000000300000
[    0.037121097,7]   HOMER Image at 0x203ffd800000 size 4MB
[    0.037192576,4] HOMER image is not reserved! Reserving
[    0.037269907,7]   PBA BAR2 : 0x0000203fff800000
[    0.037280977,7]   PBA MASK2: 0x0000000000700000
[    0.037301135,7]   OCC Common Area at 0x203fff800000 size 8MB
[    0.037351959,4] OCC common area is not reserved! Reserving
:::
:::
[    0.109004331,5] OCC: All Chip Rdy after 0 ms
:::
:::
[    0.297195] cpuidle: using governor menu
:::
:::
[    0.337736] cpuidle-powernv: Default stop: psscr =3D 0x000000000000033=
0,mask=3D0x00000000003003ff
[    0.338393] cpuidle-powernv: Deepest stop: psscr =3D 0x000000000030033=
1,mask=3D0x00000000003003ff
[    0.339000] cpuidle-powernv: Requested Level (RL) value of first deep =
stop =3D 0xf
:::
:::
[    1.617017] powernv-cpufreq: cpufreq pstate min 0x2 nominal 0x1 max 0x=
0
[    1.617523] powernv-cpufreq: Workload Optimized Frequency is enabled i=
n the platform
[    1.620734] freq_table: Duplicate freq-table entries: 3000
[    1.622298] powernv-cpufreq: Failed to register the cpufreq driver (-1=
9)
[    1.623088] powernv-cpufreq: Platform driver disabled. System does not=
 support PState control
:::
:::

-- Bala
>=20
>=20
> C.
>=20
> >=20
> > Currently skiboot disables the homer/occ code path with `QUIRK_NO_PBA=
`,
> > this quirk have to be removed in skiboot for it to use HOMER and OCC
> > SRAM device models along with a bug fix,
> >=20
> > https://github.com/balamuruhans/skiboot/commit/a655514d2a730e0372a2fa=
ee277d1cf01f71a524
> > https://github.com/balamuruhans/skiboot/commit/fd3d93d92ec66a7494346d=
6d24ced7b48264c9a0
> >=20
> > This version fixes a review comment from Cedric in previous version,
> >=20
> > changes in v3:
> >     * pass on PnvHomer *homer directly to core_max_array() function
> >       from the caller.
> >=20
> > v2 patchset:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg02231.html
> >=20
> > changes in v2:
> >     * change to PnvHomer/PnvHomerClass instead of PnvHOMER/PnvHOMERCl=
ass
> >       for better code readabililty.
> >     * fabric link to chip to use `nr_cores` from PnvChip struct for
> >       core_max_array() as we need to consider active cores in chip an=
d not
> >       whole machine.
> >     * declare variable well ahead instead in for() loop syntax to mak=
e
> >       all compilers happy.
> >     * change to shorter variable name to `hmrc` instead of `homer_cla=
ss`.
> >     * remove `homer_` prefix for regs as it is not useful.
> >     * have separate commit for checkpatch.pl coding style warnings.
> >=20
> > v1 patchset:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01610.html
> >=20
> > changes in v1:
> >     * breaks it to have separate patch series for Homer and OCC
> >       emulation.
> >     * reuse PnvOCC device model to implement SRAM device.
> >     * implement PnvHomer as separate device model.
> >     * have core max base address as part of PnvHOMERClass.
> >     * reuse PNV_CHIP_INDEX() instead of introducing new `chip_num`.
> >     * define all the memory ops access address as macros.
> >     * few coding style warnings given by checkpatch.pl.
> >=20
> > rfc patchset:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg00979.html
> >=20
> > I request for review, comments and suggestions for the changes.
> >=20
> > Balamuruhan S (4):
> >   hw/ppc/pnv_xscom: retrieve homer/occ base address from PBA BARs
> >   hw/ppc/pnv_occ: add sram device model for occ common area
> >   hw/ppc/pnv_homer: add PowerNV homer device model
> >   hw/ppc/pnv: fix checkpatch.pl coding style warnings
> >=20
> >  hw/ppc/Makefile.objs       |   1 +
> >  hw/ppc/pnv.c               |  87 ++++++++++++---
> >  hw/ppc/pnv_homer.c         | 272 +++++++++++++++++++++++++++++++++++=
++++++++++
> >  hw/ppc/pnv_occ.c           |  78 +++++++++++++
> >  hw/ppc/pnv_xscom.c         |  34 +++++-
> >  include/hw/ppc/pnv.h       |  21 ++++
> >  include/hw/ppc/pnv_homer.h |  53 +++++++++
> >  include/hw/ppc/pnv_occ.h   |   3 +
> >  8 files changed, 528 insertions(+), 21 deletions(-)
> >  create mode 100644 hw/ppc/pnv_homer.c
> >  create mode 100644 include/hw/ppc/pnv_homer.h
> >=20
>=20


