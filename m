Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11702C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB26207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HspdLgrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB26207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itT7K-0004MG-KJ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itT69-0003Nt-K6
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itT65-0002sx-3E
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:11:53 -0500
Received: from mail-eopbgr140113.outbound.protection.outlook.com
 ([40.107.14.113]:16874 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itT64-0002sa-SD
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:11:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvjFClkTHMpJtQxTlcJ6URogYqT8sxfryvL4O4RmeK1JFVf3UsMxuVoxvwej9xQUwuYPml5gcBV+xEHFClTX9raScBMXmMSpJIB+wqXvS+WyzBInFtxxtuix2RNGY4WNgelseP+RWYm9zzewKdNNDNdPKRUWs5rLA162+jbfuhjbeU+M7oiniTNyeNHethLQ+cDlnEhvfh21pYYHbhS3lElBlTP2NY/42+nJ/BDh/gbFM6Qx2j9OKFhq6i3QDm9L4u+tQn4j7Ftz9Bk9oKh9os3+NdT/eD/8ye4pS9U8hjs0F5DeSLJyPh6bXCqvTTGlpdpgAaoRsWQWDgux1HXFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyQRYzXlcROlZKczFg0sNR/0WrD25nD8vA1QPhciVhY=;
 b=QJnJKAbuprC9r895BkwamnG9mOlpHHZE50OB8lFfE0Bq9LIekNo2RbDouWZPYEzfqxtg4TC9425l2hCzDy9y2Cwc/ApltcTRJ1RxzqpWPavh7qdpMumaGKs1QB9IJDvcUtI0VpV29bfDA8JZnuiHCWFPWsE05gEgeuL3I46Fr1E5xcc7flkS0TYBD1u2BxHqWNuNXZfRvU5Xl5PcumjGY4AkNwtJau8PYR+n1JkpihmQqQf0XDq84vn5q4qBNqwTuz/hTkWYQSuM/4uYBZeZuLDE5Y5iLADAMc5qvxxHOXSgnOiRCfnSYXzrGi27o0kx985AQl4kCL96FoI3e+AcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyQRYzXlcROlZKczFg0sNR/0WrD25nD8vA1QPhciVhY=;
 b=HspdLgrvCGmyu7hxVq2JuCvSUqQe0dJ6nV4mU+NRYeikWM6Vua/KP/jWlX9i26u2byiE++P2a/qCmUEdOpQpKZ+8DuHDw1O+nzYxVBwnP9Hk/3ipxWYy/cs0fA9L6z7oj/ydLz39hOQKjY+0+dUnutbVbgraXCfzYxrnMvPqwrY=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5016.eurprd08.prod.outlook.com (10.255.122.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 09:11:46 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 09:11:46 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR07CA0016.eurprd07.prod.outlook.com (2603:10a6:7:67::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.11 via Frontend Transport; Mon, 20 Jan 2020 09:11:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [RFC] migration: introduce failed-unrecovarable status
Thread-Topic: [RFC] migration: introduce failed-unrecovarable status
Thread-Index: AQHVtaJxYJ2SVtAyAkO6QdSCxVB89Kfzd/8A
Date: Mon, 20 Jan 2020 09:11:46 +0000
Message-ID: <2e34943b-60c1-94e0-87b0-47ea8b257be4@virtuozzo.com>
References: <20191218125512.5446-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191218125512.5446-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:7:67::26) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120121144414
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac055526-ec11-4dc3-2cb9-08d79d88c646
x-ms-traffictypediagnostic: AM6PR08MB5016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB5016E36D09EEF403D6648DAEC1320@AM6PR08MB5016.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(396003)(39840400004)(136003)(189003)(199004)(2616005)(16526019)(8936002)(966005)(956004)(478600001)(31696002)(31686004)(52116002)(4326008)(86362001)(2906002)(107886003)(81166006)(54906003)(16576012)(66556008)(66446008)(81156014)(186003)(66476007)(64756008)(66946007)(8676002)(6916009)(71200400001)(316002)(26005)(6486002)(5660300002)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5016;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w6JjEfXMpXCPZma0YM/DpbyGVVC49XCI6PgsQjJDa6IrmaSEaPzy//aoWdKSvwVUztmYBZNwdHU85CiOO0bvHBpASOPvqQVZbjAQB0ze8agz8Fe1XtE5qVYqBfEmv5oJCViadcc9Asx4ETcZnI0chK5oJXW7mwRb59sR4YMeDHxw6p1a2zBL7JHjbUaxh68Cz289IHM75fKEQWVLpPkKOX91JP7XRH/MGxsBsS+wv96WDEg3oD5fIOaAojXuLx6EpFY+0TQGcWA3+oHx1C/oGNr3v0AshmxOPyI1nNZVmwkJMg4wwNnD26buO1LHy9pYpBwhWlnKXw+xZNBwBT80dAhxZZE0LGVO4N9QHHH8hbYQNXyIpWpHEGunR3RxvJd8AJVKntxpbGNOia4Wdl5dqXk5nXIUnSpftDJsp1CEL82O4ynITM4PAQprcv3vP8dzRxcikBRvc8jfQdUdsmSoJulxuZcYw6fEsot9Hb9HSPdcKBXRJk5rw28VOOmSwCwdosDKbCLirNDSsaFWuTEPHg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A945D642BF3AC541A826C496CBEE70FB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac055526-ec11-4dc3-2cb9-08d79d88c646
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 09:11:46.5124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDgTophbhs8bCBYPz+rJWk4cHgHtszy6vsMiJJs18+nzC35MzSsgQrb6daZljWrZBaDY761Awq3FbwgjLij3IsT3PBzOwYeVhZU0Xs/MCkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.113
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQoxOC4xMi4yMDE5IDE1OjU1LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBXZSBzaG91bGQgbm90IHN0YXJ0IHNvdXJjZSB2bSBhdXRvbWF0aWNhbGx5LCBpZiB0
aGUgZXJyb3Igb2NjdXJlZCBhZnRlcg0KPiB0YXJnZXQgYWNjZXNzZWQgZGlza3MsIG9yIGlmIHdl
IGZhaWxlZCB0byBpbnZhbGlkYXRlIG5vZGVzLg0KPiANCj4gQWxzbywgZml4LCB0aGF0IHdlIG5l
ZWQgaW52YWxpZGF0ZSBldmVuIGlmIGJkcnZfaW5hY3RpdmF0ZV9hbGwoKQ0KPiBmYWlsZWQsIGFz
IGluIHRoaXMgY2FzZSBpdCBzdGlsbCBtYXkgc3VjY2Vzc2Z1bGx5IGluYWN0aXZhdGUgc29tZSBv
Zg0KPiB0aGUgbm9kZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IC0tLQ0KPiANCj4gSGkgYWxs
IQ0KPiANCj4gSXQncyBhbiBpbnZlc3RpZ2F0aW9uIG9uIHRvcCBvZiBvbGQgdGhyZWFkDQo+IGh0
dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4LTA2L21zZzAy
MzU1Lmh0bWwNCj4gDQo+IEVpdGhlciBJJ20gbWlzc2luZyBzb21ldGhpbmcsIG9yIHdlIG5lZWQg
dGhpcyBwYXRjaC4gSXQncyBhIGRyYWZ0LCBtYXkNCj4gYmUgbmVlZCB0byBzcGxpdCBpdCBpbnRv
IDItMyBzbWFsbCBwYXRjaGVzLiBTdGlsbCBJJ2QgbGlrZSB0byBnZXQNCj4gZ2VuZXJhbCBhcHBy
b3ZhbCBhdCBmaXJzdCwgbWF5IGJlIEknbSBkb2luZyBzb21ldGhpbmcgd3JvbmcuDQo+IA0KPiBB
bHNvLCB0aGVyZSBtYXkgYmUgb3RoZXIgbWlncmF0aW9uIGZhaWx1cmUgY2FzZXMgbGlrZSB0aGlz
Lg0KPiANCj4gICBxYXBpL21pZ3JhdGlvbi5qc29uICAgfCAgNyArKysrKy0tDQo+ICAgbWlncmF0
aW9uL21pZ3JhdGlvbi5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
DQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9xYXBpL21pZ3JhdGlvbi5qc29uIGIvcWFwaS9taWdyYXRpb24u
anNvbg0KPiBpbmRleCBiNzM0OGQwYzhiLi45MGZhNjI1Y2JiIDEwMDY0NA0KPiAtLS0gYS9xYXBp
L21pZ3JhdGlvbi5qc29uDQo+ICsrKyBiL3FhcGkvbWlncmF0aW9uLmpzb24NCj4gQEAgLTEyNSw2
ICsxMjUsOSBAQA0KPiAgICMNCj4gICAjIEBmYWlsZWQ6IHNvbWUgZXJyb3Igb2NjdXJyZWQgZHVy
aW5nIG1pZ3JhdGlvbiBwcm9jZXNzLg0KPiAgICMNCj4gKyMgQGZhaWxlZC11bnJlY292ZXJhYmxl
OiBwb3N0Y29weSBmYWlsZWQgYWZ0ZXIgbm8gcmV0dXJuIHBvaW50LCB3aGVuIGRpc2tzIG1heQ0K
PiArIyAgICAgICAgICAgICAgICAgICAgICAgIGFscmVhZHkgYmUgYWNjZXNzZWQgYnkgdGFyZ2V0
IFFlbXUgcHJvY2Vzcy4gKHNpbmNlIDUuMCkNCj4gKyMNCj4gICAjIEBjb2xvOiBWTSBpcyBpbiB0
aGUgcHJvY2VzcyBvZiBmYXVsdCB0b2xlcmFuY2UsIFZNIGNhbiBub3QgZ2V0IGludG8gdGhpcw0K
PiAgICMgICAgICAgIHN0YXRlIHVubGVzcyBjb2xvIGNhcGFiaWxpdHkgaXMgZW5hYmxlZCBmb3Ig
bWlncmF0aW9uLiAoc2luY2UgMi44KQ0KPiAgICMNCj4gQEAgLTE0Miw4ICsxNDUsOCBAQA0KPiAg
IHsgJ2VudW0nOiAnTWlncmF0aW9uU3RhdHVzJywNCj4gICAgICdkYXRhJzogWyAnbm9uZScsICdz
ZXR1cCcsICdjYW5jZWxsaW5nJywgJ2NhbmNlbGxlZCcsDQo+ICAgICAgICAgICAgICAgJ2FjdGl2
ZScsICdwb3N0Y29weS1hY3RpdmUnLCAncG9zdGNvcHktcGF1c2VkJywNCj4gLSAgICAgICAgICAg
ICdwb3N0Y29weS1yZWNvdmVyJywgJ2NvbXBsZXRlZCcsICdmYWlsZWQnLCAnY29sbycsDQo+IC0g
ICAgICAgICAgICAncHJlLXN3aXRjaG92ZXInLCAnZGV2aWNlJywgJ3dhaXQtdW5wbHVnJyBdIH0N
Cj4gKyAgICAgICAgICAgICdwb3N0Y29weS1yZWNvdmVyJywgJ2NvbXBsZXRlZCcsICdmYWlsZWQn
LCAnZmFpbGVkLXVucmVjb3ZlcmFibGUnLA0KPiArICAgICAgICAgICAgJ2NvbG8nLCAncHJlLXN3
aXRjaG92ZXInLCAnZGV2aWNlJywgJ3dhaXQtdW5wbHVnJyBdIH0NCj4gICANCj4gICAjIw0KPiAg
ICMgQE1pZ3JhdGlvbkluZm86DQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vbWlncmF0aW9uLmMg
Yi9taWdyYXRpb24vbWlncmF0aW9uLmMNCj4gaW5kZXggMzU0YWQwNzJmYS4uMDA2ODRmZGVmOCAx
MDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL21pZ3JhdGlvbi5jDQo+ICsrKyBiL21pZ3JhdGlvbi9t
aWdyYXRpb24uYw0KPiBAQCAtMjU3Niw3ICsyNTc2LDE0IEBAIHN0YXRpYyBpbnQgcG9zdGNvcHlf
c3RhcnQoTWlncmF0aW9uU3RhdGUgKm1zKQ0KPiAgICAgICBRRU1VRmlsZSAqZmI7DQo+ICAgICAg
IGludDY0X3QgdGltZV9hdF9zdG9wID0gcWVtdV9jbG9ja19nZXRfbXMoUUVNVV9DTE9DS19SRUFM
VElNRSk7DQo+ICAgICAgIGludDY0X3QgYmFuZHdpZHRoID0gbWlncmF0ZV9tYXhfcG9zdGNvcHlf
YmFuZHdpZHRoKCk7DQo+IC0gICAgYm9vbCByZXN0YXJ0X2Jsb2NrID0gZmFsc2U7DQo+ICsNCj4g
KyAgICAvKg0KPiArICAgICAqIHJlY292ZXJhYmxlX2ZhaWx1cmUNCj4gKyAgICAgKiBBIGZhaWx1
cmUgaGFwcGVuZWQgZWFybHkgZW5vdWdoIHRoYXQgd2Uga25vdyB0aGUgZGVzdGluYXRpb24gaGFz
bid0DQo+ICsgICAgICogYWNjZXNzZWQgYmxvY2sgZGV2aWNlcywgc28gd2UncmUgc2FmZSB0byBy
ZWNvdmVyLg0KPiArICAgICAqLw0KPiArICAgIGJvb2wgcmVjb3ZlcmFibGVfZmFpbHVyZSA9IHRy
dWU7DQo+ICsgICAgYm9vbCBpbmFjdGl2YXRlZCA9IGZhbHNlOw0KPiAgICAgICBpbnQgY3VyX3N0
YXRlID0gTUlHUkFUSU9OX1NUQVRVU19BQ1RJVkU7DQo+ICAgICAgIGlmICghbWlncmF0ZV9wYXVz
ZV9iZWZvcmVfc3dpdGNob3ZlcigpKSB7DQo+ICAgICAgICAgICBtaWdyYXRlX3NldF9zdGF0ZSgm
bXMtPnN0YXRlLCBNSUdSQVRJT05fU1RBVFVTX0FDVElWRSwNCj4gQEAgLTI2MDAsMTEgKzI2MDcs
MTEgQEAgc3RhdGljIGludCBwb3N0Y29weV9zdGFydChNaWdyYXRpb25TdGF0ZSAqbXMpDQo+ICAg
ICAgICAgICBnb3RvIGZhaWw7DQo+ICAgICAgIH0NCj4gICANCj4gKyAgICBpbmFjdGl2YXRlZCA9
IHRydWU7DQo+ICAgICAgIHJldCA9IGJkcnZfaW5hY3RpdmF0ZV9hbGwoKTsNCj4gICAgICAgaWYg
KHJldCA8IDApIHsNCj4gICAgICAgICAgIGdvdG8gZmFpbDsNCj4gICAgICAgfQ0KPiAtICAgIHJl
c3RhcnRfYmxvY2sgPSB0cnVlOw0KPiAgIA0KPiAgICAgICAvKg0KPiAgICAgICAgKiBDYXVzZSBh
bnkgbm9uLXBvc3Rjb3BpYWJsZSwgYnV0IGl0ZXJhdGl2ZSBkZXZpY2VzIHRvDQo+IEBAIC0yNjgy
LDcgKzI2ODksNyBAQCBzdGF0aWMgaW50IHBvc3Rjb3B5X3N0YXJ0KE1pZ3JhdGlvblN0YXRlICpt
cykNCj4gICAgICAgICAgIGdvdG8gZmFpbF9jbG9zZWZiOw0KPiAgICAgICB9DQo+ICAgDQo+IC0g
ICAgcmVzdGFydF9ibG9jayA9IGZhbHNlOw0KPiArICAgIHJlY292ZXJhYmxlX2ZhaWx1cmUgPSBm
YWxzZTsNCj4gICANCj4gICAgICAgLyogTm93IHNlbmQgdGhhdCBibG9iICovDQo+ICAgICAgIGlm
IChxZW11X3NhdmV2bV9zZW5kX3BhY2thZ2VkKG1zLT50b19kc3RfZmlsZSwgYmlvYy0+ZGF0YSwg
YmlvYy0+dXNhZ2UpKSB7DQo+IEBAIC0yNzE2LDI2ICsyNzIzLDI4IEBAIHN0YXRpYyBpbnQgcG9z
dGNvcHlfc3RhcnQoTWlncmF0aW9uU3RhdGUgKm1zKQ0KPiAgICAgICByZXQgPSBxZW11X2ZpbGVf
Z2V0X2Vycm9yKG1zLT50b19kc3RfZmlsZSk7DQo+ICAgICAgIGlmIChyZXQpIHsNCj4gICAgICAg
ICAgIGVycm9yX3JlcG9ydCgicG9zdGNvcHlfc3RhcnQ6IE1pZ3JhdGlvbiBzdHJlYW0gZXJyb3Jl
ZCIpOw0KPiAtICAgICAgICBtaWdyYXRlX3NldF9zdGF0ZSgmbXMtPnN0YXRlLCBNSUdSQVRJT05f
U1RBVFVTX1BPU1RDT1BZX0FDVElWRSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IE1JR1JBVElPTl9TVEFUVVNfRkFJTEVEKTsNCj4gKyAgICAgICAgZ290byBmYWlsOw0KPiAgICAg
ICB9DQo+ICAgDQo+IC0gICAgcmV0dXJuIHJldDsNCj4gKyAgICByZXR1cm4gMDsNCj4gICANCj4g
ICBmYWlsX2Nsb3NlZmI6DQo+ICAgICAgIHFlbXVfZmNsb3NlKGZiKTsNCj4gICBmYWlsOg0KPiAg
ICAgICBtaWdyYXRlX3NldF9zdGF0ZSgmbXMtPnN0YXRlLCBNSUdSQVRJT05fU1RBVFVTX1BPU1RD
T1BZX0FDVElWRSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgTUlHUkFUSU9OX1NUQVRV
U19GQUlMRUQpOw0KPiAtICAgIGlmIChyZXN0YXJ0X2Jsb2NrKSB7DQo+IC0gICAgICAgIC8qIEEg
ZmFpbHVyZSBoYXBwZW5lZCBlYXJseSBlbm91Z2ggdGhhdCB3ZSBrbm93IHRoZSBkZXN0aW5hdGlv
biBoYXNuJ3QNCj4gLSAgICAgICAgICogYWNjZXNzZWQgYmxvY2sgZGV2aWNlcywgc28gd2UncmUg
c2FmZSB0byByZWNvdmVyLg0KPiAtICAgICAgICAgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAg
ICByZWNvdmVyYWJsZV9mYWlsdXJlID8gTUlHUkFUSU9OX1NUQVRVU19GQUlMRUQgOg0KPiArICAg
ICAgICAgICAgICAgICAgICAgIE1JR1JBVElPTl9TVEFUVVNfRkFJTEVEX1VOUkVDT1ZFUkFCTEUp
Ow0KPiArICAgIGlmIChyZWNvdmVyYWJsZV9mYWlsdXJlICYmIGluYWN0aXZhdGVkKSB7DQo+ICAg
ICAgICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4gICANCj4gICAgICAgICAgIGJkcnZf
aW52YWxpZGF0ZV9jYWNoZV9hbGwoJmxvY2FsX2Vycik7DQo+ICAgICAgICAgICBpZiAobG9jYWxf
ZXJyKSB7DQo+ICAgICAgICAgICAgICAgZXJyb3JfcmVwb3J0X2Vycihsb2NhbF9lcnIpOw0KPiAr
ICAgICAgICAgICAgLyoNCj4gKyAgICAgICAgICAgICAqIFdlIGZhaWxlZCB0byBpbnZhbGlkYXRl
LCBzbyB3ZSBtdXN0IG5vdCBzdGFydCB2bSBhdXRvbWF0aWNhbGx5Lg0KPiArICAgICAgICAgICAg
ICogVXNlciBtYXkgcmV0cnkgaW52YWxpZGF0aW9uIGFuZCBzdGFydCBieSBjb250IHFtcCBjb21t
YW5kLg0KPiArICAgICAgICAgICAgICovDQo+ICsgICAgICAgICAgICBtcy0+dm1fd2FzX3J1bm5p
bmcgPSBmYWxzZTsNCj4gICAgICAgICAgIH0NCj4gICAgICAgfQ0KPiAgICAgICBxZW11X211dGV4
X3VubG9ja19pb3RocmVhZCgpOw0KPiBAQCAtMzE5NCw5ICszMjAzLDEyIEBAIHN0YXRpYyB2b2lk
IG1pZ3JhdGlvbl9pdGVyYXRpb25fZmluaXNoKE1pZ3JhdGlvblN0YXRlICpzKQ0KPiAgICAgICAg
ICAgcy0+dm1fd2FzX3J1bm5pbmcgPSB0cnVlOw0KPiAgICAgICAgICAgLyogRmFsbHRocm91Z2gg
Ki8NCj4gICAgICAgY2FzZSBNSUdSQVRJT05fU1RBVFVTX0ZBSUxFRDoNCj4gKyAgICBjYXNlIE1J
R1JBVElPTl9TVEFUVVNfRkFJTEVEX1VOUkVDT1ZFUkFCTEU6DQo+ICAgICAgIGNhc2UgTUlHUkFU
SU9OX1NUQVRVU19DQU5DRUxMRUQ6DQo+ICAgICAgIGNhc2UgTUlHUkFUSU9OX1NUQVRVU19DQU5D
RUxMSU5HOg0KPiAtICAgICAgICBpZiAocy0+dm1fd2FzX3J1bm5pbmcpIHsNCj4gKyAgICAgICAg
aWYgKHMtPnZtX3dhc19ydW5uaW5nICYmDQo+ICsgICAgICAgICAgICBzLT5zdGF0ZSAhPSBNSUdS
QVRJT05fU1RBVFVTX0ZBSUxFRF9VTlJFQ09WRVJBQkxFKQ0KPiArICAgICAgICB7DQo+ICAgICAg
ICAgICAgICAgdm1fc3RhcnQoKTsNCj4gICAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAg
ICAgaWYgKHJ1bnN0YXRlX2NoZWNrKFJVTl9TVEFURV9GSU5JU0hfTUlHUkFURSkpIHsNCj4gDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

