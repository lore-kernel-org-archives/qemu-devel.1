Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B80DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76C720715
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 14:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hb7selHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76C720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibmOv-00071b-48
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 09:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ibmOD-0006Xq-9M
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ibmOB-0008SE-Qc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 09:09:24 -0500
Received: from mail-eopbgr130131.outbound.protection.outlook.com
 ([40.107.13.131]:26662 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ibmOB-0008Rm-0c; Mon, 02 Dec 2019 09:09:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxpE6S15ANQSnxzAabTsc3teZqS+r2M0lUeXE9g4Fs8DDWTNsY0cGyQZHWmDXcVMVS7iKUmPVS1gixhk3nxrkm5GpDYrYxEEqeQt1gU59iI2G8lRHTQyrbcs4yrnX6/w8Xzj4uSaKHGt0bib8vrrcy65o0QAE7NWmoHPKnVY9eeEadwXM3azx1yGsOMm3sQETDgtuoKN30ffywzq0rNPxeQ3kQDkmHyehNAfua6Sxmp7hxl1+NSDfQdNSNRAbjCYl8hEHl8C56BlJYpBd1DNfLJx/jmsWsV7iHJ9kT2uwjjC1bNNN9UAPeEDhs1ihv6tGpAwjvi+VaXF8Op5Vp7HOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPGF5u1t/+Lpq+KLd0o68KWJaaF5yeBdcU9Rz/eAwJA=;
 b=Rlkm4texnrietdrnkV+FgimLqdtyKxwwyFUHUQ00vFiaXzOp7woUnUG7+Wt87XnHiMJvJkcd2+PcxYFc7+XzlK6E3qLaWe9ZYV3UEtClDSAVi/JdE68XCg7Gog4Ca0drh8DxwOmS123c6jnZRqzAd7rWJUjGbIiooZFjU9JfosnBVmTQFb/MrQPMlZoG/uHdp1Nd55KgBORE8+5rXUobf2I3gtMGDMAAILA3igxcJyuZeGE6S572wbhT72TCIhUgyyXm1Lyae1X9d65TDVjL9aljtTwHW481MTWDn7TTkGjWGUQvmvK2nnGW3m6h4gYB/f5SjOl0fxmA2EWsHJqo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPGF5u1t/+Lpq+KLd0o68KWJaaF5yeBdcU9Rz/eAwJA=;
 b=hb7selHU6BgoCY3P4Ygdy1o2llxfyZQ33OGCSh5afNAH5lbEklMflQAmFXwyWqj9uB//N1cyRPlo8Wst/BMYDaARrxOHisJmqwDvl65CaiWdS7sevCAcSG/gmYNgeg0kx51Bf5d91YAmGpcB5e/Zrw30FEUMmBU2Rz9LzkQ1px0=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5190.eurprd08.prod.outlook.com (10.255.121.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Mon, 2 Dec 2019 14:09:20 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 14:09:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [bugfix ping2] Re: [PATCH v2 0/2] fix
 qcow2_can_store_new_dirty_bitmap
Thread-Topic: [bugfix ping2] Re: [PATCH v2 0/2] fix
 qcow2_can_store_new_dirty_bitmap
Thread-Index: AQHVqRoX5sySbwm2dE6d/PWp4kJbpw==
Date: Mon, 2 Dec 2019 14:09:20 +0000
Message-ID: <0db82122-ee0d-a346-cb49-d902d5d66b77@virtuozzo.com>
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
 <e89b8844-26c7-0768-f6dd-6faa814551e2@virtuozzo.com>
In-Reply-To: <e89b8844-26c7-0768-f6dd-6faa814551e2@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0213.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::13) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191202170918182
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28d01fbd-44cb-4485-1d0e-08d7773139c6
x-ms-traffictypediagnostic: AM6PR08MB5190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB5190CD91F59252199BAF2157C1430@AM6PR08MB5190.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(376002)(39840400004)(366004)(346002)(53754006)(189003)(199004)(25786009)(6116002)(76176011)(107886003)(6246003)(8676002)(2501003)(71200400001)(71190400001)(6506007)(6306002)(386003)(102836004)(54906003)(229853002)(6436002)(6512007)(36756003)(2351001)(81156014)(52116002)(26005)(6486002)(66066001)(31686004)(5640700003)(256004)(446003)(11346002)(186003)(99286004)(14454004)(81166006)(4326008)(7736002)(8936002)(316002)(305945005)(5660300002)(6916009)(86362001)(31696002)(66946007)(66476007)(66556008)(64756008)(478600001)(2906002)(3846002)(966005)(66446008)(2616005)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5190;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +++O5DPfctXeGG2E/Ok+DT9UVgTdw8iQLq9GWROEYr1WF/OlIbvjF3SZ5R6M+mDEHKbJuf4iCZftFPsRwnOIGYpmTmCjaMDj5P/JhcnYJqaQysQYF9LAk0Z1KyHHmKgepKWH8sOL1OHo5XC/SwXbKSR0AZOatnJqrP3mbFS4oLE7KfH8YAQbtW6rYOSdjLLc3MP84fvpm90o61XDxLJRhA/8StCoF+38dIbSSl2QG3dOWQQoTyGOG9jhyTMb2Qg+DnclCiMtv5ItjzbTOsyT7kkRA9Q0tesmIHNuaEFQHEYFzGjKFN/gOlBEB1zHSd3FtxRVTbPPaMmmK0VkjIMfP5e/9/02qU2EPyfldHjtPBxEzzaAzNKc5qa6f23Zi63515lUcVrSV14MPV64NO7rO8q5UMNAq4Tm7PuHVdD04mBY7I3/9bXMcM/4OANyLkVtpwcBWgFkEOf1wwejKlfe/OGiXmrPPfMLvI1kp+r0ZJ8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D74AE5306FC4742AE99CFBB36DB4078@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d01fbd-44cb-4485-1d0e-08d7773139c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 14:09:20.4281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bq/LZz5ADKISDBx22682fEQCWKB+0BLti1qJBi1G3vLg8XhDaaewhGc90NRXNzWgPpIg782JpFzIxuhjxN43TSLVNGGdCEuveEjBRtoAzW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5190
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.131
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
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgYWdhaW4hDQoNClN0aWxsIGZvcmdvdHRlbiBidWctZml4IDooDQoNCklzIGl0IHRvbyBsYXRl
IGZvciA0LjI/DQoNCkkgY2FuJ3QgaW1hZ2luZSBiZXR0ZXIgdGVzdCwgYW5kIGl0IHRlc3RzIGV4
YWN0bHkgd2hhdCB3cml0dGVuIGluDQpodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19i
dWcuY2dpP2lkPTE3MTI2MzYNCg0KKEhtbSwgYWN0dWFsbHksIEkgZG91YnQgdGhhdCBpdCBpcyBy
ZWFsIHVzZS1jYXNlLCBtb3JlIHByb2JhYmx5IGl0J3MgYSBidWcgaW4gbWFuYWdlbWVudCBsYXll
cikNCg0KU28sIHRha2UgdGhpcyB3aXRoIHRlc3Qgb3Igd2l0aG91dCB0ZXN0LCB0byA0LjIgb3Ig
NS4wLg0KDQoyNS4xMC4yMDE5IDEyOjU3LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSENCj4gDQo+IERvbid0IHdlIGZvcmdldCBpdD8NCj4gDQo+IEhlcmUgaXMgYSBi
dWctZml4LCBJIHRoaW5rIHdlIHdhbnQgaXQgZm9yIDQuMi4NCj4gDQo+IDE0LjEwLjIwMTkgMTQ6
NTEsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBIaSBhbGwhDQo+Pg0K
Pj4gSGVyZSBpcyBhIGZpeCBmb3IgcGVyc2lzdGVudCBiaXRtYXBzIG1hbmFnaW5nOiB3ZSBtdXN0
IGNoZWNrIGV4aXN0ZW50DQo+PiBidXQgbm90IHlldCBzdG9yZWQgYml0bWFwcyBmb3IgcWNvdzIt
cmVsYXRlZCBjb25zdHJhaW50cywgbGlrZSBtYXhpbXVtDQo+PiBudW1iZXIgb2YgYml0bWFwcyBp
biBxY293MiBpbWFnZS4NCj4+DQo+PiB2MjoNCj4+DQo+PiAwMTogY2hhbmdlIGFzc2VydGlvbiB0
byBlcnJvci1yZXR1cm4gYXQgZnVuY3Rpb24gc3RhcnQNCj4+IMKgwqDCoMKgIEJlIGZyZWUgdG8g
YWRkDQo+PiDCoMKgwqDCoCBSZXBvcnRlZC1ieTogYWlodWEgbGlhbmcgPGFsaWFuZ0ByZWRoYXQu
Y29tPg0KPj4gwqDCoMKgwqAgRml4ZXM6IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93
X2J1Zy5jZ2k/aWQ9MTcxMjYzNg0KPj4gwqDCoMKgwqAgaWYgaXQncyBhcHByb3ByaWF0ZQ0KPj4g
MDI6IG5ldyB0ZXN0DQo+PiDCoMKgwqDCoCBPaGgsIGl0IHRha2VzIGFib3V0IDQgbWludXRlcy4g
QmUgZnJlZSB0byBkcm9wIGl0LCBhcyBJIGRvdWJ0IHRoYXQNCj4+IMKgwqDCoMKgIGl0IHdvcnRo
IHRvIGhhdmUuIFRoZSBjYXNlIGlzIHNpbXBsZSwgd2UgbWF5IGxpdmUgd2l0aG91dCBhDQo+PiDC
oMKgwqDCoCB0ZXN0Lg0KPj4NCj4+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDIpOg0K
Pj4gwqDCoCBxY293Mi1iaXRtYXBzOiBmaXggcWNvdzJfY2FuX3N0b3JlX25ld19kaXJ0eV9iaXRt
YXANCj4+IMKgwqAgaW90ZXN0czogYWRkIDI2OSB0byBjaGVjayBtYXhpbXVtIG9mIGJpdG1hcHMg
aW4gcWNvdzINCj4+DQo+PiDCoCBibG9jay9xY293Mi1iaXRtYXAuY8KgwqDCoMKgwqDCoCB8IDQx
ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gwqAgdGVzdHMvcWVtdS1pb3Rl
c3RzLzI2OcKgwqDCoMKgIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+IMKgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNjkub3V0IHzCoCAzICsrKw0KPj4gwqAgdGVz
dHMvcWVtdS1pb3Rlc3RzL2dyb3VwwqDCoCB8wqAgMSArDQo+PiDCoCA0IGZpbGVzIGNoYW5nZWQs
IDY5IGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPj4gwqAgY3JlYXRlIG1vZGUgMTAw
NzU1IHRlc3RzL3FlbXUtaW90ZXN0cy8yNjkNCj4+IMKgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy9xZW11LWlvdGVzdHMvMjY5Lm91dA0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

