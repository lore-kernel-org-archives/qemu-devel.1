Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4A8C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC922206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ge37bKwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC922206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84Rw-0001qc-JP
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i84J9-00033g-SF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i84J6-0001MA-Vo
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:13:22 -0400
Received: from mail-eopbgr20104.outbound.protection.outlook.com
 ([40.107.2.104]:26846 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i84J4-0001K4-Py; Wed, 11 Sep 2019 11:13:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUDW3WK/xVWc36ej/UMOgiCKPOoBRad6RveWh3Fudoh/Z2QvnYd60tMNZnhROW6lZSkadm08wEyaYiTavOrpx/+MfdLFxmGL5FVe7eCtFsWA5xj6I/d3yduNaWYvpRVlmIIIRn3ZJ5SH+4Pgeb7B1iCsqed4+UiikUgBvFnRWY5Y5AR0tSUaH7/5wwAv8ngZwlyu+gqzG7Rv5gGewQevZ1Bps7Ng/NJX4Mgm8C5/y4NgjmtQPnfL8ppMPheLtUXq2dwRn+EJzBYA9RZK87hQw1py6jeGU1+4/9MmUr4nxwug0qGkrCkOBAzQ5subwwKNVoXQdTTxdVdgy8simwCKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HanQN+R8P7sYL+RZLdrn0rtiOM7HJJPqUoFg3lbhC30=;
 b=WjIvIBYLoHsYW69rY64a1PiUs65wdvFYkPtIsjXMgjojH+mxfro1kO89FApj2n9swjvAeDmCJF8SqKzyDfy9Rb2iXUlT1fAMmXupw9jipY7S8N201dX2MBPat2u97C0EnaN1rcBxN5EJunhcmekNzFp/dieFDwmA6i6K5q2f6Sw/2lL85W/dr543XnNNyNkYVBdTe7vXZor+eAogzY+BTjyuepw7qC8lC5zglOydaPlpU/sW3JVWUDxvNOR7nkUnh3ITWxg3BBwGDdwVpoKp7J/TfJUtEPWcogN0iC7qATtYzPy2TCIdnAUgq81SWd3Ql+MTCXMD9xhpfReFBCI3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HanQN+R8P7sYL+RZLdrn0rtiOM7HJJPqUoFg3lbhC30=;
 b=Ge37bKwNrJR41lkYkcYOZDmrsMbeSGkbbIz1CtyoqVIKOwovkIhcNDgJviFH79Z0rv17u3zdPGYcMBvhxflBDcDxCNfHaj5IO1XdHScKp0p22FP3Mg393dMvaER6RzV5WyLvPWWMW+BWOXCSyX8WtzR/f4U1wbDRztfkwQKZ724=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5420.eurprd08.prod.outlook.com (52.133.241.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Wed, 11 Sep 2019 15:13:15 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Wed, 11 Sep 2019
 15:13:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2] util/hbitmap: strict hbitmap_reset
Thread-Index: AQHVTGtMH7YacSuUYU+otoBPFxph3abuSc2AgAA1KACAAWIfgIA27PGA
Date: Wed, 11 Sep 2019 15:13:15 +0000
Message-ID: <c773ab2c-368c-825e-dd51-5ff8b5060c2b@virtuozzo.com>
References: <20190806152611.280389-1-vsementsov@virtuozzo.com>
 <fa5f14a1-e05d-24e7-a51e-ad7737d5f4a1@redhat.com>
 <c0f0831f-851b-a76d-208c-22d97e4392d8@virtuozzo.com>
 <57111ad3-6acc-1027-2e5a-f203929e48b6@redhat.com>
In-Reply-To: <57111ad3-6acc-1027-2e5a-f203929e48b6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0164.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::12) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190911181313576
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b521403b-2581-413f-7577-08d736ca91ce
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5420; 
x-ms-traffictypediagnostic: DB8PR08MB5420:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB542035200C4CDC7C28D10E27C1B10@DB8PR08MB5420.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(39840400004)(376002)(136003)(396003)(189003)(199004)(64756008)(6306002)(11346002)(446003)(6246003)(31696002)(66476007)(66446008)(66946007)(2501003)(107886003)(2906002)(6512007)(6486002)(8936002)(81156014)(36756003)(81166006)(99286004)(476003)(4326008)(186003)(486006)(54906003)(2616005)(102836004)(386003)(26005)(76176011)(6436002)(86362001)(8676002)(53546011)(6506007)(7736002)(110136005)(305945005)(478600001)(66556008)(52116002)(256004)(14454004)(25786009)(316002)(71200400001)(71190400001)(53936002)(229853002)(14444005)(3846002)(31686004)(5660300002)(66066001)(6116002)(966005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5420;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fvjMEEyT5sTKEeibJCjYag2iXlznstQSGVGleteKOlOlcI2/lYurU0ZpaV5QZOuB9bzGk61NQWNvdzkUddw657QSBYv5JIJA5+JG5S2ESjnVDH79Bu9BeJxGRAtuV+ubtZv/vqmeXxLJ9MWXqbv4ikoFDGDzkfHQjJF9J/a2qQDqwJaIs7wKfENF4Ar2GDzxKBMcKgUf0JBZ1Afbyq0KZmkFxkFw+XaIZ00brF+VcDiIqooMTx/ybhay5iY0QX2mWb7WnEdSPJOcvCnUOaqbXhkKQPOScLbgAK7qJtljBvHTKLp5fvh/G93nWuhWt9Uy0t/XkMFJ7Z995dDASThywg3wNAHgLlbQwwQojL0DzauMXKvWfYobYc5CUqxmKSRKWRPwQXyx+bzVRTEJag5lRe+NjOF+tnLw3xuJMuHrBZQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AA79BC74BE74F4FBB5D5F0B9ED9BBE2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b521403b-2581-413f-7577-08d736ca91ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 15:13:15.6016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VGI0BJCUasX1smnng8zfy9FJ0NKU4PZHKkzF7ScvzZKd/eB5vWGF6bIjjMuGnG2q0JjxnxQZtj9pcL0tjEhOnMH+OMxCASJkpST/fPr7hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5420
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.104
Subject: Re: [Qemu-devel] [PATCH v2] util/hbitmap: strict hbitmap_reset
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMDguMjAxOSAxOToyNywgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDgvNi8xOSAx
MjoxOSBQTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDA2LjA4LjIw
MTkgMTk6MDksIE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwNi4wOC4xOSAxNzoyNiwgVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gaGJpdG1hcF9yZXNldCBoYXMgYW4g
dW5vYnZpb3VzIHByb3BlcnR5OiBpdCByb3VuZHMgcmVxdWVzdGVkIHJlZ2lvbiB1cC4NCj4+Pj4g
SXQgbWF5IHByb3Zva2UgYnVncywgbGlrZSBpbiByZWNlbnRseSBmaXhlZCB3cml0ZS1ibG9ja2lu
ZyBtb2RlIG9mDQo+Pj4+IG1pcnJvcjogdXNlciBjYWxscyByZXNldCBvbiB1bmFsaWduZWQgcmVn
aW9uLCBub3Qga2VlcGluZyBpbiBtaW5kIHRoYXQNCj4+Pj4gdGhlcmUgYXJlIHBvc3NpYmxlIHVu
cmVsYXRlZCBkaXJ0eSBieXRlcywgY292ZXJlZCBieSByb3VuZGVkLXVwIHJlZ2lvbg0KPj4+PiBh
bmQgaW5mb3JtYXRpb24gb2YgdGhpcyB1bnJlbGF0ZWQgImRpcnRpbmVzcyIgd2lsbCBiZSBsb3N0
Lg0KPj4+Pg0KPj4+PiBNYWtlIGhiaXRtYXBfcmVzZXQgc3RyaWN0OiBhc3NlcnQgdGhhdCBhcmd1
bWVudHMgYXJlIGFsaWduZWQsIGFsbG93aW5nDQo+Pj4+IG9ubHkgb25lIGV4Y2VwdGlvbiB3aGVu
IEBzdGFydCArIEBjb3VudCA9PSBoYi0+b3JpZ19zaXplLiBJdCdzIG5lZWRlZA0KPj4+PiB0byBj
b21mb3J0IHVzZXJzIG9mIGhiaXRtYXBfbmV4dF9kaXJ0eV9hcmVhLCB3aGljaCBjYXJlcyBhYm91
dA0KPj4+PiBoYi0+b3JpZ19zaXplLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1p
ciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4+IC0t
LQ0KPj4+Pg0KPj4+PiB2MiBiYXNlZCBvbiBNYXgncyBodHRwczovL2dpdGh1Yi5jb20vWGFuQ2xp
Yy9xZW11LmdpdCBibG9jaw0KPj4+PiB3aGljaCB3aWxsIGJlIG1lcmdlZCBzb29uIHRvIDQuMSwg
YW5kIHRoaXMgcGF0Y2ggZ29lcyB0byA0LjINCj4+Pj4gQmFzZWQtb246IGh0dHBzOi8vZ2l0aHVi
LmNvbS9YYW5DbGljL3FlbXUuZ2l0IGJsb2NrDQo+Pj4+DQo+Pj4+IHYxIHdhcyAiW1BBVENIXSB1
dGlsL2hiaXRtYXA6IGZpeCB1bmFsaWduZWQgcmVzZXQiLCBhbmQgYXMgSSB1bmRlcnN0YW5kDQo+
Pj4+IHdlIGFsbCBhZ3JlZWQgdG8ganVzdCBhc3NlcnQgYWxpZ25tZW50IGluc3RlYWQgb2YgYWxp
Z25pbmcgZG93bg0KPj4+PiBhdXRvbWF0aWNhbGx5Lg0KPj4+Pg0KPj4+PiAgICBpbmNsdWRlL3Fl
bXUvaGJpdG1hcC5oIHwgNSArKysrKw0KPj4+PiAgICB0ZXN0cy90ZXN0LWhiaXRtYXAuYyAgIHwg
MiArLQ0KPj4+PiAgICB1dGlsL2hiaXRtYXAuYyAgICAgICAgIHwgNCArKysrDQo+Pj4+ICAgIDMg
ZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0KPj4+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2hiaXRtYXAuaCBiL2luY2x1ZGUvcWVtdS9oYml0
bWFwLmgNCj4+Pj4gaW5kZXggNGFmYmU2MjkyZS4uNzg2NWU4MTljYSAxMDA2NDQNCj4+Pj4gLS0t
IGEvaW5jbHVkZS9xZW11L2hiaXRtYXAuaA0KPj4+PiArKysgYi9pbmNsdWRlL3FlbXUvaGJpdG1h
cC5oDQo+Pj4+IEBAIC0xMzIsNiArMTMyLDExIEBAIHZvaWQgaGJpdG1hcF9zZXQoSEJpdG1hcCAq
aGIsIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBjb3VudCk7DQo+Pj4+ICAgICAqIEBjb3VudDog
TnVtYmVyIG9mIGJpdHMgdG8gcmVzZXQuDQo+Pj4+ICAgICAqDQo+Pj4+ICAgICAqIFJlc2V0IGEg
Y29uc2VjdXRpdmUgcmFuZ2Ugb2YgYml0cyBpbiBhbiBIQml0bWFwLg0KPj4+PiArICogQHN0YXJ0
IGFuZCBAY291bnQgbXVzdCBiZSBhbGlnbmVkIHRvIGJpdG1hcCBncmFudWxhcml0eS4gVGhlIG9u
bHkgZXhjZXB0aW9uDQo+Pj4+ICsgKiBpcyByZXNldHRpbmcgdGhlIHRhaWwgb2YgdGhlIGJpdG1h
cDogQGNvdW50IG1heSBiZSBlcXVhbCB0byBAc3RhcnQgKw0KPj4+PiArICogaGItPm9yaWdfc2l6
ZSwNCj4+Pg0KPj4+IHMvQHN0YXJ0ICsgaGItPm9yaWdfc2l6ZS9oYi0+b3JpZ19zaXplIC0gQHN0
YXJ0LywgSSB0aGluay4NCj4+DQo+PiBIYSwgSSB3YW50ZWQgdG8gc2F5IHN0YXJ0ICsgY291bnQg
ZXF1YWwgdG8gb3JpZ19zaXplLiBZb3VycyBpcyBPSyB0b28gb2YgY291cnNlLg0KPj4NCj4+Pg0K
Pj4+PiAgICAgICBpbiB0aGlzIGNhc2UgQGNvdW50IG1heSBiZSBub3QgYWxpZ25lZC4gQHN0YXJ0
ICsgQGNvdW50DQo+Pj4NCj4+PiArYXJlDQo+Pj4NCj4+PiBXaXRoIHRob3NlIGZpeGVkOg0KPj4+
DQo+Pj4gUmV2aWV3ZWQtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+Pg0KPj4g
VGhhbmtzIQ0KPj4NCj4gDQo+IEknbGwgYWRkIHRoaXMgdG8gdGhlIHBpbGUgZm9yIDQuMiwgYWZ0
ZXIgSSBmaXggdGhlIHJlYmFzZSBjb25mbGljdHMgdGhhdA0KPiBhcm9zZSBmcm9tIDQuMS1yYzQu
DQo+IA0KDQpIaSENCg0KRGlkbid0IHlvdSBmb3JnZXQsIG9yIHNob3VsZCBJIHJlc2VuZD8NCg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

