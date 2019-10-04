Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC189C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2A9215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 14:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qZVT0P+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2A9215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGOhg-0002CM-Jm
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 10:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iGOgf-0001do-Uo
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 10:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iGOge-000236-AQ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 10:36:05 -0400
Received: from mail-eopbgr150093.outbound.protection.outlook.com
 ([40.107.15.93]:1606 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iGOgd-000222-PM; Fri, 04 Oct 2019 10:36:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I++kyypwXGMWUeTraGFoKj3PKAnBgyNzZcDuEUMtJosSM+ypeR53YLYHXvdPAycYNgcK1URsgOwBahWwaE6ul46/3pFgIXA5vkhdRshLw/kTvbbmcXb0nmJ5dQgASGcvlLmJDhxxgudGeOtQfUNa54DMdIScCBqftpfCoLMlJbYnMwcYY3G+EPMQ45rAzaCqOtF2LVBzJWK1DK/3WqBP3jB4fVng1XwKTjkAvn4WSj/n5mR1p4/3mRJdo5LDh/a/wj2zyvRxSqTUUmby9mKug2g9ejoLOFglSrfcW4C18Kf7grmzBR2vkMysCRm8srqoBfBXfG3kYhkvWf8ozqpMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRfju/Z9crPPt6qSmurvzyzsuvWv0NOWtlUcNEQMaFo=;
 b=L3WjGyCB/WU4pXA/moo4q+ADust8Ba4fFYxbNDQVj8GVp22w32Dx9xhxHAgYtoSX6ygK+E13gY+EbEpdkA1b0pl9Yco+sDBoMzRhjDLH0PnZno1KSIxp49/Dfofmr7q1OPir61UvxjEu1uErEKm+XnZ4/Ec9vYyTKG16HD16/llVGA1AuC0v/NeO9PMBjPZ1hu1wXEYfppnIqLUJTQgHQlDGAkrljTUvmoYtpVH/st3Xpadi2vSYgTbLNijJWVHXKMyGNTJWkP71oAF3djKyoYjdO2Nj6YMRIFtta+wRqDuYP6zrSvZU6NOGCM2TdqzM7+9YR7Ss6isS8RB5sE6PVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRfju/Z9crPPt6qSmurvzyzsuvWv0NOWtlUcNEQMaFo=;
 b=qZVT0P+8Uc+1DxQ1zd9k8S0HzgWkAjvRbwhIvic0NkiGW7BfnZU0UEPO+NpSA8oDHH7iyNin8Ml7L4ZKQ0aDwkZrRrZESt53Ra5SiZWry3UdIF8r7JId6kJaYtnj4CRU/+XPvNRTgklBel/O1zf8aNaJtFRJYAeruUKw/SGfYBA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3979.eurprd08.prod.outlook.com (20.179.9.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Fri, 4 Oct 2019 14:36:00 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 14:36:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v15 0/5] backup-top filter driver for backup
Thread-Topic: [PATCH v15 0/5] backup-top filter driver for backup
Thread-Index: AQHVeFojj3WjWnCoQU+hzLWaRzHykqdKjS8AgAAELoA=
Date: Fri, 4 Oct 2019 14:36:00 +0000
Message-ID: <02921bb6-361a-9c22-68bc-e7aeab67b77e@virtuozzo.com>
References: <20191001131409.14202-1-vsementsov@virtuozzo.com>
 <5b6c405f-e8a1-43eb-b709-53e88ad642e1@redhat.com>
In-Reply-To: <5b6c405f-e8a1-43eb-b709-53e88ad642e1@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0012.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::22) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191004173557546
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7accfe6-2efe-465a-8af1-08d748d82cda
x-ms-traffictypediagnostic: DB8PR08MB3979:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB3979D8880AC2D5AC861D9FB8C19E0@DB8PR08MB3979.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(39850400004)(376002)(366004)(136003)(189003)(199004)(53754006)(25786009)(6436002)(8936002)(86362001)(99286004)(966005)(478600001)(6116002)(3846002)(2906002)(31696002)(107886003)(5660300002)(14444005)(256004)(6486002)(6246003)(36756003)(64756008)(66446008)(66946007)(4326008)(54906003)(71190400001)(71200400001)(102836004)(386003)(6512007)(66476007)(66556008)(76176011)(110136005)(8676002)(52116002)(81166006)(14454004)(53546011)(81156014)(6506007)(7736002)(186003)(229853002)(31686004)(305945005)(486006)(11346002)(476003)(2616005)(446003)(2501003)(316002)(6306002)(26005)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3979;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hbTYmvfIR9m0uFgT0pz8drMiejxXcGH+LIXLHilsM32FSP3sQPwq6pOWHSS4wQdB7aHhhRf/ip2p36f3gyRpMvZQCZYRARBQxfUs9Htt0Tv4NctfQvRR1zUAqLyutlYC2EZmO9f4VGgasWDFXNeyKJOeCWD8LhzqL+klnGyNttHiY3z5W4tlpE4gTOEsdPvF6H45zl3r3xVzo0fHfQD7lgcYgSGnbkDYWQk5LmFS54Rt8oD4AIO29lMDrk0OVuY4mxv4CQB03tsLJWYRZuMNbMsp2RlvopLuRdLTWcY/Y0ORQ2JLHs5IORcd1hM/918ytf0yBlnR5AeifQjuwXaimAb0eGOQbZmKwZZu4uK+l6HH7bWE7PLECT5M9gIECEw1gK1k4W3N4hTdyOXI67F/81eblEO2uDgOTDY4jlRPPCTSN0JiB/0EYWcxThyfdqsHwhzKYRGPK+AR45Xh00ca+w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FA741066C38794AA86AE38ED3E7FAD3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7accfe6-2efe-465a-8af1-08d748d82cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 14:36:00.2452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iccE24FE232pvgiRnmQ464l+UB4K2EJpsihKGFgyye1PqEPKpErB4Ob5bAvxQWmD2N+JQWpQt1kPYvI4Gm7ISNQbpI3WWQl9HpPERjm+fWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3979
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.93
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
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDQuMTAuMjAxOSAxNzoyMSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMS4xMC4xOSAxNToxNCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIGFsbCENCj4+DQo+PiBU
aGVzZSBzZXJpZXMgaW50cm9kdWNlIGJhY2t1cC10b3AgZHJpdmVyLiBJdCdzIGEgZmlsdGVyLW5v
ZGUsIHdoaWNoDQo+PiBkbyBjb3B5LWJlZm9yZS13cml0ZSBvcGVyYXRpb24uIE1pcnJvciB1c2Vz
IGZpbHRlci1ub2RlIGZvciBoYW5kbGluZw0KPj4gZ3Vlc3Qgd3JpdGVzLCBsZXQncyBtb3ZlIHRv
IGZpbHRlci1ub2RlIChmcm9tIHdyaXRlLW5vdGlmaWVycykgZm9yDQo+PiBiYWNrdXAgdG9vLg0K
Pj4NCj4+IFByZXBhcmF0aW9uIHBhdGNoZXMgYXJlIHF1ZXVlZCBpbiBNYXgncyBibG9jayBicmFu
Y2g6DQo+Pg0KPj4gQmFzZWQtb246IGh0dHBzOi8vZ2l0aHViLmNvbS9YYW5DbGljL3FlbXUuZ2l0
IGJsb2NrDQo+Pg0KPj4gdjE1OiB1c2UgQmRydkNoaWxkcmVuIGluIGJsb2NrLWNvcHkNCj4+IDAx
LTAzOiBuZXcNCj4+IDA0LTA1OiBhIGxvdCBvZiBjaGFuZ2VzLCBzdWNoIGFzDQo+PiAwNDoNCj4+
ICAgICAgLSBhZGQgbmV3IHBhcmFtZXRlcnMgZm9yIGNyZWF0aW9uDQo+PiAgICAgIC0gcHJlcGFy
ZSBiY3MgY3JlYXRpb24NCj4+ICAgICAgLSBhZGQgdGFyZ2V0IGNoaWxkDQo+PiAgICAgIC0gcmVm
YWN0b3IgYmRydl9iYWNrdXBfdG9wX2FwcGVuZA0KPj4gICAgICAtIGRyb3Agci1iDQo+PiAwNToN
Cj4+ICAgICAgLSBtb3ZlIGJsb2NrLWNvcHkgdG8gdXNlIEJkcnZDaGlsZHJlbg0KPj4gICAgICAt
IGRyb3AgZXh0cmEgc3R5bGUgZml4aW5nIGh1bmtzDQo+PiAgICAgIC0gaW90ZXN0IDE0MSBvdXRw
dXQgY2hhbmdlZA0KPj4NCj4+IHYxNDogRHJvcCByYW5nZSBsb2Nrcywga2VlcCBvbGQgZ29vZCBp
bi1mbGlnaHQgcmVxdWVzdHMgd2FpdGluZw0KPj4NCj4+IDEyOiBuZXcgcGF0Y2gNCj4+IDE0OiB1
c2Ugb2xkIHJlcXVlc3Qtd2FpdGluZyBzY2hlbWUgaW5zdGVhZCBvZiByYW5nZSBsb2Nrcw0KPj4N
Cj4+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDUpOg0KPj4gICAgYmxvY2svYmFja3Vw
OiBtb3ZlIGluLWZsaWdodCByZXF1ZXN0cyBoYW5kbGluZyBmcm9tIGJhY2t1cCB0bw0KPj4gICAg
ICBibG9jay1jb3B5DQo+PiAgICBibG9jay9iYWNrdXA6IG1vdmUgd3JpdGVfZmxhZ3MgY2FsY3Vs
YXRpb24gaW5zaWRlIGJhY2t1cF9qb2JfY3JlYXRlDQo+PiAgICBibG9jay9ibG9jay1jb3B5OiBz
cGxpdCBibG9ja19jb3B5X3NldF9jYWxsYmFja3MgZnVuY3Rpb24NCj4+ICAgIGJsb2NrOiBpbnRy
b2R1Y2UgYmFja3VwLXRvcCBmaWx0ZXIgZHJpdmVyDQo+PiAgICBibG9jay9iYWNrdXA6IHVzZSBi
YWNrdXAtdG9wIGluc3RlYWQgb2Ygd3JpdGUgbm90aWZpZXJzDQo+Pg0KPj4gICBxYXBpL2Jsb2Nr
LWNvcmUuanNvbiAgICAgICB8ICAgOCArLQ0KPj4gICBibG9jay9iYWNrdXAtdG9wLmggICAgICAg
ICB8ICA0MSArKysrKw0KPj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrLWNvcHkuaCB8ICAzMSArKyst
DQo+PiAgIGluY2x1ZGUvYmxvY2svYmxvY2tfaW50LmggIHwgICAxICsNCj4+ICAgYmxvY2svYmFj
a3VwLXRvcC5jICAgICAgICAgfCAyNzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+PiAgIGJsb2NrL2JhY2t1cC5jICAgICAgICAgICAgIHwgMTQ3ICsrKysrLS0tLS0tLS0tLS0t
LQ0KPj4gICBibG9jay9ibG9jay1jb3B5LmMgICAgICAgICB8IDE0MCArKysrKysrKystLS0tLS0t
LQ0KPj4gICBibG9jay9yZXBsaWNhdGlvbi5jICAgICAgICB8ICAgMiArLQ0KPj4gICBibG9ja2Rl
di5jICAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgIGJsb2NrL01ha2VmaWxlLm9ianMgICAg
ICAgIHwgICAxICsNCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA1NiAgICAgfCAgIDggKy0NCj4+
ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzE0MS5vdXQgfCAgIDIgKy0NCj4+ICAgdGVzdHMvcWVtdS1p
b3Rlc3RzLzI1NyAgICAgfCAgIDcgKy0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI1Ny5vdXQg
fCAzMDYgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAxNCBmaWxl
cyBjaGFuZ2VkLCA2MjggaW5zZXJ0aW9ucygrKSwgMzQzIGRlbGV0aW9ucygtKQ0KPj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgYmxvY2svYmFja3VwLXRvcC5oDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBibG9jay9iYWNrdXAtdG9wLmMNCj4gDQo+IFRoYW5rcywgYXBwbGllZCB0byBteSBibG9jayBi
cmFuY2g6DQo+IA0KPiBodHRwczovL2dpdC54YW5jbGljLm1vZS9YYW5DbGljL3FlbXUvY29tbWl0
cy9icmFuY2gvYmxvY2sNCj4gDQo+IE1heA0KPiANCg0KWWF5ISEgVGhhbmsgeW91IQ0KDQotLSAN
CkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

