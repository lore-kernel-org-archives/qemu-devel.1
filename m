Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF45CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 16:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4315C2084C
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 16:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gdEhVqBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4315C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOPPx-0007JF-7Q
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 12:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iOPOP-0004gk-JL
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iOPOO-0007Cv-DI
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 12:58:21 -0400
Received: from mail-eopbgr150101.outbound.protection.outlook.com
 ([40.107.15.101]:54336 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iOPOO-0007C1-7V; Sat, 26 Oct 2019 12:58:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceUBke/FMHpveKPn1gDmNZ5ja8WTqqmEllK79bzayndaunvd5xHdbm6jr7jgXyLRoJLxUa+POCerVvLh5rR+qGs8fQb7x/F0y8yoP1tURTd72qaKmfBiGDqqWiCiRxNPewtHXy4dmUqWj6E0j+xyXa1JCslVg4Dugd6vszrw2wuf/iv9jO0cXULMvB1AEkWovcY+wKG4noLQBfC2pAFjyeN0OeoEKPRQtbFIRg6mM+fK5hDOpfVUcxKdg2Ge6z2nKE8Bc9U6bD+qVJqjNoOan8ouQv9a+jvCu5o61sMoPC0ApmhSfA0JpMFNaqiUQzEKj5tzfGbz8BPUscYmZ0yObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iK+9KOSYuRbi9WRV+RXtNC+6DFch4LHxuFHlf+JXsZ0=;
 b=XWf2DGka3af0II2ZeBf4YAs4BbqOV8bwAb/XqsHFqd69Evh9PWmqAR4w/boYSXXl4C2+Wq3S8AEDXM+3BofZdB4oQO5P9nDQPraWi6jRLPvDUxNDhT76tuWRqYQPermtWff4izi28j5QXew4YzdGC7gyb2PUmAo9fcSdbvDdhW0qK2u58ql5S5wo66EU8e1Pqcu0wnGy5RZhhYBqwwSoKavOhndb+lRtbD10PdK8ULDgETdSPRkhqBYPu7Z8l1BVgklzBYWXXjNyLbFTOPOPwhES+GXWR2iby9Drh5pora3+RonnPM4U+Z1iMSgK9ZOY/22J1G7iaKhiJfJ3sLTOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iK+9KOSYuRbi9WRV+RXtNC+6DFch4LHxuFHlf+JXsZ0=;
 b=gdEhVqBjGcZBUgK9cTKAGEJOKVlwjUypVYLPSZI+ndiHn4YouI700IzQ1r0kCKHbMGrrO2WdIbkxzZKX8rR5Xd00EtQERNWI+cg7MrJ7m8TTiyCkoFHRE5Rz/77W7xgT6vsCQc+RPJmDc3QHIUq+YhLcXMGIdIrpuR7MLuwW3Kk=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB3969.eurprd08.prod.outlook.com (20.178.118.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Sat, 26 Oct 2019 16:58:17 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::dc12:c5b5:bd8e:f402]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::dc12:c5b5:bd8e:f402%4]) with mapi id 15.20.2387.025; Sat, 26 Oct 2019
 16:58:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH] qemu-iotests/iotests.py: improve assert_qmp message
Thread-Topic: [PATCH] qemu-iotests/iotests.py: improve assert_qmp message
Thread-Index: AQHVi+XgxJLbq0TJEkexRYeQ4KgjhqdsyZIAgABbvgA=
Date: Sat, 26 Oct 2019 16:58:17 +0000
Message-ID: <53de13a9-a312-6a33-3b3b-2a655cc1c3d3@virtuozzo.com>
References: <20191026101221.5506-1-vsementsov@virtuozzo.com>
 <8938c24a-4f3d-4df2-4c30-f1922242789b@redhat.com>
In-Reply-To: <8938c24a-4f3d-4df2-4c30-f1922242789b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0007.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::17)
 To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191026195814782
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8d7d295-37aa-4d84-ccae-08d75a35b260
x-ms-traffictypediagnostic: AM0PR08MB3969:
x-microsoft-antispam-prvs: <AM0PR08MB396980CD93771398F1B5E7C5C1640@AM0PR08MB3969.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0202D21D2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(136003)(366004)(39840400004)(346002)(189003)(199004)(229853002)(66066001)(31686004)(305945005)(7736002)(25786009)(4326008)(6116002)(8936002)(6486002)(6436002)(6246003)(6512007)(478600001)(316002)(486006)(31696002)(71200400001)(2616005)(476003)(14454004)(54906003)(71190400001)(5660300002)(86362001)(446003)(11346002)(102836004)(3846002)(386003)(6506007)(53546011)(66946007)(66476007)(2501003)(52116002)(256004)(8676002)(76176011)(36756003)(2906002)(186003)(99286004)(64756008)(66446008)(66556008)(26005)(81156014)(81166006)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3969;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GGlFv5kqNmsnRqnWRg423jXSBGPsOBry0hKumhysQdzp3ehNrcEL2ECNglILW6xrzyapDoydbGX6v2CsBSktvk8qnnFJ+qTEeXalcJ51Y6WdvZjVnd9slOFw1iZmY77sfhCozw9ceSd7LhANazLi9+rvQrskNONBKcdc73A4QX3/Un/oHbxi9pF+AV3WNKUVNRuN7R2I9JuA3FbqbQ4l78zW+jBeC0vtP4hHOWQUYvDUSNOWw28fjSjsYGO6N3InxIiN4mIUu63ecr12t2okI6YlRlRR4Hx/tb4jVlCy72qIBgcAxpTzrWhZAPpA01NaiPSeHoR0P+dDsTzexokxo4H1fi70mB6n5UJ8JkDOp6ydUC1qru/15zjpfuV5pdzFESc9mMs+sPK+BenyzDl7eQ1viFn+7+vlpSLdHSG0FcOtwHa80jGQlGqjrKalgeU2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <596A097F994D514C9DCB0A73DFA3B705@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d7d295-37aa-4d84-ccae-08d75a35b260
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2019 16:58:17.0888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fF9eZDSPCTvmlHusk0oy8kAiPlPZFl3BXDXDwIsca+n3nPY+5oAwySMfH1V7oGsTmZei01gufxSO+RgFSH2CmgEvX3ev/+TYE8NDXlNIHP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3969
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.101
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjYuMTAuMjAxOSAxNDoyOSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9uIDEw
LzI2LzE5IDEyOjEyIFBNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4g
TWFrZSBpdCBvYnZpb3VzLCBmcm9tIHRoZSB0d28gdmFsdWVzIHdoaWNoIGlzIGZvdW5kIGF0IHBh
dGggYW5kIHdoaWNoDQo+PiBpcyBleHBlY3RlZC4NCj4gDQo+IE1heWJlOg0KPiANCj4gIkZyb20g
dGhlIHR3byB2YWx1ZXMgY29tcGFyZWQsIG1ha2UgaXQgb2J2aW91cyB3aGljaCBpcyBmb3VuZCBh
dCBwYXRoLCBhbmQgd2hpY2ggaXMgZXhwZWN0ZWQuIg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCg0KVGhhbmtzIGZvciByZXZp
ZXcgYW5kIGJldHRlciB3b3JkaW5nIQ0KDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0t
LQ0KPj4NCj4+IEl0J3MgYSBwYWluLCBJIGNhbiBuZXZlciByZW1lbWJlciBpdCwgYW5kIGNoZWNr
aW5nIGVhY2ggdGltZSBpbiBzb3VyY2UNCj4+IGNvZGUgd2hvIGlzIHdobyBpcyBib3JpbmcuDQo+
Pg0KPj4gwqAgdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkgfCA0ICsrLS0NCj4+IMKgIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5IGIvdGVzdHMvcWVtdS1pb3Rl
c3RzL2lvdGVzdHMucHkNCj4+IGluZGV4IDcwOWRlZjRkNWQuLmU4MDViOWFiMTQgMTAwNjQ0DQo+
PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weQ0KPj4gKysrIGIvdGVzdHMvcWVt
dS1pb3Rlc3RzL2lvdGVzdHMucHkNCj4+IEBAIC03MjksOCArNzI5LDggQEAgY2xhc3MgUU1QVGVz
dENhc2UodW5pdHRlc3QuVGVzdENhc2UpOg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c2VsZi5mYWlsKCdubyBtYXRjaCBmb3IgIiVzIiBpbiAlcycgJSAoc3RyKHJlc3VsdCksIHN0cih2
YWx1ZSkpKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2U6DQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzZWxmLmFzc2VydEVxdWFsKHJlc3VsdCwgdmFsdWUsDQo+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJ3ZhbHVlcyBu
b3QgZXF1YWwgIiVzIiBhbmQgIiVzIicNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICUgKHN0cihyZXN1bHQpLCBzdHIo
dmFsdWUpKSkNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAnIiVzIiBpcyAiJXMiLCBleHBlY3RlZCAiJXMiJw0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
JSAocGF0aCwgc3RyKHJlc3VsdCksIHN0cih2YWx1ZSkpKQ0KPj4gwqDCoMKgwqDCoCBkZWYgYXNz
ZXJ0X25vX2FjdGl2ZV9ibG9ja19qb2JzKHNlbGYpOg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJl
c3VsdCA9IHNlbGYudm0ucW1wKCdxdWVyeS1ibG9jay1qb2JzJykNCj4+DQoNCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

