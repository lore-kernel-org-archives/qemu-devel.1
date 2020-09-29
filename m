Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00043C2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2C22145D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 02:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ccNKdBVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2C22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN5PV-0007yS-8y
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 22:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kN5O3-00073b-Nz
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 22:29:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:21255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kN5O0-0006qS-Gs
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 22:29:03 -0400
IronPort-SDR: wDEGzB5YJTe4s0I68hmX88FysP7vBPqeF6aMb1SI5+BGJz2sRRh5dai3Iz9+yYnR1vPa529R+b
 t0tE+Ep1kbpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="149760376"
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; d="scan'208";a="149760376"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 19:28:52 -0700
IronPort-SDR: 8tco/ciMmHU2fx0JTp1/vAtel6B9R2cwjr5dMbDDgGXsqpooTs5Pxu4io5DaObrwiINarFJh6W
 +m7dGgLlVkpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; d="scan'208";a="345111565"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga002.fm.intel.com with ESMTP; 28 Sep 2020 19:28:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Sep 2020 19:28:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 28 Sep 2020 19:28:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 28 Sep 2020 19:28:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0aw6fND5ii+AN3zkC1Ap76kS9ecaMU+0ziMBUvVgu3loAv9AC0T39jkdvV6K+YoA/4H1UpVJsFnpV/B4LKc2VFDdcY8SRmEqLW/WOcEXM7HQnIiJaPHLGbh5K3Fr5liZB14D53ZDc1/1sPhpAfmIX+JuQ1AjGROUg4yrS9QdKLcFGkaMcxflumBemeWRU9cmxhTjlCzGlKpHZKSnaTLH40rDyvJbxfe6jes84WyqpdieC3qKcbVvIarIjFfqqa3cXjzQngioiM6KbbxKlF7PPiCb3TCk+8Kq4xUKWRoO4Ynt+9395L7iLEj/qyWgTYcbaNvFfm/sMTmfB6plyn+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70QDiPXxijJcoWujJ1OOZ9yvAcXEJdc4F1jEw2wKG8Q=;
 b=QwLWUD4UiOry4b9ID5azjSPjW3616/2Y28eSZJhQYbmRIit6ebf2ALb8ajIfFS4QmUFR1/Hyp3lGItZZny3dGIzEAQPqSI9q40YNB5W8SbLaJpSf0+0LWgmztEGhbUUqpgy9Lsx2Nr32Lnevqitdw9+gwijWrZg5BZBGMxlWKqQATPyXpkTsKmoj7OA4d9Iv7+6iOBAGagIQD5uYIJuuGdpKUA9stme1tm4YA+NqvwJGjcgT8Ngvps3PIjozpCp+RxfY0a/qm9sZjPe3kJ9gWsuCPDX+kVt2u/d1Kl06wmpNv37QgXn1njX2d+qBM9MRhoFvHHqgy7o6aQA8bFJbYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70QDiPXxijJcoWujJ1OOZ9yvAcXEJdc4F1jEw2wKG8Q=;
 b=ccNKdBVCcoPuhb8qlrTttHGVDHg6x39F4r3UmSqFEAf9qD1CD0gA33y5v4bGBq60GYjaA0w2zuj3AaB1P95qNN3PrtRSQIu3ztUbZED9Q73nRrIwGOcnn7hEzu5ojcSNV6iEwtDCocMOwHMWJgAlLDndVq2Mf9QML4E34SVdL4U=
Received: from CY4PR11MB1447.namprd11.prod.outlook.com (2603:10b6:910:10::16)
 by CY4PR11MB1446.namprd11.prod.outlook.com (2603:10b6:910:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 02:28:49 +0000
Received: from CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669]) by CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 02:28:49 +0000
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Thread-Topic: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Thread-Index: AQHV6xftvSMRfFRc8kimWdtr0uia4ql62AeAgAAHfACAAANNgIAAOo2AgAABtgCAAAL4AIADspyAgAApGICAAFKaoIAAHEIAgADCguA=
Date: Tue, 29 Sep 2020 02:28:48 +0000
Message-ID: <CY4PR11MB1447410A5DFEDEEEC51A2A9780320@CY4PR11MB1447.namprd11.prod.outlook.com>
References: <1582580312-19864-2-git-send-email-luwei.kang@intel.com>
 <20200925161539.GS3717385@habkost.net>
 <MW3PR11MB46655375CAECC74BA2D7CAECF2360@MW3PR11MB4665.namprd11.prod.outlook.com>
 <20200925165415.GT3717385@habkost.net>
 <036ba624-670c-d6b7-721c-ad5c9d648c1f@redhat.com>
 <20200925202956.GV3717385@habkost.net>
 <db31a0fa-c6cf-4730-6d64-f81228948d30@redhat.com>
 <CY4PR11MB1447C4CA6B6D455EE33F724D80350@CY4PR11MB1447.namprd11.prod.outlook.com>
 <d85a3245-c774-5098-5d14-2e3b3a2eda18@redhat.com>
 <CY4PR11MB1447BB55E8AF4915CD56655980350@CY4PR11MB1447.namprd11.prod.outlook.com>
 <20200928141228.GW3717385@habkost.net>
In-Reply-To: <20200928141228.GW3717385@habkost.net>
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
x-ms-office365-filtering-correlation-id: 497c4ffb-631e-4584-5126-08d8641f6608
x-ms-traffictypediagnostic: CY4PR11MB1446:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB14464D35668B55B38EFF008180320@CY4PR11MB1446.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ssnoIhjRGo+GabxvZSfBNZK0u+IR9MJPKc6+ZcaPVC11rys2KN6oRbUvLto+HOrggpstbtJebWIGx2r2V689LTx3IuDADJYzSwZTT9IGzyGV6j3g+HDjneHryXe8yB7XC6eX+duUGSXPfOUTmqeLV5+hss2LvQ4hoEVpYqinaC3vquepHw36gZwLwMnDkVWfwNnWds6Bwg8ji3cm+hMKS7npGjHD0DNJF7wEbdKiRYod1p3nipvoTe8LS0RK8rLyARYdrIamelAPI7y37wkWwJV/ei8/rMJjOWUd7JYbhj4OH1vfYjLsQqNKt/jSd4YKEtGLVgc6JGOtOZmA3xyTcSc0G5+6q18Zx0BuqL3xFeaRlO6t+pDwvix78rcijZx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1447.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(316002)(8936002)(55016002)(5660300002)(86362001)(33656002)(2906002)(71200400001)(6506007)(478600001)(26005)(186003)(4326008)(6916009)(76116006)(9686003)(52536014)(64756008)(66446008)(7696005)(54906003)(66556008)(66476007)(66946007)(83380400001)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: VQtVIOa1kWt/1wu3opLVaQgDW7Wa2YId+BLcnS5oJYHym7YuJiOoHEQyeZwL/Og3EBNB3WSI6BwS/+StNTKNVxbspa1IG3TPO8LtL6ExyHb2gUPzXWjWBwq3515tWvZkKcFGYKEEv24JuLzO9VHZs4iy1zJqZ+PzdS1FgOTlHGgC8I9lHL6zbLkuXqJjv3y6vm9Sta+wMpUWFamUumMfTgg3Av1Mx1p1F4KEx/KA0HfPVWs+33IU4cMQDNIC3ac3ng++TZWJLr4AehnaWqMHKC5mwR+4FXZ9kcEApTMCVTZwhoTVXth1u0XMaf8awuiivzy+cNz5OAVvuKwnYITgl1nCS2FlSgluTUPZeY3nQxZYz60KXEKdfBrOYHgpsHnoxsmLuCKxIg8br+ipqA9Bz5q1ZY6S88IWvaOeaJJkBlCW8JSHFe1FiA2w3gFJn+W/Fu23Ieu7jwrV1GKYh+5/zSM1y1Qq/1u+dh2ycrlblcRAnJpH243FLQjMxdH5acm0/AgOk8FtBZ2gM8p+Fnqt8Ib+ctefx/LIYnU7gQ3xGQACPecG0Hv/R7S8aVG3Xo8Hg5Zfr93X/MDNPjZnGpoR44IyoZFQXs9pOimvsVtnEHfmS3LitcSut1YhVOUJR52rCV+xCaMvZUsobymBucGHXQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1447.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497c4ffb-631e-4584-5126-08d8641f6608
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 02:28:49.0410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pRDo0rMd2KGX3F7yISSHRqhokcZEVuMFBdXXF6vbAbYMjI+uyvSBb/OGaXZrcMgTSV+r9aCzhdNszpUSMLxqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1446
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=luwei.kang@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:28:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Strong,
 Beeman" <beeman.strong@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+ID4gPj4+PiBObywgaXQncyBub3QgcG9zc2libGUuICBLVk0gZG9lc24ndCBoYXZlIGEgc2F5
IG9uIHdoYXQgdGhlDQo+ID4gPiA+Pj4+IHByb2Nlc3NvciB3cml0ZXMgaW4gdGhlIHRyYWNpbmcg
cGFja2V0cy4NCj4gPiA+ID4+PiBDYW4gS1ZNIHJlZnVzZSB0byBlbmFibGUgcGFja2V0IGdlbmVy
YXRpb24gaWYgQ1NiYXNlIGlzIG5vdCB6ZXJvDQo+ID4gPiA+Pj4gYW5kIENQVUlELihFQVg9MTRI
LEVDWD0wKVtiaXQgMzFdIHNlZW4gYnkgZ3Vlc3QgaXMgZGlmZmVyZW50IGZyb20NCj4gaG9zdD8N
Cj4gPiA+ID4+DQo+ID4gPiA+PiBZZXMsIGJ1dCB0aGUgcHJvY2Vzc29yIGNvdWxkIGNoYW5nZSBv
cGVyYXRpbmcgbW9kZSAoYW5kIGhlbmNlDQo+ID4gPiA+PiBDU2Jhc2UpIHdoaWxlIHRyYWNpbmcg
aXMgYWN0aXZlLiAgVGhpcyBpcyB2ZXJ5IHVubGlrZWx5LCBzaW5jZSBpdA0KPiA+ID4gPj4gd291
bGQgcmVxdWlyZSBub256ZXJvIENTLWJhc2UgYW5kIGEgMzItYml0IGhvc3QsIGJ1dCBpbiBwcmlu
Y2lwbGUNCj4gPiA+ID4+IG5vdCBpbXBvc3NpYmxlIChjb3VsZCBiZSBhIGZpcm13YXJlIGNhbGws
IGZvciBleGFtcGxlKS4NCj4gPiA+ID4+DQo+ID4gPiA+PiBUaGUgb25seSBzb2x1dGlvbiBpcyBm
b3IgS1ZNIHRvIGFjY2VwdCBib3RoLCBhbmQgZm9yIFFFTVUgdG8NCj4gPiA+ID4+IHJlZnVzZSBh
IHNldHRpbmcgdGhhdCBkb2VzIG5vdCBtYXRjaCB0aGUgaG9zdC4NCj4gPiA+ID4+DQo+ID4gPiA+
DQo+ID4gPiA+IFNvIEkgbmVlZCB0byBhZGQgYSBwYXRjaCBpbiBLVk0gdG8gZGlzYWJsZWQgdGhl
IEludGVsIFBUIHdoZW4gdGhlDQo+ID4gPiA+IENTYmFzZSBpcyBub3QgemVybyBhbmQgdGhlIGd1
ZXN0IExJUCBkaWZmZXJlbnQgZnJvbSB0aGUgaG9zdC4gQW5kDQo+ID4gPiA+IHRoaXMgbGltaXRh
dGlvbiBpbiBxZW11IChkaXNhYmxlZCB0aGUgUFQgd2hlbiBMSVAgaXMgZW5hYmxlZCBpbg0KPiA+
ID4gPiB0aGUgaG9zdCkgY2FuIGJlIHJlbW92ZS4gSXMgdGhhdCByaWdodD8NCj4gPiA+DQo+ID4g
PiBObywgaWYgYSBmZWF0dXJlIGNhbm5vdCBiZSBlbXVsYXRlZCwgdGhhdCBtZWFucyBpdCBjYW5u
b3QgYmUgZW5hYmxlZA0KPiA+ID4gdW5sZXNzIGl0IG1hdGNoZXMgdGhlIGhvc3QuICBUaGF0J3Mg
Z2VuZXJhbGx5IG5vdCBhIHByb2JsZW0gc2luY2UNCj4gPiA+IEludGVsIFBUIGlzIHVzdWFsbHkg
dXNlZCBvbmx5IHdpdGggIi1jcHUgaG9zdCIuDQo+ID4gPg0KPiA+DQo+ID4gVGhlIGxpbWl0YXRp
b24gb2YgTElQIGluIHFlbXUgd2lsbCBtYXNrIG9mZiB0aGUgSW50ZWwgUFQgaW4gS1ZNIGd1ZXN0
DQo+ID4gZXZlbiB3aXRoICItY3B1IGhvc3QiLiBlLmcuIFRoaXMgYml0IHdpbGwgYmUgc2V0IGlu
IFNub3dSaWRnZSBIVyBhbmQNCj4gPiBsYXRlci4NCj4gDQo+IFRoaXMgYmVoYXZpb3IgY2FuIGFu
ZCBzaG91bGQgYmUgY2hhbmdlZC4NCj4gDQo+ID4NCj4gPiBIb3cgYWJvdXQgIi1jcHUgY3B1X21v
ZGVsLCAraW50ZWwtcHQiIHVzZSBjYXNlPyBUaGUgY3VycmVudCB2YWx1ZSBvZg0KPiA+IEludGVs
IFBUIENQVUlEIGlzIGEgY29uc3RhbnQuIENhbiB3ZSBtYWtlIHRoZSBJQ1ggQ1BVSUQgYXMgYmFz
aWMNCj4gPiBpbmZvcmF0aW9uKExJUCBpcyAwKSBhbmQgdXNpbmcgIitpbnRlbC1wdC1saXAiDQo+
ID4gdG8gbWFrZSBJbnRlbCBQVCB3b3JrIG9uIHRoZSBDUFUgd2hpY2ggTElQIGlzIDEgb24gdGhl
IGhvc3Q/IEFzIHlvdQ0KPiA+IG1lbnRpb25lZCBiZWZvcmUsIEludGVsIFBUIGNhbm5vdCBiZSBl
bmFibGVkIGluIGd1ZXN0IHVubGVzcyBpdA0KPiA+IG1hdGNoZXMgdGhlIGhvc3QuDQo+IA0KPiBU
aGlzIG1ha2VzIHNlbnNlLCBidXQgeW91IGNhbiBhbHNvIG1ha2UgZWFjaCBDUFUgbW9kZWwgc2V0
IGEgZGVmYXVsdCBmb3IgdGhlDQo+IExJUCBiaXQuICAiLWNwdSBTbm93UmlkZ2UsK2ludGVsLXB0
IiBjb3VsZCBzZXQNCj4gTElQPTEgYnkgZGVmYXVsdC4NCg0KSSBoYXZlIGEgcXVlc3Rpb24gb24g
aG93IHRvIHNldCBMSVA9MSBpbiBTbm93UmlkZ2UgYnkgZGVmYXVsdC4gDQoxLiBTZXQgTElQIGlu
ICJidWlsdGluX3g4Nl9kZWZzW10iIFNub3dSaWRnZSBDUFUgbW9kZWwuIFRoZSBMSVAgaW5jbHVk
ZWQgaW4gQ1BVSUQuKGVheD0xNHgsZWN4PTApZWN4W2JpdDMxXSBhbmQgYSBuZXcgbGVhZiBuZWVk
cyB0byBiZSBhZGRlZC4NCjIuIENoZWNraW5nIHRoZSBDUFUgbW9kZWwgaW4gdGhlIGxhdGVyIHNv
ZnR3YXJlIGZsb3cgYW5kIHNldCB0aGUgTElQIGJpdCBpZiB0aGUgQ1BVIG1vZGVsIGlzIFNub3dy
aWRnZS4gQW5kIHdlIGFsc28gbmVlZCB0byBhZGQgbW9yZSBDUFUgbW9kZWwncyBjaGVja2luZyBm
b3IgbmV3IENQVXMuDQoNCldoYXQgaXMgeW91ciBvcGluaW9uPw0KDQpUaGFua3MsDQpMdXdlaSBL
YW5nDQoNCj4gDQo+IC0tDQo+IEVkdWFyZG8NCg0K

