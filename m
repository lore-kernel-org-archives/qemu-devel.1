Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734CBC49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B0920863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B0920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hgi-0007zL-LH
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i7hYL-0000cG-BJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i7hYK-00021G-2a
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:55:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i7hYJ-00020h-RD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:55:32 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8AEqkFd043089
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 10:55:30 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uxbyym1tc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 10:55:29 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Tue, 10 Sep 2019 15:55:25 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Sep 2019 15:55:21 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8AEtKCB48562240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2019 14:55:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B467642042;
 Tue, 10 Sep 2019 14:55:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5333C42041;
 Tue, 10 Sep 2019 14:55:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.221])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 10 Sep 2019 14:55:19 +0000 (GMT)
Date: Tue, 10 Sep 2019 20:25:17 +0530
From: Balamuruhan S <bala24@linux.ibm.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
References: <20190910071019.16689-1-bala24@linux.ibm.com>
 <20190910071019.16689-4-bala24@linux.ibm.com>
 <5aace97f-5a34-7e05-9cdc-65e17613033e@kaod.org>
 <20190910103054.GB16391@localhost.localdomain>
 <f0a5499f-4a76-85b8-db74-0c83a0587974@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f0a5499f-4a76-85b8-db74-0c83a0587974@kaod.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-TM-AS-GCONF: 00
x-cbid: 19091014-0008-0000-0000-00000313E9F1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091014-0009-0000-0000-00004A32525B
Message-Id: <20190910145517.GB25854@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-10_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100144
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x8AEqkFd043089
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v1 3/3] hw/ppc/pnv_homer: add PowerNV homer
 device model
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

On Tue, Sep 10, 2019 at 01:00:54PM +0200, C=E9dric Le Goater wrote:
> >>> +
> >>> +    object_initialize_child(obj, "homer",  &chip9->homer, sizeof(c=
hip9->homer),
> >>> +                            TYPE_PNV9_HOMER, &error_abort, NULL);
> >>> +    object_property_add_const_link(OBJECT(&chip9->homer), "chip", =
obj,
> >>> +                                   &error_abort);
> >>
> >> Does HOMER need the chip ? It is not used but we might want to in th=
e=20
> >> core_max_array() ?=20
> >=20
> > sorry, no it is not required, I will remove it.
>=20
> It seems you will need the chip in core_max_array(). I would keep it.=20
> See below,

Thanks Cedric, I was not aware of how to use it,

>=20
> [ ... ]=20
>=20
> >>> +static bool core_max_array(void *opaque, hwaddr addr)
>=20
> Please change the 'void *opaque' function parameter in 'PnvHOMER *homer=
'
>=20
> >>> +{
> >>> +    PnvHOMER *homer =3D PNV_HOMER(opaque);
> >>> +    PnvHOMERClass *homer_class =3D PNV_HOMER_GET_CLASS(homer);
> >>> +
> >>> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> >>
> >> Do you need the whole machine or only the chip ? =20
> >=20
> > yes, I see it is for active cores in the chip, I can use `nr_cores`
> > defined in PnvChip.
>=20
>=20
> If you keep the QOM link above, you can grab it in the realize handler =
of
> the HOMER model with : =20
>=20
>     Object *obj;
>     Error *local_err =3D NULL;
>=20
>     obj =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
>     if (!obj) {
>         error_propagate(errp, local_err);
>         error_prepend(errp, "required link 'chip' not found: ");
>         return;
>     }
>=20
>     homer->chip =3D PNV_CHIP(obj);

sure, :+1:

>=20
> [ ... ]=20
>=20
> >>> +
> >>> +/* P9 Pstate table */
> >>> +
> >>
> >> no version ?=20
> >=20
> > PNV9_OCC_PSTATE_MAJOR_VERSION is the P9 pstate version.
>=20
> why isn't it in the switch statement below ?=20

it is there in the switch statement,

::
+    case PNV9_OCC_PSTATE_MAJOR_VERSION:
+        return 0x90;
::

>=20
> [ ... ]=20
> =20
> >>> +typedef struct PnvHOMER {
> >>> +    DeviceState parent;
> >>> +
> >>> +    MemoryRegion homer_regs;
> >>
> >> the homer_ prefix is not useful.
> >=20
> > okay, I will change it to `hregs`.
>=20
> I would just remove the prefix

will make the change as suggested by removing the prefix.

-- Bala

>=20
> Thanks,
>=20
> C.=20
>=20


