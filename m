Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722C2C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 11:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D8B2073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 11:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D8B2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9oKG-0007jC-7e
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 06:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j9oJQ-0006OZ-OT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 06:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j9oJP-0002iD-Dj
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 06:05:08 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:51302 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j9oJM-0002Xb-2E; Thu, 05 Mar 2020 06:05:04 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 54C90AAAFE4961260910;
 Thu,  5 Mar 2020 19:04:58 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 5 Mar 2020 19:04:57 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.163]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0439.000;
 Thu, 5 Mar 2020 19:04:47 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: RE: [PATCH v2] hw/net/imx_fec: write TGSR and TCSR3 in
 imx_enet_write()
Thread-Topic: [PATCH v2] hw/net/imx_fec: write TGSR and TCSR3 in
 imx_enet_write()
Thread-Index: AQHV8txXWFydji2esEaJwP7bouY1uqg507VQ
Date: Thu, 5 Mar 2020 11:04:46 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B66DA01@dggemm531-mbx.china.huawei.com>
References: <20200305105325.31264-1-kuhn.chenqun@huawei.com>
In-Reply-To: <20200305105325.31264-1-kuhn.chenqun@huawei.com>
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
X-Received-From: 45.249.212.255
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.chubb@nicta.com.au" <peter.chubb@nicta.com.au>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2hlbnF1biAoa3VobikNCj5TZW50
OiBUaHVyc2RheSwgTWFyY2ggNSwgMjAyMCA2OjUzIFBNDQo+VG86IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZzsgcWVtdS10cml2aWFsQG5vbmdudS5vcmcNCj5DYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8u
b3JnOyBaaGFuZ2hhaWxpYW5nDQo+PHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IGph
c293YW5nQHJlZGhhdC5jb207DQo+cGV0ZXIuY2h1YmJAbmljdGEuY29tLmF1OyBxZW11LWFybUBu
b25nbnUub3JnOyBDaGVucXVuIChrdWhuKQ0KPjxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT47IEV1
bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFtQQVRDSCB2Ml0g
aHcvbmV0L2lteF9mZWM6IHdyaXRlIFRHU1IgYW5kIFRDU1IzIGluDQo+aW14X2VuZXRfd3JpdGUo
KQ0KPg0KPlRoZSBjdXJyZW50IGNvZGUgY2F1c2VzIGNsYW5nIHN0YXRpYyBjb2RlIGFuYWx5emVy
IGdlbmVyYXRlIHdhcm5pbmc6DQo+aHcvbmV0L2lteF9mZWMuYzo4NTg6OTogd2FybmluZzogVmFs
dWUgc3RvcmVkIHRvICd2YWx1ZScgaXMgbmV2ZXIgcmVhZA0KPiAgICAgICAgdmFsdWUgPSB2YWx1
ZSAmIDB4MDAwMDAwMGY7DQo+ICAgICAgICBeICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fg0KPmh3
L25ldC9pbXhfZmVjLmM6ODY0Ojk6IHdhcm5pbmc6IFZhbHVlIHN0b3JlZCB0byAndmFsdWUnIGlz
IG5ldmVyIHJlYWQNCj4gICAgICAgIHZhbHVlID0gdmFsdWUgJiAweDAwMDAwMGZkOw0KPiAgICAg
ICAgXiAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn4NCj4NCj5BY2NvcmRpbmcgdG8gdGhlIGRlZmlu
aXRpb24gb2YgdGhlIGZ1bmN0aW9uLCB0aGUgdHdvIOKAnHZhbHVl4oCdIGFzc2lnbm1lbnRzDQo+
c2hvdWxkIGJlIHdyaXR0ZW4gdG8gcmVnaXN0ZXJzLg0KPg0KPlJlcG9ydGVkLWJ5OiBFdWxlciBS
b2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT4NCj5TaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8
a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+LS0tDQo+djEtPnYyOg0KPiAgVGhlIHJlZ2lzdGVy
ICdFTkVUX1RHU1InIHdyaXRlLTEtdG8tY2xlYXIgdGltZXIgZmxhZy4NCj4gIFRoZSByZWdpc3Rl
ciAnRU5FVF9UQ1NSbicgN2JpdChURikgd3JpdGUtMS10by1jbGVhciB0aW1lciBmbGFnLg0KPi0t
LQ0KPiBody9uZXQvaW14X2ZlYy5jIHwgNiArKysrLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0IGEvaHcvbmV0L2lteF9m
ZWMuYyBiL2h3L25ldC9pbXhfZmVjLmMgaW5kZXgNCj42YTEyNGExNTRhLi4zMjJjYmRjYzE3IDEw
MDY0NA0KPi0tLSBhL2h3L25ldC9pbXhfZmVjLmMNCj4rKysgYi9ody9uZXQvaW14X2ZlYy5jDQo+
QEAgLTg1NSwxMyArODU1LDE1IEBAIHN0YXRpYyB2b2lkIGlteF9lbmV0X3dyaXRlKElNWEZFQ1N0
YXRlICpzLA0KPnVpbnQzMl90IGluZGV4LCB1aW50MzJfdCB2YWx1ZSkNCj4gICAgICAgICBicmVh
azsNCj4gICAgIGNhc2UgRU5FVF9UR1NSOg0KPiAgICAgICAgIC8qIGltcGxlbWVudCBjbGVhciB0
aW1lciBmbGFnICovDQo+LSAgICAgICAgdmFsdWUgPSB2YWx1ZSAmIDB4MDAwMDAwMGY7DQo+KyAg
ICAgICAgcy0+cmVnc1tpbmRleF0gXj0gcy0+cmVnc1tpbmRleF0gJiB2YWx1ZTsNCj4rICAgICAg
ICBzLT5yZWdzW2luZGV4XSAmPSAweDAwMDAwMDBmOw0KPg0KSW4gImkuTVggNkR1YWwvNlF1YWQg
QXBwbGljYXRpb25zIFByb2Nlc3NvciBSZWZlcmVuY2UgTWFudWFsIiBkb2N1bWVudGF0aW9uLCAg
DQp0aGUgcmVnaXN0ZXIgICdFTkVUX1RHU1InICBhbGwgIGZpZWxkcyBURm4gIGlzIHdyaXRlLTEt
dG8tY2xlYXIuIA0KSXQgaXMgZGVzY3JpYmVkIGluIGRldGFpbCBhcyBmb2xsb3dz77yaDQotLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpGaWVs
ZCAgICAgICAgICBEZXNjcmlwdGlvbg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KMzHigJM0ICAgICAgICAgVGhpcyBmaWVsZCBpcyByZXNl
cnZlZC4gIA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KMyAgICAgICAgICAgICAgQ29weSBPZiBUaW1lciBGbGFnIEZvciBDaGFubmVsIDMN
ClRGMyAgICAgICAgIDAgVGltZXIgRmxhZyBmb3IgQ2hhbm5lbCAzIGlzIGNsZWFyDQogICAgICAg
ICAgICAgICAgMSBUaW1lciBGbGFnIGZvciBDaGFubmVsIDMgaXMgc2V0DQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoyICAgICAgICAgICAg
IENvcHkgT2YgVGltZXIgRmxhZyBGb3IgQ2hhbm5lbCAyDQpURjIgICAgICAgICAwIFRpbWVyIEZs
YWcgZm9yIENoYW5uZWwgMiBpcyBjbGVhcg0KICAgICAgICAgICAgICAgIDEgVGltZXIgRmxhZyBm
b3IgQ2hhbm5lbCAyIGlzIHNldA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KMSAgICAgICAgICAgICAgQ29weSBPZiBUaW1lciBGbGFnIEZv
ciBDaGFubmVsIDENClRGMSAgICAgICAgIDAgVGltZXIgRmxhZyBmb3IgQ2hhbm5lbCAxIGlzIGNs
ZWFyDQogICAgICAgICAgICAgICAgMSBUaW1lciBGbGFnIGZvciBDaGFubmVsIDEgaXMgc2V0DQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQow
ICAgICAgICAgICAgICBDb3B5IE9mIFRpbWVyIEZsYWcgRm9yIENoYW5uZWwgMA0KVEYwICAgICAg
ICAgMCBUaW1lciBGbGFnIGZvciBDaGFubmVsIDAgaXMgY2xlYXINCiAgICAgICAgICAgICAgICAx
IFRpbWVyIEZsYWcgZm9yIENoYW5uZWwgMCBpcyBzZXQNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgICAgICAgIGJyZWFrOw0KPiAgICAg
Y2FzZSBFTkVUX1RDU1IwOg0KPiAgICAgY2FzZSBFTkVUX1RDU1IxOg0KPiAgICAgY2FzZSBFTkVU
X1RDU1IyOg0KPiAgICAgY2FzZSBFTkVUX1RDU1IzOg0KPi0gICAgICAgIHZhbHVlID0gdmFsdWUg
JiAweDAwMDAwMGZkOw0KPisgICAgICAgIHMtPnJlZ3NbaW5kZXhdID0gKHZhbHVlICYgMHgwMDAw
MDA4MCkgPyAoMHgwMDAwMDA3ZCAmIHZhbHVlKSA6DQo+KyAgICAgICAgICAgICAgICAgICAgICAg
ICAodmFsdWUgJiAweDAwMDAwMGZkKTsNCj4NClRoZSBFTkVUX1RDU1JuIGZpZWxkIGRlc2NyaXB0
aW9uczoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCkZpZWxkICAgICAgICAgIERlc2NyaXB0aW9uDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQozMeKAkzggICAgICBUaGlzIGZpZWxk
IGlzIHJlc2VydmVkLg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo3ICAgICAgICAgICAgICBUaW1lciBGbGFnDQpURiAgICAgICAgICAgIFNl
dHMgd2hlbiBpbnB1dCBjYXB0dXJlIG9yIG91dHB1dCBjb21wYXJlIG9jY3Vycy4gDQogICAgICAg
ICAgICAgICAgVGhpcyBmbGFnIGlzIGRvdWJsZSBidWZmZXJlZCBiZXR3ZWVuIHRoZSBtb2R1bGUg
Y2xvY2sgYW5kIDE1ODggY2xvY2sgZG9tYWlucy4gDQogICAgICAgICAgICAgICAgV2hlbiB0aGlz
IGZpZWxkIGlzIDEsIGl0IGNhbiBiZSBjbGVhcmVkIHRvIDAgYnkgd3JpdGluZyAxdG8gaXQuDQoN
CiAgICAgICAgICAgICAgICAgMCBJbnB1dCBDYXB0dXJlIG9yIE91dHB1dCBDb21wYXJlIGhhcyBu
b3Qgb2NjdXJyZWQNCiAgICAgICAgICAgICAgICAgMSBJbnB1dCBDYXB0dXJlIG9yIE91dHB1dCBD
b21wYXJlIGhhcyBvY2N1cnJlZA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCjYgICAgICAgICAgICAgIFRpbWVyIEludGVycnVwdCBFbmFi
bGUNClRJRSAgICAgICAgICAgMCBJbnRlcnJ1cHQgaXMgZGlzYWJsZWQNCiAgICAgICAgICAgICAg
ICAgMSBJbnRlcnJ1cHQgaXMgZW5hYmxlZA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCjItNSAgICAgICAgICAgVGltZXIgTW9kZQ0KICAg
ICAgICAgICAgICAgICAuLi4uLi4uLi4uLi4uLi4uLi4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoxICAgICAgICAgICAgICBUaGlzIGZp
ZWxkIGlzIHJlc2VydmVkLg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCjAgICAgICAgICAgICAgICAgVGltZXIgRE1BIFJlcXVlc3QgRW5h
YmxlICAgDQpURFJFICAgICAgICAwIERNQSByZXF1ZXN0IGlzIGRpc2FibGVkDQogICAgICAgICAg
ICAgICAgICAgMSBETUEgcmVxdWVzdCBpcyBlbmFibGVkDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQo+ICAgICAgICAgYnJlYWs7DQo+
ICAgICBjYXNlIEVORVRfVENDUjA6DQo+ICAgICBjYXNlIEVORVRfVENDUjE6DQo+LS0NCj4yLjIz
LjANCj4NCg0K

