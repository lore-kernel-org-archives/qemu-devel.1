Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513DCC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2552071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qWGeD8Jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2552071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD41C-00065t-30
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 07:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kD40T-0005b5-9X
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:59:17 -0400
Received: from mail-bn8nam12on2049.outbound.protection.outlook.com
 ([40.107.237.49]:63744 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kD40Q-0004A9-I7
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:59:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKDtpojrHdAztM4PbTW20zlA6ctBhK5R1jaIdL6GGHby3Udo+EDHgmjXxqXuZ93SgHooC3ey12oL9oMxyF0e9Vg9xqGQMJqh0qooimJ8DBDRlz/+cvrZf4/UZFE8SkAwvspxceHYvcBp6ggyCn944Gya+QWlA2mlCGcwIiwDikoQ75LYln3yv1IJPfTdMuQxd13YVOozVlYa6vIcmhYe0ur1k3Hewmb4j9rcZQw/MW8i1Xs3j8NDcUaV0C8im9U8Kt2igp94OEzeR86CW75sH5GNXN4YfzXoJBj33ddbE4vMbrCz/9e5GN1Y651Pe/08gCHZ4df61cbD8qXIx5brWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgN7XXW0DiTQePgrD8oQVSa31cjCs2HAek2h2lJbRRI=;
 b=CDBgR3VOBFDVxhfsd3TcILYr32xHezYbP45K9/V8uYvNFsOqVeXPqfMmf9oqyHP8/G5lT1HQcmoAsBgt8vPYX0pP7oefgGn917mJPRiUlkh2laGrgJ227OjzArl8a18pqyiAtMfVJq3GZ8NsekOaiIrsOTKOk854M30POUv7LUjVYDIxtbtm6F3TduMXRopQuO9uHT/5E5a1PPmpXjZVkLbDsBaLo5gERYmD8JUrCTO2xlfB4lUpaRk5wjfP2tmyb34qPKIKpdbcD2WtZj7jjjMrHicUyNLyYrDVDoMlIE6wzmN6nZKq0qQEu61yQrgB8JOuhJjuVL8mvO2U39BfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgN7XXW0DiTQePgrD8oQVSa31cjCs2HAek2h2lJbRRI=;
 b=qWGeD8Jzj9e36wOeDeUBzYMiuPA+O68Y9TkuNBME8AAhAVjvKP6j9egb0Ds9wRxTRM9Rtmq2KBigzc0jTOC+sVkP3RnGw9VD5zNAL5OLLRxm/zltGVVLewBCnSSaz72sx24U3i4JN5nM4/MwdNUQr/JwaQ+nSdlayI68GqH2Q28=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB4789.namprd02.prod.outlook.com (2603:10b6:a03:46::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 10:59:12 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 10:59:12 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH v4 7/7] Versal: Connect DWC3 controller with virt-versal
Thread-Topic: [PATCH v4 7/7] Versal: Connect DWC3 controller with virt-versal
Thread-Index: AQHWfW+XD9uymLUJu0WH/TIouROh76lR0W8AgAHRSZA=
Date: Tue, 1 Sep 2020 10:59:12 +0000
Message-ID: <BY5PR02MB6772DB240C020D41B2492274CA2E0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-8-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200831071258.pkjkqss76tiuc7i2@sirius.home.kraxel.org>
In-Reply-To: <20200831071258.pkjkqss76tiuc7i2@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [49.205.235.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5ba426a-d794-4b0f-2fcc-08d84e660f7d
x-ms-traffictypediagnostic: BYAPR02MB4789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB47893E7EA72F22DD25FBAFCDCA2E0@BYAPR02MB4789.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4VldD7YVOXqkVnuigwjSCquSIuhefiYqyiLVb69NHSWaCavdBL1rrYy7VURFDK/8NEcqv+QduJ+0ktBd4e/PmeO83oq+Ti3j2JsP28tpy1lStsv0l0SadOfprUBJyvwQo3SsjI6XXSqmAVuR/Dl/o+rIuVdK7PH7pSE7T8EyFKGNWty69d0F/bWB9L8OVYudY6MbdeEd/BIKVTHLvyQdrQ0LSnjvpM1/89keuwGzJG0cYz5Ewt1RJLEQcI2T6KHb06X7dw1+VCf9BPwkGj7OQOhsLmmc5ARDU3jjZwu6KKdYp2FOJpRyy8QmjzgrrH5jmlk8V377bKH8dd5bFOnq0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(396003)(39860400002)(346002)(376002)(5660300002)(83380400001)(186003)(26005)(53546011)(478600001)(6916009)(52536014)(6506007)(8676002)(8936002)(71200400001)(9686003)(7696005)(7416002)(33656002)(2906002)(66446008)(64756008)(66476007)(66556008)(66946007)(86362001)(54906003)(316002)(55016002)(76116006)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1Jvq49uc7k0h7NWFxxDQikevWEg/0r2ZPFYaiqgNWN7m86N9B+/E3mVkfHfmr54oSCu7RM1PXwEdOd4Dh+5QwFbUpuylB/RNuZ6VB+o7mh0vK+m5BLzmcjJp4g1uk/ob81vBGNVZpXbll1AM/QvJ2ZLfApkKpsz9vgRHm/vSUh48ETK0ZwyDLM7+EpCf8b07Q0T6hO6YBWcz4EODykrkSBgX0gljLBZ6wm3vAK4DunhqhF3WK+zOfNDEan4MIqZObEDZClT8bXQtHWSw5xjBp4UQNDJvIu+3KToc/lnPxHaxP4isi/KM7E+tPBItJ0SmOQQ8qYUpetpKd3YLybjvFc5guuK24gb0gWPr4AAcQacVwHuEsCbuwu1CCwYcMgAecy8Tym8+2Y8BCCaJ8tSEMCkI38r2ECzN8ovvTKxIVHqx1X/58uqOnG4xov/g2iycfHQ6idKYMUj4AvwL3kUOmoqPdSttbZ0Cmz4VxwCH3SeIiIGT5SUXCKhgYog0Hs/n7vNnSNUQVZszH4I/dVBmspj12rT3UvyIrzgJD3I3wLDDxsjGmfyHGYNnTB0D1wvQh4shacoYnqwuDmBfUVthLLNofrij3KpKxvjfCCZpls1xyU3BRKctmjJCidGGLUD8BZtbHPtENQQT+/WXXZ8fLA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ba426a-d794-4b0f-2fcc-08d84e660f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 10:59:12.5223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //+pOozZEQvSqs5h/rrYD7Ar0v86ZQ6eu53OGVaxDrk28WEwMbb1i8x81xZ5mTRXoCmr+O6Mx8SH1eG127q/OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4789
Received-SPF: pass client-ip=40.107.237.49; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 06:02:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?iso-8859-1?Q?=27Marc-Andr=E9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gred,

> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Monday, August 31, 2020 12:43 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Markus Armbruster
> <armbru@redhat.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Edgar Iglesias <edgari@xilinx.com>; Francisco Eduardo Iglesias
> <figlesia@xilinx.com>; qemu-devel@nongnu.org; Alistair Francis
> <alistair.francis@wdc.com>; Eduardo Habkost <ehabkost@redhat.com>;
> Ying Fang <fangying1@huawei.com>; 'Philippe Mathieu-Daud=E9'
> <philmd@redhat.com>; Vikram Garhwal <fnuv@xilinx.com>; Paul
> Zimmerman <pauldzim@gmail.com>
> Subject: Re: [PATCH v4 7/7] Versal: Connect DWC3 controller with virt-ver=
sal
>=20
>   Hi,
>=20
> > +        unsigned int irq =3D VERSAL_USB0_IRQ_0;
> > +        const char intName[] =3D "dwc_usb3";
> > +        qemu_fdt_setprop(s->fdt, name, "interrupt-names",
> > +                         intName, sizeof(intName));
> > +        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> > +                                   GIC_FDT_IRQ_TYPE_SPI, irq,
> > +                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>=20
> This seems to declare one IRQ in the FDT.
>=20
> > +    qdev_prop_set_uint32(xhci_dev, "intrs", 4);
>=20
> Here you configure 4 IRQs for xhci-sysbus.
>=20
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(xhci_dev), 0,
> > + pic[VERSAL_USB0_IRQ_0]);
>=20
> Also a single IRQ only.
>=20
> I'm wondering which is correct?  Probably one IRQ?  Do we need support fo=
r
> multiple IRQs in xhci-sysbus in the first place?
[Sai Pavan Boddu] It should be only one, as others seems to be define for d=
evice and OTG modes. I would fix this=20

Thanks,
Sai Pavan
>=20
> take care,
>   Gerd


