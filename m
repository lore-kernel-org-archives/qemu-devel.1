Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DF9C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA7321973
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="j8JP8LfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA7321973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvMIw-0006YU-Ps
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jvMIA-0005qR-Cf
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:52:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:45350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jvMI6-0004WH-Rr
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:52:21 -0400
IronPort-SDR: A3VKtY0+q154u7875eVgBlxyk1qpo/WqovjsYrFLRc3m9uYZynJ0GAd8UG0tQyEq+k+9vTORWW
 haQCfg9mVF9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="233781057"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="233781057"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 07:52:12 -0700
IronPort-SDR: tg9izV92drl+TbeCiKuXM2z/DUfJSgxGtbL2wmWXv3+qWQVgvqZg6uNELotjcUq6fYLryzftH/
 4Q8YLVgjdCYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="360405625"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga001.jf.intel.com with ESMTP; 14 Jul 2020 07:52:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jul 2020 07:52:11 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jul 2020 07:52:11 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jul 2020 07:52:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 14 Jul 2020 07:52:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4ZVk50SDgglbDJpYzrdDBfUD2ZewuBx4DGzsOQqDqWoolvnkZbQwrO82WbpCfUwiOJS1XWjXwmzJgWA8lVp48QVv5mo1SSZfn0qYa7PSlf+XizlLePDrhRu/bbxlmSvgi9PwhuZON3/q8cDJai75mvx6cUmuE998FM13czmzxjojAOkZuMkpg+A6LKuVuEADjSOHMkWnyT1yWXFnKMx5a5FRRHnlx32rhnFpALu7HsOM+Nq3lCpaXOwxm2+dLO6ULk+4oq7cuYSMX22A4mqf0CXkw1wjWh9mc05ltDkGHsUpu1muTVcJKnHwaEHOe8MQJhOo7gw05GALPIWaPQ9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnosJeLj5aU9/hUhwiDL8XJ30uXj8FQUpBgrs3R+5wQ=;
 b=nbJ3uP8Hz7fYwLcEF3L6Wfc0q0JV5h45Paz5524X/lCIp33fff4sQILJZ5pm4RYLl/U2vHKpsqlqYx5vhfqx3MlG/qHq+L7TU9CMbnyrbzIZ9eBXJ4k1SaXn9J4Mt54MWUBLTGIcYx5fzujl9SWaqAqCOwDFesx7o59/WtjBmyGF7OzVP4zTOeTkikRT9nLlV2u8AYlseU4AFSU1oQ/KMWaATpg8zMxq264LagGW6rDk/YskCUWnK5UyZr78wOOf2laErAByoK9OXZ9rgnswzqEdN9XCkYfOwtEcvPkuZrXs0T2jOfhNSnDxQ3wPLHGc9R1REh9AB8SOQtSKJT0ExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnosJeLj5aU9/hUhwiDL8XJ30uXj8FQUpBgrs3R+5wQ=;
 b=j8JP8LfKtbsfpMm2f6f6cG1TPC30Ph9rRazQmuEw4Zx/fCOUmehsyrpBrhFYgnWf1QXVG4ynScyu6qpjPyOYqoUpjuxRIvcdI4ljpswdvJZy3JgE/ssjd5eYWGW8iGpBrKS45UO3aHbEIRr16XgcOUlvqLN5pehw83Kd3ZgnJAo=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Tue, 14 Jul
 2020 14:52:09 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74%6]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 14:52:09 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>
Subject: RE: [PULL 00/25] target-arm queue
Thread-Topic: [PULL 00/25] target-arm queue
Thread-Index: AQHWWSBWNvQP9t/ySEy6/+GGol7RpakFqseAgAF+ZkA=
Date: Tue, 14 Jul 2020 14:52:09 +0000
Message-ID: <DM5PR11MB183361CB8C55AA9E1057402D8D610@DM5PR11MB1833.namprd11.prod.outlook.com>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
 <CAFEAcA-ULj8BGkm6k2f9ye-ovg9FCKrHg6BRMuKf+F7O3sJtFQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-ULj8BGkm6k2f9ye-ovg9FCKrHg6BRMuKf+F7O3sJtFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d020f45-434f-46f2-fc51-08d828057c09
x-ms-traffictypediagnostic: DM6PR11MB4610:
x-microsoft-antispam-prvs: <DM6PR11MB46104CC4A8A71E3B60D617EC8D610@DM6PR11MB4610.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Go17diAdKn3J1nSMyNIxi1Hoz7fN5HAQulR2fC4xwKRGASicVEXUIIXFhELtCzFxnDbz6mzwhoFH+O2LiPvwIYLP2h7eoNGePwfbnbVSznPcodSlBglPzesrvdWKK6KzWJdYX6mw98tUMNCOKSNzo/ZbZmmVv3bw4Mzqw1jzGWxqgunYQOB0TaHv5Bpg00zIAAuHPbBNve0ZlL/cQkjKl359fsKdhcxU3LHooLPqhvcKlYIG8BXEiPiyOv7GC1T6dmQ2IycUzw1R4UCxUDcqRpC5AZQ7krkT/qAQBdi8S7jaUpeklJPatMVLwl/rtcEfNeSoeadcWMN8phMgT79f/qpqP8bNrLnRZnjvfTFtimO3JIu6OC1v0TC765hxRPaBmKGbveMhCgkmuzRlc+sxCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(66476007)(7696005)(186003)(66556008)(966005)(71200400001)(66946007)(83380400001)(316002)(8676002)(9686003)(66446008)(64756008)(76116006)(6506007)(5660300002)(53546011)(110136005)(55016002)(478600001)(26005)(2906002)(33656002)(8936002)(19627235002)(52536014)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: rvhZqmu26rfYff+sujlXNWGT9xW6YB2OzpBcJc3acvAUk0zpd9jw+r3ShOGYfNtyszSE0sRyoPC8HITR9NKd/NOvAG9BO5dzWldlMtywo9thJqpCrT+9TnLp3nom7NpLQD7mSogphKJDixGJhidzjT2JaSZQjtDe+j/a/vA6uKNshvwL/DO4+j3/Og3aYVVRiEU0rY19y/fgtK+eBVJaHKpatgQC7RTk4oN2i9o0KRequeXt08S4NkQ2BWba+KQy7RIcZMQVN8ToBOK7dTxto115GqEOVgp2ERYoHz79REl9UG0V4r7xKwf4tk0F2FCb19BrrOene5dCEi2kX/ruHB50O5xYc5cnPvUNFTP+BTXdTGO8s5NZiKOET1Vy4dEQcd3ZHmLR8qTDGn9WOuD7Q9/rAS1pLMeUZKW1Vo9+fp42se5xluVOyzihtRCtKURwmbk+l+zt9HcUuMZEoIsADcobamNsa2qZEEd+/SuMCsqoCfHYbR0X7myF/hFDbhmi
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1833.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d020f45-434f-46f2-fc51-08d828057c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 14:52:09.2882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVErl4d3sT/30dr0/ZwzBiv+TWt+pLM0Nv0+EbODIm0IWtmJTfX7A3jGZD9EOh+9fdyzK3oxtCzGoZI7TttyAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4610
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43; envelope-from=wentong.wu@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 10:52:12
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUWVtdS1kZXZlbCA8cWVt
dS1kZXZlbC1ib3VuY2VzK3dlbnRvbmcud3U9aW50ZWwuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFs
ZiBPZiBQZXRlciBNYXlkZWxsDQo+IFNlbnQ6IE1vbmRheSwgSnVseSAxMywgMjAyMCAxMTo1OSBQ
TQ0KPiBUbzogUUVNVSBEZXZlbG9wZXJzIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IFN1Ympl
Y3Q6IFJlOiBbUFVMTCAwMC8yNV0gdGFyZ2V0LWFybSBxdWV1ZQ0KPiANCj4gT24gTW9uLCAxMyBK
dWwgMjAyMCBhdCAxNToxMSwgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3Jn
PiB3cm90ZToNCj4gPg0KPiA+IExhc3QgbG90IG9mIHRhcmdldC1hcm0gY2hhbmdlcyB0byBzcXVl
ZXplIGluIGJlZm9yZSByYzE6DQo+ID4gICogdmFyaW91cyBtaW5vciBBcm0gYnVnIGZpeGVzDQo+
ID4gICogRGF2aWQgQ2FybGllcidzIEhhaWt1IGJ1aWxkIHBvcnRhYmlsaXR5IGZpeGVzDQo+ID4g
ICogV2VudG9uZyBXdSdzIGZpeGVzIGZvciBpY291bnQgaGFuZGxpbmcgaW4gdGhlIG5pb3MyIHRh
cmdldA0KPiA+DQo+ID4gVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAwMGNlNmMz
NmIzNWUwZWI4Y2M1ZDY4YTI4ZjI4OGE2MzM1ODQ4ODEzOg0KPiA+DQo+ID4gICBNZXJnZSByZW1v
dGUtdHJhY2tpbmcgYnJhbmNoICdyZW1vdGVzL2h1dGgtZ2l0bGFiL3RhZ3MvcHVsbC1yZXF1ZXN0
LTIwMjAtMDctMTMnIGludG8gc3RhZ2luZyAoMjAyMC0wNy0xMyAxMzowMTozMCArMDEwMCkNCj4g
Pg0KPiA+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KPiA+DQo+ID4g
ICBodHRwczovL2dpdC5saW5hcm8ub3JnL3Blb3BsZS9wbWF5ZGVsbC9xZW11LWFybS5naXQgdGFn
cy9wdWxsLXRhcmdldC1hcm0tMjAyMDA3MTMNCj4gPg0KPiA+IGZvciB5b3UgdG8gZmV0Y2ggY2hh
bmdlcyB1cCB0byA3NTZmNzM5YjE2ODJiZjEzMTk5NGVjOTZkYWQ3ZmJkZjhiNTQ0OTNhOg0KPiA+
DQo+ID4gICBody9hcm0vYXNwZWVkOiBEbyBub3QgY3JlYXRlIGFuZCBhdHRhY2ggZW1wdHkgU0Qg
Y2FyZHMgYnkgZGVmYXVsdCAoMjAyMC0wNy0xMyAxNDozNjoxMiArMDEwMCkNCj4gPg0KPiA+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gPiB0YXJnZXQtYXJtIHF1ZXVlOg0KPiA+ICAqIGh3L2FybS9iY20yODM2OiBSZW1v
dmUgdW51c2VkICdjcHVfdHlwZScgZmllbGQNCj4gPiAgKiB0YXJnZXQvYXJtOiBGaXggbXRlZGVz
YyBmb3IgZG9fbWVtX3pweg0KPiA+ICAqIEFkZCB0aGUgYWJpbGl0eSB0byBjaGFuZ2UgdGhlIEZF
QyBQSFkgTURJTyBkZXZpY2UgbnVtYmVyIG9uIGkuTVgyNS9pLk1YNi9pLk1YNw0KPiA+ICAqIHRh
cmdldC9hcm06IERvbid0IGRvIHJhdyB3cml0ZXMgZm9yIFBNSU5URU5DTFINCj4gPiAgKiB2aXJ0
aW8taW9tbXU6IEZpeCBjb3Zlcml0eSBpc3N1ZSBpbiB2aXJ0aW9faW9tbXVfaGFuZGxlX2NvbW1h
bmQoKQ0KPiA+ICAqIGJ1aWxkOiBGaXggdmFyaW91cyBpc3N1ZXMgd2l0aCBidWlsZGluZyBvbiBI
YWlrdQ0KPiA+ICAqIHRhcmdldC9uaW9zMjogZml4IHdyY3RsIGJlaGF2aW91ciB3aGVuIHVzaW5n
IGljb3VudA0KPiA+ICAqIGh3L2FybS90b3NhOiBFbmNhcHN1bGF0ZSBtaXNjIEdQSU8gaGFuZGxp
bmcgaW4gYSBkZXZpY2UNCj4gPiAgKiBody9hcm0vcGFsbS5jOiBFbmNhcHN1bGF0ZSBtaXNjIEdQ
SU8gaGFuZGxpbmcgaW4gYSBkZXZpY2UNCj4gPiAgKiBody9hcm0vYXNwZWVkOiBEbyBub3QgY3Jl
YXRlIGFuZCBhdHRhY2ggZW1wdHkgU0QgY2FyZHMgYnkgZGVmYXVsdA0KPg0KPg0KPiBBcHBsaWVk
LCB0aGFua3MuDQo+IA0KPiBQbGVhc2UgdXBkYXRlIHRoZSBjaGFuZ2Vsb2cgYXQgaHR0cHM6Ly93
aWtpLnFlbXUub3JnL0NoYW5nZUxvZy81LjENCj4gZm9yIGFueSB1c2VyLXZpc2libGUgY2hhbmdl
cy4NCg0KV2hvIHdpbGwgYmUgcmVzcG9uc2libGUgdXBkYXRpbmcgdGhlIGNoYW5nZWxvZz8gUGF0
Y2ggYXV0aG9yIG9yIHRoZSBwZXJzb24gd2hvIGhhcyB0aGUgc3BlY2lhbCBhY2Nlc3MgZm9yIHRo
YXQgd2lraSBwYWdlPw0KDQpUaGFua3MNCg0KPiAtLSBQTU0NCg0K

