Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050A9C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2990F207C4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="cNDnALk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2990F207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLj03-0007Cn-Rx
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kLiyQ-0006Ov-Es
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:20:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:49968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kLiyM-0001Xi-Cn
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:20:57 -0400
IronPort-SDR: 3V2SVEHKtaw0TGRrSO4Tmc8z2w6Z7W+3okMcG8kb4NNEukz5PCBKLu1sOngB2m3svQW+W4fkTh
 l70sW8jkLOeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="158854939"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; d="scan'208";a="158854939"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2020 01:20:47 -0700
IronPort-SDR: wkxyM7xGYmRRmw8OXN90ne5tu6IYT4VnQxwdSK5lNCOddAgU36vYHjDD1WtNI5ybIKV3xQNN9A
 kAWpWYFKB9Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; d="scan'208";a="323286579"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga002.jf.intel.com with ESMTP; 25 Sep 2020 01:20:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 25 Sep 2020 01:20:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 25 Sep 2020 01:20:47 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.52) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 25 Sep 2020 01:20:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuTkYgFPvixwBCuWsXSVP65Pv6TVI5Mx4IsQUX9zgsCDvJ9FpmVU2imuQgrr/21kNTpj0EcjT2illivET11wUbPfV7tfHfdD9PcWC4myzZ101U+rwMc5zZ1Y8cesDlJG0I7TdIzlCP2K/E1Tv5pIpH1dUu3z91ICSBF6kcgpLre4e7rH0uXVp+RM2M15mVeF03eLOD6rBFsVUZEjj6ZlC9GZ8RpycyjzbXxvkJqSlPrYufRbxfK33rDXAv0i726z60KlDD9Dv7Obc9ayuHPdB51goEh8u+sADhtvGvtpW4VYw658rodZ9RR1lpeM/US5Al4tVnzFZLDAFLhb7k5ZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPacBPjsTG1sBvCedH42+T+TOrMLfvk4O+jR+8wDq1o=;
 b=n3Drf0FBv/DR2JwKKQJFp0+SfS93dwQUh5fbtZmxGnM/zIYGcgkZ7n2Qe5DZ1mZeipjmBcEpzTtJ9VJHvveMgncXYE1lutuqH/rt2zBqJFztGSFsJBBaZPg2SB9amjBRPjdOrie3G/EawUyVbILM+N5/ZVxDq8sAsNG+KqGa4fy15Bv/Q6lrfNVRnUtPywIMJ3WUuOfU58Uvg6gZqfmLgcI/nB6GtlEeTplT6MnvTNqexPekQMYIHVfpbkzd1zbq/aLiY+MDs9Tqd1L2K5m3e11Xg+7nvZGcveVlsKhWnXvwTLKimYY8TqbyV45WwYS1Srm7UvNXLSKK344hy6/eUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPacBPjsTG1sBvCedH42+T+TOrMLfvk4O+jR+8wDq1o=;
 b=cNDnALk/wdOv9vN5TA64qmy+F/B9cNyEwR5Jt9BGslBrbAm3S/Ol/U5DyfNCKhCBbLo0CSq9t+ps3WNOBPpPx1wdrvQ2Gykg0d71JZ7zPsG3Xvl46uAm2NRHYse9M65r/B9hU2ewTwmusDkb0ZxcoGUx1AKeAVtaHb56BDDKDgs=
Received: from CY4PR11MB1447.namprd11.prod.outlook.com (2603:10b6:910:10::16)
 by CY4PR11MB1973.namprd11.prod.outlook.com (2603:10b6:903:123::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Fri, 25 Sep
 2020 08:20:43 +0000
Received: from CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669]) by CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::e973:a623:3d68:7669%4]) with mapi id 15.20.3412.022; Fri, 25 Sep 2020
 08:20:43 +0000
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Thread-Topic: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Thread-Index: AQHV6xfqjs/57yfCb0eiFZpFzYKOh6hhHEKQgQ8ceoCAA8SvIIAAmwMAgAIsh2CAAMy1AIABdRaAgAAR7ACAAThRwA==
Date: Fri, 25 Sep 2020 08:20:42 +0000
Message-ID: <CY4PR11MB1447241E17FD9C6E8E90179480360@CY4PR11MB1447.namprd11.prod.outlook.com>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <82D7661F83C1A047AF7DC287873BF1E1738B07FF@SHSMSX104.ccr.corp.intel.com>
 <20200918220255.GB57321@habkost.net>
 <CY4PR11MB14473A594C244A5B403ADC26803A0@CY4PR11MB1447.namprd11.prod.outlook.com>
 <20200921165028.GP57321@habkost.net>
 <CY4PR11MB144737577341CF0A5E8BAD1C80380@CY4PR11MB1447.namprd11.prod.outlook.com>
 <20200923141502.GO2044576@habkost.net>
 <CY4PR11MB1447BE049AD2F43295C969D680390@CY4PR11MB1447.namprd11.prod.outlook.com>
 <20200924133430.GB3717385@habkost.net>
In-Reply-To: <20200924133430.GB3717385@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42e20ddc-28e0-47ad-d6ec-08d8612be54c
x-ms-traffictypediagnostic: CY4PR11MB1973:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1973998991FD854E4B48430D80360@CY4PR11MB1973.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OK4IQZjNhGDclyI+XO7QKx+YPktcS2UuFgXt6RvNuDUhAybaVdCzkoQ/gjyRU4vNlYkBfpN2skxzxyCUVz4uguZjf0JiU+HnFchH0q6xrSZdrW7mx9IJGBgOAmRuq31YNCxmYelNm5O4cULO6UDRH4v16aAP09qDbsylRXyTrZWOjxR4kyIPXt2CU5GBPq4ZBn9j9eNwsa6rIGmZjc2V1LpLapJyIss10wSfehYqA5xuvuJh+hsEzZK/gz7AX3Bbbnr6vPuxgSVrslo7k25RBmu2v2qtEIai7fXxYvJKAPsR3FfwudFfNbt/u+X3TjKNPUb45+Ki97iZB/7Apt8v0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1447.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(7696005)(6916009)(52536014)(54906003)(186003)(4326008)(6506007)(26005)(5660300002)(316002)(478600001)(76116006)(66946007)(9686003)(71200400001)(55016002)(8936002)(8676002)(83380400001)(86362001)(2906002)(66556008)(66476007)(66446008)(64756008)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: sqi+97BtOFiL0dxmTyiusE59oisqXT9H6BM5azkaOtwAv5Pxp+0qDZl1NNwqbexG2chtmjkv2Sj5StAsuHD4t6085g5HCIWk7Du3U0XF3h4n0JWNTsGGCGNzHPYdef5kBAUsyA1NcdOnyfvC6W0eNrNN2hk6BGsVIeKd89UHE3P6SGAbDX0nK+TpLTWfAP5EINeA1vaoNvFRbZ/t9e7HUtAeUqx+xUxbJQWgRcSWwb3hyBZFwWhWkirZsU8ociUo8Xo4k8Be41lAGUXYZY0q/cTxeHmUab7REBrlfsu1Ry8eOFdBCRmhTo6HZCOfk9VpEyBbugVIw2Nnc/LqW1eiA25DC9w73BjGnXCBJ4mr+5EhS4m6h431jWD6X6uQ5xj1qjBbZcGcPtUVLxDi0J5UMJcCAMTWvy7E2BCcRpVKFuhjSlnFnjxYnaocs4FO9RIbpkgNkxvEvLyZChonj/AmBm2jSd7ySITvFug5QeboiimpRyuCSPvUiQxZVd/4uSwP5ZBzgO5oEFH5gW3hbZ1KlH9XZkvOKe0c13mikuQyyKeWZktIB/UP+0nscCmnUZ8vk6piz0FcfQ6l7XM+rn6mP5tlv0rtIwXHaBR11M4MZLn/ciho0+pYGRryRcsjml7TFwDLE53OYiIdTALXhT/ffA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1447.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e20ddc-28e0-47ad-d6ec-08d8612be54c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 08:20:43.0311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7VCbEuuSayDpuIbQ7MDq0dYSJnSaJMAT0l4m5Qr9UIZ5F8/9rgd8D+xsRaCp0nBeOw2bO7Sb7PmzXO28VeOupw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1973
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=luwei.kang@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 04:20:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: "Strong, Beeman" <beeman.strong@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Robert Hoo <robert.hu@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+ID4gPiA+ID4gSGkgRWR1YXJkbywNCj4gPiA+ID4gPiA+ICAgICBUaGlzIHBhdGNoIHNldCB3
aWxsIHJlbW92ZSBzb21lIGxpbWl0YXRpb25zIG9mIEludGVsIFBUDQo+ID4gPiA+ID4gPiBDUFVJ
RA0KPiA+ID4gaW5mb3JtYXRpb24uDQo+ID4gPiA+ID4gPiAgICAgMS4gVGhlICJJUCBwYXlsb2Fk
cyIgZmVhdHVyZSB3aWxsIGRpc2FibGUgdGhlIEludGVsIFBUIGluDQo+ID4gPiA+ID4gPiBndWVz
dHMgYW5kIGl0IHdpbGwgYmUNCj4gPiA+ID4gPiBjb21pbmcgc29vbi4NCj4gPiA+ID4gPiA+ICAg
ICAyLiBUbyBtYWtlIHRoZSBsaXZlIG1pZ3JhdGlvbiBzYWZlLCB3ZSBzZXQgdGhlIEludGVsIFBU
DQo+ID4gPiA+ID4gPiBDUFVJRCBhcyBhIGNvbnN0YW50DQo+ID4gPiA+ID4gdmFsdWUoSWNlbGFr
ZSBzZXJ2ZXIgQ1BVSUQpLiBJdCB3aWxsIG1hc2sgb2ZmIHRoZSBuZXcgZmVhdHVyZSBvZiBJbnRl
bCBQVC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IElzbid0IHRoaXMgc2VyaWVzIGRvaW5nIHRoZSBv
cHBvc2l0ZSBvZiAyPyAgSXQgcmVwbGFjZXMgYWxsDQo+ID4gPiA+ID4gY29uc3RhbnQgQ1BVSUQg
dmFsdWVzIHdpdGgga3ZtX2FyY2hfZ2V0X3N1cHBvcnRlZF9jcHVpZCgpLA0KPiA+ID4gPiA+IG1h
a2luZyB0aGUgZmVhdHVyZSB1bmF2YWlsYWJsZSBpbiBtaWdyYXRpb24tc2FmZSBtb2RlLg0KPiA+
ID4gPg0KPiA+ID4gPiBZZXMsIFRoaXMgc2VyaWVzIHdpbGwgZXhwb3NlIGFsbCB0aGUgSFcgY2Fw
YWJpbGl0aWVzIHRvIEtWTSBndWVzdA0KPiA+ID4gPiBpZiB0aGUgSW50ZWwgUFQgaXMgc3VwcG9y
dGVkIGluIHRoZSBndWVzdC4NCj4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IERvZXMgaXQg
bWVhbiB0aGUgcGxhbiBpcyB0byBkcm9wIGludGVsLXB0IG1pZ3JhdGlvbiBzdXBwb3J0IGVudGly
ZWx5Pw0KPiA+ID4gPg0KPiA+ID4gPiBJIGRvbid0IHdhbnQgdG8gZHJvcCBpbnRlbC1wdCBsaXZl
IG1pZ3JhdGlvbiBmZWF0dXJlLiBBcyBkaXNjdXNzZWQNCj4gPiA+ID4gd2l0aCB5b3UgYmVmb3Jl
LCB0aGUgSW50ZWwgUFQgZmVhdHVyZSBpbmNsdWRlcyBzb21lIHN1Yi1mZWF0dXJlcw0KPiA+ID4g
PiBhbmQgbWF5IGJlIGRpZmZlcmVudCBvbiBlYWNoIEhXIHBsYXRmb3JtLiBFeHBvc2UgYWxsIHRo
ZQ0KPiA+ID4gPiBjYXBhYmlsaXRpZXMgdG8gdGhlIGd1ZXN0IGNhbid0IG1ha2UgbGl2ZSBtaWdy
YXRpb24gc2FmZS4gRG8geW91DQo+ID4gPiA+IGhhdmUgYW55IG5ldyBwcm9wb3NhbHM/DQo+ID4g
Pg0KPiA+ID4gVG8gc3VwcG9ydCBsaXZlIG1pZ3JhdGlvbiwgd2UgbmVlZCB0aGUgc2V0IG9mIGZl
YXR1cmVzIHNlZW4gYnkgdGhlDQo+ID4gPiBndWVzdCBiZSBkZXRlcm1pbmVkIG9ubHkgYnkgdGhl
IGlucHV0IGdpdmVuIHRvIFFFTVUsIG5vdCBob3N0DQo+ID4gPiBjYXBhYmlsaXRpZXMuICBJdCBj
YW4gYmUNCj4gPiA+IHZpYToNCj4gPiA+ICgxKSBleHBsaWNpdCAiLWNwdSAuLi4sK2ZlYXQsZmVh
dD0uLi4iIGZsYWdzOw0KPiA+ID4gKDIpIHRocm91Z2ggZGF0YSBpbiB0aGUgQ1BVIG1vZGVsIHRh
YmxlOyBvcg0KPiA+ID4gKDMpIGJ5IGhhcmRjb2RpbmcgdGhlIHNhbWUgdmFsdWUgZm9yIGFsbCBj
b25maWd1cmF0aW9ucy4NCj4gPiA+DQo+ID4gPiBUaGUgY3VycmVudCBzb2x1dGlvbiBpcyAoMyku
ICAoMikgaXMgcHJvYmFibHkgdGhlIGJlc3Qgc29sdXRpb24sDQo+ID4gPiB3aXRoIHRoZSBhc3N1
bXB0aW9uIHRoYXQgdGhlIGhvc3QgY2FuIGFsd2F5cyBlbXVsYXRlIGZlYXR1cmVzIGZyb20NCj4g
PiA+IGFuIG9sZGVyIENQVSBpbiBhIG5ld2VyIENQVS4gIElmIHRoZXJlIGFyZSBmZWF0dXJlcyB0
aGF0IGNhbid0IGJlDQo+ID4gPiBlbXVsYXRlZCBpZiBtaWdyYXRpbmcgdG8gYSBuZXdlciBDUFUs
IGEgbW9yZSBleHBsaWNpdCBjb25maWd1cmF0aW9uDQo+ID4gPiBtZWNoYW5pc20gKDEpIG1pZ2h0
IGJlIGJldHRlciwgYmVjYXVzZSBub3QgYmVpbmcgYWJsZSB0byBtaWdyYXRlIGEgVk0gdG8NCj4g
bmV3ZXIgaGFyZHdhcmUgaXMgaW5jb252ZW5pZW50Lg0KPiA+ID4NCj4gPiA+IE5vbmUgb2YgdGhv
c2UgYXBwcm9hY2hlcyBwcmV2ZW50IHVzIGZyb20gaW1wbGVtZW50aW5nIHBhc3N0aHJvdWdoDQo+
ID4gPiBtb2RlIGZvciAiLWNwdSBob3N0Ii4gIFdvdWxkbid0IHRoYXQgYmUgcHJlZmVycmVkIGlu
c3RlYWQgb2YNCj4gPiA+IHJlbW92aW5nIHN1cHBvcnQgZm9yIGxpdmUgbWlncmF0aW9uPw0KPiA+
DQo+ID4gVGhhbmtzIGZvciB0aGUgY29tbWVudHMgYW5kIHN1Z2dlc3Rpb25zLiBJIHRoaW5rIHRo
ZSBuZXdlciBDUFUNCj4gPiBpbmNsdWRlcyBhbGwgdGhlIGZlYXR1cmVzIG9mIHRoZSBvbGRlciBD
UFUsIGJ1dCBubyBkb2N1bWVudCBoYXZlIHN1Y2gNCj4gPiBzdGF0ZW1lbnQuIFRvIG1ha2Ugc3Vy
ZSBpdCBjYW4gd29yayBpbiBhbGwgdGhlIGNhc2VzLCB0aGUgc29sdXRpb24gKDEpDQo+ID4gbWln
aHQgYmUgYmV0dGVyLg0KPiANCj4gTWF5YmUgKDIpIGlzIHN0aWxsIHZpYWJsZSwgYXMgbG9uZyBh
cyB0aGVyZSBhcmUgbm8gZXhwZWN0YXRpb25zIHRoYXQgZmVhdHVyZXMgd2lsbA0KPiBiZSByZW1v
dmVkIGluIGZ1dHVyZSBoYXJkd2FyZS4gIENvbXBhdGliaWxpdHkgd2l0aCBmdXR1cmUgaGFyZHdh
cmUgaW4gKDIpIGlzDQo+IG1vcmUgYWJvdXQgY29udmVuaWVuY2UsIG5vdCBhIGhhcmQgYSByZXF1
aXJlbWVudC4NCj4gDQo+IEluIGVpdGhlciBjYXNlLCAoMSkgaXMgdGhlIGJ1aWxkaW5nIGJsb2Nr
IGZvciBtYWtpbmcgKDIpIHdvcmsuDQo+IFRoaXMgbWVhbnMgd2UgY2FuIHN0YXJ0IGJ5IGltcGxl
bWVudGluZyAoMSksIGFuZCBzZWUgaWYgd2UgY2FuIGluY2x1ZGUNCj4gZmVhdHVyZXMgaW4gbmV3
IENQVSBtb2RlbHMgbGF0ZXIuDQoNCk9LLCBJIHdpbGwgYWRkIHRoZSBuZXcgc3ViLWZlYXR1cmUg
b2YgSW50ZWwgUFQgYmFzZSBvbiB0aGUgc29sdXRpb24gKDEpLg0KDQpSZWdhcmRpbmcgdGhlIGxp
bWl0YXRpb24gb2YgSVAgcGF5bG9hZCwgbWF5IEkgcmVtb3ZlIHRoaXMgbGltaXRhdGlvbiBkaXJl
Y3RseSBiZWNhdXNlIExJUCA9PSBSSVAgZm9yIG1vc3QvYWxsIHJlYWwgY29kZSwgYW5kIGl0IHdp
bGwgYmUgc2V0IGFmdGVyIElDWCBDUFVzLg0KW1BBVENIIHYxIDEvM10gaTM4NjogUmVtb3ZlIHRo
ZSBsaW1pdGF0aW9uIG9mIElQIHBheWxvYWRzIGZvciBJbnRlbCBQVA0KDQpUaGFua3MsDQpMdXdl
aSBLYW5nDQoNCj4gDQo+ID4gVGhlIEludGVsIFBUIHZpcnR1YWxpemF0aW9uIGZpcnN0IHN1cHBv
cnRlZCBvbiBJY2VsYWtlIGFuZCB3ZSBjYW4gdXNlDQo+ID4gdGhpcyBDUFVJRCBhcyBiYXNpYyBD
UFVJRCBpbmZvcm1hdGlvbi4gQW55IG5ldyBmZWF0dXJlIHdoaWNoIHN1cHBvcnRzDQo+ID4gb24g
dGhlIG5ld2VyIENQVXMgY2FuIGJlIGFkZGVkIGJ5ICItY3B1IC4uLiwrZmVhdCxmZWF0PS4uLiIu
IFdoYXQgaXMNCj4gPiB5b3VyIG9waW5pb24/DQo+IA0KPiBTb3VuZHMgZ29vZCB0byBtZS4gIEkg
d291bGQgYWxzbyBtYWtlIGludGVsLXB0IHBhc3N0aHJvdWdoIHdvcmsgaWYgdXNpbmcgIi1jcHUN
Cj4gaG9zdCIgYW5kL29yIGFuIGV4cGxpY2l0ICJpbnRlbC1wdC1wYXNzdGhyb3VnaD1vbiINCj4g
b3B0aW9uLg0KPiANCj4gLS0NCj4gRWR1YXJkbw0KDQo=

