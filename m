Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40319C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099502076E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CAUek7ZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099502076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k84WQ-0007Lt-J7
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 12:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1k84VJ-0006e9-Fm; Tue, 18 Aug 2020 12:30:29 -0400
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com
 ([40.107.236.83]:28448 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1k84VG-0004J6-Qd; Tue, 18 Aug 2020 12:30:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M16ups/lr/tQGOMT10bkpY1QzOvE7PSq/YASrODaLiWqo/aurZAKKxBr6kjqsZWB6qhJ+ckP3Hx3XQY9rd1j/nko8/LXLULzUUoEfEVucP5eQMD1AFdakkuvCrCMiUEVBfn5myvGMTXZpp7P2AUXXJtTlVM8kq/HovNgqkFuLwpzO5cvF64dvxq+TWeC9lE8kyIxhqId/pYIjcpUCGyDogyvvllcphN/MB56YyEVcwS55i56ypqXuhi5x9Sk5959/9BmTra/lLb8i80F0nVNcyqadD59iRTBoCdCx3REu63o1heJp15inCthCmid+dAumNnivYhV9zudlxE+T6i1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW2TBk+uizOR8hLdt7KWPbRHZIXdOyLaIrHFJals+W4=;
 b=b3l/1JXfOnfYTz/sP/q/wVRLLN0Fj9kBpYPkR8Ymn//BxA55P0c20hiNfjP+SePOEv02rcp068CsHuerXdbjgjWsAtzvZA0KdfGkPr6G4ocLU1N+r4hwtr7h2R5UUoONhsYObma9E2UwWQV08vbHFxavZ+XZUEHu7UQD9mZqQWPaTQkO8FIIDVIJfrS/r9UHe26ZFwkQ6wsAT2IRp02mfcoYd551qW6O+ThDpncbqCKlbjWDPqtyiyWL2xAsg+6RP9v+6JUmzEtCV78rDVPdKviMlevgfYrmGSO6srdgYjm7m8tKc9cxz9Ly2Y07T5ENapR1AJrM31QDzHLoSTfoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW2TBk+uizOR8hLdt7KWPbRHZIXdOyLaIrHFJals+W4=;
 b=CAUek7ZMZ8FMtIWI/8ebjFNrbfrz8f6THNmhsFgi7kttVPybsXTYMnR/SfDJw0DUn/vOr4GsVlKwNciIQLfbDknSE7ed7HdQbR5+jRXZniWmvbygLNdyRGE6P/EBp0kkyttwnBlZG4pOgK3CawS6/48QfV6+pPd6Sn+CQ8ORwVg=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB5975.namprd02.prod.outlook.com (2603:10b6:a03:118::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Tue, 18 Aug
 2020 16:30:15 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%7]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 16:30:15 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Bin Meng
 <bmeng.cn@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>, Bastian
 Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt
 <palmerdabbelt@google.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
Subject: RE: [PATCH 07/18] hw/sd: sd: Fix incorrect populated function switch
 status data structure
Thread-Topic: [PATCH 07/18] hw/sd: sd: Fix incorrect populated function switch
 status data structure
Thread-Index: AQHWctnsU/SfbQBsXUKm8YZh5uGNLKk+E8PA
Date: Tue, 18 Aug 2020 16:30:15 +0000
Message-ID: <BY5PR02MB67720168B25F53370840545BCA5C0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-8-git-send-email-bmeng.cn@gmail.com>
 <565d9936-3eda-db2f-b390-05f675cf6644@amsat.org>
In-Reply-To: <565d9936-3eda-db2f-b390-05f675cf6644@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9cedc970-0d1f-4bc0-cfce-08d84393fccf
x-ms-traffictypediagnostic: BYAPR02MB5975:
x-microsoft-antispam-prvs: <BYAPR02MB5975263219F672B0C17D7336CA5C0@BYAPR02MB5975.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wq2Cjpw4Q7JPEBry6XRdQUIOzn5u9K3A+oJ5Obb1Umt0P6zKIbxVfWMmYGt4UrScS5jzgJOmgd/PNVE0vr+w1iHTibeZO3psxZ+8R0jY+sn+ixqE/WiH/zI1TyNtjefOJFsuX6NLqQZtH4Wx0oo8P12eXf8Xg4pg1zTXbe7EzDCn3810dT1mzTl6iNnaCz49d7Z7yKrgLeiuBF3dnhqrOEThtbW8G7u6QR3uIL48dyiCAPz/jIy7gxmiQHS1NG9KQthpu4PYgwX+Jer4Rq8HQtxwxtFQvKy5gnEnett9IVGX9L/OoLiIZG84bwQZeyf2z4w4Z7NDei6uTiyzXxRmHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(136003)(366004)(39860400002)(346002)(396003)(186003)(9686003)(55016002)(2906002)(71200400001)(5660300002)(7416002)(33656002)(54906003)(83380400001)(86362001)(7696005)(6506007)(66946007)(4326008)(8676002)(478600001)(316002)(26005)(66476007)(110136005)(53546011)(64756008)(66446008)(76116006)(8936002)(66556008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: oAti0Aqm1BShBXdLV72SQ7l3/vpPIDe3MYsIUnTZpIgg/hJsxboyGp7H0uFHL6BNTwegVJpp+rMz9lzltPTFp1z+yJTnSJc6uT9xj26fXYwR++pLqKeNdLF6cCs/D3wdagKpRZyMKFcuJYgmwbZeLfRB/OTtqM+xnac3k9lWoN+NH1fUUyjU1DrkE1fuGGT/BCT4+joJU2KTrSWFsZ0nxhscq4G51zs93/69glQxpKOYeEqrhBhlWe+q4d8XEeWtghyf/ShV3FItMHexRCsggMiNbbr8OSApcQmzlt3jY77u21ZbNEbMG5kpQEoRxnSA1SKzPTvk8gKFBDL++6i9vMlj7TbWb81lb3vaPvHpa75Lo2izQG1yHkzoigqj5zV4BtQTvmWOXeT43hbh/pJHMVFxavHKFACQF2F1XoyfeqD6pUf2SupkMTGqP8RMPjoRnSqO9hJF8DUNQvqCLWyUWtx2fd545/3MXrc4HfZZVIgub+Qm6QWxZ2zHP2V1JQHyaOP85Cq5GtfXy8QbJSpRr71mHE/WgnDIL57cSuNMPqY/5EP3HKsQjg50BmMPOMF1JtPNRwfjzgLoPW2KhP/vLRiI8SnNVoSPs0tB/GKSND3b5ZIu6KitD0LvcoN3o8d+9z14UyUfq65kEWpZHKilDg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cedc970-0d1f-4bc0-cfce-08d84393fccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 16:30:15.2561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lymLVXNVNzT9ZZXhcgujn5febyM7zSzFTfz21tRcVbsNaRdwijEjM9kljpNpit930dEGPrz0LotbJfx0R1vhIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5975
Received-SPF: pass client-ip=40.107.236.83; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 12:30:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhbmtzIFBoaWxpcHBlLA0KDQpJIHdvdWxkIHRlc3QgdGhpcyBhbmQgZ2V0IGJhY2suDQoNClJl
Z2FyZHMsDQpTYWkgUGF2YW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbGlwcGUubWF0aGlldS5kYXVkZUBnbWFpbC5j
b20+IE9uDQo+IEJlaGFsZiBPZiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqQ0KPiBTZW50OiBTYXR1
cmRheSwgQXVndXN0IDE1LCAyMDIwIDE6MjkgUE0NCj4gVG86IEJpbiBNZW5nIDxibWVuZy5jbkBn
bWFpbC5jb20+OyBBbGlzdGFpciBGcmFuY2lzDQo+IDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+
OyBCYXN0aWFuIEtvcHBlbG1hbm4gPGtiYXN0aWFuQG1haWwudW5pLQ0KPiBwYWRlcmJvcm4uZGU+
OyBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyZGFiYmVsdEBnb29nbGUuY29tPjsgU2FnYXINCj4gS2Fy
YW5kaWthciA8c2FnYXJrQGVlY3MuYmVya2VsZXkuZWR1PjsgcWVtdS1kZXZlbEBub25nbnUub3Jn
OyBxZW11LQ0KPiByaXNjdkBub25nbnUub3JnOyBTYWkgUGF2YW4gQm9kZHUgPHNhaXBhdmFAeGls
aW54LmNvbT4NCj4gQ2M6IEJpbiBNZW5nIDxiaW4ubWVuZ0B3aW5kcml2ZXIuY29tPjsgcWVtdS1i
bG9ja0Bub25nbnUub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDcvMThdIGh3L3NkOiBzZDog
Rml4IGluY29ycmVjdCBwb3B1bGF0ZWQgZnVuY3Rpb24gc3dpdGNoDQo+IHN0YXR1cyBkYXRhIHN0
cnVjdHVyZQ0KPiANCj4gK1NhaSBQYXZhbg0KPiANCj4gT24gOC8xNC8yMCA2OjQwIFBNLCBCaW4g
TWVuZyB3cm90ZToNCj4gPiBGcm9tOiBCaW4gTWVuZyA8YmluLm1lbmdAd2luZHJpdmVyLmNvbT4N
Cj4gPg0KPiA+IEF0IHByZXNlbnQgdGhlIGZ1bmN0aW9uIHN3aXRjaCBzdGF0dXMgZGF0YSBzdHJ1
Y3R1cmUgYml0IFszOTk6Mzc2XSBhcmUNCj4gPiB3cm9uZ2x5IHB1cHVsYXRlZC4gVGhlc2UgMyBi
eXRlcyBlbmNvZGUgZnVuY3Rpb24gc3dpdGNoIHN0YXR1cyBmb3IgdGhlDQo+ID4gNiBmdW5jdGlv
biBncm91cHMsIHdpdGggNCBiaXRzIHBlciBncm91cCwgc3RhcnRpbmcgZnJvbSBmdW5jdGlvbiBn
cm91cA0KPiA+IDYgYXQgYml0IDM5OSwgdGhlbiBmb2xsb3dlZCBieSBmdW5jdGlvbiBncm91cCA1
IGF0IGJpdCAzOTUsIGFuZCBzbyBvbi4NCj4gPg0KPiA+IEhvd2V2ZXIgdGhlIGNvZGVzIG1pc3Rh
a2VubHkgZmlsbHMgaW4gdGhlIGZ1bmN0aW9uIGdyb3VwIDEgc3RhdHVzIGF0DQo+ID4gYml0IDM5
OS4gVGhpcyBmaXhlcyB0aGUgY29kZSBsb2dpYy4NCj4gPg0KPiANCj4gRml4ZXM6IGExYmIyN2Ix
ZTkgKCJTRCBjYXJkIGVtdWxhdGlvbiAoaW5pdGlhbCBpbXBsZW1lbnRhdGlvbikiKQ0KPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBCaW4gTWVuZyA8YmluLm1lbmdAd2luZHJpdmVyLmNvbT4NCj4gPiAt
LS0NCj4gPg0KPiA+ICBody9zZC9zZC5jIHwgNiArKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3
L3NkL3NkLmMgYi9ody9zZC9zZC5jDQo+ID4gaW5kZXggZmFkOWNmMS4uNTFmNTkwMCAxMDA2NDQN
Cj4gPiAtLS0gYS9ody9zZC9zZC5jDQo+ID4gKysrIGIvaHcvc2Qvc2QuYw0KPiA+IEBAIC04MDYs
MTEgKzgwNiwxNSBAQCBzdGF0aWMgdm9pZCBzZF9mdW5jdGlvbl9zd2l0Y2goU0RTdGF0ZSAqc2Qs
DQo+IHVpbnQzMl90IGFyZykNCj4gPiAgICAgIHNkLT5kYXRhWzExXSA9IDB4NDM7DQo+ID4gICAg
ICBzZC0+ZGF0YVsxMl0gPSAweDgwOwkvKiBTdXBwb3J0ZWQgZ3JvdXAgMSBmdW5jdGlvbnMgKi8N
Cj4gPiAgICAgIHNkLT5kYXRhWzEzXSA9IDB4MDM7DQo+ID4gKw0KPiA+ICsgICAgc2QtPmRhdGFb
MTRdID0gMDsNCj4gPiArICAgIHNkLT5kYXRhWzE1XSA9IDA7DQo+ID4gKyAgICBzZC0+ZGF0YVsx
Nl0gPSAwOw0KPiANCj4gUG9pbnRsZXNzIHplcm8gaW5pdGlhbGl6YXRpb24uDQo+IA0KPiBSZXZp
ZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPGY0YnVnQGFtc2F0Lm9yZz4NCj4gDQo+
IEknbGwgd2FpdCB1bnRpbCBuZXh0IHdlZWsgaW4gY2FzZSBTYWkgUGF2YW4gd2FudHMgdG8gdGVz
dCB0aGlzIHBhdGNoIChJIGRvbid0IGhhdmUNCj4gYWNjZXNzIHRvIHRoZSBYaWxpbnggaW1hZ2Vz
IGFueW1vcmUpIHRoZW4gSSdsbCBxdWV1ZSB0aGlzIHZpYSBteSBzZC1uZXh0IHRyZWUuDQo+IA0K
PiBSZWdhcmRzLA0KPiANCj4gUGhpbC4NCj4gDQo+ID4gICAgICBmb3IgKGkgPSAwOyBpIDwgNjsg
aSArKykgew0KPiA+ICAgICAgICAgIG5ld19mdW5jID0gKGFyZyA+PiAoaSAqIDQpKSAmIDB4MGY7
DQo+ID4gICAgICAgICAgaWYgKG1vZGUgJiYgbmV3X2Z1bmMgIT0gMHgwZikNCj4gPiAgICAgICAg
ICAgICAgc2QtPmZ1bmN0aW9uX2dyb3VwW2ldID0gbmV3X2Z1bmM7DQo+ID4gLSAgICAgICAgc2Qt
PmRhdGFbMTQgKyAoaSA+PiAxKV0gPSBuZXdfZnVuYyA8PCAoKGkgKiA0KSAmIDQpOw0KPiA+ICsg
ICAgICAgIHNkLT5kYXRhWzE2IC0gKGkgPj4gMSldIHw9IG5ld19mdW5jIDw8ICgoaSAlIDIpICog
NCk7DQo+ID4gICAgICB9DQo+ID4gICAgICBtZW1zZXQoJnNkLT5kYXRhWzE3XSwgMCwgNDcpOw0K
PiA+ICAgICAgc3R3X2JlX3Aoc2QtPmRhdGEgKyA2NCwgc2RfY3JjMTYoc2QtPmRhdGEsIDY0KSk7
DQo+ID4NCg0K

