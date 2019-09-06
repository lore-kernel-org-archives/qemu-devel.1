Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67C2C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 21:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A351F2070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 21:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EV2mdSM5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yU5Dwn3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A351F2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6LhE-0003Dg-Go
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 17:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=145f821d7=Dmitry.Fomichev@wdc.com>)
 id 1i6LgG-0002iI-Uy
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 17:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=145f821d7=Dmitry.Fomichev@wdc.com>)
 id 1i6LgF-0001N7-Q8
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 17:22:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35972)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=145f821d7=Dmitry.Fomichev@wdc.com>)
 id 1i6LgB-0001Ih-CM; Fri, 06 Sep 2019 17:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1567804950; x=1599340950;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=VdqQZLYfkDp53uoU/fE65UonhcHZ2yhZMxXBl8yuMwQ=;
 b=EV2mdSM5DwQAeBx4zrbCcOH5MhDIdIcBNaDMvDfh1tyHlULc9wXsK2Qp
 q4g7O0IhR2cKvj8UfnKzuZc4X6ygJnNIZgB+Wt4jjDDerjQzAL3GSbUNP
 QbVOEwAG3jIdSVSyRhBfm7R2bo3mIPsM9CdljodSdugdnEwwYqReO1qzB
 0NR0KLOMucBbl9c7UFHG3EsJGvTIhnW+suZqsgmC555T+VQkiR0x7iOro
 bR9gS7nPKW2KeMYM9o4ik06sV0Q/ENaRDvyE94p2aa0tvmacqo196eEQz
 TIlw6KXHOKXEqio1qzix6YBp3+TI3rXSuXQH6YzDJzX1XVBiRAzSLAxzm g==;
IronPort-SDR: 4cAnQcgC/97upKmttrycZZkuvgKQKcgVOWIC9X040ZuMR0OsHsw8UwpX38SAIIlCKiQ0cj7ArN
 1XwGZ16GY7G8BQsiXSurnlPZ+VszGKpGFEkXiG0uMEANeqrsxSh9SbHvTT0EhitSszCOPi7Brf
 jvR4glfs+4d9t99HZJIT77qPkUHsrmkrPw48cRKWyXIXX2U6qYAgI29HP3MdBuarow3TRSfFjf
 kshheLJn9777zlXWngnG98XxbGpFplw2mP618AAl7vxJzQNvnFp4QZr6y0HNUWhxE+KZJgEwCG
 WnE=
X-IronPort-AV: E=Sophos;i="5.64,474,1559491200"; d="scan'208";a="218330101"
Received: from mail-dm3nam03lp2054.outbound.protection.outlook.com (HELO
 NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.54])
 by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2019 05:22:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chbQ6EOqTJX9mu62Xnz00WLJzooZY7hL5jHpd+hAAclL3ms2QulmOvTu+fnfJ5MkyLLOm5W9Z2b7gL99/dPYjd97J8D4+d0fvavdgUmimqaXDblrEwB2svOdwY6qScNFE9seuU5MsSWbPK4LYqoMSs1hSSXbEVuf+lsXoQZ4RhJrzFdCu9a770AdT+QOurxY5gWdD8eP0h2EtF4breeQ2wVt9LKF3uJy/c8LvFb6T3jzZQ2BoNqE26wPrZdleIufJdVSRGG3F5AzEqzJCgDpqPheynfQuMum60FpG6wuCWF1aFT1gbnuFFTluA/Ai/xyS9Ip1hbHwg1sYiwaee/WEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdqQZLYfkDp53uoU/fE65UonhcHZ2yhZMxXBl8yuMwQ=;
 b=WECIXAAVoRs7BZo8woQHtGPjcoZjxonkFDuiivhnDbxUZCH2KCMKQmxBcRdO5g0URzAVlC62+bYd1OPdx08YKQrHDOl7zaa/aGndb8OzXblGQGBI0ykNM7ggy9D4ho+iM6KPC6KObwAta7U1wW522nqLxIMtkzlFPVX6B8/1r0vg6o31W3+rT8OBwp+XY4+vsYSMqPZ/PN189tjhCS0Ug5qURT+GOVWek0q4CFacbVPyXRVqpkDw3rpmzsQlClc2CVC/gb2Ak2iNqDkx+vhfMUDb7RXSf/yWzi7lBhSNe71aC22FgIfnjndO5REvPhp4cpx+Hby+qLorEONvc+175A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdqQZLYfkDp53uoU/fE65UonhcHZ2yhZMxXBl8yuMwQ=;
 b=yU5Dwn3gN+TDDEO8YyWJDIZ3SIXjwaJKhrNvPN1WdX2fZac9MCc2jUdr6z9cTNkwY+ijBr8bEWM7EgsB7f1s9yhHlqLDx8SDkeXlLFFzWrOyjLkD+o1ryds9gR/HC4WvWQhe4hEA84ITYUYLbHQktTJwJVQ5JsHE/VBlyMSzQUs=
Received: from CO2PR04MB2328.namprd04.prod.outlook.com (10.166.95.11) by
 CO2PR04MB2200.namprd04.prod.outlook.com (10.166.94.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 21:21:58 +0000
Received: from CO2PR04MB2328.namprd04.prod.outlook.com
 ([fe80::b44d:f58f:f4bd:fdea]) by CO2PR04MB2328.namprd04.prod.outlook.com
 ([fe80::b44d:f58f:f4bd:fdea%12]) with mapi id 15.20.2241.018; Fri, 6 Sep 2019
 21:21:58 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "sgarzare@redhat.com" <sgarzare@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v6 1/4] block: Add zoned device model
 property
Thread-Index: AQHVY2Pin1anYO+b30CJivznw8xpWKceToiAgACHxACAAFHVgIAAA1CA
Date: Fri, 6 Sep 2019 21:21:58 +0000
Message-ID: <865db6b8f5a930a34ba58ee6c920c319f1bf3c31.camel@wdc.com>
References: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
 <20190904210100.10501-2-dmitry.fomichev@wdc.com>
 <20190906081117.asr67hq26eqqooxd@steredhat>
 <412e2d4dacac702f443ebe0b8b0871460a953b70.camel@wdc.com>
 <20190906211005.kspfcs725lpadozg@steredhat.homenet.telecomitalia.it>
In-Reply-To: <20190906211005.kspfcs725lpadozg@steredhat.homenet.telecomitalia.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dmitry.Fomichev@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77770be4-1eae-4f1c-f89a-08d733104017
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:CO2PR04MB2200; 
x-ms-traffictypediagnostic: CO2PR04MB2200:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB22003997AC909E95CA5E6CECE1BA0@CO2PR04MB2200.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(51444003)(199004)(189003)(66066001)(4326008)(66446008)(64756008)(86362001)(66476007)(3846002)(2501003)(66556008)(8676002)(1730700003)(6916009)(2906002)(66946007)(305945005)(6512007)(76116006)(91956017)(6436002)(14454004)(5640700003)(6486002)(6116002)(81166006)(118296001)(8936002)(81156014)(7736002)(478600001)(229853002)(2616005)(256004)(316002)(14444005)(486006)(54906003)(71190400001)(36756003)(11346002)(5660300002)(26005)(99286004)(71200400001)(76176011)(446003)(102836004)(186003)(6506007)(6246003)(53936002)(476003)(2351001)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CO2PR04MB2200;
 H:CO2PR04MB2328.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NktvQhqKDF66uE4FUnBLuw7Dra7ZKenhuqJEDuwxh3NhbjUaHcX0YPSzYX4WfQCFx7j6UXsLV/FzzXqoxHWbaGcNfqaxXixTv/tkzUPE1Ty6EtS50mnwpZ83oy6XNRFsl30m5Q7/HMjx54kAm4vuQAA5kXL6sBDKHbYReXPyV/9VZmWDyNXuU7kd6uQ32/2idbXaVGdE/dfM8RpKd0+qtaw/0OXD6v1HpKBli9tFwrRN9QfZK1eyiChJKQiQBl5M1LDW51hdByxp4yIeB6fxNmAyQLE5yXQstuv8KC47nFIdAIGGw/FNeQcUzfoDvjtVkKuSlV6b8wDwj+mQdd/iGycn15/5RZE5Xf6g6Ck3jkphps8CpPisBByCrRGsqxptGR75H8QomTOzcQd8KqUSceL7esFeqQyGJZbT+oCcaaY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4137F904BF149646B98C0D605FCB3375@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77770be4-1eae-4f1c-f89a-08d733104017
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 21:21:58.2031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3NBHl4eBOw5hpDiDImMhNaEeH/NDGSNfcY6Gju+kMuYwYsfoXjFY+NiRZyeUloLoYWAvJ7zu+ZSQbJcCjepXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2200
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
Subject: Re: [Qemu-devel] [PATCH v6 1/4] block: Add zoned device model
 property
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gRnJpLCAyMDE5LTA5LTA2IGF0IDIzOjEwICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3Jv
dGU6DQo+IE9uIEZyaSwgU2VwIDA2LCAyMDE5IGF0IDA0OjE3OjEyUE0gKzAwMDAsIERtaXRyeSBG
b21pY2hldiB3cm90ZToNCj4gPiBPbiBGcmksIDIwMTktMDktMDYgYXQgMTA6MTEgKzAyMDAsIFN0
ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToNCj4gPiA+IE9uIFdlZCwgU2VwIDA0LCAyMDE5IGF0IDA1
OjAwOjU3UE0gLTA0MDAsIERtaXRyeSBGb21pY2hldiB3cm90ZToNCj4gPiA+ID4gVGhpcyBjb21t
aXQgYWRkcyBab25lZCBEZXZpY2UgTW9kZWwgKGFzIGRlZmluZWQgaW4gVDEwIFpCQyBhbmQNCj4g
PiA+ID4gVDEzIFpBQyBzdGFuZGFyZHMpIGFzIGEgYmxvY2sgZHJpdmVyIHByb3BlcnR5LCBhbG9u
ZyB3aXRoIHNvbWUNCj4gPiA+ID4gdXNlZnVsIGFjY2VzcyBmdW5jdGlvbnMuDQo+ID4gPiA+IA0K
PiA+ID4gPiBBIG5ldyBiYWNrZW5kIGRyaXZlciBwZXJtaXNzaW9uLCBCTEtfUEVSTV9TVVBQT1JU
X0hNX1pPTkVELCBpcyBhbHNvDQo+ID4gPiA+IGludHJvZHVjZWQuIE9ubHkgdGhlIGRyaXZlcnMg
aGF2aW5nIHRoaXMgcGVybWlzc2lvbiB3aWxsIGJlIGFsbG93ZWQNCj4gPiA+ID4gdG8gb3BlbiBo
b3N0IG1hbmFnZWQgem9uZWQgYmxvY2sgZGV2aWNlcy4NCj4gPiA+ID4gDQo+ID4gPiA+IE5vIGNv
ZGUgaXMgYWRkZWQgeWV0IHRvIGluaXRpYWxpemUgb3IgY2hlY2sgdGhlIHZhbHVlIG9mIHRoaXMg
bmV3DQo+ID4gPiA+IHByb3BlcnR5LCB0aGVyZWZvcmUgdGhpcyBjb21taXQgZG9lc24ndCBjaGFu
Z2UgYW55IGZ1bmN0aW9uYWxpdHkuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBE
bWl0cnkgRm9taWNoZXYgPGRtaXRyeS5mb21pY2hldkB3ZGMuY29tPg0KPiA+ID4gPiAtLS0NCj4g
PiA+ID4gIGJsb2NrLmMgICAgICAgICAgICAgICAgICAgfCAxNSArKysrKysrKysrKysrKysNCj4g
PiA+ID4gIGluY2x1ZGUvYmxvY2svYmxvY2suaCAgICAgfCAxOSArKysrKysrKysrKysrKysrKyst
DQo+ID4gPiA+ICBpbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oIHwgIDMgKysrDQo+ID4gPiA+ICAz
IGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4g
DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9ibG9jay5jIGIvYmxvY2suYw0KPiA+ID4gPiBpbmRleCA4
NzRhMjlhOTgzLi42OWY1NjVlMWU5IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9ibG9jay5jDQo+ID4g
PiA+ICsrKyBiL2Jsb2NrLmMNCj4gPiA+ID4gQEAgLTQ2NzksNiArNDY3OSwyMSBAQCB2b2lkIGJk
cnZfZ2V0X2dlb21ldHJ5KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB1aW50NjRfdCAqbmJfc2VjdG9y
c19wdHIpDQo+ID4gPiA+ICAgICAgKm5iX3NlY3RvcnNfcHRyID0gbmJfc2VjdG9ycyA8IDAgPyAw
IDogbmJfc2VjdG9yczsNCj4gPiA+ID4gIH0NCj4gPiA+ID4gIA0KPiA+ID4gPiArQmRydlpvbmVk
TW9kZWwgYmRydl9nZXRfem9uZWRfbW9kZWwoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+ID4gPiA+
ICt7DQo+ID4gPiA+ICsgICAgcmV0dXJuIGJzLT5ibC56b25lZF9tb2RlbDsNCj4gPiA+ID4gK30N
Cj4gPiA+ID4gKw0KPiA+ID4gPiArYm9vbCBiZHJ2X2lzX2htX3pvbmVkKEJsb2NrRHJpdmVyU3Rh
dGUgKmJzKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArICAgIC8qDQo+ID4gPiA+ICsgICAgICogSG9z
dCBBd2FyZSB6b25lIGRldmljZXMgYXJlIHN1cHBvc2VkIHRvIGJlIGFibGUgdG8gd29yaw0KPiA+
ID4gPiArICAgICAqIGp1c3QgbGlrZSByZWd1bGFyIGJsb2NrIGRldmljZXMuIFRodXMsIHdlIG9u
bHkgY29uc2lkZXINCj4gPiA+ID4gKyAgICAgKiBIb3N0IE1hbmFnZWQgZGV2aWNlcyB0byBiZSB6
b25lZCBoZXJlLg0KPiA+ID4gPiArICAgICAqLw0KPiA+ID4gPiArICAgIHJldHVybiBiZHJ2X2dl
dF96b25lZF9tb2RlbChicykgPT0gQkRSVl9aT05FRF9NT0RFTF9ITTsNCj4gPiA+ID4gK30NCj4g
PiA+ID4gKw0KPiA+ID4gPiAgYm9vbCBiZHJ2X2lzX3NnKEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0K
PiA+ID4gPiAgew0KPiA+ID4gPiAgICAgIHJldHVybiBicy0+c2c7DQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmggYi9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmgNCj4gPiA+
ID4gaW5kZXggMTI0YWQ0MDgwOS4uMjhkMDY1ZWQ4MCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvaW5j
bHVkZS9ibG9jay9ibG9jay5oDQo+ID4gPiA+ICsrKyBiL2luY2x1ZGUvYmxvY2svYmxvY2suaA0K
PiA+ID4gPiBAQCAtMjcxLDE4ICsyNzEsMzMgQEAgZW51bSB7DQo+ID4gPiA+ICAgICAgICovDQo+
ID4gPiA+ICAgICAgQkxLX1BFUk1fR1JBUEhfTU9EICAgICAgICAgID0gMHgxMCwNCj4gPiA+ID4g
IA0KPiA+ID4gPiArICAgIC8qKg0KPiA+ID4gPiArICAgICAqIFRoaXMgcGVybWlzc2lvbiBpcyBy
ZXF1aXJlZCB0byBvcGVuIGhvc3QtbWFuYWdlZCB6b25lZCBibG9jayBkZXZpY2VzLg0KPiA+ID4g
PiArICAgICAqLw0KPiA+ID4gPiArICAgIEJMS19QRVJNX1NVUFBPUlRfSE1fWk9ORUQgICA9IDB4
MjAsDQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgICBCTEtfUEVSTV9BTEwgICAgICAgICAgICAgICAg
PSAweDFmLA0KPiA+ID4gDQo+ID4gPiBTaG91bGQgd2UgdXBkYXRlIEJMS19QRVJNX0FMTCB0byAw
eDNmPw0KPiA+ID4gDQo+ID4gU3RlZmFubywgZ29vZCBjYXRjaCEgV2lsbCB1cGRhdGUgYW5kIHJl
c2VuZC4uLg0KPiA+IA0KPiANCj4gR29vZCENCj4gDQo+IExvb2tpbmcgYmV0dGVyLCBpZiB3ZSB1
cGRhdGUgaXQsIG1heWJlIHdlIHNob3VsZCBhbHNvIGNoYW5nZSBzb21ldGhpbmcgaW4NCj4geGRi
Z19ncmFwaF9hZGRfZWRnZSgpIHNpbmNlIHRoZXJlIGlzIHRoaXMgbGluZToNCj4gDQo+ICAgICBR
RU1VX0JVSUxEX0JVR19PTigxVUwgPDwgKEFSUkFZX1NJWkUocGVybWlzc2lvbnMpIC0gMSkgIT0g
QkxLX1BFUk1fQUxMICsgMSk7DQo+IA0KPiBXZSBzaG91bGQgZXh0ZW5kIHRoZSBwZXJtaXNzaW9u
cyBhcnJheSBvciBjaGFuZ2UgdGhpcyBjaGVjay4NCj4gDQpZZXMsIEkndmUgbm90aWNlZCB0aGF0
IHRoZSBtYXNrIGNoYW5nZSB0cmlnZ2VycyB0aGlzIEJVR19PTi4NCkkgYW0gYWRkaW5nIEJMS19Q
RVJNX1NVUFBPUlRfSE1fWk9ORUQgcGVybWlzc2lvbiBpbnRvICJwZXJtaXNzaW9ucyIgYXJyYXkg
YW5kIHRoaXMNCmFsc28gcmVxdWlyZXMgYWRkaW5nIHRoZSBwZXJtaXNzaW9uIHRvIHFhcGkgc2No
ZW1hLiBJIHRoaW5rIHRoYXQgd291bGQgYmUgdGhlIHJpZ2h0DQp0aGluZyB0byBkbyByYXRoZXIg
dGhhbiB0byBtb2RpZnkgdGhpcyBjaGVjay4NCg0KRG1pdHJ5DQoNCj4gVGhhbmtzLA0KPiBTdGVm
YW5vDQo=

