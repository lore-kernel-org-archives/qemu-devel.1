Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2E1C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 13:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0BEA2070C
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 13:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Oc2KGZNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BEA2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwReQ-0001Lf-QN
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 09:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33331)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwRdn-0000q5-Jz
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 09:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwRdm-0000Ep-M0
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 09:42:39 -0400
Received: from mail-eopbgr50095.outbound.protection.outlook.com
 ([40.107.5.95]:30475 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwRdm-0000CV-4g; Sat, 10 Aug 2019 09:42:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7Jgf3SXMpuuaZ7CA2PJPqGeiRzSWzDCxp8s5l+UB7errJEwFTwZItFk5Pz4XOCXdEcsfhCAsNxq3Tek9TYsGKMxXhQS9ryrfqx2tYnKsoC9gOBaUEzbbcKMXcoKk4yikQUgf+sRUMtkCwFv2ZPTNp7h3DbQXoet8Q+Lat1lnrnQW8py1nTdqeTEhOLDd4yoJrOWWt34oYm9xRFOor92bYeddJsTtnu5/fcM3Ual+tZtN/HVKGeC9XUl4aauM/wzrh4BZqPROTVpGx44J3M4+PnEtufKwBZxJacFbMV+oKweVZU4Ha0hWyiIHZqyLMyup8cDMPaauskQ2Ja5gXHDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKLQ2isiMRYUITJ9jt68T9mZCTTVsZWAPhQ3RHXXHCk=;
 b=WFJc31vP3qob9t9cS9Caf+IfCIYfvWYkVMz+79IpbdNM/wDEHgy3+/YkkOmDCb90s7OEiTs6Vxs9iRuhq7vQ4TNPO91+GtkbeC0V6Bd1llw1MMvkYvmACGAbW9pXahnV4DvcKphIV5Cw3y1Or0vthQYeiK//j4bRNjprej2lKtWq0oMQuvNiT2qFWTocQ4xo3XngQcp5AQaOSGF/ZL9rGm+JEpJ9OMr8VpEIh3I3pAf4gHd6fvytFo/y33SOLEZBH/zQk2pCz23ywVwI7C/BFx2st2sH/Ta52F9XhfCSc1tBTaaFNND0LuKeNqkU0ZnlTnK+RapQyrT6L55Re7w3eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKLQ2isiMRYUITJ9jt68T9mZCTTVsZWAPhQ3RHXXHCk=;
 b=Oc2KGZNld5kWFxqVVtQNz15zvAgM/kzLQQ0kjuHIng/AMnQo2cjzAj2kpUV0Da7pQ0dxD9sbyXr3mRqJhfifbKcoOgvx2S4LezJrrPE0oT9FqrHff7+vF8eGCOMH+cYmNm2SeMKe1Qb21mAA4TObHhFI/I4mc9HTR4l1fLwV3ww=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4137.eurprd08.prod.outlook.com (20.179.9.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Sat, 10 Aug 2019 13:42:34 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.021; Sat, 10 Aug 2019
 13:42:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 10/42] block: Drop bdrv_is_encrypted()
Thread-Index: AQHVTs2JAVV+l7jA5EC9HWC7GB5JCKb0ZU6A
Date: Sat, 10 Aug 2019 13:42:34 +0000
Message-ID: <376e2c52-2063-8e88-d1b9-6f80e1a2366f@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-11-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-11-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190810164231668
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0949ea0-049b-4256-a067-08d71d989964
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4137; 
x-ms-traffictypediagnostic: DB8PR08MB4137:
x-microsoft-antispam-prvs: <DB8PR08MB4137AB49B031E43CA0DC8599C1D10@DB8PR08MB4137.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39840400004)(396003)(346002)(376002)(199004)(189003)(316002)(14444005)(256004)(2906002)(76176011)(54906003)(386003)(6506007)(3846002)(52116002)(99286004)(229853002)(6486002)(36756003)(6116002)(26005)(66066001)(110136005)(186003)(446003)(71190400001)(71200400001)(102836004)(31696002)(7736002)(5660300002)(11346002)(2616005)(6436002)(64756008)(66946007)(66446008)(66556008)(66476007)(6512007)(53936002)(476003)(25786009)(86362001)(6246003)(8936002)(2501003)(81156014)(81166006)(478600001)(31686004)(8676002)(486006)(305945005)(14454004)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4137;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9ijFt1zNDQnkmhMI0s9GL77E/J5Ol3PjQ09aMvPv7/+t4+Ty76T3gEmc3ZQhpl0y95JIOHGwp9L7c9QJ43dj5oPbpbGJVASgRJlmiwwKPiK0p9607+2dAeNT7hCl7ZIgWUv8jxWgqmHwu/KEVDnww6XybpOp1wmEeb1wnixBG5YT4AbshOwtMzodl7vK92enDVknS4BbYSXAJG01YkLe67pGRUHGKKu8bANANUCecQhKAyIsLUW288gk8oDU+RLmE4BX0CtlAxXCcn+eyUgprU3HaPmnENJlMP9JoJtY8NG3QkVf9Ym3VHmj+r7UWw09IKIwjujwifvL9JwWUa374k5K7N0i+G31kSJ4Ds/xo7Y3Q7d30ntGkBhGBzvrUxamb9p1o9U9VvpTG6YcnI0JmlFfnRT103QKuBCEh3WRstk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AF5C227DB50EE4BA98FBEF6E1FAD459@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0949ea0-049b-4256-a067-08d71d989964
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 13:42:34.3578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GL6lIE2I758ki2RB+qil+SyYA/9gEvjvX/YCP9Fe2uLCNviKaFxIplVbFTX6jHCViQiefX18wx8joWxMQfE+DXTI+GO7o7A6kmM763pPzhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4137
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.95
Subject: Re: [Qemu-devel] [PATCH v6 10/42] block: Drop bdrv_is_encrypted()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxOToxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGUgb3JpZ2luYWwgcHVycG9z
ZSBvZiBiZHJ2X2lzX2VuY3J5cHRlZCgpIHdhcyB0byBpbnF1aXJlIHdoZXRoZXIgYSBCRFMNCj4g
Y2FuIGJlIHVzZWQgd2l0aG91dCB0aGUgdXNlciBlbnRlcmluZyBhIHBhc3N3b3JkIG9yIG5vdC4g
IEl0IGhhcyBub3QNCj4gYmVlbiB1c2VkIGZvciB0aGF0IHB1cnBvc2UgZm9yIHF1aXRlIHNvbWUg
dGltZS4NCj4gDQo+IEFjdHVhbGx5LCBpdCBpcyBub3QgZXZlbiBmaXQgZm9yIHRoYXQgcHVycG9z
ZSwgYmVjYXVzZSB0byBhbnN3ZXIgdGhhdA0KPiBxdWVzdGlvbiwgaXQgd291bGQgaGF2ZSByZWN1
cnNpdmVseSBxdWVyeSBhbGwgb2YgdGhlIGdpdmVuIG5vZGUncw0KPiBjaGlsZHJlbi4NCj4gDQo+
IFNvIG5vdyB3ZSBoYXZlIHRvIGRlY2lkZSBpbiB3aGljaCBkaXJlY3Rpb24gd2Ugd2FudCB0byBm
aXgNCj4gYmRydl9pc19lbmNyeXB0ZWQoKTogUmVjdXJzaXZlbHkgcXVlcnkgYWxsIGNoaWxkcmVu
LCBvciBkcm9wIGl0IGFuZCBqdXN0DQo+IHVzZSBicy0+ZW5jcnlwdGVkIHRvIGdldCB0aGUgY3Vy
cmVudCBub2RlJ3Mgc3RhdHVzPw0KPiANCj4gTm93YWRheXMsIGl0cyBvbmx5IHB1cnBvc2UgaXMg
dG8gcmVwb3J0IHRocm91Z2ggYmRydl9xdWVyeV9pbWFnZV9pbmZvKCkNCj4gd2hldGhlciB0aGUg
Z2l2ZW4gaW1hZ2UgaXMgZW5jcnlwdGVkIG9yIG5vdC4gIEZvciB0aGlzIHB1cnBvc2UsIGl0IGlz
DQo+IHByb2JhYmx5IG1vcmUgaW50ZXJlc3RpbmcgdG8gc2VlIHdoZXRoZXIgYSBnaXZlbiBub2Rl
IGl0c2VsZiBpcw0KPiBlbmNyeXB0ZWQgb3Igbm90IChvdGhlcndpc2UsIGEgbWFuYWdlbWVudCBh
cHBsaWNhdGlvbiBjYW5ub3QgZGlzY2VybiBmb3INCj4gY2VydGFpbiB3aGljaCBub2RlcyBhcmUg
cmVhbGx5IGVuY3J5cHRlZCBhbmQgd2hpY2gganVzdCBoYXZlIGVuY3J5cHRlZA0KPiBjaGlsZHJl
bikuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZz
ZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVp
dHpAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZs
YWRpbWlyDQo=

