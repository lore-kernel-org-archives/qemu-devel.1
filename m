Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2208C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4667821D95
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="W02u0Fk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4667821D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMt9M-00073T-6V
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kMsUW-0001yv-5k
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:42:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:51128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kMsUS-0006Nn-Ju
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:42:51 -0400
IronPort-SDR: PpSIo+9KR50ADGL0iBaC/eKs9BtAaefePIvHyiQ74c/At8NXXJ1sEecmcTr4wcoBfAlUpQ/psA
 CmH5OOCu9tew==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="161216576"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; d="scan'208";a="161216576"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 05:42:43 -0700
IronPort-SDR: DDnS9VyFzssPcEzuA768sT80A2/ZxFun/WlTTZjY7yXOOlHKIyI9JsB3sG34KYV4OXUAW+VFmw
 xICJF0NsLoHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; d="scan'208";a="340406704"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga008.jf.intel.com with ESMTP; 28 Sep 2020 05:42:43 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Sep 2020 05:42:42 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 28 Sep 2020 05:42:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 28 Sep 2020 05:42:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 28 Sep 2020 05:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pieg3AvdcZJ55DP2mlfFIICZEFJ3KL7fW7NjUUDlHQaxEuDlFZfcwQvC9cRl7/Ka/rHJSyeMp10q7fSSgtZv1rwZNWNooM1BldzGQeddS4nvrQFH8VasAARJ1UtIN84OyGg8j2sOMPXdeedz09Ka/UFBfzWa5ftSvRuWYSAbp57ShhCUlZjD//KW9NcIqto+A7jjxqFPJXH6Kl+LUM+fcY3DoTG/7x9VUTXvykfE4eIX7vBQoVowU8CitFhLj5Cq7AiCip0nOy9MElQoEwH4Y1bYJmAUD7EpKXTSd5kpEB0wHNeIkbUn0V1/lZDMcpgyuaFypJa1PF2x3YrYVjALIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1WMH8YkY66J7w8bcYBI8mJFRDle6kzGxHKJhX7sRUo=;
 b=beEaXE6zbo6sPy2KPdiXn1k4Bd67NzoIcNDZnirUw3xmVO0oG92TJquY8/fdFILZlnfrB0HECMw+n1De9viv81Ap2eJpP0rDuMLGqMyF7No3kk6hIrmyWp2TWT3r6Dl22D+j+0E4WA2edmYqJ6lPkV5j5iG6YOqH4trbIOJukk8ftm8SPRV1wNUoFwL7Nm5nX/5hOQo6y8dibuI/N1PNA3BK2HphzKRStxYLea7i10AHB47eE7ObnA4E9TTRMZ6Hru6R1cO+2uEDeGTaJ8V7ybp1EUiq+jxW2kBpDWwZgjGN1Y80T2hCkaNayEz3Ro8gh/MBGabh6nw8O8NKXO6P9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1WMH8YkY66J7w8bcYBI8mJFRDle6kzGxHKJhX7sRUo=;
 b=W02u0Fk22ZDtq6Nthsz4yvd2pSikAG3clq147Jh2nL0Z8JYaNw0KBw3g1oJ8GfkJu6yor6Hlkpfo8hYlBi8NcYGJFQsnb+1ynckZSm+S0ez9fyNFE0FVJMWglD85WGfR1x/gdYcP2kxIL8Q8BDZOL6HkSEj3wL7K3ad3gJ53slg=
Received: from CY4PR11MB1447.namprd11.prod.outlook.com (2603:10b6:910:10::16)
 by CY4PR11MB2055.namprd11.prod.outlook.com (2603:10b6:903:23::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 12:42:38 +0000
Received: from CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669]) by CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669%4]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 12:42:37 +0000
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Thread-Topic: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Thread-Index: AQHV6xftvSMRfFRc8kimWdtr0uia4ql62AeAgAAHfACAAANNgIAAOo2AgAABtgCAAAL4AIADspyAgAApGICAAFKaoA==
Date: Mon, 28 Sep 2020 12:42:37 +0000
Message-ID: <CY4PR11MB1447BB55E8AF4915CD56655980350@CY4PR11MB1447.namprd11.prod.outlook.com>
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
In-Reply-To: <d85a3245-c774-5098-5d14-2e3b3a2eda18@redhat.com>
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
x-ms-office365-filtering-correlation-id: 26b24e6a-6d6e-437f-0278-08d863abfb4a
x-ms-traffictypediagnostic: CY4PR11MB2055:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB2055935E63AA659886CB010F80350@CY4PR11MB2055.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kSxpYoyTijwyBnF9daXWqUNXEj/zpPz4rnYN4sTvDnfnonp1Zf3oJSD8seyGDjfJKiKpr24ZXILx6FdgT5T5lomeULcY7OI29xXiexCYhhfC3emhCfCInRbrI8zxODLsQB3yJIx/EI5RFJCFzh+uX/HxyC/4OFJGPemKeSw+o7uFlRDxPOZoSBs7LPZJSfT3LnC46Z88oLqn+fejcNJBPd72w25BaV5kuR+afR+1V5ukBKlFAgpdCVn8L4/mq/7qoyCeAy4UphvLgYHkRPrbloz2Fr05QoCbvuJY2wY8IQFS6p+FqX+NmAz5spaSIa5YB1sHAYJXFh2VCADBbcw4qAyvLtyywUgn4JiDqazmHRuuma2u1p+H0gHnwnd7yhYh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1447.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(9686003)(52536014)(110136005)(33656002)(5660300002)(55016002)(86362001)(8936002)(83380400001)(66476007)(8676002)(64756008)(66446008)(316002)(66556008)(76116006)(66946007)(478600001)(7696005)(54906003)(4326008)(26005)(6506007)(186003)(71200400001)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: EQbTAJeRdM6wpnGO/ZzH5tMiANAA6MQaX4vMTlvC0KzecidioXimct8SymFDsN9Q91/oHKkA0cbgpZ7NkO1zJYcR79+jRbRyoF2KqCOj4MKPZO9MBNTacd8ptNkOmDfm9CTz0GZgo2mIul7OrIgmIXnoOVft36V1dRFJIazG4lun8X4Iq3XRkqg8QTNRvZwW7RMIrUJAwSGr+nb2rQhbEy4L2jcWSNbUs0DUFwHMp+gnh7Lcwwhe9Xm5l1lxCvJe0ObtsZsaesseNItcCAKp+SXQXJ4IBLPoOva8p7XUw5DnfPdM6UiLAs/C6nkXM1dSUN9bxbOpywLwMuqS8/CF6e/FNdWAjIbV+m9q7vOJgo7bHJsPTQBjAMVlAutiaY6U0AzURgbFZkkC1k2P/fVrm/S5t4dghsu2Gh9CkJqEPmO/zql4fgIDeuOjf5rAs3w2W7GIryFuSOzzftKwRnIIfb0LSU7/LKlngWf4srwFMw0oxxlJgNjoNGjE8pc+oRkH/u+GdehEPbPw249UIlKe71ObKHTDpUl13nMPQDHeZ982DG5ImrpAsMSERpu+PWxd1cXucU2ML+8baXVzxuczvPcF1tYOSHeN/BVlylaHAlfWSwRME/Ri39jrpEi4KMGaYQ9mWXJYjBhA+h3VBOsI8w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1447.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b24e6a-6d6e-437f-0278-08d863abfb4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 12:42:37.8354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+LRBTsVUJKmval3yj+HXK7bNq6Q7bGY5quzfdDPzF59jlpTJF1pAlStLCdPOAr6GJQ0DyB6Zl8i25X2RcT01A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2055
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=luwei.kang@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 08:42:43
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

PiA+Pj4+IE5vLCBpdCdzIG5vdCBwb3NzaWJsZS4gIEtWTSBkb2Vzbid0IGhhdmUgYSBzYXkgb24g
d2hhdCB0aGUNCj4gPj4+PiBwcm9jZXNzb3Igd3JpdGVzIGluIHRoZSB0cmFjaW5nIHBhY2tldHMu
DQo+ID4+PiBDYW4gS1ZNIHJlZnVzZSB0byBlbmFibGUgcGFja2V0IGdlbmVyYXRpb24gaWYgQ1Ni
YXNlIGlzIG5vdCB6ZXJvIGFuZA0KPiA+Pj4gQ1BVSUQuKEVBWD0xNEgsRUNYPTApW2JpdCAzMV0g
c2VlbiBieSBndWVzdCBpcyBkaWZmZXJlbnQgZnJvbSBob3N0Pw0KPiA+Pg0KPiA+PiBZZXMsIGJ1
dCB0aGUgcHJvY2Vzc29yIGNvdWxkIGNoYW5nZSBvcGVyYXRpbmcgbW9kZSAoYW5kIGhlbmNlIENT
YmFzZSkNCj4gPj4gd2hpbGUgdHJhY2luZyBpcyBhY3RpdmUuICBUaGlzIGlzIHZlcnkgdW5saWtl
bHksIHNpbmNlIGl0IHdvdWxkDQo+ID4+IHJlcXVpcmUgbm9uemVybyBDUy1iYXNlIGFuZCBhIDMy
LWJpdCBob3N0LCBidXQgaW4gcHJpbmNpcGxlIG5vdA0KPiA+PiBpbXBvc3NpYmxlIChjb3VsZCBi
ZSBhIGZpcm13YXJlIGNhbGwsIGZvciBleGFtcGxlKS4NCj4gPj4NCj4gPj4gVGhlIG9ubHkgc29s
dXRpb24gaXMgZm9yIEtWTSB0byBhY2NlcHQgYm90aCwgYW5kIGZvciBRRU1VIHRvIHJlZnVzZSBh
DQo+ID4+IHNldHRpbmcgdGhhdCBkb2VzIG5vdCBtYXRjaCB0aGUgaG9zdC4NCj4gPj4NCj4gPg0K
PiA+IFNvIEkgbmVlZCB0byBhZGQgYSBwYXRjaCBpbiBLVk0gdG8gZGlzYWJsZWQgdGhlIEludGVs
IFBUIHdoZW4gdGhlDQo+ID4gQ1NiYXNlIGlzIG5vdCB6ZXJvIGFuZCB0aGUgZ3Vlc3QgTElQIGRp
ZmZlcmVudCBmcm9tIHRoZSBob3N0LiBBbmQgdGhpcw0KPiA+IGxpbWl0YXRpb24gaW4gcWVtdSAo
ZGlzYWJsZWQgdGhlIFBUIHdoZW4gTElQIGlzIGVuYWJsZWQgaW4gdGhlIGhvc3QpDQo+ID4gY2Fu
IGJlIHJlbW92ZS4gSXMgdGhhdCByaWdodD8NCj4gDQo+IE5vLCBpZiBhIGZlYXR1cmUgY2Fubm90
IGJlIGVtdWxhdGVkLCB0aGF0IG1lYW5zIGl0IGNhbm5vdCBiZSBlbmFibGVkIHVubGVzcyBpdA0K
PiBtYXRjaGVzIHRoZSBob3N0LiAgVGhhdCdzIGdlbmVyYWxseSBub3QgYSBwcm9ibGVtIHNpbmNl
IEludGVsIFBUIGlzIHVzdWFsbHkgdXNlZA0KPiBvbmx5IHdpdGggIi1jcHUgaG9zdCIuDQo+IA0K
DQpUaGUgbGltaXRhdGlvbiBvZiBMSVAgaW4gcWVtdSB3aWxsIG1hc2sgb2ZmIHRoZSBJbnRlbCBQ
VCBpbiBLVk0gZ3Vlc3QgZXZlbiB3aXRoICItY3B1IGhvc3QiLiBlLmcuIFRoaXMgYml0IHdpbGwg
YmUgc2V0IGluIFNub3dSaWRnZSBIVyBhbmQgbGF0ZXIuDQoNCkhvdyBhYm91dCAiLWNwdSBjcHVf
bW9kZWwsICtpbnRlbC1wdCIgdXNlIGNhc2U/IFRoZSBjdXJyZW50IHZhbHVlIG9mIEludGVsIFBU
IENQVUlEIGlzIGEgY29uc3RhbnQuIENhbiB3ZSBtYWtlIHRoZSBJQ1ggQ1BVSUQgYXMgYmFzaWMg
aW5mb3JhdGlvbihMSVAgaXMgMCkgYW5kIHVzaW5nICIraW50ZWwtcHQtbGlwIiB0byBtYWtlIElu
dGVsIFBUIHdvcmsgb24gdGhlIENQVSB3aGljaCBMSVAgaXMgMSBvbiB0aGUgaG9zdD8gQXMgeW91
IG1lbnRpb25lZCBiZWZvcmUsIEludGVsIFBUIGNhbm5vdCBiZSBlbmFibGVkIGluIGd1ZXN0IHVu
bGVzcyBpdCBtYXRjaGVzIHRoZSBob3N0Lg0KDQpUaGFua3MsDQpMdXdlaSBLYW5nDQo=

