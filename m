Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182A0C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE4421781
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="v00nqaHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE4421781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iabow-0008Jg-1E
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 03:40:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iabgm-00039b-71
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iabgg-0001Rj-Rv
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:31:40 -0500
Received: from mail-eopbgr150137.outbound.protection.outlook.com
 ([40.107.15.137]:2846 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iabgf-0001Ed-Ii
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:31:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfC4mbXXrgnCNrqpHF5fxhHSwS1I1Lco2CFJ9df5NtOYt70/2lWJ/s8/lESdQF5lZxqnTEjyu/BXnN2gG/OfszLSpXarpGrYjWDKCRh3Fy17ZH/6jFvsiTiej/23JlDJf7Qfw5NyyULYrT/1y62oIC4ChDVlzcrwF/77D2ihUyiA+KgcoH9Esi3ya/UeXeJQ9hMzVS5mS+zV0CpRiI9aMtut3wu0Vl4Q4cItxGt9GVw0tnGlGMbfj0G2MT/Lx3mdTgwS0+D+j5CegItvQ0+9KHu3oH0sKxlcP1H08cs/3on7RipmePADstTmxZzboON2aZzhEJrZzsjacUKXipxlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzIyhmmjWWmsKuMuz4M4/raiiYuW4Rj4CoUQzDNg56I=;
 b=X5A7XVxvjiH+N5CQtfRDii1njhJS0OAE3AbP+/DTDgG7uTJk1tve6fRM3rL3MBjiMHRGCSwxTKd965SxXZ0He9ZI68vDk3eIpgqANs8HU74xBXEF06tMSd2SJtK9C+cwJhVo/rL4vN0JsOoNZMbofVzoxcjIVyF38upONefFzsZHSxOUKg9Z8YFGdogPUy/H4eCxfxrAl/xZf4niDPV9FZiPNOpcvM3l7T4AAwSPdM7K8+6gPsXYhHjq/PIGKldQjjRws9aXxS4GnIEueGWI6sPJg4C+RthzFUiKohOLlMZvxjZZ/ysf1dHviMNJPj0r+y7/HF4H2xOUP2o0YBnOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzIyhmmjWWmsKuMuz4M4/raiiYuW4Rj4CoUQzDNg56I=;
 b=v00nqaHdE4yosJzilIO5rysliscd/OHCJ+FBCnm/qrWwVePZA2b6Evn4YrQVSQY9YLwx5uJM5lkCRD6YB1yO5emQYFVpjEid66zAqqpC3bVcjzFqFOzLZdOlgCus+nbCr3ONFv7sVpWH1Rva6czJ+fLHaZfa8k03nMbov+aBBKQ=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3591.eurprd08.prod.outlook.com (20.177.115.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Fri, 29 Nov 2019 08:31:34 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 08:31:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6] backends/cryptodev: drop local_err from
 cryptodev_backend_complete()
Thread-Topic: [PATCH v6] backends/cryptodev: drop local_err from
 cryptodev_backend_complete()
Thread-Index: AQHVpVtGe7TguB9VB0ixbHvlI2omPqehrNtKgAAnPAA=
Date: Fri, 29 Nov 2019 08:31:34 +0000
Message-ID: <1b532161-7de9-8ea5-0771-69fdeb5b70bc@virtuozzo.com>
References: <20191127194541.24304-1-vsementsov@virtuozzo.com>
 <874kynyzyo.fsf@dusky.pond.sub.org>
In-Reply-To: <874kynyzyo.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0064.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::32) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129113132928
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fa0d596-2b76-49b4-2a88-08d774a68b1e
x-ms-traffictypediagnostic: AM6PR08MB3591:
x-microsoft-antispam-prvs: <AM6PR08MB35913F13F6F4E660D470B4D6C1460@AM6PR08MB3591.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(39840400004)(396003)(136003)(376002)(199004)(189003)(6512007)(6246003)(31696002)(4326008)(305945005)(81156014)(11346002)(36756003)(76176011)(25786009)(26005)(186003)(7736002)(81166006)(99286004)(2906002)(8936002)(6506007)(86362001)(5660300002)(8676002)(102836004)(386003)(6916009)(66446008)(31686004)(66066001)(478600001)(316002)(2616005)(64756008)(66556008)(66476007)(66946007)(14454004)(256004)(6116002)(52116002)(3846002)(71190400001)(71200400001)(229853002)(6436002)(6486002)(446003)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3591;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GBHVjyMloqSbhWCIvky0TBG2KiFX0wpMVdEKXUQxQWQDCF+jMOfw/sgitH+xHBHtbcYI1nVM+cyMkUCQM8L9S6PPDrqX+IXC39pz5uHIpo5NaBj9bFIcQT9wRlX4RdblH5TA89yzVjbLWrxzIjUdoTK7mBE8seEVVnXEPxXcDNxZoiVQv7mQMF1XQuRhjMrMu9uiAnqH76AuFD//OPxV0kU7SxYstHWQLbHC5ufFr2suDZ5ABT8ug0X/T9nGrBF30JbDuVkz0QTno2Ttiw5Nxv7dE7Eh/QgVPv9daI9dPQMx9wjMtLEsK1YstMgdXmlWx5E54wGH3ahkJMw3z4o5Pp8U062AGW+pcLjYeQJphb7BXd/KYRgszrbIE2nza94Y29aDkZqfoA/gvmRXWMCC68dROSJ2At1xZPVbXbGKrRYy/TCW/PRsBvGAPR0ZyZcI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FA2CB916FA02E4086A7ED60815F9348@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa0d596-2b76-49b4-2a88-08d774a68b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 08:31:34.4457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yX7vr6js3Po+La2ry/1n6kzII5gleRUhUOpJjedSyPItpHNiuFz/ZL5ie0se/PCorsKvYAIrLlyY4qGM+0I60d9WJGRmb9uBxhGdvJN1dZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3591
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.137
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
Cc: "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMTEuMjAxOSA5OjEwLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4gVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPiB3cml0ZXM6DQo+IA0K
Pj4gTm8gcmVhc29uIGZvciBsb2NhbF9lcnIgaGVyZSwgdXNlIGVycnAgZGlyZWN0bHkgaW5zdGVh
ZC4NCj4gDQo+IFJlbGF0ZWQ6ICJbUEFUQ0ggdjZdIGh3L3ZmaW8vYXA6IGRyb3AgbG9jYWxfZXJy
IGZyb20gdmZpb19hcF9yZWFsaXplIi4NCj4gSSdtIHN1cnByaXNlZCBpdCdzIGp1c3QgdHdvLiAg
RGlkIHlvdSBzZWFyY2ggZm9yIHRoZSBhbnRpLXBhdHRlcm4NCj4gc3lzdGVtYXRpY2FsbHk/DQoN
CkFzIEkgcmVtZW1iZXIgLSBubywgb25seSB3aGVyZSBpdCBicmVha3MgYXV0b21hdGlvbi4gSGVy
ZSBlbXB0eSAib3V0OiB9Ig0KbGFiZWwgd2lsbCBicmVhayBjb21waWxhdGlvbiwgaWYgbm90IGZp
eGVkIGJlZm9yZSBvciBhZnRlciBjb2NjaW5lbGxlDQpydW4uIFNvLCBoZXJlIEkgZml4ZWQgaXQg
YmVmb3JlLg0KDQo+IA0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4+IFJldmlld2VkLWJ5OiBNYXJj
LUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4+IC0tLQ0KPj4N
Cj4+IHY2OiBhZGQgci1iIGJ5IFBoaWxpcHBlIGFuZCBNYXJjLUFuZHLDqQ0KPj4NCj4+ICAgYmFj
a2VuZHMvY3J5cHRvZGV2LmMgfCAxMSArLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEwIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9iYWNr
ZW5kcy9jcnlwdG9kZXYuYyBiL2JhY2tlbmRzL2NyeXB0b2Rldi5jDQo+PiBpbmRleCAzYzA3MWVh
Yjk1Li41YTk3MzU2ODRlIDEwMDY0NA0KPj4gLS0tIGEvYmFja2VuZHMvY3J5cHRvZGV2LmMNCj4+
ICsrKyBiL2JhY2tlbmRzL2NyeXB0b2Rldi5jDQo+PiBAQCAtMTc2LDE5ICsxNzYsMTAgQEAgY3J5
cHRvZGV2X2JhY2tlbmRfY29tcGxldGUoVXNlckNyZWF0YWJsZSAqdWMsIEVycm9yICoqZXJycCkN
Cj4+ICAgew0KPj4gICAgICAgQ3J5cHRvRGV2QmFja2VuZCAqYmFja2VuZCA9IENSWVBUT0RFVl9C
QUNLRU5EKHVjKTsNCj4+ICAgICAgIENyeXB0b0RldkJhY2tlbmRDbGFzcyAqYmMgPSBDUllQVE9E
RVZfQkFDS0VORF9HRVRfQ0xBU1ModWMpOw0KPj4gLSAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVM
TDsNCj4+ICAgDQo+PiAgICAgICBpZiAoYmMtPmluaXQpIHsNCj4+IC0gICAgICAgIGJjLT5pbml0
KGJhY2tlbmQsICZsb2NhbF9lcnIpOw0KPj4gLSAgICAgICAgaWYgKGxvY2FsX2Vycikgew0KPj4g
LSAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4gLSAgICAgICAgfQ0KPj4gKyAgICAgICAgYmMtPmlu
aXQoYmFja2VuZCwgZXJycCk7DQo+PiAgICAgICB9DQo+PiAtDQo+PiAtICAgIHJldHVybjsNCj4+
IC0NCj4+IC1vdXQ6DQo+PiAtICAgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOw0K
Pj4gICB9DQo+PiAgIA0KPj4gICB2b2lkIGNyeXB0b2Rldl9iYWNrZW5kX3NldF91c2VkKENyeXB0
b0RldkJhY2tlbmQgKmJhY2tlbmQsIGJvb2wgdXNlZCkNCj4gDQo+IFJldmlld2VkLWJ5OiBNYXJr
dXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==

