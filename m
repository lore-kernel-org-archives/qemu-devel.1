Return-Path: <SRS0=zNqU=ZC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B815C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 19:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75B820818
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 19:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MI7f8eet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75B820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTsag-0004TQ-Jb
	for qemu-devel@archiver.kernel.org; Sun, 10 Nov 2019 14:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iTsZs-000433-Nw
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 14:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iTsZr-0005K5-8H
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 14:08:48 -0500
Received: from mail-db5eur01on0704.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::704]:62876
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iTsZq-0005IR-I0; Sun, 10 Nov 2019 14:08:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVCqMTMgUJHoOsnHIRkZFWDfHNOSNh3aTQI8u27209131ShAvzHzPJHhbSS3zBBNdPwg4BX/Rrg+vcUn2V+nSggG17h7mllsZH3J4sXNlRUGpZIVS1QCJuKq2SfC5+qah5Z7XRr8sq1ChF7UFdSTfGkl2h8a6Fptppksgm6iBQ9Eijq53/lM6wtAfjfLPcuIIn9bD6hWPkqaGmKUBvxIPP447d11x1qP7SKImQRfu1YkMe05NCuEkm0NkjhUjL7oAwMlalHxDiU4rodJ1rXi1/KGDtfPQHLkZyQHJe/CL82X0Fjku8ZJvl0owTBCpgCQnLM4yFawDdyx6dRTHHdHUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0gp10nnfUe+bDwduCG+HWZz4AHL9un9piS35MDJ+Gw=;
 b=Yo28Z6Cx9VRE7hTrAOGIgDg4FCaJYF0KQQrFvuEUe0MF93zBOHSY0WLQ++TlHaWkKAzl7wYfgOUWchlO1AblqCKSvjWsK7k/iV/TMSPf6HqtbPeSCuHirV7mcv63wyBee0YSpCcjFeSuC3yKKIkLV+E4nEjraN0NyQ1rgF3AjRJ1LlgXIu8vexIE4l4+S9ngXxQLMAU58KZouWXdI8wdn9/pUAmUbz1dG+JodU0dk2edp8s38X0eeh/RHeMyKbFS3ZigLRHRxNdSzns7dnhHTqPndqp4XCWX2F6u3wJlG7cVfQflK43mfx2aWfSuHFOlvr6kGHEuhAD2C+8tMjsKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0gp10nnfUe+bDwduCG+HWZz4AHL9un9piS35MDJ+Gw=;
 b=MI7f8eetbb36Doip07FFRPmlvAA5Nl3JuR4/f1bDTJP7koaSNiw/YeomHhI8QB/B2pGXGWGSXCp/RJgeV97r5nOWpg1Ii7ww581zFUDl0sBGKFgbKW5ww8EfxtCGpNDmcFPOjqLR5avrwEkfuubbbVqWAsddPOweOFIiSseB82Y=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5297.eurprd08.prod.outlook.com (52.132.215.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Sun, 10 Nov 2019 19:08:43 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa%4]) with mapi id 15.20.2430.027; Sun, 10 Nov 2019
 19:08:43 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v0 2/2] block: allow to set 'drive' property on a realized
 block device
Thread-Topic: [PATCH v0 2/2] block: allow to set 'drive' property on a
 realized block device
Thread-Index: AQHVl/muMyF4ca4YdU2Ub7M+IU0rR6eExJGA
Date: Sun, 10 Nov 2019 19:08:42 +0000
Message-ID: <c19343f9-73b2-89a4-2b7d-b101a0b20016@virtuozzo.com>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20191110190310.19799-3-dplotnikov@virtuozzo.com>
In-Reply-To: <20191110190310.19799-3-dplotnikov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::20)
 To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.34.150.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba9b2bbc-44d8-4fff-f215-08d7661166d8
x-ms-traffictypediagnostic: AM0PR08MB5297:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB52977A662B4D858D3A336712CF750@AM0PR08MB5297.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:334;
x-forefront-prvs: 02176E2458
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(6436002)(2351001)(6486002)(26005)(305945005)(54906003)(71200400001)(71190400001)(229853002)(99286004)(6512007)(316002)(7736002)(6246003)(107886003)(6116002)(66066001)(86362001)(31696002)(3846002)(4326008)(5640700003)(66556008)(8676002)(2501003)(2616005)(476003)(25786009)(2906002)(64756008)(66946007)(446003)(81166006)(81156014)(11346002)(31686004)(66446008)(66476007)(76176011)(5024004)(36756003)(186003)(5660300002)(102836004)(486006)(52116002)(53546011)(478600001)(256004)(6506007)(386003)(14444005)(14454004)(8936002)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5297;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mjhuda8RI9UkBodNq74eNZEOqJnKS6B+TPBiO104llXw4ghlwA7mvPQ6zXtRmC1TVcMjRIAe14KI1fXGYx3aTiOl/BI9l9Eo8M258LGr/UD1jypoEhtKkr+8QTnUXmXT7YGf7ohJ0rDq2Hyvez2HxuJlXJPD7zcgiIidDpOAfZgwNmJ4D+cLyWtd+aYRRblT+ESZjLgk3xBIKZyJweNpiqO/zGNaMRq447Vjd50gEzibTdnMACC71CUkgy8sCJzyO/ILem4ixbe6GqefIAOB/UZzJz0V68/li7pWbOWmaRuAwB7NCdbAwFmUyIjiutvj2Smkr1BLZk2X5PaQ0DIfmP6pqjS9hwJ0QFNywJtECUqC/YnpHafHAp5sZH420L8mp/UDixS9hmOI8osE/R2e1vTVbcCf43Blkkx/G7e0irVZgIpg9QiLjQySFY8VWSuj
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE02DF685A711D448B5C86285C2C8107@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9b2bbc-44d8-4fff-f215-08d7661166d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2019 19:08:43.1859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rnjMF7LfUyru5lM4UizkEK2TzOXt1wgHGwpA9MV/4QkQ6X/bcmwwNSnA63SG3UIL2TEPmxqyM4+T50jgmBSbfYYpLrCnmjzLezQOhZKD6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5297
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe02::704
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpPbiAxMC4xMS4yMDE5IDIyOjAzLCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+IFRoaXMgYWxs
b3dzIHRvIGNoYW5nZSAocmVwbGFjZSkgdGhlIGZpbGUgb24gYSBibG9jayBkZXZpY2UgYW5kIGlz
IHVzZWZ1bA0KPiB0byB3b3JrYXJvdW5kIGV4Y2x1c2l2ZSBmaWxlIGFjY2VzcyByZXN0cmljdGlv
bnMsIGUuZy4gdG8gaW1wbGVtZW50IFZNDQo+IG1pZ3JhdGlvbiB3aXRoIGEgc2hhcmVkIGRpc2sg
c3RvcmVkIG9uIHNvbWUgc3RvcmFnZSB3aXRoIHRoZSBleGNsdXNpdmUNCj4gZmlsZSBvcGVuaW5n
IG1vZGVsOiBhIGRlc3RpbmF0aW9uIFZNIGlzIHN0YXJ0ZWQgd2FpdGluZyBmb3IgaW5jb21taW5n
DQo+IG1pZ3JhdGlvbiB3aXRoIGEgZmFrZSBpbWFnZSBkcml2ZSwgYW5kIGxhdGVyLCBvbiB0aGUg
bGFzdCBtaWdyYXRpb24NCj4gcGhhc2UsIHRoZSBmYWtlIGltYWdlIGZpbGUgaXMgcmVwbGFjZWQg
d2l0aCB0aGUgcmVhbCBvbmUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERlbmlzIFBsb3RuaWtvdiA8
ZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tPg0KPiAtLS0NCj4gICBody9jb3JlL3FkZXYtcHJvcGVy
dGllcy1zeXN0ZW0uYyB8IDg5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvaHcvY29yZS9xZGV2LXByb3BlcnRpZXMtc3lzdGVtLmMgYi9ody9jb3JlL3Fk
ZXYtcHJvcGVydGllcy1zeXN0ZW0uYw0KPiBpbmRleCBjNTM0NTkwZGNkLi5hYWFiMTM3MGE0IDEw
MDY0NA0KPiAtLS0gYS9ody9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uYw0KPiArKysgYi9o
dy9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uYw0KPiBAQCAtNzksOCArNzksNTUgQEAgc3Rh
dGljIHZvaWQgc2V0X3BvaW50ZXIoT2JqZWN0ICpvYmosIFZpc2l0b3IgKnYsIFByb3BlcnR5ICpw
cm9wLA0KPiAgIA0KPiAgIC8qIC0tLSBkcml2ZSAtLS0gKi8NCj4gICANCj4gLXN0YXRpYyB2b2lk
IGRvX3BhcnNlX2RyaXZlKERldmljZVN0YXRlICpkZXYsIGNvbnN0IGNoYXIgKnN0ciwgdm9pZCAq
KnB0ciwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnByb3BuYW1l
LCBib29sIGlvdGhyZWFkLCBFcnJvciAqKmVycnApDQo+ICtzdGF0aWMgdm9pZCBkb19wYXJzZV9k
cml2ZV9yZWFsaXplZChEZXZpY2VTdGF0ZSAqZGV2LCBjb25zdCBjaGFyICpzdHIsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICoqcHRyLCBjb25zdCBjaGFyICpw
cm9wbmFtZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgaW90
aHJlYWQsIEVycm9yICoqZXJycCkNCj4gK3sNCj4gKyAgICBCbG9ja0JhY2tlbmQgKmJsayA9ICpw
dHI7DQo+ICsgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnMgPSBiZHJ2X2xvb2t1cF9icyhOVUxMLCBz
dHIsIE5VTEwpOw0KPiArICAgIGludCByZXQ7DQo+ICsgICAgYm9vbCBibGtfY3JlYXRlZCA9IGZh
bHNlOw0KPiArDQo+ICsgICAgaWYgKCFicykgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJDYW4ndCBmaW5kIGJsb2NrZGV2ICclcyciLCBzdHIpOw0KPiArICAgICAgICByZXR1cm47DQo+
ICsgICAgfQ0KPiArDQo+ICsgICAgaWYgKCFibGspIHsNCj4gKyAgICAgICAgQWlvQ29udGV4dCAq
Y3R4ID0gaW90aHJlYWQgPyBiZHJ2X2dldF9haW9fY29udGV4dChicykgOg0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFlbXVfZ2V0X2Fpb19jb250ZXh0KCk7DQo+ICsg
ICAgICAgIGJsayA9IGJsa19uZXcoY3R4LCBCTEtfUEVSTV9BTEwsIEJMS19QRVJNX0FMTCk7DQo+
ICsgICAgICAgIGJsa19jcmVhdGVkID0gdHJ1ZTsNCg0KQWN0dWFsbHksIEkgaGF2ZSBjb25jZXJu
cyBhYm91dCBzaXR1YXRpb24gd2hlcmUgYmxrPW51bGwuDQoNCklzIHRoZXJlIGFueSBjYXNlIHdo
ZW4gc2NzaS1oZCAob3Igb3RoZXJzKSBkb2Vzbid0IGhhdmUgYSBibGsgYXNzaWduZWQgDQphbmQg
aXQncyBsZWdhbD8NCg0KPiArICAgIH0gZWxzZSB7DQo+ICsgICAgICAgIGlmIChibGtfYnMoYmxr
KSkgew0KPiArICAgICAgICAgICAgYmxrX3JlbW92ZV9icyhibGspOw0KPiArICAgICAgICB9DQo+
ICsgICAgfQ0KPiArDQo+ICsgICAgcmV0ID0gYmxrX2luc2VydF9icyhibGssIGJzLCBlcnJwKTsN
Cj4gKw0KPiArICAgIGlmICghcmV0ICYmIGJsa19jcmVhdGVkKSB7DQo+ICsgICAgICAgIGlmIChi
bGtfYXR0YWNoX2RldihibGssIGRldikgPCAwKSB7DQo+ICsgICAgICAgICAgICAvKg0KPiArICAg
ICAgICAgICAgICogU2hvdWxkbid0IGJlIGFueSBlcnJvcnMgaGVyZSBzaW5jZSB3ZSBqdXN0IGNy
ZWF0ZWQNCj4gKyAgICAgICAgICAgICAqIHRoZSBuZXcgYmxrIGJlY2F1c2UgdGhlIGRldmljZSBk
b2Vzbid0IGhhdmUgYW55Lg0KPiArICAgICAgICAgICAgICogTGVhdmUgdGhlIG1lc3NhZ2UgaGVy
ZSBpbiBjYXNlIGJsa19hdHRhY2hfZGV2IGlzIGNoYW5nZWQNCj4gKyAgICAgICAgICAgICAqLw0K
PiArICAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkNhbid0IGF0dGFjaCBkcml2ZSAnJXMn
IHRvIGRldmljZSAnJXMnIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIHN0ciwgb2JqZWN0
X2dldF90eXBlbmFtZShPQkpFQ1QoZGV2KSkpOw0KPiArICAgICAgICB9IGVsc2Ugew0KPiArICAg
ICAgICAgICAgKnB0ciA9IGJsazsNCj4gKyAgICAgICAgfQ0KPiArICAgIH0NCj4gKw0KPiArICAg
IGlmIChibGtfY3JlYXRlZCkgew0KPiArICAgICAgICBibGtfdW5yZWYoYmxrKTsNCj4gKyAgICB9
DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGRvX3BhcnNlX2RyaXZlX3VucmVhbGl6ZWQoRGV2
aWNlU3RhdGUgKmRldiwgY29uc3QgY2hhciAqc3RyLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2b2lkICoqcHRyLCBjb25zdCBjaGFyICpwcm9wbmFtZSwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpb3RocmVhZCwgRXJyb3Ig
KiplcnJwKQ0KPiAgIHsNCj4gICAgICAgQmxvY2tCYWNrZW5kICpibGs7DQo+ICAgICAgIGJvb2wg
YmxrX2NyZWF0ZWQgPSBmYWxzZTsNCj4gQEAgLTEzNywxOCArMTg0LDM0IEBAIGZhaWw6DQo+ICAg
ICAgIH0NCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgdm9pZCBwYXJzZV9kcml2ZShEZXZpY2VTdGF0
ZSAqZGV2LCBjb25zdCBjaGFyICpzdHIsIHZvaWQgKipwdHIsDQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICBjb25zdCBjaGFyICpwcm9wbmFtZSwgRXJyb3IgKiplcnJwKQ0KPiAtew0KPiAtICAg
IGRvX3BhcnNlX2RyaXZlKGRldiwgc3RyLCBwdHIsIHByb3BuYW1lLCBmYWxzZSwgZXJycCk7DQo+
IC19DQo+IC0NCj4gLXN0YXRpYyB2b2lkIHBhcnNlX2RyaXZlX2lvdGhyZWFkKERldmljZVN0YXRl
ICpkZXYsIGNvbnN0IGNoYXIgKnN0ciwgdm9pZCAqKnB0ciwNCj4gK3N0YXRpYyB2b2lkIHBhcnNl
X2RyaXZlX3JlYWxpemVkKERldmljZVN0YXRlICpkZXYsIGNvbnN0IGNoYXIgKnN0ciwgdm9pZCAq
KnB0ciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpw
cm9wbmFtZSwgRXJyb3IgKiplcnJwKQ0KPiAgIHsNCj4gLSAgICBkb19wYXJzZV9kcml2ZShkZXYs
IHN0ciwgcHRyLCBwcm9wbmFtZSwgdHJ1ZSwgZXJycCk7DQo+ICsgICAgZG9fcGFyc2VfZHJpdmVf
cmVhbGl6ZWQoZGV2LCBzdHIsIHB0ciwgcHJvcG5hbWUsIGZhbHNlLCBlcnJwKTsNCj4gICB9DQo+
ICAgDQo+ICtzdGF0aWMgdm9pZCBwYXJzZV9kcml2ZV9yZWFsaXplZF9pb3RocmVhZChEZXZpY2VT
dGF0ZSAqZGV2LCBjb25zdCBjaGFyICpzdHIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2b2lkICoqcHRyLCBjb25zdCBjaGFyICpwcm9wbmFtZSwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4g
K3sNCj4gKyAgICBkb19wYXJzZV9kcml2ZV9yZWFsaXplZChkZXYsIHN0ciwgcHRyLCBwcm9wbmFt
ZSwgdHJ1ZSwgZXJycCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIHBhcnNlX2RyaXZlX3Vu
cmVhbGl6ZWQoRGV2aWNlU3RhdGUgKmRldiwgY29uc3QgY2hhciAqc3RyLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICoqcHRyLCBjb25zdCBjaGFyICpwcm9wbmFt
ZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0K
PiArew0KPiArICAgIGRvX3BhcnNlX2RyaXZlX3VucmVhbGl6ZWQoZGV2LCBzdHIsIHB0ciwgcHJv
cG5hbWUsIGZhbHNlLCBlcnJwKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgcGFyc2VfZHJp
dmVfdW5yZWFsaXplZF9pb3RocmVhZChEZXZpY2VTdGF0ZSAqZGV2LCBjb25zdCBjaGFyICpzdHIs
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKipw
dHIsIGNvbnN0IGNoYXIgKnByb3BuYW1lLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+ICt7DQo+ICsgICAgZG9fcGFyc2VfZHJp
dmVfdW5yZWFsaXplZChkZXYsIHN0ciwgcHRyLCBwcm9wbmFtZSwgdHJ1ZSwgZXJycCk7DQo+ICt9
DQo+ICsNCj4gKw0KPiAgIHN0YXRpYyB2b2lkIHJlbGVhc2VfZHJpdmUoT2JqZWN0ICpvYmosIGNv
bnN0IGNoYXIgKm5hbWUsIHZvaWQgKm9wYXF1ZSkNCj4gICB7DQo+ICAgICAgIERldmljZVN0YXRl
ICpkZXYgPSBERVZJQ0Uob2JqKTsNCj4gQEAgLTE4OCwxMyArMjUxLDE1IEBAIHN0YXRpYyB2b2lk
IGdldF9kcml2ZShPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29uc3QgY2hhciAqbmFtZSwgdm9p
ZCAqb3BhcXVlLA0KPiAgIHN0YXRpYyB2b2lkIHNldF9kcml2ZShPYmplY3QgKm9iaiwgVmlzaXRv
ciAqdiwgY29uc3QgY2hhciAqbmFtZSwgdm9pZCAqb3BhcXVlLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICBFcnJvciAqKmVycnApDQo+ICAgew0KPiAtICAgIHNldF9wb2ludGVyKG9iaiwgdiwg
b3BhcXVlLCBOVUxMLCBwYXJzZV9kcml2ZSwgbmFtZSwgZXJycCk7DQo+ICsgICAgc2V0X3BvaW50
ZXIob2JqLCB2LCBvcGFxdWUsIHBhcnNlX2RyaXZlX3JlYWxpemVkLCBwYXJzZV9kcml2ZV91bnJl
YWxpemVkLA0KPiArICAgICAgICAgICAgICAgIG5hbWUsIGVycnApOw0KPiAgIH0NCj4gICANCj4g
ICBzdGF0aWMgdm9pZCBzZXRfZHJpdmVfaW90aHJlYWQoT2JqZWN0ICpvYmosIFZpc2l0b3IgKnYs
IGNvbnN0IGNoYXIgKm5hbWUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZv
aWQgKm9wYXF1ZSwgRXJyb3IgKiplcnJwKQ0KPiAgIHsNCj4gLSAgICBzZXRfcG9pbnRlcihvYmos
IHYsIG9wYXF1ZSwgTlVMTCwgcGFyc2VfZHJpdmVfaW90aHJlYWQsIG5hbWUsIGVycnApOw0KPiAr
ICAgIHNldF9wb2ludGVyKG9iaiwgdiwgb3BhcXVlLCBwYXJzZV9kcml2ZV9yZWFsaXplZF9pb3Ro
cmVhZCwNCj4gKyAgICAgICAgICAgICAgICBwYXJzZV9kcml2ZV91bnJlYWxpemVkX2lvdGhyZWFk
LCBuYW1lLCBlcnJwKTsNCj4gICB9DQo+ICAgDQo+ICAgY29uc3QgUHJvcGVydHlJbmZvIHFkZXZf
cHJvcF9kcml2ZSA9IHsNCg==

