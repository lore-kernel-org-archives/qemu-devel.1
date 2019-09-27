Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6FAC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1620820872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NfILs+s7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1620820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDkjr-0004uO-0T
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDkir-0004Gu-Uw
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDkiq-0003xk-Qd
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:31:25 -0400
Received: from mail-eopbgr60133.outbound.protection.outlook.com
 ([40.107.6.133]:4538 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDkiq-0003wo-Kq; Fri, 27 Sep 2019 03:31:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5u217cnmmipYK1DTClWzxXvbL0YCy28pOvKxHKKmwZFbQcSkiHBlhZUr6C0wZ9nXqMdPyDOmzJxyU908KYNWoz2+GAeV12NsS90Pz7UWxnDPW3kTcmp76fdbp4rmkQp3oBGMs1deQ1EETGLnEJ5UM7hINrvUIRFT441AI5ksLuKHENcxW2BYFl4S+xt2LcrkOFkEfgEnQdqBg6ymvyQzKkl+WYLdzkAdW946J0bP1s1k1Ql92I8aTfDKy/rShvmow/2ZW7oNQSlKLCxIZT6lC4WrwARW7xALQ4hN9O7qM2vovTIiUkrQS5LIy5Z27HFgPbl1Cz6kdH97yeG9PsAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utMFuYgTLImzQEnCs1QQHl0xfw+dBgP6WXLrzLU5hyE=;
 b=BvptfeTUE3oWBGYtKZBd0ZO7mbZnpJBm5YCjr3scrfNGrDl+QA2bBcKY0qiY4ewKP3cjyADgyVdAvkLUmi56rQbo56hzzZ20O93S5G8m0eLYxIMPYmASS/V29orz3bYQVLFbM+6utr/o3hGbj3sD9JA6v3agwAPzeJr0MK8CTsp+gwQbVeusVBj07xS8Z8yWLVZr7xtrUVPu3v0xdguh8ZM8w+Wr7lNpxQ4UqAS2KFAzuqiF7vDTgkbjEJFp6IBPa50aWsjTq6mL6WvA2+eDAZGP2rOPhxO2+dUtz+6Zv3rjsDWdDRCpUnjmrR6Kwa0tpildnVZaIpR8wT+PvHt9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utMFuYgTLImzQEnCs1QQHl0xfw+dBgP6WXLrzLU5hyE=;
 b=NfILs+s7cqwitKvuysmg/hmUiT9ByO2VdMQHKSWNrN4bviryGqyJ9cFpyjIPGEL2Toh2i+mhEbhbzciLP57b+pIMsLKVDTpg64yUoM/SojME0itHyCeDpeFkgxzONfbX38SaO9eFVzJ0iI/h7RHK4wjNjbUOjhJCLwKBiOgqSI8=
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com (52.132.215.9) by
 AM0PR08MB4035.eurprd08.prod.outlook.com (20.178.203.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 27 Sep 2019 07:31:22 +0000
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75]) by AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75%2]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 07:31:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH v4 04/10] iotests.py: add event_wait_log and
 events_wait_log helpers
Thread-Topic: [Qemu-devel] [PATCH v4 04/10] iotests.py: add event_wait_log and
 events_wait_log helpers
Thread-Index: AQHVTSopsvgVlwVKVEeEJ+8OAOZN+qc+43YAgACNUgA=
Date: Fri, 27 Sep 2019 07:31:21 +0000
Message-ID: <62862d28-5183-8af7-f515-36d6c9d8a2e8@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
 <20190807141226.193501-5-vsementsov@virtuozzo.com>
 <a578331a-86a6-4636-d055-3cc4c43ba495@redhat.com>
In-Reply-To: <a578331a-86a6-4636-d055-3cc4c43ba495@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0175.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::23) To AM0PR08MB5491.eurprd08.prod.outlook.com
 (2603:10a6:208:189::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190927103120062
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83f34e46-c52b-4275-c212-08d7431cb1e3
x-ms-traffictypediagnostic: AM0PR08MB4035:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB40359E25102CA0042A69A600C1810@AM0PR08MB4035.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(39850400004)(346002)(396003)(189003)(199004)(102836004)(256004)(66476007)(66066001)(26005)(66446008)(64756008)(36756003)(14444005)(476003)(2616005)(486006)(66556008)(14454004)(446003)(478600001)(186003)(107886003)(71200400001)(66946007)(5660300002)(6246003)(71190400001)(2906002)(25786009)(6116002)(3846002)(11346002)(4326008)(99286004)(76176011)(229853002)(53546011)(6506007)(386003)(31696002)(6486002)(31686004)(6512007)(52116002)(6436002)(110136005)(8936002)(316002)(2501003)(86362001)(7736002)(305945005)(54906003)(81166006)(8676002)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4035;
 H:AM0PR08MB5491.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ckMNY4wYpNZ8NpWoo71JfkfZsjTJFT3MrhrdaVJ5nhLHDTVCelqbyahQbCLwZojzumnKmFOxWQNu7i8+8TOHi6taD5HcuBpGfojOQx0yTIRCng5JcoVSIg4H8ITL/DsTjMMSlQnASvdEdKE7lWkay/Pxddx74SB2g7FKkG1IAAHe6AOnLXD9p8UitF6wLYt+V/UxtSnRiG4NzM5nQtpFsTkEVSaVb9xwjCxd9O/5AY3529rCqISWri/gwbPitsfn4GJKQEAFgwbCE3BtAABquNFQHsC7qxDwu1lK56wgMh5QEdfVHNRXHnKAFh/7fRxEPElTUibbxPq5hHIzJmUb4Or7iRRipcqwJ8D/HY+jFseNHTbkKeUTV7j0aHvMlNGogBwK5OHRuP1UDtx1dlD8SxTRWCUYBI390o9rLPxUPcQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <358E2FB9D7F17A4CAE83AE680C1731BD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f34e46-c52b-4275-c212-08d7431cb1e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 07:31:21.9754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKVShhd27raWhuiJXDRDT02tGjRgOnckt8t6vblKuhgVKWS3eO+4bvebwSdxkfdHg+GByDB5PYals1MFn3rU0n7jjgO66M+W2WzEtFNHmPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4035
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.133
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
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMDkuMjAxOSAyOjA1LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gOC83LzE5IDEw
OjEyIEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gU2lnbmVkLW9m
Zi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPg0KPj4gLS0tDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5IHwgMTAgKysr
KysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSBiL3Rlc3RzL3FlbXUtaW90
ZXN0cy9pb3Rlc3RzLnB5DQo+PiBpbmRleCBjZTc0MTc3YWIxLi40YWQyNjVmMTQwIDEwMDY0NA0K
Pj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkNCj4+ICsrKyBiL3Rlc3RzL3Fl
bXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+PiBAQCAtNTQwLDYgKzU0MCwxNiBAQCBjbGFzcyBWTShx
dGVzdC5RRU1VUXRlc3RNYWNoaW5lKToNCj4+ICAgICAgICAgICBsb2cocmVzdWx0LCBmaWx0ZXJz
LCBpbmRlbnQ9aW5kZW50KQ0KPj4gICAgICAgICAgIHJldHVybiByZXN1bHQNCj4+ICAgDQo+PiAr
ICAgIGRlZiBldmVudF93YWl0X2xvZyhzZWxmLCBuYW1lLCAqKmt3YXJncyk6DQo+PiArICAgICAg
ICBldmVudCA9IHNlbGYuZXZlbnRfd2FpdChuYW1lLCAqKmt3YXJncykNCj4+ICsgICAgICAgIGxv
ZyhldmVudCwgZmlsdGVycz1bZmlsdGVyX3FtcF9ldmVudF0pDQo+PiArICAgICAgICByZXR1cm4g
ZXZlbnQNCj4+ICsNCj4+ICsgICAgZGVmIGV2ZW50c193YWl0X2xvZyhzZWxmLCBldmVudHMsICoq
a3dhcmdzKToNCj4+ICsgICAgICAgIGV2ZW50ID0gc2VsZi5ldmVudHNfd2FpdChldmVudHMsICoq
a3dhcmdzKQ0KPj4gKyAgICAgICAgbG9nKGV2ZW50LCBmaWx0ZXJzPVtmaWx0ZXJfcW1wX2V2ZW50
XSkNCj4+ICsgICAgICAgIHJldHVybiBldmVudA0KPj4gKw0KPj4gICAgICAgIyBSZXR1cm5zIE5v
bmUgb24gc3VjY2VzcywgYW5kIGFuIGVycm9yIHN0cmluZyBvbiBmYWlsdXJlDQo+PiAgICAgICBk
ZWYgcnVuX2pvYihzZWxmLCBqb2IsIGF1dG9fZmluYWxpemU9VHJ1ZSwgYXV0b19kaXNtaXNzPUZh
bHNlLA0KPj4gICAgICAgICAgICAgICAgICAgcHJlX2ZpbmFsaXplPU5vbmUsIHVzZV9sb2c9VHJ1
ZSwgd2FpdD02MC4wKToNCj4+DQo+IA0KPiBJJ20gbm90IHN1cmUgdGhlc2UgYXJlIHJlYWxseSBu
ZWVkZWQsIHNpbmNlIHlvdSBjYW4ganVzdCBsb2cgdGhlIGV2ZW50DQo+IHlvdSBnZXQgYWZ0ZXIg
Y2FsbGluZyBlaXRoZXIgb2YgdGhlc2UgbWV0aG9kcyBhbnl3YXkuIFRoZXJlJ3Mgbm90aGluZw0K
PiBzdG9wcGluZyB5b3UgZnJvbToNCj4gDQo+IGBgYA0KPiBldmVudCA9IGV2ZW50X3dhaXRfbG9n
KC4uLikNCj4gbG9nKGZpbHRlcl9xbXBfZXZlbnQoZXZlbnQpKQ0KPiBgYGANCg0KdHdvIGxpbmVz
IHZzIG9uZQ0KDQpIbSwganVzdCBzaW1wbGUgd3JhcHBlcnMgbGlrZSBxbXBfbG9nKCksIHRvIG1h
a2UgdGVzdCBhIGJpdCBtb3JlIHJlYWRhYmxlLCB3aHkgbm90Li4NCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K

