Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E63EC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D754218BA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FswSmgoy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tQgiKK/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D754218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLXS-0007xt-9s
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55612)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0827dbf71=shinichiro.kawasaki@wdc.com>)
 id 1hjLVI-0006nZ-RA
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0827dbf71=shinichiro.kawasaki@wdc.com>)
 id 1hjLVG-0005DG-Jm
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:31:44 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <prvs=0827dbf71=shinichiro.kawasaki@wdc.com>)
 id 1hjLVF-00056U-PO
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562322702; x=1593858702;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=rlvjAuNKatGhHj/tapXFijDPqLaVQIdsQAiGzQozonU=;
 b=FswSmgoyikHu6Nsv66KbZgSiYDEHBR3byWEw7JLcI2j98Rp0VrGmGd6N
 5ikPMJYg37xczzXWcejeu7XyKMw4C8LAdzhUexCysxwjZ0F+znxbhS3B5
 7vKq9aVuzBYhB2J7QX06hTYRRdQ0KvA+RUufaGgThjm55XuW4G827h4/C
 ZZjitqyFoVdub/fH+xS73tUN+WoI0VGMCijY0nPnbZNiQLJNPmVDFMpx7
 XGOGlTBPze7RtWpPijJJ1jy74eytAmrOB7m7JW5oVPiug2IjglU/+yYlI
 augek3Fjh0HqHwIopVPafLK4fI/fyF0zAlvVnZTf1/ELyZojYsUz3T7et Q==;
IronPort-SDR: v5sOWMiAd2sOvcbQZEnCBKQi53wzS53O7UfHuJhpNLIN0zR/X5p4zYgGJ/qbnXCZ7IsUaII2Hs
 mAMciXryh03UHOzg1nuW+R8GaSyLnuzlw7PjFGXQmXqU7Qlkzq0PyMgcgyjcdjKSAsOKrC0mg6
 l6XbD2pl3TQsMsR+egn1G4hDonlKmVe5ExypOC5jTl17m+8IBCO07BfZsMn2WUZ+Hoq4HUj7KG
 uKqyNqNewsrrqWyCefN4m6mS0JXWhZ/xewd2fnBZCJgk009icBBV3kp8XEtgrD6SpIDgYI+ZT8
 hE0=
X-IronPort-AV: E=Sophos;i="5.63,454,1557158400"; d="scan'208";a="113909722"
Received: from mail-bn3nam01lp2056.outbound.protection.outlook.com (HELO
 NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.56])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2019 18:31:39 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwTqFM33uYDGUrLAnJYc3AsOvA6KqOxJUIju4gSK5gw=;
 b=tQgiKK/wvicUQJbises/4Xy1CgKIE2CG7RdB/gP20m3DfrFPkgxX1GFH7jSTEMMR6dNtWMmILmm7u8BgyKzspwxHVm1+nbe/F9b436mDTSE/RfKTo4FHv2JeVvGAarvQ7ItJca9AuG+WroQiCNp5l2x0HyEOS5Zi+het6P5m2Zc=
Received: from BN3PR04MB2257.namprd04.prod.outlook.com (10.166.73.148) by
 BN3PR04MB2369.namprd04.prod.outlook.com (10.167.2.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Fri, 5 Jul 2019 10:31:36 +0000
Received: from BN3PR04MB2257.namprd04.prod.outlook.com
 ([fe80::c03f:cac7:c1e9:d8e6]) by BN3PR04MB2257.namprd04.prod.outlook.com
 ([fe80::c03f:cac7:c1e9:d8e6%12]) with mapi id 15.20.2032.022; Fri, 5 Jul 2019
 10:31:36 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis
 <alistair23@gmail.com>
Thread-Topic: [PATCH v1 1/1] hw/scsi: Report errors and sense to guests
 through scsi-block
Thread-Index: AQHVLHFNTNaoeJK+R0uVGvml8Q5ogQ==
Date: Fri, 5 Jul 2019 10:31:36 +0000
Message-ID: <BN3PR04MB22577C778C58BC5E2C8DD61FEDF50@BN3PR04MB2257.namprd04.prod.outlook.com>
References: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
 <1bd3ffcd-3f91-ecb9-2315-da7125f1dcdd@redhat.com>
 <CAKmqyKPeo4XXVy3onoM4W14N5Nj7CFWX=JpDT-JQQRUPw5CQ3Q@mail.gmail.com>
 <4428dc80-9ace-3bb0-a497-e3d416199bfd@redhat.com>
 <CAKmqyKMRSJTMxZ5c-yyuownYF8vJLYrzr92cE4rkiTdP7tmUzg@mail.gmail.com>
 <CY1PR04MB22682B84C1ABA7FB10752465EDF90@CY1PR04MB2268.namprd04.prod.outlook.com>
 <79c9e21f-06b1-6255-97af-95c08b354c8a@redhat.com>
 <CY1PR04MB22683409CB203BF5042697FBEDF80@CY1PR04MB2268.namprd04.prod.outlook.com>
 <5a741004-fc88-f31a-2abf-70f4a9b0d5a9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86d0913a-124f-41a9-d33a-08d70133f557
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BN3PR04MB2369; 
x-ms-traffictypediagnostic: BN3PR04MB2369:
x-microsoft-antispam-prvs: <BN3PR04MB2369263F0C200468852D7658EDF50@BN3PR04MB2369.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(6436002)(99286004)(74316002)(316002)(102836004)(33656002)(53936002)(7696005)(110136005)(66066001)(55016002)(66946007)(66476007)(5660300002)(76116006)(26005)(6246003)(76176011)(186003)(53546011)(91956017)(73956011)(229853002)(478600001)(64756008)(66446008)(68736007)(66556008)(54906003)(52536014)(6506007)(9686003)(71200400001)(71190400001)(25786009)(3846002)(2906002)(44832011)(7736002)(14444005)(86362001)(305945005)(4326008)(256004)(6116002)(476003)(486006)(14454004)(8936002)(81156014)(446003)(81166006)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN3PR04MB2369;
 H:BN3PR04MB2257.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t6kaaeLrWmrV3OsdqfXcgAO5BjF1l9CyZjoH7FdiXYsXtEUWkDgxX0lxHIqh0XSwC53AxeakiJ1lygoNr+tfzo5AxGEP7zO78dRK2XO/SLnCpWAQ5wpiHqZJiW6r4xBQKBlOR7lxRiVgjPtwjhmAuOMJOBPXJ5RPvNjEJ1F1waU0h0AQwrpM/BwKDT/dFUJFHzUMSNn2nswD1OOS6rUGKJJArtTMLjmcGF9Vpx6QT3C5RzI0l/JHpPPpoO8E535ZoPHNrdt70ikjMKB8Fa9GOOzFvtt2ViVfJePUH+rQFtmP1abQ755ulqweA9boKfAGm9yvVmRimno0gkWNBg8WfFAzGPXhJPPicps0Prh5KGsqhzNX+vBia0oUEk1o6r6DnyCvgq+hriQPJsdsiFjkfbHK+1jwNIasHkYiuIOPcM8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d0913a-124f-41a9-d33a-08d70133f557
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 10:31:36.6228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shinichiro.kawasaki@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR04MB2369
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: Re: [Qemu-devel] [PATCH v1 1/1] hw/scsi: Report errors and sense to
 guests through scsi-block
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org
 Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/19 7:23 PM, Paolo Bonzini wrote:=0A=
> On 02/07/19 08:44, Shinichiro Kawasaki wrote:=0A=
>> On 7/1/19 8:56 PM, Paolo Bonzini wrote:=0A=
>>> On 01/07/19 12:14, Shinichiro Kawasaki wrote:=0A=
>>>> I observe four of them listed below in sense data,=0A=
>>>> when I ran basic operations to the zoned storage from the guest via sc=
si-block.=0A=
>>>>=0A=
>>>>        21h 04h: UNALIGNED WRITE COMMAND=0A=
>>>>        21h 05h: WRITE BOUNDARY VIOLATION=0A=
>>>>        21h 06h: ATTEMPT TO READ INVALID DATA=0A=
>>>>        55h 0Eh: INSUFFICIENT ZONE RESOURCES=0A=
>>>>=0A=
>>>> These ASCs can be reported for write or read commands due to unexpecte=
d zone=0A=
>>>> status or write pointer status. Reporting these ASCs to the guest, the=
 user=0A=
>>>> applications can handle them to manage zone/write pointer status, or h=
elp the=0A=
>>>> user application developers to understand the failure reason and fix b=
ugs.=0A=
>>>>=0A=
>>>> I took a look in scsi_sense_to_errno() and learned that ASCs are group=
ed in=0A=
>>>> errnos. To report the ASCs above to the guest, is it good to add them =
in EINVAL=0A=
>>>> group defined in scsi_sense_to_errno()? The ASCs are reported with sen=
se key=0A=
>>>> ILLEGAL_REQUEST or DATA_PROTECT, then I think it fits in the function.=
=0A=
>>>=0A=
>>> The grouping by errno is historical and pretty much broken.  It should=
=0A=
>>> be possible to change it to return just a bool.=0A=
>>=0A=
>> The errno grouping of scsi_sense_to_errno() is used not only by scsi-dis=
k but=0A=
>> also by block/iscsi for error reporting. Can we avoid errno grouping for=
 iscsi also?=0A=
> =0A=
> No, but we can do something like=0A=
> =0A=
>      if (scsi_sense_buf_is_guest_recoverable(r->req.sense,=0A=
> sizeof(r->req.sense))) {=0A=
>          /* These errors are handled by guest. */=0A=
>          sdc->update_sense(&r->req);=0A=
>          scsi_req_complete(&r->req, *r->status);=0A=
>          return true;=0A=
>      }=0A=
>      error =3D scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense)=
);=0A=
> =0A=
> This way there's generally no need to shoehorn ASC codes into errno.  I=
=0A=
> still have to test my changes, but I hope to send something within a=0A=
> couple of days.=0A=
=0A=
Thanks for sharing your thoughts. Now I understand your idea.=0A=
=0A=
I'm awaiting your patch. In case you want me to create the patch based on y=
our =0A=
idea, please let me know. I can afford some time next week to work on it.=
=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=

