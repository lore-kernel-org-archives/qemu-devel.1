Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED56EC06513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DBE2184B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DBE2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNhh-0000Rk-CE
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48809)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <BROGERS@suse.com>) id 1hiLfC-00060W-05
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1hiLfA-0008Q4-M0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:29:49 -0400
Received: from m9a0003g.houston.softwaregrp.com ([15.124.64.68]:38212)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <BROGERS@suse.com>)
 id 1hiLfA-0007wy-Eu; Tue, 02 Jul 2019 12:29:48 -0400
Received: FROM m9a0003g.houston.softwaregrp.com (15.121.0.190) BY
 m9a0003g.houston.softwaregrp.com WITH ESMTP; 
 Tue,  2 Jul 2019 16:29:34 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Jul 2019 16:20:58 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 2 Jul 2019 16:20:58 +0000
Received: from CH2PR18MB3096.namprd18.prod.outlook.com (10.255.155.222) by
 CH2PR18MB3191.namprd18.prod.outlook.com (52.132.244.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 16:20:57 +0000
Received: from CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::b0ed:1962:7f53:5cc1]) by CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::b0ed:1962:7f53:5cc1%2]) with mapi id 15.20.2008.017; Tue, 2 Jul 2019
 16:20:57 +0000
From: Bruce Rogers <BROGERS@suse.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PULL 6/6] ati-vga: switch to vgabios-ati.bin
Thread-Index: AQHVLZ4GACjNRNcZpk+7A15WWIIybKa3iQQA
Date: Tue, 2 Jul 2019 16:20:56 +0000
Message-ID: <89f9490f16b4a50ccb039e4b1de2bacb5567d82f.camel@suse.com>
References: <20190628103957.9504-1-kraxel@redhat.com>
 <20190628103957.9504-7-kraxel@redhat.com>
In-Reply-To: <20190628103957.9504-7-kraxel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=BROGERS@suse.com; 
x-originating-ip: [137.65.184.169]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13daf7aa-3171-479b-a106-08d6ff094374
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CH2PR18MB3191; 
x-ms-traffictypediagnostic: CH2PR18MB3191:
x-microsoft-antispam-prvs: <CH2PR18MB31919749E74FF396F3220C54D9F80@CH2PR18MB3191.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(199004)(189003)(4326008)(6512007)(99286004)(14454004)(478600001)(6486002)(53936002)(25786009)(229853002)(316002)(6116002)(3846002)(11346002)(68736007)(66066001)(446003)(102836004)(4744005)(6506007)(71200400001)(26005)(72206003)(76176011)(186003)(6436002)(71190400001)(305945005)(81166006)(81156014)(6246003)(86362001)(91956017)(76116006)(118296001)(2501003)(8936002)(7736002)(8676002)(2906002)(14444005)(256004)(5660300002)(66946007)(486006)(66446008)(64756008)(66556008)(66476007)(110136005)(36756003)(54906003)(73956011)(476003)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CH2PR18MB3191;
 H:CH2PR18MB3096.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0uSUxyHtfVD3hfJUnhP5URqJWdD9vZ9w31jg7yGcxxeAwg54XuhEA4a5XJZIsxXaD0hNxewBKaC+F6o9y86WgE7M4CRM1YJ4/BzUuSrcNwn/xeBf3nnD0XpQEoYn8lq9cTKwJGKSjT47p/f2nPVLGXjTwy2snRA8vj2MRLrnGbShPGOcrevcIBx3oC7p0fdcgrN32BLhHiRGV7mnTCcKske9vYoVJ22tTkNPu5i0+zCFxBxYDTtcTIbzwRuVdiMYWDVpsWVZFgHxKp6E1PAJfi6QW1oLig0Gq5Ow/KKVJRqQv+WOzNf8ir/WTgxrGaUMMsnz3aa+G6vZnPji7acNRNgCMZnSvkmvvjsDJCdnWGckMZ1Nrn5tvlbFG2xGEAHigmHx9uYu4fUXiyrbzLohyFq6VHJxbFuIC/nveAKxAc4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B70A0C9CA5B57F409DFE84BC91A215B0@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 13daf7aa-3171-479b-a106-08d6ff094374
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 16:20:56.8920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BROGERS@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3191
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 15.124.64.68
Subject: Re: [Qemu-devel] [PULL 6/6] ati-vga: switch to vgabios-ati.bin
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "cminyard@mvista.com" <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gRnJpLCAyMDE5LTA2LTI4IGF0IDEyOjM5ICswMjAwLCBHZXJkIEhvZmZtYW5uIHdyb3RlOg0K
PiBTaWduZWQtb2ZmLWJ5OiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4NCj4gVGVz
dGVkLWJ5OiBCQUxBVE9OIFpvbHRhbiA8YmFsYXRvbkBlaWsuYm1lLmh1Pg0KPiBNZXNzYWdlLWlk
OiAyMDE5MDYyMDE1MTEwNC4yNjc4LTQta3JheGVsQHJlZGhhdC5jb20NCj4gU2lnbmVkLW9mZi1i
eTogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgaHcvZGlzcGxh
eS9hdGkuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2Rpc3BsYXkvYXRpLmMgYi9ody9kaXNwbGF5
L2F0aS5jDQo+IGluZGV4IGUxYmRlNWUwYjFlMy4uMGNiMTE3Mzg0ODM5IDEwMDY0NA0KPiAtLS0g
YS9ody9kaXNwbGF5L2F0aS5jDQo+ICsrKyBiL2h3L2Rpc3BsYXkvYXRpLmMNCj4gQEAgLTkxMCw3
ICs5MTAsNyBAQCBzdGF0aWMgdm9pZCBhdGlfdmdhX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MNCj4g
KmtsYXNzLCB2b2lkICpkYXRhKQ0KPiAgICAgIGstPmNsYXNzX2lkID0gUENJX0NMQVNTX0RJU1BM
QVlfVkdBOw0KPiAgICAgIGstPnZlbmRvcl9pZCA9IFBDSV9WRU5ET1JfSURfQVRJOw0KPiAgICAg
IGstPmRldmljZV9pZCA9IFBDSV9ERVZJQ0VfSURfQVRJX1JBR0UxMjhfUEY7DQo+IC0gICAgay0+
cm9tZmlsZSA9ICJ2Z2FiaW9zLXN0ZHZnYS5iaW4iOw0KPiArICAgIGstPnJvbWZpbGUgPSAidmdh
Ymlvcy1hdGkuYmluIjsNCj4gICAgICBrLT5yZWFsaXplID0gYXRpX3ZnYV9yZWFsaXplOw0KPiAg
ICAgIGstPmV4aXQgPSBhdGlfdmdhX2V4aXQ7DQo+ICB9DQoNCkkgZG9uJ3Qgc2VlIHZnYWJpb3Mt
YXRpLmJpbiBnZXR0aW5nIGluc3RhbGxlZCBhcyBvbmUgb2YgdGhlIGluc3RhbGxlZA0KYmxvYnMu
IElzIHRoYXQgaW50ZW50aW9uYWwgZm9yIHNvbWUgcmVhc29uPw0KDQpCcnVjZQ0K

