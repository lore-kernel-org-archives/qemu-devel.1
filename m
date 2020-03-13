Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BF7C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 12:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A425C206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 12:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A425C206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCjRU-0002Tn-Qg
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 08:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jCjQY-0001g3-JQ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 08:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jCjQX-0007gh-3o
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 08:28:34 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2458 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jCjQW-0007RI-OA; Fri, 13 Mar 2020 08:28:33 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id D6D892A0FBBEADF3A927;
 Fri, 13 Mar 2020 20:28:27 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 13 Mar 2020 20:28:27 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.115]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0439.000;
 Fri, 13 Mar 2020 20:28:17 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH v3] hw/net/imx_fec: write TGSR and TCSR3 in
 imx_enet_write()
Thread-Topic: [PATCH v3] hw/net/imx_fec: write TGSR and TCSR3 in
 imx_enet_write()
Thread-Index: AQHV+ObPtRtUe3LsBUSeORYMttecbahF3cmAgACVqvA=
Date: Fri, 13 Mar 2020 12:28:17 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B68C891@dggemm511-mbx.china.huawei.com>
References: <20200313032327.7008-1-kuhn.chenqun@huawei.com>
 <CAFEAcA9mOppVAYgP4LJeuSBgiaYN16H+JHbKr7OTFvjbvD-3wA@mail.gmail.com>
In-Reply-To: <CAFEAcA9mOppVAYgP4LJeuSBgiaYN16H+JHbKr7OTFvjbvD-3wA@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.205.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.187
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGV0ZXIgTWF5ZGVsbCBbbWFpbHRv
OnBldGVyLm1heWRlbGxAbGluYXJvLm9yZ10NCj5TZW50OiBGcmlkYXksIE1hcmNoIDEzLCAyMDIw
IDc6MzEgUE0NCj5UbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPg0K
PkNjOiBRRU1VIERldmVsb3BlcnMgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IFFFTVUgVHJpdmlh
bCA8cWVtdS0NCj50cml2aWFsQG5vbmdudS5vcmc+OyBaaGFuZ2hhaWxpYW5nIDx6aGFuZy56aGFu
Z2hhaWxpYW5nQGh1YXdlaS5jb20+Ow0KPkV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWku
Y29tPjsgSmFzb24gV2FuZw0KPjxqYXNvd2FuZ0ByZWRoYXQuY29tPjsgUGV0ZXIgQ2h1YmIgPHBl
dGVyLmNodWJiQG5pY3RhLmNvbS5hdT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzXSBody9uZXQv
aW14X2ZlYzogd3JpdGUgVEdTUiBhbmQgVENTUjMgaW4NCj5pbXhfZW5ldF93cml0ZSgpDQo+DQo+
T24gRnJpLCAxMyBNYXIgMjAyMCBhdCAwMzoyMywgQ2hlbiBRdW4gPGt1aG4uY2hlbnF1bkBodWF3
ZWkuY29tPiB3cm90ZToNCj4+DQo+PiBUaGUgY3VycmVudCBjb2RlIGNhdXNlcyBjbGFuZyBzdGF0
aWMgY29kZSBhbmFseXplciBnZW5lcmF0ZSB3YXJuaW5nOg0KPj4gaHcvbmV0L2lteF9mZWMuYzo4
NTg6OTogd2FybmluZzogVmFsdWUgc3RvcmVkIHRvICd2YWx1ZScgaXMgbmV2ZXIgcmVhZA0KPj4g
ICAgICAgICB2YWx1ZSA9IHZhbHVlICYgMHgwMDAwMDAwZjsNCj4+ICAgICAgICAgXiAgICAgICB+
fn5+fn5+fn5+fn5+fn5+fn4NCj4+IGh3L25ldC9pbXhfZmVjLmM6ODY0Ojk6IHdhcm5pbmc6IFZh
bHVlIHN0b3JlZCB0byAndmFsdWUnIGlzIG5ldmVyIHJlYWQNCj4+ICAgICAgICAgdmFsdWUgPSB2
YWx1ZSAmIDB4MDAwMDAwZmQ7DQo+PiAgICAgICAgIF4gICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+
DQo+Pg0KPj4gQWNjb3JkaW5nIHRvIHRoZSBkZWZpbml0aW9uIG9mIHRoZSBmdW5jdGlvbiwgdGhl
IHR3byDigJx2YWx1ZeKAnQ0KPj4gYXNzaWdubWVudHMgIHNob3VsZCBiZSB3cml0dGVuIHRvIHJl
Z2lzdGVycy4NCj4+DQo+PiBSZXBvcnRlZC1ieTogRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1
YXdlaS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdl
aS5jb20+DQo+PiAtLS0NCj4+IENjOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc+DQo+PiBDYzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4+IENjOiBQ
ZXRlciBDaHViYiA8cGV0ZXIuY2h1YmJAbmljdGEuY29tLmF1Pg0KPj4NCj4+IHYxLT52MjoNCj4+
ICAgVGhlIHJlZ2lzdGVyICdFTkVUX1RHU1InIHdyaXRlLTEtdG8tY2xlYXIgdGltZXIgZmxhZy4N
Cj4+ICAgVGhlIHJlZ2lzdGVyICdFTkVUX1RDU1JuJyA3Yml0KFRGKSB3cml0ZS0xLXRvLWNsZWFy
IHRpbWVyIGZsYWcuDQo+Pg0KPj4gdjItPnYzOg0KPj4gICBPcHRpbWl6ZSBjb2RlIHN0eWxlLCBi
YXNlZCBvbiBkaXNjdXNzaW9ucyB3aXRoIFBldGVyLg0KPj4gLS0tDQo+PiAgaHcvbmV0L2lteF9m
ZWMuYyB8IDkgKysrKysrLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvbmV0L2lteF9mZWMuYyBiL2h3
L25ldC9pbXhfZmVjLmMgaW5kZXgNCj4+IDZhMTI0YTE1NGEuLjM1NDc5NzU3MTAgMTAwNjQ0DQo+
PiAtLS0gYS9ody9uZXQvaW14X2ZlYy5jDQo+PiArKysgYi9ody9uZXQvaW14X2ZlYy5jDQo+PiBA
QCAtODU0LDE0ICs4NTQsMTcgQEAgc3RhdGljIHZvaWQgaW14X2VuZXRfd3JpdGUoSU1YRkVDU3Rh
dGUgKnMsDQo+dWludDMyX3QgaW5kZXgsIHVpbnQzMl90IHZhbHVlKQ0KPj4gICAgICAgICAgcy0+
cmVnc1tpbmRleF0gPSB2YWx1ZSAmIDB4MDAwMDdmN2Y7DQo+PiAgICAgICAgICBicmVhazsNCj4+
ICAgICAgY2FzZSBFTkVUX1RHU1I6DQo+PiAtICAgICAgICAvKiBpbXBsZW1lbnQgY2xlYXIgdGlt
ZXIgZmxhZyAqLw0KPj4gLSAgICAgICAgdmFsdWUgPSB2YWx1ZSAmIDB4MDAwMDAwMGY7DQo+PiAr
ICAgICAgICAvKiBpbXBsZW1lbnQgY2xlYXIgdGltZXIgZmxhZywgMC0zIGJpdHMgVzFDLCByZXNl
cnZlZCBiaXRzIHdyaXRlIHplcm8gKi8NCj4+ICsgICAgICAgIHMtPnJlZ3NbaW5kZXhdICY9IH4o
dmFsdWUgJiAweDAwMDAwMDBmKSAmIDB4MDAwMDAwMGY7DQo+DQo+SSB0aGluayBJIG11c3QgaGF2
ZSBtaXN1bmRlcnN0b29kIHdoYXQgeW91IHdlcmUgc3VnZ2VzdGluZyBpbiB5b3VyIHByZXZpb3Vz
DQo+cXVlc3Rpb24uDQo+VGhlIGZpbmFsICYgd2l0aCAweDAwMDAwMDBmIGhlcmUgaXMgdW5uZWNl
c3NhcnksIGJlY2F1c2UgdGhvc2UgYml0cyBhcmUNCj5hbHdheXMgMCBpbiBzLT5yZWdzW2luZGV4
XSBhbnl3YXkuDQo+DQo+PiAgICAgICAgICBicmVhazsNCj4+ICAgICAgY2FzZSBFTkVUX1RDU1Iw
Og0KPj4gICAgICBjYXNlIEVORVRfVENTUjE6DQo+PiAgICAgIGNhc2UgRU5FVF9UQ1NSMjoNCj4+
ICAgICAgY2FzZSBFTkVUX1RDU1IzOg0KPj4gLSAgICAgICAgdmFsdWUgPSB2YWx1ZSAmIDB4MDAw
MDAwZmQ7DQo+PiArICAgICAgICAvKiA3IGJpdHMgVzFDLCByZXNlcnZlZCBiaXRzIHdyaXRlIHpl
cm8gKi8NCj4+ICsgICAgICAgIHMtPnJlZ3NbaW5kZXhdICY9IH4odmFsdWUgJiAweDAwMDAwMDgw
KSAmIDB4MDAwMDAwZmY7DQo+DQo+U2ltaWxhcmx5IGhlcmUuDQo+DQo+PiArICAgICAgICBzLT5y
ZWdzW2luZGV4XSAmPSB+MHgwMDAwMDA3ZDsgLyogd3JpdGFibGUgZmllbGRzICovDQo+PiArICAg
ICAgICBzLT5yZWdzW2luZGV4XSB8PSAodmFsdWUgJiAweDAwMDAwMDdkKTsNCj4+ICAgICAgICAg
IGJyZWFrOw0KPj4gICAgICBjYXNlIEVORVRfVENDUjA6DQo+PiAgICAgIGNhc2UgRU5FVF9UQ0NS
MToNCj4NCj5TaG9ydCBhbnN3ZXI6IG15IHJlY29tbWVuZGF0aW9uIGlzIHRvIHVzZSB0aGUgZXhw
cmVzc2lvbnMgSSByZWNvbW1lbmRlZA0KPnRoYXQgeW91IHVzZS4uLg0KDQpBbGwgcmlnaHQsICBJ
IGNoYW5nZSBpdCBsYXRlci4NCg0KVGhhbmtzLg0K

