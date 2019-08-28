Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF9DC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197A722CED
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 15:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="arFTXj+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197A722CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2zoh-0003Lr-4Z
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 11:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2zns-0002kk-5L
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i2znr-0001j5-4b
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 11:24:08 -0400
Received: from mail-eopbgr130103.outbound.protection.outlook.com
 ([40.107.13.103]:6118 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i2znn-0001dj-IL; Wed, 28 Aug 2019 11:24:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9RYDasKoG1Pwctevftn4GqkH6D5KsqqrWIR8Mf/InLl+Zlb41dg2md1ZnzVpdp2B9+Z0MmNZ3d3fm709XKxnJm/EhZjZTbGazeYpi2unW1nqBfxVZZHAyUJp49Ni2sruF8qzf28QLtBvqo8nUNWbtIVYq7diw32gEQJDq+95uAYubr1GY6r7xnFkru6nFysFSMjDmWmKBR9zeruhSNUeqZrxGBiQrMoJTaDxtaQJduIEn50yjHy2gLTgDcWaf0Cww/IRdoRf5d83k5ucIU3+77wNyuYEEgilelVGwDVi+3jf6jTBRZM4Q6hlsrcTfKxx6lNqY/JRJoS81jinvBJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsmlJ168AcjhjPmFMZFe5W03H/GyxF80nxzNEi7erAI=;
 b=NByBe+3ISt3CimJ+MMolRs3PGQYpU7LNayhUBgD0UTgSAqPzKMb/pZn8KuYi5XEMcEmQdr4qoKXRenBBuPT4LpCpefhuuViIte0/qPzU01ilAsMU8C0IBB0D3/POL7bQF/82Qd1QwhFHGXTq9ig6+bM/CUtj/Ko+cu8eV3wB+TtcFv9WMyQIKo2PrmDwQqrYYVemOMVU/KZwXisX4qizgUJKboElwHEaTRod9HZj2+jvtdqH1lPFi1vAkNy7kI23Apqxu/2n/jTUgTB9DlNNBXOiJAz41LtpVtC9bCaju5okZs53MpkPVB+91xlizOP1Ps485OemCG2QN5rZMbaqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsmlJ168AcjhjPmFMZFe5W03H/GyxF80nxzNEi7erAI=;
 b=arFTXj+qWh0IK86/6Tw3vNufhjJSRTAZ6RF8SDIiL3P3RUs13UWhSv8P3fV90mICqhvlJKVQAR42c0GBDyiu574lZqBH2gFOUNFeB7YMzilWoVcA5o3AWlqtrVA86MJ6C1spK1qyHP29lGE7xybR5P8apR9c1Pd8/QeVrCb6ziI=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4526.eurprd08.prod.outlook.com (20.179.26.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 15:24:00 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 15:24:00 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-block] [PATCH v5 6/6] iotests: extend sleeping time under
 Valgrind
Thread-Index: AQHVPk9L+aGW2bt4m0G0OQXEvFC84qb9H8GAgAvyDoCABpDSgIABSfkA
Date: Wed, 28 Aug 2019 15:24:00 +0000
Message-ID: <421d92ed-0eb1-6e45-f080-0198c1739e17@virtuozzo.com>
References: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563553816-148827-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <083ece64-0178-fe4a-45df-331257a115fb@redhat.com>
 <350a5dee-7bc7-cfa0-e5b4-0c0f2202d119@virtuozzo.com>
 <27a1a3e5-3ebd-2e64-a36e-e8e4728b2b6d@redhat.com>
In-Reply-To: <27a1a3e5-3ebd-2e64-a36e-e8e4728b2b6d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0006.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::16) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab559526-a405-44fa-16f7-08d72bcbc06a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4526; 
x-ms-traffictypediagnostic: VI1PR08MB4526:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB4526384E26E90F5D6DDAFBF3F4A30@VI1PR08MB4526.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(39850400004)(376002)(366004)(199004)(189003)(3846002)(305945005)(6116002)(2501003)(186003)(7736002)(11346002)(478600001)(31696002)(2906002)(14454004)(446003)(99286004)(52116002)(486006)(76176011)(86362001)(66066001)(2616005)(476003)(229853002)(316002)(26005)(44832011)(31686004)(110136005)(54906003)(2201001)(386003)(81166006)(8936002)(25786009)(14444005)(81156014)(256004)(64756008)(66446008)(66946007)(66476007)(102836004)(8676002)(66556008)(6506007)(107886003)(6486002)(5660300002)(4326008)(53546011)(36756003)(53936002)(6512007)(71190400001)(71200400001)(6246003)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4526;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BxgVFZQc959RBi9wF0NH7eXFvGvoclPV0zv4IfoxtXuSh7fcsfaJI4miOOWl04+vvklYqS330/GO2pC5733Ci9dnFVtu7Xpl0GTyOHjg6TCZJ22WczM2ocGu2j6xBNs3TrW9ABthCrSmNkkD2ZOp9CxmumTwYkoyVzvbIesm5LuQ/ctBn8bPUAwEnqzd93/CSH9/K5FU5N3/XfjG87lPpgUKKD+U5IqnR2nkO2Egzlxq8/4Mh0JxMoiOY4FpFQIaTVaNvONx4wlScN4T5N/FYSiy2xOL5kgMXntMY0G7Bq5O0dSqn/mF7X1oHVThjry+KA/aA5sOroYucoXoiihufQlCAoiwEy6MW+NB0KlHvy3qXPLY4vuolP+Rt1iQ0CCCXCOJr+OxfbvRegHBatx4u+HXasm0OelLfA+3YqrIWIs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9893305C2703164E873BB84600321CD9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab559526-a405-44fa-16f7-08d72bcbc06a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 15:24:00.4347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbXaxfs68/sXWuVbYovsztrXAtvg9sI45ukDTl95mkrh/VY88a7sFKCJp5eKSfbc3s+KloOap+WmqPtbgxcFiMcrdDq0nv6o/0XKLwT4oBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4526
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.103
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 6/6] iotests: extend
 sleeping time under Valgrind
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI3LzA4LzIwMTkgMjI6NDIsIEpvaG4gU25vdyB3cm90ZToNCj4gDQo+IA0KPiBPbiA4
LzIzLzE5IDExOjI3IEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4g
MTYuMDguMjAxOSA0OjAxLCBKb2huIFNub3cgd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9uIDcvMTkv
MTkgMTI6MzAgUE0sIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4+PiBUbyBzeW5jaHJvbml6
ZSB0aGUgdGltZSB3aGVuIFFFTVUgaXMgcnVubmluZyBsb25nZXIgdW5kZXIgdGhlIFZhbGdyaW5k
LA0KPj4+PiBpbmNyZWFzZSB0aGUgc2xlZXBpbmcgdGltZSBpbiB0aGUgdGVzdCAyNDcuDQo+Pj4+
DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmlj
aEB2aXJ0dW96em8uY29tPg0KPj4+PiBSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgdGVz
dHMvcWVtdS1pb3Rlc3RzLzI0NyB8IDYgKysrKystDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL3FlbXUtaW90ZXN0cy8yNDcgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjQ3DQo+Pj4+IGluZGV4
IDU0NmE3OTQuLmM4NTNiNzMgMTAwNzU1DQo+Pj4+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8y
NDcNCj4+Pj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0Nw0KPj4+PiBAQCAtNTcsNyArNTcs
MTEgQEAgVEVTVF9JTUc9IiRURVNUX0lNRy40IiBfbWFrZV90ZXN0X2ltZyAkc2l6ZQ0KPj4+PiAg
ICB7ImV4ZWN1dGUiOiJibG9jay1jb21taXQiLA0KPj4+PiAgICAgImFyZ3VtZW50cyI6eyJkZXZp
Y2UiOiJmb3JtYXQtNCIsICJ0b3Atbm9kZSI6ICJmb3JtYXQtMiIsICJiYXNlLW5vZGUiOiJmb3Jt
YXQtMCIsICJqb2ItaWQiOiJqb2IwIn19DQo+Pj4+ICAgIEVPRg0KPj4+PiAtc2xlZXAgMQ0KPj4+
PiAraWYgWyAiJHtWQUxHUklORF9RRU1VfSIgPT0gInkiIF07IHRoZW4NCj4+Pj4gKyAgICBzbGVl
cCAxMA0KPj4+PiArZWxzZQ0KPj4+PiArICAgIHNsZWVwIDENCj4+Pj4gK2ZpDQo+Pj4+ICAgIGVj
aG8gJ3siZXhlY3V0ZSI6InF1aXQifScNCj4+Pj4gICAgKSB8ICRRRU1VIC1xbXAgc3RkaW8gLW5v
Z3JhcGhpYyAtbm9kZWZhdWx0cyBcDQo+Pj4+ICAgICAgICAtYmxvY2tkZXYgZmlsZSxub2RlLW5h
bWU9ZmlsZS0wLGZpbGVuYW1lPSRURVNUX0lNRy4wLGF1dG8tcmVhZC1vbmx5PW9uIFwNCj4+Pj4N
Cj4+Pg0KPj4+IFRoaXMgbWFrZXMgbWUgbmVydm91cywgdGhvdWdoLiBXb24ndCB0aGlzIHJhY2Ug
dGVycmlibHk/IChXYWl0LCB3aHkNCj4+PiBkb2Vzbid0IGl0IHJhY2UgYWxyZWFkeT8pDQo+Pj4N
Cj4+DQo+PiBIbW0sIGhvd2V2ZXIgaXQgd29ya3Mgc29tZWhvdy4gSSdtIGFmcmFpZCB0aGF0IGV2
ZXJ5dGhpbmcgd2l0aCAic2xlZXAiIGlzIGRlZmluaXRlbHkgcmFjeS4uDQo+PiBPciB3aGF0IGRv
IHlvdSBtZWFuPw0KPj4NCj4gDQo+IFJpZ2h0IC0tIGFueXRoaW5nIHdpdGggYSBzbGVlcCBpcyBh
bHJlYWR5IGF0IHJpc2sgZm9yIHJhY2luZy4NCj4gDQo+IFdoYXQgSSBhbSBwaWNraW5nIHVwIG9u
IGhlcmUgaXMgdGhhdCB3aXRoIHZhbGdyaW5kLCB0aGVyZSBpcyBhbiBldmVuDQo+IGdyZWF0ZXIg
Y29tcHV0YXRpb25hbCBvdmVyaGVhZCB0aGF0J3MgbXVjaCBoYXJkZXIgdG8gcHJlZGljdCwgc28g
SSB3YXMNCj4gd29uZGVyaW5nIGhvdyB0aGVzZSB2YWx1ZXMgd2VyZSBkZXRlcm1pbmVkLg0KPiAN
Cg0KSSBqdXN0IGZvbGxvd2VkIHRoZSB0cmVuZCBhbmQgZXh0ZW5kZWQgdGhlIHNsZWVwaW5nIHRp
bWUgd2l0aCBhIGdyYXRlciANCnRvbGVyYW5jZSBzbyB0aGF0IHRoZSB0ZXN0IGNvdWxkIHBhc3Mg
b24gc3lzdGVtcyB3aGVyZSB0aGUgJ3NsZWVwIDEnIA0KY29tbWFuZCBoZWxwcyB0byBwYXNzIHdp
dGhvdXQgVmFsZ3JpbmQuIFdlIGNvdWxkIHJld3JpdGUgdGhlIHRlc3QgMjQ3IGluIA0KUHl0aG9u
IGluIGEgc2VwYXJhdGUgc2VyaWVzLCBzaGFsbCB3ZT8NCg0KQW5kcmV5DQoNCj4gKEkgd291bGRu
J3Qgd2l0aGhvbGQgYW4gUkIgZm9yIHRoYXQgYWxvbmUgLS0gdGhlIHNsZWVwcyBhcmUgZXhpc3Rp
bmcNCj4gcHJvYmxlbXMuKQ0KPiANCj4gV2hhdCBJIG1vdmVkIG9uIHRvIHdvbmRlcmluZyBpbiBw
YXJ0aWN1bGFyIGlzIHdoeSB0ZXN0IDI0NyBkb2Vzbid0DQo+IGFscmVhZHkgaGF2ZSByYWNlIHBy
b2JsZW1zLCBiZWNhdXNlIGl0IGxvb2tzIHF1aXRlIGZyYWdpbGUuDQo+IA0KPiBOZWl0aGVyIG9m
IHRoZXNlIGFyZSByZWFsbHkgQW5kcmV5J3MgcHJvYmxlbXM7IEkgd2FzIGp1c3Qgc3VycHJpc2Vk
DQo+IG1vbWVudGFyaWx5IHRoYXQgSSBkb24ndCBzZWUgMjQ3IGZhaWwgbW9yZSBvZnRlbiBhbHJl
YWR5LCBhcy1pcy4NCj4gDQo+IC0tanMNCj4gDQoNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRz
LA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

