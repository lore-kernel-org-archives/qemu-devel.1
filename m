Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB394C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8249C206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bZaa6e01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8249C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHRh-0000Jn-Pu
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIDzi-0001H7-UC
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIDzh-00060X-CO
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 11:35:18 -0400
Received: from mail-eopbgr10115.outbound.protection.outlook.com
 ([40.107.1.115]:26550 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIDzg-0005zd-KN; Wed, 09 Oct 2019 11:35:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqYDQC38PhUbmiZpPuePc+Cp38WwZKRbj0rRez/Ud0hsaXXcS4bGA35Ua2oX5N0e0pPDAGVu/AsMG2wsxeJ4GYWRk/ef6R6iQyf0BaW8EUILv24ON+W1jWbsb/1/OdwmCmZLRXL7rr9VWJfqgcsp9ljFWWQ/SJluXlm3PhCXQAJ9154cpPduXpCvPKj4PKq41RxPSWlGCW8QSvu5M7DZgsDrsyHF9TiwxYuzVvJVaZTbhDqZUdyYCLdbPoxpEoIF1VPdDRgUImyAY5wa8cQM3O1DiwrBf6agzaas2Da5ExOEjMc8jSzCk4vcH7GHLj4vEU2MSwqZK5nFfp3vXsyP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KSgw+kRTi590OojqKb9M5Y1uogyptCTiYTJX0tFFi0=;
 b=UGqhn25ZQDSfbLZAc4tbWLZR4xhBdlt6m/VWWwv8K2xmq0sn10c8PlRMjevJR3/z5GY94I3ND+zpKK5aAgew2/vBXc4zgFK2MpmMTmUUAq0WNi3b8JB1p6VmfVDB4nfUVbTC+2F+Wahr4YH2Tz8fg5gbL5tvuoAteXDOXx1IXp+bB+UBM/olW/slo7/IOwzDXgOxRXVxpjoVhGgwRx731ieJQfnjRYiTgpiQfEQkjFfj0aotlOvtdkgQ4Hdq6lDCINLIqRKBGuqTsmAqVyQnjVT2HSzdj4pfYgKhzce9hJwrfZOZ+I6fdtMteH27YiHQN1rdBf+O1aKXPZ57dDXHEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KSgw+kRTi590OojqKb9M5Y1uogyptCTiYTJX0tFFi0=;
 b=bZaa6e019RraHVh/IoT+JappvrfQVI1NXssSIjiyQdDR6v9qDCKi/x9afutk4lKbKAClBZ5kDHkeGfDv6x6UsTbjZFjk2eZD/3ZsaR/yuoRZjp3ax/icrwWq+fR+1uRHvtSVTxcop0JID4s4c4BbJYh0uZi2kZKDcKo4wwFhp5k=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5338.eurprd08.prod.outlook.com (52.133.240.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Wed, 9 Oct 2019 15:35:13 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 15:35:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v9 0/3] NBD reconnect
Thread-Topic: [PATCH v9 0/3] NBD reconnect
Thread-Index: AQHVfn1t6zBcyKMMskq23aKnUBotP6dScUoA
Date: Wed, 9 Oct 2019 15:35:12 +0000
Message-ID: <67747ec4-7f43-c4b6-f221-9ae5a0fc061d@virtuozzo.com>
References: <20191009084158.15614-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191009084158.15614-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191009183510651
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4d696a3-6399-444a-d282-08d74cce4694
x-ms-traffictypediagnostic: DB8PR08MB5338:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5338C7449ACF6E0FF7474472C1950@DB8PR08MB5338.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(396003)(346002)(376002)(136003)(199004)(189003)(53754006)(476003)(2906002)(5640700003)(229853002)(486006)(66446008)(11346002)(66946007)(102836004)(64756008)(66556008)(107886003)(256004)(66476007)(6246003)(6486002)(3846002)(4326008)(6436002)(86362001)(36756003)(6116002)(186003)(26005)(6512007)(66066001)(31696002)(446003)(6506007)(386003)(2616005)(8936002)(52116002)(76176011)(99286004)(25786009)(305945005)(5660300002)(2351001)(71200400001)(14454004)(2501003)(478600001)(71190400001)(8676002)(7736002)(81156014)(6916009)(54906003)(316002)(31686004)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5338;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hhxXu58swXYSDW0slQopXQw0yiaUsCgi4TRBKqOLf+Z1Pq/Bgz4i6j/LqjGOgKK+O8PN2yItpuATIvrxqsQzUuNzRS8J8pBfCjTrh8sSt/iSNG8gicQlh5vem00Z2h/NSODOfluH1hUExpmVf8gjSIztV16eIQH4WS0vF523CSrGzAtGRcf38TLf/eUFJUDtu6rseKzARvT5Tl9FvmQ5UAAVXS5HeSqAxnSuPlk1ms8debBgywPwkTuW5APMR+hiCvdVGj/GGlc/QXE/9aclvYW0Ml424TNqy0VyBMWCxCIWJm5WFOrUOUeqdNx4eNaT7E+G0O8MVwsVu0GnIpHFsHKva6HTRllXGwak2Z2/dQg3bvHuLBy2HYlN2LKCAy6XxAMVpFnJzcM0PwcIb2PnVn6iHMzm6GNLipWvJPTmhTo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <317B1E04B8B3BC42B1DEB50800F9DF60@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d696a3-6399-444a-d282-08d74cce4694
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 15:35:12.9108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: boj0C66zexlwZQme4DWM9rHh13AUQO8YNReACjjasXHIpt310RHkIOi5H0X7509PqIWpBuv7cQtpAQliSJXVT+Qta6NHgy57UaVYkh46vlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5338
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.115
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T29wcywgc29tZWhvdywgSSBjb3BpZWQgc3ViamVjdCBhbmQgZm9yZ2V0IHRvIGZpeCB2OS92MTAu
IEl0J3MgdjEwLg0KDQowOS4xMC4yMDE5IDExOjQxLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IHdyb3RlOg0KPiBIaSBhbGwhDQo+IEhlcmUgaXMgTkJEIHJlY29ubmVjdC4gUHJldmlvdXNs
eSwgaWYgY29ubmVjdGlvbiBmYWlsZWQgYWxsIGN1cnJlbnQNCj4gYW5kIGZ1dHVyZSByZXF1ZXN0
cyB3aWxsIGZhaWwuIEFmdGVyIHRoZSBzZXJpZXMsIG5iZC1jbGllbnQgZHJpdmVyDQo+IHdpbGwg
dHJ5IHRvIHJlY29ubmVjdCB1bmxpbWl0ZWQgdGltZXMuIER1cmluZyBmaXJzdCBAcmVjb25uZWN0
LWRlbGF5DQo+IHNlY29uZHMgb2YgcmVjb25uZWN0aW5nIGFsbCByZXF1ZXN0cyB3aWxsIHdhaXQg
Zm9yIHRoZSBjb25uZWN0aW9uLA0KPiBhbmQgaWYgaXQgaXMgZXN0YWJsaXNoZWQgcmVxdWVzdHMg
d2lsbCBiZSByZXNlbnQuIEFmdGVyDQo+IEByZWNvbm5lY3QtZGVsYXkgcGVyaW9kIGFsbCByZXF1
ZXN0cyB3aWxsIGJlIGZhaWxlZCAodW50aWwgc3VjY2Vzc2Z1bA0KPiByZWNvbm5lY3QpLg0KPiAN
Cj4gdjEwOg0KPiANCj4gMDE6IGFkZCBFcmljJ3Mgci1iDQo+IDAyOiBkcm9wIGRlYWQgYXNzaWdu
bWVudCBsb2NhbF9lcnIgPSBOVUxMDQo+ICAgICAgcy9uYmRfcmVjb25uZWN0X2xvb3AvbmJkX2Nv
X3JlY29ubmVjdF9sb29wLw0KPiAwMzogYXZvaWQgcmFjZSBjb25kaXRpb25zICsgc29tZSBpbXBy
b3ZlbWVudHMNCj4gICAgLSBpbnRyb2R1Y2UgcWVtdV9pb19zaWxlbnRfY2hlY2sgYW5kIHVzZSBp
dCB0byB3YWl0IGZvciBOQkQgc2VydmVyDQo+ICAgICAgc3RhcnQNCj4gICAgLSB1c2Ugc2l6ZSB2
YXJpYWJsZSBpbnN0ZWFkIG9mICc1TScgaW4gYWxsIHBsYWNlcw0KPiAgICAtIHVzZSBzbWFydCB3
YWl0aW5nIGxvb3AgaW5zdGVhZCBvZiBzbGVlcCwgdG8gd2FpdCBmb3Igam9iIHByb2dyZXNzDQo+
ICAgIC0gZG8gc3J2LndhaXQoKSBhZnRlciBzcnYua2lsbCgpLCB0byBiZSBzdXJlIHRoYXQgc2Vy
dmVyIGlzIHN0b3BwZWQNCj4gICAgLSBkcm9wIHRocm90dGxpbmcgZWFybGllcg0KPiAgICAtIGRy
b3AgJ3F1aWNrJyB0YWcgaW4gZ3JvdXAgZmlsZQ0KPiANCj4gVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSAoMyk6DQo+ICAgIHFlbXUtY29yb3V0aW5lLXNsZWVwOiBpbnRyb2R1Y2UgcWVtdV9j
b19zbGVlcF93YWtlDQo+ICAgIGJsb2NrL25iZDogbmJkIHJlY29ubmVjdA0KPiAgICBpb3Rlc3Rz
OiB0ZXN0IG5iZCByZWNvbm5lY3QNCj4gDQo+ICAgaW5jbHVkZS9xZW11L2Nvcm91dGluZS5oICAg
ICAgfCAgMjMgKystDQo+ICAgYmxvY2svbmJkLmMgICAgICAgICAgICAgICAgICAgfCAzMzEgKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAgIHV0aWwvcWVtdS1jb3JvdXRpbmUt
c2xlZXAuYyAgIHwgIDUxICsrKystLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNjQgICAgICAg
IHwgIDk1ICsrKysrKysrKysNCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjY0Lm91dCAgICB8ICAx
MyArKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgICAgIHwgICAxICsNCj4gICB0ZXN0
cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSB8ICAxMSArKw0KPiAgIDcgZmlsZXMgY2hhbmdlZCwg
NDQ3IGluc2VydGlvbnMoKyksIDc4IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDc1
NSB0ZXN0cy9xZW11LWlvdGVzdHMvMjY0DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3Fl
bXUtaW90ZXN0cy8yNjQub3V0DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXIN
Cg==

