Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3ECC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD7922209
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GS5lDX9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD7922209
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWDY-0000Ny-Dv
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIW0X-0008U3-0Z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:53:53 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com
 ([40.107.94.82]:29024 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIW0U-0000MB-AY
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:53:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK9jWVPHBGGLRdFFivqYXYq35v8qSnUrRhuvY8b8n5WMzhFzKhOGUnjyCIavaNgfsFnGQCMbCfyLXzM+3oEkKPaYW6YMPyxwLj9IpB9kFeN2sYKUFvgf2b6wzkwt3eRA5NoFEDMkZGx5Wd+Ldkg6NLJkR1JJuM+8T1zqzQL5d4nEJJSiZNhn6hT5lPwqqB0XAxkHWK1wG05dK/7W57++dl32bAXnilssxbRV5601WiT4NGdxS61iy9JH3dfyrttrIQ/sssOpk5eSZks4plFv/hIGozDI/HXKt5G6NvUh0TfsmNp1LV6gc7qrmABsNUEJEUrXybvY0jHLaNxGV0Gg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YRtsEP9Qw9sw2r9KCi7d8rmUOTrb0cVKFTIZLfLW2Q=;
 b=Zl7pNUtecRF7QYQJHJ9txQQH38O6kd67LnEv2X357wnVmydais3NQGLL5h3qQazycriWCYgRu+IjDCYnaIY1yfx9TPq7zgY/b1+hakqx6cY1lyvqr/0x5E9mOf8hxSl8q2g5BqLcvVfjfeTX4gGsDxHgFyWnITpcshrZq5f/90d/UNCNXYcI7dRnFbISddXBTTdQ5czlOrRmtUMWmZ7bC6RyLxthiEhfyjFek4E0A9LJpz042f2dOcS93L7COYGG5jfDKkruvqpan53wcjdAXrrfIUtatCSt1Up8LgP108C0PRsv2ThLoUtBvXfEKBCvR5IAefeENjkSl0YLrcCU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YRtsEP9Qw9sw2r9KCi7d8rmUOTrb0cVKFTIZLfLW2Q=;
 b=GS5lDX9RXbDiTR87m8LPQ256KFagJQQWFqpBUMiXRsAOgcg3RH95Z9qWCNubyWA0QqPDLIWuXgQ6Ted1DWAzSCS1T6ZYvUow98U6Hnyk4PfwFU6E7cu1p0Ysud65rv7qULUdX7fQwz641Xj4cOUZqydtjmAM40E/4CPVuCrnBxg=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5269.namprd02.prod.outlook.com (2603:10b6:a03:6e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Wed, 16 Sep
 2020 11:38:41 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 11:38:41 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH v5 0/7]  Make hcd-xhci independent of pci hooks
Thread-Topic: [PATCH v5 0/7]  Make hcd-xhci independent of pci hooks
Thread-Index: AQHWhzt2jqQqNQc2r0i4kVMGXR3HcalptcaAgAF3VLA=
Date: Wed, 16 Sep 2020 11:38:41 +0000
Message-ID: <BY5PR02MB67729AF79B6E25EFAF61251FCA210@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1599719469-24062-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200915131419.zmw26wy5k6hoxom7@sirius.home.kraxel.org>
In-Reply-To: <20200915131419.zmw26wy5k6hoxom7@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 092d0a63-fd6b-46fd-93be-08d85a350fa7
x-ms-traffictypediagnostic: BYAPR02MB5269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5269B2906EC771F241359750CA210@BYAPR02MB5269.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dIavnmyt2HJCx0SR0nZH1qCj5xgoWA1NYvo3wFM3zC1/IcSPPCZdmgKK58WEybFKnyz5GzUu6TEFIJv46bX/UxcZUU7RzTIvvlnP7EQYNE1yDKkI0Mqff9aOA8h19puJSuuZ4e3dFHYOdBD9v9ylyZn3iNcy4iRp/R0k5ZEhuIu/wcOr9Qe2GLzsce06LyySsHqkAuvRIyhLU8Ue9fw/Qb1FzJbS6namraxakQD+0groKYshJ9mO84kS/yhcpU2q9dhMVxtSQ2jeFoJwebWX5s9MVQg9ZHJtsh54vviB3SGIU1xqTGO3lxoyRETXn7PhZBDQQfaLCQ/XJbw8fWDtXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(376002)(346002)(39860400002)(136003)(396003)(66446008)(66556008)(2906002)(9686003)(66476007)(6916009)(76116006)(8936002)(64756008)(55016002)(8676002)(66946007)(316002)(52536014)(4744005)(5660300002)(7416002)(86362001)(71200400001)(26005)(186003)(478600001)(83380400001)(7696005)(53546011)(33656002)(6506007)(4326008)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ybwnDHhlA9RMYUgGT/6mV03DHM4dtgYvGz44L7QGPgRH1jfdNvTEfqnzPHZJLIFmkw6zqPuMtLmu/8DZd1/kLQyC+p+J0mNOyJEu+ykE4t6d2PeoFX/zGob/1jWlhRbM5DTlOpMn58q2soaUN5x87/mfVeu2cYvgsigTGmUL0gyT3DxiKPcRgzFoK17OrOikrBRpr7NZ4R/AtGsIX4Ww+1DbzXegiw5TO/zmqBVJdW9S0FCa0I7HURoFemDJlxUUBoONfTZgKRjhN5p16jdNR9Wn3vgC9dlzJXsWa266BbONUBnQRjteXNyM3tyKFFtw4xEo5ALVJx/1pYKs/m6OOQDc0KnIf6r7PNJciEkinRduRNAgKSXXdZ4Aw3EkZX/bV+RyZqj0Q67n8uViWOHyymNQzUWfxUod4gQxYm4U0ay+glf75cz4uvKiYXlTUzSgw5DPNOGYBrO78YlwpBaLNcu+7AJj2DeAs1eLXQHpzRH8ZfjmUq0KHBKg9+hd8OMrh4rSNjBeIdDlzkiI6Adb7EUoj52Hcgzg1vubGQOWJXQJePvdi65Yz1JRmCuhHQIUDa6MGUHOxfMOgqat4hXR8Oym9rlR9MyJ1HTncR1qWo0C7G6qNfQihxyVbi3gKOOMATtjkxDWJwXqqDUmhLVHeg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092d0a63-fd6b-46fd-93be-08d85a350fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 11:38:41.2957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdmusFtXOSKXbbqi+hbMSGZkxnGtO2/mSffZcDtcQGg5PvLq4lkEC6gEb1ea6iBE33/32C2+Dt8KGtwqthPjlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5269
Received-SPF: pass client-ip=40.107.94.82; envelope-from=saipava@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 07:53:48
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

Hi Gerd,

Sending out V6, with few fixes and rebased over latest master.

Thanks,
Sai Pavan=20
> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Tuesday, September 15, 2020 6:44 PM
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
> Subject: Re: [PATCH v5 0/7] Make hcd-xhci independent of pci hooks
>=20
> On Thu, Sep 10, 2020 at 12:01:02PM +0530, Sai Pavan Boddu wrote:
> > This patch series attempts to make 'hcd-xhci' an independent model so
> > it can be used by both pci and system-bus interface.
>=20
> Fails to apply again.
>=20
> I guess this time the typedef / qom changes (I've just rebased my microvm
> series because of that ...).
>=20
> take care,
>   Gerd


