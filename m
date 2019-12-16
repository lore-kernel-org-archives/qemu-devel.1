Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177A5C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C57206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vWJFB1sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C57206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igrjt-0007bJ-Vj
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 09:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1igrj8-00077Q-2F
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1igrj6-0002ej-2l
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:52:01 -0500
Received: from mail-eopbgr20131.outbound.protection.outlook.com
 ([40.107.2.131]:27539 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1igrj5-0002LV-51; Mon, 16 Dec 2019 09:52:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhyUaZhDvoE6Iew0VycM25HQWGQG4B6TOhN1uDUX8qFa22k1Pe2m7VTbzV68BSdU1y5J79l3ZYaTy1tqkplI297Xb/Fh3TYY7kmMjwf32rMwSFw34YLfn8Zyv2Rl/5qHjeTk6K7YaL4Nf23E/S2evYtrE7Fk8fqPlzQFp9eWbdRf+I2rdtqRzmkvSopKfQwZDLkNbUnfaioHqnkC3hD/d3hyzqudtuT+kbQXP6fgM9ROHq1xU6O3WB31kmshXMqjvUogFAqHZy+/drpIV4D2JDuvUNlcIdQSwf/wXVUFhPTldjejRsQheJYYJjl003AZJrFSGXE0yuk66iAxUaiYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLuY3dkAymS9Xol9mf7IorEha2OdTLPJ8UBRHzS6QKA=;
 b=j6SMtyrxs9sZeXL7yU6pGJdTxla0Ht1Z5+30IyYqJlZFvM0qo17g+GtxkZcGIgh6MsDR7WgaD6L3VmfFQTIsoJ+reVwlTNmb58JYqLhPADsFTR88FcOX/RRjio2ZNU91F+ZFm4FigjI2nDc9K15b0n/1xEt47xv7ujIiDcxpTh3zLWyB/u3o3wTCZWPeThifVuyaoNp+mlGtuVgrfYAa0xgPozoVlm5Q4FYdnp1IbXLYR6MfJ3UG1Jto/AoZJRmFR8BHFb3Tw6fg/dZikZ2VfpDpWSHJNCPxdJ9/FjMFtoLZm/yzT8JtlCf8AVEyxNcu6JMxxQ1avBuztu6DqguJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLuY3dkAymS9Xol9mf7IorEha2OdTLPJ8UBRHzS6QKA=;
 b=vWJFB1slw/mfdRBDa9RBuUcw5+bNSgFtAIrzC1fvKnsaQDDM+nu1eqw83HCbRG3MTLRbYFhTDSj97YusjKlE1ZWG4fnRjpQPgLT1BEuF7NZWcPtuS+UQlVnIuieFOztPys/rnLsHRe7n+nUWEKAPBNWU5C4Nipklu3ZThe20LAI=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Mon, 16 Dec 2019 14:51:54 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12%4]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 14:51:54 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v0 2/2] block: allow to set 'drive' property on a realized
 block device
Thread-Topic: [PATCH v0 2/2] block: allow to set 'drive' property on a
 realized block device
Thread-Index: AQHVl/muMyF4ca4YdU2Ub7M+IU0rR6eE9tyAgAvVKACAJ0VZAIAE/2KA
Date: Mon, 16 Dec 2019 14:51:54 +0000
Message-ID: <e982f384-0d94-7519-8cb1-48208025217a@virtuozzo.com>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20191110190310.19799-3-dplotnikov@virtuozzo.com>
 <c19343f9-73b2-89a4-2b7d-b101a0b20016@virtuozzo.com>
 <c38c1301-a28f-baf1-d441-ae8c7205feb1@virtuozzo.com>
 <20191213103246.GB3428@localhost.localdomain>
In-Reply-To: <20191213103246.GB3428@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::11)
 To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.233.241.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2766ea0-cb88-45b4-b25c-08d782377dff
x-ms-traffictypediagnostic: AM0PR08MB2961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB2961BF83F06EC1817CF0152DCF510@AM0PR08MB2961.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(376002)(136003)(39840400004)(396003)(199004)(189003)(6916009)(186003)(86362001)(66476007)(66556008)(64756008)(66446008)(5660300002)(31686004)(6486002)(66946007)(4326008)(316002)(478600001)(81156014)(81166006)(8936002)(2616005)(71200400001)(2906002)(6506007)(53546011)(8676002)(6512007)(36756003)(54906003)(31696002)(52116002)(26005)(107886003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB2961;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uvJOSN+j8Ajua6hBnYx/bLrRfArMHUtFaTJub/sNpY0Bckwu2s/zANYct6c9nIZE/Nbif1NyqhhWSIpiPO1ALMjqbx5rbDmzTpFW3OrzO408cfvvOKWTuLNx5EXDTUoVQf/GrF07VVTAdgyhGnMHS3XmyNHKIh6+pb4IZ2v+njLdlwXgLR+kDAwBNvYVk1A/NYMCJv+S5/6RcaaI6Y+b+sNARkaIw7ZSgOaLiExhUqJdBF6DKiKsfHFX7RE6l6wwWPquvRfPTV3B/tc0ebc5ku7yzwSS1mUAgEmC32v5jQc++FZL1VC/Nt2kxAc4nH1etSzhaQ34lz32C/hvIw4Yz+bZV9dC9lwgQyQCF3a12yUpvtcISNp6XFaV1CuozPc69exrBX2HmMPXNMlTIQ6mEQ+5PFdjsqtjXLvW5sCWmSpKNzpqGNVvGVlTrjN4Wml1
Content-Type: text/plain; charset="utf-8"
Content-ID: <E910A6A5393771459C5CE0237667DFD0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2766ea0-cb88-45b4-b25c-08d782377dff
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 14:51:54.6275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PGsiq2jx0LBhpbyjVO0GtiX2AMZx565dT99JZ+DM16DpT+PcWtNcHT22VnfpELW8i0O13jSkHs8+vKoeBMiFuwdAUeLZ7+GchKTBIFIIBuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2961
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.131
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
 "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDEzLjEyLjIwMTkgMTM6MzIsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDE4LjExLjIw
MTkgdW0gMTE6NTAgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+DQo+PiBPbiAx
MC4xMS4yMDE5IDIyOjA4LCBEZW5pcyBQbG90bmlrb3Ygd3JvdGU6DQo+Pj4gT24gMTAuMTEuMjAx
OSAyMjowMywgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPj4+PiBUaGlzIGFsbG93cyB0byBjaGFu
Z2UgKHJlcGxhY2UpIHRoZSBmaWxlIG9uIGEgYmxvY2sgZGV2aWNlIGFuZCBpcyB1c2VmdWwNCj4+
Pj4gdG8gd29ya2Fyb3VuZCBleGNsdXNpdmUgZmlsZSBhY2Nlc3MgcmVzdHJpY3Rpb25zLCBlLmcu
IHRvIGltcGxlbWVudCBWTQ0KPj4+PiBtaWdyYXRpb24gd2l0aCBhIHNoYXJlZCBkaXNrIHN0b3Jl
ZCBvbiBzb21lIHN0b3JhZ2Ugd2l0aCB0aGUgZXhjbHVzaXZlDQo+Pj4+IGZpbGUgb3BlbmluZyBt
b2RlbDogYSBkZXN0aW5hdGlvbiBWTSBpcyBzdGFydGVkIHdhaXRpbmcgZm9yIGluY29tbWluZw0K
Pj4+PiBtaWdyYXRpb24gd2l0aCBhIGZha2UgaW1hZ2UgZHJpdmUsIGFuZCBsYXRlciwgb24gdGhl
IGxhc3QgbWlncmF0aW9uDQo+Pj4+IHBoYXNlLCB0aGUgZmFrZSBpbWFnZSBmaWxlIGlzIHJlcGxh
Y2VkIHdpdGggdGhlIHJlYWwgb25lLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBQ
bG90bmlrb3YgPGRwbG90bmlrb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICDCoCBo
dy9jb3JlL3FkZXYtcHJvcGVydGllcy1zeXN0ZW0uYyB8IDg5ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tDQo+Pj4+ICDCoCAxIGZpbGUgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwg
MTIgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9jb3JlL3FkZXYtcHJv
cGVydGllcy1zeXN0ZW0uYw0KPj4+PiBiL2h3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLXN5c3RlbS5j
DQo+Pj4+IGluZGV4IGM1MzQ1OTBkY2QuLmFhYWIxMzcwYTQgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3
L2NvcmUvcWRldi1wcm9wZXJ0aWVzLXN5c3RlbS5jDQo+Pj4+ICsrKyBiL2h3L2NvcmUvcWRldi1w
cm9wZXJ0aWVzLXN5c3RlbS5jDQo+Pj4+IEBAIC03OSw4ICs3OSw1NSBAQCBzdGF0aWMgdm9pZCBz
ZXRfcG9pbnRlcihPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwNCj4+Pj4gUHJvcGVydHkgKnByb3As
DQo+Pj4+ICDCoCDCoCAvKiAtLS0gZHJpdmUgLS0tICovDQo+Pj4+ICDCoCAtc3RhdGljIHZvaWQg
ZG9fcGFyc2VfZHJpdmUoRGV2aWNlU3RhdGUgKmRldiwgY29uc3QgY2hhciAqc3RyLCB2b2lkDQo+
Pj4+ICoqcHRyLA0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjb25zdCBjaGFyICpwcm9wbmFtZSwgYm9vbCBpb3RocmVhZCwNCj4+Pj4g
RXJyb3IgKiplcnJwKQ0KPj4+PiArc3RhdGljIHZvaWQgZG9fcGFyc2VfZHJpdmVfcmVhbGl6ZWQo
RGV2aWNlU3RhdGUgKmRldiwgY29uc3QgY2hhciAqc3RyLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2
b2lkICoqcHRyLCBjb25zdCBjaGFyICpwcm9wbmFtZSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9v
bCBpb3RocmVhZCwgRXJyb3IgKiplcnJwKQ0KPj4+PiArew0KPj4+PiArwqDCoMKgIEJsb2NrQmFj
a2VuZCAqYmxrID0gKnB0cjsNCj4+Pj4gK8KgwqDCoCBCbG9ja0RyaXZlclN0YXRlICpicyA9IGJk
cnZfbG9va3VwX2JzKE5VTEwsIHN0ciwgTlVMTCk7DQo+Pj4+ICvCoMKgwqAgaW50IHJldDsNCj4+
Pj4gK8KgwqDCoCBib29sIGJsa19jcmVhdGVkID0gZmFsc2U7DQo+Pj4+ICsNCj4+Pj4gK8KgwqDC
oCBpZiAoIWJzKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKGVycnAsICJDYW4n
dCBmaW5kIGJsb2NrZGV2ICclcyciLCBzdHIpOw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJu
Ow0KPj4+PiArwqDCoMKgIH0NCj4+Pj4gKw0KPj4+PiArwqDCoMKgIGlmICghYmxrKSB7DQo+Pj4+
ICvCoMKgwqDCoMKgwqDCoCBBaW9Db250ZXh0ICpjdHggPSBpb3RocmVhZCA/IGJkcnZfZ2V0X2Fp
b19jb250ZXh0KGJzKSA6DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcWVtdV9nZXRfYWlvX2NvbnRl
eHQoKTsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGJsayA9IGJsa19uZXcoY3R4LCBCTEtfUEVSTV9B
TEwsIEJMS19QRVJNX0FMTCk7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBibGtfY3JlYXRlZCA9IHRy
dWU7DQo+Pj4gQWN0dWFsbHksIEkgaGF2ZSBjb25jZXJucyBhYm91dCBzaXR1YXRpb24gd2hlcmUg
YmxrPW51bGwuDQo+Pj4NCj4+PiBJcyB0aGVyZSBhbnkgY2FzZSB3aGVuIHNjc2ktaGQgKG9yIG90
aGVycykgZG9lc24ndCBoYXZlIGEgYmxrIGFzc2lnbmVkDQo+Pj4gYW5kIGl0J3MgbGVnYWw/DQo+
IE5vLCBibG9jayBkZXZpY2VzIHdpbGwgYWx3YXlzIGhhdmUgYSBCbG9ja0JhY2tlbmQsIGV2ZW4g
aWYgaXQgZG9lc24ndA0KPiBoYXZlIGEgcm9vdCBub2RlIGluc2VydGVkLg0KPg0KPj4+PiArwqDC
oMKgIH0gZWxzZSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoYmxrX2JzKGJsaykpIHsNCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmxrX3JlbW92ZV9icyhibGspOw0KPj4+PiArwqDC
oMKgwqDCoMKgwqAgfQ0KPj4+PiArwqDCoMKgIH0NCj4+Pj4gKw0KPj4+PiArwqDCoMKgIHJldCA9
IGJsa19pbnNlcnRfYnMoYmxrLCBicywgZXJycCk7DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoCBpZiAo
IXJldCAmJiBibGtfY3JlYXRlZCkgew0KPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGJsa19hdHRh
Y2hfZGV2KGJsaywgZGV2KSA8IDApIHsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoN
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFNob3VsZG4ndCBiZSBhbnkgZXJyb3Jz
IGhlcmUgc2luY2Ugd2UganVzdCBjcmVhdGVkDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKiB0aGUgbmV3IGJsayBiZWNhdXNlIHRoZSBkZXZpY2UgZG9lc24ndCBoYXZlIGFueS4NCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIExlYXZlIHRoZSBtZXNzYWdlIGhlcmUgaW4g
Y2FzZSBibGtfYXR0YWNoX2RldiBpcyBjaGFuZ2VkDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKi8NCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKGVycnAs
ICJDYW4ndCBhdHRhY2ggZHJpdmUgJyVzJyB0byBkZXZpY2UgJyVzJyIsDQo+Pj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0ciwgb2JqZWN0X2dldF90
eXBlbmFtZShPQkpFQ1QoZGV2KSkpOw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsNCj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnB0ciA9IGJsazsNCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIH0NCj4+Pj4gK8KgwqDCoCB9DQo+PiBBbm90aGVyIHByb2JsZW0gaGVyZSwgaXMgdGhhdCB0
aGUgInNpemUiIG9mIHRoZSBkZXZpY2UgZGV2IG1heSBub3QgbWF0Y2gNCj4+IGFmdGVyIHNldHRp
bmcgYSBkcml2ZS4NCj4+IFNvLCB3ZSBzaG91bGQgdXBkYXRlIGl0IGFmdGVyIHRoZSBkcml2ZSBz
ZXR0aW5nLg0KPj4gSXQgd2FzIGZvdW5kLCB0aGF0IGl0IGNvdWxkIGJlIGRvbmUgYnkgY2FsbGlu
Zw0KPj4gQmxvY2tEZXZPcHMuYmRydl9wYXJlbnRfY2JfcmVzaXplLg0KPj4NCj4+IEJ1dCBJIGhh
dmUgc29tZSBjb25jZXJucyBhYm91dCBkb2luZyBpdCBzby4gSW4gdGhlIGNhc2Ugb2YgdmlydGlv
IHNjc2kNCj4+IGRpc2sgd2UgaGF2ZSB0aGUgZm9sbG93aW5nIGNhbGxzdGFjaw0KPj4NCj4+ICAg
wqDCoMKgIGJkcnZfcGFyZW50X2NiX3Jlc2l6ZSBjYWxscygpIC0+DQo+PiAgIMKgIMKgwqDCoMKg
wqAgc2NzaV9kZXZpY2VfcmVwb3J0X2NoYW5nZShkZXYsIFNFTlNFX0NPREUoQ0FQQUNJVFlfQ0hB
TkdFRCkpIC0+DQo+PiAgIMKgIMKgIMKgIMKgIMKgIMKgIHZpcnRpb19zY3NpX2NoYW5nZSAtPg0K
Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmlydGlvX3Njc2lfcHVzaF9ldmVu
dChzLCBkZXYsIFZJUlRJT19TQ1NJX1RfUEFSQU1fQ0hBTkdFLA0KPj4gICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc2Vuc2UuYXNjIHwNCj4+IChzZW5zZS5hc2NxIDw8IDgpKTsN
Cj4gSSB0aGluayB0aGUgc2FmZXN0IG9wdGlvbiBmb3Igbm93IChhbmQgd2hpY2ggc2hvdWxkIHNv
bHZlIHRoZSBjYXNlIHlvdQ0KPiB3YW50IHRvIGFkZHJlc3MpIGlzIGNoZWNraW5nIHdoZXRoZXIg
b2xkIGFuZCBuZXcgc2l6ZSBtYXRjaCBhbmQNCj4gcmV0dXJuaW5nIGFuIGVycm9yIG90aGVyd2lz
ZS4NCj4NCj4+IHZpcnRpb19zY3NpX2NoYW5nZcKgIHB1c2hlcyB0aGUgZXZlbnQgdG8gdGhlIGd1
ZXN0IHRvIG1ha2UgdGhlIGd1ZXN0DQo+PiBhc2sgZm9yIHNpemUgcmVmcmVzaGluZy4gIElmIEkn
bSBub3QgbWlzdGFrZW4sIGhlcmUgd2UgY2FuIGdldCBhIHJhY2UNCj4+IGNvbmRpdGlvbiB3aGVu
IHNvbWUgYW5vdGhlciByZXF1ZXN0IGlzIHByb2Nlc3NlZCB3aXRoIGFuIHVuY2hhbmdlZA0KPj4g
c2l6ZSBhbmQgdGhlbiB0aGUgc2l6ZSBjaGFuZ2luZyByZXF1ZXN0IGlzIHByb2Nlc3NlZC4NCj4g
SSB0aGluayB0aGlzIGlzIGFjdHVhbGx5IGEgcHJvYmxlbSBldmVuIHdpdGhvdXQgcmVzaXppbmc6
IFdlIG5lZWQgdG8NCj4gcXVpZXNjZSB0aGUgZGV2aWNlIGJldHdlZW4gcmVtb3ZpbmcgdGhlIG9s
ZCByb290IGFuZCBpbnNlcnRpbmcgdGhlIG5ldw0KPiBvbmUuIFRoZXkgd2F5IHRvIGFjaGlldmUg
dGhpcyBpcyBwcm9iYWJseSBieSBzcGxpdHRpbmcgYmxrX2RyYWluKCkgaW50bw0KPiBhIGJsa19k
cmFpbl9iZWdpbigpL2VuZCgpIGFuZCB0aGVuIGRyYWluaW5nIHRoZSBCbG9ja0JhY2tlbmQgaGVy
ZSB3aGlsZQ0KPiB3ZSdyZSB3b3JraW5nIG9uIGl0Lg0KPg0KPiBLZXZpbg0KV2h5IGRvbid0IHdl
IHVzZSBiZHJ2X2RyYWluZWRfYmVnaW4vZW5kIGRpcmVjdGx5PyBUaGlzIGlzIHdoYXQgYmxrX2Ry
YWluIA0KZG9lcy4NCklmIHdlIHdhbnQgdG8gc3BsaXQgYmxrX2RyYWluIHdlIG11c3Qga2VlcCB0
cmFjayBpZiBibGsncyBicmR2IGlzbid0IA0KY2hhbmdlIG90aGVyd2lzZSB3ZSBjYW4gZW5kIHVw
IHdpdGggZHJhaW5fYmVnaW4gb25lIGFuZCBkcmFpbiBlbmQgDQphbm90aGVyIGJkcnYgaWYgd2Ug
ZG8gcmVtb3ZlL2luc2VydCBpbiBiZXR3ZWVuLg0KDQpBbm90aGVyIHRoaW5nIGlzIHNob3VsZCB3
ZSByZWFsbHkgY2FyZSBhYm91dCB0aGlzIGlmIHdlIGhhdmUgVk0gc3RvcHBlZCANCmFuZCB0aGUg
c2l6ZXMgbWF0Y2hlZD8NCg0KRGVuaXMNCj4NCg0K

