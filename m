Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E980CC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 06:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE654214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 06:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gmJhTcd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE654214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j90hB-00011I-Pq
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 01:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j90gW-0000ZW-8Q
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 01:05:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j90gU-0000bs-KT
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 01:05:39 -0500
Received: from mail-co1nam11on2049.outbound.protection.outlook.com
 ([40.107.220.49]:42209 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1j90gU-0000bV-87
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 01:05:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz6PlM9xJcTywz7XdrRIKrJpn/LDMkDpjDKXi4iChgXMk8SEUQi/z0OOzPGwWh97DfUb5eqFbS3z2QT8/ORvTi3c8DXgdBmdzd5Z6ILygwUkufF+2jtH3kjL/4mBAXJ9QsNwbM7BFNuG0/3Vc56ZVbeMwcpNR8Y5d7NG+ycVFOUCLqV/bOeupnE1+BxEYgxTFfAlIRWlUD/2EofXKP1X4C348PTOioSmEvN0rIRjCG/SpjpHIToYhPBt6hvCQXyDC7j+vuZCN8TNbPrEJ/dnJfZzb/iZ00yI649HesWzhKbwQfusLIZ2X/dwrxWRyBE0dBKOa41gKmID9AY0s81kNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VlxvQgP87RvdfpgcH/DDRwhPnfd7KlWEpxkV9eNhLY=;
 b=nDkWKgeMl5eT/LVp4O61c9xpfuEaN1CKCkiW/m77NAsDhtuyuAW7K5VjcBhlVm7NbOLf/cvVDOA440W1qcZuytUnNpAEIDgTzMe9cx3VVMv0Rds6LxG/QM2HVq1t3BHn5jjzcOxxVsc81V0rch2dYfEa/hawuoVA9CUZqGQ10Rb3pMZRcKYku/J4+Fd+/Sj1OJXDL1zv7kzp+p8FUfpkbRpOsg7BMffp0GtSJOKBtDWi3EtkdjY8G5moc7MD/SoU0WR+RPziUOg46cey3Ba0ji6qSHuv/miy+YKpCRux/pKR65fBHmvl2vFu8UtmP7FSKa/x8uRj6ooqLwtGb0MbIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VlxvQgP87RvdfpgcH/DDRwhPnfd7KlWEpxkV9eNhLY=;
 b=gmJhTcd8thUgafq8MTxCdr5CAywM38cHprWr1WPGwFo999TFNNnp7JTstiMDCUMDuhyGi/5ET6IdoBi9TzQecvobmEvUU229HnB4CRPXR2nCCpxwrpZN3vfj9ZvT+h1Wr9XjU3To+qlhif8dH4rCxaLs4LuCahkSgxvP4C+lFYA=
Received: from MN2PR02MB5935.namprd02.prod.outlook.com (2603:10b6:208:111::23)
 by MN2PR02MB6637.namprd02.prod.outlook.com (2603:10b6:208:19a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 06:05:35 +0000
Received: from MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::7161:a3a3:c491:10cd]) by MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::7161:a3a3:c491:10cd%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 06:05:35 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: Implementing IOMMU support for SDHCI
Thread-Topic: Implementing IOMMU support for SDHCI
Thread-Index: AdXsoAgJBAmayeg8R/u0QxshP3edDAAIdgSAAFZNw6AAAZw1AAC/muUQ
Date: Tue, 3 Mar 2020 06:05:35 +0000
Message-ID: <MN2PR02MB5935222A7AAD7518BD4F5DF8CAE40@MN2PR02MB5935.namprd02.prod.outlook.com>
References: <MN2PR02MB5935836FBB0AC02F56278FE3CAEA0@MN2PR02MB5935.namprd02.prod.outlook.com>
 <CAFEAcA_iXuc_r=wJWhHjZ1ROvfCwsxbU0yyiwJpqaxDfFtfmbQ@mail.gmail.com>
 <MN2PR02MB5935FCFCAB2C3CECE898B290CAE80@MN2PR02MB5935.namprd02.prod.outlook.com>
 <CAFEAcA9h29YvbXSZxq4xFg_NbiYr-amqF9QGBS8nBvhvLi1WhQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9h29YvbXSZxq4xFg_NbiYr-amqF9QGBS8nBvhvLi1WhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saipava@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55df6bac-7216-4335-33fb-08d7bf38e38a
x-ms-traffictypediagnostic: MN2PR02MB6637:|MN2PR02MB6637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6637AD7BE12A400E2AD49D04CAE40@MN2PR02MB6637.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(4326008)(5660300002)(81166006)(81156014)(8676002)(66476007)(478600001)(6916009)(66446008)(26005)(64756008)(66556008)(66946007)(107886003)(186003)(2906002)(76116006)(52536014)(71200400001)(9686003)(7696005)(53546011)(54906003)(55016002)(316002)(33656002)(86362001)(8936002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB6637;
 H:MN2PR02MB5935.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yo7jKoRkmmJsE5McPW67WjfZbr6wr7OZRIMOQ4UWStillS2uyX9J0KjXu6a3oyzkW9xiHZd8DM+l4T2CfdFo9bcY4wIEIwRJK9eIeuov9gFrhEleivY3d5e9tzDW9V2EM4Anbdmw9lsoD1JcD602UvyR6e05S1vdrFSMAv5jbFdkotqGjn8kHlpV6awX3hJWU6u7xN7xyskg5tZF55ZNXaEPznwZDo/xYqhVNVsaJMNKSSSh5HyWzSdGWWe7kSzR30QAbuDC4Sx/xdkXGeEoeDPVenC2GX3wnqtX8VZITSAElRubRSf3xhJZ5oXTskf9bgQyBkNsU8PdwSvEpqSNnMEHMxnKMa/7djzWmRvcvgbIfbYslNCZauAYeiC9RiM7/6iwKc00VKJ14IHPFu0XM2X+eiPRzdIzdD4AXCq2vLch2B4mbLXFklNvOASHtPLY
x-ms-exchange-antispam-messagedata: j33WY0B2sFzj799VioAK7VcmuYUND+m0CXtYBktzesz0bR57R+gKF+0i/3nIBBPfJOBP5PyhbxkrdWBjgMqO1tzECZ0O9m+3mR8/eaI9FEsCcPR6C61ByNGkS2V2N7co0DIBrME9j6LC6DlU37EMcQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55df6bac-7216-4335-33fb-08d7bf38e38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 06:05:35.1204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZICzARUemC4Z1QlbiebDBEc4E2ZUKcI7qWfF+5VKlP4uBpgiOaZywFNkXJgEWHuh4JeAEYu/EmZ+pCfplvEtgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6637
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.49
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIg
TWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1
YXJ5IDI4LCAyMDIwIDM6NTYgUE0NCj4gVG86IFNhaSBQYXZhbiBCb2RkdSA8c2FpcGF2YUB4aWxp
bnguY29tPg0KPiBDYzogcGJvbnppbmlAcmVkaGF0LmNvbTsgUUVNVSBEZXZlbG9wZXJzIDxxZW11
LWRldmVsQG5vbmdudS5vcmc+Ow0KPiBFZGdhciBJZ2xlc2lhcyA8ZWRnYXJpQHhpbGlueC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBJbXBsZW1lbnRpbmcgSU9NTVUgc3VwcG9ydCBmb3IgU0RIQ0kNCj4g
DQo+IE9uIEZyaSwgMjggRmViIDIwMjAgYXQgMTA6MDgsIFNhaSBQYXZhbiBCb2RkdSA8c2FpcGF2
YUB4aWxpbnguY29tPiB3cm90ZToNCj4gPiBbU2FpIFBhdmFuIEJvZGR1XSBPdXIgaWRlYSBpcyB0
byBjcmVhdGUgZG1hIGhlbHBlciBmdW5jdGlvbiB3aGljaCBjYW4NCj4gPiBhbHNvIHBhc3MgdGhl
IE1lbVR4QXR0ciBpLmUgbGlrZSBkbWFfbWVtb3J5X3J3X2F0dHIgKEFkZHJlc3NTcGFjZSAqYXMs
DQo+IGRtYV9hZGRyX3QgYWRkciwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdm9pZCAqYnVmLCBkbWFfYWRkcl90IGxlbiwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRE1BRGlyZWN0aW9uIGRpciwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgTWVtVHhBdHRycyBhdHRyKSB3aGljaCBuZWVkcyB0bw0KPiA+
IGJlIHVzZWQgaW4gc2RoY2ksICB3aXRoICJBZGRyZXNzU3BhY2UgKmFzIiBwb2ludGluZyB0byBz
bW11Lg0KPiANCj4gWWVzLCB5b3Ugd2FudCB0byBiZSBhYmxlIHRvIHBhc3MgTWVtVHhBdHRycyBm
cm9tIGRldmljZXMgdXNpbmcgdGhlIGRtYQ0KPiBBUElzLiAoT3IgeW91IGNvdWxkIGp1c3QgY2Fs
bCBkbWFfYmFycmllcigpIHlvdXJzZWxmIGJlZm9yZSBkaXJlY3RseSB1c2luZyBhbg0KPiBhZGRy
ZXNzX3NwYWNlXyogZnVuY3Rpb24uKSBQbHVtYmluZyB0aGF0IHRocm91Z2ggaXMgc3RyYWlnaHRm
b3J3YXJkLg0KPiANCj4gQXMgYW4gYXNpZGUsIHdlIGFyZSBlbm9ybW91c2x5IGluY29uc2lzdGVu
dCBhYm91dCB3aGV0aGVyIGRldmljZXMgdXNlDQo+IGRtYV9tZW1vcnlfKiBmdW5jdGlvbnMgb3Ig
anVzdCBkaXJlY3RseSBkbyBhZGRyZXNzX3NwYWNlXyogY2FsbHMuIEkgdGhpbmsNCj4gdGhlIGlu
dGVudGlvbiBpcyB0aGF0IHRoZSBkbWFfbWVtb3J5XyogaW5jbHVkZSBuZWNlc3NhcnkgbWVtb3J5
IGJhcnJpZXJzLA0KPiBidXQgaXQncyBub3QgY2xlYXIgdG8gbWUgYXQgbGVhc3Qgd2hlbiB0aGUg
YmFycmllcnMgYXJlIG5lY2Vzc2FyeSBvciB3aHkgd2UNCj4gaGF2ZSB0aGlzIGZhbWlseSBvZiBm
dW5jdGlvbnMgdGhhdCBzb21lIGRldmljZXMgdXNlIGFuZCBtb3N0IGp1c3QgZG9uJ3QuDQo+IA0K
PiA+IEkgc2VlIHdlIGRvbuKAmXQgbmVlZCBRT00gdmFyaWFudCBvZiBNZW1UeEF0dHIgZm9yIHRo
aXMgZnVuY3Rpb25hbGl0eSwNCj4gPmJ1dCB0aG91Z2h0IGl0IHdvdWxkIGJlIGdvb2QgdG8gdXNl
ICAiIG9iamVjdF9hZGRfbGlua19wcm9wZXJ0eS8NCj4gPm9iamVjdF9zZXRfbGlua19wcm9wZXJ0
eSAiIHRvIHNldCB0aGUgdmFsdWVzIGZyb20gbWFjaGluZSBmaWxlJ3MuDQo+ID5JIHdvdWxkIGRy
b3AgdGhpcyBpZGVhLCBhbmQgbG9vayBmb3Igb3RoZXIgb3B0aW9ucyB0byBzZXQgdGhlIGF0dHJp
YnV0ZXMuDQo+IA0KPiBUaGUgYXR0cmlidXRlcyBvZiBhIHRyYW5zYWN0aW9uIGFyZSBzZXQgYnkg
dGhlIHRoaW5nIGdlbmVyYXRpbmcgdGhlDQo+IHRyYW5zYWN0aW9ucyAoZWl0aGVyIHRoZSBDUFUs
IG9yIHRoZSBETUEgZGV2aWNlLCB3aGF0ZXZlciBpdCBpcykuIFR5cGljYWxseQ0KPiB0aGV5J3Jl
IGVpdGhlciBmaXhlZCwgb3IgcG9zc2libHkgY29uZmlndXJhYmxlIGF0IGEgaGFyZHdhcmUgbGV2
ZWwsIG9yDQo+IHNvbWV0aW1lcyBjb25maWd1cmFibGUgYnkgc29mdHdhcmUuDQo+IEkgZG9uJ3Qg
dGhpbmsgYW55IG9mIHRob3NlIHNjZW5hcmlvcyBhcmUgb25lcyB3aGVyZSB5b3UnZCB3YW50IHRo
ZSBib2FyZA0KPiBtb2RlbCB0byBiZSBwYXNzaW5nIGluIGEgTWVtVHhBdHRyIGF0IGRldmljZSBj
cmVhdGlvbiB0aW1lLg0KW1NhaSBQYXZhbiBCb2RkdV0gWWVhaCBvaywgdGhpcyBtYWtlcyBzZW5z
ZS4gT25seSB0aGluZ3Mgd2hpY2ggbWUgbWlnaHQgbmVlZCB0byBjb25maWd1cmUgYXJlIG1hc3Rl
ciBpZCdzIGFuZCB0cnVzdCB6b25lIHNldHRpbmdzIGlmIHBvc3NpYmxlLg0KTWF5IGJlIHdlIGNh
biBzZXQgdGhlbSBhdCBzb2MgZW11bGF0aW9uIGxldmVsIGkuZSAiaHcvYXJtL3hsbngtenlucW1w
LmMiDQoNClJlZ2FyZHMsDQpTYWkgUGF2YW4NCj4gDQo+IHRoYW5rcw0KPiAtLSBQTU0NCg==

