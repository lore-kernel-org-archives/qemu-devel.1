Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA75C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 09:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8218622CF4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 09:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C0TEFhuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8218622CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i007Z-0005fY-Iq
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 05:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i006k-0005Ar-PH
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i006j-0004Ic-Pf
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:07:14 -0400
Received: from mail-eopbgr140121.outbound.protection.outlook.com
 ([40.107.14.121]:31364 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i006f-0004CX-9z; Tue, 20 Aug 2019 05:07:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Htn1UuCSS+OphAFEPF+wZaiwRHvRsbdeXAAiqJ4W54LPf84R69q2BLEXftSft+wWCWteR300Bu9iPC+d77j63JdZVHj+0jakbNApOxmDRlJT3F7TLOlVXQrWizlIkXpl6KStrh8e3WKvilSz8dKiVP5n73Z/rP+CH+HMu/mspqK7dDk60YR5rMuY1YlzLlyHTMOO+IXcC2IPEWVWi45VEWQOeIWIIPXBHQhKwJD5FHuF8i5yzL5DVbGT7z76zhi5t4DeUSag5AcgbGkpTxYP69SjUSY0c9NefKb3rpe8WkhsJqkhEdqQVDGGFppQAAFA0mGZhapev2/O8Ry9Xg9PSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpkcFloFVn4K/95U2sY/JnZI9Ma5e9hlFuGu15rrCzg=;
 b=MbKevcqFrQJhPaezBsk4Cipw1kFK7aJ+bkSYBi3Ad6ninka/PG8K7W9+ov8s81vqrpYOlzZZP3fCMseSdewoCwUH8JCAMyWRDr3AMnOGu3JAwuIg0JEMjJRQItHZC2BSMDlMjw2OxmRaCx2VamYTzj8Hl+9Q9lw4u/92DUTRwF4y4aYt//6a7Wl+5fQuGmylfRe3qDCg1w+5l4k6S44dQNMkgvwhSObtAcLlr28OENfGqG0yhU+E7B/rwI24h+1UasquSaI7vaa0PL21UTkVwU8GGmUysirs7uoRuSELNW/wsNUVhffyCDkQPrCFTtQx0E8jX9xqg4mXqHG590Lmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpkcFloFVn4K/95U2sY/JnZI9Ma5e9hlFuGu15rrCzg=;
 b=C0TEFhuhvym6JvOjU056IfDJ+dvnOwZq+s55IWchNO+saXSj20qXkBSUoydtuPiNIZzVJmBZzruwMVuPGiP2Woh7e4vLaHIvkSDMiIpJ/XNN+7j5QP4decS3g9sFE5SfZ/9n9NTqaEFEUn7J3247VVrxmddAlXwNwnDVq9g2zwY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5404.eurprd08.prod.outlook.com (52.133.240.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 09:07:05 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 09:07:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] nbd: Advertise multi-conn for shared read-only
 connections
Thread-Index: AQHVU5pRbfX2Dmnn90+3JIt/UilW+Kb9xGyAgAAGyQCAAZ4rAIAEXK6A
Date: Tue, 20 Aug 2019 09:07:05 +0000
Message-ID: <d08f28cc-4ea0-6d8d-63b9-bd2e3e7323fa@virtuozzo.com>
References: <20190815185024.7010-1-eblake@redhat.com>
 <104559cd-a1dc-2b2c-8992-689cbdd0f827@virtuozzo.com>
 <22c4c265-91fc-3639-4a4e-2fffe426ce68@virtuozzo.com>
 <3f1fa92e-af18-87f8-3149-7c11bd186e64@redhat.com>
In-Reply-To: <3f1fa92e-af18-87f8-3149-7c11bd186e64@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0072.eurprd07.prod.outlook.com
 (2603:10a6:3:64::16) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190820120703400
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b93a9045-0527-4447-be31-08d7254dc58d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5404; 
x-ms-traffictypediagnostic: DB8PR08MB5404:
x-microsoft-antispam-prvs: <DB8PR08MB54047F71EA1CA21F83874803C1AB0@DB8PR08MB5404.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(396003)(136003)(346002)(376002)(189003)(199004)(316002)(53546011)(6506007)(229853002)(11346002)(81166006)(386003)(2616005)(81156014)(476003)(26005)(2906002)(6486002)(486006)(14454004)(66066001)(256004)(4326008)(186003)(6436002)(478600001)(71190400001)(71200400001)(8936002)(8676002)(52116002)(76176011)(31686004)(99286004)(3846002)(7736002)(6116002)(36756003)(31696002)(446003)(102836004)(6512007)(86362001)(2501003)(305945005)(5660300002)(54906003)(110136005)(53936002)(6246003)(25786009)(66946007)(66476007)(66556008)(64756008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5404;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WBy3KaV8DW7CvyR6BOyrKnF+Drld4OROiS1+w/2MasL95mkTvqwyhh257S7bQwnrzFxJ6UlQX+Ly8iew/I4Pj4j9VHaBJfuQVpJ583wwaKnwl1eIwS2NJ9LI2tdc7FyDht+Yq0T5kuxFNVacPeL53KOHoh+ql9jfxpB3w74IaLqAWMkyNOrQo9o7Hur47D7UCng1yxxG60tvv3rOfVtU0LNr6zu6gCjjcj2VAtprHOhhKEoCTXK2JtrpTxsHdyR0Tuo24pGJ/YWmeLmymhWrvOxa+BBAltg6ZQ8UPYRml1PHs9t96kxj1EhEASZ7/GWcFEup/qpvq6UUuRoaiqnjC0MPJigOGNbyBUYY+MsYpbrL5sNw/l784hdDSTmzxkB93EJAjtvygU1Ny+RcVDRfDP39OtQN8tpFEP35yyjtq78=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <04BE2E3EBC35634EB424DBB5CE559083@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93a9045-0527-4447-be31-08d7254dc58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 09:07:05.5146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wh9FuByF9bnzTKFF0lwEPd/9SP8z5PSEoPbOxd2wOtHKTN2yXOhLV2l6K3orqPDbACFvc2EL4kK9IBztKKJdiibx9Rt7ELM7nOrSM39N0Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5404
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.121
Subject: Re: [Qemu-devel] [PATCH] nbd: Advertise multi-conn for shared
 read-only connections
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
Cc: Kevin Wolf <kwolf@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTcuMDguMjAxOSAxNzozMCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOC8xNi8xOSA1OjQ3IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiANCj4+Pj4gKysrIGIvYmxv
Y2tkZXYtbmJkLmMNCj4+Pj4gQEAgLTE4OSw3ICsxODksNyBAQCB2b2lkIHFtcF9uYmRfc2VydmVy
X2FkZChjb25zdCBjaGFyICpkZXZpY2UsIGJvb2wgaGFzX25hbWUsIGNvbnN0IGNoYXIgKm5hbWUs
DQo+Pj4+ICDCoMKgwqDCoMKgIH0NCj4+Pj4NCj4+Pj4gIMKgwqDCoMKgwqAgZXhwID0gbmJkX2V4
cG9ydF9uZXcoYnMsIDAsIGxlbiwgbmFtZSwgTlVMTCwgYml0bWFwLA0KPj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdyaXRhYmxlID8gMCA6IE5C
RF9GTEFHX1JFQURfT05MWSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB3cml0YWJsZSA/IDAgOiBOQkRfRkxBR19SRUFEX09OTFksIHRydWUs
DQo+Pj4NCj4+PiBzL3RydWUvIXdyaXRhYmxlID8NCj4+DQo+PiBPaCwgSSBzZWUsIEpvaG4gYWxy
ZWFkeSBub3RpY2VkIHRoaXMsIGl0J3MgY2hlY2tlZCBpbiBuYmRfZXhwb3J0X25ldyBhbnl3YXku
Lg0KPiANCj4gU3RpbGwsIHNpbmNlIHR3byByZXZpZXdlcnMgaGF2ZSBjYXVnaHQgaXQsIEknbSBm
aXhpbmcgaXQgOikNCg0KV2l0aCBpdCBvciB3aXRob3V0Og0KDQpSZXZpZXdlZC1ieTogVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+IA0K
PiANCj4+Pj4gQEAgLTE0ODYsNiArMTQ4Niw4IEBAIE5CREV4cG9ydCAqbmJkX2V4cG9ydF9uZXco
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IGRldl9vZmZzZXQsDQo+Pj4+ICDCoMKgwqDC
oMKgIHBlcm0gPSBCTEtfUEVSTV9DT05TSVNURU5UX1JFQUQ7DQo+Pj4+ICDCoMKgwqDCoMKgIGlm
ICgobmJkZmxhZ3MgJiBOQkRfRkxBR19SRUFEX09OTFkpID09IDApIHsNCj4+Pj4gIMKgwqDCoMKg
wqDCoMKgwqDCoCBwZXJtIHw9IEJMS19QRVJNX1dSSVRFOw0KPj4+PiArwqDCoMKgIH0gZWxzZSBp
ZiAoc2hhcmVkKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBuYmRmbGFncyB8PSBOQkRfRkxBR19D
QU5fTVVMVElfQ09OTjsNCj4+DQo+PiBGb3IgbWUgaXQgbG9va3MgYSBiaXQgc3RyYW5nZTogd2Ug
YWxyZWFkeSBoYXZlIG5iZGZsYWdzIHBhcmFtZXRlciBmb3IgbmJkX2V4cG9ydF9uZXcoKSwgd2h5
DQo+PiB0byBhZGQgYSBzZXBhcmF0ZSBib29sZWFuIHRvIHBhc3Mgb25lIG9mIG5iZGZsYWdzIGZs
YWdzPw0KPiANCj4gQmVjYXVzZSBJIHdhbnQgdG8gZ2V0IHJpZCBvZiB0aGUgbmJkZmxhZ3MgaW4g
bXkgbmV4dCBwYXRjaC4NCj4gDQo+Pg0KPj4gQWxzbywgZm9yIHFlbXUtbmJkLCBzaG91bGRuJ3Qg
d2UgYWxsb3cgLWUgb25seSB0b2dldGhlciB3aXRoIC1yID8NCj4gDQo+IEknbSByZWx1Y3RhbnQg
dG87IGl0IG1pZ2h0IGJyZWFrIHdoYXRldmVyIGV4aXN0aW5nIHVzZXIgaXMgb2theSBleHBvc2lu
Zw0KPiBpdCAoYWx0aG91Z2ggc3VjaCB1c2VycyBhcmUgcXVlc3Rpb25hYmxlLCBzbyBtYXliZSB3
ZSBjYW4gYXJndWUgdGhleQ0KPiB3ZXJlIGFscmVhZHkgYnJva2VuKS4gIE1heWJlIGl0J3MgdGlt
ZSB0byBzdGFydCBhIGRlcHJlY2F0aW9uIGN5Y2xlPw0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

