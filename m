Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4E7C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172F52073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Wda/1hbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172F52073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVehL-0006sJ-7C
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVegR-0005pt-6o; Mon, 04 May 2020 13:15:11 -0400
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com
 ([40.107.244.52]:6051 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVegO-0002F9-QY; Mon, 04 May 2020 13:15:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPBNLDZf4e3k9e61JDcT9pSeKOW9l9U5thI7Hm7d/jKRMLVlCUv69h3+ya5a1YfhJFKbGsMKe80A3CGHhPDvrpqETlUczg3UIdPYA5V+UTrh6+Wb3OvG5gOR8f8xF5iM2/qSQBnTd5Yj5jNCX1x31WnYPMPlqsc3/7Q8q7OcwaaWKtR1g/uHXJ25m6D7equhcwIZNc/DM61w5VXFHY6IGU9gkE/5QEu2Yj0nws1ugpWTRrOQ2xbyD/g7w+G7EorVzbTpTJjVVBLO6JH03NR3LiwmlvP9Lq/fMgDEgPCQzXSD1iblQgAXLPLuTeUV06bLrbD1LNAUQ3Q0Gb9TFBir/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AR9aaR+iAYajjDUW0hNV7hnOYKd9ehdS1KhSnCu8Ks=;
 b=RqcWi3s/bQ6NNxZ5vbredFZ1UAQkmL8WPiszTr13YXqr5lhr3xJMkrIRp2GIQCsWw8kHOHsAo6M6eua/hQT+m8wkTFesE/KDLugpv0bDIGGAEhFT6Ipiz+vx4p+aucRiv5b3BWLadyNXL8s0of1aaqIqmlZO4a2CWGFl+1sS9omts/afUFmTi9FsGU6YCpWpgXA6REWrTdxiqmmcrKr4fLFJYTRZ72w8lIONzg1/sUl3CQmyIuyqgNt7Yu8StUMsPuTQENei63Arv29ufNnZlFtPXl3JGo+37fDGtcH0qA1geGQcwMp4sY0Ln7RU4f8NM33BnB0WlNj+VBgk+e/T2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AR9aaR+iAYajjDUW0hNV7hnOYKd9ehdS1KhSnCu8Ks=;
 b=Wda/1hbNo+8/25t7GUnLtHQvFyVriNe7MRuaPw61rVJARm5VooRr8um7krys9TTOUY77IPpl/sHy3cgzh9eiabmnqwUoQ6c+bQDTB1o8VXspZf+zIPWiw6uQ7/uI455FJvhsCNsVnvjyzlM0Jeo+7imMBoL/DRFREQs/g8P43pQ=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6068.namprd02.prod.outlook.com (2603:10b6:a03:1fe::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Mon, 4 May
 2020 17:15:05 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::9165:a37e:f249:48f6]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::9165:a37e:f249:48f6%7]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 17:15:05 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Ramon Fried <rfried.dev@gmail.com>
Subject: RE: [PATCH v2 00/10] Cadence GEM Fixes
Thread-Topic: [PATCH v2 00/10] Cadence GEM Fixes
Thread-Index: AQHWIiu6WqSHfcRVT0avdZJHQrYl2qiYKSHg
Date: Mon, 4 May 2020 17:15:05 +0000
Message-ID: <BY5PR02MB67727A994D298BA12762F715CAA60@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <CAGi-RUKfonE6S+1nmFdjhT_OrQ-+E7EMCOmsXZ-zdGttF9JFbw@mail.gmail.com>
In-Reply-To: <CAGi-RUKfonE6S+1nmFdjhT_OrQ-+E7EMCOmsXZ-zdGttF9JFbw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a61ea7d-da12-4b67-3e5a-08d7f04eb082
x-ms-traffictypediagnostic: BY5PR02MB6068:|BY5PR02MB6068:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB60684ADDE40B8A442A26F331CAA60@BY5PR02MB6068.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ON8lz6xZDfBg6OhBPoL+UD+rDNUDGvFWwc/uPcfdEOkidzrlFzxw/CLC/H6ImJhinADyfU4yPf5/Cu7ajg1Y/Odn8Nj+pIgGQAYnl6U+z3gKuodnQhOT2xh3eqmL93mRyECP2fik9tRXcfR+SCSJ0ZI8Z7b8Sg82RecVhEyOUsehN6bU5h+S35SE1iCWLAsl26mGhA7zHFRYifrbTa3xXvl/GAbFQ8cAaF3iykmVCL7baMKpsZTYdy2birPxq1FVETj9h3RDInstGk+meGYIkbvOCdYUHZfUqK06bPV1yN1FQOnscjaDHiyWetK8iTqt5hBTHYbHzMOXcBqjp5FCNiEUxwcIx55uGYq3qj+YdWMYfL2kV10GBiHzR+/iaDOjNZ2K35O8Dv0t0DXZeA5BY+lUVEwpZ/tqzopsByl9o3e2uuPcFMJKb+gP30vNNAY/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(9686003)(71200400001)(5660300002)(316002)(26005)(186003)(55016002)(2906002)(4326008)(53546011)(6506007)(52536014)(7696005)(33656002)(478600001)(66446008)(54906003)(64756008)(66556008)(66476007)(6916009)(86362001)(8936002)(76116006)(8676002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: zaSv/EIGGUBkukLEbLbEdxSHvnGGuyIk0joTK8j9+NUoRKCYWewvO4oeIqZqb1McdZi8U3itqS4mUaoixW+SteeO1IWw6PCADX2I7z0lh/Nk20OXn09D+Esv19sFnjQPTLodcPadxzFVwoVUST4mEFo9IB3O5qQpb9b/i0yTtOYXGfbwvfMy2nwsbrEcerm7Gj/eg7D8SkRwH2L+gN6bhw/BUZKiwb37v4hrGj6Yf2LRpPbJ3Qd7+bLxsuJlp3FlIwh9GSv6iuqD8HDvAhDBCV1EAFhL4S433pjjzct7cJVr5Y4D/ZOLZdrD5ZqVIZrjyQfZ1gPBv1baz9z3j+Kp9FNooZd5PMWaYOj0AXYok78hM4jB49YfQom7O+YmS6M7rCXmjvYdQdD2kLz2udKrwmEoeS0iq/ZMbSObL+SYiWKeacvbLCZYQdimYP7muz9Df/u78yZ5jwSu3UNUaDr0YFrCfG1dAt6oUhWOdQab5lEy4SrltfoQ+Msu7jmdbs16xMBQCrAMmGOPjm6D9eMuDY3VZEBbwM1VCnjds22eGhoTAbcU90JLa5s6w3CmaP6EQnqLwVUltoXmG20Lkc9fA0KijqMvDoKN9Ks8H8x2jWUGZ0hWuaZqk//QF88sjDyGEni62tU8ayRxkkoZ++6v0EKOLPFi0/SO/mue2Gu+RQrULB/OEmajLp1kc9TJekcjdkQNc4bNM0YYwLJviAUZLxj4U7tSWdk/aMnCt2DfPBLYJYBQY8ezWOk95c42+PaiqYgMiF6H4kR9TnyHihvtiwtTQvT8gj+9Vm23MJSKHkM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a61ea7d-da12-4b67-3e5a-08d7f04eb082
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 17:15:05.4172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMeh0xnC+mt2MuJGipWxiLpmtepYGRqooqcqMBjV1ShGF9nYE19OT9bm7d0IF1XtyaNsITDoxEET4soNFDkIgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6068
Received-SPF: pass client-ip=40.107.244.52; envelope-from=saipava@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 13:15:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Tong Ho <tongh@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUmFtb24sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFtb24g
RnJpZWQgPHJmcmllZC5kZXZAZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIE1heSA0LCAyMDIw
IDk6MjAgUE0NCj4gVG86IFNhaSBQYXZhbiBCb2RkdSA8c2FpcGF2YUB4aWxpbnguY29tPg0KPiBD
YzogRWRnYXIgRS4gSWdsZXNpYXMgPGVkZ2FyLmlnbGVzaWFzQGdtYWlsLmNvbT47IEFsaXN0YWly
IEZyYW5jaXMNCj4gPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47IFBldGVyIE1heWRlbGwgPHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZz47DQo+IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+OyBNYXJrdXMgQXJtYnJ1c3Rlcg0KPiA8YXJtYnJ1QHJlZGhhdC5jb20+OyBQaGlsaXBwZSBN
YXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+Ow0KPiBUb25nIEhvIDx0b25naEB4aWxp
bnguY29tPjsgb3BlbiBsaXN0OlhpbGlueCBaeW5xIDxxZW11LQ0KPiBhcm1Abm9uZ251Lm9yZz47
IFFFTVUgRGV2ZWxvcGVycyA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDAwLzEwXSBDYWRlbmNlIEdFTSBGaXhlcw0KPiANCj4gT24gTW9uLCBNYXkgNCwg
MjAyMCBhdCA1OjE0IFBNIFNhaSBQYXZhbiBCb2RkdQ0KPiA8c2FpLnBhdmFuLmJvZGR1QHhpbGlu
eC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBGb2xsb3dpbmcgcGF0Y2ggc2Vy
aWVzIGZpeGVzIGlzc3VlcyB3aXRoIHByaW9yaXR5IHF1ZXVlcywgQWRkcyBKVU1CTw0KPiA+IEZy
YW1lIHN1cHBvcnQsIE1ha2VzIERlYnVnIHN0YXRlbWVudHMgY29tcGlsYWJsZSAmIEZpeGVzIHJl
bGF0ZWQgdG8NCj4gPiBtdWx0aWNhc3QgZnJhbWVzLg0KPiA+DQo+ID4gQ2hhbmdlcyBmb3IgVjI6
DQo+ID4gICAgICAgICBGaXhlZCBidWlsZCBmYWlsdXJlIG9uIGZlZG9yYSBkb2NrZXIgbWFjaGlu
ZQ0KPiA+ICAgICAgICAgRml4IGJ1Z2d5IGRlYnVnIHByaW50IHRvIHVzZSBzaXplZCBpbnRlZ2Vy
IGNhc3RpbmcNCj4gPg0KPiA+IFNhaSBQYXZhbiBCb2RkdSAoOSk6DQo+ID4gICBuZXQ6IGNhZGVu
Y2VfZ2VtOiBGaXggZGVidWcgc3RhdGVtZW50cw0KPiA+ICAgbmV0OiBjYWRlbmNlX2dlbTogRml4
IHRoZSBxdWV1ZSBhZGRyZXNzIHVwZGF0ZSBkdXJpbmcgd3JhcCBhcm91bmQNCj4gPiAgIG5ldDog
Y2FkZW5jZV9nZW06IEZpeCBpcnEgdXBkYXRlIHcuci50IHF1ZXVlDQo+ID4gICBuZXQ6IGNhZGVu
Y2VfZ2VtOiBEZWZpbmUgYWNjZXNzIHBlcm1pc3Npb24gZm9yIGludGVycnVwdCByZWdpc3RlcnMN
Cj4gPiAgIG5ldDogY2FkZW5jZV9nZW06IFNldCBJU1IgYWNjb3JkaW5nIHRvIHF1ZXVlIGluIHVz
ZQ0KPiA+ICAgbmV0OiBjYWRlbmNlX2dlbTogQWRkIHN1cHBvcnQgZm9yIGp1bWJvIGZyYW1lcw0K
PiA+ICAgbmV0OiBjYWRuZWNlX2dlbTogVXBkYXRlIGlycV9yZWFkX2NsZWFyIGZpZWxkIG9mIGRl
c2lnbmNmZ19kZWJ1ZzEgcmVnDQo+ID4gICBuZXQ6IGNhZGVuY2VfZ2VtOiBVcGRhdGUgdGhlIHJl
c2V0IHZhbHVlIGZvciBpbnRlcnJ1cHQgbWFzayByZWdpc3Rlcg0KPiA+ICAgbmV0OiBjYWRlbmNl
X2dlbTogVFhfTEFTVCBiaXQgc2hvdWxkIGJlIHNldCBieSBndWVzdA0KPiA+DQo+ID4gVG9uZyBI
byAoMSk6DQo+ID4gICBuZXQ6IGNhZGVuY2VfZ2VtOiBGaXggUlggYWRkcmVzcyBmaWx0ZXJpbmcN
Cj4gPg0KPiA+ICBody9uZXQvY2FkZW5jZV9nZW0uYyB8IDE2Nw0KPiA+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgOTQgaW5zZXJ0aW9ucygrKSwgNzMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiAtLQ0KPiA+IDIu
Ny40DQo+ID4NCj4gSGV5LiBkaWQgeW91IHRlc3QgdGhlc2Ugd2l0aCA2NCBkZXNjcmlwdG9yIGFk
ZHJlc3NpbmcgPw0KW1NhaSBQYXZhbiBCb2RkdV0gVGVzdGVkIGl0IHdpdGggYSBCYXJlTWV0YWwg
YXBwbGljYXRpb24uDQoNCj4gSSBjYW4gdGVzdCBpdCBmb3IgeW91IGlmIHlvdSBuZWVkLg0KW1Nh
aSBQYXZhbiBCb2RkdV0gWWVzLCB3b3VsZCBiZSBuaWNlLCBpZiB5b3UgY2FuIHJldmlldy4NCg0K
VGhhbmtzLA0KU2FpIFBhdmFuDQo+IFRoYW5rcywNCj4gUmFtb24uDQo=

