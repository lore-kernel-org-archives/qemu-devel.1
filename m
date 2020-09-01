Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7F5C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 07:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95949206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 07:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kC3v4Epf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95949206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD0qX-0002Wd-Ow
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 03:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kD0py-000256-Fc
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 03:36:14 -0400
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com
 ([40.107.94.51]:5824 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kD0pu-0001yV-Vn
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 03:36:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrfBGVGhJ25ZxSkbHbWWpcnpK+6R2luJDV7Ic+7dt1OjSJ4on5ltuaT4672/rMzr4m0Sy5x4hzKo1y3mXCom0E2r9k2S6NRkXle6dB/HnVr8p4j239nj9y3eDi9cRjpLeO4b3lYf5GyuREqjq8Ka7qx4xNWX4ld8t0xn86mftwyQ5pmy79sVOg0t0/8e5GzXSxkbXyYd4JrXiQVAe+3AcIj7vpRyZVuoboN0h/MHeexkB9dwQygwaOunh/iQCcyrzfaDSaEwM1nC2fYqr+2Fqjfr46Cwcu4WwPmywhbKRlQlPIBX4/k9Sy5FzNmShrtZaWXViX9rm0kDC1xnP2ERtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2SscsDuT+vnGf9WL2jEap2i0A5daduckbWtppz6H2Q=;
 b=Dd+xCxKBQLEa7E2MwD/Bmuac6EBVCZGVt/BqSy8ii14I9Epo3uzsoSdlg7GTRVi8R7OTZTUuzDM3pJ054KR0sA/nmShNshim/AAkAktvB9EVeS3H8dsVO7XbrPHksflFvNvQVk+dIz4bfYp0tXTxlamWZOLiKY5vSBfOEhgkIAkGlnQkttoe7cxdVKgW5zGtjkR3gmEIyyWQlDS0ELByKDM+UZ5CcNsowUbLtr8gPrpg4tLZ+o5uNyj7QPvhIKtH44q1vaFzw6+707lKp8mwqnrvcgtLO4Lqo8oCDklGzaXPRKc7teTDZawPwb0pBmcqE8VBzCfyB8cY1e8mMMnJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2SscsDuT+vnGf9WL2jEap2i0A5daduckbWtppz6H2Q=;
 b=kC3v4Epf1EHA6cHU6dpDufRBbYxfk3mIx3JxqAr/ziVMEvuqKXTKak6mjHuRepPmkKJZ3s0QShr01RxiSmdr8aiJZXjWlHYsJuxD8Qa66B5Dm9OhnlO8XVTfzIXj57FkYF5fmrj+ZOKWqi8kSUGvCfXQ4tpg4ZvkxMIMMzh76xY=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB4325.namprd02.prod.outlook.com (2603:10b6:a03:5c::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 07:36:07 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 07:36:07 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH v4 5/7] misc: Add versal-usb2-regs module
Thread-Topic: [PATCH v4 5/7] misc: Add versal-usb2-regs module
Thread-Index: AQHWfW+XdzVFxEXdu0yTjH5fCdo/UqlRzocAgABIbXA=
Date: Tue, 1 Sep 2020 07:36:07 +0000
Message-ID: <BY5PR02MB677220F09E4F1EBD5DB76224CA2E0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-6-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200831070234.bke5kwujclbxcggy@sirius.home.kraxel.org>
In-Reply-To: <20200831070234.bke5kwujclbxcggy@sirius.home.kraxel.org>
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
x-ms-office365-filtering-correlation-id: ecae2889-0d84-4f45-4354-08d84e49b06c
x-ms-traffictypediagnostic: BYAPR02MB4325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4325CC8300FCAB308F414985CA2E0@BYAPR02MB4325.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dQEJPEqCaoeOyMBkW47Jty62XpbNdugJip6+iGYHWuM1Juy6l6MqtO+qXw1lqN1z4Ma6+ah6G4X8b6FCXNZDjhNJ29CbZnJvlxpSLKKK7O290muieeXr7KRQiB6NSjCM6mAxFT5Pfai3hMZSWhXVoQ8/H6ZSNxFmpm/1mQ3o0W+QJ0GiZf/5LPQsClyL20amo8JOnSBrl6SRi4PaA3ZuLSrUZ3K+0dtfxzoiVbHsnjxI1cRLX/zLWBJyNmXTDTPGvbsC5TkFljBu0m+O4YL7XdluBHCWYns+B0BeXRW/cb6t3GhOtxMrKMKhPUPbunrXqPXhaDc42V8Rgn98raMTVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(346002)(366004)(396003)(376002)(136003)(33656002)(6916009)(6506007)(26005)(52536014)(8936002)(7416002)(76116006)(5660300002)(2906002)(53546011)(7696005)(71200400001)(54906003)(83380400001)(9686003)(66476007)(64756008)(478600001)(55016002)(66556008)(8676002)(86362001)(186003)(316002)(4326008)(66446008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: KoySyRcTzni/QkSSzGXw2+mIkX6bs1MFi3POa7v0oMCNQmAlebJEKUYWuRgfExm9n8eWYJuEY1DE/U43sCwUx0kc8+aPvdwB9gr5cj9/zxFkEQqqn+lttHf0eKb4xm0dgSg3jK68FBiO+S7GdCJ+100/uN3PKYHLlSskVPtKq6A0+33LK1KX1QIMAait62xiCJS/SHTTpuZf+KxL7E1X12f2ubJhisp0jj5Jf7w1pfAfYfiqgRUolVKXxURyQGTb/WJFl+G0wEBxY6XTokxT3Bf3/40krdaPPXs5adY83XsxF30J8e/do39cVJeMadwV8KvONicUx1K6N0L82coVMhC7xekzhdRvXyvHxmoAUuAgBkhEcKtkljK0aCU99l3bgUZHbkRbmUhurCU1OizH031+muRMovol1IhSjeLkpRm2S5Td7rQvKJenKM4Y+sGoDKOkfXe+iHGQpIvucN1QE5aXt2vA/MbPereyANM7XoHi+dmVHLoi1pGsHcCklL/riR9QSZORrJITXBLcCQ5DLRv8DoC8inXSzk7m4XjfcmlD7NLBSmtYtMnFKpf86ve1Vpm+kyBtezpBlUH3wflskLNfuC8mVsADb9sXaagnwl2sKGFqszEM+KrxqeFfsMJguK1xIqjU+Pt8FCuk69NWRA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecae2889-0d84-4f45-4354-08d84e49b06c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 07:36:07.0527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8H5hDsRnEnEMHbzVu/CgWwWoOsQRy39vqgglz3o8PSv943X++j0WkaLnPcWPT/M8klbnavu0SvBJ0DCLYlKrQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4325
Received-SPF: pass client-ip=40.107.94.51; envelope-from=saipava@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 03:36:08
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
> Sent: Monday, August 31, 2020 12:33 PM
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
> Subject: Re: [PATCH v4 5/7] misc: Add versal-usb2-regs module
>=20
> On Sat, Aug 29, 2020 at 12:49:38AM +0530, Sai Pavan Boddu wrote:
> > This is a dummy module to emulate control registers of versal usb2
> > controller.
>=20
> --verbose please.  xhci supports all usb speeds, including usb2.
[Sai Pavan Boddu] This module is has soc specific control/status register t=
o control the phy-reset, adjust frame length time  and coherency properties=
 for the transactions.

>=20
> So why this hardware is here, what does it on a real device and what is t=
he
> emulation doing?  "dummy" sounds like it does just enough to make the
> guest driver happy, probably pretending nothing is connected?
Yes, this is added to make guest happy.

I will the commit message with more info

Regards,
Sai Pavan
>=20
> thanks,
>   Gerd


