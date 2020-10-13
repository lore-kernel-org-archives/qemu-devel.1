Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E99C43467
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CF520E65
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CF520E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIut-0005uI-9w
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kSIoQ-0005eQ-6F; Tue, 13 Oct 2020 07:49:50 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2547 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kSIoN-0004ft-IM; Tue, 13 Oct 2020 07:49:49 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 18598F6BFD84A2A20E3F;
 Tue, 13 Oct 2020 19:49:40 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 13 Oct 2020 19:49:39 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.75]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0487.000;
 Tue, 13 Oct 2020 19:49:33 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Laurent Vivier
 <laurent@vivier.eu>, Li Qiang <liq3ea@gmail.com>
Subject: RE: [PATCH] migration/block-dirty-bitmap: fix uninitialized
 variable warning
Thread-Topic: [PATCH] migration/block-dirty-bitmap: fix uninitialized
 variable warning
Thread-Index: AQHWnvWXB6+3xHhZ7kqhgehHhToetKmTlYMAgACocACAAF4JAIAAjDZA//+83oCAAIfTIA==
Date: Tue, 13 Oct 2020 11:49:32 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B9B2E21@dggemm531-mbx.china.huawei.com>
References: <20201010110730.1575180-1-kuhn.chenqun@huawei.com>
 <2b2bc826-0785-66e2-3515-b98abfac26ca@vivier.eu>
 <CAKXe6SL8fRN=-iqFEiHeWqZm0F+T+8vkc7qJeUz6izQcZQ2Q-A@mail.gmail.com>
 <70bc9735-6555-078a-52da-61da6c58f1d3@vivier.eu>
 <7412CDE03601674DA8197E2EBD8937E83B9B2054@dggemm531-mbx.china.huawei.com>
 <82c0eefd-9227-8d76-e941-343ac78895a7@virtuozzo.com>
In-Reply-To: <82c0eefd-9227-8d76-e941-343ac78895a7@virtuozzo.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:49:40
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
Cc: Fam Zheng <fam@euphon.net>, Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, ganqixin <ganqixin@huawei.com>,
 Euler Robot <euler.robot@huawei.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+Pj4+IExlIDEwLzEwLzIwMjAgw6AgMTM6MDcsIENoZW4gUXVuIGEgw6ljcml0IDoNCj4gPj4+
Pj4gVGhpcyBpZiBzdGF0ZW1lbnQganVkZ21lbnQgaXMgcmVkdW5kYW50IGFuZCBpdCB3aWxsIGNh
dXNlIGEgd2FybmluZzoNCj4gPj4+Pj4NCj4gPj4+Pj4gbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJp
dG1hcC5jOjEwOTA6MTM6IHdhcm5pbmc6IOKAmGJpdG1hcF9uYW1l4oCZIG1heQ0KPiA+Pj4+PiBi
ZSB1c2VkICB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XbWF5YmUtdW5pbml0aWFs
aXplZF0NCj4gPj4+Pj4gICAgICAgICAgICAgICBnX3N0cmxjcHkocy0+Yml0bWFwX25hbWUsIGJp
dG1hcF9uYW1lLA0KPiA+PiBzaXplb2Yocy0+Yml0bWFwX25hbWUpKTsNCj4gPj4+Pj4NCj4gPj4+
Pj4NCj4gPj4NCj4gXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn4NCj4gPj4+Pj4NCj4gPj4+Pj4gUmVwb3J0ZWQtYnk6IEV1bGVyIFJv
Ym90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDaGVu
IFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+ID4+Pj4+IC0tLQ0KPiA+Pj4+PiAgIG1p
Z3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYyB8IDIgLS0NCj4gPj4+Pj4gICAxIGZpbGUgY2hh
bmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL21pZ3Jh
dGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYw0KPiA+Pj4+PiBiL21pZ3JhdGlvbi9ibG9jay1kaXJ0
eS1iaXRtYXAuYyBpbmRleCA1YmVmNzkzYWMwLi5lMDllYTRmMjJiDQo+ID4+Pj4+IDEwMDY0NA0K
PiA+Pj4+PiAtLS0gYS9taWdyYXRpb24vYmxvY2stZGlydHktYml0bWFwLmMNCj4gPj4+Pj4gKysr
IGIvbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jDQo+ID4+Pj4+IEBAIC0xMDg0LDkgKzEw
ODQsNyBAQCBzdGF0aWMgaW50DQo+IGRpcnR5X2JpdG1hcF9sb2FkX2hlYWRlcihRRU1VRmlsZQ0K
PiA+PiAqZiwgREJNTG9hZFN0YXRlICpzLA0KPiA+Pj4+PiAgICAgICAgICAgICAgIH0gZWxzZSB7
DQo+ID4+Pj4+ICAgICAgICAgICAgICAgICAgIGJpdG1hcF9uYW1lID0gcy0+Yml0bWFwX2FsaWFz
Ow0KPiA+Pj4+PiAgICAgICAgICAgICAgIH0NCj4gPj4+Pj4gLSAgICAgICAgfQ0KPiA+Pj4+Pg0K
PiA+Pj4+PiAtICAgICAgICBpZiAoIXMtPmNhbmNlbGxlZCkgew0KPiA+Pj4+PiAgICAgICAgICAg
ICAgIGdfc3RybGNweShzLT5iaXRtYXBfbmFtZSwgYml0bWFwX25hbWUsDQo+ID4+IHNpemVvZihz
LT5iaXRtYXBfbmFtZSkpOw0KPiA+Pj4+PiAgICAgICAgICAgICAgIHMtPmJpdG1hcCA9IGJkcnZf
ZmluZF9kaXJ0eV9iaXRtYXAocy0+YnMsDQo+ID4+Pj4+IHMtPmJpdG1hcF9uYW1lKTsNCj4gPj4+
Pj4NCj4gPj4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IEkgZG9uJ3QgdGhpbmsgaXQncyBjb3JyZWN0IGFz
ICJjYW5jZWxfaW5jb21pbmdfbG9ja2VkKHMpIiBjYW4NCj4gPj4+PiBjaGFuZ2UgdGhlIHZhbHVl
IG9mICJzLT5jYW5jZWxsZWQiLg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gSGkgTGF1cmVudCwNCj4g
Pj4+DQo+ID4+PiBZb3UncmUgcmlnaHQuIFNvIEkgdGhpbmsgdGhpcyBjYW4gc2ltcGx5IGFzc2ln
biAnYml0bWFwX25hbWUnIHRvDQo+ID4+PiBOVUxMIHRvIG1ha2UgY29tcGlsZXIgaGFwcHkuDQo+
ID4+DQo+ID4+IFllcywgYW5kIGFkZGluZyBhIGNvbW1lbnQgYmVmb3JlIHRoZSBzZWNvbmQgImlm
ICghcy0+Y2FuY2VsbGVkKSB7IiB0bw0KPiA+PiBleHBsYWluIHRoZSB2YWx1ZSBjYW4gYmUgY2hh
bmdlZCBieSAiY2FuY2VsX2luY29taW5nX2xvY2tlZChzKSIgd291bGQNCj4gPj4gYXZvaWQgdG8g
aGF2ZSB0aGlzIGtpbmQgb2YgcGF0Y2ggcG9zdGVkIHJlZ3VsYXJseSB0byB0aGUgTUwuDQo+ID4+
DQo+ID4gSGkgTGF1cmVudCwNCj4gPg0KPiA+IFdlIGdpdmUgdGhlIGJpdG1hcF9uYW1lIGEgZGVm
YXVsdCB2YWx1ZSAocy0+Yml0bWFwX2FsaWFzKSBzbyB0aGF0IHdlIGNhbg0KPiByZW1vdmUgdGhl
IGFzc2lnbm1lbnQgb2YgdGhlIGVsc2UgYnJhbmNoIHN0YXRlbWVudC4NCj4gPg0KPiA+IEFuZCB0
aGVuIHdlIG1lcmdlIHRoZSB0d28gaWYgc3RhdGVtZW50cygiaWYgKCFzLT5jYW5jZWxsZWQpIiwg
ImlmDQo+IChiaXRtYXBfYWxpYXNfbWFwKSIpICwgIGF2b2lkcyBjb25mdXNpb24gdGhlIHR3byAi
aWYgKCFzLT5jYW5jZWxsZWQpIi4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBDaGVuIFF1bg0KPiA+
DQo+ID4NCj4gPiBUaGUgY29kZSBzaG93IGFzIHRoYXQ6DQo+ID4gQEAgLTEwNjQsMTUgKzEwNjQs
MTQgQEAgc3RhdGljIGludCBkaXJ0eV9iaXRtYXBfbG9hZF9oZWFkZXIoUUVNVUZpbGUNCj4gKmYs
IERCTUxvYWRTdGF0ZSAqcywNCj4gPiAgICAgICBhc3NlcnQobm90aGluZyB8fCBzLT5jYW5jZWxs
ZWQgfHwgISFhbGlhc19tYXAgPT0NCj4gPiAhIWJpdG1hcF9hbGlhc19tYXApOw0KPiA+DQo+ID4g
ICAgICAgaWYgKHMtPmZsYWdzICYgRElSVFlfQklUTUFQX01JR19GTEFHX0JJVE1BUF9OQU1FKSB7
DQo+ID4gLSAgICAgICAgY29uc3QgY2hhciAqYml0bWFwX25hbWU7DQo+ID4gKyAgICAgICAgY29u
c3QgY2hhciAqYml0bWFwX25hbWUgPSBzLT5iaXRtYXBfYWxpYXM7DQo+ID4NCj4gPiAgICAgICAg
ICAgaWYgKCFxZW11X2dldF9jb3VudGVkX3N0cmluZyhmLCBzLT5iaXRtYXBfYWxpYXMpKSB7DQo+
ID4gICAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIlVuYWJsZSB0byByZWFkIGJpdG1hcCBhbGlh
cyBzdHJpbmciKTsNCj4gPiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICAgICAg
ICAgICB9DQo+ID4NCj4gPiAtICAgICAgICBpZiAoIXMtPmNhbmNlbGxlZCkgew0KPiA+IC0gICAg
ICAgICAgICBpZiAoYml0bWFwX2FsaWFzX21hcCkgew0KPiA+ICsgICAgICAgIGlmICghcy0+Y2Fu
Y2VsbGVkICYmIGJpdG1hcF9hbGlhc19tYXApIHsNCj4gPiAgICAgICAgICAgICAgICAgICBiaXRt
YXBfbmFtZSA9DQo+IGdfaGFzaF90YWJsZV9sb29rdXAoYml0bWFwX2FsaWFzX21hcCwNCj4gPg0K
PiBzLT5iaXRtYXBfYWxpYXMpOw0KPiA+ICAgICAgICAgICAgICAgICAgIGlmICghYml0bWFwX25h
bWUpIHsNCj4gPiBAQCAtMTA4MSw5ICsxMDgwLDYgQEAgc3RhdGljIGludCBkaXJ0eV9iaXRtYXBf
bG9hZF9oZWFkZXIoUUVNVUZpbGUgKmYsDQo+IERCTUxvYWRTdGF0ZSAqcywNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHMtPmJzLT5ub2RlX25hbWUsDQo+IHMtPm5vZGVf
YWxpYXMpOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBjYW5jZWxfaW5jb21pbmdfbG9ja2Vk
KHMpOw0KPiA+ICAgICAgICAgICAgICAgICAgIH0NCj4gPiAtICAgICAgICAgICAgfSBlbHNlIHsN
Cj4gPiAtICAgICAgICAgICAgICAgIGJpdG1hcF9uYW1lID0gcy0+Yml0bWFwX2FsaWFzOw0KPiA+
IC0gICAgICAgICAgICB9DQo+ID4gICAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgICBpZiAo
IXMtPmNhbmNlbGxlZCkgew0KPiA+DQo+IA0KPiBTb3VuZHMgZ29vZC4NCj4gDQpPSywgSSdsbCB1
cGRhdGUgaXQgbGF0ZXIuDQoNClRoYW5rcywNCkNoZW4gUXVuDQo=

