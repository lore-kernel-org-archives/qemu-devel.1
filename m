Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9895C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DCD207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="J3XXYyII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DCD207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBMDO-0007id-OP
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <juterry@microsoft.com>) id 1iBM9u-000504-Oz
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <juterry@microsoft.com>) id 1iBM9t-0005C9-1L
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:53:26 -0400
Received: from mail-eopbgr780111.outbound.protection.outlook.com
 ([40.107.78.111]:36106 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <juterry@microsoft.com>)
 id 1iBM9s-0005Bx-LK
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 12:53:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLqyGwUT1UyHIUTNpdI/0PAqqJ0VFuGCZpeGhJLu9mlb41KlUBpKOMBVCbi0wMEJZtDe9pT3b6aRyjgkQKqQHUTTb8NB0ZZiotOUGxA/JLfZwjeBAEPXcQZ1j2sGjecMt6X0rsNv5hEW9qfTB8M/F6UHHqGwflIWcfOFKOfrIGjjsGewO1Mil+tQbD8XGjUaMfh3bZ9Y4V9ArZvydaBLgGZET/bGay1aa9rSwXyZpt/mg9Zr0v651z7TCU1ofMvay0+Ff6O6vV2nJG1M9TjPvY0OqvNOp9lMujJAmw5Vle2nKVaRqXoqTIfkJe7F5mkG5EBvvu+XqzHwocBNINPLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSeIx5Vgdw1gi5WOAYdlRvZfVrDYVG4JsNgNgLfyL20=;
 b=Sd/d2tq0/1vFHB47a2oexiG7ewsPmB/ummpjqkmanNn8SW12bbwArhk/+Z9tdlXVDQ1O52mhaw3mWe5S7LQxaXSHO2vWy7PXIkVWBDW7yAyNeKgZ3WNxoxl5tw1lIMqoFpsS/RgaTKlVWiH+jBVVnoqbBczp4AFyL9jb10H9WconZJ8RR/0qeBk2taBqY7LNuydEMXxV3ai012Q6xXxYCZfPiEkK2Dh93RZUxQmR3HLYyJlARRze0pi2NzCeY7BoTnXqIcFjU3DnoKzepC/uma6SYX1hTPGyVr7Rz9dSgKb3R/+dX5VaQkhWfJkJ8MttPcJlwbm2G21fTRE+DjhQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSeIx5Vgdw1gi5WOAYdlRvZfVrDYVG4JsNgNgLfyL20=;
 b=J3XXYyIIU9tvrEeRs/v2EUqd8CZAf//BS4+RrNYvySSUdUdH/UlG3TthxnaLJUlqfTOE7ttds35mqf6WlisARP3wQh5YYQOwj55VUBtrOgd7pzNRJKNFGsQ04SkIuvkRex8/+QjgrrXUj0vRJbX0B+0qH+ZGcX/9JaZGu+vO6xo=
Received: from BYAPR21MB1208.namprd21.prod.outlook.com (20.179.57.18) by
 BYAPR21MB1174.namprd21.prod.outlook.com (20.179.56.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.3; Fri, 20 Sep 2019 16:53:22 +0000
Received: from BYAPR21MB1208.namprd21.prod.outlook.com
 ([fe80::95a1:4685:1c47:2947]) by BYAPR21MB1208.namprd21.prod.outlook.com
 ([fe80::95a1:4685:1c47:2947%4]) with mapi id 15.20.2284.007; Fri, 20 Sep 2019
 16:53:22 +0000
From: "Justin Terry (VM)" <juterry@microsoft.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2 0/3] testing: Build WHPX enabled binaries
Thread-Topic: [PATCH v2 0/3] testing: Build WHPX enabled binaries
Thread-Index: AQHVb6dAQeEzUHaEsEK/azv/b5+saac0rc4AgAAaOpA=
Date: Fri, 20 Sep 2019 16:53:22 +0000
Message-ID: <BYAPR21MB1208F0D09B3E5CA80F1B7C3BB6880@BYAPR21MB1208.namprd21.prod.outlook.com>
References: <20190920113329.16787-1-philmd@redhat.com>
 <01f2f0ee-a288-921a-58f4-78aeb4d457e1@redhat.com>
In-Reply-To: <01f2f0ee-a288-921a-58f4-78aeb4d457e1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=juterry@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-20T16:53:20.9547169Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6d1ab3d4-bb00-4afb-93d9-43660558f9d1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=juterry@microsoft.com; 
x-originating-ip: [67.185.128.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b5669c5-5b3b-402d-9328-08d73deb0bf1
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR21MB1174:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR21MB11748A8019CD701361BD3011B6880@BYAPR21MB1174.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(13464003)(52284002)(199004)(189003)(55016002)(2501003)(229853002)(8990500004)(25786009)(6436002)(486006)(6506007)(66574012)(76116006)(26005)(53546011)(11346002)(3846002)(7696005)(76176011)(446003)(5660300002)(7736002)(14444005)(256004)(8936002)(52536014)(102836004)(6116002)(6306002)(316002)(9686003)(66556008)(71190400001)(4326008)(71200400001)(66946007)(186003)(86362001)(10290500003)(476003)(81156014)(33656002)(74316002)(81166006)(10090500001)(2906002)(110136005)(64756008)(66446008)(966005)(6246003)(14454004)(478600001)(99286004)(7416002)(8676002)(305945005)(54906003)(77540400001)(66476007)(66066001)(22452003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR21MB1174;
 H:BYAPR21MB1208.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 75Awq8r1Zv+L3r5C/biEeDqU8wOSG+0eqKH18EIlA8gw/yIsNPMOgMB78/mC1L6mi8Ylfr9dpIndvIDk8z5D2zXbwVM1VMhEB+c5ByU6FzmblhxvMs+Js1f88/Otx3UQxs985XcpJX9hxl9Bc3KdKhanErHBv14B9pLF2lzYN3hRMALlunmJk+J0es6gXjD66YJj2SHQ3GDTh9f8BY3hGDbxNsJsdvE2gWvYcAC1QmZcfFoiejLSidMwlHYKpKIiLfuQwfCIBaLro2/kDDmsmIWVqR8a5IxmKRijfji+DkvyEgTC27bsXLUT0aHc7Jd/gLioe6S4P1iUJDPvOrWsnnX6MKlEK1Lyg335cT5kcO1/Qv+66vTokzIWDFtn245j1uoZmhk9XR0UNksbBGbxB819JeZvlw4t67JM0eGKsAk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5669c5-5b3b-402d-9328-08d73deb0bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 16:53:22.1245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8sri9IiZyulMKNSH8Pq3OVeDeEe9groWugzjf8jNyCFckG6w9//89ZAFCPTea+buT0reR4bdSjtXWnBMdZO4RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1174
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.111
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGV5IFBoaWwsDQoNCkkgaGF2ZSBjb250YWN0ZWQgb3VyIGxlZ2FsIGRlcGFydG1lbnQgZm9yIGd1
aWRhbmNlIG9uIHRoaXMgc3BlY2lmaWMgdXNlIGNhc2UgYW5kIHdpbGwgdXBkYXRlIHlvdSB3aGVu
IEkgaGVhciBiYWNrLiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0aWVuY2UuDQoNCkp1c3RpbiBUZXJy
eQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIg
MjAsIDIwMTkgODoxOCBBTQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBKdXN0aW4gVGVy
cnkgKFZNKSA8anV0ZXJyeUBtaWNyb3NvZnQuY29tPg0KPiBDYzogRGFuaWVsIFAgLiBCZXJyYW5n
w6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+OyBGYW0gWmhlbmcNCj4gPGZhbUBldXBob24ubmV0Pjsg
VGhvbWFzIEh1dGggPHRodXRoQHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pDQo+IDxwYm9uemlu
aUByZWRoYXQuY29tPjsgQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPjsgUmlj
aGFyZA0KPiBIZW5kZXJzb24gPHJ0aEB0d2lkZGxlLm5ldD47IEVkdWFyZG8gSGFia29zdCA8ZWhh
Ymtvc3RAcmVkaGF0LmNvbT47DQo+IFN0ZWZhbiBXZWlsIDxzd0B3ZWlsbmV0ei5kZT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiAwLzNdIHRlc3Rpbmc6IEJ1aWxkIFdIUFggZW5hYmxlZCBiaW5h
cmllcw0KPiANCj4gT24gOS8yMC8xOSAxOjMzIFBNLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3
cm90ZToNCj4gPiBBZGQgYSBqb2IgdG8gY3Jvc3MtYnVpbGQgUUVNVSB3aXRoIFdIUFggZW5hYmxl
ZC4NCj4gPg0KPiA+IFNpbmNlIHRoZSBXSFBYIGlzIGN1cnJlbnRseSBicm9rZW4sIGluY2x1ZGUg
dGhlIHBhdGNoIHJlcXVpcmVkIHRvIGhhdmUNCj4gPiBzdWNjZXNzZnVsIFNoaXBwYWJsZSBidWls
ZC4NCj4gPg0KPiA+IEkgcHJldmlvdXNseSBpbmNsdWRlZCB0aGUgV0hQWCBoZWFkZXJzIHNoYXJl
ZCBieSB0aGUgQW5kcm9pZCBwcm9qZWN0LA0KPiA+IGFuZCBEYW5pZWwgYXNrZWQgbWUgdG8gY2hl
Y2sgdGhlIEVVTEEuIFdoaWxlIHRyeWluZyB0byBtYW51YWxseQ0KPiA+IGluc3RhbGwgdGhlIFdp
bmRvd3MgU0RLLCBJIG5vdGljZWQgdGhlIGluc3RhbGxlciBmZXRjaGVzIGFyY2hpdmVzDQo+ID4g
ZGlyZWN0bHksIGtpbmRseSBhc2tpbmcgd2hlcmUgdGhleSBhcmUgc3RvcmVkIHZpYSB0aGUgL2Z3
bGluayBBUEkuDQo+ID4gRG8gdGhlIHNhbWUsIGZldGNoIHRoZSByZXF1aXJlZCBhcmNoaXZlcyBh
bmQgZXh0cmFjdCB0aGVtLiBObyBuZWVkIHRvDQo+ID4gYWNjZXB0IEVVTEEuLi4NCj4gPg0KPiA+
IERvY2tlciBidWlsZCB0aGUgaW1hZ2UgZmlyc3QsIHRoZW4gYnVpbGQgUUVNVSBpbiBhIGluc3Rh
bmNlIG9mIHRoaXMNCj4gPiBpbWFnZS4gVGhlIGltYWdlIGlzIGludGVybmFsIHRvIFNoaXBwYWJs
ZSwgdGhlIGluc3RhbmNlcyBhcmUgbm90DQo+ID4gcmVhY2hhYmxlIGFuZCBhcmUgdGhyb3duIG9u
Y2UgdGhlIGJ1aWxkIGlzIGZpbmlzaGVkLiBXaGF0IHdlIGNvbGxlY3QNCj4gPiBmcm9tIFNoaXBw
YWJsZSBpcyB0aGUgY29uc29sZSBvdXRwdXQgb2YgUUVNVSBidWlsZCBwcm9jZXNzLCBhbmQgaWYg
dGhlDQo+ID4gYnVpbGQgcHJvY2VzcyBzdWNjZWVkIG9yIGZhaWxlZC4gU28gZmFyIHdlIGRvIG5v
dCByZWRpc3RyaWJ1dGUgdGhlDQo+ID4gaW1hZ2Ugb3IgYnVpbHQgYmluYXJpZXMuDQo+ID4NCj4g
PiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSAoMyk6DQo+ID4gICB0YXJnZXQvaTM4NjogRml4IGJy
b2tlbiBidWlsZCB3aXRoIFdIUFggZW5hYmxlZA0KPiA+ICAgdGVzdHMvZG9ja2VyOiBBZGQgZmVk
b3JhLXdpbjEwc2RrLWNyb3NzIGltYWdlDQo+ID4gICAuc2hpcHBhYmxlLnltbDogQnVpbGQgV0hQ
WCBlbmFibGVkIGJpbmFyaWVzDQo+IA0KPiBGV0lXIGhlcmUgaXMgdGhlIHJlc3VsdCBvZiB0aGlz
IHNlcmllczoNCj4gaHR0cHM6Ly9uYW0wNi5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGYXBwLg0KPiBzaGlwcGFibGUuY29tJTJGZ2l0aHViJTJGcGhp
bG1kJTJGcWVtdSUyRnJ1bnMlMkY1MTYlMkYxMSUyRmNvbg0KPiBzb2xlJmFtcDtkYXRhPTAyJTdD
MDElN0NqdXRlcnJ5JTQwbWljcm9zb2Z0LmNvbSU3QzczM2E1NjZmMzIzMzQyNw0KPiA4YWU2ZjA4
ZDczZGRkYjM5ZiU3QzcyZjk4OGJmODZmMTQxYWY5MWFiMmQ3Y2QwMTFkYjQ3JTdDMSU3QzAlN0M2
DQo+IDM3MDQ1ODk0NzMzNDYzMTUwJmFtcDtzZGF0YT01NVVSZ0RJSTVyNzRRTVVwTE9EJTJGV1Q1
JTJCNWpienl2DQo+IG5mQ1NkdiUyRk5hV0RBdyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiBEdXJhdGlv
biAxNyBtaW51dGVzICgxMDc2IHNlY29uZHMpDQo+IA0KPiA0bTQ5cyBidWlsZGluZyB0aGUgcWVt
dTpmZWRvcmEtd2luMTBzZGstY3Jvc3MgZG9ja2VyIGltYWdlLCAxMW0xMHMNCj4gYnVpbGRpbmcg
V0hQWCBRRU1VLg0K

