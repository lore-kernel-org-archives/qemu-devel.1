Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44315C17445
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B362214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B362214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUDap-0003nx-8t
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 12:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <BROGERS@suse.com>) id 1iUDa8-0003M4-SH
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1iUDa6-0006SW-7Z
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:34:27 -0500
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:47610)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1iUDa6-0005vE-1Z
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:34:26 -0500
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY
 m9a0002g.houston.softwaregrp.com WITH ESMTP; 
 Mon, 11 Nov 2019 17:32:59 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 11 Nov 2019 17:31:29 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 11 Nov 2019 17:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7+xj1kpaFlhm08A+u7V1+T5FAjsi9G+FvndbDjSJJXdmPuobXSGIUQSnWYNMDwLakcC27BWwA9viMJjg8xQA/gIYBz4KEQJdhbVv3ALnxg8uA3f6y9QI/yIb21rNJRd6t2dzw2kjV8HUZgzTINtXDrxzl77EFsnKwU7wEODu54oJg8ZVXl2Rwe8jIaCYhsmU3qV2wqkotCmuSeUp6hBHlEGwO+FovGa7eVRjUufVMa2mZ6ETHW0jGZ2yFitpPTS6W3tTh5UHSkBCMR6wUgJMEqLS3RQaDUHyVJsX0kQRy2nuC2Bg69AuErDzQLvM8S7TOHv/IWTTyQ3OFH3ZyoGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qRRiDvWidNUMgDEmcndgGIOvOPOdOkY7MNbn9yW5Ek=;
 b=Paqj+jXriCeVuuPa9ac0JVmhPUnx/e1dJmdGzSCVix43GEMW4xYis87KI02ektABOseikvdTGUIxIJvVEIPyRvYUDUCFdDcXvpNGJzSuf+iKSpP1M9UwB0qB+sWKLlHZmHPituN6LKlgc8wrCgF3VlD0dqVn0UKMyi7eyMw5l9rhktvmNU9RDQO8KvPBPYIVDpU6OhZDP+AO9K67tg3S+5xNGntZ3noIM+6XDSzNTf8X5IcxHyjWU/tkJu5C85Of0KGsxDVW1lb1Z7sTXx85mqfLvL6xdHcZU811wYABONP8VFi3PrgBynyViHGuxzpPGGjX95XnfHlcrZ9sqcFwpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CH2PR18MB3096.namprd18.prod.outlook.com (52.132.244.221) by
 CH2PR18MB3093.namprd18.prod.outlook.com (10.255.155.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Mon, 11 Nov 2019 17:31:28 +0000
Received: from CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::7907:96f9:6e13:4f1a]) by CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::7907:96f9:6e13:4f1a%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 17:31:28 +0000
From: Bruce Rogers <BROGERS@suse.com>
To: "ehabkost@redhat.com" <ehabkost@redhat.com>, "cathy.zhang@intel.com"
 <cathy.zhang@intel.com>
Subject: Re: [Resend PATCH 0/3] Add CPU model for intel processor Cooper Lake
Thread-Topic: [Resend PATCH 0/3] Add CPU model for intel processor Cooper Lake
Thread-Index: AQHViKxdEFiNUUiBPE+pcMbggrQxFqdpGsAAgB0/lwA=
Date: Mon, 11 Nov 2019 17:31:28 +0000
Message-ID: <b63dfa9a201405b5f64e891a42c2f8dd80961cda.camel@suse.com>
References: <1571729728-23284-1-git-send-email-cathy.zhang@intel.com>
 <20191024025218.GL6744@habkost.net>
In-Reply-To: <20191024025218.GL6744@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=BROGERS@suse.com; 
x-originating-ip: [137.65.133.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10870367-59e3-42d3-09f4-08d766ccfc27
x-ms-traffictypediagnostic: CH2PR18MB3093:
x-microsoft-antispam-prvs: <CH2PR18MB3093C940B0526CAE10EEBE9DD9740@CH2PR18MB3093.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(36756003)(6486002)(256004)(81166006)(81156014)(66066001)(25786009)(8676002)(229853002)(8936002)(6436002)(118296001)(446003)(4326008)(6512007)(3846002)(2906002)(6116002)(71190400001)(71200400001)(110136005)(316002)(11346002)(54906003)(99286004)(14454004)(4744005)(5660300002)(486006)(2616005)(476003)(2501003)(6506007)(76176011)(86362001)(186003)(305945005)(478600001)(26005)(6246003)(4001150100001)(66446008)(76116006)(64756008)(7736002)(66476007)(91956017)(66556008)(66946007)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CH2PR18MB3093;
 H:CH2PR18MB3096.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NRL7IUXbL7EIGDOx65lV5PHgRHvrSrh7STt8EVU/OjdiLzJNM1dGqXNQE3Ymyfx3U4rb9jWmaxFHWpbUQLlwRFf5nUGGdhw9fVfiEJ7f+5Tqbog/v0puLo8CRcNIaKp6+Sqxb/Qsihny73ZkEYaTlqUUIOswkN5Iwod0AP/AmEJnpWk5Kkdb+OMWCfTRWj0l32L4sD5i82qNaQNCnw1sDyvQRnNKJLfIEi+h7zX2Pso5/VQMxtUTsOscU1r0VqtdBom4jy+GKCogwKTXiQTaaauvMytKOKb+yGcQYpDPIaxfdsDHVOzVWoUlImenZLh8bFILyCr0TrkuXMqmcUWamT+ONFKsU/eU9sPsb2WwSjifouAMm6DrmWSqAXewCED1+L57PEzf3Pffhje1kVaPLEh8DDt9hckJCE8he248qOv7rZNaR3KiryC0NahnxcaA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C823F1E9E7CB24E8FAECDF09D6DB5B9@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 10870367-59e3-42d3-09f4-08d766ccfc27
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 17:31:28.4183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZZLL0ToSEUz6xOwC+s+yLlcXa350nzshTGWsmmJNk0toxYOSrWoGd+n5b6UyLhrdi4ArHtDaOQqOcqHhwkHIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3093
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.64.67
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gV2VkLCAyMDE5LTEwLTIzIGF0IDIzOjUyIC0wMzAwLCBFZHVhcmRvIEhhYmtvc3Qgd3JvdGU6
DQo+IE9uIFR1ZSwgT2N0IDIyLCAyMDE5IGF0IDAzOjM1OjI1UE0gKzA4MDAsIENhdGh5IFpoYW5n
IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2hzZXQgaXMgdG8gYWRkIENQVSBtb2RlbCBmb3IgaW50ZWwg
cHJvY2Vzc29yIENvb3BlciBMYWtlLg0KPiA+IEl0DQo+ID4gd2lsbCBpbmhlcml0IGZlYXR1cmVz
IGZyb20gdGhlIGV4aXN0aW5nIENQVSBtb2RlbCBDYXNjYWRlbGFrZS0NCj4gPiBTZXJ2ZXIsDQo+
ID4gbWVhbndoaWxlLCBhZGQgdGhlIHBsYXRmb3JtIGFzc29jaWF0ZWQgbmV3IGluc3RydWN0aW9u
IGFuZCBmZWF0dXJlDQo+ID4gZm9yIHNwZWN1bGF0aXZlIGV4ZWN1dGlvbiB3aGljaCB0aGUgaG9z
dCBzdXBwb3J0cy4gVGhlcmUgYXJlDQo+ID4gYXNzb2NpYXRlZA0KPiA+IGZlYXR1cmUgYml0IGFu
ZCBtYWNybyBkZWZpbmVkIGhlcmUgYXMgbmVlZGVkLg0KPiANCj4gUXVldWVkLCB0aGFua3MuDQo+
IA0KPiA+IENhdGh5IFpoYW5nICgzKToNCj4gPiAgIGkzODY6IEFkZCBNU1IgZmVhdHVyZSBiaXQg
Zm9yIE1EUy1OTw0KPiA+ICAgaTM4NjogQWRkIG1hY3JvIGZvciBzdGlicA0KPiA+ICAgaTM4Njog
QWRkIG5ldyBDUFUgbW9kZWwgQ29vcGVybGFrZQ0KPiA+IA0KPiA+ICB0YXJnZXQvaTM4Ni9jcHUu
YyB8IDYwDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ICB0YXJnZXQvaTM4Ni9jcHUuaCB8ICAzICsrKw0KPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKykNCj4gPiANCg0KSGkgRWR1YXJkbywNCg0KSXMgdGhp
cyBnb2luZyB0byBtYWtlIGl0IGludG8gdjQuMj8NCg0KUmVnYXJkcywNCkJydWNlDQo=

