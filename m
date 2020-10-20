Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D975BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD9822200
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD9822200
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmDF-00014w-Ug
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 03:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kUmBz-000076-Hy; Tue, 20 Oct 2020 03:36:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2984 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kUmBx-0005n8-Ms; Tue, 20 Oct 2020 03:36:23 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 3639D591FCB0D094825E;
 Tue, 20 Oct 2020 15:36:11 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.142]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0487.000;
 Tue, 20 Oct 2020 15:36:02 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: RE: [PATCH v3] migration/block-dirty-bitmap: fix uninitialized
 variable warning
Thread-Topic: [PATCH v3] migration/block-dirty-bitmap: fix uninitialized
 variable warning
Thread-Index: AQHWoh9nKW/nkP8HRkaUZLAK8ayEIKmWurKAgAlmh/A=
Date: Tue, 20 Oct 2020 07:36:01 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B9DA561@dggemm511-mbx.china.huawei.com>
References: <20201014114430.1898684-1-kuhn.chenqun@huawei.com>
 <c3a75c21-d9a6-a13b-7076-936867376ac6@virtuozzo.com>
In-Reply-To: <c3a75c21-d9a6-a13b-7076-936867376ac6@virtuozzo.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 03:36:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "fam@euphon.net" <fam@euphon.net>, ganqixin <ganqixin@huawei.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGluZyENCg0KSGVsbG8sDQoNCiAgTWF5YmUgdGhpcyBwYXRjaCwgc29tZSBwZW9wbGUgaGF2ZSBh
bnkgb3RoZXIgc3VnZ2VzdGlvbnM/ICAgT3IsIG1heWJlIG1pc3NlZCB0byBxdWV1ZT8NCg0KVGhh
bmtzLA0KQ2hlbiBRdW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IFttYWlsdG86dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tXQ0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMTQsIDIwMjAgMTE6NTYgUE0NCj4gVG86
IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT47IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsNCj4gcWVtdS10cml2aWFsQG5vbmdudS5vcmcNCj4gQ2M6IG1yZWl0ekByZWRoYXQu
Y29tOyBzdGVmYW5oYUByZWRoYXQuY29tOyBmYW1AZXVwaG9uLm5ldDsNCj4gZWJsYWtlQHJlZGhh
dC5jb207IGpzbm93QHJlZGhhdC5jb207IHF1aW50ZWxhQHJlZGhhdC5jb207DQo+IGRnaWxiZXJ0
QHJlZGhhdC5jb207IFpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNv
bT47DQo+IGdhbnFpeGluIDxnYW5xaXhpbkBodWF3ZWkuY29tPjsgcWVtdS1ibG9ja0Bub25nbnUu
b3JnOyBFdWxlciBSb2JvdA0KPiA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT47IExhdXJlbnQgVml2
aWVyIDxsYXVyZW50QHZpdmllci5ldT47IExpIFFpYW5nDQo+IDxsaXEzZWFAZ21haWwuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBtaWdyYXRpb24vYmxvY2stZGlydHktYml0bWFwOiBm
aXggdW5pbml0aWFsaXplZCB2YXJpYWJsZQ0KPiB3YXJuaW5nDQo+IA0KPiAxNC4xMC4yMDIwIDE0
OjQ0LCBDaGVuIFF1biB3cm90ZToNCj4gPiBBIGRlZmF1bHQgdmFsdWUgaXMgcHJvdmlkZWQgZm9y
IHRoZSB2YXJpYWJsZSAnYml0bWFwX25hbWUnIHRvIGF2b2lkIGNvbXBpbGVyDQo+IHdhcm5pbmcu
DQo+ID4NCj4gPiBUaGUgY29tcGlsZXIgc2hvdyB3YXJuaW5nOg0KPiA+IG1pZ3JhdGlvbi9ibG9j
ay1kaXJ0eS1iaXRtYXAuYzoxMDkwOjEzOiB3YXJuaW5nOiDigJhiaXRtYXBfbmFtZeKAmQ0KPiA+
IG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmlu
aXRpYWxpemVkXQ0KPiA+ICAgICAgICAgZ19zdHJsY3B5KHMtPmJpdG1hcF9uYW1lLCBiaXRtYXBf
bmFtZSwNCj4gc2l6ZW9mKHMtPmJpdG1hcF9uYW1lKSk7DQo+ID4NCj4gXn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gPg0KPiA+
IFJlcG9ydGVkLWJ5OiBFdWxlciBSb2JvdDxldWxlci5yb2JvdEBodWF3ZWkuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IENoZW4gUXVuPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPg0KPiANCj4gUmV2
aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVv
enpvLmNvbT4NCj4gDQo+IC0tDQo+IEJlc3QgcmVnYXJkcywNCj4gVmxhZGltaXINCg==

