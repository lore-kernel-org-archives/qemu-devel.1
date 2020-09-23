Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8910DC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 02:54:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A453C206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 02:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="PSV9Hxif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A453C206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKuvP-00026U-AE
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 22:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kKuuF-0001MJ-8q
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 22:53:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:1729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kKuuA-0001B3-Rd
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 22:53:18 -0400
IronPort-SDR: ICxOWT3iStxcW+f5hbnR/uRhF2QBNzNaPp5F24cbxZL1RE3DXd0G4Pz4splKFO4U/iwfaGy4Jv
 ayOTWi26JoDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="148425646"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="148425646"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 19:53:07 -0700
IronPort-SDR: 2m9Y/vINp5OTzXrbyKz5dUoGfwyrSgjj5vwCwsaSfTCFGx0DDKmwGOyNoY81aCI4eY8HwGIWTw
 gIkyKHDsUc5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="342273124"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2020 19:53:02 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 19:52:54 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 19:52:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Sep 2020 19:52:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 22 Sep 2020 19:52:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBi5W1bM/5K8T7gX+Z5CgcSSlEBgilbLKj7xkIr2q6K5MKk8UdwwfM9LHuPv7mt3ZzTsNcuLELxjGYwnQyU4zprCT97/N9+xlJXf2QbhibURtYFmGQoHE6QsoUBGctmx3uazBTtg0EvJJePXLhRV3/bKob1wIRTq9sJvGgKxe4qTNJi/kkt4HxIGmh8lRIodpq35xlIQQZxzBHfKRetYojt8V/pefpcA2ugr/XmG7hNKmOD7f7SMem5+MHfDa5tupsLcIpa0TUJ8KYk6dgyYF3UvN02QdKiOXyGjVvyGH9adI5ICKGoDjp9ZsuH2+smGZDDBbOKi6DkzdH/6nSNqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rk1dDbw4l22G/T42tm9e8AfkbJAMswRKE1UDCyLwLUY=;
 b=ZkaXQldspQhxudPKArtDUAPFn6Lt/RBOzZ3DBWx7wmocckXBar4bqEI1DVn1/3+gYnDbIMxVNaF7TWxf0+v/iLgBL2vaWF7qKzofEPVjEAyoBvXOpbkI1E1A7lurPCgWYtUtthAf6Z3fbQmfqfzv6e4gZP1Te3qN9z7AjR2Olx/V6SGTJfAFboD/xGSrANHCZdrCPWNSF19zRibcnrIo1gIRjVFFZ38YaCBn0jh2Y0AYT/1JwgilGtndOl73WNIyf0NiOQ2x2GZ7xyFC50Eo7jXUUSRBU0vY9Y6qVeAejv05Lm9/slXoPBLo/AxeQWdOI/Z+5MKBh2gURGI/aScZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rk1dDbw4l22G/T42tm9e8AfkbJAMswRKE1UDCyLwLUY=;
 b=PSV9HxifxKwFnd+Q/xEJju34LSZPokZn0kAnK4TA+vLPSooP6vFGGk4Eh/IW/qfzU+RiQ+tx3ZRc2rb3LiOKm0byEuhDqKo55A+1QrTYWenrhmbaOylkoWiss4oX4l56aC2rwE/KNvjiYi2o5lLheoSXKlVAVMPSsbXjCLMZAhk=
Received: from CY4PR11MB1447.namprd11.prod.outlook.com (2603:10b6:910:10::16)
 by CY4PR11MB1270.namprd11.prod.outlook.com (2603:10b6:903:2c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 02:52:50 +0000
Received: from CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::c9f:501b:232d:893a]) by CY4PR11MB1447.namprd11.prod.outlook.com
 ([fe80::c9f:501b:232d:893a%5]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 02:52:50 +0000
From: "Kang, Luwei" <luwei.kang@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: RE: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Thread-Topic: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Thread-Index: AQHV6xfqjs/57yfCb0eiFZpFzYKOh6hhHEKQgQ8ceoCAA8SvIIAAmwMAgAIsh2A=
Date: Wed, 23 Sep 2020 02:52:50 +0000
Message-ID: <CY4PR11MB144737577341CF0A5E8BAD1C80380@CY4PR11MB1447.namprd11.prod.outlook.com>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
 <82D7661F83C1A047AF7DC287873BF1E1738B07FF@SHSMSX104.ccr.corp.intel.com>
 <20200918220255.GB57321@habkost.net>
 <CY4PR11MB14473A594C244A5B403ADC26803A0@CY4PR11MB1447.namprd11.prod.outlook.com>
 <20200921165028.GP57321@habkost.net>
In-Reply-To: <20200921165028.GP57321@habkost.net>
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
x-ms-office365-filtering-correlation-id: af38d151-6030-4cd9-0fab-08d85f6bc27e
x-ms-traffictypediagnostic: CY4PR11MB1270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB12705EE682FDEF00AA11B8F280380@CY4PR11MB1270.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IAAYPI7/OlZYYfM5Xiid0WCiNSbiuGXwKtCoD+y4hYc/E0MtyAXQ6Olh9s4TaUYraK+2OnKkeP0bgtFr+HNvaJz3jqw9GZIEADIxc1Ihys4nzLF9SYw7Z1qomPM2Aayak2W3p8EpTUCdwy2+6g4wy71SgkGFais6QeTVCnndBIhjMGmxXBzK888UHnp0/23RV03I8C/LkT7Y7aqXEaY1vLPuDJDmeodRgLymz8f2nJ6THvDMcWhtS3ANtFK4qPQ6GIWtv+hYl8B0MWW5Ysa04q7FcdLaJ6iae/77EwXXROMNsb4GoiRVNyWZ3HVzMy4NQkRf7dj1aNcj4j7M0l4LBrp0HKHu4F6Z5JPoQJaGBI35Z0jWYe8sOYL9sstM3RWqjirmdn/dJKlTdhZo/zwkCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1447.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(186003)(52536014)(33656002)(8676002)(8936002)(2906002)(55016002)(9686003)(4326008)(66556008)(316002)(66476007)(71200400001)(76116006)(66946007)(66446008)(64756008)(53546011)(6506007)(26005)(7696005)(86362001)(83380400001)(5660300002)(6916009)(54906003)(966005)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ptXS0hjHCYYZZnSSAbmA7U4KtXtKtzYf0xP66+N8ZN2F5cYSTSEw7Hz8t2iwSls4fZnWMlLA2LAnLsJF91Or5DFjU//fhnuZHnRw7NMsvRbzG7Rx5xIB3OkXlEY9+tCYJiJcUFG6m1WdHThnwTRYJ9Ueh6h2n9+FRGbZmMfSdF/EdmKyaDpbnt81vQubQkASnlPNeIl59WPR2orH/qGXPye3yq9dfOqx0Azz8JUfOLt4PPQimJCa+rYskt5qFbQDgNY75C1H5Lhn7irsoUvehZp9QUgLiCOKbh4IPGFNt8mDRW0/vmSzBqZm+/fwZASXOXNtOXRvrObL6l0NYbBc3WPnarkx+cyVjLlscG2NLxul+qOoLPpNfT9RoXYg+ezfyUgjH/gEQSy8SlQvsLbxl+zq2qAVWGukT0OGOf+6K0heC/XL3arWbW3HaEvB/R7/Hup5dw2IC+ZY45dnMp5pW5+Cu93s9k6Rq4fvR3H7blLrqiTpJG1AjN8qpDvczMwea5qXLZb0UD8asVxkKX3uUrdM5/u4g26TVR1Pv3qkRcKMswhxpEte2MJoe333matVNc1vifKfAsg3OqDBhenvAXO3yIOmGUuiWk8HgiZit5ivk13v+3Ao1A3itvItfMUV6EVAmWMp9kdeO7staXS+bQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1447.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af38d151-6030-4cd9-0fab-08d85f6bc27e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 02:52:50.0416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GK8BkmgVW5FkpQS95yPu2JgRzc7mbM2ROizJhUMU0Hwe0nr2t9Lxy0PT2mwfkCGt//8NcM3347uQNSGFriABIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1270
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=luwei.kang@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 22:53:08
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
Cc: "Strong, Beeman" <beeman.strong@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Robert Hoo <robert.hu@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+IEhpIEVkdWFyZG8sDQo+ID4gICAgIFRoaXMgcGF0Y2ggc2V0IHdpbGwgcmVtb3ZlIHNvbWUg
bGltaXRhdGlvbnMgb2YgSW50ZWwgUFQgQ1BVSUQgaW5mb3JtYXRpb24uDQo+ID4gICAgIDEuIFRo
ZSAiSVAgcGF5bG9hZHMiIGZlYXR1cmUgd2lsbCBkaXNhYmxlIHRoZSBJbnRlbCBQVCBpbiBndWVz
dHMgYW5kIGl0IHdpbGwgYmUNCj4gY29taW5nIHNvb24uDQo+ID4gICAgIDIuIFRvIG1ha2UgdGhl
IGxpdmUgbWlncmF0aW9uIHNhZmUsIHdlIHNldCB0aGUgSW50ZWwgUFQgQ1BVSUQgYXMgYSBjb25z
dGFudA0KPiB2YWx1ZShJY2VsYWtlIHNlcnZlciBDUFVJRCkuIEl0IHdpbGwgbWFzayBvZmYgdGhl
IG5ldyBmZWF0dXJlIG9mIEludGVsIFBULg0KPiANCj4gSXNuJ3QgdGhpcyBzZXJpZXMgZG9pbmcg
dGhlIG9wcG9zaXRlIG9mIDI/ICBJdCByZXBsYWNlcyBhbGwgY29uc3RhbnQgQ1BVSUQgdmFsdWVz
DQo+IHdpdGgga3ZtX2FyY2hfZ2V0X3N1cHBvcnRlZF9jcHVpZCgpLCBtYWtpbmcgdGhlIGZlYXR1
cmUgdW5hdmFpbGFibGUgaW4NCj4gbWlncmF0aW9uLXNhZmUgbW9kZS4NCg0KWWVzLCBUaGlzIHNl
cmllcyB3aWxsIGV4cG9zZSBhbGwgdGhlIEhXIGNhcGFiaWxpdGllcyB0byBLVk0gZ3Vlc3QgaWYg
dGhlIEludGVsIFBUIGlzIHN1cHBvcnRlZCBpbiB0aGUgZ3Vlc3QuDQoNCj4gDQo+IERvZXMgaXQg
bWVhbiB0aGUgcGxhbiBpcyB0byBkcm9wIGludGVsLXB0IG1pZ3JhdGlvbiBzdXBwb3J0IGVudGly
ZWx5Pw0KDQpJIGRvbid0IHdhbnQgdG8gZHJvcCBpbnRlbC1wdCBsaXZlIG1pZ3JhdGlvbiBmZWF0
dXJlLiBBcyBkaXNjdXNzZWQgd2l0aCB5b3UgYmVmb3JlLCB0aGUgSW50ZWwgUFQgZmVhdHVyZSBp
bmNsdWRlcyBzb21lIHN1Yi1mZWF0dXJlcyBhbmQgbWF5IGJlIGRpZmZlcmVudCBvbiBlYWNoIEhX
IHBsYXRmb3JtLiBFeHBvc2UgYWxsIHRoZSBjYXBhYmlsaXRpZXMgdG8gdGhlIGd1ZXN0IGNhbid0
IG1ha2UgbGl2ZSBtaWdyYXRpb24gc2FmZS4gRG8geW91IGhhdmUgYW55IG5ldyBwcm9wb3NhbHM/
DQoNClRoYW5rcywNCkx1d2VpIEthbmcNCg0KPiANCj4gPg0KPiA+ICAgICBBYm91dCB0aGlzIGlz
c3VlIGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTg1Mzk3MiwN
Cj4gSW50ZWwgUFQgaXMgZGlzYWJsZWQgaW4gdGhlIGd1ZXN0IGJ5IGRlZmF1bHQsIHdlIHNob3Vs
ZCB1c2UgIi1jcHUgSWNlbGFrZS0NCj4gU2VydmVyLCtpbnRlbC1wdCIgdG8gZW5hYmxlIHRoZSBJ
bnRlbCBQVC4NCj4gDQo+IFRoYXQncyBjb3JyZWN0LiAgVGhlIHBvaW50IG9mIHRoZSBCWiBpcyB0
aGF0IGxpYnZpcnQgbW9kZT1ob3N0LW1vZGVsIHdhcw0KPiBleHBlY3RlZCB0byBpbmNsdWRlIGlu
dGVsLXB0IGF1dG9tYXRpY2FsbHkgd2hlbiBhdmFpbGFibGUuICBXaXRoIHRoaXMgc2VyaWVzLCB0
aGUNCj4gcmVxdWVzdCBpbiB0aGUgQlogc3RvcHMgbWFraW5nIHNlbnNlIChiZWNhdXNlIGludGVs
LXB0IHdvbid0IGJlIG1pZ3JhdGlvbi1zYWZlDQo+IGFueW1vcmUpLCBidXQgSSdtIG5vdCBzdXJl
IHlldCB0aGF0J3MgcmVhbGx5IHRoZSBwbGFuLg0KPiANCj4gDQo+ID4NCj4gPiBUaGFua3MsDQo+
ID4gTHV3ZWkgS2FuZw0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
ID4gRnJvbTogRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPg0KPiA+ID4gU2Vu
dDogU2F0dXJkYXksIFNlcHRlbWJlciAxOSwgMjAyMCA2OjAzIEFNDQo+ID4gPiBUbzogS2FuZywg
THV3ZWkgPGx1d2VpLmthbmdAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IHBib256aW5pQHJlZGhhdC5j
b207IHJ0aEB0d2lkZGxlLm5ldDsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiA+ID4gU3Ryb25n
LCBCZWVtYW4gPGJlZW1hbi5zdHJvbmdAaW50ZWwuY29tPjsgSmlyaSBEZW5lbWFyaw0KPiA+ID4g
PGpkZW5lbWFyQHJlZGhhdC5jb20+OyBSb2JlcnQgSG9vIDxyb2JlcnQuaHVAbGludXguaW50ZWwu
Y29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwLzNdIFJlbW92ZSB0aGUgbGltaXRh
dGlvbiBvZiBJbnRlbCBQVCBDUFVJRA0KPiA+ID4gaW5mbw0KPiA+ID4NCj4gPiA+IEhpIEx1d2Vp
IEthbmcsDQo+ID4gPg0KPiA+ID4gSSB3YXMgbG9va2luZyBmb3IgaW5mbyBvbiBpbnRlbC1wdCBh
bmQganVzdCBzYXcgdGhpcyBzZXJpZXMsIGFuZCBpdA0KPiA+ID4gd2FzIG5ldmVyIHJldmlld2Vk
IG9yIG1lcmdlZCAoc29ycnkgZm9yIG1pc3NpbmcgaXQhKS4gIElzIHRoaXMgc3RpbGwNCj4gPiA+
IHRoZSBhcHByb2FjaCB3ZSB3YW50IHRvIGZvbGxvdyBmb3IgaW50ZWwtcHQ/DQo+ID4gPg0KPiA+
ID4gSSdtIENDaW5nIEppcmkgRGVuZW1hcmsgYmVjYXVzZSB0aGlzIG1pZ2h0IGJlIHJlbGV2YW50
IGZvciBhIGxpYnZpcnQNCj4gPiA+IGlzc3VlIHJlbGF0ZWQgdG8gaW50ZWwtcHQgd2Ugd2VyZSBp
bnZlc3RpZ2F0aW5nWzFdLg0KPiA+ID4NCj4gPiA+IFsxXSBodHRwczovL2J1Z3ppbGxhLnJlZGhh
dC5jb20vc2hvd19idWcuY2dpP2lkPTE4NTM5NzINCj4gPiA+DQo+ID4gPg0KPiA+ID4gT24gTW9u
LCBNYXIgMzAsIDIwMjAgYXQgMDk6NTY6MDlBTSArMDAwMCwgS2FuZywgTHV3ZWkgd3JvdGU6DQo+
ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBLYW5n
LCBMdXdlaSA8bHV3ZWkua2FuZ0BpbnRlbC5jb20+DQo+ID4gPiA+ID4gU2VudDogVHVlc2RheSwg
RmVicnVhcnkgMjUsIDIwMjAgNTozOCBBTQ0KPiA+ID4gPiA+IFRvOiBwYm9uemluaUByZWRoYXQu
Y29tOyBydGhAdHdpZGRsZS5uZXQ7IGVoYWJrb3N0QHJlZGhhdC5jb20NCj4gPiA+ID4gPiBDYzog
cWVtdS1kZXZlbEBub25nbnUub3JnOyBTdHJvbmcsIEJlZW1hbg0KPiA+ID4gPGJlZW1hbi5zdHJv
bmdAaW50ZWwuY29tPjsNCj4gPiA+ID4gPiBLYW5nLCBMdXdlaSA8bHV3ZWkua2FuZ0BpbnRlbC5j
b20+DQo+ID4gPiA+ID4gU3ViamVjdDogW1BBVENIIHYxIDAvM10gUmVtb3ZlIHRoZSBsaW1pdGF0
aW9uIG9mIEludGVsIFBUIENQVUlEDQo+ID4gPiA+ID4gaW5mbw0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gVGhlIEludGVsIFBUIGZlYXR1cmUgaW5jbHVkZXMgc29tZQ0KPiA+ID4gPiA+IHN1Yi1mZWF0
dXJlcyhDUFVJRC4oRUFYPTE0SCxFQ1g9MEgpKQ0KPiA+ID4gPiA+IGFuZCB0aGVzZSBzdWItZmVh
dHVyZXMgYXJlIGRpZmZlcmVudCBvbiBkaWZmZXJlbnQgSFcgcGxhdGZvcm1zLg0KPiA+ID4gPiA+
IFRvIG1ha2UgdGhlIGxpdmUgbWlncmF0aW9uIHNhZmV0eShnZXQgdGhlIHNhbWUgQ1BVSUQgaW5m
byB3aXRoDQo+ID4gPiA+ID4gc2FtZSBjcHUgbW9kZWwgb24gZGlmZmVyZW50IEhXIHBsYXRmb3Jt
KSwgdGhlIGN1cnJlbnQgSW50ZWwgUFQNCj4gPiA+ID4gPiBDUFVJRCBpbmZvcm1hdGlvbiBpcyBz
ZXQgdG8gYSBjb25zdGFudCB2YWx1ZShmcm9tIElDRUxBS0UgU2VydmVyKS4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IEl0IHdpbGwgYmxvY2sgdGhlIG5ldyBmZWF0dXJlIGluIHRoZSBsYXRlciBIVyBw
bGF0Zm9ybS4gd2hhdCdzDQo+ID4gPiA+ID4gbW9yZSwgdGhlIHN1cHBvcnQgb2YgIklQIHBheWxv
YWRzIiB3aWxsIGRpc2FibGUgdGhlIEludGVsIFBUIGluDQo+ID4gPiA+ID4gS1ZNIGd1ZXN0KHBh
dGNoIDEpIGJ1dCBpdCB3aWxsIGNvbWUgc29vbi4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoaXMg
cGF0Y2hzZXQgcmVtb3ZlIHRoaXMgbGltaXRhdGlvbiBhbmQgZXhwb3NlIGFsbCB0aGUNCj4gPiA+
ID4gPiBjYXBhYmlsaXRpZXMgdG8gS1ZNIGd1ZXN0LiBBcyBpdCB3aWxsIGJyZWFrIHRoZSBsaXZl
IG1pZ3JhdGlvbg0KPiA+ID4gPiA+IHNhZmUsIEludGVsIFBUIHdpbGwgYmUgbWFza2VkIGFzIHVu
bWlncmF0YWJsZS4NCj4gPiA+ID4NCj4gPiA+ID4gUGluZy4NCj4gPiA+ID4NCj4gPiA+ID4gVGhh
bmtzLA0KPiA+ID4gPiBMdXdlaSBLYW5nDQo+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBM
dXdlaSBLYW5nICgzKToNCj4gPiA+ID4gPiAgIGkzODY6IFJlbW92ZSB0aGUgbGltaXRhdGlvbiBv
ZiBJUCBwYXlsb2FkcyBmb3IgSW50ZWwgUFQNCj4gPiA+ID4gPiAgIGkzODY6IFJlbW92ZSB0aGUg
Q1BVSUQgbGltaXRhdGlvbiBvZiBJbnRlbCBQVA0KPiA+ID4gPiA+ICAgaTM4NjogTWFyayB0aGUg
J0lOVEVMX1BUJyBDUFVJRCBiaXQgYXMgdW5taWdyYXRhYmxlDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiAgdGFyZ2V0L2kzODYvY3B1LmMgfCA2OQ0KPiA+ID4gPiA+ICsrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNjQgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiAtLQ0KPiA+ID4gPiA+IDEuOC4zLjENCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiAtLQ0KPiA+
ID4gRWR1YXJkbw0KPiA+DQo+IA0KPiAtLQ0KPiBFZHVhcmRvDQoNCg==

