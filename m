Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A17C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 05:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4C221548
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 05:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="sEW5EY5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4C221548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMlZz-0003JN-2I
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 01:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kMlZB-0002t9-RH
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 01:19:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:6349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kMlZ9-0008Bn-3j
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 01:19:13 -0400
IronPort-SDR: fZOG20uTffqWqCYJu93SBV749Yy57mKOegFzQ1INOIR4YVSt8GN52IDTcthgLfmfumvWohJ9z8
 Kib2iHFkh2BA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="180096693"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; d="scan'208";a="180096693"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 22:19:04 -0700
IronPort-SDR: Df4gDXJqi08DE/Mfp28+PM5DkwvDtSyFpCQXWEjUlCLoWhrcSxYYtYhxt5uUPJBQpJXjRld5tC
 lNUTWmuKoDyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; d="scan'208";a="349724033"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by FMSMGA003.fm.intel.com with ESMTP; 27 Sep 2020 22:19:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 27 Sep 2020 22:19:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 27 Sep 2020 22:19:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 27 Sep 2020 22:19:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 27 Sep 2020 22:19:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO034Q5G2jA2GGVpwdhNxqlacCY8hdl1nMMEpIjBGYxv66KC3Wg0SC19M+EbbefQipuKHEEqf4JNvycsprNl7k8LI4Cp8VFEEB9rHu+QY9IXoJ9qWfBqMqyQO1RzUUjCM6F7uEb4km2LuvJi8+cN0rewbIy1G3iCfSz9eXnPlRftf9T7pW4oDiPnJLGGOONngiRw4dBoG8ef2p6OFClgpNuDFK3KOkSr3xrD34oh7XEI9aDndqDR1UuyY2guliiOQO6Gt02LOKghujeaYOO+5yCKNaIfLPeOiPWD374BtfK7hJ2V+Ts1g1/10PmzJa4oijc+zR+L54PGX7VG5xDqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8clcFagS9u4IUVqiTfwbavStG1QwdwT6vS9tkJEX+gI=;
 b=djDxDgopvgPPMhzK8Zd2VF+UO+ewMuXk7mxsyt2IVyRBMhw7OKTBa+hi1py346QUE0aaeXAD51i/ROy/DhGHecLsQze7D+4obCKMow3O3HnvOGD7ONJOLuL2GT9GErsumey7/E9FXa+jSiE7xg8WncPzMiBMBMep4SG3oeTsteVnqk/GX8u9F7sdTRVHXHHX2N2mfAzNTBWlsn/Yay6DfTdLTTIwgvgBj+slesigjcZdRhQeGj6L8ZfdgPjZjDcPnukxl0sLTyBCUS3eyIx0eA8BWyuRcaavfpyem2m3uPOxQVUAEY4L66419OQBW7seKkhMdN3DksgI/WU3nn+Csg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8clcFagS9u4IUVqiTfwbavStG1QwdwT6vS9tkJEX+gI=;
 b=sEW5EY5OJ784oaxQSrwsWkH6G+nqasOgwTGDXc+hsDymW37dA85M6yLUpFoOHdkNAWkOFHzVH5yR9fri6B2I68Iu8/u0I0qRS7IF77AX64EWAg9NmDGmA/90aeOwdYng6xOjG5KjxKb7l9JMcflKzNHJPEP11j+roSwr3cNPvgY=
Received: from CY4PR11MB1447.namprd11.prod.outlook.com (2603:10b6:910:10::16)
 by CY4PR11MB1446.namprd11.prod.outlook.com (2603:10b6:910:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 05:19:02 +0000
Received: from CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669]) by CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669%4]) with mapi id 15.20.3412.028; Mon, 28 Sep 2020
 05:19:02 +0000
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Thread-Topic: [PATCH v1 1/3] i386: Remove the limitation of IP payloads for
 Intel PT
Thread-Index: AQHV6xftvSMRfFRc8kimWdtr0uia4ql62AeAgAAHfACAAANNgIAAOo2AgAABtgCAAAL4AIADspyA
Date: Mon, 28 Sep 2020 05:19:01 +0000
Message-ID: <CY4PR11MB1447C4CA6B6D455EE33F724D80350@CY4PR11MB1447.namprd11.prod.outlook.com>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <1582580312-19864-2-git-send-email-luwei.kang@intel.com>
 <20200925161539.GS3717385@habkost.net>
 <MW3PR11MB46655375CAECC74BA2D7CAECF2360@MW3PR11MB4665.namprd11.prod.outlook.com>
 <20200925165415.GT3717385@habkost.net>
 <036ba624-670c-d6b7-721c-ad5c9d648c1f@redhat.com>
 <20200925202956.GV3717385@habkost.net>
 <db31a0fa-c6cf-4730-6d64-f81228948d30@redhat.com>
In-Reply-To: <db31a0fa-c6cf-4730-6d64-f81228948d30@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 363196a0-332b-46b0-b49d-08d8636e02f9
x-ms-traffictypediagnostic: CY4PR11MB1446:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB14463FBBBFE1E285A4B4A0E080350@CY4PR11MB1446.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: punhQ7goFviL2AbH+3aMWMoJ2WfiYqMUgbMxjJsa4lYN41R7C+ZaCjouZMBri8rj/95DCgqPUSG+sggVBoLpEdgyTa0dcgP6sW2aW9MoYRWLuChY+YmSFqiRtpxbIr2+VwH/4MQQl5iCfyfue3lMdg5RLx5Mvk/WdfZOlGYYWYF5RsZ83KhLxebfbkB9sIXFU8UMBzTGKY2grsGX9wbx2E3/wRUfAGVgcQdxNVk4BrN2i6W/je/eFIZcZ4xCB0jp/R2LacJN9J3FANBjSzGZVebKdu7cDrp9zuCxKb2azYTDSn9Tv0wAp9OJrEEByeFBMIbYrL4PqMeTCM4I2blrh3vtZg7c2OqZWKEEP8tJURhg9SMx8Vu7nelVeESeiHS4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1447.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(76116006)(66446008)(64756008)(4326008)(8676002)(4744005)(66556008)(66476007)(66946007)(83380400001)(54906003)(7696005)(55016002)(8936002)(316002)(9686003)(52536014)(478600001)(186003)(26005)(110136005)(5660300002)(86362001)(71200400001)(33656002)(6506007)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: zS7JPgYSJRgvbVUIYxXS0ugy/c/azzS2o4sbiSpBw8G7SXuWOEPkrdprjWrON4P2XeryOK4G8bq4WlMGw9pgPJw6w4EReRlirBR+ol+ugmBTQ/b2j0u4q/GattVbUUpbf4n3d31MNMz5tbYHNJ68qLnlm1TRyO7QHVv170HyQQj2T9mqX5L9Xv+ZapvqC4Q8nZIeJmOtJQfp/9x9LXLXyFnvmixuimug9DRddmMYAVCbgHVxxzu4wCdyxOCUUe/A22XsKWZSkY+oniRQDac9iqpcoIEk4hF053AlaVkMW0wcDPf/tFav4WcX3tOdxWs3Q9U0/FjR8XZmyEZ1BGHlJcf6QmJJcKXGuaJ4FERwKVQUapu4C6WvTAwNVbhKvWDc4PXplWM0+IcOQyaOHSF6eqcNRrk6MHsBiCGUQuV+4Cp62zUAX4tQWZM0gA6j+0mzEb4U8ZO0nI4gEOvFOKR5ktLgZhVmJtSXkhiXb7BZTrsgWUMofqxlCJSr5v/uB35MzZt71kGYbdtZGP9lKG+tBnEQUKV4a8LdW5WZzvfbq+4TY5yQRUt9DEICbZG/fWotQwvK3Gb7aZJkhRpORaZwdTV1VSTftMZqRDS6cc45hjPPpJ/e9BM2/SsyVtIu5uKS/b/u2U92J60/8KGCHJx7fg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1447.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363196a0-332b-46b0-b49d-08d8636e02f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 05:19:01.9517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uNVxpRUtkLOpX851vrTEyw9LiauNDbsIKqvUdQfGkaM2drrr/ZzJ2TOxyFYrPP0UyUEU97vOlsDzBOU7crQJzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1446
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88; envelope-from=luwei.kang@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 01:19:07
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

PiA+PiBObywgaXQncyBub3QgcG9zc2libGUuICBLVk0gZG9lc24ndCBoYXZlIGEgc2F5IG9uIHdo
YXQgdGhlIHByb2Nlc3Nvcg0KPiA+PiB3cml0ZXMgaW4gdGhlIHRyYWNpbmcgcGFja2V0cy4NCj4g
PiBDYW4gS1ZNIHJlZnVzZSB0byBlbmFibGUgcGFja2V0IGdlbmVyYXRpb24gaWYgQ1NiYXNlIGlz
IG5vdCB6ZXJvIGFuZA0KPiA+IENQVUlELihFQVg9MTRILEVDWD0wKVtiaXQgMzFdIHNlZW4gYnkg
Z3Vlc3QgaXMgZGlmZmVyZW50IGZyb20gaG9zdD8NCj4gDQo+IFllcywgYnV0IHRoZSBwcm9jZXNz
b3IgY291bGQgY2hhbmdlIG9wZXJhdGluZyBtb2RlIChhbmQgaGVuY2UgQ1NiYXNlKSB3aGlsZQ0K
PiB0cmFjaW5nIGlzIGFjdGl2ZS4gIFRoaXMgaXMgdmVyeSB1bmxpa2VseSwgc2luY2UgaXQgd291
bGQgcmVxdWlyZSBub256ZXJvIENTLWJhc2UNCj4gYW5kIGEgMzItYml0IGhvc3QsIGJ1dCBpbiBw
cmluY2lwbGUgbm90IGltcG9zc2libGUgKGNvdWxkIGJlIGEgZmlybXdhcmUgY2FsbCwgZm9yDQo+
IGV4YW1wbGUpLg0KPiANCj4gVGhlIG9ubHkgc29sdXRpb24gaXMgZm9yIEtWTSB0byBhY2NlcHQg
Ym90aCwgYW5kIGZvciBRRU1VIHRvIHJlZnVzZSBhIHNldHRpbmcNCj4gdGhhdCBkb2VzIG5vdCBt
YXRjaCB0aGUgaG9zdC4NCj4gDQoNClNvIEkgbmVlZCB0byBhZGQgYSBwYXRjaCBpbiBLVk0gdG8g
ZGlzYWJsZWQgdGhlIEludGVsIFBUIHdoZW4gdGhlIENTYmFzZSBpcyBub3QgemVybyBhbmQgdGhl
IGd1ZXN0IExJUCBkaWZmZXJlbnQgZnJvbSB0aGUgaG9zdC4gQW5kIHRoaXMgbGltaXRhdGlvbiBp
biBxZW11IChkaXNhYmxlZCB0aGUgUFQgd2hlbiBMSVAgaXMgZW5hYmxlZCBpbiB0aGUgaG9zdCkg
Y2FuIGJlIHJlbW92ZS4gSXMgdGhhdCByaWdodD8NCg0KVGhhbmtzLA0KTHV3ZWkgS2FuZyANCg0K

