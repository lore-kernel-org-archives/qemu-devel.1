Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8568FC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B3F2474B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ioepABje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B3F2474B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXlrj-0005Yq-F5
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 09:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kXlqJ-0004GG-TO
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:50:23 -0400
Received: from mail-mw2nam12on2081.outbound.protection.outlook.com
 ([40.107.244.81]:58656 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kXlqG-0002dn-RP
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsSqd6rr+KRwAs1Fej+R9TA4jZohebnPZsPonaeL3eWpbI1kMnVOqt80Gl4MgCaNlHGZ9h7uMfQ7838a2ASScNTkueSY+kc5XHb1vS+B0GlvAomEZB8z97oQJt8B9Gz1m/gVX5ipq8dyB9FBxre1/E1ULo87TOGgtMOL1xUriPiVpb6OW2rffihLdtJ4aH+sa6GI5lUcd98D+tN/tHVXXe0cP1cLdQKdrFtMv8JHhLylnd3YczK8SgZkUnHISIJV5NVEqg2mdbgRpmFK6WpfWZIRQkyuzxtP+vL8vEiKxLeRCCuSUTF/tqTss8kNvO4gg8ogR1QB5z8jkv3jadCaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLILOzDjWFM3rjxdCe6znoE8sJDwj91KUnhO/DXDyyQ=;
 b=n/fydSn0NVu5OZS7oIpeyoz+7sieTvMuoh23hA2ia/zK5xr9qWEsqpxhcUUSnisP/+Obl/3m/OBoQjck+2DBbopXY2JiTlKNssW0GiXUPk+c/0vygEOe/WL4wGPBHo3gUd12eUAG7++m2X6wUNWblMpMu56asjbsW4TFuWfSziXsoacS3Rgsc5NqJ3worECTvAktmJP4ipc5RTws1W4l96WVjYhUmeChBjZJhskM1rEXeFB8LOX9sgyjFHriKy1UYmPeNvAb/55RyTEk8n4aphyk5BePZG+DJkHqAJaMq3UrePBTNbRIGxzdSPNQi2kvmB88kwse3ESy55V65KSaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLILOzDjWFM3rjxdCe6znoE8sJDwj91KUnhO/DXDyyQ=;
 b=ioepABjeskEUPfwUNmQf1BSQj3mIGy1P0Mg5cXFlKxb0TTzPeQA9FSRoV7Vxj/j8oq4Kd/E+8ERDETg4PrD0ckYhZpbDxAZ2U4PuD20fBXhKiAX2mKb7Z51RzEW9rpiq29vCHFpW8smtFYPRS9SlTT2Ncx1HTezWdMivQluZkV8=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by SJ0PR02MB7455.namprd02.prod.outlook.com (2603:10b6:a03:29c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 13:50:17 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15%3]) with mapi id 15.20.3499.018; Wed, 28 Oct 2020
 13:50:17 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH v12 1/3] misc: Add versal-usb2-ctrl-regs module
Thread-Topic: [PATCH v12 1/3] misc: Add versal-usb2-ctrl-regs module
Thread-Index: AQHWqGyCOxCysZDUa0SsRgsa6fcPJqmqEhYAgAATCCCAAt09EIAABUcAgAABeQA=
Date: Wed, 28 Oct 2020 13:50:16 +0000
Message-ID: <BY5PR02MB67725BCB101936D51A8F1ED8CA170@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1603369056-4168-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1603369056-4168-2-git-send-email-sai.pavan.boddu@xilinx.com>
 <CAFEAcA_UuL=ymba+v1O75EOZqXBopLq_HOEtgZ8vZSyJ3AcF3Q@mail.gmail.com>
 <BY5PR02MB67726DABBD88E12722E48F95CA190@BY5PR02MB6772.namprd02.prod.outlook.com>
 <BY5PR02MB677213F5F6D3EE8D980B4B0ECA170@BY5PR02MB6772.namprd02.prod.outlook.com>
 <CAFEAcA_HX6gYE8yt6Qi2x1NKCWZ+GySgUW65r-cLobzN=z4rCQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_HX6gYE8yt6Qi2x1NKCWZ+GySgUW65r-cLobzN=z4rCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8eb9e869-cfbd-4fba-bc99-08d87b48671a
x-ms-traffictypediagnostic: SJ0PR02MB7455:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR02MB7455023D3DC8C8C540D91400CA170@SJ0PR02MB7455.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: InysNWAWTtGOjqsTaHge/kr7xzeqU94buCq+U1L+ncZFQ05ij4i+jCRb3SV3eLwEH4fofmqzHl2doDxiTy6Gix545OCUmYLfWgS3OWnHm/qEsjKI0NW43Lvix4YW3rJrMJE/ZBoNhkwgjbvgC5m+dIfybPrv9NuVT0BmxbzvlvdhuuNncAF6lS4+aiw8Jel5qZhlatTaQeyPCuFY82Pn4ZUp0dpj7AgrWn9litHA05s9c91+ofS2zbcfZsQRtKn010WLA/DlHOPGM5PNKfu1fAE9Gxsg6y9UQ+WYYVhVjVvOURILpoy/m56GKJ8yv/AZmUCkOIfMAZg/mJlwliQyiQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(8936002)(26005)(52536014)(54906003)(19627235002)(478600001)(5660300002)(316002)(8676002)(6916009)(33656002)(4326008)(186003)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(86362001)(2906002)(55016002)(83380400001)(71200400001)(9686003)(53546011)(7416002)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: mzQWJ1a1vUhja6yFca28o4DyFJ2iiOU20F+tx/ZJh9DZbzQqr76XmwQgd8+lsnPhT9B/KCsfZaEqOOxx5hDaFFadTubuxCVA5kE8TrszALqtefuquycxcVkQTzPDMGljuRuEXagE/gWcPQMuVY+MZFFBcnaZlt8d76c+auKxcKd681nkCYC2fEP/6/m1RnOZ0Ex/mGw5P3eh0G4SOFp8meHwtcpXdWrHF2k8omZHPchuYJZpu7HdgT7vARA1yoHLLLpBYTVoE2fch6u6MUbiIcQSQxG76vOjgtkUlfkYTgj15BBhRI7ltX5yDZdD+u12tj/CX3yLzfs5vDSsVUx5LiepM5LMD9+vaB0cCRcGyqmKb/7tuwCC+QGA57yhetdBmOTMBe/EGf8LXHJ70B1xg0vUdCk747eXs2Z/XetTV6F3VsuRDcnmecsnzt6ZS/1snbg40lP6IQldwnx91rubsPIKeWJ1hM7eFwn9atoSlunN4HQaCu4GfQbRCRS5/5/z/uGXsYuM/v4h6OGMt1ghYyOA6PG4dabiQbKt1lX4zRstmyzeWZN1w9PiVft2R4YzhPQice74qJ+31/6yOYzD0KOBHUHcIQnegYNMCxKegrhQZ0hZ2Nr9z36SRnsxqjuGl4wCvoi+1Zkz548W8irvsw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb9e869-cfbd-4fba-bc99-08d87b48671a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 13:50:16.9128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5dREu6Cbf6N+7XAw/Da5+Q6kWEQ+BLw6EY1R31JHkhhNqCFr7IQd9PT1uvnL3Y3hE03fVy1nRrS4G+QfXZwzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7455
Received-SPF: pass client-ip=40.107.244.81; envelope-from=saipava@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 09:50:19
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
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIg
TWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE9j
dG9iZXIgMjgsIDIwMjAgNjo0NCBQTQ0KPiBUbzogU2FpIFBhdmFuIEJvZGR1IDxzYWlwYXZhQHhp
bGlueC5jb20+DQo+IENjOiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+OyBN
YXJjLUFuZHLDqSBMdXJlYXUNCj4gPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT47IFBhb2xv
IEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+Ow0KPiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxA
cmVkaGF0LmNvbT47IEVkZ2FyIElnbGVzaWFzIDxlZGdhcmlAeGlsaW54LmNvbT47DQo+IEZyYW5j
aXNjbyBFZHVhcmRvIElnbGVzaWFzIDxmaWdsZXNpYUB4aWxpbnguY29tPjsgUUVNVSBEZXZlbG9w
ZXJzIDxxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnPjsgQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3Rh
aXIuZnJhbmNpc0B3ZGMuY29tPjsgRWR1YXJkbw0KPiBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQu
Y29tPjsgWWluZyBGYW5nIDxmYW5neWluZzFAaHVhd2VpLmNvbT47DQo+IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT47IFZpa3JhbSBHYXJod2FsDQo+IDxmbnV2QHhp
bGlueC5jb20+OyBQYXVsIFppbW1lcm1hbiA8cGF1bGR6aW1AZ21haWwuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYxMiAxLzNdIG1pc2M6IEFkZCB2ZXJzYWwtdXNiMi1jdHJsLXJlZ3MgbW9k
dWxlDQo+IA0KPiBPbiBXZWQsIDI4IE9jdCAyMDIwIGF0IDEyOjU4LCBTYWkgUGF2YW4gQm9kZHUg
PHNhaXBhdmFAeGlsaW54LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBQZXRlciwNCj4gPg0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFNhaSBQYXZhbiBCb2Rk
dQ0KPiA+ID4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDI2LCAyMDIwIDEwOjU5IFBNDQo+ID4gPiBU
bzogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiA+ID4gQ2M6IE1h
cmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT47IE1hcmMtQW5kcsOpIEx1cmVhdQ0K
PiA+ID4gPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT47IFBhb2xvIEJvbnppbmkgPHBib256
aW5pQHJlZGhhdC5jb20+Ow0KPiA+ID4gR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+
OyBFZGdhciBJZ2xlc2lhcw0KPiA+ID4gPGVkZ2FyaUB4aWxpbnguY29tPjsgRnJhbmNpc2NvIEVk
dWFyZG8gSWdsZXNpYXMNCj4gPiA+IDxmaWdsZXNpYUB4aWxpbnguY29tPjsgUUVNVSBEZXZlbG9w
ZXJzIDxxZW11LSBkZXZlbEBub25nbnUub3JnPjsNCj4gPiA+IEFsaXN0YWlyIEZyYW5jaXMgPGFs
aXN0YWlyLmZyYW5jaXNAd2RjLmNvbT47IEVkdWFyZG8gSGFia29zdA0KPiA+ID4gPGVoYWJrb3N0
QHJlZGhhdC5jb20+OyBZaW5nIEZhbmcgPGZhbmd5aW5nMUBodWF3ZWkuY29tPjsgUGhpbGlwcGUN
Cj4gPiA+IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT47IFZpa3JhbSBHYXJod2Fs
DQo+IDxmbnV2QHhpbGlueC5jb20+Ow0KPiA+ID4gUGF1bCBaaW1tZXJtYW4gPHBhdWxkemltQGdt
YWlsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjEyIDEvM10gbWlzYzogQWRkIHZl
cnNhbC11c2IyLWN0cmwtcmVncyBtb2R1bGUNCj4gPiA+DQo+ID4gPiBIaSBQZXRlciwNCj4gPiA+
DQo+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IFBldGVy
IE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gPiA+ID4gU2VudDogTW9uZGF5
LCBPY3RvYmVyIDI2LCAyMDIwIDk6MzMgUE0NCj4gPiA+ID4gVG86IFNhaSBQYXZhbiBCb2RkdSA8
c2FpcGF2YUB4aWxpbnguY29tPg0KPiA+ID4gPiBDYzogTWFya3VzIEFybWJydXN0ZXIgPGFybWJy
dUByZWRoYXQuY29tPjsgTWFyYy1BbmRyw6kgTHVyZWF1DQo+ID4gPiA+IDxtYXJjYW5kcmUubHVy
ZWF1QHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pDQo+ID4gPiA+IDxwYm9uemluaUByZWRoYXQu
Y29tPjsgR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+OyBFZGdhcg0KPiA+ID4gPiBJ
Z2xlc2lhcyA8ZWRnYXJpQHhpbGlueC5jb20+OyBGcmFuY2lzY28gRWR1YXJkbyBJZ2xlc2lhcw0K
PiA+ID4gPiA8ZmlnbGVzaWFAeGlsaW54LmNvbT47IFFFTVUgRGV2ZWxvcGVycw0KPiA+ID4gPiA8
cWVtdS0gZGV2ZWxAbm9uZ251Lm9yZz47IEFsaXN0YWlyIEZyYW5jaXMNCj4gPiA+ID4gPGFsaXN0
YWlyLmZyYW5jaXNAd2RjLmNvbT47IEVkdWFyZG8gSGFia29zdCA8ZWhhYmtvc3RAcmVkaGF0LmNv
bT47DQo+ID4gPiA+IFlpbmcgRmFuZyA8ZmFuZ3lpbmcxQGh1YXdlaS5jb20+OyBQaGlsaXBwZSBN
YXRoaWV1LURhdWTDqQ0KPiA+ID4gPiA8cGhpbG1kQHJlZGhhdC5jb20+OyBWaWtyYW0gR2FyaHdh
bCA8Zm51dkB4aWxpbnguY29tPjsgUGF1bA0KPiA+ID4gPiBaaW1tZXJtYW4NCj4gPiA+IDxwYXVs
ZHppbUBnbWFpbC5jb20+Ow0KPiA+ID4gPiBTYWkgUGF2YW4gQm9kZHUgPHNhaXBhdmFAeGlsaW54
LmNvbT4NCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTIgMS8zXSBtaXNjOiBBZGQgdmVy
c2FsLXVzYjItY3RybC1yZWdzDQo+ID4gPiA+IG1vZHVsZQ0KPiA+ID4gPg0KPiA+ID4gPiBPbiBU
aHUsIDIyIE9jdCAyMDIwIGF0IDEzOjExLCBTYWkgUGF2YW4gQm9kZHUNCj4gPiA+ID4gPHNhaS5w
YXZhbi5ib2RkdUB4aWxpbnguY29tPg0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IFRoaXMgbW9kdWxlIGVtdWxhdGVzIGNvbnRyb2wgcmVnaXN0ZXJzIG9mIHZlcnNhbCB1c2Iy
DQo+ID4gPiA+ID4gY29udHJvbGxlciwgdGhpcyBpcyBhZGRlZCBqdXN0IHRvIG1ha2UgZ3Vlc3Qg
aGFwcHkuIEluIGdlbmVyYWwNCj4gPiA+ID4gPiB0aGlzIG1vZHVsZSB3b3VsZCBjb250cm9sIHRo
ZSBwaHktcmVzZXQgc2lnbmFsIGZyb20gdXNiDQo+ID4gPiA+ID4gY29udHJvbGxlciwgZGF0YSBj
b2hlcmVuY3kgb2YgdGhlIHRyYW5zYWN0aW9ucywgc2lnbmFscyB0aGUgaG9zdCBzeXN0ZW0NCj4g
ZXJyb3JzIHJlY2VpdmVkIGZyb20gY29udHJvbGxlci4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFNhaSBQYXZhbiBCb2RkdSA8c2FpLnBhdmFuLmJvZGR1QHhpbGlueC5jb20+
DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVmlrcmFtIEdhcmh3YWwgPGZudS52aWtyYW1AeGls
aW54LmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgaHcvbWlzYy9tZXNvbi5idWlsZCAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ID4gPiA+ICBody9taXNjL3hsbngt
dmVyc2FsLXVzYjItY3RybC1yZWdzLmMgICAgICAgICB8IDIyOQ0KPiA+ID4gPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiAgaW5jbHVkZS9ody9taXNjL3hsbngtdmVyc2Fs
LXVzYjItY3RybC1yZWdzLmggfCAgNDUgKysrKysrDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgc2Vl
bXMgYSBiaXQgb2RkLiBJZiBpdCdzIGEgVVNCIGRldmljZSAob3IgcGFydCBvZiBhIFVTQg0KPiA+
ID4gPiBkZXZpY2UpIHRoZW4gaXQgc2hvdWxkIGJlIHVuZGVyIGh3L3VzYiwgc2hvdWxkbid0IGl0
Pw0KPiA+ID4gW1NhaSBQYXZhbiBCb2RkdV0gVGhpcyBpcyBhIHRvcCBsZXZlbCB3cmFwcGVyIG92
ZXIgaGNkLWR3YzMgZGV2aWNlLA0KPiA+ID4gd2hpY2ggaXMgc3BlY2lmaWMgdG8gdmVyc2FsIHNv
Yy4gSXQncyBtb3N0bHkgZHVtbXkgd2hpY2ggY29udHJvbHMNCj4gPiA+IHRoZSBwaHktcmVzZXQg
YW5kIGRvZXMgZnJhbWUgbGVuZ3RoIGFkanVzdG1lbnRzLiBJdCB3YXMgYWRkZWQganVzdA0KPiA+
ID4gdG8gbWFrZSBndWVzdCBoYXBweSwgdGhhdCBpcyB0aGUgcmVhc29uIGl0IGhhcyBiZWVuIGFk
ZGVkIHRvIG1pc2MgZGV2aWNlcy4NCj4gPiA+ID4NCj4gPiA+ID4gPiArc3RhdGljIHZvaWQgaXJf
c3RhdHVzX3Bvc3R3KFJlZ2lzdGVySW5mbyAqcmVnLCB1aW50NjRfdCB2YWw2NCkgew0KPiA+ID4g
PiA+ICsgICAgVmVyc2FsVXNiMkN0cmxSZWdzICpzID0gWElMSU5YX1ZFUlNBTF9VU0IyX0NUUkxf
UkVHUyhyZWctDQo+ID4gPiA+b3BhcXVlKTsNCj4gPiA+ID4gPiArICAgIC8qDQo+ID4gPiA+ID4g
KyAgICAgKiBUT0RPOiBUaGlzIHNob3VsZCBhbHNvIGNsZWFyIFVTQlNUUy5IU0UgZmllbGQgaW4g
VVNCIFhIQ0kNCj4gcmVnaXN0ZXIuDQo+ID4gPiA+ID4gKyAgICAgKiBNYXkgYmUgY29tYmluZSBi
b3RoIHRoZSBtb2R1bGVzLg0KPiA+ID4gPiA+ICsgICAgICovDQo+ID4gPiA+DQo+ID4gPiA+IFdo
YXQgZG9lcyB0aGUgaGFyZHdhcmUgZm9yIHRoaXMgbG9vayBsaWtlPyBZb3UndmUgbW9kZWxsZWQg
aXQgYXMNCj4gPiA+ID4gdHdvIGNvbXBsZXRlbHkgc2VwYXJhdGUgZGV2aWNlcyAodGhpcyBvbmUg
YW5kIHRoZQ0KPiA+ID4gPiBUWVBFX1VTQl9EV0MzKSBidXQgd291bGQgaXQgYmUgY2xvc2VyIHRv
IHRoZSBoYXJkd2FyZSBzdHJ1Y3R1cmUgdG8NCj4gPiA+ID4gaGF2ZSBhIHRvcC1sZXZlbCBkZXZp
Y2Ugd2hpY2ggaGFzLWEgRFdDMyA/DQo+ID4gPiBbU2FpIFBhdmFuIEJvZGR1XSBZZXMsIHdlIGNh
biBsb29rIGF0IGl0IHN1Y2ggd2F5LiBCdXQgYXMgaXRzDQo+ID4gPiBzcGVjaWZpYyB0byB2ZXJz
YWwgU09DLCB3ZSBoYXZlIGNyYWZ0ZWQgaXQgb3V0IGFuZCBzdGl0Y2hlZCB0aGVtIGluIFNPQyBm
aWxlLg0KPiA+ID4NCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBTYWkgUGF2YW4NCj4gPiBbU2FpIFBh
dmFuIEJvZGR1XSBJIHdvdWxkIGJlIHNlbmRpbmcgVjEzIHdpdGhvdXQgZG9pbmcgYW55IGNoYW5n
ZXMgd2l0aA0KPiB0aGlzIHBhdGNoIGFuZCBhZGRyZXNzaW5nIG90aGVyIGNvbW1lbnRzLCBQbGVh
c2UgcmV2aWV3IG92ZXIgVjEzLg0KPiANCj4gWW91IGhhdmUgbXkgcmV2aWV3IGNvbW1lbnRzIGFi
b3ZlLiBJIHRoaW5rIHRoZSB3YXkgeW91J3ZlIHN0cnVjdHVyZWQgdGhpcw0KPiBpc24ndCByZWFs
bHkgdGhlIGJlc3Qgd2F5IHRvIGRvIGl0Lg0KW1NhaSBQYXZhbiBCb2RkdV0gT2ssIEkgd291bGQg
bW92ZSB0aGlzIGludG8gVVNCIGZvbGRlciBhcyBpdHMgcmVsYXRlZC4gDQpCdXQgdGhpcyBkZXZp
Y2UgaXMgbm90IGxpa2UgYSB0b3AgbGV2ZWwgbW9kdWxlIG9mIERXQzMgbW9kZWwsIGlzIHVzZWQg
Zm9yIGhhbmRsaW5nIHBoeS1yZXNldCBzaWduYWwgJiBwb3dlciBtYW5hZ2VtZW50IG9mIHVzYiBw
b3J0Lg0KSXQncyBub3QgYSBnb29kIGlkZWEgdG8gZW1iZWRkZWQgdGhpcyBkZXZpY2UgaW50byBE
V0MzIG1vZHVsZS4NCg0KQW55d2F5LCBJIHdvdWxkIGF0dGVtcHQgdG8gY3JlYXRlIGEgc3Vic3lz
dGVtIGJ5IG1ha2luZyBkd2MzIGFuZCB1c2IyLWN0cmwtcmVncyBjaGlsZCBvZiBvbmUgZGV2aWNl
Lg0KDQpSZWdhcmRzLA0KU2FpIFBhdmFuDQoNCj4gDQo+IHRoYW5rcw0KPiAtLSBQTU0NCg==

