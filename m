Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9566C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981B52168B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981B52168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaE1C-0004Jp-Re
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 02:15:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arei.gonglei@huawei.com>) id 1iaE0G-0003kb-7x
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arei.gonglei@huawei.com>) id 1iaE0E-00081I-Uq
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:14:16 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2483 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
 id 1iaE0E-0007ka-Id; Thu, 28 Nov 2019 02:14:14 -0500
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 8089BB7CAB5F298D1177;
 Thu, 28 Nov 2019 15:14:02 +0800 (CST)
Received: from DGGEML511-MBX.china.huawei.com ([169.254.1.151]) by
 DGGEML401-HUB.china.huawei.com ([fe80::89ed:853e:30a9:2a79%31]) with mapi id
 14.03.0439.000; Thu, 28 Nov 2019 15:13:53 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v6] backends/cryptodev: drop local_err from
 cryptodev_backend_complete()
Thread-Topic: [PATCH v6] backends/cryptodev: drop local_err from
 cryptodev_backend_complete()
Thread-Index: AQHVpVtFP2rZkz4m50KfOlRvg42c16egKx1A
Date: Thu, 28 Nov 2019 07:13:53 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB5A1062@dggeml511-mbx.china.huawei.com>
References: <20191127194541.24304-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191127194541.24304-1-vsementsov@virtuozzo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.225.234]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.188
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Q0NpbmcgcWVtdS10cml2aWFsQG5vbmdudS5vcmcNCg0KUmV2aWV3ZWQtYnk6IEdvbmdsZWkgPGFy
ZWkuZ29uZ2xlaUBodWF3ZWkuY29tPg0KDQoNClJlZ2FyZHMsDQotR29uZ2xlaQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgW21haWx0bzp2c2VtZW50c292QHZpcnR1b3p6by5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBO
b3ZlbWJlciAyOCwgMjAxOSAzOjQ2IEFNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4g
Q2M6IEdvbmdsZWkgKEFyZWkpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47IG1hcmNhbmRyZS5s
dXJlYXVAZ21haWwuY29tOw0KPiBwaGlsbWRAcmVkaGF0LmNvbTsgdnNlbWVudHNvdkB2aXJ0dW96
em8uY29tDQo+IFN1YmplY3Q6IFtQQVRDSCB2Nl0gYmFja2VuZHMvY3J5cHRvZGV2OiBkcm9wIGxv
Y2FsX2VyciBmcm9tDQo+IGNyeXB0b2Rldl9iYWNrZW5kX2NvbXBsZXRlKCkNCj4gDQo+IE5vIHJl
YXNvbiBmb3IgbG9jYWxfZXJyIGhlcmUsIHVzZSBlcnJwIGRpcmVjdGx5IGluc3RlYWQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQo+IFJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1h
cmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gLS0tDQo+IA0KPiB2NjogYWRkIHItYiBieSBQ
aGlsaXBwZSBhbmQgTWFyYy1BbmRyw6kNCj4gDQo+ICBiYWNrZW5kcy9jcnlwdG9kZXYuYyB8IDEx
ICstLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEwIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JhY2tlbmRzL2NyeXB0b2Rldi5jIGIvYmFja2Vu
ZHMvY3J5cHRvZGV2LmMgaW5kZXgNCj4gM2MwNzFlYWI5NS4uNWE5NzM1Njg0ZSAxMDA2NDQNCj4g
LS0tIGEvYmFja2VuZHMvY3J5cHRvZGV2LmMNCj4gKysrIGIvYmFja2VuZHMvY3J5cHRvZGV2LmMN
Cj4gQEAgLTE3NiwxOSArMTc2LDEwIEBAIGNyeXB0b2Rldl9iYWNrZW5kX2NvbXBsZXRlKFVzZXJD
cmVhdGFibGUgKnVjLA0KPiBFcnJvciAqKmVycnApICB7DQo+ICAgICAgQ3J5cHRvRGV2QmFja2Vu
ZCAqYmFja2VuZCA9IENSWVBUT0RFVl9CQUNLRU5EKHVjKTsNCj4gICAgICBDcnlwdG9EZXZCYWNr
ZW5kQ2xhc3MgKmJjID0gQ1JZUFRPREVWX0JBQ0tFTkRfR0VUX0NMQVNTKHVjKTsNCj4gLSAgICBF
cnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4gDQo+ICAgICAgaWYgKGJjLT5pbml0KSB7DQo+IC0g
ICAgICAgIGJjLT5pbml0KGJhY2tlbmQsICZsb2NhbF9lcnIpOw0KPiAtICAgICAgICBpZiAobG9j
YWxfZXJyKSB7DQo+IC0gICAgICAgICAgICBnb3RvIG91dDsNCj4gLSAgICAgICAgfQ0KPiArICAg
ICAgICBiYy0+aW5pdChiYWNrZW5kLCBlcnJwKTsNCj4gICAgICB9DQo+IC0NCj4gLSAgICByZXR1
cm47DQo+IC0NCj4gLW91dDoNCj4gLSAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgbG9jYWxfZXJy
KTsNCj4gIH0NCj4gDQo+ICB2b2lkIGNyeXB0b2Rldl9iYWNrZW5kX3NldF91c2VkKENyeXB0b0Rl
dkJhY2tlbmQgKmJhY2tlbmQsIGJvb2wgdXNlZCkNCj4gLS0NCj4gMi4yMS4wDQoNCg==

