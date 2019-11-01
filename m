Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8D8CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 13:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBBB21734
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 13:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Uno49Aog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBBB21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQX7P-0006YH-8s
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 09:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1iQX6S-0005vs-Hk
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 09:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1iQX6Q-0000Ef-Dk
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 09:36:35 -0400
Received: from mail-am5eur03on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe08::703]:7680
 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1iQX6P-00007a-Gz; Fri, 01 Nov 2019 09:36:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmG8DzQdCnFoYPRfCapFNZ7Vvh/jR7150URnxbe2uTxFdb+kuQd5y/4EbtrZ/Rf9bcTCipG3TAzGMNkNyJSjR8quUR089CSmeDbW2aI0QaHBpLgVGUSOKSLkIKOTAqr27ULgd5LptWiJarEQl0AkILwsi6al5XObrKzFdlFdkM2FiECuRxtx9iGA0kdFLY2WZl5jv70+C2cp/HMUTKPOtsWqHpNS3Ce/5ZGaqsmui57Rrg0FOwaHREHNpKv3vcKVukYz4qZ5/iCjamBtFSCrJU+E+BkhXcjMWtO1Iaj4zQafcrqsx1Wlz3jbUxwKRVzMmzvoUSTj+LBRkizbRWfAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+P+Pr+7meBAqqYu9FGNaBA24Mq7pePwQAwAVpoJvP4=;
 b=EYOmkcXYndipVSsn8A7exufOcSomGKJmC6lRpNLWS1S2Ko5a3sTkGVclDsa0dBi7vrole7daEOCdxLGjh/WkzGiraMi7BESc6LgxtElJt1Ks9HQ/U3oFHo6nOCMSerlLaj9fkeL4Dp11PSA/g+lzNWVwn3C/bm7Brq2DsC0RMW7PtsRalpZT35urtAK9VuR9TP4RdeNSyr1GZoYUONExAxVeMZ38SRPv2bWBRdhP97ey0gt07LhX63jYsEgoMconW0IJGZfrFXOTg+bhacAEoL+PPIv8OT2WrXeCxX1hZfjC8VtQUFL0jNxDu4ZvfUrwUiEBsdt32WbwzuZv6UOfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+P+Pr+7meBAqqYu9FGNaBA24Mq7pePwQAwAVpoJvP4=;
 b=Uno49AogBCDpMqoOJHNNuqCz1EmpukFbXJ/fBZxlNXDgefnp/eSik9GOQ7hMQCnlR1klsl3xdOnQplBEBTuAEXGjZKxKgyfNqC7JgdH8Ix8mIFIJRM7gtugv+PeCNKc01Lv0Bg9zvT56NP8sesXCFix895+1C7iJBlNb7/zuEi0=
Received: from DB7PR08MB3052.eurprd08.prod.outlook.com (52.135.131.139) by
 DB7PR08MB3788.eurprd08.prod.outlook.com (20.178.84.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 13:36:25 +0000
Received: from DB7PR08MB3052.eurprd08.prod.outlook.com
 ([fe80::b0a9:80ac:af62:a71e]) by DB7PR08MB3052.eurprd08.prod.outlook.com
 ([fe80::b0a9:80ac:af62:a71e%6]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 13:36:25 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz
 <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
Thread-Topic: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
Thread-Index: AQHVkJs1nNWugfYf7EOzXc04zyxgzKd2Gq6AgAA0uAD//9oFAIAAM1yA///Ou4CAABSTgIAACcsAgAAHnAA=
Date: Fri, 1 Nov 2019 13:36:24 +0000
Message-ID: <120056dc-0c4c-e477-4d5b-2cc2ef5f32fb@virtuozzo.com>
References: <20191101100019.9512-1-mreitz@redhat.com>
 <fbf32283-2ec5-28ae-f4c9-5bd7d4af7b3f@redhat.com>
 <783a805a-3a3a-e8c5-41ac-f6476378975e@virtuozzo.com>
 <908ffc42-8328-969d-641b-4596ec0b6b45@redhat.com>
 <fb5ae941-622f-c82d-9eb8-be3fe66e3fb6@virtuozzo.com>
 <909d8474-0e8f-b9b9-5647-b604f956900a@redhat.com>
 <c252753e-c67a-be46-1136-d0d7d9e642e7@redhat.com>
 <e80f5808-a450-3019-1b1f-b718c9bae6f5@virtuozzo.com>
In-Reply-To: <e80f5808-a450-3019-1b1f-b718c9bae6f5@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0308.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::32) To DB7PR08MB3052.eurprd08.prod.outlook.com
 (2603:10a6:5:28::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [91.217.168.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7d48b5f-d5d5-4717-948e-08d75ed07d8c
x-ms-traffictypediagnostic: DB7PR08MB3788:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR08MB3788EB5AA45D88D1D7A15557B6620@DB7PR08MB3788.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(346002)(366004)(39840400004)(189003)(199004)(504964003)(52314003)(66476007)(6306002)(26005)(305945005)(6512007)(2906002)(7736002)(186003)(229853002)(6436002)(5660300002)(6486002)(81166006)(3846002)(6116002)(81156014)(8676002)(8936002)(316002)(446003)(11346002)(486006)(2616005)(476003)(76176011)(6506007)(53546011)(102836004)(66066001)(386003)(478600001)(71190400001)(31696002)(25786009)(2501003)(256004)(14444005)(66946007)(36756003)(71200400001)(110136005)(54906003)(6246003)(4326008)(31686004)(107886003)(14454004)(52116002)(99286004)(86362001)(66556008)(64756008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3788;
 H:DB7PR08MB3052.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ei30+lHbJSd9iRCbt+H5pTFnLG7em4Z28ERXlCN6mb5OPwV+9wK0s+xcmoMgx70GF2PmrFa/qWZai5dnLr84DUfeW757PMxX6p4r0XRNM8nF+YAy6Lgtr1anu4WZGEB5jQkS9BoFyROr4kmWf8k73OI0KN6RTzcsiwmGw03+SR3OlV1W6qa0D4yGfMSajX3mSufPN6woSonZxAfyIiP3sfdjg1GQTCP4jPnI2VV187B0ncnBIZxMuRpzY1XWMLKZrPw99v12BBjXIqFBtbbC93fGc/7jwXSlz+11kJPPIXc9EDGgUgWJhuQhpueLnYpJtDkMvnKqLJJFRUhganQ48uaXSQgxQ6Nnyd2pFRRQWRejNegPucRsZO80yjf5XJQuUYevjPOLYt+/6dJDLAQme075pJw+tTPL2pWLA6NeQ32xMKumNa/dgHMRDW1fB5bLtEdMoyGY2Xw60Exm7q2rZz8QdaHCpUk+KJXfosxIR2o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B1A2C1D4A2BE843AAB80F4F8D0F00DD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d48b5f-d5d5-4717-948e-08d75ed07d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 13:36:25.0027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lUxiH9R14fu4Z4fhBXS8tdxjwPoenUkk5maBKtR+AU9JMHATWkjHBtVIKVd2Y9AYpHS3VGIP9lI+65DKtBYaSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3788
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::703
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTEvMS8xOSA0OjA5IFBNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0K
PiAwMS4xMS4yMDE5IDE1OjM0LCBNYXggUmVpdHogd3JvdGU6DQo+PiBPbiAwMS4xMS4xOSAxMjoy
MCwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+IE9uIDAxLjExLjE5IDEyOjE2LCBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+PiAwMS4xMS4yMDE5IDE0OjEyLCBNYXggUmVpdHog
d3JvdGU6DQo+Pj4+PiBPbiAwMS4xMS4xOSAxMToyOCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSB3cm90ZToNCj4+Pj4+PiAwMS4xMS4yMDE5IDEzOjIwLCBNYXggUmVpdHogd3JvdGU6DQo+
Pj4+Pj4+IE9uIDAxLjExLjE5IDExOjAwLCBNYXggUmVpdHogd3JvdGU6DQo+Pj4+Pj4+PiBIaSwN
Cj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBUaGlzIHNlcmllcyBidWlsZHMgb24gdGhlIHByZXZpb3VzIFJG
Qy4gIFRoZSB3b3JrYXJvdW5kIGlzIG5vdyBhcHBsaWVkDQo+Pj4+Pj4+PiB1bmNvbmRpdGlvbmFs
bHkgb2YgQUlPIG1vZGUgYW5kIGZpbGVzeXN0ZW0gYmVjYXVzZSB3ZSBkb27igJl0IGtub3cgdGhv
c2UNCj4+Pj4+Pj4+IHRoaW5ncyBmb3IgcmVtb3RlIGZpbGVzeXN0ZW1zLiAgRnVydGhlcm1vcmUs
IGJkcnZfY29fZ2V0X3NlbGZfcmVxdWVzdCgpDQo+Pj4+Pj4+PiBoYXMgYmVlbiBtb3ZlZCB0byBi
bG9jay9pby5jLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEFwcGx5aW5nIHRoZSB3b3JrYXJvdW5kIHVu
Y29uZGl0aW9uYWxseSBpcyBmaW5lIGZyb20gYSBwZXJmb3JtYW5jZQ0KPj4+Pj4+Pj4gc3RhbmRw
b2ludCwgYmVjYXVzZSBpdCBzaG91bGQgYWN0dWFsbHkgYmUgZGVhZCBjb2RlLCB0aGFua3MgdG8g
cGF0Y2ggMQ0KPj4+Pj4+Pj4gKHRoZSBlbGVwaGFudCBpbiB0aGUgcm9vbSkuICBBcyBmYXIgYXMg
SSBrbm93LCB0aGVyZSBpcyBubyBvdGhlciBibG9jaw0KPj4+Pj4+Pj4gZHJpdmVyIGJ1dCBxY293
MiBpbiBoYW5kbGVfYWxsb2Nfc3BhY2UoKSB0aGF0IHdvdWxkIHN1Ym1pdCB6ZXJvIHdyaXRlcw0K
Pj4+Pj4+Pj4gYXMgcGFydCBvZiBub3JtYWwgSS9PIHNvIGl0IGNhbiBvY2N1ciBjb25jdXJyZW50
bHkgdG8gb3RoZXIgd3JpdGUNCj4+Pj4+Pj4+IHJlcXVlc3RzLiAgSXQgc3RpbGwgbWFrZXMgc2Vu
c2UgdG8gdGFrZSB0aGUgd29ya2Fyb3VuZCBmb3IgZmlsZS1wb3NpeA0KPj4+Pj4+Pj4gYmVjYXVz
ZSB3ZSBjYW7igJl0IHJlYWxseSBwcmV2ZW50IHRoYXQgYW55IG90aGVyIGJsb2NrIGRyaXZlciB3
aWxsIHN1Ym1pdA0KPj4+Pj4+Pj4gemVybyB3cml0ZXMgYXMgcGFydCBvZiBub3JtYWwgSS9PIGlu
IHRoZSBmdXR1cmUuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gQW55d2F5LCBsZXTigJlzIGdldCB0byB0
aGUgZWxlcGhhbnQuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gICAgRnJvbSBpbnB1dCBieSBYRlMgZGV2
ZWxvcGVycw0KPj4+Pj4+Pj4gKGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5j
Z2k/aWQ9MTc2NTU0NyNjNykgaXQgc2VlbXMgY2xlYXINCj4+Pj4+Pj4+IHRoYXQgYzhiYjIzY2Jk
YmUgY2F1c2VzIGZ1bmRhbWVudGFsIHBlcmZvcm1hbmNlIHByb2JsZW1zIG9uIFhGUyB3aXRoDQo+
Pj4+Pj4+PiBhaW89bmF0aXZlIHRoYXQgY2Fubm90IGJlIGZpeGVkLiAgSW4gb3RoZXIgY2FzZXMs
IGM4YmIyM2NiZGJlIGltcHJvdmVzDQo+Pj4+Pj4+PiBwZXJmb3JtYW5jZSBvciB3ZSB3b3VsZG7i
gJl0IGhhdmUgaXQuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSW4gZ2VuZXJhbCwgYXZvaWRpbmcgcGVy
Zm9ybWFuY2UgcmVncmVzc2lvbnMgaXMgbW9yZSBpbXBvcnRhbnQgdGhhbg0KPj4+Pj4+Pj4gaW1w
cm92aW5nIHBlcmZvcm1hbmNlLCB1bmxlc3MgdGhlIHJlZ3Jlc3Npb25zIGFyZSBqdXN0IGEgbWlu
b3IgY29ybmVyDQo+Pj4+Pj4+PiBjYXNlIG9yIGluc2lnbmlmaWNhbnQgd2hlbiBjb21wYXJlZCB0
byB0aGUgaW1wcm92ZW1lbnQuICBUaGUgWEZTDQo+Pj4+Pj4+PiByZWdyZXNzaW9uIGlzIG5vIG1p
bm9yIGNvcm5lciBjYXNlLCBhbmQgaXQgaXNu4oCZdCBpbnNpZ25pZmljYW50LiAgTGF1cmVudA0K
Pj4+Pj4+Pj4gVml2aWVyIGhhcyBmb3VuZCBwZXJmb3JtYW5jZSB0byBkZWNyZWFzZSBieSBhcyBt
dWNoIGFzIDg4ICUgKG9uIHBwYzY0bGUsDQo+Pj4+Pj4+PiBmaW8gaW4gYSBndWVzdCB3aXRoIDRr
IGJsb2NrcywgaW9kZXB0aD04OiAxNjYyIGtCL3MgZnJvbSAxMy45IE1CL3MpLg0KPj4+Pj4+PiBB
aCwgY3JhcC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSSB3YW50ZWQgdG8gc2VuZCB0aGlzIHNlcmllcyBh
cyBlYXJseSB0b2RheSBhcyBwb3NzaWJsZSB0byBnZXQgYXMgbXVjaA0KPj4+Pj4+PiBmZWVkYmFj
ayBhcyBwb3NzaWJsZSwgc28gSeKAmXZlIG9ubHkgc3RhcnRlZCBkb2luZyBiZW5jaG1hcmtzIG5v
dy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVGhlIG9idmlvdXMNCj4+Pj4+Pj4NCj4+Pj4+Pj4gJCBxZW11
LWltZyBiZW5jaCAtdCBub25lIC1uIC13IC1TIDY1NTM2IHRlc3QucWNvdzINCj4+Pj4+Pj4NCj4+
Pj4+Pj4gb24gWEZTIHRha2VzIGxpa2UgNiBzZWNvbmRzIG9uIG1hc3RlciwgYW5kIGxpa2UgNTAg
dG8gODAgc2Vjb25kcyB3aXRoDQo+Pj4+Pj4+IGM4YmIyM2NiZGJlIHJldmVydGVkLiAgU28gbm93
IG9uIHRvIGd1ZXN0IHRlc3RzLi4uDQo+Pj4+Pj4gQWhhLCB0aGF0J3MgdmVyeSBpbnRlcmVzdGlu
ZykgV2hhdCBhYm91dCBhaW8tbmF0aXZlIHdoaWNoIHNob3VsZCBiZSBzbG93ZWQgZG93bj8NCj4+
Pj4+PiBDb3VsZCBpdCBiZSB0ZXN0ZWQgbGlrZSB0aGlzPw0KPj4+Pj4gVGhhdCBpcyBhaW89bmF0
aXZlICgtbikuDQo+Pj4+Pg0KPj4+Pj4gQnV0IHNvIGZhciBJIGRvbuKAmXQgc2VlIGFueSBzaWdu
aWZpY2FudCBkaWZmZXJlbmNlIGluIGd1ZXN0IHRlc3RzIChpLmUuLA0KPj4+Pj4gZmlvIC0tcnc9
d3JpdGUgLS1icz00ayAtLWlvZGVwdGg9OCAtLXJ1bnRpbWU9MW0gLS1kaXJlY3Q9MQ0KPj4+Pj4g
LS1pb2VuZ2luZT1saWJhaW8gLS10aHJlYWQgLS1udW1qb2JzPTE2IC0tc2l6ZT0yRyAtLXRpbWVf
YmFzZWQpLCBuZWl0aGVyDQo+Pj4+PiB3aXRoIDY0IGtCIG5vciB3aXRoIDIgTUIgY2x1c3RlcnMu
ICAoQnV0IG9ubHkgb24gWEZTLCBJ4oCZbGwgaGF2ZSB0byBzZWUNCj4+Pj4+IGFib3V0IGV4dDQg
c3RpbGwuKQ0KPj4+PiBobW0sIHRoaXMgcG9zc2libHkgbW9zdGx5IHRlc3RzIHdyaXRlcyB0byBh
bHJlYWR5IGFsbG9jYXRlZCBjbHVzdGVycy4gSGFzIGZpbw0KPj4+PiBhbiBvcHRpb24gdG8gYmVo
YXZlIGxpa2UgcWVtdS1pbWcgYmVuY2ggd2l0aCAtUyA2NTUzNiwgaS5lLiB3cml0ZSBvbmNlIGlu
dG8NCj4+Pj4gZWFjaCBjbHVzdGVyPw0KPj4+IE1heWJlLCBidXQgaXMgdGhhdCBhIHJlYWxpc3Rp
YyBkZXBpY3Rpb24gb2Ygd2hldGhlciB0aGlzIGNoYW5nZSBpcyB3b3J0aA0KPj4+IGl0PyAgVGhh
dCBpcyB3aHkgSeKAmW0gZG9pbmcgdGhlIGd1ZXN0IHRlc3QsIHRvIHNlZSB3aGV0aGVyIGl0IGFj
dHVhbGx5DQo+Pj4gaGFzIG11Y2ggaW1wYWN0IG9uIHRoZSBndWVzdC4NCj4+IEnigJl2ZSBjaGFu
Z2VkIHRoZSBhYm92ZSBmaW8gaW52b2NhdGlvbiB0byB1c2UgLS1ydz1yYW5kd3JpdGUgYW5kIGFk
ZGVkDQo+PiAtLWZhbGxvY2F0ZT1ub25lLiAgVGhlIHBlcmZvcm1hbmNlIHdlbnQgZG93biwgYnV0
IGl0IHdlbnQgZG93biBib3RoIHdpdGgNCj4+IGFuZCB3aXRob3V0IGM4YmIyM2NiZGJlLg0KPj4N
Cj4+IFNvIG9uIG15IFhGUyBzeXN0ZW0gKFhGUyBvbiBsdWtzIG9uIFNTRCksIEkgc2VlOg0KPj4g
LSB3aXRoIGM4YmIyM2NiZGJlOiAyNi4wIC0gMjcuOSBNQi9zDQo+PiAtIHdpdGhvdXQgYzhiYjIz
Y2JkYmU6IDI1LjYgLSAyNyBNQi9zDQo+Pg0KPj4gT24gbXkgZXh0NCBzeXN0ZW0gKG5hdGl2ZSBv
biBTU0QpLCBJIHNlZToNCj4+IC0gd2l0aDogMzkuNCAtIDQxLjUgTUIvcw0KPj4gLSB3aXRob3V0
OiAzOS40IC0gNDIuMCBNQi9zDQo+Pg0KPj4gU28gYmFzaWNhbGx5IG5vIGRpZmZlcmVuY2UgZm9y
IFhGUywgYW5kIHJlYWxseSBubyBkaWZmZXJlbmNlIGZvciBleHQ0Lg0KPj4gKEkgcmFuIHRoZXNl
IHRlc3RzIHdpdGggMiBNQiBjbHVzdGVycy4pDQo+Pg0KPiBIbW0uIEkgZG9uJ3Qga25vdy4gRm9y
IG1lIGl0IHNlZW1zIG9idmlvdXMgdGhhdCB6ZXJvaW5nIDJNIGNsdXN0ZXIgaXMgc2xvdywgYW5k
IHRoaXMNCj4gaXMgcHJvdmVkIGJ5IHNpbXBsZSB0ZXN0cyB3aXRoIHFlbXUtaW1nIGJlbmNoLCB0
aGF0IGZhbGxvY2F0ZSBpcyBmYXN0ZXIgdGhhbiB6ZXJvaW5nDQo+IG1vc3Qgb2YgdGhlIGNsdXN0
ZXIuDQo+DQo+IFNvLCBpZiBzb21lIGd1ZXN0IHRlc3QgZG9lc24ndCBzaG93IHRoZSBkaWZmZXJl
bmNlLCB0aGlzIG1lYW5zIHRoYXQgInNtYWxsIHdyaXRlIGludG8NCj4gbmV3IGNsdXN0ZXIiIGlz
IGVmZmVjdGl2ZWx5IHJhcmUgY2FzZSBpbiB0aGlzIHRlc3QuLiBBbmQgdGhpcyBkb2Vzbid0IHBy
b3ZlIHRoYXQgaXQncw0KPiBhbHdheXMgcmFyZSBhbmQgaW5zaWduaWZpY2FudC4NCj4NCj4gSSBk
b24ndCBzdXJlIHRoYXQgd2UgaGF2ZSBhIHJlYWwtd29ybGQgZXhhbXBsZSB0aGF0IHByb3ZlcyBu
ZWNlc3NpdHkgb2YgdGhpcyBvcHRpbWl6YXRpb24sDQo+IG9yIHdhcyB0aGVyZSBzb21lIG9yaWdp
bmFsIGJ1ZyBhYm91dCBsb3ctcGVyZm9ybWFuY2Ugd2hpY2ggd2FzIGZpeGVkIGJ5IHRoaXMgb3B0
aW1pemF0aW9uLi4NCj4gRGVuLCBBbnRvbiwgZG8gd2UgaGF2ZSBzb21ldGhpbmcgYWJvdXQgaXQ/
DQo+DQpzb3JyeSwgSSBoYXZlIG1pc3NlZCB0aGUgYmVnaW5uaW5nIG9mIHRoZSB0aHJlYWQuDQoN
CldoaWNoIGRyaXZlciBpcyB1c2VkIGZvciB2aXJ0dWFsIGRpc2sgLSBjYWNoZWQgb3Igbm9uLWNh
Y2hlZCBJTw0KaXMgdXNlZCBpbiBRRU1VPyBXZSB1c2Ugbm9uLWNhY2hlZCBieSBkZWZhdWx0IGFu
ZCB0aGlzIGNvdWxkDQptYWtlIGEgZGlmZmVyZW5jZSBzaWduaWZpY2FudGx5Lg0KDQpNYXgsDQoN
CmNhbiB5b3UgcGxzIHNoYXJlIHlvdXIgZG9tYWluLnhtbCBvZiB0aGUgZ3Vlc3QgY29uZmlnIGFu
ZA0KZmlvIGZpbGUgZm9yIGd1ZXN0LiBJIHdpbGwgcmVjaGVjayB0byBiZSAxMjAlIHN1cmUuDQoN
ClRoYW5rIHlvdSBpbiBhZHZhbmNlLA0KwqDCoMKgIERlbg0K

