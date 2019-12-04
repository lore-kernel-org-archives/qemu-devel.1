Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0528FC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F732084F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f2ZpnmJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F732084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icW9v-00083p-QB
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icW7x-0006nm-0r
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icW7v-0006vH-Lc
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:59:40 -0500
Received: from mail-eopbgr60100.outbound.protection.outlook.com
 ([40.107.6.100]:27623 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icW7u-0006kF-UT
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:59:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtX/LacuAXA6kQjwJ6udZ/ALu+TVU8i6LArvJNG8ud1C1Z8pyvvOksVlPgfvl7+nO9LclkUhLMnFsLNI+I5EWdgIJWgtgz9fa8YPv0/QMGcSqQXXCmKLuR3wjy+DVuG4k8ykeEMTF0FCkvTUSxOD4BtRlqGoeFSUscvw6CL+k5/sD9snJ3HdEJAOdH+Dzf9SRNj3vSrJ5kppKB43+Pi5xtYtmu4azpnJCZvKjeb6Hy3JN6F7ShxZc/yTc6q+XclEYWpXoUek0wqYwPJFYmZUmKEsTincezsi1a+xur/1ZObnkX6EaVFVbqEcAO6voM2vEcAzIhb+U0d+DXyDcFCdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc2Kb/Od6fdZ1kqrt9OvbGfHv1447nRid7Wcdcnypvo=;
 b=L8+f5WJmXOQAGbdkEuogIwpRRS0uB5MahGAkabAzqXsleNuFhRf3wbGiHLT/3YhVzTliMCtjDizQrG7dNQ7eImw7uHBkR6CeFV2uvicdCEGH6LnJiconxF9Ye+aKLUjEFpG0cmwWsfkBOekyemqI/6rB2VMo40CiQ3cbOWn4oWtfl5mcjkUXloOlWijO8dkFmp2abNAILwluX9LGK1ONIr0PEaICQenYGocFnSL5dmb8EGv8wPJrPrT0WyynoB70j6xGRSRRots2rUlm416OPg77AYHgK1mio/ptPAE74tqc0aHjkGjq9DbQhZveSv96BxlwugOxKtQOYRYFUTS0Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc2Kb/Od6fdZ1kqrt9OvbGfHv1447nRid7Wcdcnypvo=;
 b=f2ZpnmJF2X+FjgdnN1CpcsPzxUg4e2wagjAqP/6sJQ6RaRFzrwaYzM2mDczM6Ra7kD9HMOuFUSuBBbCNySh6yNYuqXKmmYmGCO138LxuL5l7Likjn2y824XEY2ZTtGjVCyDdoBUXE/87L92ZGp2r5MWyrWyWIvvW9JoaGD9hzzw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4360.eurprd08.prod.outlook.com (20.179.4.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Wed, 4 Dec 2019 14:59:36 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 14:59:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6] error: rename errp to errp_in where it is IN-argument
Thread-Topic: [PATCH v6] error: rename errp to errp_in where it is IN-argument
Thread-Index: AQHVpVGz6p/zLL3Qt0SjF9DL93KD5KegpCn6gAAIsQCAAF2o1YAAyNqAgABmf2CAAAlkAIAAD11ngAepOA6AACBpAA==
Date: Wed, 4 Dec 2019 14:59:36 +0000
Message-ID: <d1a58207-604b-e6bc-c2c3-a30e692c880a@virtuozzo.com>
References: <20191127183704.14825-1-vsementsov@virtuozzo.com>
 <878so05bca.fsf@dusky.pond.sub.org>
 <f901e0db-61df-898f-ce18-096bfeadf525@virtuozzo.com>
 <87mucf218w.fsf@dusky.pond.sub.org>
 <80e563ee-31fb-da43-ddde-c8666e4b92c6@virtuozzo.com>
 <87eexqda3c.fsf@dusky.pond.sub.org>
 <41f32448-f2b8-1822-25df-f02c61df9bc4@virtuozzo.com>
 <878snybrf7.fsf@dusky.pond.sub.org> <87blsob5uq.fsf@dusky.pond.sub.org>
In-Reply-To: <87blsob5uq.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::17)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191204175934587
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5472744d-8253-44ac-d16a-08d778ca942e
x-ms-traffictypediagnostic: AM6PR08MB4360:
x-microsoft-antispam-prvs: <AM6PR08MB4360E1DB0604054A5FAB25B1C15D0@AM6PR08MB4360.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(346002)(39840400004)(376002)(136003)(199004)(189003)(6512007)(36756003)(6486002)(229853002)(6916009)(66946007)(186003)(3846002)(26005)(31686004)(8676002)(8936002)(4326008)(102836004)(6506007)(6246003)(71200400001)(71190400001)(66556008)(6116002)(6436002)(81166006)(66476007)(66446008)(76176011)(52116002)(64756008)(25786009)(81156014)(5660300002)(99286004)(316002)(54906003)(7736002)(478600001)(305945005)(2906002)(2616005)(11346002)(14454004)(31696002)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4360;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H0M/xCzdrqADqpxm0VH3JAe8v4+c73Gp46o8rN6VTNPffcGfLtB5kuSAWhVP7fuQrZVFGmgbu0NaE0pIDskbPdFazp9vf5ovZTdExDCwudeNGumxYcLDffYhgWUqw1E516eC2OrElZI0okryak5oWsXFtHZYH+0q0qT2dGY61AJd2h8rfaJsubbKDBNByFN/rmS9EN3QhMqFLz6GX7mly5y4pzKp7vWsedaGuDf6LMq4IG5d+7efIcri8E7PDsFobylgG6yO8ARe7hoXRMZQs3mkLBcVd7bftlRYP9HmuDCvO2TSYweX4++h933v/k006xrdpaO9LRRDujpw/Ogm4umYKdmBrV/iPfpnLzZa2js7Qiy/fotO3LIEgRDnqVN8Aiqt+k4Ij1CgBtCqCO6y5VcOyYsOIsO5ixgYqQ+lklx/7oIZcWgHJKDbbjpFPabV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <69D2FD7758FEB04AACA439C888AB47FB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5472744d-8253-44ac-d16a-08d778ca942e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 14:59:36.4005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fXTPfOVdcPXdCJB4OCpRxLG/UOtMEv2pQ+ua1TLtv7RibYbuIWTdQf30HWgNuiV7ZP4JnLWq9mkwYVSqCC7qIF+CXyhYD+Ll7ozs3MufnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4360
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.100
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
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDQuMTIuMjAxOSAxNjowMywgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IE1hcmt1cyBBcm1i
cnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4gd3JpdGVzOg0KPiANCj4+IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPj4NCj4+
PiAyOS4xMS4yMDE5IDE3OjM1LCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4gWy4uLl0NCj4+
Pj4gSSBwdXNoZWQgbXkgZml4dXBzIHRvIGdpdDovL3JlcG8ub3IuY3ovcWVtdS9hcm1icnUuZ2l0
IGJyYW5jaCBlcnJvci1wcmVwDQo+Pj4+IGZvciB5b3VyIGNvbnZlbmllbmNlLiAgVGhlIGNvbW1p
dCBtZXNzYWdlcyBvZiB0aGUgZml4ZWQgdXAgY29tbWl0cyBuZWVkDQo+Pj4+IHJlcGhyYXNpbmcs
IG9mIGNvdXJzZS4NCj4+Pj4NCj4+Pg0KPj4+IExvb2tlZCB0aHJvdWdoIGZpeHVwcywgbG9va3Mg
T0sgZm9yIG1lLCB0aGFua3MhIFdoYXQgbmV4dD8NCj4+DQo+PiBMZXQgbWUgZmluaXNoIG15IGZp
eGluZyBpbmNvcnJlY3QgZGVyZWZlcmVuY2VzIG9mIGVycnAsIGFuZCB0aGVuIHdlDQo+PiBmaWd1
cmUgb3V0IHdoYXQgdG8gaW5jbHVkZSBpbiB2Ny4NCj4gDQo+IFlvdXIgdjYgd2l0aCBteSBmaXh1
cHMgZG9lcyBub3QgY29uZmxpY3Qgd2l0aCBteSAiW1BBVENIIHYyIDAwLzE4XSBFcnJvcg0KPiBo
YW5kbGluZyBmaXhlcyIsIGV4Y2VwdCBmb3IgImh3L2NvcmUvbG9hZGVyLWZpdDogZml4IGZyZWVp
bmcgZXJycCBpbg0KPiBmaXRfbG9hZF9mZHQiLCB3aGljaCBteSAiW1BBVENIIHYyIDA3LzE4XSBo
dy9jb3JlOiBGaXggZml0X2xvYWRfZmR0KCkNCj4gZXJyb3IgaGFuZGxpbmcgdmlvbGF0aW9ucyIg
c3VwZXJzZWRlcy4NCj4gDQo+IFN1Z2dlc3QgeW91IHdvcmsgaW4gdGhlIGZpeHVwcyBhbmQgcG9z
dCBhcyB2Ny4gIEknbGwgbWVyZ2UgdGhhdCBpbiBteQ0KPiB0cmVlLCB0byBnaXZlIHlvdSBhIGJh
c2UgZm9yIHRoZSByZW1haW5kZXIgb2YgeW91ciAiYXV0byBwcm9wYWdhdGVkDQo+IGxvY2FsX2Vy
ciIgd29yay4gIFdoaWxlIHlvdSB3b3JrIG9uIHRoYXQsIEknbGwgd29yayBvbiBnZXR0aW5nIHRo
ZSBiYXNlDQo+IG1lcmdlZCBpbnRvIG1hc3Rlci4gIFNvdW5kcyBsaWtlIGEgcGxhbj8NCj4gDQoN
ClllcywgdGhhdCdzIGdvb2QuIEknbGwgc2VuZCB2NyB0b21vcnJvdy4NCg0KV2hhdCB5b3Ugc3Vn
Z2VzdCB0byBkbyBhZnRlciBpdD8NClNlbmQgaW4gb25lIHNlcmllcyBhIHBhdGNoIHdpdGggbWFj
cm8gKyBjb2NjaW5lbGxlICsNCnN1YnNldCBvZiBhdXRvZ2VuZXJhdGVkIHBhdGNoZXMsIHdoaWNo
IHdlcmUgcmV2aWV3ZWQgKGJ1dCBub3Qgc2VuZGluZyBoYWxmDQphIHN1YnN5c3RlbSBvZiBjb3Vy
c2UpPw0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

