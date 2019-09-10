Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515FDC4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2383D208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2383D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hKh-0003rC-8i
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i7hJm-0002tI-UV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i7hJl-00033w-Ma
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:40:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i7hJl-00033Z-Fb
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:40:29 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8AEU5hL038928
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 10:40:28 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uxcwp2gye-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 10:40:26 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Tue, 10 Sep 2019 15:40:23 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Sep 2019 15:40:19 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8AEeI3D54198410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2019 14:40:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46E07A4069;
 Tue, 10 Sep 2019 14:40:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9407A4062;
 Tue, 10 Sep 2019 14:40:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.221])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 10 Sep 2019 14:40:16 +0000 (GMT)
Date: Tue, 10 Sep 2019 20:10:14 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
References: <20190910071019.16689-1-bala24@linux.ibm.com>
 <0a76efcd-127c-75a4-8fc8-92007ccec1a5@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0a76efcd-127c-75a4-8fc8-92007ccec1a5@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19091014-0012-0000-0000-000003498A7E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091014-0013-0000-0000-00002183EF97
Message-Id: <20190910144014.GA25854@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-10_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100141
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x8AEU5hL038928
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v1 0/3] add Homer/OCC common area emulation
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
Cc: maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, groug@kaod.org,
 qemu-devel@nongnu.org, hari@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 01:45:55PM +0200, C=E9dric Le Goater wrote:
> On 10/09/2019 09:10, Balamuruhan S wrote:
> > Hi All,
> >=20
> > This is follow-up patch that implements HOMER and OCC SRAM device
> > models to emulate homer memory and occ common area access for pstate
> > table, occ sensors, runtime data and slw.
> >=20
> > This version addresses review comments in previous patchset and
> > breaks it to have separate patch series for Homer and OCC emulation,
> >=20
> > https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg00979.html
> >=20
> > currently skiboot disables the homer/occ code path with `QUIRK_NO_PBA=
`,
> > this quirk have to be removed in skiboot for it to use HOMER and OCC
> > SRAM device models along with few bug fixes,
> >=20
> > https://github.com/balamuruhans/skiboot/commit/a655514d2a730e0372a2fa=
ee277d1cf01f71a524
> > https://github.com/balamuruhans/skiboot/commit/fd3d93d92ec66a7494346d=
6d24ced7b48264c9a0
>=20
> Can't we generate the sensors in QEMU ? I am not sure what this
> patch does. Is the Header Block invalid ?=20

This doesn't directly affect Qemu, this is skiboot bug where it
creates device tree node for sensor-groups and does sensor
sanity check to initialize, but in negative scenario where there
is no sensors like in Qemu the sanity check fails but still device
tree populates the sensor-groups node wrongly. The cleanup is not
handled in skiboot and this patch does that.

>=20
> It would be good to generate properties to control their values=20
> on the monitor line, like Rashmica did for GPIO model in the=20
> Aspeed machine.

>=20
> > https://github.com/balamuruhans/skiboot/commit/165b3829a93bc177c18133=
945a8cca3a2d701173
>=20
> This one is weird .

I did a miss here, in skiboot there is check whether parsed pstate id
for pmin and pmax is valid or not. In this check, pmax to pmin for P8
it is 0 to -N and for P9 0 to N. But in Qemu for the MemoryRegionOps
structure read() callback function can have only uint64_t as return
type, so for P8 I got error from skiboot as we return postive value
and misunderstood to make this skiboot change. Cedric how can we handle
this from Qemu ?

Thanks for review,

-- Bala

>=20
> C.=20
>=20
> >=20
> > changes from v1:
> >     * reuse PnvOCC device model to implement SRAM device.
> >     * implement PnvHomer as separate device model.
> >     * have core max base address as part of PnvHOMERClass.
> >     * reuse PNV_CHIP_INDEX() instead of introducing new `chip_num`.
> >     * define all the memory ops access address as macros.
> >     * few coding style warnings given by checkpatch.pl.
> >=20
> > I request for review, comments and suggestions for the changes.
> >=20
> > Balamuruhan S (3):
> >   hw/ppc/pnv_xscom: retrieve homer/occ base address from PBA BARs
> >   hw/ppc/pnv_occ: add sram device model for occ common area
> >   hw/ppc/pnv_homer: add PowerNV homer device model
> >=20
> >  hw/ppc/Makefile.objs       |   1 +
> >  hw/ppc/pnv.c               |  87 ++++++++++++---
> >  hw/ppc/pnv_homer.c         | 258 +++++++++++++++++++++++++++++++++++=
++++++++++
> >  hw/ppc/pnv_occ.c           |  78 ++++++++++++++
> >  hw/ppc/pnv_xscom.c         |  34 +++++-
> >  include/hw/ppc/pnv.h       |  21 ++++
> >  include/hw/ppc/pnv_homer.h |  52 +++++++++
> >  include/hw/ppc/pnv_occ.h   |   3 +
> >  8 files changed, 513 insertions(+), 21 deletions(-)
> >  create mode 100644 hw/ppc/pnv_homer.c
> >  create mode 100644 include/hw/ppc/pnv_homer.h
> >=20
>=20


