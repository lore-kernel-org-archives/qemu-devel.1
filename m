Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59E5C5B57A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67118214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TWWB9Nfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67118214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgsl2-0001N9-Kp
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52820)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hgsaN-0002m9-Fd
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hgsaK-0005Yn-T9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:14:46 -0400
Received: from mail-am5eur03on0706.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::706]:51770
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hgsaK-0005WL-I5; Fri, 28 Jun 2019 11:14:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=nvZlTrZG6it0TlQ2wYecVQ16pJJlEUKJR76BAoC6qY+DQJxZ38ohOTqQuIFhUm+U0fxTMPLnFoSQKvTPKrO2IPCVZm8LC2s9pFTtSajgfacKEMFPlTCtjK05vEWMBWmjQS/DETprUjGNslVpWigWf5S5B4T2aLvMZT8GHiqvzO0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHrinij1C8e93YwUzmAT8ZrO0JJrTcp1cNMqmTwuTXc=;
 b=phIPjDtVu8/LFes6qBoHCneEkWFqthp/rPpcw2mPMdUK5bYR900y/fd1WxXDRowJTBML1vPp2WY8rq2crj8awm1XwLdIcMRebv0Qt6NlAcGZrhxau3DFvJWVkh9IV40mZBfoyxGz9mF1/kQcvisRQWQiFRQ1KqJxyTJtHe1dge4=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHrinij1C8e93YwUzmAT8ZrO0JJrTcp1cNMqmTwuTXc=;
 b=TWWB9Nfb9UKkAFTykAnIBMBs6IFDFUnJyuaum7Npxmp0X6STyAvqVU+g5AOUhz7HBPp4ckwJkEN0vY2pkGEk8NBFvql+M0fAGErecb5UOVJzBb85elZwcYP0nCm2YiwFGw3thbXvHYG2O/E3eX9wFWpu2p+TCLdPM4LOh4ss1vk=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3252.eurprd08.prod.outlook.com (52.134.94.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 15:14:41 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 15:14:41 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v0 2/3] qcow2: add compression type processing
Thread-Index: AQHVLZuN7Ey1lYD5REukjsp4qtAkE6aw7L0AgAAL2QCAAEBXgP//5kmAgAA2yID//9GEgIAAApCAgAADIAA=
Date: Fri, 28 Jun 2019 15:14:41 +0000
Message-ID: <3c60417d-a9a1-997d-3f51-d0d88da8d48e@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-3-dplotnikov@virtuozzo.com>
 <20190628102333.GG5179@dhcp-200-226.str.redhat.com>
 <08da0859-10da-5d4b-3203-72341a166255@virtuozzo.com>
 <20190628120622.GI5179@dhcp-200-226.str.redhat.com>
 <4fef0430-5a0c-36ca-eec0-a2c0ce10cb91@virtuozzo.com>
 <20190628142437.GL5179@dhcp-200-226.str.redhat.com>
 <bf5134a7-7c5e-2b28-9acb-3b82df982e1e@virtuozzo.com>
 <20190628145419.GM5179@dhcp-200-226.str.redhat.com>
 <c9e17ca7-db6a-8479-3caf-1f19fa3d7016@redhat.com>
In-Reply-To: <c9e17ca7-db6a-8479-3caf-1f19fa3d7016@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0022.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::32) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1625d621-b424-4c32-a150-08d6fbdb5825
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3252; 
x-ms-traffictypediagnostic: AM0PR08MB3252:
x-microsoft-antispam-prvs: <AM0PR08MB32527E0715260E3A168B4B19CFFC0@AM0PR08MB3252.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(53546011)(66066001)(81156014)(6246003)(71190400001)(478600001)(7736002)(107886003)(2906002)(81166006)(68736007)(31686004)(8676002)(66946007)(6512007)(54906003)(4326008)(305945005)(25786009)(6116002)(110136005)(316002)(53936002)(76176011)(186003)(3846002)(6506007)(8936002)(102836004)(86362001)(73956011)(6436002)(99286004)(36756003)(26005)(476003)(31696002)(66476007)(256004)(229853002)(5660300002)(486006)(64756008)(66556008)(11346002)(446003)(386003)(71200400001)(66446008)(6486002)(2616005)(14454004)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3252;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fx+hPDW6aTvmCLg0gjv/56FHa135sToxVAGyj1P7rrFuCsJ3dtU0MiEumVVkKr7a8SbvbH5DAnZQbe5iUDE1sJOI5Jor/H2oRO1NE9T0rys3uL3aX9QRtqne4AeiITsH+wZyfFxeV5fWSxhSB/+83u972YQR0DvH8ujK92kYcrXwQRnXoWgOqHSi6YVBf3Ncf7t7qnFscW7dI5IuMlkEO2c2U6PNw6C4DscbzGbV/cACz3BroaEMq8GFr8kmr+4DWsf7P2R2rad3Px0wFerVFE7ewCXuIoJWkqGs8WAgibX1Fq4mghkPHeinkTv1/YH97qJOCEwRMFX1WcqttDA4hChr9cM/klHMbZz/snx2Kq9OSfrU85qKtFS76Qeb5HXFdyF0qf6mWkhdqR7va6rE5s4KlrDf3/Nk5Umgl/6RHSU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A6F202709178D4E812508510F0167E6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1625d621-b424-4c32-a150-08d6fbdb5825
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 15:14:41.7363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3252
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::706
Subject: Re: [Qemu-devel] [PATCH v0 2/3] qcow2: add compression type
 processing
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI4LjA2LjIwMTkgMTg6MDMsIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMjguMDYuMTkg
MTY6NTQsIEtldmluIFdvbGYgd3JvdGU6DQo+PiBBbSAyOC4wNi4yMDE5IHVtIDE2OjQwIGhhdCBE
ZW5pcyBQbG90bmlrb3YgZ2VzY2hyaWViZW46DQo+Pj4NCj4+Pg0KPj4+IE9uIDI4LjA2LjIwMTkg
MTc6MjQsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4+IEFtIDI4LjA2LjIwMTkgdW0gMTQ6NTYgaGF0
IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gT24gMjgu
MDYuMjAxOSAxNTowNiwgS2V2aW4gV29sZiB3cm90ZToNCj4+Pj4+PiBBbSAyOC4wNi4yMDE5IHVt
IDEzOjI0IGhhdCBEZW5pcyBQbG90bmlrb3YgZ2VzY2hyaWViZW46DQo+Pj4+Pj4+DQo+Pj4+Pj4+
DQo+Pj4+Pj4+IE9uIDI4LjA2LjIwMTkgMTM6MjMsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4+Pj4+
PiBBbSAyOC4wNS4yMDE5IHVtIDE2OjM3IGhhdCBEZW5pcyBQbG90bmlrb3YgZ2VzY2hyaWViZW46
DQo+Pj4+Pj4+Pj4gV2l0aCB0aGUgcGF0Y2gsIHFjb3cyIGlzIGFibGUgdG8gcHJvY2VzcyBpbWFn
ZSBjb21wcmVzc2lvbiB0eXBlDQo+Pj4+Pj4+Pj4gZGVmaW5lZCBpbiB0aGUgaW1hZ2UgaGVhZGVy
IGFuZCBjaG9vc2UgdGhlIGNvcnJlc3BvbmRpbmcgbWV0aG9kDQo+Pj4+Pj4+Pj4gZm9yIGNsdXN0
ZXJzIGNvbXByZXNzaW5nLg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gQWxzbywgaXQgcmV3b3JrIHRo
ZSBjbHVzdGVyIGNvbXByZXNzaW9uIGNvZGUgZm9yIGFkZGluZyBtb3JlDQo+Pj4+Pj4+Pj4gY29t
cHJlc3Npb24gdHlwZXMuDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBEZW5p
cyBQbG90bmlrb3YgPGRwbG90bmlrb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4+Pj4+PiAtLS0NCj4+
Pj4+Pj4+PiAgICAgIGJsb2NrL3Fjb3cyLmMgfCAxMDMgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4+Pj4+Pj4+PiAgICAgIDEgZmlsZSBjaGFuZ2Vk
LCA5MiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+
IGRpZmYgLS1naXQgYS9ibG9jay9xY293Mi5jIGIvYmxvY2svcWNvdzIuYw0KPj4+Pj4+Pj4+IGlu
ZGV4IGM0YjViOTM0MDguLjkwZjE1Y2MzYzkgMTAwNjQ0DQo+Pj4+Pj4+Pj4gLS0tIGEvYmxvY2sv
cWNvdzIuYw0KPj4+Pj4+Pj4+ICsrKyBiL2Jsb2NrL3Fjb3cyLmMNCj4+Pj4+Pj4+PiBAQCAtNDAw
LDExICs0MDAsMzkgQEAgc3RhdGljIGludCBxY293Ml9yZWFkX2V4dGVuc2lvbnMoQmxvY2tEcml2
ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IHN0YXJ0X29mZnNldCwNCj4+Pj4+Pj4+PiAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPj4+Pj4+Pj4+ICAgICAgDQo+Pj4+Pj4+Pj4gICAgICAgICAgICAgIGNh
c2UgUUNPVzJfRVhUX01BR0lDX0NPTVBSRVNTSU9OX1RZUEU6DQo+Pj4+Pj4+Pj4gKyAgICAgICAg
ICAgIC8qIENvbXByZXNzaW9uIHR5cGUgYWx3YXlzIGdvZXMgd2l0aCB0aGUgY29tcHJlc3Npb24g
dHlwZSBiaXQgc2V0ICovDQo+Pj4+Pj4+Pj4gKyAgICAgICAgICAgIGlmICghKHMtPmluY29tcGF0
aWJsZV9mZWF0dXJlcyAmIFFDT1cyX0lOQ09NUEFUX0NPTVBSRVNTSU9OX1RZUEUpKSB7DQo+Pj4+
Pj4+Pj4gKyAgICAgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsDQo+Pj4+Pj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICJjb21wcmVzc2lvbl90eXBlX2V4dDogIg0KPj4+Pj4+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAiZXhwZWN0IGNvbXByZXNzaW9uIHR5cGUgYml0
IHNldCIpOw0KPj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4+
Pj4+Pj4gKyAgICAgICAgICAgIH0NCj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4gKyAgICAgICAgICAg
IHJldCA9IGJkcnZfcHJlYWQoYnMtPmZpbGUsIG9mZnNldCwgJnMtPmNvbXByZXNzaW9uX3R5cGUs
IGV4dC5sZW4pOw0KPj4+Pj4+Pj4+ICsgICAgICAgICAgICBzLT5jb21wcmVzc2lvbl90eXBlID0g
YmUzMl90b19jcHUocy0+Y29tcHJlc3Npb25fdHlwZSk7DQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+
ICsgICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAg
ZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCAtcmV0LA0KPj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAiRVJST1I6IENvdWxkIG5vdCByZWFkIGNvbXByZXNzaW9uIHR5cGUi
KTsNCj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+Pj4+Pj4+Pj4gKyAg
ICAgICAgICAgIH0NCj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAvKg0K
Pj4+Pj4+Pj4+IC0gICAgICAgICAgICAgKiBTZXR0aW5nIGNvbXByZXNzaW9uIHR5cGUgdG8gQkRS
VlFjb3cyU3RhdGUtPmNvbXByZXNzaW9uX3R5cGUNCj4+Pj4+Pj4+PiAtICAgICAgICAgICAgICog
ZnJvbSB0aGUgaW1hZ2UgaGVhZGVyIGlzIGdvaW5nIHRvIGJlIGhlcmUNCj4+Pj4+Pj4+PiArICAg
ICAgICAgICAgICogVGhlIGRlZmF1bHQgY29tcHJlc3Npb24gdHlwZSBpcyBub3QgYWxsb3dlZCB3
aGVuIHRoZSBleHRlbnNpb24NCj4+Pj4+Pj4+PiArICAgICAgICAgICAgICogaXMgcHJlc2VudC4g
WkxJQiBpcyB1c2VkIGFzIHRoZSBkZWZhdWx0IGNvbXByZXNzaW9uIHR5cGUuDQo+Pj4+Pj4+Pj4g
KyAgICAgICAgICAgICAqIFdoZW4gY29tcHJlc3Npb24gdHlwZSBleHRlbnNpb24gaGVhZGVyIGlz
IHByZXNlbnQgdGhlbg0KPj4+Pj4+Pj4+ICsgICAgICAgICAgICAgKiBjb21wcmVzc2lvbl90eXBl
IHNob3VsZCBoYXZlIGEgdmFsdWUgZGlmZmVyZW50IGZyb20gdGhlIGRlZmF1bHQuDQo+Pj4+Pj4+
Pj4gICAgICAgICAgICAgICAgICAgKi8NCj4+Pj4+Pj4+PiAtICAgICAgICAgICAgIGJyZWFrOw0K
Pj4+Pj4+Pj4+ICsgICAgICAgICAgICBpZiAocy0+Y29tcHJlc3Npb25fdHlwZSA9PSBRQ09XMl9D
T01QUkVTU0lPTl9UWVBFX1pMSUIpIHsNCj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgIGVycm9y
X3NldGcoZXJycCwNCj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgImNvbXBy
ZXNzaW9uX3R5cGVfZXh0OiINCj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ImludmFsaWQgY29tcHJlc3Npb24gdHlwZSAlZCIsDQo+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFFDT1cyX0NPTVBSRVNTSU9OX1RZUEVfWkxJQik7DQo+Pj4+Pj4+Pj4gKyAg
ICAgICAgICAgIH0NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBUaGlzIGlzIGEgcmVzdHJpY3Rpb24gdGhh
dCB0aGUgc3BlYyBkb2Vzbid0IG1ha2UsIHNvIHN0cmljdGx5IHNwZWFraW5nDQo+Pj4+Pj4+PiB0
aGlzIGltcGxlbWVudGF0aW9uIHdvdWxkbid0IGJlIGNvbXBsaWFudCB0byB0aGUgc3BlYy4NCj4+
Pj4+Pj4gVGhlIGlkZWEgaXMgdGhhdCBaTElCIHNob3VsZG4ndCBhcHBlYXIgaW4gdGhlIGNvbXBy
ZXNzaW9uIHR5cGUNCj4+Pj4+Pj4gZXh0ZW5zaW9uLiBUaGlzIGFsbG93cyBpbWFnZSBiYWNrd2Fy
ZCBjb21wYXRpYmlsaXR5IHdpdGggYW4gb2xkZXIgcWVtdQ0KPj4+Pj4+PiBpZiB6bGliIGlzIHVz
ZWQuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoZXJlIGlzIG5vIHJlYXNvbiB0byBzZXQgWkxJQiBpbiB0
aGUgZXh0ZW5zaW9uIGJlY2F1c2UgYW4gb2xkZXIgcWVtdQ0KPj4+Pj4+PiBrbm93cyBob3cgdG8g
dHJlYWQgWkxJQiBjb21wcmVzc2VkIGNsdXN0ZXJzLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBUaGUgcmVz
dHJpY3Rpb24gYWltcyB0byBndWFyYW50ZWUgdGhhdC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSSB0cmll
ZCB0byBkZXNjcmliZSB0aGlzIGNhc2UgaW4gdGhlIHNwZWNpZmljYXRpb246DQo+Pj4+Pj4+IC4u
Lg0KPj4+Pj4+PiBXaGVuIHRoZSBjb21wcmVzc2lvbiB0eXBlIGJpdCBpcyBub3Qgc2V0LCBhbmQg
dGhlIGNvbXByZXNzaW9uIHR5cGUNCj4+Pj4+Pj4gaGVhZGVyIGV4dGVuc2lvbiBpcyBhYnNlbnQs
IFpMSUIgY29tcHJlc3Npb24gaXMgdXNlZCBmb3IgY29tcHJlc3NlZA0KPj4+Pj4+PiBjbHVzdGVy
cy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gUWVtdSB2ZXJzaW9ucyBvbGRlciB0aGFuIDQuMSBjYW4gdXNl
IGltYWdlcyBjcmVhdGVkIHdpdGggY29tcHJlc3Npb24NCj4+Pj4+Pj4gdHlwZSBaTElCIHdpdGhv
dXQgYW55IGFkZGl0aW9uYWwgcHJlcGFyYXRpb25zIGFuZCBjYW5ub3QgdXNlIGltYWdlcw0KPj4+
Pj4+PiBjcmVhdGVkIHdpdGggY29tcHJlc3Npb24gdHlwZXMgIT0gWkxJQi4NCj4+Pj4+Pj4gLi4u
DQo+Pj4+Pj4+DQo+Pj4+Pj4+IERvZXMgaXQgbWFrZXMgc2Vuc2U/DQo+Pj4+Pj4NCj4+Pj4+PiBU
aGlzIHRleHQgc2F5cyB0aGF0IHVzaW5nIHpsaWIgaW4gdGhlIGV4dGVuc2lvbiBpcyBub3QgbmVj
ZXNzYXJ5IGJlY2F1c2UNCj4+Pj4+PiBpdCdzIHRoZSBkZWZhdWx0LiBCdXQgaXQgZG9lc24ndCBz
YXkgdGhhdCB1c2luZyB6bGliIGluIHRoZSBleHRlbnNpb24gaXMNCj4+Pj4+PiBpbGxlZ2FsLg0K
Pj4+Pj4+DQo+Pj4+Pj4gSSBhZ3JlZSB0aGF0IHRoZXJlIGlzIG5vIGdvb2QgcmVhc29uIHRvIGNy
ZWF0ZSBhIGNvbXByZXNzaW9uIHR5cGUNCj4+Pj4+PiBleHRlbnNpb24gaWYgeW91IGhhdmUgemxp
Yi4gQnV0IGlzIHRoZXJlIGEgZ29vZCByZWFzb24gdG8gZm9yYmlkIGl0Pw0KPj4+Pj4gSSB0aGlu
ayB5ZXMsIGlmIHdlIGNyZWF0ZSBpbWFnZSB3aXRoIHRoZSBleHRlbnNpb24gc2V0IHRvIHpsaWIg
d2UNCj4+Pj4+IHByZXZlbnQgYW4gb2xkZXIgcWVtdSBmcm9tIHVzaW5nIHRoYXQgaW1hZ2UuIEZ1
cnRoZXJtb3JlLCB0byBhbGxvdyBvbGRlcg0KPj4+Pj4gcWVtdSB1c2luZyBzdWNoIGltYWdlcyB3
ZSBuZWVkIHRvIGNyZWF0ZSBzcGVjaWFsIGNvbnZlcnNpb24gcHJvY2VkdXJlDQo+Pj4+PiB3aGlj
aCBoYXMgdG8gcmVtb3ZlIHRoZSBleHRlbnNpb24gaGVhZGVyLg0KPj4+Pj4NCj4+Pj4+IElmIHps
aWIgaXMgYSAic3BlY2lhbCBjb21wcmVzc2lvbiB0eXBlIiB3aGljaCBpcyBhbHdheXMgc2V0IGJ5
IGRlZmF1bHQNCj4+Pj4+IHdpdGhvdXQgdGhlIGV4dGVuc2lvbiBoZWFkZXIgd2UnbGwgZ2V0IHJp
ZCBvZiBzdWNoIGltYWdlIGNvbnZlcnNpb24NCj4+Pj4+IHByb2NlZHVyZSBhbmQgYW4gb2xkZXIg
cWVtdSBjb3VsZCB1c2UgaXQgImFzIGlzIg0KPj4+Pj4NCj4+Pj4+IE1pZ2h0IGl0IHdvcmsgYXMg
YSBnb29kIHJlYXNvbj8NCj4+Pj4+DQo+Pj4+Pj4gSXQNCj4+Pj4+PiBvbmx5IHJlcXVpcmVzIHVz
IHRvIGFkZCBhcnRpZmljaWFsIHJlc3RyaWN0aW9ucyB0byBjb2RlIHRoYXQgd291bGQgd29yaw0K
Pj4+Pj4+IGZpbmUgd2l0aG91dCB0aGVtLg0KPj4+Pj4+DQo+Pj4+Pj4gRWl0aGVyIHdheSwgaWYg
d2Ugd2FudCB0byByZWplY3Qgc3VjaCBleHRlbnNpb25zLCB0aGUgc3BlYyBuZWVkcyB0byBzYXkN
Cj4+Pj4+PiB0aGF0IGl0J3MgaWxsZWdhbC4gQW5kIGlmIHRoZSBzcGVjIGFsbG93cyBzdWNoIGlt
YWdlcywgd2UgbXVzdCBhY2NlcHQNCj4+Pj4+PiB0aGVtLg0KPj4+Pj4gWWVzLCBpdCdzIHRydWUN
Cj4+Pj4+DQo+Pj4+PiBUaGUgb25seSByZWFzb25zIHRoYXQgemxpYiBjb21wcmVzc2lvbiB0eXBl
IGV2ZW4gZXhpc3RzIGluIHRoZQ0KPj4+Pj4gZW51bWVyYXRpb24gaXMgdG8gYXZvaWQgYW1iaWd1
aXR5IGZvciB1c2Vycy4NCj4+Pj4+IEZvciB0aGVtIGl0IG1heSBiZSBoYXJkIHRvIHVuZGVyc3Rh
bmQgd2h5IHRoZXkgY2FuIHNldCB6c3RkIGFuZCBjYW5ub3QNCj4+Pj4+IHNldCB6bGliIGFzIGNv
bXByZXNzaW9uIHR5cGUgYW5kIHRvIHJlYWxseSBzZXQgemxpYiB0aGV5IGhhdmUgdG8gc2V0IG5v
DQo+Pj4+PiBjb21wcmVzc2lvbiB0eXBlIHRvIG1ha2UgdGhlIGRlZmF1bHQgemxpYiB0byBhcHBs
eS4NCj4+Pj4+DQo+Pj4+PiBXaGVuIGEgdXNlciBzZXQgemxpYiBhcyBjb21wcmVzc2lvbiB0eXBl
IHRoZSBpbWFnZSBpcyBjcmVhdGVkIGFzIGJlZm9yZQ0KPj4+Pj4gdGhlIGV4dGVuc2lvbiBoZWFk
ZXIgd2VyZSBpbnRyb2R1Y2VkLg0KPj4+Pj4NCj4+Pj4+IFJlYXNvbmFibGU/DQo+Pj4+Pj4NCj4+
Pj4+Pj4+IFdlIGNhbiBkaXNjdXNzIHdoZXRoZXIgdGhlIGNvZGUgb3IgdGhlIHNwZWMgc2hvdWxk
IGJlIGNoYW5nZWQuIEF0IHRoZQ0KPj4+Pj4+Pj4gbW9tZW50LCBJIGRvbid0IHNlZSBhIGdvb2Qg
cmVhc29uIHRvIG1ha2UgdGhlIHJlc3RyaWN0aW9uDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+ICsjaWZk
ZWYgREVCVUdfRVhUDQo+Pj4+Pj4+Pj4gKyAgICAgICAgICAgIHByaW50ZigiUWNvdzI6IGltYWdl
IGNvbXByZXNzaW9uIHR5cGUgJXNcbiIsIHMtPmNvbXByZXNzaW9uX3R5cGUpOw0KPj4+Pj4+Pj4+
ICsjZW5kaWYNCj4+Pj4+Pj4+PiArICAgICAgICAgICAgYnJlYWs7DQo+Pj4+Pj4+Pj4gICAgICAN
Cj4+Pj4+Pj4+PiAgICAgICAgICAgICAgY2FzZSBRQ09XMl9FWFRfTUFHSUNfREFUQV9GSUxFOg0K
Pj4+Pj4+Pj4+ICAgICAgICAgICAgICB7DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gV2Ugd291bGQgc2F2
ZSBtb3N0IG9mIHRoaXMgY29kZSBpZiB3ZSBhZGRlZCBhIG5ldyBmaWVsZCB0byB0aGUgaGVhZGVy
DQo+Pj4+Pj4+PiBpbnN0ZWFkIG9mIGFkZGluZyBhIGhlYWRlciBleHRlbnNpb24uIE5vdCBzYXlp
bmcgdGhhdCB3ZSBzaG91bGQNCj4+Pj4+Pj4+IGRlZmluaXRlbHkgZG8gdGhpcywgYnV0IGxldCdz
IGRpc2N1c3MgaXQgYXQgbGVhc3QuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IElmIHdlIGFkZCB0aGUgbmV3
IGZpZWxkIHRvIHRoZSBoZWFkZXIgd2lsbCB0aGUgb2xkZXIgcWVtdSBiZSBhYmxlIHRvIHVzZQ0K
Pj4+Pj4+PiBpdC4gT3Igd2Ugd2lsbCBhZGQgdGhlIGhlYWRlciBvbmx5IGlmIG5lZWRlZCwgaS5l
LiBpZiBjb21wcmVzc2lvbl90eXBlDQo+Pj4+Pj4+ICE9IHpsaWINCj4+Pj4+Pg0KPj4+Pj4+IElu
Y3JlYXNpbmcgdGhlIGhlYWRlciBzaXplIGlzIGJhY2t3YXJkcyBjb21wYXRpYmxlLiBPbGRlciBx
ZW11IHZlcnNpb25zDQo+Pj4+Pj4gc2hvdWxkIGhhbmRsZSBzdWNoIGltYWdlcyBjb3JyZWN0bHku
IFRoZXkgd291bGQgc3RvcmUgdGhlIHVua25vd24gcGFydA0KPj4+Pj4+IG9mIHRoZSBoZWFkZXIg
aW4gcy0+dW5rbm93bl9oZWFkZXJfZmllbGRzIGFuZCBrZWVwIGl0IHVubW9kaWZpZWQgd2hlbg0K
Pj4+Pj4+IHVwZGF0aW5nIHRoZSBpbWFnZSBoZWFkZXIuDQo+Pj4+Pj4NCj4+Pj4+PiBXZSB3b3Vs
ZCBzdGlsbCBhZGQgdGhlIGluY29tcGF0aWJsZSBmZWF0dXJlIGZsYWcgZm9yIG5vbi16bGliLCBv
Zg0KPj4+Pj4+IGNvdXJzZS4NCj4+Pj4+IHNvLCB3ZSBiYXNpY2FsbHkgbmVlZCB0byBkbyB0aGUg
c2FtZTogc3RvcmUgY29tcHJlc3Npb24gdHlwZSBhbmQgZm9yYmlkDQo+Pj4+PiB0byB1c2UgYmVj
YXVzZSBvZiBmbGFnIGlmIG5vdCB6bGliLg0KPj4+Pj4NCj4+Pj4+IFNvdW5kcyBsaWtlIGl0IGRv
ZXNuJ3QgZGlmZmVyIHRoYXQgbXVjaCBmcm9tIHRoZSBleHRlbnNpb24gaGVhZGVyIGFwcHJvYWNo
Lg0KPj4+Pg0KPj4+PiBJdCBwcm92aWRlcyBtb3JlIG9yIGxlc3MgdGhlIHNhbWUgZnVuY3Rpb25h
bGl0eSwgYnV0IHdvdWxkIHByb2JhYmx5IG1ha2UNCj4+Pj4gdGhpcyBwYXRjaCBoYWxmIHRoZSBz
aXplIGJlY2F1c2UgYWxsIG9mIHRoZSBjb2RlIHJlbGF0ZWQgdG8gcmVhZGluZyBhbmQNCj4+Pj4g
Y2hlY2tpbmcgdGhlIGhlYWRlciBleHRlbnNpb24gd291bGQgZ28gYXdheS4gSXQgYWxzbyBzYXZl
cyBhIGZldyBieXRlcw0KPj4+PiBpbiB0aGUgaGVhZGVyIGNsdXN0ZXIgKDQgYnl0ZXMgdnMuIDE2
IGJ5dGVzKS4NCj4+PiBvaywgd2lsbCByZS1kbyBpdCB0aGF0IHdheS4NCj4+Pg0KPj4+IERvIHlv
dSBhZ3JlZSBpbiBnZW5lcmFsIHdpdGggaG93IHpsaWIgY29tcHJlc3Npb24gdHlwZSBpcyB0cmVh
dGVkPw0KPj4NCj4+IEFzIEkgc2FpZCwgSSB0aGluayBib3RoIHdheXMgYXJlIGp1c3RpZmlhYmxl
IGFzIGxvbmcgYXMgd2Ugc3RheQ0KPj4gY29uc2lzdGVudCBiZXR3ZWVuIHFlbXUgYW5kIHNwZWMu
DQo+Pg0KPj4gSSdkIHByZWZlciB0byBhbGxvdyB6bGliIGluIHRoZSBleHRlbnNpb24sIHlvdSdk
IHByZWZlciB0byBmb3JiaWQgaXQuDQo+PiBTbyBJJ2QgbGlrZSB0byBoZWFyIG9waW5pb25zIGZy
b20gc29tZSBtb3JlIHBlb3BsZSBvbiB3aGljaCB3YXkgdGhleQ0KPj4gcHJlZmVyLg0KPiANCj4g
SSBkb27igJl0IHRoaW5rIGl04oCZcyBhbnkgYmV0dGVyIHRvIGNvbXBsZXRlbHkgZm9yYmlkIGl0
IHRoYW4gdG8ganVzdA0KPiByZWNvbW1lbmQgaW4gdGhlIHNwZWMgdGhhdCBzb2Z0d2FyZSBzaG91
bGQgbm90IHNldCB0aGlzIGZpZWxkIHRvIHpsaWIgdG8NCj4gZW5zdXJlIGJhY2t3YXJkcyBjb21w
YXRpYmlsaXR5Lg0KPiANCj4gSSBzZWUgdGhlIHBvaW50IG9mIGZvcmJpZGRpbmcgaXQsIGJ1dCBp
ZiBJIHdlcmUgdG8ga25vdyBub3RoaW5nIG9mIHFjb3cyDQo+IGFuZCByZWFkIHRoZSBzcGVjLCBJ
IGd1ZXNzIEnigJlkIGZpbmQgaXQgYSBiaXQgd2VpcmQgdG8gcmVhZCDigJxJZiB0aGlzDQo+IGZp
ZWxkIGlzIG5vdCBwcmVzZW50LCB0aGUgY29tcHJlc3Npb24gdHlwZSBpcyB6bGliOyBpZiBpdCBp
cywgaXQgaXMgbm90DQo+IHpsaWIsIGJ1dCB0aGUgc3BlY2lmaWVkIHZhbHVlLuKAnSAgSeKAmWQg
YXNrIG15c2VsZiB3aHkgaXQgaXNu4oCZdCBzaW1wbHkg4oCcVGhlDQo+IGNvbXByZXNzaW9uIHR5
cGUgaXMgZ2l2ZW4gYnkgdGhpcyBmaWVsZCwgaXQgZGVmYXVsdHMgdG8gemxpYi7igJ0NCj4gDQpB
cyBJIHVuZGVyc3Rvb2QsIGlmIHdlIGdvIHdpdGggdGhlIGhlYWRlciBleHRlbmRpbmcgd2UnbGwg
YWRkIGEgbmV3IA0KZmllbGQgaW4gdGhlIGhlYWRlciBhbnl3YXkgd2hpY2ggYWx3YXlzIGhvbGQg
c29tZSB2YWx1ZS4gQnksIGRlZmF1bHQgaXQgDQp3aWxsIGJlIHpsaWIuDQpTbywgdGhlIG9ubHkg
cXVlc3Rpb24gbm93IGlzIHdoZXRoZXIgd2UgYWxsb3cgemxpYiB2YWx1ZSB3aXRoIHRoZSANCmlu
Y29tcGF0aWJsZSBmZWF0dXJlIGZsYWcgc2V0LiBNeSBwb2ludCBpcyBpZiBjb21wcmVzc2lvbiB0
eXBlIGlzIHpsaWIgDQp0aGUgY29ycmVzcG9uZGluZyBpbmNvbXBhdGlibGUgZmVhdHVyZSBmbGFn
IHNob3VsZCBOT1QgYmUgc2V0Lg0KDQpJbiB0aGF0IGNhc2UgYW4gb2xkZXIgcWVtdSB3aWxsIHB1
dCB0aGUgY29tcHJlc3Npb24gdHlwZSB0byANCnMtPnVua25vd25faGVhZGVyX2ZpZWxkcyBhbmQg
cnVuIHdpdGggemxpYiwgb3RoZXJ3aXNlIGl0IGNvdWxkbid0IG9wZW4gDQp0aGUgZmlsZS4NCg0K
RGVuaXMNCj4gTWF4DQo+IA0KDQotLSANCkJlc3QsDQpEZW5pcw0K

