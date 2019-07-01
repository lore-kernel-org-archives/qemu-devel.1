Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5749C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D27C206A2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WJoEl0qD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LNS16dVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D27C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi30D-0004Yw-Do
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 16:34:17 -0400
Received: from [2001:470:142:3::10] (port=54213 helo=eggs.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=078c2aed5=Alistair.Francis@wdc.com>)
 id 1hi2y4-00037p-Ly
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=078c2aed5=Alistair.Francis@wdc.com>)
 id 1hi2xw-0002CU-Ax
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:32:02 -0400
Received: from [68.232.141.245] (port=24951 helo=esa1.hgst.iphmx.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=078c2aed5=Alistair.Francis@wdc.com>)
 id 1hi2xS-000276-FB; Mon, 01 Jul 2019 16:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562013088; x=1593549088;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=t0zilVrsnptR4o/X16EGoLIx2lBppe5iNJ1mY2Dq4Uw=;
 b=WJoEl0qDBZxjnkqRIAlB1+1dnPejZZQnaxiVj2bDBhvs2J4bQ1TzFD2k
 a9vq4vYYsUWGuv5h4ArxWWKQB0mh68+QnWBIQ6yp+by5ivMFsxr0O1IKk
 OSCy3Q6ERJmUk52P4Dq+L15dkU2rUu789PyUCFXADDbN3YSUVgCrYZEMZ
 h0k6jUN7Ui0laAzFOYDJhZOBEuw3XYDMMnxr35QStJeMnF6bBMCxAzOoD
 XhZ/s9EYPcXSQKgeqxNGN61vuePShtIwWX6Y7emnxkYPw7wd5KXmu4T1V
 xfpnSqnWTex7z3FGrCDjfDj3BJM5FLDyBFK/3rsv3Ggn1ZJ5k14/fpphU A==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; d="scan'208";a="218363525"
Received: from mail-by2nam01lp2052.outbound.protection.outlook.com (HELO
 NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.52])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 02:19:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0zilVrsnptR4o/X16EGoLIx2lBppe5iNJ1mY2Dq4Uw=;
 b=LNS16dVW1zuY/WP2i3DBEhvkuwas2ahDzSw/8gqXUkU3aMqGndl9rHfcN3KjBodrVHpRtP6kHXJfRlFz0ESSfeAgDASdW3ALBQyW/tNpSxtggP4P5n5vUKIA5jPSGttu5gdO44kdEt6Knon5DFsGymVpw0VZk4t7hNjeyr9FEE0=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB5655.namprd04.prod.outlook.com (20.179.56.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Mon, 1 Jul 2019 18:19:37 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::40b0:3c4b:b778:664d]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::40b0:3c4b:b778:664d%7]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 18:19:37 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Thread-Topic: [PULL 33/34] roms: Add OpenSBI version 0.3
Thread-Index: AQHVLPx3D6cSVSLMSUSkcnC2JIn/F6a2AV8AgAAO5QCAAAOyAIAAAYuAgAABxYCAAAEbgA==
Date: Mon, 1 Jul 2019 18:19:37 +0000
Message-ID: <9363cb8764e800d8c30ff6722c680e4aa8bd9271.camel@wdc.com>
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-34-palmer@sifive.com>
 <CAFEAcA8sscJQ2GCwL1gM+EcRtfHQb1v0BwORt6ncH54x51TCVg@mail.gmail.com>
 <5896113812cd914308e5b617377f8e8205224cfe.camel@wdc.com>
 <CAFEAcA_-h6b_f1fuWh7NkGo+FT0xSyCDXgd3b4pwEvNDN8HcJw@mail.gmail.com>
 <efaaaa7aabddfb8481af4c5b2eeec23513f8fcb8.camel@wdc.com>
 <CAFEAcA_cwm_1VhGW7yGL6=ja7TuO3c9perBs_OoWMaXBhJYH9g@mail.gmail.com>
In-Reply-To: <CAFEAcA_cwm_1VhGW7yGL6=ja7TuO3c9perBs_OoWMaXBhJYH9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b32c80c0-eb54-453d-c94d-08d6fe50acff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB5655; 
x-ms-traffictypediagnostic: BYAPR04MB5655:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5655322D78DC7D0B042CAEAF90F90@BYAPR04MB5655.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(24433001)(73956011)(316002)(54906003)(2906002)(71190400001)(6486002)(71200400001)(229853002)(5640700003)(476003)(66476007)(6436002)(66066001)(118296001)(53936002)(64756008)(66556008)(66946007)(66446008)(25786009)(26005)(5660300002)(6246003)(305945005)(6512007)(478600001)(7736002)(8936002)(186003)(2501003)(11346002)(6916009)(76176011)(486006)(68736007)(72206003)(256004)(446003)(7416002)(4326008)(2351001)(102836004)(6506007)(8676002)(36756003)(86362001)(76116006)(81156014)(3846002)(6116002)(81166006)(99286004)(2616005)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5655;
 H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Af/fZd+PqOl3YDSyOuYQkCdVAYC5LFj/XQj3/hetKfydElTAd97XeZBasVijo+qPgFI6XsklLu0v67xAjfAU2vSW5U7y9DhpmVVJT2CQ1KuKJRjrTTVAkhKXyqUllVSq19L/b4ie9qnJIWp62mSzOFHVmvhjbvVfQFyyZEji/z0I29GO/y587eyuqPjLFp0t5owY6o1NC4Z1wxa5yIHzg8gKsn6XFkmuzAefqCaQk2HJsny0Nx23ViB4BlKrsqCouyYddbKWwZrxEwVVHjqFtl929k38e/wqtqRkOSj/LLLtCjKaVyIkZYAv8SFDxTcEdiJt9Z9oVDlfsWqFd07h1Aciabc+BSse9PtbmuoBrDBpekiDcP6558b8rJCGaCrzdisy9SdL4k40GQUyL/CFesrXyypYjanc8qMA3wApbYI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1F79ACECBAE8E44AB732B3F3E19846F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32c80c0-eb54-453d-c94d-08d6fe50acff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 18:19:37.1137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Alistair.Francis@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5655
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.141.245
Subject: Re: [Qemu-devel] [PULL 33/34] roms: Add OpenSBI version 0.3
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "palmer@sifive.com" <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gTW9uLCAyMDE5LTA3LTAxIGF0IDE5OjEzICswMTAwLCBQZXRlciBNYXlkZWxsIHdyb3RlOg0K
PiBPbiBNb24sIDEgSnVsIDIwMTkgYXQgMTk6MDksIEFsaXN0YWlyIEZyYW5jaXMgPA0KPiBBbGlz
dGFpci5GcmFuY2lzQHdkYy5jb20+IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAxOS0wNy0wMSBhdCAx
OTowMSArMDEwMCwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gPiA+IE9uIE1vbiwgMSBKdWwgMjAx
OSBhdCAxODo1MCwgQWxpc3RhaXIgRnJhbmNpcyA8DQo+ID4gPiBBbGlzdGFpci5GcmFuY2lzQHdk
Yy5jb20+IHdyb3RlOg0KPiA+ID4gPiBQUzogSXQgc2VlbXMgbGlrZSB0aGVyZSBhcmUgc3RpbGwg
c29tZSBpc3N1ZXMgd2l0aCB0aGlzIHBhdGNoDQo+ID4gPiA+IHNvDQo+ID4gPiA+IG1heWJlDQo+
ID4gPiA+IGl0J3Mgd29ydGggZHJvcHBpbmcgdGhpcyBwYXRjaCBmcm9tIHRoZSBQUiBzbyB0aGF0
IHdlIGNhbiBnZXQNCj4gPiA+ID4gZXZlcnl0aGluZyBlbHNlIG1lcmdlZC4NCj4gPiA+IA0KPiA+
ID4gWWVhaCwgdGhhdCB3b3VsZCBiZSBteSBzdWdnZXN0aW9uLg0KPiA+IA0KPiA+IENhbiB5b3Ug
ZG8gdGhhdCB3aGVuIHlvdSBtZXJnZSBpdCBvciBkb2VzIFBhbG1lciBoYXZlIHRvIHNlbmQgdGhl
DQo+ID4gUFINCj4gPiBhZ2Fpbj8NCj4gDQo+IFBhbG1lciBuZWVkcyB0byByZXNwaW4gaXQgLS0g
cHVsbHMgYXJlIHNpZ25lZCBhbmQgSSBjYW4ndA0KPiBtb2RpZnkgdGhlbSwgb25seSBlaXRoZXIg
YXBwbHkgdGhlbSBvciBub3QuIChUZWNobmljYWxseSBJDQo+IGNvdWxkIGluIHRoZW9yeSBjaGVy
cnktcGljayBhbGwgdGhlIG90aGVyIGNvbW1pdHMgb3V0IG9mIHRoZW0NCj4gYnV0IHRoYXQgd291
bGQgYmUgYSBodWdlIGFtb3VudCBvZiBtYW51YWwgbGFib3VyLikNCg0KTm8gd29ycmllcy4NCg0K
QFBhbG1lciBjYW4geW91IHBsZWFzZSBkcm9wIHRoZXNlIHR3byBwYXRjaGVzIGZyb20gdGhpcyBQ
Uj8NCg0KaHcvcmlzY3Y6IExvYWQgT3BlblNCSSBhcyB0aGUgZGVmYXVsdCBmaXJtd2FyZQ0Kcm9t
czogQWRkIE9wZW5TQkkgdmVyc2lvbiAwLjMNCg0KU29ycnkgZm9yIHRoZSBhbGwgdGhlIGxhc3Qg
bWludXRlIGNoYW5nZXMuIEknbGwgd2FpdCB1bnRpbCBPcGVuU0JJIDAuNA0KdG8gcmVzcGluIHRo
b3NlIHR3byBwYXRjaGVzLg0KDQpBbGlzdGFpcg0KDQo+IA0KPiB0aGFua3MNCj4gLS0gUE1NDQo=

