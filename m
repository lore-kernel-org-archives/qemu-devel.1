Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57527C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853AE2177B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 09:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="GI4LF79r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853AE2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQS5f-0007Ki-9c
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 05:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1kQS4K-0006gY-OK
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:18:36 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:20770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1kQS4G-00046A-RZ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 05:18:36 -0400
IronPort-SDR: vivXOGe+WbzsHHnzIS06/VREAR6ik4MWf0vDkE+ISPvZR0U+pypbzTywLXLTZTta/Zj4iItFxj
 1C/Jd9ZP8MetCoIKjS6L5wze42Ah/fZJR4R1QWlKsGt7i2QyhtSn7faYTtcRejHYnuSycTG7Zq
 B/1EhH8kQfMA+iP/kJRYEQoNYJokJ3jpNQPuw59BqRPaPA1wL1CZRkUr/kXRUrc7kI4crkdgz4
 SWsE7JZINXByxYxbClJyezwnLHzQKhGbfSLkuIg/JWchsnGLsiLy0h/cD3A6+f65c/IDj4kVis
 4sI=
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="19269717"
X-IronPort-AV: E=Sophos;i="5.77,350,1596466800"; d="scan'208";a="19269717"
Received: from mail-os2jpn01lp2050.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.50])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2020 18:18:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0LVEvIPmho9Sqe0raQWPPiVL2GuETZKn7jE0sMR7e8FYQoS6hYURWpQ67kDR57sDoOk5Z1cFkZcKNb8rS4d3lq0pO6YUlCOVKFHvymi2K7Y4aQV6Zfxi0eiNjzN4iyNvl/kqL797FsYvLvUMbNOLUShlpytpRhz7sdpACsZadwywkpERqWfB/GP066QDJeukJKzOosE5w+5qV6dAU5ltxNCsQ1ujjMMLRE3hL8I8W/9didh46K1H41q3Z/X7Jr2C6Hes90/a8SKm3CRgkTtjutxR+w66Vwk5YfLFZzU0zE4gzz6n63Xd9TUuH1MEE8KOFZ/xNH6lrO8oJEs+c3H4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPGoBBRTCml1F5dz3uuqK9OxnkJkn2Y5RhSxMCK/z5E=;
 b=EihVYPxWq/zjz0xBIO6bBg69RJfWdkdxGmUXjpxpnK30vXnxP8flfQvbECpUPLSt1jLQ+p0SmjeWN8clRZdoD494twTPapzjD0UBnrBgVnNgBMfeSIeEwxnUVP/njuxkmR+sIt4bniLV9+e38K1/QQh0Ub0eimkxjZRzCubw5vAPnS0S1dsqM3HEkuhIL9KUwDj+PUKPxqWF8DQVuKDkPf69WR+1u68b1I8FxIzY5PhpMAtVq0W/xBVK/T1t5l2hIpcAwZFNCoyjrvbQbQnVdTEobHvLUtOEhOnWUFF2AbSSw+HeLzTFNR5jbA8GATihSADiXwjy/bQNvOMTf1Y58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPGoBBRTCml1F5dz3uuqK9OxnkJkn2Y5RhSxMCK/z5E=;
 b=GI4LF79rzs1bE66iKrKuQSrUxQbF0qbh0cO22wIrCUxRixupC6FL+KITzdhwrEYTOmNYHQmAfrOHHUq5iYkC1SiIwWp8P1b11yFLEl+eXvp70ohpOb4yQzACxV+1pI5R+KX1LeJjeT+mSSeWO2/Olsd8slQvwmoBJO53lH2pHI4=
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com (2603:1096:604:74::21)
 by OSBPR01MB4582.jpnprd01.prod.outlook.com (2603:1096:604:74::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 8 Oct
 2020 09:18:23 +0000
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::922:4117:105f:bce]) by OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::922:4117:105f:bce%4]) with mapi id 15.20.3455.024; Thu, 8 Oct 2020
 09:18:23 +0000
From: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "virtio-fs@redhat.com" <virtio-fs@redhat.com>
Subject: RE: [PATCH] configure: add option for virtiofsd
Thread-Topic: [PATCH] configure: add option for virtiofsd
Thread-Index: AQHWnIrb+Kne8hlQY0en7yQgBnyE6amMRIUAgADTW3A=
Date: Thu, 8 Oct 2020 09:17:08 +0000
Deferred-Delivery: Thu, 8 Oct 2020 09:18:07 +0000
Message-ID: <OSBPR01MB45820C38F613E3D38A565CCEE50B0@OSBPR01MB4582.jpnprd01.prod.outlook.com>
References: <20201007092913.1524199-1-misono.tomohiro@jp.fujitsu.com>
 <15796673-2daf-70a8-4b20-b861d4c22e62@redhat.com>
In-Reply-To: <15796673-2daf-70a8-4b20-b861d4c22e62@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: d617510541c4411abfe373d4bb788a7f
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cab68e6-c116-4990-c6a4-08d86b6b1b67
x-ms-traffictypediagnostic: OSBPR01MB4582:
x-microsoft-antispam-prvs: <OSBPR01MB4582BDF91E339A211128658FE50B0@OSBPR01MB4582.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B2UAF4k5IeIgf0+PV2ZGJ0NJswuVeZSMY9gNf1BWZz/2BZ/6VTbeuyz+Xcxu7Cp+ZBUJjyY8LzCwojsZDuS0C9e798g9G8jB+QtrXgAOMbZGArK4p9dSS/3gun6GcWFNsB7j15R2GcQ2ITz7z5i8D7DAbGxmtJC8FZAMnU7dDi3ssGaXGSzE3V9ifkgflvjFRWwBWTaXhMF6aKZD6+CjR12u4podpUldL4wLx8WjQ9fYKE3Opc7AOp1b/g/FHu5CWHkfxUVA5mtzgvws9Dp+R+n7hVeXd+tSC5vKBkrkr/C6vowwCCLmcI0oAh/sPXICeqD+Zy1P3kt2PR9lT/JJudRFxxRGb5FVWiJEvLXF4UkS7Uw31uYyQmnwfaPdquMjkKWKTUm4cHXn8snN8IObHufN57sJ8NnRe6sHF9oGLKqWAr0d2iA7gQ1AIELWU0HZ60P0jYUAEqMWs5P+EgrYmw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSBPR01MB4582.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(85182001)(71200400001)(6506007)(53546011)(186003)(478600001)(966005)(26005)(7696005)(83080400001)(66946007)(76116006)(66476007)(86362001)(66556008)(64756008)(33656002)(52536014)(5660300002)(66446008)(316002)(110136005)(8936002)(55016002)(83380400001)(9686003)(2906002)(8676002)(6666004)(777600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tju6k8K5bFfPUueSl4ITSk1t05eXNAaSoby/H44KnILJbyNu6MiqFE4WVVobbSsIFtlIBgxOFoZGg2ZdDSWDn8RO+ucNsBWnniWoefPED/8HHYOoVILAiiwvQzmV0pwmCFzK/zy+ryFwjZKCrDk2IqGOTohe8DZ6vovQyUEabAdd7dpZL7TMBjV9lWMUGd5B2h5wp7dI6L2JNKv4pEF6cdIRSXRX8QeE2/08STiCdiFVsnd6ZC8K3UI+02KQeNZfVIdJYQDeqUN4D4kuLx7wEq7ZoSIyaQdoyAAwVC74k/eTJZxnRHhbxklOYtfEPsHrWPpzF8VDUnsjBrWQx+GUYkqVJSSejdNnQt72XveB2Mpt5LO2fzgnkcjUhGaa3/If1bo1o4gyBNIHppTeElIlwFeBhj8808XRpFaQ35HtRCPHU5/VvpY8X92KINJcW0aw/TkN+tumS8V1Y3xPCS7X8EH4jlOwyznRQV3zC7ElkJ+N/935fjLJdrB4VZ9ZTsPvA3kivlQjFcGPYk7qnDjgvZBua/C0LK1D4Ke5KP6ydHvTCv/8WNJMUuhtiIAgxZMixUtgMHKi+iG2f2p7UvnrSA1dffY2LUjL2VwTktpTAV3iRcMVrVCMC2wa1VSdL0z9mhd4jFtLqVlloJwBrS3C9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4582.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cab68e6-c116-4990-c6a4-08d86b6b1b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 09:18:23.7364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BV8Ar/spN4/ypLEmQeF/41dkxl0QkhmO7MgqFQHkC/2K5jsE3fKHYwpYo8Qw3qy/dEUtf2j4vgnhbUTzyKvaNC2glZweSpKoj0j0KElhPGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4582
Received-SPF: pass client-ip=216.71.158.65;
 envelope-from=misono.tomohiro@fujitsu.com; helo=esa20.fujitsucc.c3s2.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 05:18:27
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

PiBPbiAwNy8xMC8yMCAxMToyOSwgTWlzb25vIFRvbW9oaXJvIHdyb3RlOg0KPiA+IEN1cnJlbnRs
eSBpdCBpcyB1bmtub3duIHdoZXRoZXIgdmlydGlvZnNkIHdpbGwgYmUgYnVpbHQgYXQNCj4gPiBj
b25maWd1cmF0aW9uIHRpbWUuIEl0IHdpbGwgYmUgYXV0b21hdGljYWxseSBidWlsdCB3aGVuIGRl
cGVuZGVuY3kgaXMNCj4gPiBtZXQuIEFsc28sIHJlcXVpcmVkIGxpYnJhcmllcyBhcmUgbm90IGNs
ZWFyLg0KPiA+DQo+ID4gVG8gbWFrZSB0aGlzIGNsZWFyLCBhZGQgY29uZmlndXJlIG9wdGlvbiAt
LXtlbmFibGUsZGlzYWJsZX0tdmlydGlvZnNkLg0KPiA+IFRoZSBkZWZhdWx0IGlzIHRoZSBzYW1l
IGFzIGN1cnJlbnQgKGVuYWJsZWQgaWYgYXZhaWxhYmxlKSBsaWtlIG1hbnkNCj4gPiBvdGhlciBv
cHRpb25zLiBXaGVuIC0tZW5hYmxlLXZpcnRpb2ZzZCBpcyBnaXZlbiBhbmQgZGVwZW5kZW5jeSBp
cyBub3QNCj4gPiBtZXQsIHdlIGdldDoNCj4gPg0KPiA+ICAgRVJST1I6IHZpcnRpb2ZzZCByZXF1
aXJlcyBsaWJjYXAtbmcgZGV2ZWwsIHNlY2NvbXAgZGV2ZWwsIHZob3N0IHVzZXINCj4gPiBhbmQg
dG9vbHMgc3VwcG9ydA0KPiA+DQo+ID4gSW4gYWRkaXRpb24sIGNvbmZpZ3VyYXRpb24gc3VtbWFy
eSBub3cgaW5jbHVkZXMgdmlydGlvZnNkIGVudHJ5Og0KPiA+DQo+ID4gICBidWlsZCB2aXJ0aW9m
cyBkYWVtb246IFlFUy9OTw0KPiA+DQo+ID4gU2lkZW5vdGU6IHRoaXMgcGF0Y2ggZGVmaW5lcyBD
T05GSUdfVklSVElPRlNEIGZvciBjb25maWctaG9zdC5tYWsgdG8NCj4gPiBhdm9pZCBkdXBsaWNh
dGUgZGVwZW5kZW5jeSBjaGVjayBpbiB0b29scy9tZXNvbi5idWlsZC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE1pc29ubyBUb21vaGlybyA8bWlzb25vLnRvbW9oaXJvQGpwLmZ1aml0c3UuY29t
Pg0KPiANCj4gSGkgTWlzb25vLA0KPiANCj4gY2FuIHlvdSBwbGVhc2UgaGFuZGxlIHRoZSBvcHRp
b24gdmlhIG1lc29uX29wdGlvbnMudHh0PyAgVGhhdCBpcywganVzdCBwYXNzIHRoZSB2YWx1ZSAo
YXV0by9lbmFibGVkL2Rpc2FibGVkKSB0aHJvdWdoDQo+IGZyb20gY29uZmlndXJlIHRvIG1lc29u
LCBhbmQgaGFuZGxlIHRoZSBkZWZhdWx0IGluIHRvb2xzL21lc29uLmJ1aWxkLiAgVGhlIGxvZ2lj
IHdpbGwgYmUgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gDQo+IGhhdmVfdmlydGlvZnNkID0gKHRh
cmdldG9zID09ICdsaW51eCcgYW5kDQo+ICAgICAnQ09ORklHX1NFQ0NPTVAnIGluIGNvbmZpZ19o
b3N0IGFuZA0KPiAgICAgJ0NPTkZJR19MSUJDQVBfTkcnIGluIGNvbmZpZ19ob3N0KQ0KPiANCj4g
aWYgZ2V0X29wdGlvbigndmlydGlvZnNkJykuZW5hYmxlZCgpDQo+ICAgaWYgbm90IGhhdmVfdmly
dGlvZnNkDQo+ICAgICBpZiB0YXJnZXRvcyAhPSAnbGludXgnDQo+ICAgICAgIGVycm9yKCd2aXJ0
aW9mc2QgcmVxdWlyZXMgTGludXgnKQ0KPiAgICAgZWxzZQ0KPiAgICAgICBlcnJvcigndmlydGlv
ZnNkIHJlcXVpcmVzIGxpYmNhcC1uZy1kZXZlbCBhbmQgc2VjY29tcC1kZXZlbCcpDQo+ICAgICBl
bmRpZg0KPiAgIGVuZGlmDQo+IGVsaWYgZ2V0X29wdGlvbigndmlydGlvZnNkJykuZGlzYWJsZWQo
KSBvciBub3QgaGF2ZV90b29scyBvciBcDQo+ICAgICAgbm90ICdDT05GSUdfVkhPU1RfVVNFUicg
aW4gY29uZmlnX2hvc3QNCj4gICBoYXZlX3ZpcnRpb2ZzZCA9IGZhbHNlDQo+IGVuZGlmDQo+IA0K
PiBpZiBoYXZlX3ZpcnRpb2ZzZA0KPiAgIHN1YmRpcigndmlydGlvZnNkJykNCj4gZW5kaWYNCj4g
DQo+IFRoaXMgaXMgYmVjYXVzZSwgd2hlbiBhZGRpbmcgdGhlIG9wdGlvbiwgdGhlcmUgYXJlIHNv
bWUgY29uZGl0aW9ucyB0aGF0IHNob3VsZCBkaXNhYmxlIHZpcnRpb2ZzZCBieSBkZWZhdWx0IGJ1
dCBjYW4gYmUNCj4gb3ZlcnJpZGRlbiB3aXRoIC0tZW5hYmxlLXZpcnRpb2ZzZC4NCj4gDQo+IE1v
cmUgaW5mb3JtYXRpb24gb24gaG93IHRvIGNyZWF0ZSBhIG5ldyBNZXNvbiBvcHRpb24gY2FuIGJl
IGZvdW5kIGluIGRvY3MvZGV2ZWwvYnVpbGQtc3lzdGVtLnJzdC4NCg0KSGkgUGFvbG8NCg0KVGhh
bmtzIGEgbG90IGZvciB0aGUgY2xlYXIgZXhwbGFuYXRpb24uIEkgd2lsbCB1cGRhdGUgdGhlIHBh
dGNoIHRvIGZvbGxvdyB0aGUgbWVzb24gc3R5bGUuDQpJIHJlYWxpemVkIHZpcnRpb2ZzZCBhY3R1
YWxseSBuZWVkcyB0b29scyAoaS5lLiAiLS1kaXNhYmxlLXRvb2xzIC0tZW5hYmxlLXZpcnRpb2Zz
ZCINCmRvZXMgbm90IHdvcmsgd2l0aCBhYm92ZSBtZXNvbi5idWlsZCkgc2luY2UgdmlydGlvZnNk
IHJlcXVpcmVzIGxpYnZob3N0X3VzZXIgd2hpY2ggd2lsbA0KYmUgYnVpbHQgb255IHdoZW4gdG9v
bHMgYXJlIGJ1aWx0LiBTbywgSSB3aWxsIGtlZXAgdGhlIGN1cnJlbnQgZGVwZW5kZW5jeSBjaGVj
ayAoZXhjZXB0ICdoYXZlX3N5c3RlbScpLg0KDQpCVFcsIHdoaWxlIHRlc3RpbmcgdGhlIHVwZGF0
ZWQgcGF0Y2gsIEkgbm90aWNlZCBjdXJyZW50IG1hc3RlciBicmFuY2ggKGFzIG9mIDEwLzA4KSBm
YWlscyB0byBleGVjdXRlIHZpcnRpb2ZzZC4NCmJhY2t0cmFjZSBmcm9tIGNvcmVkdW1wIHNob3dz
Og0KIzAgIGdldF9yZWxvY2F0ZWRfcGF0aCAoZGlyPTB4NTYwZjRkMmYyZWYwICIvdXNyL2xvY2Fs
L3Zhci9ydW4vdmlydGlvZnNkIikgYXQgLi4vdXRpbC9jdXRpbHMuYzo5MjQNCiMxICAweDAwMDA1
NjBmNGJhYWI2ZGEgaW4gcWVtdV9nZXRfbG9jYWxfc3RhdGVfcGF0aG5hbWUgKHJlbGF0aXZlX3Bh
dGhuYW1lPXJlbGF0aXZlX3BhdGhuYW1lQGVudHJ5PTB4NTYwZjRiYWM2Y2YxICJydW4vdmlydGlv
ZnNkIikNCiAgICBhdCAuLi91dGlsL29zbGliLXBvc2l4LmM6MzQ1DQojMiAgMHgwMDAwNTYwZjRi
YWExYjA5IGluIGZ2X3NvY2tldF9sb2NrIChzZT0weDU2MGY0ZDJmMmYyMCkgYXQgLi4vdG9vbHMv
dmlydGlvZnNkL2Z1c2VfdmlydGlvLmM6ODY1DQojMyAgZnZfY3JlYXRlX2xpc3Rlbl9zb2NrZXQg
KHNlPTB4NTYwZjRkMmYyZjIwKSBhdCAuLi90b29scy92aXJ0aW9mc2QvZnVzZV92aXJ0aW8uYzo5
MDYNCiM0ICB2aXJ0aW9fc2Vzc2lvbl9tb3VudCAoc2U9MHg1NjBmNGQyZjJmMjApIGF0IC4uL3Rv
b2xzL3ZpcnRpb2ZzZC9mdXNlX3ZpcnRpby5jOjk2OA0KIzUgIDB4MDAwMDU2MGY0YmE5OTcyNSBp
biBtYWluIChhcmdjPTxvcHRpbWl6ZWQgb3V0PiwgYXJndj08b3B0aW1pemVkIG91dD4pIGF0IC4u
L3Rvb2xzL3ZpcnRpb2ZzZC9wYXNzdGhyb3VnaF9sbC5jOjI5NDcNCg0KU28sIHRoaXMgaXMgcmVs
YXRlZCB0bzogaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9jb21taXQvZjRmNWVkMmNiZGU2
NWFjYWExYmQ4OGQwMGNjMjNmYThiZjZiNWVkOSNkaWZmLWFlOWI3MzI5OTg1ODdiNjA5YzA4NTRi
YWU0MGIyZmU2UjkyNA0KDQpBZGRpbmcgICJxZW11X2luaXRfZXhlY19kaXIoYXJndlswXSk7IiBp
biB2aXJ0aW9mcydzIG1haW4oKSBzZWVtcyBzb2x2ZSB0aGUgcHJvYmxlbSwgDQpidXQgaXMgaXQg
Y29ycmVjdCBmaXg/DQoNClJlZ2FyZHMsDQpNaXNvbm8NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
UGFvbG8NCj4gDQo+ID4gLWhhdmVfdmlydGlvZnNkID0gKGhhdmVfc3lzdGVtIGFuZA0KPiA+IC0g
ICAgaGF2ZV90b29scyBhbmQNCj4gPiAtICAgICdDT05GSUdfTElOVVgnIGluIGNvbmZpZ19ob3N0
IGFuZA0KPiA+IC0gICAgJ0NPTkZJR19TRUNDT01QJyBpbiBjb25maWdfaG9zdCBhbmQNCj4gPiAt
ICAgICdDT05GSUdfTElCQ0FQX05HJyBpbiBjb25maWdfaG9zdCBhbmQNCj4gPiAtICAgICdDT05G
SUdfVkhPU1RfVVNFUicgaW4gY29uZmlnX2hvc3QpDQo+ID4gLQ0KPiA+IC1pZiBoYXZlX3ZpcnRp
b2ZzZA0KPiA+ICtpZiAnQ09ORklHX1ZJUlRJT0ZTRCcgaW4gY29uZmlnX2hvc3QNCj4gPiAgICBz
dWJkaXIoJ3ZpcnRpb2ZzZCcpDQo+ID4gIGVuZGlmDQo+ID4NCg0K

