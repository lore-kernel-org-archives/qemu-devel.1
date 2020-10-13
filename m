Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8354C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B19A207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B19A207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSF4x-0007lm-TU
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kSF3u-0006xU-34; Tue, 13 Oct 2020 03:49:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2982 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kSF3r-00075u-7H; Tue, 13 Oct 2020 03:49:33 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 7029CF933DCD19530814;
 Tue, 13 Oct 2020 15:49:21 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.75]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0487.000;
 Tue, 13 Oct 2020 15:49:15 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Laurent Vivier <laurent@vivier.eu>, Li Qiang <liq3ea@gmail.com>
Subject: RE: [PATCH] migration/block-dirty-bitmap: fix uninitialized
 variable warning
Thread-Topic: [PATCH] migration/block-dirty-bitmap: fix uninitialized
 variable warning
Thread-Index: AQHWnvWXB6+3xHhZ7kqhgehHhToetKmTlYMAgACocACAAF4JAIAAjDZA
Date: Tue, 13 Oct 2020 07:49:15 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B9B2054@dggemm531-mbx.china.huawei.com>
References: <20201010110730.1575180-1-kuhn.chenqun@huawei.com>
 <2b2bc826-0785-66e2-3515-b98abfac26ca@vivier.eu>
 <CAKXe6SL8fRN=-iqFEiHeWqZm0F+T+8vkc7qJeUz6izQcZQ2Q-A@mail.gmail.com>
 <70bc9735-6555-078a-52da-61da6c58f1d3@vivier.eu>
In-Reply-To: <70bc9735-6555-078a-52da-61da6c58f1d3@vivier.eu>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:49:22
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
Cc: Fam Zheng <fam@euphon.net>,
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXVyZW50IFZpdmllciBbbWFp
bHRvOmxhdXJlbnRAdml2aWVyLmV1XQ0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEzLCAyMDIw
IDM6MTEgUE0NCj4gVG86IExpIFFpYW5nIDxsaXEzZWFAZ21haWwuY29tPg0KPiBDYzogRmFtIFpo
ZW5nIDxmYW1AZXVwaG9uLm5ldD47IGdhbnFpeGluIDxnYW5xaXhpbkBodWF3ZWkuY29tPjsNCj4g
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tOyBaaGFuZ2hhaWxpYW5nDQo+IDx6aGFuZy56aGFuZ2hh
aWxpYW5nQGh1YXdlaS5jb20+OyBxZW11LWJsb2NrQG5vbmdudS5vcmc7IEp1YW4gUXVpbnRlbGEN
Cj4gPHF1aW50ZWxhQHJlZGhhdC5jb20+OyBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZzsgUWVtdSBE
ZXZlbG9wZXJzDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBEci4gRGF2aWQgQWxhbiBHaWxi
ZXJ0IDxkZ2lsYmVydEByZWRoYXQuY29tPjsNCj4gU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUBy
ZWRoYXQuY29tPjsgRXVsZXIgUm9ib3QNCj4gPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+OyBDaGVu
cXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+Ow0KPiBNYXggUmVpdHogPG1yZWl0
ekByZWRoYXQuY29tPjsgSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBtaWdyYXRpb24vYmxvY2stZGlydHktYml0bWFwOiBmaXggdW5pbml0aWFsaXpl
ZCB2YXJpYWJsZQ0KPiB3YXJuaW5nDQo+IA0KPiBMZSAxMy8xMC8yMDIwIMOgIDAzOjM0LCBMaSBR
aWFuZyBhIMOpY3JpdMKgOg0KPiA+IExhdXJlbnQgVml2aWVyIDxsYXVyZW50QHZpdmllci5ldT4g
5LqOMjAyMOW5tDEw5pyIMTLml6XlkajkuIAg5LiL5Y2IMTE6MzMNCj4g5YaZ6YGT77yaDQo+ID4+
DQo+ID4+IExlIDEwLzEwLzIwMjAgw6AgMTM6MDcsIENoZW4gUXVuIGEgw6ljcml0IDoNCj4gPj4+
IFRoaXMgaWYgc3RhdGVtZW50IGp1ZGdtZW50IGlzIHJlZHVuZGFudCBhbmQgaXQgd2lsbCBjYXVz
ZSBhIHdhcm5pbmc6DQo+ID4+Pg0KPiA+Pj4gbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5j
OjEwOTA6MTM6IHdhcm5pbmc6IOKAmGJpdG1hcF9uYW1l4oCZIG1heQ0KPiA+Pj4gYmUgdXNlZCAg
dW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdDQo+
ID4+PiAgICAgICAgICAgICAgZ19zdHJsY3B5KHMtPmJpdG1hcF9uYW1lLCBiaXRtYXBfbmFtZSwN
Cj4gc2l6ZW9mKHMtPmJpdG1hcF9uYW1lKSk7DQo+ID4+Pg0KPiA+Pj4NCj4gXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gPj4+
DQo+ID4+PiBSZXBvcnRlZC1ieTogRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+
DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+
DQo+ID4+PiAtLS0NCj4gPj4+ICBtaWdyYXRpb24vYmxvY2stZGlydHktYml0bWFwLmMgfCAyIC0t
DQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlm
ZiAtLWdpdCBhL21pZ3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYw0KPiA+Pj4gYi9taWdyYXRp
b24vYmxvY2stZGlydHktYml0bWFwLmMgaW5kZXggNWJlZjc5M2FjMC4uZTA5ZWE0ZjIyYiAxMDA2
NDQNCj4gPj4+IC0tLSBhL21pZ3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYw0KPiA+Pj4gKysr
IGIvbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jDQo+ID4+PiBAQCAtMTA4NCw5ICsxMDg0
LDcgQEAgc3RhdGljIGludCBkaXJ0eV9iaXRtYXBfbG9hZF9oZWFkZXIoUUVNVUZpbGUNCj4gKmYs
IERCTUxvYWRTdGF0ZSAqcywNCj4gPj4+ICAgICAgICAgICAgICB9IGVsc2Ugew0KPiA+Pj4gICAg
ICAgICAgICAgICAgICBiaXRtYXBfbmFtZSA9IHMtPmJpdG1hcF9hbGlhczsNCj4gPj4+ICAgICAg
ICAgICAgICB9DQo+ID4+PiAtICAgICAgICB9DQo+ID4+Pg0KPiA+Pj4gLSAgICAgICAgaWYgKCFz
LT5jYW5jZWxsZWQpIHsNCj4gPj4+ICAgICAgICAgICAgICBnX3N0cmxjcHkocy0+Yml0bWFwX25h
bWUsIGJpdG1hcF9uYW1lLA0KPiBzaXplb2Yocy0+Yml0bWFwX25hbWUpKTsNCj4gPj4+ICAgICAg
ICAgICAgICBzLT5iaXRtYXAgPSBiZHJ2X2ZpbmRfZGlydHlfYml0bWFwKHMtPmJzLA0KPiA+Pj4g
cy0+Yml0bWFwX25hbWUpOw0KPiA+Pj4NCj4gPj4+DQo+ID4+DQo+ID4+IEkgZG9uJ3QgdGhpbmsg
aXQncyBjb3JyZWN0IGFzICJjYW5jZWxfaW5jb21pbmdfbG9ja2VkKHMpIiBjYW4gY2hhbmdlDQo+
ID4+IHRoZSB2YWx1ZSBvZiAicy0+Y2FuY2VsbGVkIi4NCj4gPj4NCj4gPg0KPiA+IEhpIExhdXJl
bnQsDQo+ID4NCj4gPiBZb3UncmUgcmlnaHQuIFNvIEkgdGhpbmsgdGhpcyBjYW4gc2ltcGx5IGFz
c2lnbiAnYml0bWFwX25hbWUnIHRvIE5VTEwNCj4gPiB0byBtYWtlIGNvbXBpbGVyIGhhcHB5Lg0K
PiANCj4gWWVzLCBhbmQgYWRkaW5nIGEgY29tbWVudCBiZWZvcmUgdGhlIHNlY29uZCAiaWYgKCFz
LT5jYW5jZWxsZWQpIHsiIHRvIGV4cGxhaW4NCj4gdGhlIHZhbHVlIGNhbiBiZSBjaGFuZ2VkIGJ5
ICJjYW5jZWxfaW5jb21pbmdfbG9ja2VkKHMpIiB3b3VsZCBhdm9pZCB0byBoYXZlDQo+IHRoaXMg
a2luZCBvZiBwYXRjaCBwb3N0ZWQgcmVndWxhcmx5IHRvIHRoZSBNTC4NCj4gDQpIaSBMYXVyZW50
LA0KDQpXZSBnaXZlIHRoZSBiaXRtYXBfbmFtZSBhIGRlZmF1bHQgdmFsdWUgKHMtPmJpdG1hcF9h
bGlhcykgc28gdGhhdCB3ZSBjYW4gcmVtb3ZlIHRoZSBhc3NpZ25tZW50IG9mIHRoZSBlbHNlIGJy
YW5jaCBzdGF0ZW1lbnQuDQoNCkFuZCB0aGVuIHdlIG1lcmdlIHRoZSB0d28gaWYgc3RhdGVtZW50
cygiaWYgKCFzLT5jYW5jZWxsZWQpIiwgImlmIChiaXRtYXBfYWxpYXNfbWFwKSIpICwgIGF2b2lk
cyBjb25mdXNpb24gdGhlIHR3byAiaWYgKCFzLT5jYW5jZWxsZWQpIi4NCg0KVGhhbmtzLA0KQ2hl
biBRdW4NCg0KDQpUaGUgY29kZSBzaG93IGFzIHRoYXQ6DQpAQCAtMTA2NCwxNSArMTA2NCwxNCBA
QCBzdGF0aWMgaW50IGRpcnR5X2JpdG1hcF9sb2FkX2hlYWRlcihRRU1VRmlsZSAqZiwgREJNTG9h
ZFN0YXRlICpzLA0KICAgICBhc3NlcnQobm90aGluZyB8fCBzLT5jYW5jZWxsZWQgfHwgISFhbGlh
c19tYXAgPT0gISFiaXRtYXBfYWxpYXNfbWFwKTsNCg0KICAgICBpZiAocy0+ZmxhZ3MgJiBESVJU
WV9CSVRNQVBfTUlHX0ZMQUdfQklUTUFQX05BTUUpIHsNCi0gICAgICAgIGNvbnN0IGNoYXIgKmJp
dG1hcF9uYW1lOw0KKyAgICAgICAgY29uc3QgY2hhciAqYml0bWFwX25hbWUgPSBzLT5iaXRtYXBf
YWxpYXM7DQoNCiAgICAgICAgIGlmICghcWVtdV9nZXRfY291bnRlZF9zdHJpbmcoZiwgcy0+Yml0
bWFwX2FsaWFzKSkgew0KICAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiVW5hYmxlIHRvIHJlYWQg
Yml0bWFwIGFsaWFzIHN0cmluZyIpOw0KICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KICAg
ICAgICAgfQ0KDQotICAgICAgICBpZiAoIXMtPmNhbmNlbGxlZCkgew0KLSAgICAgICAgICAgIGlm
IChiaXRtYXBfYWxpYXNfbWFwKSB7DQorICAgICAgICBpZiAoIXMtPmNhbmNlbGxlZCAmJiBiaXRt
YXBfYWxpYXNfbWFwKSB7DQogICAgICAgICAgICAgICAgIGJpdG1hcF9uYW1lID0gZ19oYXNoX3Rh
YmxlX2xvb2t1cChiaXRtYXBfYWxpYXNfbWFwLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcy0+Yml0bWFwX2FsaWFzKTsNCiAgICAgICAgICAgICAg
ICAgaWYgKCFiaXRtYXBfbmFtZSkgew0KQEAgLTEwODEsOSArMTA4MCw2IEBAIHN0YXRpYyBpbnQg
ZGlydHlfYml0bWFwX2xvYWRfaGVhZGVyKFFFTVVGaWxlICpmLCBEQk1Mb2FkU3RhdGUgKnMsDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcy0+YnMtPm5vZGVfbmFtZSwgcy0+bm9k
ZV9hbGlhcyk7DQogICAgICAgICAgICAgICAgICAgICBjYW5jZWxfaW5jb21pbmdfbG9ja2VkKHMp
Ow0KICAgICAgICAgICAgICAgICB9DQotICAgICAgICAgICAgfSBlbHNlIHsNCi0gICAgICAgICAg
ICAgICAgYml0bWFwX25hbWUgPSBzLT5iaXRtYXBfYWxpYXM7DQotICAgICAgICAgICAgfQ0KICAg
ICAgICAgfQ0KDQogICAgICAgICBpZiAoIXMtPmNhbmNlbGxlZCkgew0K

