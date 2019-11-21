Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FF0C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C53B2071C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C53B2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXiVv-0001m5-Cv
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 04:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iXiVI-0001EM-LF
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iXiVH-00089Z-Ag
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:11:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iXiVH-00089B-63
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:11:55 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAL8wArp061824
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:11:54 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wact98g3j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:11:53 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Thu, 21 Nov 2019 09:11:30 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Nov 2019 09:11:28 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAL9AnXt44040702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2019 09:10:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0ECB84203F;
 Thu, 21 Nov 2019 09:11:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C368742041;
 Thu, 21 Nov 2019 09:11:25 +0000 (GMT)
Received: from dhcp-9-120-236-104.in.ibm.com (unknown [9.120.236.104])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 21 Nov 2019 09:11:25 +0000 (GMT)
Date: Thu, 21 Nov 2019 14:41:23 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 0/5] ppc/pnv: fix Homer/Occ mappings on multichip systems
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <779f2a3b-62d2-62e9-674c-b2b53bf26da0@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <779f2a3b-62d2-62e9-674c-b2b53bf26da0@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19112109-4275-0000-0000-00000384541C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112109-4276-0000-0000-00003897D09B
Message-Id: <20191121091123.GG14854@dhcp-9-120-236-104.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_01:2019-11-20,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 suspectscore=3
 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911210080
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xAL8wArp061824
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 08:46:30AM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> On 19/11/2019 18:50, Balamuruhan S wrote:
> > Hi All,
> >=20
> > PowerNV fails to boot in multichip systems due to some misinterpretat=
ion
> > and mapping in Homer/Occ device models, this patchset fixes the
> > following,
> >=20
> >  - Homer size is 4MB per chip and Occ common area size is 8MB
> >  - Bar masks are used to calculate sizes of Homer/Occ in skiboot so
> >    return appropriate value
> >  - Occ common area is in BAR 3 on Power8 but wrongly mapped to BAR 2
> >    currently
> >  - OCC common area is shared across chips and should be mapped only o=
nce
> >    for multichip systems
>=20
> The first thing to address is the HOMER XSCOM region.=20
>=20
> Introduce an empty skeleton for P8 and P9 with different mem ops hander=
s
> because the registers have a different layout. From there, add the supp=
ort
> for the different PBA* regs and move them out from the default XSCOM
> handlers. That should fix most of the current problems and it will prov=
ide=20
> a nice framework for future extensions.

sure, I will work on it.

>=20
> Why not add the associated HOMER MMIO region while we are it ? the PBA
> registers have all the definitions we need and it will gives us access
> to the pstate table.

so, idea is to have HOMER MMIO for us to use it accessing pstate table / =
data
and HOMER XSCOM for homer associated xscom access for PBA* registers to
P8 and P9 respectively.

>=20
>=20
> Second is the OCC region. Do we need a XSCOM *or* a MMIO region ? This =
is=20
> not clear. Please check skiboot. I think a MMIO region should be enough
> because this is how sensor data from the OCC is accessed.

Okay, I will do the change for OCC to use MMIO, and will check skiboot
for making it better.

>=20
> On that topic, we could define properties on the PnvOCC model for each=20
> sensor and tune the value from the QEMU monitor. It really shouldn't be
> too complex.

How can we tune value from QEMU monitor ? This is new to me and will
need to check it. I remember you have advised this with the error
injection framework patches and Rashmica's patch that provides way to
use Qemu monitor to feed data, but I need to do some study.

>=20
> Also the same address is used, we should only map it once but we need=20
> to invent something to know from which chip it is accessed.

This is something need to check how real hardware handles it while
accessing shared occ region from different chip and think how to make it
for us.

Thanks a lot!

-- Bala

>=20
>=20
> C.
>=20
>=20
> >=20
> > Request for your review and suggestions to make it better. I would li=
ke to
> > thank Cedric for his time and help to figure out the issues.
> >
> > Balamuruhan S (5):
> >   hw/ppc/pnv: incorrect homer and occ common area size
> >   hw/ppc/pnv_xscom: PBA bar mask values are incorrect with homer/occ
> >     sizes
> >   hw/ppc/pnv_xscom: Power8 occ common area is in PBA BAR 3
> >   hw/ppc/pnv_xscom: occ common area to be mapped only once
> >   hw/ppc/pnv_xscom: add PBA BARs for Power8 slw image
> >=20
> >  hw/ppc/pnv_occ.c     |  2 +-
> >  hw/ppc/pnv_xscom.c   | 37 +++++++++++++++++++++++++++----------
> >  include/hw/ppc/pnv.h | 12 ++++++++----
> >  3 files changed, 36 insertions(+), 15 deletions(-)
> >=20
>=20


