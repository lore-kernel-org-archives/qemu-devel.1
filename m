Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A2CC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 14:48:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD24F2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 14:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Rd3/nNyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD24F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxBd2-00081P-VC
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 10:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37006)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxBbt-000705-7x
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxBbq-0005o1-OD
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:47:44 -0400
Received: from mail-eopbgr50123.outbound.protection.outlook.com
 ([40.107.5.123]:9377 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxBbq-0005nS-50; Mon, 12 Aug 2019 10:47:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7vN6UBiar/d5QHCkjgxUnt3jX6OStjbGQgGfmA7jRGZom30BxF1pApQKwvzBlSgJPSf2dnloiBQZk+9Wgi236fIFn8i250Z6YktvrCFL0R9KSIhEEAaGfY2T0Z/EwX4sNQBwrDWrnEqSldDHif+sildQCCUvqsakmZDKylyfpCjH4QiQMoDFR26D4hM9Otd1fyx3P7vy7uFAk7tetrUgzDOcAqftnhCIH6Wc2lbV9JB7VL8HZtkcb1u3byK3x+hNPbGMghW9teQ83ooTEClblMs+4R4gDHAowoTZpbeVyubzg+FH2j0tJhilO3PEGWJcFk9hiWkdSR4Lzz0rOea+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBX8N8uxkrE6Uq9rtIpcaRHWl28GypIKvk/fTv77vYc=;
 b=HFZux8IQZT0CECWGP3i6iaD2dD312XzRiAp7AJlZ2evvi9IQVPUtSArAw+209NVLkbetzcpZ7xrGAL9w2iCbY8pinXiOGnT/UPf9zX5g4mlRwTzIN6LQPb7m97+VcsBGJgqQCPS8HVw3HvBur2C1F5FZR2I+UqlnQlcx5JAh0T0AqaBcRfzZ3FyMbc6OfF0+yKnc+OxREbI7HntyqvB5XT/FzNVLN1fjAv9/t2nsFi/sVfhh5GQD2OxVmR61UKxF1oTR89KR8VZXwdGAWl7LhO5GY6I+IyCxat23hhJ/vEl0u9OFze0qZRdEKhxsjIaCJAmDpCo/KvSLm9itKLkTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBX8N8uxkrE6Uq9rtIpcaRHWl28GypIKvk/fTv77vYc=;
 b=Rd3/nNyCTcrUZ0AT2/VkcQd74UzA4hSIoneBRoGw5Vxr28ivUiGT3Q/LqZau2OOdHZ3hbxFpWpDVshXcX4cvbHvSQjEUS6h75kL+n5ho79AmctpA6c1PqQtdTaajP4EepM9Z++rnY3NSKdfBPF6zzTb1bCMXhGCplam0zM16Eq0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4187.eurprd08.prod.outlook.com (20.179.9.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.22; Mon, 12 Aug 2019 14:47:40 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:47:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 1/3] vdi: Make block_status recurse for fixed images
Thread-Index: AQHVQwFdJNt2TM9ks0SHntbJ24gB1ab3s8GA
Date: Mon, 12 Aug 2019 14:47:40 +0000
Message-ID: <fc17bae2-a916-3c0e-b944-f2fd60d4ecca@virtuozzo.com>
References: <20190725155512.9827-1-mreitz@redhat.com>
 <20190725155512.9827-2-mreitz@redhat.com>
In-Reply-To: <20190725155512.9827-2-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0012.eurprd07.prod.outlook.com
 (2603:10a6:7:67::22) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812174737479
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dbcc906-969f-4c94-cd48-08d71f340632
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4187; 
x-ms-traffictypediagnostic: DB8PR08MB4187:
x-microsoft-antispam-prvs: <DB8PR08MB41878C4B42D573DCEA21E87DC1D30@DB8PR08MB4187.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(39840400004)(366004)(136003)(376002)(189003)(199004)(81156014)(81166006)(6512007)(8676002)(31686004)(99286004)(14454004)(7736002)(11346002)(486006)(2616005)(2906002)(476003)(25786009)(446003)(478600001)(8936002)(54906003)(36756003)(110136005)(86362001)(229853002)(6436002)(66066001)(6486002)(31696002)(102836004)(52116002)(2501003)(26005)(316002)(76176011)(71190400001)(71200400001)(66946007)(66446008)(64756008)(66556008)(6506007)(386003)(186003)(66476007)(6246003)(256004)(14444005)(5660300002)(6116002)(3846002)(53936002)(4326008)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4187;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GD0zQfWRx+wOTxePnKNfHFCHzhVrEV5Dw8DWFaLKJOdWLrwvgymjGdSk+9HgNIXPe6JbXn4kra6IO1IkT/3bRx2O5WCWFvtYEwPH3HydHUUWF/CWcjATsu65+QqafaLpXWhQbeqlbO5ggbGR2DKdU7NlPrUO3nWFyOMudEI7Waazb+A2da3KwxYMjA5shc+ASEj1WhuQuuOXEo5+kP3DPhjV7I/Vuh0CSHG2y+cceTu8XKxdL0YjrZ2KkHDWn6yMaW9cxNONvD8DpVcrLZPx975+Mqq/j+vubuM+jA8/tiG0uuoBooFH4fSzFbpyiVy9sNhwEr1uF5BFAgkkeR1LF+boqTsExk1hJG7gAgbvrjJORt5P79NNrD1ZqmrDkSYmh399NEfmu7fOr2E2kSHJD+RFPSMUbGslAWZP7exEmqU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E2EB95FFF13DA4BAFA48C6758EC47E1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbcc906-969f-4c94-cd48-08d71f340632
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:47:40.0809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2fONfbFI/3xGJtEHBUWRz9rb07doYyMBPLAEuLlKLqmYLCjM5jc5EXK1mjnwcPdE8uT5u7h7Vk/asmj98BnJhXXvRsMPQmWVEDbb7YSNxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4187
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.123
Subject: Re: [Qemu-devel] [PATCH 1/3] vdi: Make block_status recurse for
 fixed images
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjUuMDcuMjAxOSAxODo1NSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBTdWdnZXN0ZWQtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4gRml4
ZXM6IDY5ZjQ3NTA1ZWU2NmFmYWE1MTMzMDVkZTBjMTg5NWEyMjRlNTJjNDUNCj4gU2lnbmVkLW9m
Zi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCg0KU29ycnkgZm9yIGEgZGVsYXks
IEkgdGhvdWdodCB0aGF0IG1haW50YWluZXJzIG9mIHRoZSBmb3JtYXRzIHdpbGwgYXBwcm92ZSB0
aGVzZSBwYXRjaGVzIDspDQoNCkRvbid0IGtub3cgdmRpIGNvZGUsIGJ1dCBpdCBpcyB3aGF0IEkg
c3VnZ2VzdGVkIGFuZCBzZWVtcyB0byBiZSB0aGUgcmlnaHQgdGhpbmcgdG8gZG86DQoNClJldmll
d2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6
by5jb20+DQoNCj4gLS0tDQo+ICAgYmxvY2svdmRpLmMgfCAzICsrLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9i
bG9jay92ZGkuYyBiL2Jsb2NrL3ZkaS5jDQo+IGluZGV4IGI5ODQ1YTRjYmQuLjQwZDQwYzM0ZDUg
MTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3ZkaS5jDQo+ICsrKyBiL2Jsb2NrL3ZkaS5jDQo+IEBAIC01
NDIsNyArNTQyLDggQEAgc3RhdGljIGludCBjb3JvdXRpbmVfZm4gdmRpX2NvX2Jsb2NrX3N0YXR1
cyhCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICAgICAgKm1hcCA9IHMtPmhlYWRlci5vZmZzZXRf
ZGF0YSArICh1aW50NjRfdClibWFwX2VudHJ5ICogcy0+YmxvY2tfc2l6ZSArDQo+ICAgICAgICAg
ICBpbmRleF9pbl9ibG9jazsNCj4gICAgICAgKmZpbGUgPSBicy0+ZmlsZS0+YnM7DQo+IC0gICAg
cmV0dXJuIEJEUlZfQkxPQ0tfREFUQSB8IEJEUlZfQkxPQ0tfT0ZGU0VUX1ZBTElEOw0KPiArICAg
IHJldHVybiBCRFJWX0JMT0NLX0RBVEEgfCBCRFJWX0JMT0NLX09GRlNFVF9WQUxJRCB8DQo+ICsg
ICAgICAgIChzLT5oZWFkZXIuaW1hZ2VfdHlwZSA9PSBWRElfVFlQRV9TVEFUSUMgPyBCRFJWX0JM
T0NLX1JFQ1VSU0UgOiAwKTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGludCBjb3JvdXRpbmVf
Zm4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

