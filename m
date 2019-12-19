Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5E9C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 09:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF712465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 09:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iCbCwPJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF712465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihs3L-0006mA-W8
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 04:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihs2h-0006H5-F4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:24:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihs2f-0005VR-Q1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:24:22 -0500
Received: from mail-eopbgr20101.outbound.protection.outlook.com
 ([40.107.2.101]:29750 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihs2f-0005Hx-4E; Thu, 19 Dec 2019 04:24:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEJxsuOjKagVeLvYAxyrOZv8ti4MuWis5vboXWSfLH5U8Y81BEDPKJELws4L3rnS8y6X2GkBJTV0wfy2T6kFhzdi4bHT7OP4DuCIboXT6QRZUee2ZJ1HrLWhoVNVaH0sJeW1bJzuT/C2y7akItcx+Ueg+iBMqpzDEk2k9QVnmdXQGoFC7k9+RLLLydJJ++2Eo1qC9GY8qku+fHrE4BzAZcB4/TfFqSJ4R+nVRhC2RyiJUBqwQulfd35U4/Akd3XgY4dGP0zboJ3hoAU9bhxTUmozmphNhv5RNxXCYBeKYneynJogizrbNiT26nBbYcS4e+Vku+HHBNJGiC0PxYjspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDccCRgu5eKnzQUPXrai/H1nMdYBFyTLXYDhjVi0GBs=;
 b=Bhir9SWoVe6E5LyJcv982a4Sa59T4xsOW864rdfHknDnBGSl6j3Witi5v1g3o5APTqnZJgH4rJ5wz8kc/gVOOUjTFjUHmxkC+ymhBMhWhmt4SPZTICWiJwB7+4a8rPVWvWYeQcQ6LUQQjhqKFzBbGHCDx+tR7q7TXIcyLsQvNO6x75gMDhrryBoZYuMhjmexn4BAj6uRBx/SIvblHqY/4a5oCiftWPK2rzfOL3YYteigVwAAcCzusLYhd2X8s5BaailI3UGVhtJ5a2L7FEwbEA2WXipU4FkVzS2Ob/QLpojcFJmhqrxArBqGftzeOIMpwPRyd9egTZKnpfPSmweD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDccCRgu5eKnzQUPXrai/H1nMdYBFyTLXYDhjVi0GBs=;
 b=iCbCwPJGqFK3BODhmI49DuSmgh5n+1BQcR8oVSrdvDibWCbr+o2wa1pkyM5b79mDCPdpN4P9cpvL6lqtZGL/qAJMJGnrOamXm1mCZIAG4oQ2mMfewTC34fFyfVELujQjytpGmAJqwqDFpSFl8npAGmGx9vXN4NCS8tMJkK6AYOU=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3301.eurprd08.prod.outlook.com (52.135.164.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 09:24:18 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 09:24:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-4.2? v3 0/8] block: Fix resize (extending) of short
 overlays
Thread-Topic: [PATCH for-4.2? v3 0/8] block: Fix resize (extending) of short
 overlays
Thread-Index: AQHVoU6neqv907dUcE6t1HvrHyi33qezwPUAgA2Yl4A=
Date: Thu, 19 Dec 2019 09:24:17 +0000
Message-ID: <eed0efba-aa38-4901-8f10-6ec3ee339437@virtuozzo.com>
References: <20191122160511.8377-1-kwolf@redhat.com>
 <20191210174644.GC7103@linux.fritz.box>
In-Reply-To: <20191210174644.GC7103@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0044.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::33) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191219122414944
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 612dcf34-667c-40f9-b89b-08d7846538ef
x-ms-traffictypediagnostic: AM6PR08MB3301:
x-microsoft-antispam-prvs: <AM6PR08MB33016A133D6A9F025678B0C7C1520@AM6PR08MB3301.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39850400004)(376002)(346002)(396003)(189003)(199004)(186003)(66946007)(31696002)(66476007)(8676002)(66556008)(64756008)(66446008)(8936002)(316002)(26005)(2616005)(81156014)(81166006)(4326008)(6486002)(110136005)(54906003)(86362001)(71200400001)(6506007)(31686004)(6512007)(5660300002)(478600001)(2906002)(52116002)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3301;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /yeDhgHGSbnJ8+NiUshCj5YiRL0YSeRDAkJ+7Gd53layTQiLnVSStQxmPhHc7dhzMhIs+y3ogVJHXFz16oC/ljkqtnRy1hVXrp21zFjQhv42H2IZwnPxtKGNqQ5qTupJvK/v28f+S2DUICEHbwAiwjETjTHtIEMTMHTZ9PY2fzGJ18TjVl0emwNIGg5Nr3pt1+nUPXLGVyquS91Xts5/kxYO12KdJSrMQN/oBx02lORGGjN+lL/7SU7pou1JlVQNNtrHT27HUSyVyXcKFXFahAatyK+pDjVwvwrJ1WE1NEHxPKpW/ebiDt7Lk4nARlV71eW98tjYmoNFCfQc+6RbPWV/265AfpeZ0KoJUg3MmJ6C3W8uRXDce9q+oEmJUgIBKA8/tYJ7SWTuoqt8X08mIgOrJcJWM1ngw8UAonNezzeKavH6rF2sZ6Cp3+0ARmXA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2200D8AC572824CBB8662F19CBDF609@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612dcf34-667c-40f9-b89b-08d7846538ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 09:24:18.0011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/tyTolOaK/u/TM+pX0vJgnOb30IN9r8smmu53GvBXImK/53ivpIsEX2XSsce0WWgGNalUp3JMx38WOZBD1vseFDMC/dkiB70kC87RGwtQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3301
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.101
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMTIuMjAxOSAyMDo0NiwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMjIuMTEuMjAxOSB1bSAx
NzowNSBoYXQgS2V2aW4gV29sZiBnZXNjaHJpZWJlbjoNCj4+IFNlZSBwYXRjaCA0IGZvciB0aGUg
ZGVzY3JpcHRpb24gb2YgdGhlIGJ1ZyBmaXhlZC4NCj4gDQo+IEknbSBhcHBseWluZyBwYXRjaGVz
IDMgYW5kIDUtNyB0byB0aGUgYmxvY2sgYnJhbmNoIGJlY2F1c2UgdGhleSBtYWtlDQo+IHNlbnNl
IG9uIHRoZWlyIG93bi4NCj4gDQo+IFRoZSByZWFsIGZpeCB3aWxsIG5lZWQgYW5vdGhlciBhcHBy
b2FjaCBiZWNhdXNlIHRoZSBlcnJvciBoYW5kbGluZyBpcw0KPiBicm9rZW4gaW4gdGhpcyBvbmU6
IElmIHplcm9pbmcgb3V0IGZhaWxzIChlaXRoZXIgYmVjYXVzZSBvZiBOT19GQUxMQkFDSw0KPiBv
ciBiZWNhdXNlIG9mIHNvbWUgb3RoZXIgSS9PIGVycm9yKSwgYmRydl9jb190cnVuY2F0ZSgpIHdp
bGwgcmV0dXJuDQo+IGZhaWx1cmUsIGJ1dCB0aGUgaW1hZ2Ugc2l6ZSBoYXMgYWxyZWFkeSBiZWVu
IGluY3JlYXNlZCwgd2l0aCBwb3RlbnRpYWxseQ0KPiBpbmNvcnJlY3QgZGF0YSBpbiB0aGUgbmV3
IGFyZWEuDQo+IA0KPiBUbyBmaXggdGhpcywgd2UgbmVlZCB0byBtYWtlIHN1cmUgdGhhdCB6ZXJv
cyB3aWxsIGJlIHJlYWQgYmVmb3JlIHdlDQo+IGNvbW1pdCB0aGUgbmV3IGltYWdlIHNpemUgdG8g
dGhlIGltYWdlIGZpbGUgKGUuZy4gcWNvdzIgaGVhZGVyKSBhbmQgdG8NCj4gYnMtPnRvdGFsX3Nl
Y3RvcnMuIEluIG90aGVyIHdvcmRzLCBpdCBtdXN0IGJlY29tZSB0aGUgcmVzcG9uc2liaWxpdHkg
b2YNCj4gdGhlIGJsb2NrIGRyaXZlci4NCj4gDQo+IFRvIHRoaXMgZWZmZWN0LCBJJ20gcGxhbm5p
bmcgdG8gaW50cm9kdWNlIGEgUFJFQUxMT0NfTU9ERV9aRVJPX0lOSVQgZmxhZw0KPiB0aGF0IGNh
biBiZSBvcidlZCB0byB0aGUgcHJlYWxsb2NhdGlvbiBtb2RlLiBUaGlzIHdpbGwgZmFpbCBieSBk
ZWZhdWx0DQo+IGJlY2F1c2UgaXQgbG9va3MgbGlrZSBqdXN0IGFub3RoZXIgdW5pbXBsZW1lbnRl
ZCBwcmVhbGxvY2F0aW9uIG1vZGUgdG8NCj4gYmxvY2sgZHJpdmVycy4gSXQgd2lsbCBiZSByZXF1
ZXN0ZWQgZXhwbGljaXRseSBieSBjb21taXQgam9icyBhbmQNCj4gYXV0b21hdGljYWxseSBhZGRl
ZCBieSBiZHJ2X2NvX3RydW5jYXRlKCkgaWYgdGhlIGJhY2tpbmcgZmlsZSB3b3VsZA0KPiBiZWNv
bWUgdmlzaWJsZSAobGlrZSBpbiB0aGlzIHNlcmllcywgYnV0IG5vdyBmb3IgYWxsIHByZWFsbG9j
YXRpb24NCj4gbW9kZXMpLiBJJ20gcGxhbm5pbmcgdG8gaW1wbGVtZW50IGl0IGZvciBxY293MiBh
bmQgZmlsZS1wb3NpeCBmb3Igbm93LA0KPiB3aGljaCBzaG91bGQgY292ZXIgbW9zdCBpbnRlcmVz
dGluZyBjYXNlcy4NCj4gDQo+IERvZXMgdGhpcyBtYWtlIHNlbnNlIHRvIHlvdT8NCj4gDQoNClRo
aXMgc2hvdWxkIHdvcmsuIERvIHlvdSBzdGlsbCBoYXZlIHRoaXMgcGxhbiBpbiBhIHRpbWVsaW5l
Pw0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

