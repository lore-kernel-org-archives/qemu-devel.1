Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C6FC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229452199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M+cHqch4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229452199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvG8T-0006L0-AE
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59537)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hvG7q-0005qa-JM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hvG7p-0008Na-5e
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:12:46 -0400
Received: from mail-eopbgr60114.outbound.protection.outlook.com
 ([40.107.6.114]:45652 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hvG7p-0008LA-00
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:12:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVuUwmkPsVu78dk2u2iIlWGsApQka+yEvg8IP4tf/4y/e6/e01ikbnXjGLEyhOcZWEKlp7H2G/t81HdSfH24Rt7bj7RcHqmkTPem/9KkhRx17FlD4s6EKAMzQaaARCDN30KpcPPp2dmjO/0ZzawYrDh7iuVCZMSD/Nix7iLEFN0HPyawQu7x/0qTCeaZS6jfxCEgijYNKx7y1dtxi7VmF19A0mhOlLE/OSnn2bmLYD07592AJFG8xObOY2NaW+gZfzOQv5nkOZa0GEvmi7w/810uy/lDKQzrNFi+aSDwIevKXtFAOk8A1g5ZvAk/rIsCW7PEZb24dbNgUV2mKUEi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfcG4VnkgZF0zKVF44fGo927aHaLbrPXGWhtOWi0uB4=;
 b=FS47/QvdAOzZrkEgt2WNjrp6vLF2WzZRksJVXzb4KJKpy2QbLotDBgoFZt7W+QrR8Vw3P9cCRZG6mMOfXnU1RflFGUIJd9sc17DSnrOgzxiLWEvCuiCyE1JMkEaGHTSyl2IMku/EW9aMFjDRrmoNPhxSEsOdubG9n6zMw0vwnTHm69vlHy5cNo/0BR/7R+i2K76dtJu1Lo6B7sl7sI3v4DQR3ZGRUD0+d4PeowoZJmLRIzexOpPFCLdU5YZ+YpCEQv/6B+xpEKKrS/nm4gKyQRmgkbGibA1vp4n3GsIQ5nXgSY5xtnm5uSfzbsdnCAY7I65dL+EPr+7Z7vIxvnEKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfcG4VnkgZF0zKVF44fGo927aHaLbrPXGWhtOWi0uB4=;
 b=M+cHqch4G9Bpoi1qpJuSBgfc1U9pJL54ZNMNE0Kq3wIFBuBxbFDWFHMsVUuO5iMUHkaZCcE2YNN4KtQpgyulwvSSkagYhAOcBFQBRNzWJZ6qCcQpG49ZeW/nO+dWoZNkBYq1DyymrUi/izG8oamTBW6lHvDy9Fayc7yfAGm4R68=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3089.eurprd08.prod.outlook.com (52.134.90.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Wed, 7 Aug 2019 07:12:43 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::ac29:7eee:83d9:4668]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::ac29:7eee:83d9:4668%7]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 07:12:43 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 0/3] add zstd cluster compression
Thread-Index: AQHVMmomDcJsRQ8pz0G55mjwXrsq+abjZhaAgAwUCwA=
Date: Wed, 7 Aug 2019 07:12:43 +0000
Message-ID: <F90CD1C6-5352-459E-9DD2-2014473725D4@getmailspring.com>
References: <99CF1695-466B-4F46-83C7-50E9A5847519@getmailspring.com>
In-Reply-To: <99CF1695-466B-4F46-83C7-50E9A5847519@getmailspring.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0050.eurprd04.prod.outlook.com
 (2603:10a6:3:19::18) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Mailspring
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3056fd41-bf5d-47e0-2fe2-08d71b06a3e2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3089; 
x-ms-traffictypediagnostic: AM0PR08MB3089:
x-microsoft-antispam-prvs: <AM0PR08MB30895CF4DE35F7A4A72BF3F6CFD40@AM0PR08MB3089.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(396003)(346002)(376002)(366004)(53754006)(199004)(189003)(54534003)(316002)(2501003)(86362001)(9686003)(6512007)(54906003)(3736002)(446003)(11346002)(81166006)(476003)(8676002)(486006)(81156014)(2906002)(53936002)(6436002)(5640700003)(229853002)(478600001)(14454004)(54896002)(6306002)(3846002)(733005)(6116002)(6916009)(6486002)(25786009)(36756003)(52116002)(4326008)(66446008)(66946007)(102836004)(6506007)(386003)(26005)(76176011)(186003)(256004)(71190400001)(2351001)(33656002)(8936002)(99286004)(68736007)(18926415008)(305945005)(50226002)(66476007)(107886003)(6246003)(7736002)(66066001)(71200400001)(19627235002)(64756008)(5660300002)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3089;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nVt6UBOMih5l0PLi4gMKEmoHZ+Ue0+4ftxrY1zoi8KYJmI/37l181YdBSvT+xPh9M36VNF7Wf0UF9pzY3IMpbvY2VGFgeYoDAEBEJlGoDZ7JP7qk90U8wE8FGFZijmE2zBYRatvmlkOxmOx2LqdDjFGwk/g2/81A5ufo85SU0x04LrA/vLVrV/jbs6Lotb01Yny0PhweHb5//k3BUUbzNeDPRicVNtH04k229+lmzUpyfWiaYzZmzLHv9a1vplegvs22tXqEOw500XxlTI5BrFTtR+EPujT7tMy20ZgAcn+wD/v7JEr5UM9GZ9X/YFA0VJebzzbj/Hmj8OaxNzJCDhDco1kEqPoJbSneh0V5wRec4Epa6g9n2FL4JHw/z8W3MiJ2dmEdQP8Y4/S52EV3BC9avTwmM3Vwog/SpJU2q+k=
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3056fd41-bf5d-47e0-2fe2-08d71b06a3e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 07:12:43.0797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+4QXhAx+XPbHjwY/eRapZJ0gbij8mt6/OC0yag+1e3MkqDA43/mZxt9RsGsdTfbwoa8iqXlbKEKXZ55SQC6uovPTzRuLcBI/lFmKd/rUJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3089
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.114
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 0/3] add zstd cluster compression
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGluZyENCg0KT24gSnVsIDMwIDIwMTksIGF0IDU6NDUgcG0sIERlbmlzIFBsb3RuaWtvdiA8ZHBs
b3RuaWtvdkB2aXJ0dW96em8uY29tPiB3cm90ZToNCkhpIGFsbCEgSXMgdGhlcmUgYW55IG90aGVy
IGNvbW1lbnRzIGJlc2lkZXMgTWFya3VzJ3Mgb25lIGFib3V0IGFkZGluZyB6bGliL3pzdGQgbGlu
a3MgdG8gY29tcHJlc3NlZCBjbHVzdGVyIGxheW91dCBkZXNjcmlwdGlvbj8NCg0KT24gSnVsIDQg
MjAxOSwgYXQgNDowOSBwbSwgRGVuaXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5j
b20+IHdyb3RlOg0KY2hhbmdlIGxvZzoNCg0KdjI6DQoqIHJlbGF4IHRoZSBjb21wcmVzc2lvbiB0
eXBlIHNldHRpbmcgcmVzdHJpY3Rpb24gaW4gdGhlIHNwZWMNCiogZml4IHFjb3cyIGhlYWRlciBz
aXplIGNoZWNraW5nDQoqIGZpeCBlcnJvciBwcm9jZXNzaW5nIGFuZCBtZXNzYWdpbmcNCiogZml4
IHFjb3cyIGltYWdlIHNwZWNpZmljIGluZm8gcmVwb3J0aW5nDQoqIHNldCBRY293MkNvbXByZXNz
aW9uVHlwZSB6c3RkIGNvbmZpZyBkZXBlbmRhbnQNCiogYWRkIHpzdGQgY29tcHJlc3NlZCBjbHVz
dGVyIGZvcm1hdCBkZXNjcmlwdGlvbiB0byB0aGUgc3BlYw0KDQp2MToNCiogZXh0ZW5kIHFjb3cy
IGhlYWRlciBpbnN0ZWFkIG9mIGFkZGluZyBhIG5ldyBpbmNvbXBhdGlibGUgZXh0ZW5zaW9uIGhl
YWRlcg0Kc3BlY2lmaWNhdGlvbiByZS13cml0dGVuIGFjY29yZGluZ2x5DQoqIGVuYWJsZSB6c3Rk
IGNvbXByZXNzaW9uIHZpYSBjb25maWcNCiogZml4IHpzdGQgKGRlKWNvbXByZXNzaW9uIGZ1bmN0
aW9ucw0KKiBmaXggY29tbWVudHMvZGVzY3JpcHRpb24NCiogZml4IGZ1bmN0aW9uIG5hbWluZw0K
DQotLS0NClRoZSBnb2FsIG9mIHRoZSBwYXRjaC1zZXQgaXMgdG8gZW5hYmxlIHFjb3cyIHRvIHVz
ZSB6c3RkIGNvbXByZXNzaW9uIGZvcg0KY2x1c3RlcnMuIFpTVEQgcHJvdmlkZXMgYmV0dGVyIChk
ZSljb21wcmVzc2lvbiBwZXJmb3JtYW5jZSB0aGFuIGN1cnJlbnRseQ0KdXNlZCBaTElCLiBVc2lu
ZyBpdCB3aWxsIGltcHJvdmUgcGVyZm9yYW1uY2UgKHJlZHVjZSBjb21wcmVzc2lvbiB0aW1lKQ0K
d2hlbiB0aGUgY29tcHJlc3NlZCBjbHVzdGVycyBpcyB1c2VkLCBlLmcgYmFja3VwIHNjZW5hcmlv
cy4NCg0KQWxzbywgdGhlIHBhdGNoLXNldCBleHRlbmRzIHFjb3cyIHNwZWNpZmljYXRpb24gYnkg
YWRkaW5nIGNvbXByZXNzaW9uX3R5cGUNCmZlYXR1cmUuIFRoZSBmZWF0dXJlIGVuYWJsZXMgYWRk
aW5nIFpTVEQgYW5kIGFub3RoZXIgY29tcHJlc3Npb24gYWxnb3JpdGhtcw0KaW4gdGhlIGZ1dHVy
ZS4NCg0KSGVyZSBpcyBzb21lIG1lYXN1cmVtZW50cyBaU1REIHZzIFpMSUI6DQoNClRoZSB0ZXN0
Og0KVGVzdCBjb21wcmVzc2VzIGFuZCBkZWNvbXByZXNzZXMgcWVtdSBxY293MiBpbWFnZSB3aXRo
IGp1c3QNCmluc3RhbGxlZCByaGVsLTcuNiBndWVzdC4NCkltYWdlIGNsdXN0ZXIgc2l6ZTogNjRL
LiBJbWFnZSBvbiBkaXNrIHNpemU6IDIuMkcNCg0KVGhlIHRlc3Qgd2FzIGNvbmR1Y3RlZCB3aXRo
IGJyZCBkaXNrIHRvIHJlZHVjZSB0aGUgaW5mbHVlbmNlDQpvZiBkaXNrIHN1YnN5c3RlbSB0byB0
aGUgdGVzdCByZXN1bHRzLg0KVGhlIHJlc3VsdHMgaXMgZ2l2ZW4gaW4gc2Vjb25kcy4NCg0KY29t
cHJlc3MgY21kOg0KdGltZSAuL3FlbXUtaW1nIGNvbnZlcnQgLU8gcWNvdzIgLWMgLW8gY29tcHJl
c3Npb25fdHlwZT1bemxpYnx6c3RkXQ0Kc3JjLmltZyBbemxpYnx6c3RkXV9jb21wcmVzc2VkLmlt
Zw0KZGVjb21wcmVzcyBjbWQNCnRpbWUgLi9xZW11LWltZyBjb252ZXJ0IC1PIHFjb3cyDQpbemxp
Ynx6c3RkXV9jb21wcmVzc2VkLmltZyB1bmNvbXByZXNzZWQuaW1nDQoNCg0KVGhlIHJlc3VsdHM6
DQpjb21wcmVzc2lvbiBkZWNvbXByZXNzaW9uDQp6bGliIHpzdGQgemxpYiB6c3RkDQotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCnJl
YWwgNjUuNSAxNi4zICgtNzUgJSkgMS45IDEuNiAoLTE2ICUpDQp1c2VyIDY1LjAgMTUuOCA1LjMg
Mi41DQpzeXMgMy4zIDAuMiAyLjAgMi4wDQoNCkJvdGggWkxJQiBhbmQgWlNURCBnYXZlIHRoZSBz
YW1lIGNvbXByZXNzaW9uIHJhdGlvOiB+MS41DQpjb21wcmVzc2VkIGltYWdlIHNpemUgaW4gYm90
aCBjYXNlczogfjEuNEcNCg0KRGVuaXMgUGxvdG5pa292ICgzKToNCnFjb3cyOiBpbnRyb2R1Y2Ug
Y29tcHJlc3Npb24gdHlwZSBmZWF0dXJlDQpxY293MjogcmV3b3JrIHRoZSBjbHVzdGVyIGNvbXBy
ZXNzaW9uIHJvdXRpbmUNCnFjb3cyOiBhZGQgenN0ZCBjbHVzdGVyIGNvbXByZXNzaW9uDQoNCmJs
b2NrL3Fjb3cyLmMgfCAyODcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0N
CmJsb2NrL3Fjb3cyLmggfCAyNiArKystDQpjb25maWd1cmUgfCAzMiArKysrKw0KZG9jcy9pbnRl
cm9wL3Fjb3cyLnR4dCB8IDQwICsrKysrLQ0KaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaCB8IDEg
Kw0KcWFwaS9ibG9jay1jb3JlLmpzb24gfCAyMyArKy0NCjYgZmlsZXMgY2hhbmdlZCwgMzc5IGlu
c2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KDQotLQ0KMi4xNy4wDQoNCg==
