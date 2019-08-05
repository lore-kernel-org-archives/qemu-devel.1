Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E7AC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1126B216F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 15:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S5e3VrjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1126B216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huecm-0008Ls-WB
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 11:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43857)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1huec7-0007d7-Ca
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1huec6-0003bz-Bh
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 11:09:31 -0400
Received: from mail-eopbgr30132.outbound.protection.outlook.com
 ([40.107.3.132]:51680 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1huec3-0003Z5-Dv; Mon, 05 Aug 2019 11:09:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diNqLQ8pbbXrWaa08DnmA9UWW+/NOxLYHfwYeC4XzTmku6RxO1EiE3ige0OcrcschVwSc4HRyzSRLNQbuXoO5SDV6G0uj4KGJHsVQWj+hjRn/m8KUx01ghhVvziY3fpOlbSGE6ag8fFC/uETRWNC/Y3ZG//s9RtROe2AhBL7h6QLPEY0z4Wms2pSxQFVobU1BKaHf9muQ4C11IOa0nhpdN7pJTqGeMjIKX1H251ujYRmlR2wcEWAKx0qg5vFzr/Xt31V2X06MwLovQnspJx308G1GrtZLfBMvD2jY/mCMi3QKyNJmSk/x4M/bz6KvACwZKmwY6luLVH70wpLIW5HRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPpfdAH+p7ZUVnCXBJmNScxQqEIpiQf/2W70/87LnfI=;
 b=gG3WzPk/IjoZnhtSHe7AWTfUmSnIGxFyaAblPJusAdbhIlm2pbkvXG7hbkQwoqEmv4Hg307aQrI3ylajhZplcnkp2y3yOQ5bPFFt/gRP484YqSoa3I/1sDgCQKPkFRZV/+2AW0m7xG7vkLrd3sciLNQA6RV4PC7OnQs+ukqpFfFNpuxG+QBbTPhUpi4zTiFPD+PhvJ9kFLjg2CexHlXJlolOA9sjLRjMDqrbFkF+7lgaAw7poBO6YW1tZUKigyfJuxA1LUdVFDl4ro1z4aCN2NNoiOXjTlfnaWrxWe7IxQht59UA1we0i70/dNrcQfnbRNEGQdfXE2D7aemXZ68huw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPpfdAH+p7ZUVnCXBJmNScxQqEIpiQf/2W70/87LnfI=;
 b=S5e3VrjXsrxwL6+gIqbd6PXhTKqkIsaSkIopFo8bQ0wT5I5mMQjehyrVYCb7IXzIqvQWpv+CPGCUL4CNBlPRhaCWhKo/9MlZMY4USCJCV7sL3Kptb6n/8W4BJjazA0mC/mPiivjuXnjNsapbpYyL7Age3j6Pq1wBPHYk8lyGDxs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3996.eurprd08.prod.outlook.com (20.179.9.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Mon, 5 Aug 2019 15:09:24 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 15:09:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2] mirror: Only mirror granularity-aligned chunks
Thread-Index: AQHVS53fGTIYbFjR0U6GYZgAe8NwbabsqEiA
Date: Mon, 5 Aug 2019 15:09:24 +0000
Message-ID: <34fc0ae2-8707-9793-fddc-9fafc899f0ee@virtuozzo.com>
References: <20190805145541.3731-1-mreitz@redhat.com>
In-Reply-To: <20190805145541.3731-1-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::12)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190805180921615
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d315645-b478-42dc-235a-08d719b6e69d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3996; 
x-ms-traffictypediagnostic: DB8PR08MB3996:
x-microsoft-antispam-prvs: <DB8PR08MB39960602166F92308464570AC1DA0@DB8PR08MB3996.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:486;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(396003)(366004)(136003)(39850400004)(199004)(189003)(446003)(2616005)(2501003)(6246003)(71190400001)(6512007)(71200400001)(36756003)(66446008)(99286004)(66946007)(256004)(7736002)(86362001)(14454004)(478600001)(305945005)(66556008)(386003)(8936002)(102836004)(8676002)(6116002)(81166006)(81156014)(6486002)(64756008)(229853002)(2906002)(66066001)(6506007)(3846002)(316002)(68736007)(11346002)(486006)(31696002)(110136005)(6436002)(476003)(26005)(14444005)(76176011)(53936002)(66476007)(31686004)(25786009)(52116002)(54906003)(186003)(4326008)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3996;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U/DQqNtT1WNTRGfmLnltZPEMRTWNrLHWf6jEr94QTMNGJoPtZY8RnpKcQpy8BYkTnxoqQJLbi2HPcl6eEQ5sUFdpSEH5iX7b6Cqhw9Q/YQ+Rc3SbSTVBMUanp/muMlhZ10slhiY98n3oZLeuN/zfmTruPgcRKUnzDQw9hhrrvQQl/jM1KkgXflhZbqMNl7UyvQ1+cFf+PohgEdX4NmnbTSbuLWpN+i6RgsggjOy+07FTYmQ4N5NlEcQvSzUkrlFQGVivTtNg9d58rPCIlHlGo4F8I2PnCuPRbR6/jFpL86Uzc0WljCmMaWRPVXInDzbBMcFN/s8lOcuJ4dFpFzJEjtUCKt6Jz0LlgJmWCgMbdy2/4hyTpwP9eJJiFNCDlS66sBYCuxPtmx2zR3e28glfGBEKhA85UxSKnX7SMAYXaCk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AADCF05C560FA047B66F908E7CEBB24B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d315645-b478-42dc-235a-08d719b6e69d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 15:09:24.2466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3996
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.132
Subject: Re: [Qemu-devel] [PATCH v2] mirror: Only mirror granularity-aligned
 chunks
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDUuMDguMjAxOSAxNzo1NSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBJbiB3cml0ZS1ibG9ja2luZyBt
b2RlLCBhbGwgd3JpdGVzIHRvIHRoZSB0b3Agbm9kZSBkaXJlY3RseSBnbyB0byB0aGUNCj4gdGFy
Z2V0LiAgV2UgbXVzdCBvbmx5IG1pcnJvciBjaHVua3Mgb2YgZGF0YSB0aGF0IGFyZSBhbGlnbmVk
IHRvIHRoZQ0KPiBqb2IncyBncmFudWxhcml0eSwgYmVjYXVzZSB0aGF0IGlzIGhvdyB0aGUgZGly
dHkgYml0bWFwIHdvcmtzLg0KPiBUaGVyZWZvcmUsIHRoZSByZXF1ZXN0IGFsaWdubWVudCBmb3Ig
d3JpdGVzIG11c3QgYmUgdGhlIGpvYidzDQo+IGdyYW51bGFyaXR5IChpbiB3cml0ZS1ibG9ja2lu
ZyBtb2RlKS4NCj4gDQo+IFVuZm9ydHVuYXRlbHksIHRoaXMgZm9yY2VzIGFsbCByZWFkcyBhbmQg
d3JpdGVzIHRvIGhhdmUgdGhlIHNhbWUNCj4gZ3JhbnVsYXJpdHkgKHdlIG9ubHkgbmVlZCB0aGlz
IGFsaWdubWVudCBmb3Igd3JpdGVzIHRvIHRoZSB0YXJnZXQsIG5vdA0KPiB0aGUgc291cmNlKSwg
YnV0IHRoYXQgaXMgc29tZXRoaW5nIHRvIGJlIGZpeGVkIGFub3RoZXIgdGltZS4NCj4gDQo+IENj
OiBxZW11LXN0YWJsZUBub25nbnUub3JnDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJl
aXR6QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiB2MjogRml4IHRoZSBwbGFjZW1lbnQgb2Ygb3VyIGJk
cnZfcmVmcmVzaF9saW1pdHMoKSBjYWxsIFtWbGFkaW1pcl0NCj4gLS0tDQo+ICAgYmxvY2svbWly
cm9yLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDI1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9taXJyb3IuYyBiL2Js
b2NrL21pcnJvci5jDQo+IGluZGV4IDhjYjc1ZmI0MDkuLjdmMGZmMDFiZWIgMTAwNjQ0DQo+IC0t
LSBhL2Jsb2NrL21pcnJvci5jDQo+ICsrKyBiL2Jsb2NrL21pcnJvci5jDQo+IEBAIC0xNDgxLDYg
KzE0ODEsMTUgQEAgc3RhdGljIHZvaWQgYmRydl9taXJyb3JfdG9wX2NoaWxkX3Blcm0oQmxvY2tE
cml2ZXJTdGF0ZSAqYnMsIEJkcnZDaGlsZCAqYywNCj4gICAgICAgKm5zaGFyZWQgPSBCTEtfUEVS
TV9BTEw7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIHZvaWQgYmRydl9taXJyb3JfdG9wX3JlZnJl
c2hfbGltaXRzKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBFcnJvciAqKmVycnApDQo+ICt7DQo+ICsg
ICAgTWlycm9yQkRTT3BhcXVlICpzID0gYnMtPm9wYXF1ZTsNCj4gKw0KPiArICAgIGlmIChzICYm
IHMtPmpvYiAmJiBzLT5qb2ItPmNvcHlfbW9kZSA9PSBNSVJST1JfQ09QWV9NT0RFX1dSSVRFX0JM
T0NLSU5HKSB7DQo+ICsgICAgICAgIGJzLT5ibC5yZXF1ZXN0X2FsaWdubWVudCA9IHMtPmpvYi0+
Z3JhbnVsYXJpdHk7DQo+ICsgICAgfQ0KPiArfQ0KPiArDQo+ICAgLyogRHVtbXkgbm9kZSB0aGF0
IHByb3ZpZGVzIGNvbnNpc3RlbnQgcmVhZCB0byBpdHMgdXNlcnMgd2l0aG91dCByZXF1aXJpbmcg
aXQNCj4gICAgKiBmcm9tIGl0cyBiYWNraW5nIGZpbGUgYW5kIHRoYXQgYWxsb3dzIHdyaXRlcyBv
biB0aGUgYmFja2luZyBmaWxlIGNoYWluLiAqLw0KPiAgIHN0YXRpYyBCbG9ja0RyaXZlciBiZHJ2
X21pcnJvcl90b3AgPSB7DQo+IEBAIC0xNDkzLDYgKzE1MDIsNyBAQCBzdGF0aWMgQmxvY2tEcml2
ZXIgYmRydl9taXJyb3JfdG9wID0gew0KPiAgICAgICAuYmRydl9jb19ibG9ja19zdGF0dXMgICAg
ICAgPSBiZHJ2X2NvX2Jsb2NrX3N0YXR1c19mcm9tX2JhY2tpbmcsDQo+ICAgICAgIC5iZHJ2X3Jl
ZnJlc2hfZmlsZW5hbWUgICAgICA9IGJkcnZfbWlycm9yX3RvcF9yZWZyZXNoX2ZpbGVuYW1lLA0K
PiAgICAgICAuYmRydl9jaGlsZF9wZXJtICAgICAgICAgICAgPSBiZHJ2X21pcnJvcl90b3BfY2hp
bGRfcGVybSwNCj4gKyAgICAuYmRydl9yZWZyZXNoX2xpbWl0cyAgICAgICAgPSBiZHJ2X21pcnJv
cl90b3BfcmVmcmVzaF9saW1pdHMsDQo+ICAgfTsNCj4gICANCj4gICBzdGF0aWMgQmxvY2tKb2Ig
Km1pcnJvcl9zdGFydF9qb2IoDQo+IEBAIC0xNjM3LDYgKzE2NDcsMjEgQEAgc3RhdGljIEJsb2Nr
Sm9iICptaXJyb3Jfc3RhcnRfam9iKA0KPiAgICAgICAgICAgcy0+c2hvdWxkX2NvbXBsZXRlID0g
dHJ1ZTsNCj4gICAgICAgfQ0KPiAgIA0KPiArICAgIC8qDQo+ICsgICAgICogTXVzdCBiZSBjYWxs
ZWQgYmVmb3JlIHdlIHN0YXJ0IHRyYWNraW5nIHdyaXRlcywgYnV0IGFmdGVyDQo+ICsgICAgICoN
Cj4gKyAgICAgKiAgICAgKChNaXJyb3JCbG9ja0pvYiAqKQ0KPiArICAgICAqICAgICAgICAgKChN
aXJyb3JCRFNPcGFxdWUgKikNCj4gKyAgICAgKiAgICAgICAgICAgICBtaXJyb3JfdG9wX2JzLT5v
cGFxdWUNCj4gKyAgICAgKiAgICAgICAgICktPmpvYg0KPiArICAgICAqICAgICApLT5jb3B5X21v
ZGUNCj4gKyAgICAgKg0KPiArICAgICAqIGhhcyB0aGUgY29ycmVjdCB2YWx1ZS4NCj4gKyAgICAg
KiAoV2Ugc3RhcnQgdHJhY2tpbmcgd3JpdGVzIGFzIG9mIHRoZSBmb2xsb3dpbmcNCj4gKyAgICAg
KiBiZHJ2X2NyZWF0ZV9kaXJ0eV9iaXRtYXAoKSBjYWxsLikNCj4gKyAgICAgKi8NCj4gKyAgICBi
ZHJ2X3JlZnJlc2hfbGltaXRzKG1pcnJvcl90b3BfYnMsICZlcnJvcl9hYm9ydCk7DQoNCkFsc28s
IEknbSBub3Qgc3VyZSBhYm91dCBlcnJvcl9hYm9ydCgpIGhlcmUuIHdoeSBub3QgdXNlIGxvY2Fs
X2VyciBhbmQgcmV0dXJuIE5VTEwNCmlmIGZhaWxlZD8NCg0KPiArDQo+ICAgICAgIHMtPmRpcnR5
X2JpdG1hcCA9IGJkcnZfY3JlYXRlX2RpcnR5X2JpdG1hcChicywgZ3JhbnVsYXJpdHksIE5VTEws
IGVycnApOw0KPiAgICAgICBpZiAoIXMtPmRpcnR5X2JpdG1hcCkgew0KPiAgICAgICAgICAgZ290
byBmYWlsOw0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

