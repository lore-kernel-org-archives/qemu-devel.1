Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FC1C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4AC20644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="h1+FcJ67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4AC20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsS6j-000326-J8
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 09:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46965)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hsS68-0002AF-Ue
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hsS67-0006JR-EE
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:23:24 -0400
Received: from mail-eopbgr140117.outbound.protection.outlook.com
 ([40.107.14.117]:1614 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hsS62-0006Fk-FD; Tue, 30 Jul 2019 09:23:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haMeyAgMl+AWAa+pRGkU2FuyK5ViyPNfTK4Sga9TueoRfHitrttQr3WMDskbviVXNF4T881VZ+kXdQW8Ho0K9pHfDqfuoAfl2AtLhb1rjZPi0TYFwbOBe0vDmPRBVg/b1NfHTtFBWBNfBfXGnVDI127tAJ6IqL30E+ZKdXeZrJb75Jj15k1mUY04Y+wTqD6KgbTTyJZr87fiU0RhwV+G7yca1XLrMYwzUTcwvjW3AGK9/n/GWgOToFzJlmQlBNv2od6kAF93DY9/P4Bcd6QIWqmxhchofX/o2kHOKI3qoFornoHN49k8Wguzo1gbzsEUU63S8/zqofrCA78su4EgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvhRcf7VrNiqBUgKEa2YhkuM0DXmXmKpb1SC9Pvx0B0=;
 b=oMF20G4dJS0kLFAQEizLTb1X4dl2m7W9guzV3vFM/8IKwmqcnV24F4LB68Wf+wdsIV2xLnbo0CVm1A6DpiZbyK+4HC9xukmKusYa6fe9EIgJE6n0daEHWPdVi8ekI+YP36QfDk4zRJZp+zcDu1hxOuHVtl0tS/kvZKBKQcbb6tiYzYS5IKOexLQcS/fDcd2QcY98v8ERvgin3D3fBpcyPiBiGydLxZsKFAvEovjR/xINoXvmt/mlH7HlLK3+nXGds9sdQ7g5dk5uGol6Mt35Zoteal/K0+YF9iWIeh4yq0AMEERbesUxYu7RiIJmTfUxwOz9tH3kqqdsxzpz6qaMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvhRcf7VrNiqBUgKEa2YhkuM0DXmXmKpb1SC9Pvx0B0=;
 b=h1+FcJ67Rt+yKiqLwGDeSCWt6urfrnjz7+IelZmby5CY9flPsfXgQ36foWnIP4l5Oos5N/MocaRgqnjrPZlWY4p2m1Y0WqTIhQXLaB8uozTi1m86xtMDghmugErlsLvxtOP9ncuFgQZ2vIfR5/T61RugfogrKYvIDsdtelSA3Bs=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3103.eurprd08.prod.outlook.com (52.133.15.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Tue, 30 Jul 2019 13:23:14 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 13:23:14 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] tests: Set read-zeroes on for null-co driver
Thread-Index: AQHVRgulae/lr4xz6EGdKpGPDO9mvKbjHyuAgAAB24CAAAbAgA==
Date: Tue, 30 Jul 2019 13:23:13 +0000
Message-ID: <b3d6196e-36e1-6d13-015c-c631ab09cc04@virtuozzo.com>
References: <1564404360-733987-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <13985217-0967-e7b6-db62-43c865d49141@redhat.com>
 <aff46d02-5876-091a-c0f6-8214231f2bc9@redhat.com>
In-Reply-To: <aff46d02-5876-091a-c0f6-8214231f2bc9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::14) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6c7a4c8-7501-49a6-8cea-08d714f1132b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3103; 
x-ms-traffictypediagnostic: VI1PR08MB3103:
x-microsoft-antispam-prvs: <VI1PR08MB3103F1238D9ADBD4602DCEA4F4DC0@VI1PR08MB3103.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(376002)(136003)(39850400004)(366004)(189003)(199004)(2616005)(476003)(446003)(11346002)(186003)(53546011)(26005)(66066001)(256004)(66556008)(66946007)(6506007)(486006)(36756003)(102836004)(386003)(44832011)(305945005)(25786009)(52116002)(86362001)(66446008)(76176011)(4326008)(14454004)(7736002)(64756008)(99286004)(5660300002)(71200400001)(478600001)(31696002)(66476007)(2501003)(7416002)(2906002)(71190400001)(68736007)(316002)(8676002)(229853002)(6436002)(6486002)(6512007)(81166006)(81156014)(110136005)(54906003)(6246003)(31686004)(6116002)(3846002)(53936002)(8936002)(2201001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3103;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AUZULa1v9P6Br2A0GebxKCmhqTTMy9kzJqxh2dk0c/zx/ePQpLiaDTRY6hGo64VZN2DAkzUfjQLwCQUkBpNVrIzKER4pbTdgq/qSRNkYTcY0BuCtIQeleZpIg7Hx2h1CwK/6LvCloaoaHVAMpn8im66+T5k/nxhOQ0O8f0znWWWKCuUTPSyZMtWj7YKz5lmpq+kBlz6vkp2XQC5/OwNlkiFHFc3g5/+Qp9z4ozAW/JWnBHmzQB8ovwxIHxf/1oV2rnrTTyf2j9Vts3PumTnP9byviLAupSYgZyGw6IVp5EFYGIKD4+uLAVUOMbPHAU9qiBzpTu7rwl35Cc3aaeYzMCaaMdhhM2B8T4l+jAnBe1YKJEN5tpQVWSUG+tm8dpFXoACceEl36foLijNLYILEC//L1W4Du6ln9BXLH24oqvI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA0A68AA66171C4E92C057A185E8E1E9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c7a4c8-7501-49a6-8cea-08d714f1132b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 13:23:13.9758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3103
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.117
Subject: Re: [Qemu-devel] [PATCH] tests: Set read-zeroes on for null-co
 driver
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
 "lvivier@redhat.com" <lvivier@redhat.com>, "hare@suse.com" <hare@suse.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "fam@euphon.net" <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDMwLzA3LzIwMTkgMTU6NTksIFRob21hcyBIdXRoIHdyb3RlOg0KPiBPbiAzMC8wNy8y
MDE5IDE0LjUyLCBUaG9tYXMgSHV0aCB3cm90ZToNCj4+IE9uIDI5LzA3LzIwMTkgMTQuNDYsIEFu
ZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4+IFRoaXMgcGF0Y2ggaXMgdG8gcmVkdWNlIHRoZSBu
dW1iZXIgb2YgVmFsZ3JpbmQgcmVwb3J0IG1lc3NhZ2VzIGFib3V0DQo+Pj4gdXNpbmcgdW5pbml0
aWFsaXplZCBtZW1vcnkgd2l0aCB0aGUgbnVsbC1jbyBkcml2ZXIuIEl0IGhlbHBzIHRvIGZpbHRl
cg0KPj4+IHJlYWwgbWVtb3J5IGlzc3VlcyBhbmQgaXMgdGhlIHNhbWUgd29yayBkb25lIGZvciB0
aGUgaW90ZXN0cyB3aXRoIHRoZQ0KPj4+IGNvbW1pdCBJRCBhNjg2MjQxOGZlYzQwNzIuDQo+Pj4N
Cj4+PiBTdWdnZXN0ZWQtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6
by5jb20+DQo+Pj4gLS0tDQo+PiBbLi4uXQ0KPj4+IGRpZmYgLS1naXQgYS90ZXN0cy90ZXN0LWJs
b2Nram9iLXR4bi5jIGIvdGVzdHMvdGVzdC1ibG9ja2pvYi10eG4uYw0KPj4+IGluZGV4IDg2NjA2
ZjkuLjdkYTkyMTYgMTAwNjQ0DQo+Pj4gLS0tIGEvdGVzdHMvdGVzdC1ibG9ja2pvYi10eG4uYw0K
Pj4+ICsrKyBiL3Rlc3RzL3Rlc3QtYmxvY2tqb2ItdHhuLmMNCj4+PiBAQCAtMTUsNiArMTUsNyBA
QA0KPj4+ICAgI2luY2x1ZGUgInFlbXUvbWFpbi1sb29wLmgiDQo+Pj4gICAjaW5jbHVkZSAiYmxv
Y2svYmxvY2tqb2JfaW50LmgiDQo+Pj4gICAjaW5jbHVkZSAic3lzZW11L2Jsb2NrLWJhY2tlbmQu
aCINCj4+PiArI2luY2x1ZGUgInFhcGkvcW1wL3FkaWN0LmgiDQo+Pj4gICANCj4+PiAgIHR5cGVk
ZWYgc3RydWN0IHsNCj4+PiAgICAgICBCbG9ja0pvYiBjb21tb247DQo+Pj4gQEAgLTk2LDcgKzk3
LDkgQEAgc3RhdGljIEJsb2NrSm9iICp0ZXN0X2Jsb2NrX2pvYl9zdGFydCh1bnNpZ25lZCBpbnQg
aXRlcmF0aW9ucywNCj4+PiAgIA0KPj4+ICAgICAgIGRhdGEgPSBnX25ldzAoVGVzdEJsb2NrSm9i
Q0JEYXRhLCAxKTsNCj4+PiAgIA0KPj4+IC0gICAgYnMgPSBiZHJ2X29wZW4oIm51bGwtY286Ly8i
LCBOVUxMLCBOVUxMLCAwLCAmZXJyb3JfYWJvcnQpOw0KPj4+ICsgICAgUURpY3QgKm9wdCA9IHFk
aWN0X25ldygpOw0KPj4+ICsgICAgcWRpY3RfcHV0X3N0cihvcHQsICJmaWxlLnJlYWQtemVyb2Vz
IiwgIm9uIik7DQo+Pj4gKyAgICBicyA9IGJkcnZfb3BlbigibnVsbC1jbzovLyIsIE5VTEwsIG9w
dCwgMCwgJmVycm9yX2Fib3J0KTsNCj4+PiAgICAgICBnX2Fzc2VydF9ub25udWxsKGJzKTsNCj4+
DQo+PiBOb3Qgc3VyZSwgYnV0IGRvbid0IHlvdSBuZWVkIHRvIGFsc28gcWRpY3RfZGVzdHJveV9v
Ymoob3B0KSBhdCB0aGUgZW5kDQo+PiB0byBhdm9pZCBsZWFraW5nIG1lbW9yeT8gKEFsc28gaW4g
dGhlIG90aGVyIHNwb3RzIHdoZXJlIHlvdSB1c2UNCj4+IHFkaWN0X25ldygpIC4uLikNCj4gDQo+
IE5ldmVyIG1pbmQsIHNlZW1zIGxpa2UgYmRydl9vcGVuKCkgaXMgZG9pbmcgYW4gcW9iamVjdF91
bnJlZigpIG9uIHRoZQ0KPiBvcHRpb25zIGF0IHRoZSBlbmQsIHNvIEkgZ3Vlc3MgdGhpcyBzaG91
bGQgYmUgZmluZS4uLg0KPiANCj4gU28gaW4gdGhhdCBjYXNlOg0KPiANCj4gQWNrZWQtYnk6IFRo
b21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KPiANCj4gKEkgYXNzdW1lIHRoaXMgd2lsbCBi
ZSB0YWtlbiB0aHJvdWdoIHRoZSBibG9jayB0cmVlPyBMZXQgbWUga25vdyBpZiB5b3UNCj4gcHJl
ZmVyIHRoZSBxdGVzdCB0cmVlIGluc3RlYWQpDQo+IA0KDQpUaGFua3MsIFRob21hcyENCkkgaGF2
ZSBydW4gdGhlIHBhdGNoZWQgcHJvZ3JhbSB1bmRlciB0aGUgVmFsZ3JpbmQgdG8gZG91YmxlIGNo
ZWNrIGZvciANCm1lbW9yeSBpc3N1ZXMgLSBubyBsZWFrIHJlcG9ydGVkLg0KQXMgZm9yIHRoZSBi
cmFuY2gsIEkgd291bGQgYmUgaGFwcHkgd2l0aCBlaXRoZXIuDQoNCkFuZGV5DQotLSANCldpdGgg
dGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=

