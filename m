Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6822C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773A020C56
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="McVVaLth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773A020C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDfM-0006oe-QC
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joe.slater@windriver.com>)
 id 1jlDeW-0005so-FM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:37:32 -0400
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com
 ([40.107.243.63]:6530 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joe.slater@windriver.com>)
 id 1jlDeS-0007EN-Ux
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:37:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fi1df6jTxGP7uHXhfMzngKondvqVGSvpWaGZ1fNVBkEuUsERWwsBNf9woVnU7r7Y5NSVgPACG/CQ5VDNEy3dYbwcmJeQ4z9nLeOf7wB4HzVYT7+Gk40uyLQKgva/SIac9SRpP5znNyI4lLqCzQ0JiKCTvck57BG1Q+f8uMMusjz7bJmXBuc3WbIe0aW95m8PTzZXCUy902/5k7i29JUcIFOx82j1qcbNTlnDyeGlrU1eAAloandAhw1phU6r+n9+7QkOrK6EwK3sYWrNrDMEi5xES1GduKl5FXNIyogLa/XRFPhzrBiifVTE/4igGtLXuH4hOrKHc1D805udVxtz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru4mr7cQF+5jfOkf2LRXSW5SpSOeJWqGYinAv4pztPw=;
 b=QKxo/X4gRoV7mQTWibhWSuvkiNLuXwqJ41CcUiXhtCtu074+ubDArmYlrGF485FCap/OBILYKSUvvWPDZCya1wNQrXwhLq8WljBbhW4/M/Aifei/2/FRtw0vrv63LFfjZoZytQYayqfVyPySYhfoWiRzGIHz2LVhr4TujmQc3hweMmFuaq5NwDjoTkvd45eH0HKqqsQRDOFxr4xAmzqMeHRKm4xaFMu3Z9sHLjFgkHLsWNGQzELk25Zrk1MIHD7T2KS52Omdgm50v9AyVtixnmR8ZmFXC9GfDs5BrV39xZXb+Bx9AQgTpHNzps1gjrrCyZ8dOGtpLS+eCHcyQm78aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru4mr7cQF+5jfOkf2LRXSW5SpSOeJWqGYinAv4pztPw=;
 b=McVVaLthu258ufs2sbAa0LKA4mcF85em3pXeFEoWhDDhMAg3slSErtcmGpSNxyVcFqzQw4b1WUeFNkANhrdHQn5KUEbEPmwaisLG64vRXYwGj944WDX86RSa80KG9BhB5CIILb2hrA5EinjsixTzsM1He7Nu+ZIJtp75R458bnM=
Received: from BY5PR11MB3992.namprd11.prod.outlook.com (2603:10b6:a03:188::10)
 by BY5PR11MB4118.namprd11.prod.outlook.com (2603:10b6:a03:191::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 15:37:25 +0000
Received: from BY5PR11MB3992.namprd11.prod.outlook.com
 ([fe80::2c89:3733:2dbb:3a8d]) by BY5PR11MB3992.namprd11.prod.outlook.com
 ([fe80::2c89:3733:2dbb:3a8d%4]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 15:37:25 +0000
From: "Slater, Joseph" <joe.slater@windriver.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH 1/1] os_find_datadir: search as in version 4.2
Thread-Topic: [PATCH 1/1] os_find_datadir: search as in version 4.2
Thread-Index: AQHWQ79bRF2+FOMQ60ar7fzsw/2lWqjbXYUQ
Date: Tue, 16 Jun 2020 15:37:25 +0000
Message-ID: <BY5PR11MB399239CDC1B3FF27F3FFC934889D0@BY5PR11MB3992.namprd11.prod.outlook.com>
References: <20200615225827.183062-1-joe.slater@windriver.com>
 <CAFEAcA_ZU_w7PaYFVVaW1vzGySOLaNaThVcNQFNmd_GV-hG6Qw@mail.gmail.com>
In-Reply-To: <CAFEAcA_ZU_w7PaYFVVaW1vzGySOLaNaThVcNQFNmd_GV-hG6Qw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [24.4.218.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc81a78a-10b5-436f-5af5-08d8120b2b52
x-ms-traffictypediagnostic: BY5PR11MB4118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB41187B78C62D8CC1469EF918889D0@BY5PR11MB4118.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3QW/8CGdTfSzkB7r4krphQPQJZOHBmE9inG1O2A8gGDlervZkdGyHmXdwCmQbofdxYrv2YEn2m7l5ySzTJDD4fXqCPFzHTgRjjxjarpgeqrF8xJuufH+c0CG/O+sX2VPFcHhKh9sobW5efSrn0gtp/AYxqco56iVm3pluyUBNUyyrRgA//I4j7UbeTsbg0d8yWDaD6pM6nBzY/RIWuonCSR5uv0/F6CHjtai5F5BFRehvedr1de3Odz0qPVHQgT1JC2ej537N3ICKo5VqkCOXPn7gMzOsmfr/hIE+twblrVZ+JWbmd+OeifPkyZnkDDAwSqE3OsTGJWEnFAgSl5Rxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3992.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39850400004)(366004)(376002)(346002)(396003)(136003)(316002)(33656002)(2906002)(7696005)(186003)(53546011)(71200400001)(6506007)(83380400001)(478600001)(54906003)(8936002)(66556008)(4326008)(66446008)(66946007)(6916009)(64756008)(66476007)(26005)(76116006)(8676002)(86362001)(5660300002)(55016002)(52536014)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: blbOOyDkMjH2rysXmTZOP/o4XS/t3VdqlS63QPr5Dm3JuTN0fd0/QIUVlKr57ZYguifSXfUaTY08cKaOjPh/NZ2Pwq5kSW0SlhHbkimpyZlgG5Vfo2cVNyXcZEDJ2Dz/idDrk++rgzHw5y2FuWJFFYzG/LH23NzXDUGW6sPH7y5JmpTyP4t35K/CE60j+aqGmHfHI9hERUBvgGXbKf7Q+NPQ9A7/EcfSQQ0cxFWXwxVWnebV8McJT2PrEiuUNiMWt1pM8tLF3bcUYVgedVv7zZFz2s8wJPz66PtRDmGPPkZoQZTlhTMMQHPVCedAGphVzFseJRNh3J4xx6VOmU37C0dXmGX6wpDdVRJJXhRs0diiZrI7ARIbxuhNE4CENrc7sHb1Zih48XiShK535J9nAwPcbXYV6hbc9sxzcksBs5xj4OFxpjbHSgtnrJDPjwkk2IBVJjbY2PjCCoOlsGohPnmQfZPkKwVxkms3tZrua6Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc81a78a-10b5-436f-5af5-08d8120b2b52
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 15:37:25.2023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBf0BED9zWWnHdyQY5N8zhSM9HqlsntCyPJwCppQMC8svgM6vAFzv+ExBzmNyM1nDo2ndI3aAl20mPR382MKQVCoHIDPbnzT5VWZyOawIvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4118
Received-SPF: pass client-ip=40.107.243.63;
 envelope-from=joe.slater@windriver.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 11:37:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "MacLeod, Randy" <Randy.MacLeod@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsDQoNClNwZWNpZmljYWxseSwgNS4wIGJyZWFrcyB0aGUgd2F5IHlvY3RvIHJ1bnFl
bXUgc3RhcnRzIHFlbXUtc3lzdGVtLSouICBUaGUgaW5zdGFsbGF0aW9uIHBhdGggd2hpY2ggaXMg
bm90IGtub3duIGF0IHFlbXUgYnVpbGQgdGltZSwgaXMgPGFyYml0cmFyeS1wcmVmaXg+L3Vzci97
YmluLHNoYXJlfS4gIEluIGdlbmVyYWwsIHRob3VnaCwgSSB0aGluayBpdCdzIGEgZ29vZCBpZGVh
IHRvIGxvb2sgaW4gInJlYXNvbmFibGUiIGxvY2F0aW9ucyByZWxhdGl2ZSB0byB0aGUgZXhlY3V0
YWJsZSwgbWF5YmUgd2l0aCBjb21tYW5kIGxpbmUgb3B0aW9ucyB0YWtpbmcgcHJlY2VkZW5jZS4N
Cg0KSm9lDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQZXRlciBNYXlkZWxs
IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+IA0KU2VudDogVHVlc2RheSwgSnVuZSAxNiwgMjAy
MCAyOjIwIEFNDQpUbzogU2xhdGVyLCBKb3NlcGggPGpvZS5zbGF0ZXJAd2luZHJpdmVyLmNvbT4N
CkNjOiBRRU1VIERldmVsb3BlcnMgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IE1hY0xlb2QsIFJh
bmR5IDxSYW5keS5NYWNMZW9kQHdpbmRyaXZlci5jb20+OyBNYXJjLUFuZHLDqSBMdXJlYXUgPG1h
cmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT47IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhh
dC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gb3NfZmluZF9kYXRhZGlyOiBzZWFyY2gg
YXMgaW4gdmVyc2lvbiA0LjINCg0KT24gVHVlLCAxNiBKdW4gMjAyMCBhdCAwMDowMCwgSm9lIFNs
YXRlciA8am9lLnNsYXRlckB3aW5kcml2ZXIuY29tPiB3cm90ZToNCj4NCj4gQWx3YXlzIGxvb2sg
Zm9yIC4uL3NoYXJlL3FlbXUgdGhlbiAuLi9wYy1iaW9zIHdoZW4gbG9va2luZyBmb3IgZGF0YWRp
ci4NCg0KQ291bGQgeW91IHByb3ZpZGUgc29tZSBtb3JlIGNvbnRleHQsIHBsZWFzZT8gV2h5IGlz
IHRoaXMgY2hhbmdlIHVzZWZ1bDsgcHJlc3VtYWJseSB3ZSBicm9rZSBzb21lIHNldHVwIGluIDUu
MCwgYnV0IHdoYXQgZXhhY3RseSA/DQoNCkknbSBndWVzc2luZyB0aGlzIG1pZ2h0IGJlIGEgcmVn
cmVzc2lvbiBpbnRyb2R1Y2VkIGJ5IGNvbW1pdA0KNmRkMmRhY2VkZDgzZDEyMzI4IHNvIEknbSBj
Y2luZyB0aGUgcmVsZXZhbnQgcGVvcGxlLg0KDQo+IFNpZ25lZC1vZmYtYnk6IEpvZSBTbGF0ZXIg
PGpvZS5zbGF0ZXJAd2luZHJpdmVyLmNvbT4NCj4gLS0tDQo+ICBvcy1wb3NpeC5jIHwgOSArKysr
KysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL29zLXBvc2l4LmMgYi9vcy1wb3NpeC5jDQo+IGluZGV4IDNjZDUy
ZTFlNzAuLmY3N2RhOTRiZjYgMTAwNjQ0DQo+IC0tLSBhL29zLXBvc2l4LmMNCj4gKysrIGIvb3Mt
cG9zaXguYw0KPiBAQCAtODIsOCArODIsOSBAQCB2b2lkIG9zX3NldHVwX3NpZ25hbF9oYW5kbGlu
Zyh2b2lkKQ0KPg0KPiAgLyoNCj4gICAqIEZpbmQgYSBsaWtlbHkgbG9jYXRpb24gZm9yIHN1cHBv
cnQgZmlsZXMgdXNpbmcgdGhlIGxvY2F0aW9uIG9mIHRoZSBiaW5hcnkuDQo+ICsgKiBUeXBpY2Fs
bHksIHRoaXMgd291bGQgYmUgIiRiaW5kaXIvLi4vc2hhcmUvcWVtdSIuDQo+ICAgKiBXaGVuIHJ1
bm5pbmcgZnJvbSB0aGUgYnVpbGQgdHJlZSB0aGlzIHdpbGwgYmUgIiRiaW5kaXIvLi4vcGMtYmlv
cyIuDQo+IC0gKiBPdGhlcndpc2UsIHRoaXMgaXMgQ09ORklHX1FFTVVfREFUQURJUi4NCj4gKyAq
IE90aGVyd2lzZSwgdGhpcyBpcyBDT05GSUdfUUVNVV9EQVRBRElSIGFzIGNvbnN0cnVjdGVkIGJ5
IGNvbmZpZ3VyZS4NCj4gICAqLw0KPiAgY2hhciAqb3NfZmluZF9kYXRhZGlyKHZvaWQpDQo+ICB7
DQo+IEBAIC05Myw2ICs5NCwxMiBAQCBjaGFyICpvc19maW5kX2RhdGFkaXIodm9pZCkNCj4gICAg
ICBleGVjX2RpciA9IHFlbXVfZ2V0X2V4ZWNfZGlyKCk7DQo+ICAgICAgZ19yZXR1cm5fdmFsX2lm
X2ZhaWwoZXhlY19kaXIgIT0gTlVMTCwgTlVMTCk7DQo+DQo+ICsgICAgZGlyID0gZ19idWlsZF9m
aWxlbmFtZShleGVjX2RpciwgIi4uIiwgInNoYXJlIiwgInFlbXUiLCBOVUxMKTsNCj4gKyAgICBp
ZiAoZ19maWxlX3Rlc3QoZGlyLCBHX0ZJTEVfVEVTVF9JU19ESVIpKSB7DQo+ICsgICAgICAgIHJl
dHVybiBnX3N0ZWFsX3BvaW50ZXIoJmRpcik7DQo+ICsgICAgfQ0KPiArICAgIGdfZnJlZShkaXIp
OyAgLyogbm8gYXV0b2ZyZWUgdGhpcyB0aW1lICovDQo+ICsNCj4gICAgICBkaXIgPSBnX2J1aWxk
X2ZpbGVuYW1lKGV4ZWNfZGlyLCAiLi4iLCAicGMtYmlvcyIsIE5VTEwpOw0KPiAgICAgIGlmIChn
X2ZpbGVfdGVzdChkaXIsIEdfRklMRV9URVNUX0lTX0RJUikpIHsNCj4gICAgICAgICAgcmV0dXJu
IGdfc3RlYWxfcG9pbnRlcigmZGlyKTsNCj4gLS0NCj4gMi4xNy4xDQo=

