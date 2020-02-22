Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9E4C35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 02:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062D8206E2
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 02:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="hg/8I0TD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062D8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5KDC-0004a0-6O
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 21:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasper.lowell@bt.com>) id 1j5KCa-00048Q-Ul
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 21:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasper.lowell@bt.com>) id 1j5KCY-00051X-WE
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 21:07:32 -0500
Received: from smtpe1.intersmtp.com ([213.121.35.74]:49317)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasper.lowell@bt.com>)
 id 1j5KCY-0004zd-EN
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 21:07:30 -0500
Received: from tpw09926dag15e.domain1.systemhost.net (10.9.212.15) by
 BWP09926079.bt.com (10.36.82.110) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Sat, 22
 Feb 2020 02:07:26 +0000
Received: from tpw09926dag08h.domain1.systemhost.net (10.9.202.47) by
 tpw09926dag15e.domain1.systemhost.net (10.9.212.15) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Sat, 22 Feb 2020 02:07:26 +0000
Received: from bwp09926083.bt.com (10.36.82.114) by
 tpw09926dag08h.domain1.systemhost.net (10.9.202.47) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Sat, 22 Feb 2020 02:07:26
 +0000
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (104.47.21.54) by
 smtpe1.intersmtp.com (10.36.82.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1713.5; Sat, 22 Feb 2020 02:07:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKF+pQx+ETcz8pndNXGWpYk7kJ4OL6+IeQsvQjwSM6fYrZH5vCNDZdfV29nImhALpDijRreaRqAQNkUwtfsWTDM9o+VtTzhHQJaph13m/cOBEhqGSaZ5zuubWAn2iXpM4HjOy6Ps/8d/KBLk38yuld991oRyLUfi5y9PUeK+JloMlrp8X+UlrglA58cTTO1L9zGZqu/34o3f77EHN5srNX6YC9Xhar+dXdG3PYwrRmK03E7KWE6ZaCVAeZlPM5v4uDzW0aa2qw5uZguglxEagq+o3eRaTLR2etsfW1wzHx+On4JuBk1VbCRwA6NURquu4xxrgiIhGQh+jK+1GfEVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbpTx6TWOjzNOR/3tfa7F4NSmO+WeCrbMjhnJEfwmxY=;
 b=KzzGLJr6fa8ItGSrPa2tgyuTH4E7xlG0cWAPkUN1TgbfaUw8MFDboLWRIawI937gJb2BwlExImMFXKnVkWDZhClsh2F2PsAYlQ7A9/QvW3bsTrllH6kEYUpOneQg6i9lFDroFquj72K8fIRbrQH01aJRSYeVhQ7UisZgw1EPRrSZ/JqiuWdSypAe7f71/JBCktWGq1SA9UBlqIR/EaB6Z9kYxvctmLvM+TsPQyoManCTP2OyxtzagoVa6Qc5IXIm0bBouD+hISnLcEM9xOBq6GukgS8334Uf5GO4IgiZwD57Cm1YyaPMXP+1oSAwWQ7O82r1ssJBmzkqbTbyu6Ab6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbpTx6TWOjzNOR/3tfa7F4NSmO+WeCrbMjhnJEfwmxY=;
 b=hg/8I0TD9uG4Y8yILAdNky7bipmHC6N20DQTmgsAmejXr2ZEuan82LCYz++P54zfZ5dbPjoOmS6+CxBgIElgrRB7/A/KaQF1lzGeHMwiem6VGzsFWqatzExYw6l6mjmXFjAUP5+eRbddc2ObRSktxWcj4zvqEf+hkxXwDs4eBAg=
Received: from CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM (20.179.109.212) by
 CWXP123MB2327.GBRP123.PROD.OUTLOOK.COM (20.176.63.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Sat, 22 Feb 2020 02:07:26 +0000
Received: from CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e475:38a3:109b:b884]) by CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e475:38a3:109b:b884%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 02:07:25 +0000
From: <jasper.lowell@bt.com>
To: <balaton@eik.bme.hu>
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
Thread-Topic: [PATCH] hw/ide: Remove status register read side effect
Thread-Index: AQHV6IMztk0nS91QXUSAhbuFxp1TiaglyjyAgACuYAA=
Date: Sat, 22 Feb 2020 02:07:25 +0000
Message-ID: <d805ea83320fdb2de626b0657e94a87bc0ea5015.camel@bt.com>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <alpine.BSF.2.22.395.2002211635360.45267@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2002211635360.45267@zero.eik.bme.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jasper.lowell@bt.com; 
x-originating-ip: [147.10.27.86]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4b1bdf7-d748-4df1-671b-08d7b73bf64c
x-ms-traffictypediagnostic: CWXP123MB2327:
x-microsoft-antispam-prvs: <CWXP123MB23272D1F72D511FB5855D0FB83EE0@CWXP123MB2327.GBRP123.PROD.OUTLOOK.COM>
x-antispam-2: 1
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(189003)(199004)(5660300002)(8676002)(81156014)(316002)(36756003)(4326008)(8936002)(2906002)(54906003)(81166006)(6916009)(71200400001)(66446008)(66556008)(91956017)(64756008)(6506007)(66476007)(6512007)(86362001)(76116006)(6486002)(478600001)(66946007)(186003)(2616005)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CWXP123MB2327;
 H:CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bt.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8nNaTbMDNuOU6nPQFc0W4u7tqVNkd/UWYtWiM4Zwn/hTraF67u//lHwbrX0R8xSMmQ3GLSfhQRYgnDpRKZFHhAIw/5HEUPhsC1InCABWQ62HTfxAQyRqZO/bBdjsq9CDGvhFfL/Q28KPc+OpLTYi0uatPaXr33F1M7d4xVz+6CYSCeJe76egHG/ecKEQwvGs8FUEGu6hkXKW+I3ga98FjISJLJdzTx0qmJfS2Yl4U//KWg7BSSa2TrRO3wEX5Vpg+hWbOTJQziED/615p8uyVv2D+j3vp1nxJZTgwAnWmu+nBpppuXk2ILtikm6wtE9wxuGbRK/wTLLNgEC9EAauivAIC1sD+9XvnimE6UTEAZhB9EmbYYXPz/bjMBWY6ppDBS5AqeO+sKG8NH890Tpyf93FZILRW4Sn61NMh/8M5tKraF7pWAA41flgFrY8T4h
x-ms-exchange-antispam-messagedata: gyZ3ejufPE4NevYV58EORQ7PswHX+A5gZfKNFKeJHr1dNJvm/kQsdEmnjMX2wgC2ij7eunsR7TNY0MNJ5pYhVVie+P0WMAnscWF+E6zUQBK8Vg72R7rqTEDDubhW1ccMWeyrLT+0DfMB6b29jNbSCA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <427C5B8733A2F44BA23C27717DAB5130@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b1bdf7-d748-4df1-671b-08d7b73bf64c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 02:07:25.8071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EuUDwstj1H0NDJJSyhuZgCP8lB5uDRsFrqo7qoHQB4mozqYqnR/ht6H8Qkb4TEnbQ+C0/Om9Gxt3qQ3t8r7+Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2327
X-OriginatorOrg: bt.com
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.74
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBUaGUgY2hpcCBkb2NzIGRvbid0IG1lbnRpb24gYW55IHNpZGUgZWZmZWN0LCB0aGV5IG9ubHkg
c2F5IHRoYXQgdGhlDQo+IERNQSANCj4gSVJRIGFuZCBFcnJvciBiaXRzIGluIHRoZSBidXMgbWFz
dGVyIElERSBzdGF0dXMgcmVnIChiaXRzIDIgYW5kIDEpDQo+IGFyZSANCj4gd3JpdGUgMSB0byBj
bGVhcg0KDQpJIGhhdmVuJ3QgZm91bmQgYW55IGRvY3VtZW50YXRpb24gdGhhdCBtZW50aW9uIHRo
YXQgc2lkZSBlZmZlY3QgZWl0aGVyLg0KQXMgeW91IHNheSwgaXQgb25seSBtZW50aW9ucyB0aGF0
IHlvdSBzaG91bGQgc2V0IHRoZSBiaXQgdG8gY2xlYXIuDQpXaGlsZSB0aGUgc2lkZSBlZmZlY3Qg
b2YgY2xlYXJpbmcgaW50ZXJydXB0cyBieSByZWFkaW5nIHRoZSBzdGF0dXMNCnJlZ2lzdGVyIGRv
ZXNuJ3QgYXBwZWFyIHRvIGJlIGluIGRvY3VtZW50YXRpb24gYW55d2hlcmUgKHRvIG15DQprbm93
bGVkZ2UpLCBJIGRvIHNlZSB0aGlzIHNpZGUgZWZmZWN0IHJlZmVyZW5jZWQgaW4gdGhlIHNvdXJj
ZSBjb2RlIG9mDQpkcml2ZXJzIG9jY2FzaW9uYWxseS4NCg0KSW4gL2RyaXZlcnMvaWRlL2lkZS1p
by5jIG9mIHRoZSBMaW51eCBrZXJuZWw6DQovKg0KICogV2hhY2sgdGhlIHN0YXR1cyByZWdpc3Rl
ciwganVzdCBpbiBjYXNlDQogKiB3ZSBoYXZlIGEgbGVmdG92ZXIgcGVuZGluZyBJUlEuDQogKi8N
Cih2b2lkKWh3aWYtPnRwX29wcy0+cmVhZF9zdGF0dXMoaHdpZik7DQoNCkFsb25nIHdpdGg6DQog
KglUaGVyZSdzIG5vdGhpbmcgcmVhbGx5IHVzZWZ1bCB3ZSBjYW4gZG8gd2l0aCBhbiB1bmV4cGVj
dGVkDQppbnRlcnJ1cHQsDQogKglvdGhlciB0aGFuIHJlYWRpbmcgdGhlIHN0YXR1cyByZWdpc3Rl
ciAodG8gY2xlYXIgaXQpLCBhbmQNCmxvZ2dpbmcgaXQuDQoNClRoZSBDTUQ2NHggc3BlY2lmaWMg
Y29kZSBpbiB0aGUgTGludXgga2VybmVsIGRvZXMgZXhwbGljaXRseSBzZXQgdGhlDQpJUlEgYml0
cyBpbiB0aGUgYnVzIG1hc3RlciBJREUgc3RhdHVzIHJlZ2lzdGVyIHRvIGNsZWFyIGl0LiBJJ20g
bm90DQpzdXJlIHdoeSwgc28gbWF5YmUgc29tZW9uZSBlbHNlIGNhbiBjaGltZSBpbiBleHBsYWlu
aW5nIHdoeSBMaW51eA0Kc29tZXRpbWVzIGNsZWFycyBpbnRlcnJ1cHRzIGJ5IHJlYWRpbmcgdGhl
IHN0YXR1cyByZWdpc3RlciBhbmQgb3RoZXINCnRpbWVzIGZvbGxvd3MgdGhlIGRvY3VtZW50YXRp
b24gYW5kIHNldHMgdGhlIHJlcXVpcmVkIGJpdHMuIFRoZSBPcGVuQlNEDQpkcml2ZXIgYWxzbyBh
cHBlYXJzIHRvIHNldCB0aGUgYml0cyBleHBsaWNpdGx5Lg0KDQpJIHRoaW5rIHRoZSByZWFzb24g
d2h5IHRoZSBTb2xhcmlzIDEwIGRyaXZlciBjcmFzaGVzIGZhdGFsbHkgd2hlcmVhcw0KTGludXgg
YW5kIE9wZW5CU0QgaWdub3JlIHRoZSBzaWRlIGVmZmVjdCBpcyBiZWNhdXNlIHdoZW4gY2xlYXJp
bmcNCmludGVycnVwdHMsIFNvbGFyaXMgMTAgZXhwZWN0cyB0aGUgaW50ZXJydXB0IGJpdCB0byBi
ZSBzZXQgYW5kIGNoZWNrcw0KdGhpcy4gTGludXggYW5kIE9wZW5CU0QgYXBwZWFyIHRvIGNsZWFy
IGl0IHJlZ2FyZGxlc3Mgb2YgaXRzIHN0YXRlLg0KDQpXaXRoIHRoZSBwYXRjaCwgSSBkaWRuJ3Qg
bm90aWNlIGFueSByZWdyZXNzaW9uIGZvciBPcGVuQlNEIHVuZGVyIFN1bjR1DQphbmQgdGhlcmUg
d2VyZSBpbXByb3ZlbWVudHMgdG8gdGhlIFNvbGFyaXMgMTAgYm9vdCB1bmRlciBTdW40dS4NCg0K
PiBVbmZvcnR1bmF0ZWx5IA0KPiB0aGlzIGRvZXMgbm90IGNoYW5nZSBteSBwcm9ibGVtcyB3aXRo
IG90aGVyIEJNRE1BIGRldmljZXMgb24gUFBDLg0KDQpUaGlzIHBhdGNoIGRvZXNuJ3Qgc29sdmUg
YWxsIHRoZSBwcm9ibGVtcyBmb3IgU29sYXJpcyAxMC4gSXQgZ2V0cw0KZnVydGhlciBpbiB0aGUg
Ym9vdCBwcm9jZXNzIGJ1dCBpdCBpcyBzdGlsbCB1bmFibGUgdG8gbW91bnQgdGhlIGZpbGUNCnN5
c3RlbS4gSSBzdXNwZWN0IHRoYXQgdGhlcmUgYXJlIG1vcmUgYnVncyBpbiB0aGUgSURFL0NNRDY0
NiBlbXVsYXRpb24uDQpJJ20gZ29pbmcgdG8gY29udGludWUgbG9va2luZyBpbnRvIGl0LiBJdCdz
IHN0aWxsIHBvc3NpYmxlIHdlIGFyZSBiZWluZw0KYWZmZWN0ZWQgYnkgdGhlIHNhbWUgYnVncy4g
UmlnaHQgbm93LCBJJ20gY29uc2lkZXJpbmcgdGhhdCB0aGUNCnVucmVzcG9uc2l2ZSBzZXJpYWwg
Y29uc29sZSB1bmRlciBTdW40dSBvbiBTb2xhcmlzIDEwIGlzIGR1ZSB0byBub3QNCmJlaW5nIGFi
bGUgdG8gbW91bnQgdGhlIGZpbGUgc3lzdGVtIGFuZCBwdWxsIHRoZSByZXF1aXJlZCBhc3NldHMg
Zm9yDQp0aGUgaW5zdGFsbGF0aW9uIG1lbnUuDQoNCj4gdGhpcyBjaGFuZ2Ugc2VlbXMgdG8gYnJl
YWsgDQo+IHNvbWV0aGluZyBlbHNlIGFjY29yZGluZyB0byBhIENJIHRlc3QgcmVwb3J0IGZyb20g
cGF0Y2hldy4NCg0KVGhlIHRlc3QgYXBwZWFycyB0byBicmVhayBoZXJlIGluIC90ZXN0cy9xdGVz
dC9pZGUtdGVzdC5jIGZvciBvYnZpb3VzDQpyZWFzb25zOg0KLyogUmVhZGluZyB0aGUgc3RhdHVz
IHJlZ2lzdGVyIGNsZWFycyB0aGUgSVJRICovDQpnX2Fzc2VydCghcXRlc3RfZ2V0X2lycShxdHMs
IElERV9QUklNQVJZX0lSUSkpOw0KDQpTaG91bGQgdGhlIHBhdGNoIEkndmUgc3VnZ2VzdGVkIGJl
IGNvcnJlY3QsIHRoaXMgdGVzdCB3b3VsZCBuZWVkIHRvIGJlDQp1cGRhdGVkLiBUaGlzIGlzIG15
IGZpcnN0IHBhdGNoIGF0dGVtcHQgZm9yIFFFTVUgc28gSSdtIG5vdCBzdXJlIHdoYXQNCnRoZSBw
cm9jZXNzIGlzLiBTaG91bGQgSSBiZSBzdWJtaXR0aW5nIGEgbmV3IFYyIHBhdGNoIHdpdGggdGhl
c2UNCmNoYW5nZXM/IEkgd29uJ3QgaGF2ZSB0aGUgb3Bwb3J0dW5pdHkgdG8gdXBkYXRlIHRoZSBw
YXRjaCBmb3IgYSBmZXcNCmRheXMgYnV0IHdpbGwgY29udGludWUgd2F0Y2hpbmcgdGhlIHRocmVh
ZCBmb3IgcmV2aWV3cy4NCg0KVGhhbmtzLA0KSmFzcGVyIExvd2VsbC4NCg0KDQpPbiBGcmksIDIw
MjAtMDItMjEgYXQgMTY6NDMgKzAxMDAsIEJBTEFUT04gWm9sdGFuIHdyb3RlOg0KPiBPbiBGcmks
IDIxIEZlYiAyMDIwLCBqYXNwZXIubG93ZWxsQGJ0LmNvbSB3cm90ZToNCj4gPiBUaGUgTGludXgg
bGliQVRBIEFQSSBkb2N1bWVudGF0aW9uIG1lbnRpb25zIHRoYXQgb24gc29tZSBoYXJkd2FyZSwN
Cj4gPiByZWFkaW5nIHRoZSBzdGF0dXMgcmVnaXN0ZXIgaGFzIHRoZSBzaWRlIGVmZmVjdCBvZiBj
bGVhcmluZyB0aGUNCj4gPiBpbnRlcnJ1cHQgY29uZGl0aW9uLiBXaGVuIGVtdWxhdGluZyB0aGUg
Z2VuZXJpYyBTdW40dSBtYWNoaW5lDQo+ID4gcnVubmluZw0KPiA+IFNvbGFyaXMgMTAsIHRoZSBT
b2xhcmlzIDEwIENNRDY0NiBkcml2ZXIgZXhpdHMgZmF0YWxseSBiZWNhdXNlIG9mDQo+ID4gdGhp
cw0KPiA+IGVtdWxhdGVkIHNpZGUgZWZmZWN0LiBUaGlzIHNpZGUgZWZmZWN0IGlzIGxpa2VseSB0
byBub3QgZXhpc3Qgb24NCj4gPiByZWFsDQo+ID4gQ01ENjQ2IGhhcmR3YXJlLg0KPiANCj4gVGhl
IGNoaXAgZG9jcyBkb24ndCBtZW50aW9uIGFueSBzaWRlIGVmZmVjdCwgdGhleSBvbmx5IHNheSB0
aGF0IHRoZQ0KPiBETUEgDQo+IElSUSBhbmQgRXJyb3IgYml0cyBpbiB0aGUgYnVzIG1hc3RlciBJ
REUgc3RhdHVzIHJlZyAoYml0cyAyIGFuZCAxKQ0KPiBhcmUgDQo+IHdyaXRlIDEgdG8gY2xlYXIg
c28gdGhpcyBtaWdodCBiZSBPSyBidXQgdGhpcyBjaGFuZ2Ugc2VlbXMgdG8gYnJlYWsgDQo+IHNv
bWV0aGluZyBlbHNlIGFjY29yZGluZyB0byBhIENJIHRlc3QgcmVwb3J0IGZyb20gcGF0Y2hldy4N
Cj4gVW5mb3J0dW5hdGVseSANCj4gdGhpcyBkb2VzIG5vdCBjaGFuZ2UgbXkgcHJvYmxlbXMgd2l0
aCBvdGhlciBCTURNQSBkZXZpY2VzIG9uIFBQQy4NCj4gDQo+IFJlZ2FyZHMsDQo+IEJBTEFUT04g
Wm9sdGFuDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc3BlciBMb3dlbGwgPGphc3Blci5sb3dl
bGxAYnQuY29tPg0KPiA+IC0tLQ0KPiA+IGh3L2lkZS9jb3JlLmMgfCAxIC0NCj4gPiAxIGZpbGUg
Y2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9ody9pZGUvY29y
ZS5jIGIvaHcvaWRlL2NvcmUuYw0KPiA+IGluZGV4IDgwMDAwZWI3NjYuLjgyZmQwNjMyYWMgMTAw
NjQ0DQo+ID4gLS0tIGEvaHcvaWRlL2NvcmUuYw0KPiA+ICsrKyBiL2h3L2lkZS9jb3JlLmMNCj4g
PiBAQCAtMjIxMCw3ICsyMjEwLDYgQEAgdWludDMyX3QgaWRlX2lvcG9ydF9yZWFkKHZvaWQgKm9w
YXF1ZSwNCj4gPiB1aW50MzJfdCBhZGRyKQ0KPiA+ICAgICAgICAgfSBlbHNlIHsNCj4gPiAgICAg
ICAgICAgICByZXQgPSBzLT5zdGF0dXM7DQo+ID4gICAgICAgICB9DQo+ID4gLSAgICAgICAgcWVt
dV9pcnFfbG93ZXIoYnVzLT5pcnEpOw0KPiA+ICAgICAgICAgYnJlYWs7DQo+ID4gICAgIH0NCj4g
PiANCj4gPiANCg==

