Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB50C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA72218FD
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA72218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIzz-0007dO-GU
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41624)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hvIzW-0006tN-0t
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hvIzU-00055I-CT
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:16:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50434
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hvIzU-00054X-7G
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:16:20 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x77ACPRf011866
 for <qemu-devel@nongnu.org>; Wed, 7 Aug 2019 06:16:19 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2u7v58hnp0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 06:16:18 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Wed, 7 Aug 2019 11:16:17 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 7 Aug 2019 11:16:14 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x77AGDpr47841286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Aug 2019 10:16:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7DEA42045;
 Wed,  7 Aug 2019 10:16:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C41042041;
 Wed,  7 Aug 2019 10:16:12 +0000 (GMT)
Received: from dhcp-9-109-247-185.in.ibm.com (unknown [9.124.35.43])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Aug 2019 10:16:12 +0000 (GMT)
Date: Wed, 7 Aug 2019 15:46:10 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <9cbb8079-d606-ab69-a5b3-93226888108a@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9cbb8079-d606-ab69-a5b3-93226888108a@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19080710-0012-0000-0000-0000033AE64C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080710-0013-0000-0000-00002174A306
Message-Id: <20190807101610.GC10532@dhcp-9-109-247-185.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-07_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070112
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x77ACPRf011866
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Enhancing Qemu MMIO emulation with
 scripting interface
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
Cc: hari@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 maddy@linux.vnet.ibm.com, pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 07, 2019 at 10:15:48AM +0200, C=E9dric Le Goater wrote:
> On 07/08/2019 09:14, Balamuruhan S wrote:
> > Hi All,
> >=20
> > This is a proposal to extend mmio callbacks in Qemu with scripting in=
terface
> > that is prototyped with python in this implementation. It gives abili=
ty to
> > feed runtime data through callbacks without recompiling Qemu in gener=
ic way.
> > This patchset adds library that provides APIs for Qemu to talk with p=
ython
> > scripts placed in path -module-path and how existing xscom can be ext=
ended
> > with python interface infrastructure.
> >=20
> > We have also added an hacky emulation for memory region (OCC common a=
rea and HOMER)
> > which is shared between core and un-core engine (ideally this should =
be via
> > sram device) to showcase the effectiveness of having the scripting in=
terface
> > (uncore engine taken for discussion here is powerpc specificed called=
 OCC).
>=20
> We should try to merge this part first. It is useful as it is after som=
e
> cleanups.

okay :+1:

>=20
> > Having scripting interface helps to emulate/test different uncore-cor=
e
> > interactions including uncore engine failure or hang. It also helps i=
n feeding
> > randomized data at byte level access. This patchset is primarily to e=
xtend mmio
> > callbacks with scripting interface and to demonstrate effectiveness i=
t.
>=20
> It is already possible to feed device models with external data using Q=
MP or
> external agents using a chardev backend transport. What are the benefit=
s
> of using the embedded python approach ? =20
>=20
> > Some changes are required in PowerPC skiboot tree to test these chang=
es since
> > the memory region is disabled currently for Qemu emulated PowerNV hos=
t,
> > https://github.com/balamuruhans/skiboot/commit/a655514d2a730e0372a2fa=
ee277d1cf01f71a524
>=20
> You should send that patch.

okay, I will send it.

Thank you Cedric for your review and suggestions.

-- Bala
>=20
> Thanks,
>=20
> C.=20
>=20
> > Qemu commandline used to test,
> >=20
> > ```
> > # qemu/ppc64-softmmu/qemu-system-ppc64 \
> > -M powernv \
> > -cpu POWER9 \
> > -m 16G \
> > -kernel vmlinux \
> > -initrd debug_homer.cpio \
> > -nographic -bios skiboot/skiboot.lid \
> > -module-path /home/bala/homer/python-modules/,xscom_module=3Dhomer,xs=
com_read=3Dxscom_read,xscom_write=3Dxscom_write,homer_module=3Dhomer,home=
r=3Dhomer_read,occ_module=3Dhomer,occ=3Docc_read
> > ```
> >=20
> > Script used to feed data can be something like,
> > https://github.com/balamuruhans/python-modules/blob/master/script.py
> >=20
> > It could uncover couple of firmware bugs,
> > https://github.com/balamuruhans/skiboot/commit/fd3d93d92ec66a7494346d=
6d24ced7b48264c9a0
> > https://github.com/balamuruhans/skiboot/commit/165b3829a93bc177c18133=
945a8cca3a2d701173
> >=20
> > Code changes:
> > Patch 1: adds library to provide python interface APIs
> > Patch 2: extend existing xscom to adopt this python interface
> > Patch 3 - 6: emulate uncore/core shared memory region with mmio callb=
acks and
> > add support with this infrastructure.
> >=20
> > I request for comments, suggestions, ideas on getting a scripting int=
erface
> > like python added in qemu.
> >=20
> > Balamuruhan S (6):
> >   utils/python_api: add scripting interface for Qemu with python lib
> >   hw/ppc/pnv_xscom: extend xscom to use python interface
> >   hw/ppc/pnv_homer: add homer/occ common area emulation for PowerNV
> >   hw/ppc/pnv: initialize and realize homer/occ common area
> >   hw/ppc/pnv_xscom: retrieve homer/occ base address from PBA BARs
> >   hw/ppc/pnv_homer: add python interface support for homer/occ common
> >     area
> >=20
> >  configure                   |  10 +++
> >  hw/ppc/Makefile.objs        |   2 +-
> >  hw/ppc/pnv.c                |  49 ++++++++++-
> >  hw/ppc/pnv_homer.c          | 205 ++++++++++++++++++++++++++++++++++=
++++++++++
> >  hw/ppc/pnv_xscom.c          |  59 +++++++++++--
> >  include/hw/ppc/pnv.h        |  15 ++++
> >  include/hw/ppc/pnv_homer.h  |  41 +++++++++
> >  include/sysemu/python_api.h |  30 +++++++
> >  include/sysemu/sysemu.h     |   8 ++
> >  qemu-options.hx             |  14 +++
> >  util/Makefile.objs          |   1 +
> >  util/python_api.c           | 100 +++++++++++++++++++++
> >  vl.c                        |  66 ++++++++++++++
> >  13 files changed, 588 insertions(+), 12 deletions(-)
> >  create mode 100644 hw/ppc/pnv_homer.c
> >  create mode 100644 include/hw/ppc/pnv_homer.h
> >  create mode 100644 include/sysemu/python_api.h
> >  create mode 100644 util/python_api.c
> >=20
>=20


