Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3BFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9F22145D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="SPqQyzxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9F22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN5PF-0007xR-J4
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 22:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kN5O5-00073o-Iv
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 22:29:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:45556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kN5O3-0006rG-Gi
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 22:29:05 -0400
IronPort-SDR: vGsvXJP5SJw8x3/8BpzM3jva8PdXLd3sYAy/kh08gfNibUn/o+vnteKVrg5e36VLnNuoeas44L
 V2DF+d9GIb9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="180256166"
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; d="scan'208";a="180256166"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 19:29:00 -0700
IronPort-SDR: eVuunb+VQdiodwjBmHva9fxIaosmNbzWgsTR0Nn6GW97GVWCFsLMXbjBkFgJut8yiYeNZYw7uE
 FOGJRMhdBhaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; d="scan'208";a="324503211"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga002.jf.intel.com with ESMTP; 28 Sep 2020 19:29:00 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Sep 2020 19:28:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 28 Sep 2020 19:28:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 28 Sep 2020 19:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9v8yfLVIRqs8Nxl1h9bAW4rVhdRsrbn3Z7Fxac0OQah9A+ntTDKx6rOWLSkbBPwH6flNUmy//21JZytyzQctOqce/kmWhdSrE8J8Me4CGnKu40/SAdn0GL2jZutLr4TtjziOegLF33qOpa+WMqu0fBPt8joXtS2QqkXbmw0jMe2J/qCRnkky814uvi4d4ZpQrNuHIXK9kvSz/LOPqx56YeGACRueo+suE77sIDUvtb+AazlfUYNSp8l+of4o+t52XRAcdKtidue/cEgmBdJNxnzJ6GMjFtrsSHjrijorVymFeNIsjgR4EJ6po65VnM93mZjzmVLTEPF9hH0e+hS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETEF5ZqCUV9cxjRcx68f3ZaOa574TX5dwnBU40+eUMU=;
 b=JpZ7ZOEITVFSgFEcFJs5dCZO3dicAGQ2wF1pIm7bIrkvDMncgdDtl6CwQskEiSxasMXfstpNYYayKVgnx33qF3hdYtVj/ZYPpJ8ltJybxvftfJ8wyHpkddhSGPHiAsqG2kI7RzrrT7dHGXkL+hJjEFectTVMivtTKBt0I/BYE1YoYUzlzHZ0bzFofYclLbRzmVZOQJNeUs9UlDr4EdLGLIOjoNIBdZXGL+bB1njVmEd/DAfzvZUS/9Z7n6ysCp/T8vr9TtK9gd3z6siAYh3Kess06iaFCzYxY2torVQcGaaHT2uwzUa852ORGBvuF9vdB9Azbtr36YPN3pBNnAY3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETEF5ZqCUV9cxjRcx68f3ZaOa574TX5dwnBU40+eUMU=;
 b=SPqQyzxS+x5ly3lftfilsMscrnrbnuVVsWFTt2cKPjwp5xjOyHrXUKLH8r+L1nkm9RyBJFzei9J8IWUtOR6+OZV13E355lqDcJyFsWUbg930zScn0oMJZEvgqWJM1n28uzp/ozhcxmm23oxQGuf0EjPh9mRQKd84mlHrfx5v+UM=
Received: from CY4PR11MB1447.namprd11.prod.outlook.com (2603:10b6:910:10::16)
 by CY4PR11MB1446.namprd11.prod.outlook.com (2603:10b6:910:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 02:28:53 +0000
Received: from CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669]) by CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 02:28:53 +0000
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Thread-Topic: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Thread-Index: AQHV6xftvSMRfFRc8kimWdtr0uia4ql62AeAgAAHfACAAANNgIAAOo2AgAABtgCAAAL4AIADspyAgAApGICAAFKaoIAAR0yAgACXKxA=
Date: Tue, 29 Sep 2020 02:28:53 +0000
Message-ID: <CY4PR11MB1447F4A9A85051891F1E650680320@CY4PR11MB1447.namprd11.prod.outlook.com>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <1582580312-19864-2-git-send-email-luwei.kang@intel.com>
 <20200925161539.GS3717385@habkost.net>
 <MW3PR11MB46655375CAECC74BA2D7CAECF2360@MW3PR11MB4665.namprd11.prod.outlook.com>
 <20200925165415.GT3717385@habkost.net>
 <036ba624-670c-d6b7-721c-ad5c9d648c1f@redhat.com>
 <20200925202956.GV3717385@habkost.net>
 <db31a0fa-c6cf-4730-6d64-f81228948d30@redhat.com>
 <CY4PR11MB1447C4CA6B6D455EE33F724D80350@CY4PR11MB1447.namprd11.prod.outlook.com>
 <d85a3245-c774-5098-5d14-2e3b3a2eda18@redhat.com>
 <CY4PR11MB1447BB55E8AF4915CD56655980350@CY4PR11MB1447.namprd11.prod.outlook.com>
 <761a025d-6973-e4ab-df6b-c25a171d1298@redhat.com>
In-Reply-To: <761a025d-6973-e4ab-df6b-c25a171d1298@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1418851c-b90b-4db4-7aac-08d8641f68d3
x-ms-traffictypediagnostic: CY4PR11MB1446:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1446598A775EBEDCE5C5B8D980320@CY4PR11MB1446.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WiAwyrKtKht5BpPPs90+7yrQI0noEczcDbbNDVTbz4LWpyRtsqSUXuZdM16I7GObIumRgYmQ76qVEHRD4Bq/nNHsFT3RSysO9PSBRr+B/mbnsojRFqw3zBtqGkSS1SwbFjwGveRIDoHkoRpkr2PibB5lKpFPJHyztaqq+2s4XO1Vjy5rP4nMm+l5ON1oBWoVHd4pDWUtSBWV2pRQutYPK+mparc97Y/qx5S6b5ocTjLp1+zVIurTPGle39C9vvTK+Sin9idDijBrZZLRglQa6jrt3pr092KIubAMBcBox4wBTv+feDug9UvzE2bAHT1epslacfI6W0f3TmBGRGdHdn8YJ5oyUGIMDod1QQM6QhoZjJCkEWgyWqAqCCKRG0Md
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1447.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(316002)(8936002)(55016002)(5660300002)(86362001)(33656002)(2906002)(71200400001)(6506007)(478600001)(110136005)(26005)(186003)(4326008)(76116006)(9686003)(52536014)(64756008)(66446008)(7696005)(54906003)(66556008)(66476007)(66946007)(83380400001)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: MbLpB+c54+BbljWIlVJhxG60V2EyJwiaocbHqqk4aIXb2So/CpyWIovnlKycP73D5lN8i95ip/76M3g6KCNPjEkLq3GvrSkob/2wz4C4lJhx7GDGq44CHWSfNM+Arz4raKFmKSidigvwyb4FJF1FzqbA3LhryVG2AYEAvAEMPrUf5zRynz1l5v5+GXS7RM3G/TaUe5gMdizqxeHPyxX7UDH52V4c3OERmEFreMvJRHjwfEmq9oLWYFeJi5/cH0GW/rWzP9Uy2eUZLtgWDk1IV0gTedlIhsOBfFyJPTMDbpyWkgDXmywFsV4fbqfeY+/aezwQkyhOpYyQSBWKnXs1GtUE+Cs/pcSQZCX06Fr70SdmWPtrY8VHTIZRoagCX7W6N6RreKwPvtQuN1vYOpFiCD792t3S2LK2JbUGtVeXv02rXvZ6/C7s+9E/Uts5o1+9T6sk68nQwH2//PnPHBW2+vAML5eIXor1sQvuGYJzaFoIsVXWdQnsiQ6i3m525At8DldZQWby/lMmJa4nqGsmf04AVeeHdxobIaCc2UMdDs99Vasao4SQ1FzcobMa1c/aOiXuZmTdu7HP6cK1nfOsjG4WRQ9tV3vPwKpwQXen2kS7WI3JV2RrHky46z+a05sdx7spJEt2f7IKi11hzfTgqw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1447.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1418851c-b90b-4db4-7aac-08d8641f68d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 02:28:53.7869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdQQqhdZdDjHpe+R1TncXpqQUg9+0G7mo/3qD3yMgOlNmaO6eAl9tU9UIGLPmfW2QsUp6iNxej5f6i8cPsFyHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1446
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88; envelope-from=luwei.kang@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:29:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Strong,
 Beeman" <beeman.strong@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+PiBObywgaWYgYSBmZWF0dXJlIGNhbm5vdCBiZSBlbXVsYXRlZCwgdGhhdCBtZWFucyBpdCBj
YW5ub3QgYmUgZW5hYmxlZA0KPiA+PiB1bmxlc3MgaXQgbWF0Y2hlcyB0aGUgaG9zdC4gIFRoYXQn
cyBnZW5lcmFsbHkgbm90IGEgcHJvYmxlbSBzaW5jZQ0KPiA+PiBJbnRlbCBQVCBpcyB1c3VhbGx5
IHVzZWQgb25seSB3aXRoICItY3B1IGhvc3QiLg0KPiA+Pg0KPiA+IFRoZSBsaW1pdGF0aW9uIG9m
IExJUCBpbiBxZW11IHdpbGwgbWFzayBvZmYgdGhlIEludGVsIFBUIGluIEtWTSBndWVzdA0KPiA+
IGV2ZW4gd2l0aCAiLWNwdSBob3N0Ii4gZS5nLiBUaGlzIGJpdCB3aWxsIGJlIHNldCBpbiBTbm93
UmlkZ2UgSFcgYW5kDQo+ID4gbGF0ZXIuDQo+IA0KPiBJIGFncmVlIHRoYXQgUUVNVSB3b3VsZCBo
YXZlIHRvIGxlYXJuIGFib3V0IExJUC4gIFVubGlrZSB0aGlzIHBhdGNoLCBob3dldmVyLA0KPiB4
ODZfY3B1X2ZpbHRlcl9mZWF0dXJlcyB3b3VsZCBoYXZlIHRvIGZhaWwgaWYgaG9zdCBMSVAgIT0g
Z3Vlc3QgTElQLiAgVGhhdCBpcywNCj4gc29tZXRoaW5nIGxpa2UNCj4gDQo+ICAgICAgICAgICAg
KGVjeF8wICYgSU5URUxfUFRfSVBfTElQKSkgIT0NCj4gCQkoZW52LT5mZWF0dXJlc1tJTlRFTF9Q
VF9FQ1hfMF0gJiBJTlRFTF9QVF9JUF9MSVApDQo+IA0KPiB3aGVyZSAiaW50ZWwtcHQtbGlwIiB3
b3VsZCBiZSBhIGZlYXR1cmUgaW4gZW52LT5mZWF0dXJlc1tJTlRFTF9QVF9FQ1hfMF0uDQoNCkdv
dCBpdC4gVGhhbmtzLg0KDQpMdXdlaSBLYW5nDQoNCj4gDQo+ID4gSG93IGFib3V0ICItY3B1IGNw
dV9tb2RlbCwgK2ludGVsLXB0IiB1c2UgY2FzZT8gVGhlIGN1cnJlbnQgdmFsdWUgb2YNCj4gPiBJ
bnRlbCBQVCBDUFVJRCBpcyBhIGNvbnN0YW50LiBDYW4gd2UgbWFrZSB0aGUgSUNYIENQVUlEIGFz
IGJhc2ljDQo+ID4gaW5mb3JhdGlvbihMSVAgaXMgMCkgYW5kIHVzaW5nICIraW50ZWwtcHQtbGlw
IiB0byBtYWtlIEludGVsIFBUIHdvcmsNCj4gPiBvbiB0aGUgQ1BVIHdoaWNoIExJUCBpcyAxIG9u
IHRoZSBob3N0PyBBcyB5b3UgbWVudGlvbmVkIGJlZm9yZSwgSW50ZWwNCj4gPiBQVCBjYW5ub3Qg
YmUgZW5hYmxlZCBpbiBndWVzdCB1bmxlc3MgaXQgbWF0Y2hlcyB0aGUgaG9zdC4NCj4gDQo+IFll
cywgdGhpcyB3b3VsZCB3b3JrLg0KPiANCj4gUGFvbG8NCg0K

