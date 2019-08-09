Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5F8C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16686208C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S4rwoLgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16686208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvzjj-0000ZP-8S
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 03:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59734)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvzjH-0008RM-Ed
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 03:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvzjG-0003CE-8N
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 03:54:27 -0400
Received: from mail-eopbgr00102.outbound.protection.outlook.com
 ([40.107.0.102]:9685 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvzjF-0003Bf-VN; Fri, 09 Aug 2019 03:54:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exX3+dfgmQol9KgPtDg5OMzlCx8XKVUEsmP2Glguy8+4cbMm17wE3jcksmysfbf7O7NLywvzuDbtHS5/isc18WtERHtnf4niFx9Pd2TUkP27veCqKvxf/+HWWZlGR3Ejs4D21M//9p67fQ6wcgs452rYWcMFV9P1kof01/rrhkyEju5qBn3DZM51oJDPVKkGxSC84253L3gNx3wa56nfMU63q7SiSmkmPVUu/JSDi2p/sa975lJZkddcVlZl1xOjgGA2SsQbZY3mXdk6qO6dcKIZP/JmI1+UabCZMhH5rzWRnKkHJqdf1DKGEX91bcG6FG3KLXM7EDFbKvemURgfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWdjLt9q1Q7pSFDfrz16Mh4nrESXPtG3EHnXCIH2veU=;
 b=U+KO374gz5l/cJWkMUq0N3lQYnEmuLn4rD2ymQdCUliyhdtc5Ksk9LTYTkbBbHxQ41yeTiSOB9Bfv1AjghpdI9nJ/7BRLQXVmZ9MLP05h36aVtU89fA5H28pfu2tlkuGgCbp/UK2fwJ31gXZ84kDLKcLGf3SNoKKB9RGvvodSgYwD+1Ia0N3ByRHGSfgDEnqmonO2BjP7H73ihKVC6iAoI849UEkK/T8uWMUC6VOKE9VMyxNCfgtNOBfmqdqqTc3Yz2h3dAvAVBsIUWGcmeL5i8rTLxPNztTnxHXIg60cwGclkL2DQL84v346YYIYWFQX6NGva9LG/xNw4k5VrO+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWdjLt9q1Q7pSFDfrz16Mh4nrESXPtG3EHnXCIH2veU=;
 b=S4rwoLgH4soxypfBTlhE6JmUZIQ+ZYbgcuFd4iuk/63pX54c22upO4StyC5rRuPw8dV6oIN6fVVctieLpB5rr5xIS21VfuVBRwIdpH/yTRNdAt4iYuDdn7hAZvSt2bLwTYqUskKyZXb/MCFLcMBz+uXEAC3S4891Hml1YMnRFgE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5002.eurprd08.prod.outlook.com (10.255.17.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 9 Aug 2019 07:54:22 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 07:54:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 8/8] block/backup: backup_do_cow: use
 bdrv_dirty_bitmap_next_dirty_area
Thread-Index: AQHVTPc5PQtWgpxcJkOaMxPOkjggNqbwBuWAgAJueIA=
Date: Fri, 9 Aug 2019 07:54:21 +0000
Message-ID: <1695f5ec-0016-6768-1520-25ab6bf5d8ef@virtuozzo.com>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-9-vsementsov@virtuozzo.com>
 <bf5dc465-6dce-8a8c-86d0-322adda769a8@redhat.com>
In-Reply-To: <bf5dc465-6dce-8a8c-86d0-322adda769a8@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0323.eurprd05.prod.outlook.com
 (2603:10a6:7:92::18) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190809105419285
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37fee2f4-dea5-4088-258b-08d71c9eca2e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5002; 
x-ms-traffictypediagnostic: DB8PR08MB5002:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5002C67C610400DEA7FDF08EC1D60@DB8PR08MB5002.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:117;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(39850400004)(346002)(366004)(376002)(189003)(199004)(6246003)(7736002)(5660300002)(107886003)(478600001)(53936002)(6436002)(14454004)(36756003)(4326008)(99286004)(229853002)(31686004)(25786009)(6512007)(52116002)(66556008)(8676002)(3846002)(14444005)(256004)(66446008)(76176011)(26005)(6116002)(54906003)(486006)(110136005)(66476007)(81156014)(81166006)(64756008)(316002)(305945005)(6486002)(2501003)(446003)(66946007)(66066001)(102836004)(6506007)(386003)(8936002)(53546011)(31696002)(86362001)(186003)(71190400001)(71200400001)(2906002)(2616005)(11346002)(476003)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5002;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zTclBsT1ssk4LIeki0x/rKXd9sesTJE77UBveZj7Vumi0zMCzLL+DWDSbHpXLd27SvjUuekZ23pb+PcJXc+/mxnkbbo+STtHbTlQiC9VkNRZy07QDLfoO8ujlSKbEfz+MtmzsAQWwpao3W8YlJ2GlJeTRi4Kf8JXjzI3ErrAw2aCNddSxVeRuQ8nVF3WX28bsRNp6jQNysywZ9TmozQZxzeuas3E9LlEAw4wDK/gVxa98ognPkjs21ygmQJdB7OXHbPmrkRTVT5Ocnr0FJDvAOOw6srmWjLda+lI+UsAHGWp1uOeA6akU3J9CcSxspe6Ma43GpXxp3wpIMEEWWBlqOy433VjZajcau4yPgHwrZjeJd9cvizyizdEdMQznBa8cNokmJcg1BWDr7Vze6JQ7ouQXk+Rbyz+PCfaGgecri8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B099F905E956F04EAB8146C53C1FE82C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fee2f4-dea5-4088-258b-08d71c9eca2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 07:54:22.0078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nt7gt491d3CvAa4H3i3OvuGKz8XvsbEWYQBI/45/fOQ5FJ+W40Sm+m7CnZvtIl1dPWFKtNCucCkHNk9l+oCgd9uzESbaMamA73ujK4GZBaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5002
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.102
Subject: Re: [Qemu-devel] [PATCH 8/8] block/backup: backup_do_cow: use
 bdrv_dirty_bitmap_next_dirty_area
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMDguMjAxOSAyMTo0NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwNy4wOC4xOSAxMDowNywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFVzZSBlZmZlY3RpdmUgYmRy
dl9kaXJ0eV9iaXRtYXBfbmV4dF9kaXJ0eV9hcmVhIGludGVyZmFjZS4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6
by5jb20+DQo+PiAtLS0NCj4+ICAgYmxvY2svYmFja3VwLmMgfCA1NiArKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MjQgaW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Js
b2NrL2JhY2t1cC5jIGIvYmxvY2svYmFja3VwLmMNCj4+IGluZGV4IGYxOWM5MTk1ZmUuLjVlZGUw
YzgyOTAgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9iYWNrdXAuYw0KPj4gKysrIGIvYmxvY2svYmFj
a3VwLmMNCj4+IEBAIC0yMzUsMjUgKzIzNSwyOCBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBi
YWNrdXBfZG9fY293KEJhY2t1cEJsb2NrSm9iICpqb2IsDQo+PiAgIHsNCj4+ICAgICAgIENvd1Jl
cXVlc3QgY293X3JlcXVlc3Q7DQo+PiAgICAgICBpbnQgcmV0ID0gMDsNCj4+IC0gICAgaW50NjRf
dCBzdGFydCwgZW5kOyAvKiBieXRlcyAqLw0KPj4gKyAgICB1aW50NjRfdCBvZmYsIGN1cl9ieXRl
czsNCj4+ICsgICAgaW50NjRfdCBhbGlnbmVkX29mZnNldCwgYWxpZ25lZF9ieXRlcywgYWxpZ25l
ZF9lbmQ7DQo+PiAgICAgICBCZHJ2UmVxdWVzdEZsYWdzIHJlYWRfZmxhZ3MgPQ0KPj4gICAgICAg
ICAgICAgICBpc193cml0ZV9ub3RpZmllciA/IEJEUlZfUkVRX05PX1NFUklBTElTSU5HIDogMDsN
Cj4+ICAgDQo+PiAgICAgICBxZW11X2NvX3J3bG9ja19yZGxvY2soJmpvYi0+Zmx1c2hfcndsb2Nr
KTsNCj4+ICAgDQo+PiAtICAgIHN0YXJ0ID0gUUVNVV9BTElHTl9ET1dOKG9mZnNldCwgam9iLT5j
bHVzdGVyX3NpemUpOw0KPj4gLSAgICBlbmQgPSBRRU1VX0FMSUdOX1VQKGJ5dGVzICsgb2Zmc2V0
LCBqb2ItPmNsdXN0ZXJfc2l6ZSk7DQo+PiArICAgIGFsaWduZWRfb2Zmc2V0ID0gUUVNVV9BTElH
Tl9ET1dOKG9mZnNldCwgam9iLT5jbHVzdGVyX3NpemUpOw0KPj4gKyAgICBhbGlnbmVkX2VuZCA9
IFFFTVVfQUxJR05fVVAoYnl0ZXMgKyBvZmZzZXQsIGpvYi0+Y2x1c3Rlcl9zaXplKTsNCj4+ICsg
ICAgYWxpZ25lZF9ieXRlcyA9IGFsaWduZWRfZW5kIC0gYWxpZ25lZF9vZmZzZXQ7DQo+PiAgIA0K
Pj4gLSAgICB0cmFjZV9iYWNrdXBfZG9fY293X2VudGVyKGpvYiwgc3RhcnQsIG9mZnNldCwgYnl0
ZXMpOw0KPj4gKyAgICB0cmFjZV9iYWNrdXBfZG9fY293X2VudGVyKGpvYiwgYWxpZ25lZF9vZmZz
ZXQsIG9mZnNldCwgYnl0ZXMpOw0KPj4gICANCj4+IC0gICAgd2FpdF9mb3Jfb3ZlcmxhcHBpbmdf
cmVxdWVzdHMoam9iLCBzdGFydCwgZW5kKTsNCj4+IC0gICAgY293X3JlcXVlc3RfYmVnaW4oJmNv
d19yZXF1ZXN0LCBqb2IsIHN0YXJ0LCBlbmQpOw0KPj4gKyAgICB3YWl0X2Zvcl9vdmVybGFwcGlu
Z19yZXF1ZXN0cyhqb2IsIGFsaWduZWRfb2Zmc2V0LCBhbGlnbmVkX2VuZCk7DQo+PiArICAgIGNv
d19yZXF1ZXN0X2JlZ2luKCZjb3dfcmVxdWVzdCwgam9iLCBhbGlnbmVkX29mZnNldCwgYWxpZ25l
ZF9lbmQpOw0KPj4gICANCj4+ICAgICAgIGlmIChqb2ItPmluaXRpYWxpemluZ19iaXRtYXApIHsN
Cj4+IC0gICAgICAgIGludDY0X3Qgb2ZmLCBjaHVuazsNCj4+ICsgICAgICAgIGludDY0X3QgY2h1
bms7DQo+PiAgIA0KPj4gLSAgICAgICAgZm9yIChvZmYgPSBvZmZzZXQ7IG9mZnNldCA8IGVuZDsg
b2Zmc2V0ICs9IGNodW5rKSB7DQo+PiAtICAgICAgICAgICAgcmV0ID0gYmFja3VwX2JpdG1hcF9y
ZXNldF91bmFsbG9jYXRlZChqb2IsIG9mZiwgZW5kIC0gb2ZmLCAmY2h1bmspOw0KPj4gKyAgICAg
ICAgZm9yIChvZmYgPSBhbGlnbmVkX29mZnNldDsgb2ZmIDwgYWxpZ25lZF9lbmQ7IG9mZiArPSBj
aHVuaykgew0KPj4gKyAgICAgICAgICAgIHJldCA9IGJhY2t1cF9iaXRtYXBfcmVzZXRfdW5hbGxv
Y2F0ZWQoam9iLCBvZmYsIGFsaWduZWRfZW5kIC0gb2ZmLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmNodW5rKTsNCj4+ICAgICAgICAgICAg
ICAgaWYgKHJldCA8IDApIHsNCj4+ICAgICAgICAgICAgICAgICAgIGNodW5rID0gam9iLT5jbHVz
dGVyX3NpemU7DQo+PiAgICAgICAgICAgICAgIH0NCj4+IEBAIC0yNjEsNDcgKzI2NCwzNiBAQCBz
dGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNrdXBfZG9fY293KEJhY2t1cEJsb2NrSm9iICpqb2Is
DQo+PiAgICAgICB9DQo+PiAgICAgICByZXQgPSAwOw0KPj4gICANCj4+IC0gICAgd2hpbGUgKHN0
YXJ0IDwgZW5kKSB7DQo+PiAtICAgICAgICBpbnQ2NF90IGRpcnR5X2VuZDsNCj4+IC0gICAgICAg
IGludDY0X3QgY3VyX2J5dGVzOw0KPj4gLQ0KPj4gLSAgICAgICAgaWYgKCFiZHJ2X2RpcnR5X2Jp
dG1hcF9nZXQoam9iLT5jb3B5X2JpdG1hcCwgc3RhcnQpKSB7DQo+PiAtICAgICAgICAgICAgdHJh
Y2VfYmFja3VwX2RvX2Nvd19za2lwKGpvYiwgc3RhcnQpOw0KPj4gLSAgICAgICAgICAgIHN0YXJ0
ICs9IGpvYi0+Y2x1c3Rlcl9zaXplOw0KPj4gLSAgICAgICAgICAgIGNvbnRpbnVlOyAvKiBhbHJl
YWR5IGNvcGllZCAqLw0KPj4gLSAgICAgICAgfQ0KPj4gLQ0KPj4gLSAgICAgICAgZGlydHlfZW5k
ID0gYmRydl9kaXJ0eV9iaXRtYXBfbmV4dF96ZXJvKGpvYi0+Y29weV9iaXRtYXAsIHN0YXJ0LA0K
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVuZCAt
IHN0YXJ0KTsNCj4+IC0gICAgICAgIGlmIChkaXJ0eV9lbmQgPCAwKSB7DQo+PiAtICAgICAgICAg
ICAgZGlydHlfZW5kID0gZW5kOw0KPj4gLSAgICAgICAgfQ0KPj4gLQ0KPj4gLSAgICAgICAgdHJh
Y2VfYmFja3VwX2RvX2Nvd19wcm9jZXNzKGpvYiwgc3RhcnQpOw0KPj4gLSAgICAgICAgY3VyX2J5
dGVzID0gTUlOKGRpcnR5X2VuZCAtIHN0YXJ0LCBqb2ItPmxlbiAtIHN0YXJ0KTsNCj4+IC0gICAg
ICAgIGJkcnZfcmVzZXRfZGlydHlfYml0bWFwKGpvYi0+Y29weV9iaXRtYXAsIHN0YXJ0LCBkaXJ0
eV9lbmQgLSBzdGFydCk7DQo+PiArICAgIG9mZiA9IGFsaWduZWRfb2Zmc2V0Ow0KPj4gKyAgICBj
dXJfYnl0ZXMgPSBhbGlnbmVkX2J5dGVzOw0KPj4gKyAgICB3aGlsZSAoYmRydl9kaXJ0eV9iaXRt
YXBfbmV4dF9kaXJ0eV9hcmVhKGpvYi0+Y29weV9iaXRtYXAsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm9mZiwgJmN1cl9ieXRlcykpDQo+PiArICAg
IHsNCj4+ICsgICAgICAgIHRyYWNlX2JhY2t1cF9kb19jb3dfcHJvY2Vzcyhqb2IsIG9mZik7DQo+
PiArICAgICAgICBiZHJ2X3Jlc2V0X2RpcnR5X2JpdG1hcChqb2ItPmNvcHlfYml0bWFwLCBvZmYs
IGN1cl9ieXRlcyk7DQo+PiAgIA0KPj4gICAgICAgICAgIGlmIChqb2ItPnVzZV9jb3B5X3Jhbmdl
KSB7DQo+PiAtICAgICAgICAgICAgcmV0ID0gYmFja3VwX2Nvd193aXRoX29mZmxvYWQoam9iLCBz
dGFydCwgY3VyX2J5dGVzLCByZWFkX2ZsYWdzKTsNCj4+ICsgICAgICAgICAgICByZXQgPSBiYWNr
dXBfY293X3dpdGhfb2ZmbG9hZChqb2IsIG9mZiwgY3VyX2J5dGVzLCByZWFkX2ZsYWdzKTsNCj4+
ICAgICAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4+ICAgICAgICAgICAgICAgICAgIGpvYi0+
dXNlX2NvcHlfcmFuZ2UgPSBmYWxzZTsNCj4+ICAgICAgICAgICAgICAgfQ0KPj4gICAgICAgICAg
IH0NCj4+ICAgICAgICAgICBpZiAoIWpvYi0+dXNlX2NvcHlfcmFuZ2UpIHsNCj4+IC0gICAgICAg
ICAgICByZXQgPSBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihqb2IsIHN0YXJ0LCBjdXJf
Ynl0ZXMsDQo+PiArICAgICAgICAgICAgcmV0ID0gYmFja3VwX2Nvd193aXRoX2JvdW5jZV9idWZm
ZXIoam9iLCBvZmYsIGN1cl9ieXRlcywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmVhZF9mbGFncywgZXJyb3JfaXNfcmVhZCk7DQo+PiAgICAg
ICAgICAgfQ0KPj4gICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+PiAtICAgICAgICAgICAgYmRy
dl9zZXRfZGlydHlfYml0bWFwKGpvYi0+Y29weV9iaXRtYXAsIHN0YXJ0LCBkaXJ0eV9lbmQgLSBz
dGFydCk7DQo+PiArICAgICAgICAgICAgYmRydl9zZXRfZGlydHlfYml0bWFwKGpvYi0+Y29weV9i
aXRtYXAsIG9mZiwgY3VyX2J5dGVzKTsNCj4+ICAgICAgICAgICAgICAgYnJlYWs7DQo+PiAgICAg
ICAgICAgfQ0KPj4gICANCj4+ICAgICAgICAgICAvKiBQdWJsaXNoIHByb2dyZXNzLCBndWVzdCBJ
L08gY291bnRzIGFzIHByb2dyZXNzIHRvby4gIE5vdGUgdGhhdCB0aGUNCj4+ICAgICAgICAgICAg
KiBvZmZzZXQgZmllbGQgaXMgYW4gb3BhcXVlIHByb2dyZXNzIHZhbHVlLCBpdCBpcyBub3QgYSBk
aXNrIG9mZnNldC4NCj4+ICAgICAgICAgICAgKi8NCj4+IC0gICAgICAgIHN0YXJ0ICs9IGN1cl9i
eXRlczsNCj4+ICsgICAgICAgIG9mZiArPSBjdXJfYnl0ZXM7DQo+PiAgICAgICAgICAgam9iLT5i
eXRlc19yZWFkICs9IGN1cl9ieXRlczsNCj4+ICAgICAgICAgICBqb2JfcHJvZ3Jlc3NfdXBkYXRl
KCZqb2ItPmNvbW1vbi5qb2IsIGN1cl9ieXRlcyk7DQo+PiArICAgICAgICBjdXJfYnl0ZXMgPSBv
ZmZzZXQgKyBieXRlcyAtIG9mZjsNCj4gDQo+IEhtLCB3aHkgbm90IGFsaWduZWRfZW5kIC0gb2Zm
Pw0KPiANCj4gKFlvdSBjb3VsZCBhbHNvIGRyb3AgYWxpZ25lZF9ieXRlcyBhbHRvZ2V0aGVyIGFu
ZCBhbHdheXMgc2V0IGN1cl9ieXRlcw0KPiB0byBhbGlnbmVkX2VuZCAtIG9mZi4pDQo+IA0KDQpI
bW0sIHJpZ2h0Lg0KDQpUaGFuayB5b3UgZm9yIHJldmlld2luZyENCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K

