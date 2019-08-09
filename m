Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8E0C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 08:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BD52086D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 08:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ab7g+HMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BD52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw0EQ-0003Fe-Pd
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 04:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37595)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw0Dz-0002ma-Me
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw0Dy-0007aE-Eo
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:26:11 -0400
Received: from mail-eopbgr20120.outbound.protection.outlook.com
 ([40.107.2.120]:17491 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hw0Dx-0007Zb-Rv; Fri, 09 Aug 2019 04:26:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0vbiSgaToloBqYIiqNeLYujan+TL9FJ19j1fKOG0yqHriplwRljbVOksi9JG1ip1rX0WgvoG9K4dkpbj7NOfTR/IhUpwCnLnhGlsv+omu+DAIpTZgPrRB/buQUI5A4Tk5CRIs3ZXseulen497HsjIIOnXopAiF73L83szjPXsOxpWxw9WDa0148oWQIj4hdH3Oqq4SU5tFnl9mFN2t/axsCa7h7MS9dSb7DyQ1p8WWHqL3n2eR6zPFvfowfUGfYqdsXMpbBBErR63TzVsFDVJSlEwJ3UeuweBMDYOejj2sW1KMadC/+oAYaAyo/hsflZWPf4+sl+6gbnTF9qqpNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkyhL1zknQqscmTt/7KAXTcWSSYg3X2/bZMkkVKWPyg=;
 b=OmtM6tjIZpJgS0J1MmzK1IH63IrNv4rcaPuuiTPB/7A0pD3d0Fobu8AaWSBM+Gl/lbEmUfjU7x4qU0FiuLR2u/Mnhn2VD/g2ZGSOayZu6S6fO6ywKPAi4JmfnFBAU4PGcsyRbME0+w5BxuKnQQ6HNtAIdXVLx03I3Vj+DDXI5xa79AGGmlk5vPAoY0NUyEdoVLAjWc9L1XKJlrDlWYLH7LmeAt+F4wOZfga4fOOs19DDZJNG9pVUAzQWfnK7HeZ9Mzi3s9fszFNtEnRKRvDMBZXtjApmoU6b3t6KgRzQVDrhOqzv3z8ovPdPAPi6H9fpPKYufIhU4y6LNDASkD7mBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkyhL1zknQqscmTt/7KAXTcWSSYg3X2/bZMkkVKWPyg=;
 b=Ab7g+HMg1MrFSqanmddDZiMjh7RuZhRylZ/yod6X2SH96jOMhfBMUxANKztKjfCJ2S9mvZMk0EK00q0iMyk85A+cx8EtRnAeTosjxytwJWtn943GQVkLSKTE+6sRXkR67o4hiWxa06hL+48EQcXb4AaaZGO58wwy9putinEc1xs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5004.eurprd08.prod.outlook.com (10.255.19.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 9 Aug 2019 08:26:07 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 08:26:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] tests/test-hbitmap: test next_zero and
 _next_dirty_area after truncate
Thread-Index: AQHVS61lVjIKiZYGV0yHDMkwqelKmKbwYleAgAIeeoA=
Date: Fri, 9 Aug 2019 08:26:07 +0000
Message-ID: <f4d13748-7b72-92b1-03c6-c3b44d31795e@virtuozzo.com>
References: <20190805164652.42409-1-vsementsov@virtuozzo.com>
 <f7d9be28-73d8-af63-55af-4ed33e17d0cb@redhat.com>
In-Reply-To: <f7d9be28-73d8-af63-55af-4ed33e17d0cb@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0014.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::24) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190809112605097
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5867a83-826f-4bac-7f80-08d71ca339e4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5004; 
x-ms-traffictypediagnostic: DB8PR08MB5004:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB50043850CDFF271D1487EE14C1D60@DB8PR08MB5004.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39850400004)(136003)(396003)(189003)(199004)(25786009)(2501003)(66066001)(6512007)(8676002)(6116002)(305945005)(31696002)(14454004)(3846002)(7736002)(11346002)(2616005)(476003)(486006)(446003)(99286004)(2906002)(54906003)(110136005)(4326008)(86362001)(36756003)(316002)(71190400001)(186003)(8936002)(6306002)(66446008)(52116002)(76176011)(66946007)(478600001)(14444005)(102836004)(31686004)(64756008)(66556008)(26005)(71200400001)(256004)(66476007)(81156014)(81166006)(107886003)(53936002)(6246003)(53546011)(229853002)(386003)(6506007)(6486002)(966005)(5660300002)(6436002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5004;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j4Rgt5RqcskHttSZDc94xVemTv9YFk01myw9pmTxtH0Rkl8Z3p3nPqksKdDlbxaTSTTQUbPUqVSnuVOJaD+/m6pXPhnSf9a4T0eTEO9phbyfAE8BuP8n2oiRbmIXR8XnOkrtStbj66BhCwVEv3TrfzoUneWON6uNDuhJUknISvfKV+Q0zO0GvBMOz6a9+MVU7Z6djJX2x3kANk2NUkD+TiIto3dSXcgz/Gq+tkDKYJUubOKrfI1MLrpiiiZQDC9PtQQpzdUwKXkQr5f6Iq5zWpkG4yryHI9n1TyB6AmgMz0vQLgydFEoAXwDohLcHJV/Dvv8RPn0NmQGcZtJKmoKzLJ1NtLePgRVtxavKuYfBqJK8HK39AJf01lbeeQluwFuC4bRGonDUmht+4FFV8LlHzXonHpUc5CvWmxTfBqE6co=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88FCB941EFD8E948A8CFB3A08A0937A2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5867a83-826f-4bac-7f80-08d71ca339e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 08:26:07.4679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DwrSStBQBff1nivHuzj3FOvXgxTrm+891t9syzLGFPC6g7NsDgpkdZ6AWR1N3B2CppQQFsU4wM5LNDToM1G1KRJt+sAQqunENdt4ZXMUaQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5004
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.120
Subject: Re: [Qemu-devel] [PATCH] tests/test-hbitmap: test next_zero and
 _next_dirty_area after truncate
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMDguMjAxOSAzOjA0LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gOC81LzE5IDEy
OjQ2IFBNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gVGVzdCB0aGF0
IGhiaXRtYXBfbmV4dF96ZXJvIGFuZCBoYml0bWFwX25leHRfZGlydHlfYXJlYSBjYW4gZmluZCB0
aGluZ3MNCj4+IGFmdGVyIG9sZCBiaXRtYXAgZW5kLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+
IC0tLQ0KPj4NCj4+IEl0J3MgYSBmb2xsb3ctdXAgZm9yDQo+Pg0KPj4gICAgICBbUEFUQ0ggZm9y
LTQuMV0gdXRpbC9oYml0bWFwOiB1cGRhdGUgb3JpZ19zaXplIG9uIHRydW5jYXRlDQo+Pg0KPj4g
ICB0ZXN0cy90ZXN0LWhiaXRtYXAuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKysNCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVz
dHMvdGVzdC1oYml0bWFwLmMgYi90ZXN0cy90ZXN0LWhiaXRtYXAuYw0KPj4gaW5kZXggNTkyZDgy
MTlkYi4uZWVkNWQyODhjYiAxMDA2NDQNCj4+IC0tLSBhL3Rlc3RzL3Rlc3QtaGJpdG1hcC5jDQo+
PiArKysgYi90ZXN0cy90ZXN0LWhiaXRtYXAuYw0KPj4gQEAgLTEwMDQsNiArMTAwNCwxNSBAQCBz
dGF0aWMgdm9pZCB0ZXN0X2hiaXRtYXBfbmV4dF96ZXJvXzQoVGVzdEhCaXRtYXBEYXRhICpkYXRh
LCBjb25zdCB2b2lkICp1bnVzZWQpDQo+PiAgICAgICB0ZXN0X2hiaXRtYXBfbmV4dF96ZXJvX2Rv
KGRhdGEsIDQpOw0KPj4gICB9DQo+PiAgIA0KPj4gK3N0YXRpYyB2b2lkIHRlc3RfaGJpdG1hcF9u
ZXh0X3plcm9fYWZ0ZXJfdHJ1bmNhdGUoVGVzdEhCaXRtYXBEYXRhICpkYXRhLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9pZCAq
dW51c2VkKQ0KPj4gK3sNCj4+ICsgICAgaGJpdG1hcF90ZXN0X2luaXQoZGF0YSwgTDEsIDApOw0K
Pj4gKyAgICBoYml0bWFwX3Rlc3RfdHJ1bmNhdGVfaW1wbChkYXRhLCBMMSAqIDIpOw0KPj4gKyAg
ICBoYml0bWFwX3NldChkYXRhLT5oYiwgMCwgTDEpOw0KPj4gKyAgICB0ZXN0X2hiaXRtYXBfbmV4
dF96ZXJvX2NoZWNrKGRhdGEsIDApOw0KPj4gK30NCj4+ICsNCj4+ICAgc3RhdGljIHZvaWQgdGVz
dF9oYml0bWFwX25leHRfZGlydHlfYXJlYV9jaGVjayhUZXN0SEJpdG1hcERhdGEgKmRhdGEsDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0
X3Qgb2Zmc2V0LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQ2NF90IGNvdW50KQ0KPj4gQEAgLTExMDQsNiArMTExMywxNSBAQCBzdGF0aWMg
dm9pZCB0ZXN0X2hiaXRtYXBfbmV4dF9kaXJ0eV9hcmVhXzQoVGVzdEhCaXRtYXBEYXRhICpkYXRh
LA0KPj4gICAgICAgdGVzdF9oYml0bWFwX25leHRfZGlydHlfYXJlYV9kbyhkYXRhLCA0KTsNCj4+
ICAgfQ0KPj4gICANCj4+ICtzdGF0aWMgdm9pZCB0ZXN0X2hiaXRtYXBfbmV4dF9kaXJ0eV9hcmVh
X2FmdGVyX3RydW5jYXRlKFRlc3RIQml0bWFwRGF0YSAqZGF0YSwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHZvaWQgKnVu
dXNlZCkNCj4+ICt7DQo+PiArICAgIGhiaXRtYXBfdGVzdF9pbml0KGRhdGEsIEwxLCAwKTsNCj4+
ICsgICAgaGJpdG1hcF90ZXN0X3RydW5jYXRlX2ltcGwoZGF0YSwgTDEgKiAyKTsNCj4+ICsgICAg
aGJpdG1hcF9zZXQoZGF0YS0+aGIsIEwxICsgMSwgMSk7DQo+PiArICAgIHRlc3RfaGJpdG1hcF9u
ZXh0X2RpcnR5X2FyZWFfY2hlY2soZGF0YSwgMCwgVUlOVDY0X01BWCk7DQo+PiArfQ0KPj4gKw0K
Pj4gICBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+PiAgIHsNCj4+ICAgICAgIGdf
dGVzdF9pbml0KCZhcmdjLCAmYXJndiwgTlVMTCk7DQo+PiBAQCAtMTE2OSw2ICsxMTg3LDggQEAg
aW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICB0ZXN0X2hiaXRtYXBfbmV4dF96ZXJvXzApOw0KPj4gICAgICAgaGJpdG1hcF90ZXN0X2FkZCgi
L2hiaXRtYXAvbmV4dF96ZXJvL25leHRfemVyb180IiwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgdGVzdF9oYml0bWFwX25leHRfemVyb180KTsNCj4+ICsgICAgaGJpdG1hcF90ZXN0X2FkZCgi
L2hiaXRtYXAvbmV4dF96ZXJvL25leHRfemVyb19hZnRlcl90cnVuY2F0ZSIsDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgdGVzdF9oYml0bWFwX25leHRfemVyb19hZnRlcl90cnVuY2F0ZSk7DQo+
PiAgIA0KPj4gICAgICAgaGJpdG1hcF90ZXN0X2FkZCgiL2hiaXRtYXAvbmV4dF9kaXJ0eV9hcmVh
L25leHRfZGlydHlfYXJlYV8wIiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgdGVzdF9oYml0
bWFwX25leHRfZGlydHlfYXJlYV8wKTsNCj4+IEBAIC0xMTc2LDYgKzExOTYsOCBAQCBpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIHRlc3Rf
aGJpdG1hcF9uZXh0X2RpcnR5X2FyZWFfMSk7DQo+PiAgICAgICBoYml0bWFwX3Rlc3RfYWRkKCIv
aGJpdG1hcC9uZXh0X2RpcnR5X2FyZWEvbmV4dF9kaXJ0eV9hcmVhXzQiLA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICB0ZXN0X2hiaXRtYXBfbmV4dF9kaXJ0eV9hcmVhXzQpOw0KPj4gKyAgICBo
Yml0bWFwX3Rlc3RfYWRkKCIvaGJpdG1hcC9uZXh0X2RpcnR5X2FyZWEvbmV4dF9kaXJ0eV9hcmVh
X2FmdGVyX3RydW5jYXRlIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICB0ZXN0X2hiaXRtYXBf
bmV4dF9kaXJ0eV9hcmVhX2FmdGVyX3RydW5jYXRlKTsNCj4+ICAgDQo+PiAgICAgICBnX3Rlc3Rf
cnVuKCk7DQo+PiAgIA0KPj4NCj4gDQo+IFRlc3RlZC1ieTogSm9obiBTbm93IDxqc25vd0ByZWRo
YXQuY29tPg0KPiBSZXZpZXdlZC1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPiAN
Cj4gQW5kIHN0YWdlZDoNCj4gDQo+IFRoYW5rcywgYXBwbGllZCB0byBteSBiaXRtYXBzIHRyZWU6
DQo+IA0KPiBodHRwczovL2dpdGh1Yi5jb20vam5zbm93L3FlbXUvY29tbWl0cy9iaXRtYXBzDQoN
ClRoYW5rcyEgSG1tIGJ1dCBJIGRvbid0IHNlZSB0aGUgcGF0Y2ggYXQgdGhpcyBsaW5rLCBuZWl0
aGVyIDAxIGFuZCAwMyBmcm9tDQoiW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzNdIGJhY2t1cCBmaXhl
cyBmb3IgNC4xPyIuLi4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

