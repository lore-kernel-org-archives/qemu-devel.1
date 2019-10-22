Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2635BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4DD2075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PNZNlpnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4DD2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrhq-0004N7-0d
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMrgP-0003qY-T9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMrgO-00041R-CE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:46:33 -0400
Received: from mail-eopbgr150095.outbound.protection.outlook.com
 ([40.107.15.95]:18302 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iMrgJ-0003ur-Mc; Tue, 22 Oct 2019 06:46:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm9x54FFeRFVdcXq5styXiwSFw+6Gv6HbjlzK3VkXgRpEHHCFMxdZOL0XoXtV3717Ghz5VlD7C8AZeBn+XuOuI7DbbPPGTEycJbUN/lZ9sWGZpc4Pj7MRfzSCPL9Z9iTDktaFQMoHvnpKm795OVvc7Tl42ssJPnW+hC+nNM3JxQYKtiuO6YphETbSTuUPj9Gra2ctJAvkLGgCRja1G/d7y89PgtAOyyKz22OgnqKHqUrqvXj6JDE0aj7ad4mYsRv3VqibwKapaCCErlqwUbkcJGkuDdrUjzrH6cOjmaydDMQWU8G2IKsKZrwo6KYN34+fKCv/+U6gIAr5xL5dEiXeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3KAhXGNwxFbsURhwURIeTr6UTDUhglaQ4nUZDZBVxw=;
 b=en/K3tXTHVSbv2Jq8WzjlrOxtiAtc0qpFJj5zZ+nSaZ83cweIH7+S+yMCcK9NWFf53TCntphOBHmO9TNuxAqePzimNXz9GWUs70/Vlfs6riiNxUgwl6MuZCSVf1NEYNfc6ogADomeQx7nlQMGtXr3O8xGMBFQ7s1qm6sfC9l6CztpckLB1CsUL+Vzs7DeWPhsA+htgrKtwky8hX7UFId7pfz/y3T796zx9RfLuN4fYtL9Dn0d3cXFTFb7/av7QJc20yk4HG7lOn4sqwnn6Ma3qEUmmD4C9H5mL9uq0QRjE+yFWC610DZgOAiTAKYsJL24fwsjevII3gsP8v30dEqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3KAhXGNwxFbsURhwURIeTr6UTDUhglaQ4nUZDZBVxw=;
 b=PNZNlpnNehyAAQDeZI634p4A90cST69klQX/221E//KeUAgokZzMMQjMo8AD838BCPVAn67DoK5lh6qIFbRX3Pg3/Rukv4Qwy1HoRbBXO4fIuQZQ87Y4Z+EeTDeAV6L0ZeoGRCSwQxZ2HluRSfMfm4V2lS8sBAdB1bhPfjgytFM=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB4579.eurprd08.prod.outlook.com (20.178.82.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Tue, 22 Oct 2019 10:46:21 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 10:46:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Max Reitz
 <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 1/4] block: support compressed write at generic layer
Thread-Topic: [PATCH v5 1/4] block: support compressed write at generic layer
Thread-Index: AQHVh4YxmUtdFYq2BEKkM8Mgtnynq6dmZxIAgAAO34CAAAbigA==
Date: Tue, 22 Oct 2019 10:46:21 +0000
Message-ID: <cc3f87c2-3ad5-da4e-4750-27a48bce1ee6@virtuozzo.com>
References: <1571603828-185910-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1571603828-185910-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <408ef2ab-1f6c-2c9f-ad50-92269c20fb27@redhat.com>
 <eece4ca2-7c40-cae6-b15f-beed73830fd8@virtuozzo.com>
In-Reply-To: <eece4ca2-7c40-cae6-b15f-beed73830fd8@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0021.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::34)
 To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191022134619088
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44f94e1b-a31b-4482-3256-08d756dd1378
x-ms-traffictypediagnostic: AM0PR08MB4579:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB457974F68AA0BA80DF545EC0C1680@AM0PR08MB4579.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(396003)(136003)(346002)(376002)(189003)(199004)(6486002)(7736002)(478600001)(2201001)(86362001)(66446008)(2501003)(66556008)(3846002)(6116002)(2906002)(305945005)(14454004)(25786009)(31696002)(8676002)(66476007)(71200400001)(71190400001)(81156014)(64756008)(6436002)(66946007)(8936002)(81166006)(186003)(5660300002)(229853002)(110136005)(6246003)(256004)(316002)(54906003)(14444005)(107886003)(76176011)(99286004)(52116002)(4326008)(26005)(102836004)(6506007)(386003)(66066001)(2616005)(446003)(6512007)(476003)(31686004)(486006)(11346002)(36756003)(53546011)(41533002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4579;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: npFfKgiXO9ZOL4qu39jZPWrzyjsiy2Mi694XVvl8MWLC3Dzv/lHiP9U3pXz3Zp57eiS0gkAJ8pD0+qKAwSAOjcV4ni8+mbzcR0YQslVIpmnjaW9Qm9irBg8vJGPHdbJgCv9DFg3OCWjXx/Pw57x9zJgyus5ic1xGFkc2ClbWxh9rvB6YzXDTOxDazYJyDfyAphNGGlDA76kjel6HxYTvokootJ6G+pyo7WsMw0MlWAlZ39COaEmHN1dRCIX8ZhzUGk6p5a42H7BQ3aVoqm1y25aAL/Fplo4cY/xNnjhH6DpCQvtaVnrtCEQVgkHd5MlzwipDYRiUXS/FT+RVXjwa95XB12grAQ7XQgIjnUQPJEXgtg9CHfkowSMB8LcRh7C5YzBJvOgNlnpdn0/jiQGeMEhCJYmqiHD02PAwbX31PbZzd6941BLzBSEHSi4XgGhz
Content-Type: text/plain; charset="utf-8"
Content-ID: <F54583A95AC18A4DB82672BA1BD64A79@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f94e1b-a31b-4482-3256-08d756dd1378
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 10:46:21.2568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wWA6W3jQ8lRTh60dYk5mQ+i331x0F5J06xD/4/pxv2/v28EAPepcjA0uKssg4kDoThA7jpVaO0Iso0UOrax9wMeidoaNiIGRiB8ZcKxHas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4579
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.95
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjIuMTAuMjAxOSAxMzoyMSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IA0KPiBPbiAyMi8x
MC8yMDE5IDEyOjI4LCBNYXggUmVpdHogd3JvdGU6DQo+PiBPbiAyMC4xMC4xOSAyMjozNywgQW5k
cmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+Pj4gVG8gaW5mb3JtIHRoZSBibG9jayBsYXllciBhYm91
dCB3cml0aW5nIGFsbCB0aGUgZGF0YSBjb21wcmVzc2VkLCB3ZQ0KPj4+IGludHJvZHVjZSB0aGUg
J2NvbXByZXNzJyBjb21tYW5kIGxpbmUgb3B0aW9uLiBCYXNlZCBvbiB0aGF0IG9wdGlvbiwgdGhl
DQo+Pj4gd3JpdHRlbiBkYXRhIHdpbGwgYmUgYWxpZ25lZCBieSB0aGUgY2x1c3RlciBzaXplIGF0
IHRoZSBnZW5lcmljIGxheWVyLg0KPj4+DQo+Pj4gU3VnZ2VzdGVkLWJ5OiBSb21hbiBLYWdhbiA8
cmthZ2FuQHZpcnR1b3p6by5jb20+DQo+Pj4gU3VnZ2VzdGVkLWJ5OiBWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4gU2lnbmVkLW9mZi1i
eTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+
Pj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbT4NCj4+PiAtLS0NCj4+PiAgICBibG9jay5jICAgICAgICAgICAgICAgICAg
IHwgMjAgKysrKysrKysrKysrKysrKysrKy0NCj4+PiAgICBibG9jay9pby5jICAgICAgICAgICAg
ICAgIHwgMTMgKysrKysrKysrLS0tLQ0KPj4+ICAgIGJsb2NrL3Fjb3cyLmMgICAgICAgICAgICAg
fCAgNCArKysrDQo+Pj4gICAgYmxvY2tkZXYuYyAgICAgICAgICAgICAgICB8ICA5ICsrKysrKysr
LQ0KPj4+ICAgIGluY2x1ZGUvYmxvY2svYmxvY2suaCAgICAgfCAgMSArDQo+Pj4gICAgaW5jbHVk
ZS9ibG9jay9ibG9ja19pbnQuaCB8ICAyICsrDQo+Pj4gICAgcWFwaS9ibG9jay1jb3JlLmpzb24g
ICAgICB8ICA1ICsrKystDQo+Pj4gICAgcWVtdS1vcHRpb25zLmh4ICAgICAgICAgICB8ICA2ICsr
KystLQ0KPj4+ICAgIDggZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlv
bnMoLSkNCj4+DQo+PiBUaGUgcHJvYmxlbSB3aXRoIGNvbXByZXNzaW9uIGlzIHRoYXQgdGhlcmUg
YXJlIHN1Y2ggdGlnaHQgY29uc3RyYWludHMgb24NCj4+IGl0IHRoYXQgaXQgY2FuIHJlYWxseSBv
bmx5IHdvcmsgZm9yIHZlcnkgZGVmaW5lZCB1c2UgY2FzZXMuICBUaG9zZQ0KPj4gY29uc3RyYWlu
dHMgYXJlOg0KPj4NCj4+IC0gT25seSB3cml0ZSB3aG9sZSBjbHVzdGVycywNCj4+IC0gQ2x1c3Rl
cnMgY2FuIGJlIHdyaXR0ZW4gdG8gb25seSBvbmNlLg0KPj4NCj4+IFRoZSBmaXJzdCBwb2ludCBp
cyBhZGRyZXNzZWQgaW4gdGhpcyBwYXRjaCBieSBzZXR0aW5nIHJlcXVlc3RfYWxpZ25tZW50Lg0K
Pj4gICAgQnV0IEkgZG9u4oCZdCBzZWUgaG93IHRoZSBzZWNvbmQgb25lIGNhbiBiZSBhZGRyZXNz
ZWQuICBXZWxsLCBtYXliZSBieQ0KPj4gYWxsb3dpbmcgaXQgaW4gYWxsIGRyaXZlcnMgdGhhdCBz
dXBwb3J0IGNvbXByZXNzaW9uLiAgQnV0IGlmIEkganVzdCBsb29rDQo+PiBhdCBxY293MiwgdGhh
dCBpc27igJl0IGdvaW5nIHRvIGJlIHRyaXZpYWw6IFlvdSBuZWVkIHRvIGFsbG9jYXRlIGENCj4+
IGNvbXBsZXRlbHkgbmV3IGNsdXN0ZXIgd2hlcmUgeW91IHdyaXRlIHRoZSBkYXRhIChpbiBjYXNl
IGl0IGdyb3dzKSwgYW5kDQo+PiB0aHVzIHlvdSBsZWF2ZSBiZWhpbmQgYSBob2xlLCB3aGljaCBr
aW5kIG9mIGRlZmVhdHMgdGhlIHB1cnBvc2Ugb2YNCj4+IGNvbXByZXNzaW9uLg0KPj4NCj4+IChG
b3IgZGVtb25zdHJhdGlvbjoNCj4+DQo+PiAkIC4vcWVtdS1pbWcgY3JlYXRlIC1mIHFjb3cyIHRl
c3QucWNvdzIgNjRNDQo+PiBGb3JtYXR0aW5nICd0ZXN0LnFjb3cyJywgZm10PXFjb3cyIHNpemU9
NjcxMDg4NjQgY2x1c3Rlcl9zaXplPTY1NTM2DQo+PiBsYXp5X3JlZmNvdW50cz1vZmYgcmVmY291
bnRfYml0cz0xNg0KPj4gJCB4ODZfNjQtc29mdG1tdS9xZW11LXN5c3RlbS14ODZfNjQgXA0KPj4g
ICAgICAgLWJsb2NrZGV2ICJ7J25vZGUtbmFtZSc6ICdkcnYwJywgJ2RyaXZlcic6ICdxY293Mics
DQo+PiAgICAgICAgICAgICAgICAgICAnY29tcHJlc3MnOiB0cnVlLA0KPj4gICAgICAgICAgICAg
ICAgICAgJ2ZpbGUnOiB7J2RyaXZlcic6ICdmaWxlJywgJ2ZpbGVuYW1lJzogJ3Rlc3QucWNvdzIn
fX0iIFwNCj4+ICAgICAgIC1tb25pdG9yIHN0ZGlvDQo+PiBRRU1VIDQuMS41MCBtb25pdG9yIC0g
dHlwZSAnaGVscCcgZm9yIG1vcmUgaW5mb3JtYXRpb24NCj4+IChxZW11KSBxZW11LWlvIGRydjAg
IndyaXRlIC1QIDQyIDAgNjRrIg0KPj4gd3JvdGUgNjU1MzYvNjU1MzYgYnl0ZXMgYXQgb2Zmc2V0
IDANCj4+IDY0IEtpQiwgMSBvcHM7IDAwLjAyIHNlYyAoNC4wNTUgTWlCL3NlYyBhbmQgNjQuODc5
MyBvcHMvc2VjKQ0KPj4gKHFlbXUpIHFlbXUtaW8gZHJ2MCAid3JpdGUgLVAgMjMgMCA2NGsiDQo+
PiB3cml0ZSBmYWlsZWQ6IElucHV0L291dHB1dCBlcnJvcg0KPj4NCj4+ICkNCj4+DQo+PiBDb21w
cmVzc2lvbiByZWFsbHkgb25seSB3b3JrcyB3aGVuIHlvdSBmdWxseSB3cml0ZSBhbGwgb2YgYW4g
aW1hZ2UNCj4+IGV4YWN0bHkgb25jZTsgaS5lLiBhcyB0aGUgcWVtdS1pbWcgY29udmVydCBvciBh
cyBhIGJhY2t1cCB0YXJnZXQuICBGb3INCj4+IGJvdGggY2FzZXMgd2UgYWxyZWFkeSBoYXZlIGEg
Y29tcHJlc3Npb24gb3B0aW9uLiAgU28gSeKAmW0gd29uZGVyaW5nIHdoZXJlDQo+PiB0aGlzIG5l
dyBvcHRpb24gaXMgcmVhbGx5IHVzZWZ1bC4NCj4+DQo+PiAoWW91IGRvIGFkZCBhIHRlc3QgZm9y
IHN0cmVhbSwgYnV0IEkgZG9u4oCZdCBrbm93IHdoZXRoZXIgdGhhdOKAmXMgcmVhbGx5IGENCj4+
IGdvb2QgZXhhbXBsZSwgc2VlIG15IHJlc3BvbnNlIHRoZXJlLikNCj4+DQo+PiBNYXgNCj4+DQo+
IA0KPiBUaGFuayB5b3UgdmVyeSBtdWNoIE1heCBmb3IgeW91ciBkZXRhaWxlZCByZXNwb25zZS4N
Cj4gDQo+IDEpIFlvdSBhcmUgcmlnaHQgdGhhdCBjb21wcmVzc2lvbiBpcyB1c2VkIHdpdGggdGhl
IGJhY2t1cCBtb3N0bHkuIFRoZQ0KPiBvcHRpb24gZm9yIHRoZSBjb21wcmVzc2lvbiB3aXRoIGJh
Y2t1cCB3b3VsZCBiZSByZXBsYWNlZCBieSB1c2FnZSBhdCB0aGUNCj4gYmxvY2sgbGF5ZXIsIHdp
dGggbm8gZHVwbGljYXRpb24uIEFsc28sIGl0IGNhbiBiZSB1c2VmdWwgZm9yIE5CRCBmb3INCj4g
aW5zdGFuY2UsDQo+IA0KPiAkIC4vcWVtdS1pbWcgY3JlYXRlIC1mIHFjb3cyIC1vIHNpemU9MTBH
IC4vaW1hZ2UucWNvdzINCj4gJCBzdWRvIC4vcWVtdS1uYmQgLWMgL2Rldi9uYmQwIC4vaW1hZ2Uu
cWNvdzINCj4gJCBzdWRvIGRkIGlmPS9kZXYvc2RhMSBvZj0vZGV2L25iZDAgYnM9MTBNIGNvdW50
PTEwDQo+IDEwKzAgcmVjb3JkcyBpbg0KPiAxMCswIHJlY29yZHMgb3V0DQo+IDEwNDg1NzYwMCBi
eXRlcyAoMTA1IE1CKSBjb3BpZWQsIDAsMDg5MDU4MSBzLCAxLDIgR0Ivcw0KPiAkIHN1ZG8gLi9x
ZW11LW5iZCAtZCAvZGV2L25iZDANCj4gJCBkdSAtc2ggLi9pbWFnZS5xY293Mg0KPiAxMDFNICAg
IC4vaW1hZ2UucWNvdzINCj4gDQo+IGFuZCB3aXRoIHRoZSBjb21wcmVzc2lvbg0KPiANCj4gJCAu
L3FlbXUtaW1nIGNyZWF0ZSAtZiBxY293MiAtbyBzaXplPTEwRyAuL2ltYWdlLnFjb3cyDQo+ICQg
c3VkbyAuL3FlbXUtbmJkIC1DIC1jIC9kZXYvbmJkMCAuL2ltYWdlLnFjb3cyDQo+ICQgc3VkbyBk
ZCBpZj0vZGV2L3NkYTEgb2Y9L2Rldi9uYmQwIGJzPTEwTSBjb3VudD0xMA0KPiAxMCswIHJlY29y
ZHMgaW4NCj4gMTArMCByZWNvcmRzIG91dA0KPiAxMDQ4NTc2MDAgYnl0ZXMgKDEwNSBNQikgY29w
aWVkLCAwLDA3NjA0NiBzLCAxLDQgR0Ivcw0KPiAkIHN1ZG8gLi9xZW11LW5iZCAtZCAvZGV2L25i
ZDANCj4gJCBkdSAtc2ggLi9pbWFnZS5xY293Mg0KPiA1LDNNICAgIC4vaW1hZ2UucWNvdzINCj4g
DQo+IFRoZSBpZGVhIGJlaGluZCBpbnRyb2R1Y2luZyB0aGUgbmV3ICdjb21wcmVzcycgb3B0aW9u
IGlzIHRvIHVzZSB0aGF0DQo+IG9ubHkgb25lIGluc3RlYWQgb2YgbWFueSBvdGhlciBvbmVzIG9m
IHN1Y2ggYSBraW5kLg0KPiANCj4gMikgWW91IGFyZSByaWdodCBhbHNvIHRoYXQgIkNvbXByZXNz
aW9uIGNhbid0IG92ZXJ3cml0ZSBhbnl0aGluZy4uLiINCj4gSXQgY2FuIGJlIHNlZW4gaW4gdGhl
IGNvbW1pdCBtZXNzYWdlDQo+IGIwYjY4NjJlNWUxYTEzOTRlMGFiM2Q1ZGE5NGJhOGIwZGE4NjY0
ZTINCj4gDQo+IEkgYW0gbm90IHN1cmUgaWYgZGF0YSBzaG91bGQgYmUgd3JpdHRlbiBjb21wcmVz
c2VkIHRvIHRoZSBhY3RpdmUgbGF5ZXIuDQo+IEkgbWFkZSB0aGUgdGVzdHMgd2l0aCB0aGUgaWRl
YSBvZiBicmluZ2luZyBleGFtcGxlcyBvZiB1c2FnZSB0aGUNCj4gJ2NvbXByZXNzJyBvcHRpb24g
YmVjYXVzZSBwYXNzaW5nIGFuIG9wdGlvbiBpcyBhIHRyaWNreSB0aGluZyBpbiBRRU1VLg0KPiBC
dXQgdGhlIGlzc3VlIHRha2VzIHBsYWNlIGFueXdheSBpZiB3ZSB3YW50IHRvIHJld3JpdGUgdG8g
YWxsb2NhdGVkDQo+IGNsdXN0ZXJzLg0KPiBJIHdvdWxkIGxpa2UgdG8gaW52ZXN0aWdhdGUgdGhl
IG1hdHRlciBhbmQgbWFrZSBhIHBhdGNoIHRoYXQgcmVzb2x2ZXMNCj4gdGhhdCBpc3N1ZS4NCj4g
RG8geW91IGFncmVlIHdpdGggdGhhdD8NCj4gDQo+IEFuZHJleQ0KPiANCg0KDQpZZXMsIHdlIHdh
bnQgdGhpcyBvcHRpb24gbm90IHRvIGFsbG93IGNvbXByZXNzZWQgd3JpdGVzIGZvciBndWVzdHMs
IGJ1dCB0bw0KYWxsb3cNCi0gc3RyZWFtIHdpdGggY29tcHJlc3Npb24gKHVzZWQgdG8gcmVtb3Zl
IGNvbXByZXNzZWQgaW5jcmVtZW50YWwgYmFja3VwLCB3ZQ0KbmVlZCB0byBtZXJnZSBpdCB0byB0
aGUgbmV4dCBpbmNyZW1lbnRhbCkNCi0gYmFja3VwIHdpdGggY29tcHJlc3Npb24gKHdlIGhhdmUg
YW4gb3B0aW9uYWwgYWxyZWFkeSwgc28gaXQgd29ya3MpDQotIGJhY2t1cCB0byBuYmQgc2VydmVy
IHdpdGggY29tcHJlc3Npb246IGVuYWJsZSBjb21wcmVzc2lvbiBvbiBuYmQgc2VydmVyDQoNClNv
IGluc3RlYWQgb2YgYWRkaW5nIHR3byBvcHRpb25zIChmb3Igc3RyZWFtIGFuZCBmb3IgbmJkKSwg
aXQgc2VlbXMgYmV0dGVyIHRvDQphZGQgb25seSBvbmUgZm9yIGdlbmVyaWMgbGF5ZXIuDQoNClRo
ZW4sIGl0IGJlY29tZXMgcG9zc2libGUgdG8gcnVuIGd1ZXN0IG9uIGltYWdlIHdpdGggY29tcHJl
c3M9b24uIEl0J3MgYSBzaWRlDQplZmZlY3QsIGJ1dCBzdGlsbCBpdCBzaG91bGQgd29yayBjb3Jy
ZWN0bHkuDQoNCkkgdGhpbmsgdGhlIHNpbXBsZXN0IHRoaW5nIGlzIHRvIGp1c3QgcnVuIG5vcm1h
bCB3cml0ZSwgaWYgY29tcHJlc3NlZCB3cml0ZQ0KZmFpbGVkIGJlY2F1c2Ugb2YgcmVhbGxvY2F0
aW9uLiBXZSBzaG91bGQgY2hlY2sgdGhhdCBvbiB0aGF0IGZhaWx1cmUtcGF0aA0KRU5PVFNVUCBp
cyByZXR1cm5lZCBhbmQgaGFuZGxlIGl0IGZvciBjb21wcmVzcz1vbiBvcHRpb24gYnkgZmFsbGJh
Y2sgdG8NCm5vcm1hbCB3cml0ZSBpbiBnZW5lcmljIGJsb2NrL2lvLmMNCg0KKE5vdGUsIHRoYXQg
aW4gY2FzZSB3aXRoIHN0cmVhbSB3ZSByZXdyaXRlIG9ubHkgdW5hbGxvY2F0ZWQgY2x1c3RlcnMp
DQoNCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

