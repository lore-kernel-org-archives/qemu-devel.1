Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA976C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAA32089D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tHUWIhX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAA32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXiui-0004dG-QY
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 04:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXit8-0003Ga-SK
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:36:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXit5-0007TN-SY
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:36:33 -0500
Received: from mail-eopbgr00125.outbound.protection.outlook.com
 ([40.107.0.125]:39805 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXit4-0007Qj-Il; Thu, 21 Nov 2019 04:36:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIzzBfp46ooq4HW7NmJUs83NcOhEsxp0XepzCUN8Sc0qIIj75hvPJr0N3QdMbnmAZCIFjBLwKKTT8nCIz0YJ2k/WHVQthIAXqRk+fgZSgn9fEwBK2swxtn9M0QknqdZfC5/X8rK4yOw+ewnLQpOMjP35xv08YtE8h3k6Hf4rNVd7GlJEx3x15RWWJXBTX/AL1tTPN76MpkkQXzRhh6qxT0U9Yo+YoW4QoOyxsngMRH9NVd3zmtuLlSpQTYnMXRrUskMcgOIuc4iF1UxncJ7TKet6bDlZsWZgZCnyOFv5ZZq6GbVzl7OARoZdsliHzBx8kTxjkhbpYL8WQsrpmu6ksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0BEg7gOVAASnB7K8bt9yn9Tk30mAZM5eKW2QYg8Ye4=;
 b=b283LAyQcqy1VHPiCYL4t3g2TtOxxjt/AAFXB/vP+wL+6WoXXexEQVQx+FbC7HqV9tpWOhzdTMjmDq/ZkBIhp87LDziQJczZq/iOhgHuPikknlyzd9ms176sFrfFUpo1zAQ1dNlc/vz1FAcEXFSS79N4IrGitVHKESu4oEmFSHTnLEDdtPUPsERvCuBSCB4DkEWrh2uQ8ZKj6le1sEN/fyB2Xrfjjiujy9vTtzagWRTe+TeoXN0+Z1+sVJjItzTQzO2xk8zl62eLZ46rqbJfdn9fgaE8ywWgjLP9RC25608009tcZlBsCDwW6S2Mu5NbMCROJDiyZ+URD7fSs/RNXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0BEg7gOVAASnB7K8bt9yn9Tk30mAZM5eKW2QYg8Ye4=;
 b=tHUWIhX2ai5pdn0VyXTNDfjRA56oxS/lXZYAyzWBs0n7pwQf0ilfsO7Kp1l9ilQ0JZ7f1yuRmJJSZ0sBPQnpvAdkEh/Q7Ovxw3evf/9Li6KbG/XZXmSOQZU26xmrajAyVwfatQchX8pnQn2vYS88ZKd5DM5dIU8HaFlNY8k18hU=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5272.eurprd08.prod.outlook.com (10.255.122.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 21 Nov 2019 09:36:27 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 09:36:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 6/6] iotests: Test committing to short backing file
Thread-Topic: [PATCH v2 6/6] iotests: Test committing to short backing file
Thread-Index: AQHVn9KxRltA7uNPbUqM02ssz4EKHKeUkvCAgADLsgA=
Date: Thu, 21 Nov 2019 09:36:27 +0000
Message-ID: <8e9bdd41-abed-7481-c19c-6b888ad4b0ff@virtuozzo.com>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-7-kwolf@redhat.com>
 <879ef61a-97fc-24b6-00e8-94145d946af5@redhat.com>
In-Reply-To: <879ef61a-97fc-24b6-00e8-94145d946af5@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0014.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::24) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191121123624866
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a110a5ad-0b89-46af-c87b-08d76e6647e8
x-ms-traffictypediagnostic: AM6PR08MB5272:
x-microsoft-antispam-prvs: <AM6PR08MB5272A55B65F1DF632263F602C14E0@AM6PR08MB5272.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39830400003)(366004)(346002)(376002)(189003)(199004)(478600001)(66066001)(11346002)(446003)(2616005)(2501003)(71190400001)(71200400001)(66476007)(64756008)(6436002)(66556008)(99286004)(5660300002)(316002)(102836004)(386003)(53546011)(81156014)(52116002)(81166006)(6116002)(110136005)(8676002)(3846002)(54906003)(66446008)(6506007)(66946007)(256004)(14444005)(186003)(76176011)(8936002)(26005)(229853002)(36756003)(2906002)(31696002)(86362001)(31686004)(14454004)(6512007)(6486002)(6246003)(305945005)(7736002)(4326008)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5272;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZS9L69lMPCdd2mU4gQ4KyGY97lkIlOBxPVEFxLJDCQu2KYydn+zvlTnHVImJVkBt5C/7HmHWZAtOqTvrRrmAiTSrK/e+AA48qZHYsoDKJcfCFoAZ3OwmiCBKphQrS6InuGe9wxYj6MbOYniavfiY5eQTpwFOiVpQSDCr967DOT9n+BtZwSSCV/jswVrbkPAoK0QqYwoowpwDKN9E6N11ppSTgPPMXKTVq7fsloooNCGoZEjzGBCr49EJ68ee5DyS6A7RH6irHoTwVMOXpJ2AQKQPlrfJ2RgZXzoyxGf9JTP3lr8FkRV8+mRVw2KfbWe2jGKU1LXtwmGiAz6Wc2roVgmCDn+98KN6qKkvu7QlSPI8OhNNLVfCe+zRxqGqU+gqnjY49Z063ypgCqYTSZqVQEBg0VvY3VYMF3CHUuRwAx64jKc/DZoEll4wFrSoAucM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9296ADDBDAF7B142B08857AFDEFB2F50@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a110a5ad-0b89-46af-c87b-08d76e6647e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 09:36:27.0500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTXN9HkFGlkQI92Rgb+MoLdGFPg8p5wskAYe/0VF5nttgRADV+cDJsaClMPgwpswqrYvt2WdGTeczAWMiM77YcdveL/gcJx+oYWkh0hqrFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5272
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.125
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
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMTEuMjAxOSAwOjI3LCBFcmljIEJsYWtlIHdyb3RlOg0KPiBPbiAxMS8yMC8xOSAxMjo0NSBQ
TSwgS2V2aW4gV29sZiB3cm90ZToNCj4+IFNpZ25lZC1vZmYtYnk6IEtldmluIFdvbGYgPGt3b2xm
QHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+IMKgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNzTCoMKgwqDC
oMKgwqDCoCB8IDE0MSArKysrKysrKysrKysrKysrKysrKysNCj4+IMKgIHRlc3RzL3FlbXUtaW90
ZXN0cy8yNzQub3V0wqDCoMKgIHwgMjI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+IMKgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+
PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSB8wqDCoCAyICstDQo+PiDCoCA0IGZp
bGVzIGNoYW5nZWQsIDM3MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+PiDCoCBjcmVh
dGUgbW9kZSAxMDA3NTUgdGVzdHMvcWVtdS1pb3Rlc3RzLzI3NA0KPj4gwqAgY3JlYXRlIG1vZGUg
MTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0cy8yNzQub3V0DQo+Pg0KPiANCj4gDQo+PiArwqDCoMKg
IGlvdGVzdHMubG9nKCc9PT0gVGVzdGluZyBRTVAgYWN0aXZlIGNvbW1pdCAodG9wIC0+IG1pZCkg
PT09JykNCj4+ICsNCj4+ICvCoMKgwqAgY3JlYXRlX2NoYWluKCkNCj4+ICvCoMKgwqAgd2l0aCBj
cmVhdGVfdm0oKSBhcyB2bToNCj4+ICvCoMKgwqDCoMKgwqDCoCB2bS5sYXVuY2goKQ0KPj4gK8Kg
wqDCoMKgwqDCoMKgIHZtLnFtcF9sb2coJ2Jsb2NrLWNvbW1pdCcsIGRldmljZT0ndG9wJywgYmFz
ZV9ub2RlPSdtaWQnLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBq
b2JfaWQ9J2pvYjAnLCBhdXRvX2Rpc21pc3M9RmFsc2UpDQo+PiArwqDCoMKgwqDCoMKgwqAgdm0u
cnVuX2pvYignam9iMCcsIHdhaXQ9NSkNCj4+ICsNCj4+ICvCoMKgwqAgaW90ZXN0cy5pbWdfaW5m
b19sb2cobWlkKQ0KPj4gK8KgwqDCoCBpb3Rlc3RzLnFlbXVfaW9fbG9nKCctYycsICdyZWFkIC1Q
IDEgMCAlZCcgJSBzaXplX3Nob3J0LCBtaWQpDQo+PiArwqDCoMKgIGlvdGVzdHMucWVtdV9pb19s
b2coJy1jJywgJ3JlYWQgLVAgMCAlZCAlZCcgJSAoc2l6ZV9zaG9ydCwgc2l6ZV9kaWZmKSwgbWlk
KQ0KPj4gKw0KPiANCj4gV291bGQgaXQgYWxzbyBiZSB3b3J0aCB0ZXN0aW5nIGEgY29tbWl0IG9m
IG1pZCAtPiBiYXNlLCBhbmQgc2hvd2luZyB0aGF0IHRvcCBzdGlsbCBzZWVzIHRoZSBzYW1lIGNv
bnRlbnRzIGFmdGVyd2FyZHM/DQo+IA0KDQpUaGlzIGlzIGp1c3Qgc3RpbGwgYnJva2VuLCBzZWUg
bWF5ICJbUEFUQ0ggMC80XSBmaXggJiBtZXJnZSBibG9ja19zdGF0dXNfYWJvdmUgYW5kIGlzX2Fs
bG9jYXRlZF9hYm92ZSIgc2VyaWVzLg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXIN
Cg==

