Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D905AC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E6422ADA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WXjuwKIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E6422ADA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqHxT-0004Dp-Sm
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 10:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52447)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqHxH-0003pd-9b
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hqHxG-0000CC-8J
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:09:19 -0400
Received: from mail-eopbgr00122.outbound.protection.outlook.com
 ([40.107.0.122]:40280 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hqHxF-00006s-MF
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:09:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjZhnPg/HTDeySJ3avXOVCTJB43xks9L+mt41iQSytEglZ1Xk1Fud51It5uyhr6fAiUDTNA6L1JBGxdEl722i7M3O31NwfEGS4tXLjr++bRpRmk55cdpH9Hp9ng6NCUvXNr2G8O0QkmQxbA/2VGrcoKstIaYQ8dG2LLzddNQztPLAYcaIsUVPX0JdZ+8bdoLKjcHcftUUh58L+bVY883w7mSHbOJRLfuONDjDo6HO9KZ0oHP/6bOJ7KbEGYRmnx844JZqsNWKWvDSrW4DTQy09nQN7mXzsUelqvlXQEpnVC+vGDFDYKckPTEYg+vFJ2G/p1tTso6bbLsDQmsCdRJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENpAcQPsZ++lOf8l6olt8mi2UN09BpBA6Uu9bNjnO98=;
 b=mXmMEVg4JHptlJYYUxOaIyNJ/4Nbng8Glvh3NmvM2eCj4iEBOiqhcnshNOc3nepK8CWzUTkJqp4Jp3VRhTCmzHCpiOpcx0lMAsWqBSG455ZeCGvUWRP1ABd5b23bPfs88lyUpYAUb63MaN7nl6Y0mZV9PpQe6b0u6t8CGhq2Zbp5AU/sPG33Hya+dcUWF5lpaQK+rIP0TGEmN0y/dAcxNcchooE/2VQ1pZFishidtSBir5iWAMG0PwU/09vdEcaT7rBIK6MdGkIniLQEJSS5wmHN9+G8cGRUEgeEfg45pW4ZgzKYyiBKP0xLpoY+0+Ezt3Sfbrg//rEB8bRd3rqA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENpAcQPsZ++lOf8l6olt8mi2UN09BpBA6Uu9bNjnO98=;
 b=WXjuwKISie2+TbSVQv8VB5QivvUik0HoabwbpsxD0h8ZvrKLyPqZi8sutmgh/cT7wKZBRBfABfnYXSNJ9QzOIfa/K7JJp+Qne8fZ1DC8ManJAVTw20F7fBrJEr/M1JPKb0RuA1XkmaTFsxjem6bZtcrJtqglP1cH0o2TvXAAGGk=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5466.eurprd08.prod.outlook.com (52.133.242.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Wed, 24 Jul 2019 14:09:15 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2115.005; Wed, 24 Jul 2019
 14:09:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v3] qapi: Add InetSocketAddress member
 keep-alive
Thread-Index: AQHVItcM3wOm9AhbYkaUVWyUUHH336asbz0VgCYsUgCAB3F/AA==
Date: Wed, 24 Jul 2019 14:09:15 +0000
Message-ID: <6a1109d2-4afd-a68f-27eb-200724bb9f47@virtuozzo.com>
References: <20190614173140.19159-1-vsementsov@virtuozzo.com>
 <87v9wtn634.fsf@dusky.pond.sub.org>
 <548af442-ed15-3065-ddbd-a3728a4e752c@redhat.com>
In-Reply-To: <548af442-ed15-3065-ddbd-a3728a4e752c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:7:66::13) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190724170912667
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bf89aa3-cdea-4cd5-15fb-08d71040827d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5466; 
x-ms-traffictypediagnostic: DB8PR08MB5466:
x-microsoft-antispam-prvs: <DB8PR08MB54663A6CA8448B5CEF40E948C1C60@DB8PR08MB5466.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39850400004)(396003)(376002)(366004)(136003)(189003)(199004)(66066001)(71200400001)(71190400001)(25786009)(76176011)(26005)(386003)(36756003)(53546011)(6116002)(186003)(3846002)(6436002)(68736007)(486006)(6246003)(102836004)(6506007)(53936002)(8676002)(31686004)(478600001)(305945005)(52116002)(446003)(11346002)(2616005)(476003)(7736002)(110136005)(4326008)(14454004)(6512007)(86362001)(6486002)(66446008)(66946007)(5660300002)(81166006)(81156014)(64756008)(256004)(31696002)(66476007)(66556008)(54906003)(8936002)(316002)(229853002)(99286004)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5466;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8paJidY5uh7O2ZMtx2KYpiAqR9az/BNNZEQeQTO9O4C6JCNDbw70ajWs2uqSjNZ7BKxSJftzE4X9VVynBkDNxHxAuh1Ne1sGYEj/sv9fCVEJSKLs+4rLnU4lukIeJkGDxrP1cdHSUJjRLpU9lTvVCdCmGjU5bOfpQd42OZ0D2Jl62uHKHi+OnC7VvLW1C050QMZfW4h1kIqK7eBcNL7oRJe/6G/yXkoEeQmKrVWRlDQOqECosPCcQr2yiFizT0Osdn6MXXpw0eU57m8Bq7BWu5Ch2lvh6hm9laXMJH63IsqO9+2H8bgSD91sNCAsw4bRYyfHxrQ3Iut019vF7ssM57tbS0ervW5JkXlp9jMGnp0HfWRyLAZzmL/FcOVR3UC9hRL/FDZMxnvBWRtjsfXmoSQqFs/L6Mty9ZqC/TfWFPY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1449D65CE1DF8B47A4FAB9B2AB87D452@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf89aa3-cdea-4cd5-15fb-08d71040827d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 14:09:15.1262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5466
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.122
Subject: Re: [Qemu-devel] [PATCH v3] qapi: Add InetSocketAddress member
 keep-alive
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
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDcuMjAxOSAyMzoyOSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNi8yNS8xOSA4OjMyIEFN
LCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4+IEkgYXBvbG9naXplIGZvciBkcmFnZ2luZyBt
eSBmZWV0IG9uIHRoaXMgcmV2aWV3Lg0KPj4NCj4+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPj4NCj4+PiBJdCdzIG5lZWRl
ZCB0byBwcm92aWRlIGtlZXBhbGl2ZSBmb3IgbmJkIGNsaWVudCB0byB0cmFjayBzZXJ2ZXINCj4+
PiBhdmFpbGFiaWxpdHkuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4gLS0tDQo+Pj4NCj4g
DQo+Pj4gKysrIGIvcWFwaS9zb2NrZXRzLmpzb24NCj4+PiBAQCAtNTMsNiArNTMsOSBAQA0KPj4+
ICAgIw0KPj4+ICAgIyBAaXB2Njogd2hldGhlciB0byBhY2NlcHQgSVB2NiBhZGRyZXNzZXMsIGRl
ZmF1bHQgdHJ5IGJvdGggSVB2NCBhbmQgSVB2Ng0KPj4+ICAgIw0KPj4+ICsjIEBrZWVwLWFsaXZl
OiBlbmFibGUga2VlcC1hbGl2ZSB3aGVuIGNvbm5lY3RpbmcgdG8gdGhpcyBzb2NrZXQuIE5vdCBz
dXBwb3J0ZWQNCj4+PiArIyAgICAgICAgICAgICAgZm9yIHNlcnZlci1zaWRlIGNvbm5lY3Rpb25z
LiAoU2luY2UgNC4xKQ0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGlzIG1pc3NlZCA0LjEuICBBcmUg
eW91IHBsYW5uaW5nIG9uIHNlbmRpbmcgdjQsIHRvIGFkZHJlc3MNCj4gDQo+Pj4gKyMNCj4+DQo+
PiBJcyAic2VydmVyLXNpZGUgY29ubmVjdGlvbiIgaXMgYW4gZXN0YWJsaXNoZWQgdGVybT8NCj4+
DQo+PiBGb3Igd2hhdCBpdCdzIHdvcnRoLCAicGFzc2l2ZSBzb2NrZXQiIGlzLCBzZWUgbGlzdGVu
KDIpLg0KPj4NCj4+PiAgICMgU2luY2U6IDEuMw0KPj4+ICAgIyMNCj4+PiAgIHsgJ3N0cnVjdCc6
ICdJbmV0U29ja2V0QWRkcmVzcycsDQo+Pj4gQEAgLTYxLDcgKzY0LDggQEANCj4+PiAgICAgICAn
Km51bWVyaWMnOiAgJ2Jvb2wnLA0KPj4+ICAgICAgICcqdG8nOiAndWludDE2JywNCj4+PiAgICAg
ICAnKmlwdjQnOiAnYm9vbCcsDQo+Pj4gLSAgICAnKmlwdjYnOiAnYm9vbCcgfSB9DQo+Pj4gKyAg
ICAnKmlwdjYnOiAnYm9vbCcsDQo+Pj4gKyAgICAnKmtlZXAtYWxpdmUnOiAnYm9vbCcgfSB9DQo+
Pj4gICANCj4+PiAgICMjDQo+Pj4gICAjIEBVbml4U29ja2V0QWRkcmVzczoNCj4+PiBkaWZmIC0t
Z2l0IGEvdXRpbC9xZW11LXNvY2tldHMuYyBiL3V0aWwvcWVtdS1zb2NrZXRzLmMNCj4+PiBpbmRl
eCA4ODUwYTI4MGE4Li44MTMwNjM3NjFiIDEwMDY0NA0KPj4+IC0tLSBhL3V0aWwvcWVtdS1zb2Nr
ZXRzLmMNCj4+PiArKysgYi91dGlsL3FlbXUtc29ja2V0cy5jDQo+Pj4gQEAgLTQzOCw2ICs0Mzgs
MTIgQEAgaW50IGluZXRfY29ubmVjdF9zYWRkcihJbmV0U29ja2V0QWRkcmVzcyAqc2FkZHIsIEVy
cm9yICoqZXJycCkNCj4+PiAgICAgICBzdHJ1Y3QgYWRkcmluZm8gKnJlcywgKmU7DQo+Pj4gICAg
ICAgaW50IHNvY2sgPSAtMTsNCj4+PiAgIA0KPj4+ICsgICAgaWYgKHNhZGRyLT5rZWVwX2FsaXZl
KSB7DQo+Pj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAia2VlcC1hbGl2ZSBvcHRpb25zIGlz
IG5vdCBzdXBwb3J0ZWQgZm9yIHNlcnZlci1zaWRlICINCj4+PiArICAgICAgICAgICAgICAgICAg
ICJjb25uZWN0aW9uIik7DQo+Pj4gKyAgICAgICAgcmV0dXJuIC0xOw0KPj4+ICsgICAgfQ0KPj4+
ICsNCj4+PiAgICAgICByZXMgPSBpbmV0X3BhcnNlX2Nvbm5lY3Rfc2FkZHIoc2FkZHIsIGVycnAp
Ow0KPj4+ICAgICAgIGlmICghcmVzKSB7DQo+Pj4gICAgICAgICAgIHJldHVybiAtMTsNCj4+DQo+
PiBJJ20gYWZyYWlkIHlvdSBhZGRlZCB0aGlzIHRvIHRoZSB3cm9uZyBmdW5jdGlvbjsgLi4uDQo+
Pg0KPj4+IEBAIC00NTcsNiArNDYzLDE5IEBAIGludCBpbmV0X2Nvbm5lY3Rfc2FkZHIoSW5ldFNv
Y2tldEFkZHJlc3MgKnNhZGRyLCBFcnJvciAqKmVycnApDQo+Pj4gICAgICAgfQ0KPj4+ICAgDQo+
Pj4gICAgICAgZnJlZWFkZHJpbmZvKHJlcyk7DQo+Pj4gKw0KPj4+ICsgICAgaWYgKHNhZGRyLT5r
ZWVwX2FsaXZlKSB7DQo+Pg0KPj4gLi4uIGl0IHJlbmRlcnMgdGhpcyBjb2RlIHVucmVhY2hhYmxl
Lg0KPj4NCj4+IEkgZ3Vlc3MgdGhlICJub3Qgc3VwcG9ydGVkIGZvciBwYXNzaXZlIHNvY2tldHMi
IGNoZWNrIHNob3VsZCBnbyBpbnRvDQo+PiBpbmV0X2xpc3Rlbl9zYWRkcigpIGluc3RlYWQuDQo+
IA0KPiB0aGlzIGNvbW1lbnQ/DQo+IA0KDQpTb3JyeSBmb3IgYmlnIGRlbGF5LCB3aWxsIHJlc2Vu
ZCBmb3IgNC4yIHNvb24uDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

