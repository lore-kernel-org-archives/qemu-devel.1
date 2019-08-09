Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF82C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F232171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TGA+nGqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F232171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1rB-0001uF-JY
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw1qf-00014j-NY
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw1qe-0007Mn-Fx
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:10:13 -0400
Received: from mail-eopbgr150097.outbound.protection.outlook.com
 ([40.107.15.97]:33665 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hw1qd-0007M0-KQ; Fri, 09 Aug 2019 06:10:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIcoTyexVAzIB5pKQiESZGDurBhWRu2MtAruoTGAl0liDrCFhzxhuruohfrRP9HXlPBIJuK8S5Hr+3jZ8AoNx6CzTd+xQjdVKmBVq9vDJrMnuZSn0t5RkQ7rrY4DKE4iAxEAbZrFdJ5iUSWHs6rQFtql55FjT6E0zqySeePfIT6AURTOQihNG7xQub2VWpVjB+kAXQMvsYMzKfKKdkikxPg6YdPwNpCuRKfuo5UIaI4K4BLmPSJpPEMttOTmv9BlMWbT87RvgiDfgAIuGdSSLdfoZos0+of6nADsQehEdNcMwWq2ZE+t/c5Xpy24cxJ1Mlj373p27Akcsrdk1Rb26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rd7efOx+60B7Jq1ypt8GhhdNPsjV6JZ+eRika4fjpU=;
 b=e9unGBBD3cuS3xyeshVhDAFCJjH/NwfHyDQ6xOnqj9oIjr/k0zuL0DkHlT5K0rUEx105HZ/l6DnPisPt+8XEyIVr5vPnuzNHJmVEjBYeBTMW+GZh6AHJsfAOinpFeEG3fYY7P8FDbN6NiV4Ti2gp5U3L1kJ1GProZdj2F71i+jGFEXIoQ7tM0rBNvd49z64yq9aAYgOHAh4tL8qaXFApPf33vjMfKcjis5Tg2IYhenQVmG9gobspmty7p6FvrFBawIT/wTLuemHpdu5QUGONsN4XSxEu5yJOdwJxjnQv19h9VfRv58NoKPBsUyM/94LIr18MtvBBrffXY1j/50Wlvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rd7efOx+60B7Jq1ypt8GhhdNPsjV6JZ+eRika4fjpU=;
 b=TGA+nGqNIcrKUqWBlpu5qh3dGb9Ka88NntIqS/li967Mrz5JZ7FDQgzP/SNMyMsWupb1YtNEGZySK2bw0AhgfKJhVU6vOQx2SAxk0akpOqBgs0syPMRBV6nvWP+YlT/4TsbQ57nKMBLaxPk1b87n+2752Ml8oXTrz493t/Op69s=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4939.eurprd08.prod.outlook.com (10.255.4.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Fri, 9 Aug 2019 10:10:09 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 10:10:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 4/8] block/backup: improve unallocated clusters skipping
Thread-Index: AQHVTPc5s/npQfEhfkGoVKrBP/0JC6bv+juAgAKsOgD///TYAA==
Date: Fri, 9 Aug 2019 10:10:09 +0000
Message-ID: <542a72b3-b7d1-2a6c-9b6d-6ccfdc215434@virtuozzo.com>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-5-vsementsov@virtuozzo.com>
 <23fd227d-9074-3a9e-b6c7-09f4abadc021@redhat.com>
 <ba8ea007-06dd-03fb-9f9c-6e31a4764156@virtuozzo.com>
In-Reply-To: <ba8ea007-06dd-03fb-9f9c-6e31a4764156@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0158.eurprd05.prod.outlook.com
 (2603:10a6:7:28::45) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190809131006765
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2baa595e-8c57-4b30-fc69-08d71cb1c233
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4939; 
x-ms-traffictypediagnostic: DB8PR08MB4939:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB49392D9A30513555C637D1D6C1D60@DB8PR08MB4939.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(39850400004)(136003)(366004)(52314003)(189003)(199004)(25786009)(6436002)(52116002)(107886003)(31686004)(54906003)(99286004)(53546011)(229853002)(76176011)(81156014)(26005)(81166006)(4326008)(71200400001)(110136005)(71190400001)(6506007)(316002)(6486002)(14454004)(36756003)(8936002)(2906002)(5660300002)(86362001)(102836004)(31696002)(486006)(256004)(476003)(6512007)(2616005)(3846002)(8676002)(66066001)(14444005)(7736002)(305945005)(478600001)(186003)(66446008)(64756008)(66556008)(66476007)(6246003)(66946007)(11346002)(386003)(53936002)(446003)(2501003)(6116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4939;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 06DaLhcU4dNsjFRPH65qxL3lDNemHjEOSJ4C+Bin2hMeF1m6D4gjJ6xzPlVnZsp2qd7VyGHJqYJVcXZMaBU9VPhExx/bTlA7LNRqFmurxCmNXYqmG+XmaVykbWh3U+oPQVSQt6k46d8dJVCeDPQD/sezSzDHBWho8K9uJO9l0uLSfy1Gd7lxJsqC+pD+Al8E3JSWR+fCOrA5n1+upanQSccot6+xw+gKK3khvcXmNtyfgLL0icy6kXSqpAYgy1L+KymbtgitjSDAj6m5ogYELqH6MVpXRqnrE1CeT/DpSsYVKqPKTi7QgItiEhXD61xOST+gD8PXxqDns9U1VTsTVyKDrZcZDoDdUlAeXWqCthpd0X5hFiVpL/+XkBh7a1eyeYF1Whogoae85WtFKrRRwsul+3e5cx9tuPig8Wm9B2A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D36BEA02F8E3A448B9CD8350F428CDA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baa595e-8c57-4b30-fc69-08d71cb1c233
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 10:10:09.0651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHlg3Xetc6QtPfpxH5GcMnYGzmiZ8beoSXC+mW8qXpbWh4D+U8B78G+TADJSaBwqQ4el/c3QkZ6Rg2seyNhYep9TXvhlBswLDqv8u4+0vrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4939
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.97
Subject: Re: [Qemu-devel] [PATCH 4/8] block/backup: improve unallocated
 clusters skipping
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

MDkuMDguMjAxOSAxMDo1MCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDcuMDguMjAxOSAyMTowMSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMDcuMDguMTkgMTA6MDcs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gTGltaXQgYmxvY2tfc3Rh
dHVzIHF1ZXJ5aW5nIHRvIHJlcXVlc3QgYm91bmRzIG9uIHdyaXRlIG5vdGlmaWVyIHRvDQo+Pj4g
YXZvaWQgZXh0cmEgc2Vla2luZy4NCj4+DQo+PiBJIGRvbuKAmXQgdW5kZXJzdGFuZCB0aGlzIHJl
YXNvbmluZy7CoCBDaGVja2luZyB3aGV0aGVyIHNvbWV0aGluZyBpcw0KPj4gYWxsb2NhdGVkIGZv
ciBxY293MiBzaG91bGQganVzdCBtZWFuIGFuIEwyIGNhY2hlIGxvb2t1cC7CoCBXaGljaCB3ZSBo
YXZlDQo+PiB0byBkbyBhbnl3YXkgd2hlbiB3ZSB0cnkgdG8gY29weSBkYXRhIG9mZiB0aGUgc291
cmNlLg0KPiANCj4gQnV0IGZvciByYXcgaXQncyBzZWVraW5nLiBJIHRoaW5rIHdlIGp1c3Qgc2hv
dWxkbid0IGRvIGFueSB1bm5lY2Vzc2FyeSBvcGVyYXRpb25zDQo+IGluIGNvcHktYmVmb3JlLXdy
aXRlIGhhbmRsaW5nLiBTbyBpbnN0ZWFkIG9mIGNhbGxpbmcNCj4gYmxvY2tfc3RhdHVzKHJlcXVl
c3Rfc3RhcnQsIGRpc2tfZW5kKSBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGNhbGwNCj4gYmxvY2tf
c3RhdHVzKHJlcXVlc3Rfc3RhcnQsIHJlcXVlc3RfZW5kKS4gQW5kIGl0IGlzIG1vcmUgYXBwbGlj
YWJsZSBmb3IgcmV1c2luZyB0aGlzDQo+IGNvZGUgdG9vLg0KDQpvb3BzLCBhbmQgc2VlayBsYWNr
IHRoZSBsaW1pdCBhbnl3YXkuDQoNCkJ1dCBhbnl3YXksIHdlIGhhdmUgQVBJIHdpdGggY291bnQg
bGltaXQgYW5kIGl0IHNlZW1zIG5hdHVyYWwgdG8gYXNzdW1lIHRoYXQgc29tZQ0KZHJpdmVyIG1h
eSBkbyBtb3JlIGNhbGN1bGF0aW9ucyBmb3IgYmlnZ2VyIHJlcXVlc3QuIFNvIHNtYWxsZXIgcmVx
dWVzdCBpcyBnb29kIGZvcg0KY29weS1iZWZvcmUtd3JpdGUgb3BlcmF0aW9uIHdoZW4gd2UgYXJl
IGluIGEgaGFycnkgdG8gdW5mcmVlemUgZ3Vlc3Qgd3JpdGUgYXMgc29vbg0KYXMgcG9zc2libGUu
DQoNCkhtbSwgZXhhbXBsZSBvZiBzdWNoIGRyaXZlIG1heSBiZSBOQkQsIHdoaWNoIGNhbiBjb25j
YXRlbmF0ZSBibG9jay1zdGF0dXMgcmVzdWx0cyBvZg0KZXhwb3J0ZWQgZGlzay4NCg0KDQo+IA0K
Pj4NCj4+IEkgY291bGQgdW5kZXJzdGFuZCBzYXlpbmcgdGhpcyBtYWtlcyB0aGUgY29kZSBlYXNp
ZXIsIGJ1dCBJIGFjdHVhbGx5DQo+PiBkb27igJl0IHRoaW5rIGl0IGRvZXMuwqAgSWYgeW91IGlt
cGxlbWVudGVkIGNoZWNraW5nIHRoZSBhbGxvY2F0aW9uIHN0YXR1cw0KPj4gb25seSBmb3IgYXJl
YXMgd2hlcmUgdGhlIGJpdG1hcCBpcyByZXNldCAod2hpY2ggSSB0aGluayB0aGlzIHBhdGNoDQo+
PiBzaG91bGQpLCB0aGVuIGl04oCZZCBqdXN0IGR1cGxpY2F0ZSB0aGUgZXhpc3RpbmcgbG9vcC4N
Cj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNl
bWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+IC0tLQ0KPj4+IMKgIGJsb2NrL2JhY2t1cC5jIHwg
MzggKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0NCj4+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvYmxvY2svYmFja3VwLmMgYi9ibG9jay9iYWNrdXAuYw0KPj4+IGluZGV4IDExZTI3
Yzg0NGQuLmE0ZDM3ZDJkNjIgMTAwNjQ0DQo+Pj4gLS0tIGEvYmxvY2svYmFja3VwLmMNCj4+PiAr
KysgYi9ibG9jay9iYWNrdXAuYw0KPj4NCj4+IFsuLi5dDQo+Pg0KPj4+IEBAIC0yNjcsNiArMjY3
LDE4IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJhY2t1cF9kb19jb3coQmFja3VwQmxvY2tK
b2IgKmpvYiwNCj4+PiDCoMKgwqDCoMKgIHdhaXRfZm9yX292ZXJsYXBwaW5nX3JlcXVlc3RzKGpv
Yiwgc3RhcnQsIGVuZCk7DQo+Pj4gwqDCoMKgwqDCoCBjb3dfcmVxdWVzdF9iZWdpbigmY293X3Jl
cXVlc3QsIGpvYiwgc3RhcnQsIGVuZCk7DQo+Pj4gK8KgwqDCoCBpZiAoam9iLT5pbml0aWFsaXpp
bmdfYml0bWFwKSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGludDY0X3Qgb2ZmLCBjaHVuazsNCj4+
PiArDQo+Pj4gK8KgwqDCoMKgwqDCoMKgIGZvciAob2ZmID0gb2Zmc2V0OyBvZmZzZXQgPCBlbmQ7
IG9mZnNldCArPSBjaHVuaykgew0KPj4NCj4+IFRoaXMgaXMgd2hhdCBJ4oCZbSByZWZlcnJpbmcg
dG8sIEkgdGhpbmsgdGhpcyBsb29wIHNob3VsZCBza2lwIGFyZWFzIHRoYXQNCj4+IGFyZSBjbGVh
bi4NCj4gDQo+IEFncmVlLCB3aWxsIGRvLg0KPiANCj4+DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0ID0gYmFja3VwX2JpdG1hcF9yZXNldF91bmFsbG9jYXRlZChqb2IsIG9mZiwgZW5k
IC0gb2ZmLCAmY2h1bmspOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQgPCAw
KSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaHVuayA9IGpvYi0+Y2x1
c3Rlcl9zaXplOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+PiArwqDCoMKgwqDC
oMKgwqAgfQ0KPj4+ICvCoMKgwqAgfQ0KPj4+ICvCoMKgwqAgcmV0ID0gMDsNCj4+PiArDQo+Pj4g
wqDCoMKgwqDCoCB3aGlsZSAoc3RhcnQgPCBlbmQpIHsNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
aW50NjRfdCBkaXJ0eV9lbmQ7DQo+Pj4gQEAgLTI3NiwxNSArMjg4LDYgQEAgc3RhdGljIGludCBj
b3JvdXRpbmVfZm4gYmFja3VwX2RvX2NvdyhCYWNrdXBCbG9ja0pvYiAqam9iLA0KPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOyAvKiBhbHJlYWR5IGNvcGllZCAqLw0KPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChqb2ItPmluaXRp
YWxpemluZ19iaXRtYXApIHsNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBiYWNr
dXBfYml0bWFwX3Jlc2V0X3VuYWxsb2NhdGVkKGpvYiwgc3RhcnQsICZza2lwX2J5dGVzKTsNCj4+
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0ID09IDApIHsNCj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyYWNlX2JhY2t1cF9kb19jb3dfc2tpcF9yYW5nZShqb2Is
IHN0YXJ0LCBza2lwX2J5dGVzKTsNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHN0YXJ0ICs9IHNraXBfYnl0ZXM7DQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjb250aW51ZTsNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4gLcKgwqDCoMKg
wqDCoMKgIH0NCj4+PiAtDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRpcnR5X2VuZCA9IGJkcnZf
ZGlydHlfYml0bWFwX25leHRfemVybyhqb2ItPmNvcHlfYml0bWFwLCBzdGFydCwNCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbmQgLSBzdGFydCk7DQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChkaXJ0eV9lbmQgPCAwKSB7DQo+Pg0KPj4gSG0sIHlvdSBy
ZXNvbHZlZCB0aGF0IGNvbmZsaWN0IGRpZmZlcmVudGx5IGZyb20gbWUuDQo+Pg0KPj4gSSBkZWNp
ZGVkIHRoZSBiZHJ2X2RpcnR5X2JpdG1hcF9uZXh0X3plcm8oKSBjYWxsIHNob3VsZCBnbyBiZWZv
cmUgdGhlDQo+PiBiYWNrdXBfYml0bWFwX3Jlc2V0X3VuYWxsb2NhdGVkKCkgY2FsbCBzbyB0aGF0
IHdlIGNhbiB0aGVuIGRvIGENCj4+DQo+PiDCoMKgIGRpcnR5X2VuZCA9IE1JTihkaXJ0eV9lbmQs
IHN0YXJ0ICsgc2tpcF9ieXRlcyk7DQo+Pg0KPj4gYmVjYXVzZSB3ZSBwcm9iYWJseSBkb27igJl0
IHdhbnQgdG8gY29weSBhbnl0aGluZyBwYXN0IHdoYXQNCj4+IGJhY2t1cF9iaXRtYXBfcmVzZXRf
dW5hbGxvY2F0ZWQoKSBoYXMgaW5xdWlyZWQuDQo+Pg0KPj4NCj4+IEJ1dCB0aGVuIGFnYWluIHRo
aXMgcGF0Y2ggZWxpbWluYXRlcyB0aGUgZGlmZmVyZW5jZSBhbnl3YXkuLi4NCj4+IMKgPg0KPj4+
IEBAIC01NDYsNyArNTQ5LDggQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmFja3VwX3J1bihK
b2IgKmpvYiwgRXJyb3IgKiplcnJwKQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBvdXQ7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGJhY2t1cF9iaXRtYXBfcmVzZXRfdW5hbGxvY2F0
ZWQocywgb2Zmc2V0LCAmY291bnQpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9
IGJhY2t1cF9iaXRtYXBfcmVzZXRfdW5hbGxvY2F0ZWQocywgb2Zmc2V0LCBzLT5sZW4gLSBvZmZz
ZXQsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZjb3Vu
dCk7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCA8IDApIHsNCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pg0KPj4NCj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=

