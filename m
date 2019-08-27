Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36730C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EF4214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YRp62RH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EF4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2cAT-0003VT-4t
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 10:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2c9h-0002zz-PK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2c9g-00008d-NX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:09:05 -0400
Received: from mail-db5eur01on0721.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::721]:13632
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i2c9e-00006l-Hv; Tue, 27 Aug 2019 10:09:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFptWUsUhAcTQWbA4rLS4mS5AdxjNacfd5N2Fe5bWOJCTkVSZ6NqPYvK7xawS5ZlMwtMwfj5GWndYpy5me2RlfA6AmnwBPZ9Y0TGgmyC/stZJCvqyYvnVEv39hv+lnpW6ACeI025MD+2Y48LB0S0tvu/rj5D++J3T4/4cL8pk1VPr/vsb0A0Gd/y2rBKlQaE7FqRmAgPdmA7eZK9Mwrfnm/PibGDFt8+QRuptsL4R96Ff1BMxZkqxMHZ+YnV0S9pDEAwW8t8gsj6bRW2yxyuNdqLEDadIVxwPKe7d9dV6oI2jzxQXRT46P4xbRY8fExGnJeZOpZrTitO9oDo2kmcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9QNU8OTh0QR1SrrB5/A841CymdYC4mvQ2Ma2Rcna1U=;
 b=MJuF7hpVBo5HFyQrZpfZ5yehxZSEBgPoXDCfbgeXggZNICt4jBVvbE0P2WXz5s8KWqbsJsLVYGLTAcms18chEbNjT5Ij0PuJkDt4QEKQAmF1HsdHFg7jvcqz4kGpwDb5qNIXmIqp5vTjYZDp6zXLzxkycSlhzVLVeNlYDZ4IeXDUrh9dN02A3OMzibxuthrhRcmysFTFBbvYWEgbuTMQ8sQrOh/hJDYP3gv9Y5zBpTPD3wwBU1to/IdAZbMgl6ZuRu1Ef/bwZmdBxkJK9+/LGMJPTuaJdMkTscuBTd7A6a6yzZ/ET5NcvWlzjMWHeV48HOx0pIqZCvICJXGjRBHmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9QNU8OTh0QR1SrrB5/A841CymdYC4mvQ2Ma2Rcna1U=;
 b=YRp62RH6TsHY9OG5xMcmUUPvNmnYcnNEQ06rOrHitCBNzGoqyijZAKgr0i3m84O5+AbFjLN4tfPM01OibY80OwyXzJd0NE6tqgRuoFVryMoLY2/cC+8SxvjRc/ZmOx3iivc2opK0aHf/09DM9EMtv7HqTPu+v09OiPd6fr/EqD0=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4525.eurprd08.prod.outlook.com (20.179.26.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 14:08:59 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 14:08:59 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2] block: workaround for unaligned byte range in
 fallocate()
Thread-Index: AQHVXN6/9zhncFLxI0q6RGEW621xhKcPBHWAgAADuwA=
Date: Tue, 27 Aug 2019 14:08:59 +0000
Message-ID: <40b7e57b-0560-8d9b-91f4-2e24d2a9d265@virtuozzo.com>
References: <1566913973-15490-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4b240066-60b7-0f9b-9f17-d5da43b9da84@redhat.com>
In-Reply-To: <4b240066-60b7-0f9b-9f17-d5da43b9da84@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0047.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::15) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5666d969-4763-4dfa-79b1-08d72af81b0c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4525; 
x-ms-traffictypediagnostic: VI1PR08MB4525:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB4525723D6F5E848FD4EB4A53F4A00@VI1PR08MB4525.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(39850400004)(376002)(396003)(366004)(199004)(189003)(25786009)(2616005)(26005)(476003)(102836004)(446003)(76176011)(386003)(2906002)(6246003)(2201001)(486006)(66476007)(107886003)(316002)(256004)(53546011)(478600001)(7736002)(110136005)(44832011)(4326008)(229853002)(11346002)(99286004)(305945005)(14454004)(14444005)(54906003)(6116002)(66946007)(66556008)(6506007)(66066001)(6436002)(71200400001)(53936002)(71190400001)(8676002)(6512007)(5660300002)(81166006)(81156014)(31686004)(86362001)(186003)(4744005)(2501003)(52116002)(31696002)(66446008)(36756003)(3846002)(64756008)(8936002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4525;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7obcxrUaDdGH3XyK8enAbAz9/KB5HCoDWTYsXHTDpfY/ScOKeMMYeqohKDCE9AHttbkutMPEW/Pg/751bdAaDt28i2mtsoFHkov9ZqZXxcmPQwbTFUpri1KIJR+aQQ2hVmB/7ux3ez2Q1mfxibj0Gf1NlOt3keL671zggLe29OtvzYxmvkVDdtf15ElZ19Jfv8FVsJqPK6QRBnjgqZvXboffXlK68RDctByjzdLCy+BH8TVxS6LUTp06e8yQy6R+YLuDUZsKtPZ3fF5TxGz8kwhjtjVPATYt/gCg+846MuBIuQSXU0zsFmNnhTsdHf/snx1pszR7lwb0SsvtFLjWyZzyD433Na0h07OQhRKsWHjW3al2j2lvkgx8XrjaMr6DOu0woDa+zSFJXGMMd4kHBnawkMdieq90p5WZRKHsAiE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <920953783C380045888B298E6FF9A1B9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5666d969-4763-4dfa-79b1-08d72af81b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 14:08:59.2171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N86F0jAoyRwLW6STtg9hSgdXtwcVnJychRRcsDijxk+aPeq+x+yHu3wkAb/KWiXDU4TFnekOpkMBLlrFYULuUza5LJEEMInz8K0kPiT6ys4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4525
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe02::721
Subject: Re: [Qemu-devel] [PATCH v2] block: workaround for unaligned byte
 range in fallocate()
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI3LzA4LzIwMTkgMTY6NTUsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDgvMjcvMTkg
ODo1MiBBTSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+PiBSZXZlcnQgdGhlIGNvbW1pdCAx
MThmOTk0NDJkICdibG9jay9pby5jOiBmaXggZm9yIHRoZSBhbGxvY2F0aW9uIGZhaWx1cmUnDQo+
PiBhbmQgdXNlIGJldHRlciBlcnJvciBoYW5kbGluZyBmb3IgZmlsZSBzeXN0ZW1zIHRoYXQgZG8g
bm90IHN1cHBvcnQNCj4+IGZhbGxvY2F0ZSgpIGZvciBhbiB1bmFsaWduZWQgYnl0ZSByYW5nZS4g
QWxsb3cgZmFsbGluZyBiYWNrIHRvIHB3cml0ZQ0KPj4gaW4gY2FzZSBmYWxsb2NhdGUoKSByZXR1
cm5zIEVJTlZBTC4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhh
dC5jb20+DQo+PiBTdWdnZXN0ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZp
cnR1b3p6by5jb20+DQo+PiBSZXZpZXdlZC1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5j
b20+DQo+PiAtLS0NCj4+ICAgYmxvY2svZmlsZS1wb3NpeC5jIHwgNyArKysrKysrDQo+PiAgIGJs
b2NrL2lvLmMgICAgICAgICB8IDIgKy0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IFF1ZXVpbmcgdGhpcyBpbiBteSBOQkQgdHJlZSAo
YXMgSSBwZXJmb3JtZWQgdGVzdGluZyBvbiB0b3Agb2YgaXQgd2hlbg0KPiB3b3JraW5nIG9uIE5C
RCBmYXN0LXplcm8pLg0KPiANCg0KQWxzbywgbWF5YmUgdGhlIHRocmVhZCBtZXNzYWdlIElEIHdv
dWxkIGJlIGdvb2QgdG8gbWVudGlvbiBhcyB3ZWxsOg0KPDE1NTQ0NzQyNDQtNTUzNjYxLTEtZ2l0
LXNlbmQtZW1haWwtYW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCg0KQW5kcmV5DQot
LSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=

