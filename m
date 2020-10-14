Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C389C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 01:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69E0208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 01:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69E0208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSVEo-0006zl-35
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 21:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kSVD0-0006Lk-49; Tue, 13 Oct 2020 21:04:02 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:49834 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kSVCs-0007sO-JB; Tue, 13 Oct 2020 21:04:01 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 2B79930560E6550F719E;
 Wed, 14 Oct 2020 09:03:46 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 14 Oct 2020 09:03:46 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.75]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0487.000;
 Wed, 14 Oct 2020 09:03:35 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH v2] migration/block-dirty-bitmap: fix uninitialized
 variable warning
Thread-Topic: [PATCH v2] migration/block-dirty-bitmap: fix uninitialized
 variable warning
Thread-Index: AQHWoV0hzSMk/IMnP02jswbxivecYqmVFqSAgAEuwTA=
Date: Wed, 14 Oct 2020 01:03:35 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B9B6538@dggemm531-mbx.china.huawei.com>
References: <20201013123340.1850548-1-kuhn.chenqun@huawei.com>
 <561a0092-3723-a95a-0208-d53cb475a532@redhat.com>
In-Reply-To: <561a0092-3723-a95a-0208-d53cb475a532@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 21:03:46
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
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF4IFJlaXR6IFttYWls
dG86bXJlaXR6QHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTMsIDIwMjAg
MTA6NDcgUE0NCj4gVG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT47
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gcWVtdS10cml2aWFsQG5vbmdudS5vcmcNCj4gQ2M6
IHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbTsgc3RlZmFuaGFAcmVkaGF0LmNvbTsgZmFtQGV1cGhv
bi5uZXQ7DQo+IGVibGFrZUByZWRoYXQuY29tOyBqc25vd0ByZWRoYXQuY29tOyBxdWludGVsYUBy
ZWRoYXQuY29tOw0KPiBkZ2lsYmVydEByZWRoYXQuY29tOyBaaGFuZ2hhaWxpYW5nIDx6aGFuZy56
aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+Ow0KPiBnYW5xaXhpbiA8Z2FucWl4aW5AaHVhd2VpLmNv
bT47IHFlbXUtYmxvY2tAbm9uZ251Lm9yZzsgRXVsZXIgUm9ib3QNCj4gPGV1bGVyLnJvYm90QGh1
YXdlaS5jb20+OyBMYXVyZW50IFZpdmllciA8bGF1cmVudEB2aXZpZXIuZXU+OyBMaSBRaWFuZw0K
PiA8bGlxM2VhQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gbWlncmF0aW9u
L2Jsb2NrLWRpcnR5LWJpdG1hcDogZml4IHVuaW5pdGlhbGl6ZWQgdmFyaWFibGUNCj4gd2Fybmlu
Zw0KPiANCj4gT24gMTMuMTAuMjAgMTQ6MzMsIENoZW4gUXVuIHdyb3RlOg0KPiA+IEEgZGVmYXVs
dCB2YWx1ZSBpcyBwcm92aWRlZCBmb3IgdGhlIHZhcmlhYmxlICdiaXRtYXBfbmFtZScgdG8gYXZv
aWQgY29tcGlsZXINCj4gd2FybmluZy4NCj4gPg0KPiA+IFRoZSBjb21waWxlciBzaG93IHdhcm5p
bmc6DQo+ID4gbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jOjEwOTA6MTM6IHdhcm5pbmc6
IOKAmGJpdG1hcF9uYW1l4oCZDQo+ID4gbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlz
IGZ1bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdDQo+ID4gICAgICAgIGdfc3RybGNweShz
LT5iaXRtYXBfbmFtZSwgYml0bWFwX25hbWUsDQo+IHNpemVvZihzLT5iaXRtYXBfbmFtZSkpOw0K
PiA+DQo+IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+DQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogRXVsZXIgUm9ib3QgPGV1bGVyLnJv
Ym90QGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hlbiBRdW4gPGt1aG4uY2hlbnF1
bkBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+IENjOiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+ID4gQ2M6IExhdXJlbnQgVml2aWVyIDxs
YXVyZW50QHZpdmllci5ldT4NCj4gPiBDYzogTGkgUWlhbmcgPGxpcTNlYUBnbWFpbC5jb20+DQo+
ID4gLS0tDQo+ID4gIG1pZ3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYyB8IDkgKystLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+
IA0KPiBObyBvYmplY3Rpb25zLCBzZW1hbnRpY2FsbHksIGJ1dC4uLg0KPiANCj4gPiBkaWZmIC0t
Z2l0IGEvbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jDQo+ID4gYi9taWdyYXRpb24vYmxv
Y2stZGlydHktYml0bWFwLmMgaW5kZXggNWJlZjc5M2FjMC4uYmNiNzljMDRjZSAxMDA2NDQNCj4g
PiAtLS0gYS9taWdyYXRpb24vYmxvY2stZGlydHktYml0bWFwLmMNCj4gPiArKysgYi9taWdyYXRp
b24vYmxvY2stZGlydHktYml0bWFwLmMNCj4gPiBAQCAtMTA2NCwxNSArMTA2NCwxMyBAQCBzdGF0
aWMgaW50IGRpcnR5X2JpdG1hcF9sb2FkX2hlYWRlcihRRU1VRmlsZQ0KPiAqZiwgREJNTG9hZFN0
YXRlICpzLA0KPiA+ICAgICAgYXNzZXJ0KG5vdGhpbmcgfHwgcy0+Y2FuY2VsbGVkIHx8ICEhYWxp
YXNfbWFwID09DQo+ID4gISFiaXRtYXBfYWxpYXNfbWFwKTsNCj4gPg0KPiA+ICAgICAgaWYgKHMt
PmZsYWdzICYgRElSVFlfQklUTUFQX01JR19GTEFHX0JJVE1BUF9OQU1FKSB7DQo+ID4gLSAgICAg
ICAgY29uc3QgY2hhciAqYml0bWFwX25hbWU7DQo+ID4gLQ0KPiA+ICAgICAgICAgIGlmICghcWVt
dV9nZXRfY291bnRlZF9zdHJpbmcoZiwgcy0+Yml0bWFwX2FsaWFzKSkgew0KPiA+ICAgICAgICAg
ICAgICBlcnJvcl9yZXBvcnQoIlVuYWJsZSB0byByZWFkIGJpdG1hcCBhbGlhcyBzdHJpbmciKTsN
Cj4gPiAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gICAgICAgICAgfQ0KPiA+DQo+
ID4gLSAgICAgICAgaWYgKCFzLT5jYW5jZWxsZWQpIHsNCj4gPiAtICAgICAgICAgICAgaWYgKGJp
dG1hcF9hbGlhc19tYXApIHsNCj4gPiArICAgICAgICBjb25zdCBjaGFyICpiaXRtYXBfbmFtZSA9
IHMtPmJpdG1hcF9hbGlhczsNCj4gDQo+IHFlbXXigJlzIGNvZGluZyBzdHlsZSBtYW5kYXRlcyBk
ZWNsYXJhdGlvbnMgdG8gYmUgcGxhY2VkIGF0IHRoZSBiZWdpbm5pbmcgb2YNCj4gdGhlaXIgYmxv
Y2ssIHNvIHRoZSBkZWNsYXJhdGlvbiBoYXMgdG8gc3RheSB3aGVyZSBpdCBpcy4gIChQdXR0aW5n
IHRoZSBhc3NpZ25tZW50DQo+IGhlcmUgbG9va3MgcmVhc29uYWJsZS4pDQo+IA0KSGkgTWF4LA0K
ICBEZWNsYXJhdGlvbiB2YXJpYWJsZXMgaGVyZSB0byBlbnN1cmUgdGhhdCB0aGUgYWJvdmUgZXhj
ZXB0aW9ucyhVbmFibGUgdG8gcmVhZCBiaXRtYXAgYWxpYXMgc3RyaW5nKSBhcmUgYXZvaWRlZC4N
CklmIHRoZSBkZWNsYXJhdGlvbiBoYXMgdG8gc3RheSB3aGVyZSBpdCBpcywgaXMgdGhlcmUgYSBw
b3NzaWJpbGl0eSB0aGF0IHRoZSBhc3NpZ25tZW50IGZhaWxzPw0KDQo+ID4gKyAgICAgICAgaWYg
KCFzLT5jYW5jZWxsZWQgJiYgYml0bWFwX2FsaWFzX21hcCkgew0KPiA+ICAgICAgICAgICAgICAg
ICAgYml0bWFwX25hbWUgPQ0KPiBnX2hhc2hfdGFibGVfbG9va3VwKGJpdG1hcF9hbGlhc19tYXAs
DQo+ID4NCj4gcy0+Yml0bWFwX2FsaWFzKTsNCj4gDQo+IFRoaXMgYmxvY2sgb2YgY291cnNlIG5l
ZWRzIHRvIGJlIHJlLWluZGVudGVkLg0KPiANCkkgZm9yZ290IHRoaXMuIEkgd2lsbCB1cGRhdGUg
aXQgbGF0ZXIuDQoNClRoYW5rcywNCkNoZW5RdW4NCg0KPiANCj4gPiAgICAgICAgICAgICAgICAg
IGlmICghYml0bWFwX25hbWUpIHsNCj4gPiBAQCAtMTA4MSw5ICsxMDc5LDYgQEAgc3RhdGljIGlu
dCBkaXJ0eV9iaXRtYXBfbG9hZF9oZWFkZXIoUUVNVUZpbGUgKmYsDQo+IERCTUxvYWRTdGF0ZSAq
cywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcy0+YnMtPm5vZGVfbmFt
ZSwNCj4gcy0+bm9kZV9hbGlhcyk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgY2FuY2VsX2lu
Y29taW5nX2xvY2tlZChzKTsNCj4gPiAgICAgICAgICAgICAgICAgIH0NCj4gPiAtICAgICAgICAg
ICAgfSBlbHNlIHsNCj4gPiAtICAgICAgICAgICAgICAgIGJpdG1hcF9uYW1lID0gcy0+Yml0bWFw
X2FsaWFzOw0KPiA+IC0gICAgICAgICAgICB9DQo+ID4gICAgICAgICAgfQ0KPiA+DQo+ID4gICAg
ICAgICAgaWYgKCFzLT5jYW5jZWxsZWQpIHsNCj4gPg0KPiANCg0K

