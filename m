Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A449C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 522E420828
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c3X7kg47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522E420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2yHU-0004uO-Em
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 09:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2yGN-0004Hk-AI
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i2yGL-0002Zz-Dx
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:45:27 -0400
Received: from mail-eopbgr140133.outbound.protection.outlook.com
 ([40.107.14.133]:56502 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i2yGA-0002Ro-1E; Wed, 28 Aug 2019 09:45:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnltvTDPc8UTQbtLzwQQJu6tlIpBgpv+UGjja3US2v9chWph6I4dpI6VdIJnqzYL3PIXEHnbwbRuYtDs6y6LFZPssXKqYkz0dYou9oDVI5o/e0wGGCKHVA3hEID+psEwKLWlG6UOuwX2SkG8IYlFo7TmjIIfiYVh7C5VsIVKpp7GtY0pdBITLuVo3lzWNTVGWe03kz9LoeuJfiAx2yF5m43MRWwsl7ZH5XG/fpSD3oriy1p36jb5tgj5u4YRcPdHUu073O3b5ZuEPzkc5miDrD9XAQ6D6/wO/79ZOVGBD0nZr8tjWDtvRthzLmZpJf8aFtlyJKMAkiWOH0+0TPsfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAObLB+gNd1X+r6QseHXsheeFsAptr4RITB6ZVU4tCk=;
 b=ZHyFnb+RtiQp9NmI1Bbx0brJXgMP3q5h4qOISk7+g//3dElk4xhIxhSxMLJcEjF2ZyHR2++jMga8SFDN508rBVQHwzO1HWT3TW7LOoCN2ZxJAUy5nMz6nrzue3VIihke6Da7l5pRSn4s4wQUsJYailxkJmUbkB3cpAMbjJ2mWGxpIFLVj41w3gaCwSPJ1OkAsF9OKmWjlBTgacIs2JQR23qSxhjWI4YzH+qrLENOLw9e4iWZ4T56R91BKpZ0mdMSiv1gt3oIcjOtj0aK6kHoSy+vqjPL+v5q0YK8+DJe7z5h95mL9FXeOXRQklShAtqbxMsbtMiOEjDAk1Q7GPACqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAObLB+gNd1X+r6QseHXsheeFsAptr4RITB6ZVU4tCk=;
 b=c3X7kg47liYzkGZ+WKkk+gBWqxAI/5q6Tr/Oo38uGbZ1TwhYDBN3idqscPqrrOVrdocGI/UG/upY7kkftUuS3NJCqFZq8s2WbIE6BGBBml7PNgBdbk3cy9mEXFBY8+5WAUdCjEPsLFNhzZMpwhS5gCb9D+j5/47wA2w0/KI+6jE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4187.eurprd08.prod.outlook.com (20.179.9.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 13:45:09 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 13:45:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "nbd@other.debian.org"
 <nbd@other.debian.org>
Thread-Topic: [Qemu-devel] [PATCH 1/1] protocol: Add NBD_CMD_FLAG_FAST_ZERO
Thread-Index: AQHVWcFpy4hSeVJKj0eg17mhrngR4acQWlsAgAA0ggCAAAs4gA==
Date: Wed, 28 Aug 2019 13:45:08 +0000
Message-ID: <3b8fd5cb-4c9d-801e-61e0-3a620e758cb7@virtuozzo.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143426.26838-1-eblake@redhat.com>
 <20190823143426.26838-2-eblake@redhat.com>
 <274bc60d-f57d-2f97-4be9-8de1aabb0949@virtuozzo.com>
 <810779d1-0289-d635-0446-93b3dd32ec95@redhat.com>
In-Reply-To: <810779d1-0289-d635-0446-93b3dd32ec95@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0006.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::16) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190828164505856
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d1a3ce0-c952-41c1-839a-08d72bbdf0e4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4187; 
x-ms-traffictypediagnostic: DB8PR08MB4187:
x-microsoft-antispam-prvs: <DB8PR08MB418771BF16724C03EFB8E10CC1A30@DB8PR08MB4187.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(39840400004)(366004)(376002)(189003)(199004)(305945005)(6436002)(7736002)(4326008)(66556008)(64756008)(36756003)(256004)(66446008)(8936002)(81166006)(81156014)(8676002)(6486002)(66476007)(14444005)(2501003)(2906002)(14454004)(52116002)(76176011)(186003)(71190400001)(478600001)(71200400001)(26005)(3846002)(6116002)(99286004)(66946007)(31686004)(86362001)(486006)(66066001)(6246003)(53936002)(446003)(476003)(2616005)(316002)(54906003)(6506007)(386003)(102836004)(53546011)(229853002)(5660300002)(110136005)(6512007)(25786009)(31696002)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4187;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JxtP6jR4kYdekZDeP7ak+ixGnOhWL2H7X5JAWZgiSiymXxlUbP2xRf6nhxgJMgXDRC0Jmlv0uhj3z7Vvq9vZlKbCmSt0pa5zxXQb8e+413ktPSBPIT0He/jl0YKkz+xTiNvJdNbGUL6tzDL63W4o1+cnBh8fzW0G825KCOokVPUZ1N4fJR1cNG4fTkEf70vvkfGsOFtCYuJuL/XTnNS9PaETZ5/C9OOWARuvy0NwZCKLMhEMx5tkevQnvkEr/oyJw3f7xb8bLhkRDLtxzK8amF7+/yCKDkyVNVL94Um35OKUUAnDCpdHpaFXZUdviRLKugpeXN8q+rio1un6Do7QIDmIxd4YgaIgB7FkWhrYmCymb4tLnShWsZ21/TMRk/Di7eSv18aZrC1SlyD9dbIoEUe3Km6xxZq1ipkE3uvq+TU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAB736C3C05578499CBE08F51AF6782B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1a3ce0-c952-41c1-839a-08d72bbdf0e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 13:45:08.8667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYaCDEIq5VBqilN7/2ywnY7lH4X4n0fE3ZocP1v6m1VFpMOCVOA+73zOGi1FghmJYUGjlaabSV5eUbs3qksDpWidd8G7x8V41hmK6MaEEj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4187
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.133
Subject: Re: [Qemu-devel] [PATCH 1/1] protocol: Add NBD_CMD_FLAG_FAST_ZERO
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMDguMjAxOSAxNjowNCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOC8yOC8xOSA0OjU3IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiANCj4+PiBIZW5jZSwgaXQg
aXMgZGVzaXJhYmxlIHRvIGhhdmUgYSB3YXkgZm9yIGNsaWVudHMgdG8gc3BlY2lmeSB0aGF0IGEN
Cj4+PiBwYXJ0aWN1bGFyIHdyaXRlIHplcm8gcmVxdWVzdCBpcyBiZWluZyBhdHRlbXB0ZWQgZm9y
IGEgZmFzdCB3aXBlLCBhbmQNCj4+PiBnZXQgYW4gaW1tZWRpYXRlIGZhaWx1cmUgaWYgdGhlIHpl
cm8gcmVxdWVzdCB3b3VsZCBvdGhlcndpc2UgdGFrZSB0aGUNCj4+PiBzYW1lIHRpbWUgYXMgYSB3
cml0ZS4gIENvbnZlcnNlbHksIGlmIHRoZSBjbGllbnQgaXMgbm90IHBlcmZvcm1pbmcgYQ0KPj4+
IHByZS1pbml0aWFsaXphdGlvbiBwYXNzLCBpdCBpcyBzdGlsbCBtb3JlIGVmZmljaWVudCBpbiB0
ZXJtcyBvZg0KPj4+IG5ldHdvcmtpbmcgdHJhZmZpYyB0byBzZW5kIE5CRF9DTURfV1JJVEVfWkVS
TyByZXF1ZXN0cyB3aGVyZSB0aGUNCj4+PiBzZXJ2ZXIgaW1wbGVtZW50cyB0aGUgZmFsbGJhY2sg
dG8gdGhlIHNsb3dlciB3cml0ZSwgdGhhbiBpdCBpcyBmb3IgdGhlDQo+Pj4gY2xpZW50IHRvIGhh
dmUgdG8gcGVyZm9ybSB0aGUgZmFsbGJhY2sgdG8gc2VuZCBOQkRfQ01EX1dSSVRFIHdpdGggYQ0K
Pj4+IHplcm9lZCBidWZmZXIuDQo+Pg0KPj4gSG93IGFyZSB5b3UgZ29pbmcgdG8gZmluYWxseSB1
c2UgaXQgaW4gcWVtdS1pbWcgY29udmVydD8NCj4gDQo+IEl0J3MgYWxyZWFkeSBpbiB1c2UgdGhl
cmUgKGluIGZhY3QsIHRoZSBjb3ZlciBsZXR0ZXIgc2hvd3MgYWN0dWFsIHRpbWluZw0KPiBleGFt
cGxlcyBvZiBob3cgcWVtdS1pbWcncyB1c2Ugb2YgQkRSVl9SRVFfTk9fRkFMTEJBQ0ssIHdoaWNo
IHRyYW5zbGF0ZXMNCj4gdG8gTkJEX0NNRF9GTEFHX0ZBU1RfWkVSTywgb2JzZXJ2YWJseSBhZmZl
Y3RzIHRpbWluZykuDQo+IA0KPj4gT2ssIHdlIGhhdmUgYSBsb29wDQo+PiBvZiBzZW5kaW5nIHdy
aXRlLXplcm8gcmVxdWVzdHMuIEFuZCBvbiBmaXJzdCBFTk9UU1VQIHdlJ2xsIGFzc3VtZSB0aGF0
IHRoZXJlDQo+PiBpcyBubyBiZW5lZml0IHRvIGNvbnRpbnVlPyBCdXQgd2hhdCBpZiBhY3R1YWxs
eSBzZXJ2ZXIgcmV0dXJucyBFTk9UU1VQIG9ubHkNCj4+IG9uY2Ugd2hlbiB3ZSBoYXZlIDEwMDAg
aXRlcmF0aW9ucz8gU2VlbXMgd2Ugc2hvdWxkIHN0aWxsIGRvIHplcm9pbmcgaWYgd2UNCj4+IGhh
dmUgb25seSBhIGZldyBFTk9UU1VQcy4uLg0KPiANCj4gV2hlbiBhdHRlbXB0aW5nIGEgYnVsayB6
ZXJvLCB5b3UgdHJ5IHRvIHdpcGUgdGhlIGVudGlyZSBkZXZpY2UsDQo+IHByZXN1bWFibHkgd2l0
aCBzb21ldGhpbmcgdGhhdCBpcyBsYXJnZSBhbmQgYWxpZ25lZC4gIFllcywgaWYgeW91IGhhdmUN
Cj4gdG8gc3BsaXQgdGhlIHdyaXRlIHplcm8gcmVxdWVzdCBkdWUgdG8gc2l6ZSBsaW1pdGF0aW9u
cywgdGhlbiB5b3Ugcmlzaw0KPiB0aGF0IHRoZSBmaXJzdCB3cml0ZSB6ZXJvIHN1Y2NlZWRzIGJ1
dCBsYXRlciBvbmVzIGZhaWwsIHRoZW4geW91IGRpZG4ndA0KPiB3aXBlIHRoZSBlbnRpcmUgZGlz
aywgYnV0IHlvdSBhbHNvIGRvbid0IG5lZWQgdG8gcmVkbyB0aGUgd29yayBvbiB0aGUNCj4gZmly
c3QgaGFsZiBvZiB0aGUgaW1hZ2UuICBCdXQgaXQgaXMgbXVjaCBtb3JlIGxpa2VseSB0aGF0IHRo
ZSBmaXJzdA0KPiB3cml0ZSBvZiB0aGUgYnVsayB6ZXJvIGlzIHJlcHJlc2VudGF0aXZlIG9mIHRo
ZSBvdmVyYWxsIG9wZXJhdGlvbiAoYW5kDQo+IHNvIGluIHByYWN0aWNlLCBpdCBvbmx5IHRha2Vz
IG9uZSBmYXN0IHplcm8gYXR0ZW1wdCB0byBsZWFybiBpZiBidWxrDQo+IHplcm9pbmcgaXMgd29y
dGh3aGlsZSwgdGhlbiBjb250aW51ZSB3aXRoIGZhc3QgemVyb2VzIHdpdGhvdXQgaXNzdWVzKS4N
Cj4gDQo+Pg0KPj4gSSB1bmRlcnN0YW5kIHRoYXQgZmFpbC1vbi1maXJzdCBFTk9UU1VQIGlzIE9L
IGZvciByYXctd2l0aG91dC1mYWxsb2N0ZSB2cyBxY293MiwNCj4+IGFzIGZpcnN0IHdpbGwgYWx3
YXlzIHJldHVybiBFTk9UU1VQIGFuZCBzZWNvbmQgd2lsbCBuZXZlciBmYWlsLi4gQnV0IGluIHN1
Y2ggd2F5DQo+PiB3ZSdsbCBPSyB3aXRoIHNpbXBsZXIgZXh0ZW5zaW9uLCB3aGljaCBvbmx5IGhh
dmUgb25lIHNlcnZlci1hZHZpcnRpc2VkIG5lZ290aWF0aW9uDQo+PiBmbGFnIE5CRF9GTEFHX1pF
Uk9fSVNfRkFTVC4NCj4gDQo+IEFkdmVydGlzaW5nIHRoYXQgYSBzZXJ2ZXIncyB6ZXJvIGJlaGF2
aW9yIGlzIGFsd2F5cyBnb2luZyB0byBiZQ0KPiBzdWNjZXNzZnVsbHkgZmFzdCBpcyBhIG11Y2gg
aGFyZGVyIGZsYWcgdG8gaW1wbGVtZW50LiAgVGhlIGp1c3RpZmljYXRpb24NCj4gZm9yIHRoZSBz
ZW1hbnRpY3MgSSBjaG9zZSAoYWR2ZXJ0aXNpbmcgdGhhdCB0aGUgc2VydmVyIGNhbiBxdWlja2x5
DQo+IHJlcG9ydCBmYWlsdXJlIGlmIHN1Y2Nlc3MgaXMgbm90IGZhc3QsIGJ1dCBub3QgcmVxdWly
aW5nIGZhc3QgemVybykNCj4gY292ZXJzIHRoZSBjYXNlIHdoZW4gdGhlIGRlY2lzaW9uIG9mIHdo
ZXRoZXIgYSB6ZXJvIGlzIGZhc3QgbWF5IGFsc28NCj4gZGVwZW5kIG9uIG90aGVyIGZhY3RvcnMg
LSBmb3IgZXhhbXBsZSwgaWYgdGhlIHNlcnZlciBrbm93cyB0aGUgaW1hZ2UNCj4gc3RhcnRzIGlu
IGFuIGFsbC16ZXJvIHN0YXRlLCB0aGVuIGl0IGNhbiB0cmFjayBhIGJvb2xlYW46IGFsbCB3cml0
ZSB6ZXJvDQo+IHJlcXVlc3RzIHdoaWxlIHRoZSBib29sZWFuIGlzIHNldCByZXR1cm4gaW1tZWRp
YXRlIHN1Y2Nlc3MgKG5vdGhpbmcgdG8NCj4gZG8pLCBidXQgYWZ0ZXIgdGhlIGZpcnN0IHJlZ3Vs
YXIgd3JpdGUsIHRoZSBib29sZWFuIGlzIHNldCB0byBmYWxzZSwgYW5kDQo+IGFsbCBmdXJ0aGVy
IHdyaXRlIHplcm8gcmVxdWVzdHMgZmFpbCBhcyBiZWluZyBwb3RlbnRpYWxseSBzbG93OyBhbmQg
c3VjaA0KPiBhbiBpbXBsZW1lbnRhdGlvbiBpcyBzdGlsbCB1c2VmdWwgZm9yIHRoZSBxZW11LWlt
ZyBjb252ZXJ0IGNhc2UuDQoNCkFncmVlZCwgdGhhbmtzIGZvciB0aGlzIGV4YW1wbGUpDQoNCj4g
DQo+Pg0KPj4gVGhlcmUgaXMgbm90IHN1Y2ggcHJvYmxlbSBpZiB3ZSBoYXZlIG9ubHkgb25lIGl0
ZXJhdGlvbiwgc28gbWF5IGJlIG5ldyBjb21tYW5kDQo+PiBGSUxMX1pFUk8sIGZpbGxpbmcgdGhl
IHdob2xlIGRldmljZSBieSB6ZXJvcz8NCj4gDQo+IE9yIGJldHRlciB5ZXQsIGltcGxlbWVudCBz
dXBwb3J0IGZvciA2NC1iaXQgY29tbWFuZHMuICBZZXMsIG15IGNvdmVyDQo+IGxldHRlciBjYWxs
ZWQgb3V0IGZ1cnRoZXIgb3J0aG9nb25hbCBleHRlbnNpb25zLCBhbmQgaW1wbGVtZW50aW5nIDY0
LWJpdA0KPiB6ZXJvaW5nIChzbyB0aGF0IHlvdSBjYW4gaXNzdWUgYSB3cml0ZSB6ZXJvIHJlcXVl
c3Qgb3ZlciB0aGUgZW50aXJlDQo+IGltYWdlIGluIG9uZSBjb21tYW5kKSwgYXMgd2VsbCBhcyBh
IHdheSBmb3IgYSBzZXJ2ZXIgdG8gYWR2ZXJ0aXNlIHdoZW4NCj4gdGhlIGltYWdlIGJlZ2lucyBs
aWZlIGluIGFuIGFsbC16ZXJvIHN0YXRlLCBhcmUgYWxzbyBmdXJ0aGVyIGV4dGVuc2lvbnMNCj4g
Y29taW5nIGRvd24gdGhlIHBpcGVsaW5lLiAgQnV0IGFzIG5vdCBhbGwgc2VydmVycyBoYXZlIHRv
IGltcGxlbWVudCBhbGwNCj4gb2YgdGhlIGV4dGVuc2lvbnMsIGVhY2ggZXh0ZW5zaW9uIHRoYXQg
Y2FuIGJlIG9ydGhvZ29uYWxseSBpbXBsZW1lbnRlZA0KPiBhbmQgc2hvdyBhbiBpbXByb3ZlbWVu
dCBvbiBpdHMgb3duIGlzIHN0aWxsIHdvcnRod2hpbGU7IGFuZCBteSBjb3Zlcg0KPiBsZXR0ZXIg
aGFzIHNob3duIHRoYXQgZmFzdCB6ZXJvZXMgb24gdGhlaXIgb3duIG1ha2UgYSBtZWFzdXJhYmxl
DQo+IGRpZmZlcmVuY2UgdG8gY2VydGFpbiB3b3JrbG9hZHMuDQo+IA0KPj4+ICsgICAgSWYgdGhl
IHNlcnZlciBhZHZlcnRpc2VkIGBOQkRfRkxBR19TRU5EX0ZBU1RfWkVST2AgYnV0DQo+Pj4gKyAg
ICBgTkJEX0NNRF9GTEFHX0ZBU1RfWkVST2AgaXMgbm90IHNldCwgdGhlbiB0aGUgc2VydmVyIE1V
U1QgTk9UIGZhaWwNCj4+PiArICAgIHdpdGggYE5CRF9FTk9UU1VQYCwgZXZlbiBpZiB0aGUgb3Bl
cmF0aW9uIGlzIG5vIGZhc3RlciB0aGFuIGENCj4+PiArICAgIGNvcnJlc3BvbmRpbmcgYE5CRF9D
TURfV1JJVEVgLiBDb252ZXJzZWx5LCBpZg0KPj4+ICsgICAgYE5CRF9DTURfRkxBR19GQVNUX1pF
Uk9gIGlzIHNldCwgdGhlIHNlcnZlciBNVVNUIGZhaWwgcXVpY2tseSB3aXRoDQo+Pj4gKyAgICBg
TkJEX0VOT1RTVVBgIHVubGVzcyB0aGUgcmVxdWVzdCBjYW4gYmUgc2VydmljZWQgaW4gbGVzcyB0
aW1lIHRoYW4NCj4+PiArICAgIGEgY29ycmVzcG9uZGluZyBgTkJEX0NNRF9XUklURWAsIGFuZCBT
SE9VTEQgTk9UIGFsdGVyIHRoZSBjb250ZW50cw0KPj4+ICsgICAgb2YgdGhlIGV4cG9ydCB3aGVu
IHJldHVybmluZyB0aGlzIGZhaWx1cmUuIFRoZSBzZXJ2ZXIncw0KPj4+ICsgICAgZGV0ZXJtaW5h
dGlvbiBvZiBhIGZhc3QgcmVxdWVzdCBNQVkgZGVwZW5kIG9uIGEgbnVtYmVyIG9mIGZhY3RvcnMs
DQo+Pj4gKyAgICBzdWNoIGFzIHdoZXRoZXIgdGhlIHJlcXVlc3Qgd2FzIHN1aXRhYmx5IGFsaWdu
ZWQsIG9uIHdoZXRoZXIgdGhlDQo+Pj4gKyAgICBgTkJEX0NNRF9GTEFHX05PX0hPTEVgIGZsYWcg
d2FzIHByZXNlbnQsIG9yIGV2ZW4gb24gd2hldGhlciBhDQo+Pj4gKyAgICBwcmV2aW91cyBgTkJE
X0NNRF9UUklNYCBoYWQgYmVlbiBwZXJmb3JtZWQgb24gdGhlIHJlZ2lvbi4gIElmIHRoZQ0KPj4+
ICsgICAgc2VydmVyIGRpZCBub3QgYWR2ZXJ0aXNlIGBOQkRfRkxBR19TRU5EX0ZBU1RfWkVST2As
IHRoZW4gaXQgU0hPVUxEDQo+Pj4gKyAgICBOT1QgZmFpbCB3aXRoIGBOQkRfRU5PVFNVUGAsIHJl
Z2FyZGxlc3Mgb2YgdGhlIHNwZWVkIG9mIHNlcnZpY2luZw0KPj4+ICsgICAgYSByZXF1ZXN0LCBh
bmQgU0hPVUxEIGZhaWwgd2l0aCBgTkJEX0VJTlZBTGAgaWYgdGhlDQo+Pj4gKyAgICBgTkJEX0NN
RF9GTEFHX0ZBU1RfWkVST2AgZmxhZyB3YXMgc2V0LiBBIHNlcnZlciBNQVkgYWR2ZXJ0aXNlDQo+
Pj4gKyAgICBgTkJEX0ZMQUdfU0VORF9GQVNUX1pFUk9gIHdoZXRoZXIgb3Igbm90IGl0IGNhbiBw
ZXJmb3JtIGZhc3QNCj4+PiArICAgIHplcm9pbmc7IHNpbWlsYXJseSwgYSBzZXJ2ZXIgU0hPVUxE
IGZhaWwgd2l0aCBgTkJEX0VOT1RTVVBgIHdoZW4NCj4+PiArICAgIHRoZSBmbGFnIGlzIHNldCBp
ZiB0aGUgc2VydmVyIGNhbm5vdCBxdWlja2x5IGRldGVybWluZSBpbiBhZHZhbmNlDQo+Pj4gKyAg
ICB3aGV0aGVyIHRoYXQgcmVxdWVzdCB3b3VsZCBoYXZlIGJlZW4gZmFzdCwgZXZlbiBpZiBpdCB0
dXJucyBvdXQNCj4+PiArICAgIHRoYXQgdGhlIHNhbWUgcmVxdWVzdCB3aXRob3V0IHRoZSBmbGFn
IHdvdWxkIGJlIGZhc3QgYWZ0ZXIgYWxsLg0KPj4+ICsNCj4+DQo+PiBXaGF0IGlmIFdSSVRFX1pF
Uk8gaW4gdGhlIGF2ZXJhZ2UgaXMgZmFzdGVyIHRoYW4gV1JJVEUgKGZvciBleGFtcGxlIGJ5IDIw
JSksDQo+PiBidXQgc2VydmVyIG5ldmVyIGNhbiBndWFyYW50ZWUgcGVyZm9ybWFuY2UgZm9yIG9u
ZSBXUklURV9aRVJPIG9wZXJhdGlvbiwgZG8NCj4+IHlvdSByZXN0cmljdCBzdWNoIGNhc2U/IEht
bSwgT0ssIFNIT1VMRCBpcyBub3QgTVVTVCBhY3R1YWxseS4uDQo+IA0KPiBJIHRoaW5rIG15IGZv
bGxvd3VwIG1haWwsIGJhc2VkIG9uIFdvdXRlcidzIHF1ZXN0aW9ucywgY292ZXJzIHRoaXM6IHRo
ZQ0KDQpIbW0sIE9LLCBzb3JyeSBmb3IgZHVwbGljYXRpb24NCg0KPiBnb2FsIGlzIHRvIGRvY3Vt
ZW50IHRoZSB1c2UgY2FzZSBvZiBvcHRpbWl6aW5nIHRoZSBjb3B5IG9mIGEgc3BhcnNlDQo+IGlt
YWdlLCBieSBwcm9iaW5nIHdoZXRoZXIgYSBidWxrIHByZS16ZXJvaW5nIHBhc3MgaXMgd29ydGh3
aGlsZS4gIFRoYXQNCj4gc2hvdWxkIGJlIHRoZSBtZWFzdXJpbmcgcm9kIC0gaWYgdGhlIGltcGxl
bWVudGF0aW9uIGNhbiBwZXJmb3JtIGEgZmFzdGVyDQo+IHNwYXJzZSBjb3B5IGJlY2F1c2Ugb2Yg
d3JpdGUgemVyb2VzIHRoYXQgYXJlIHNvbWV0aW1lcywgYnV0IG5vdCBhbHdheXMsDQo+IGZhc3Rl
ciB0aGFuIHdyaXRlcywgaW4gc3BpdGUgb2YgdGhlIGR1cGxpY2F0ZWQgSS9PIHRoYXQgaGFwcGVu
cyB0byB0aGUNCj4gZGF0YSBwb3J0aW9ucyBvZiB0aGUgaW1hZ2UgdGhhdCB3ZXJlIHRvdWNoZWQg
dHdpY2UgYnkgdGhlIHByZS16ZXJvIHBhc3MNCj4gdGhlbiB0aGUgYWN0dWFsIGRhdGEgcGFzcywg
dGhlbiBzdWNjZWVkaW5nIG9uIGZhc3QgemVybyByZXF1ZXN0cyBpcw0KPiBva2F5LiAgQnV0IGlm
IGl0IG1ha2VzIHRoZSBvdmVyYWxsIGltYWdlIGNvcHkgc2xvd2VyLCB0aGVuIGZhaWxpbmcgd2l0
aA0KPiBFTk9UU1VQIGlzIHByb2JhYmx5IGJldHRlci4gIEFuZCBhdCB0aGUgZW5kIG9mIHRoZSBk
YXksIGl0IGlzIHJlYWxseQ0KPiBqdXN0IGEgaGV1cmlzdGljIC0gaWYgdGhlIHNlcnZlciBndWVz
c2VkIHdyb25nLCB0aGUgd29yc3QgdGhhdCBoYXBwZW5zDQo+IGlzIHNsb3dlciBwZXJmb3JtYW5j
ZSAoYW5kIG5vdCBkYXRhIGNvcnJ1cHRpb24pLg0KPiANCg0KT0ssIEkgdW5kZXJzdGFuZCwgdGhh
biBpdCdzIGFsbCBzb3VuZHMgZ29vZA0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

