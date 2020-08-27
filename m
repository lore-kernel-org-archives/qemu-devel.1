Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96909C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6256922BEA
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 07:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6256922BEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBCL8-0003Am-Mh
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 03:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kBBuL-00035O-CH; Thu, 27 Aug 2020 03:01:13 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:47832 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kBBuH-0002m2-Oq; Thu, 27 Aug 2020 03:01:13 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 6506E1FDF67428F7D126;
 Thu, 27 Aug 2020 15:00:56 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 27 Aug 2020 15:00:56 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.141]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0487.000;
 Thu, 27 Aug 2020 15:00:47 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH v2 09/10] hw/intc: Remove redundant statement in
 exynos4210_combiner_read()
Thread-Topic: [PATCH v2 09/10] hw/intc: Remove redundant statement in
 exynos4210_combiner_read()
Thread-Index: AQHWetKNgmqjr7ls9UKOtUz3l3Xb5qlIPmkAgAM/MOA=
Date: Thu, 27 Aug 2020 07:00:46 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B8E58BD@dggemm511-mbx.china.huawei.com>
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-10-kuhn.chenqun@huawei.com>
 <CAFEAcA_SLjM28bHH8WxBdHAFdLgE6zgqNAj9EpOVp77WL-iqKg@mail.gmail.com>
In-Reply-To: <CAFEAcA_SLjM28bHH8WxBdHAFdLgE6zgqNAj9EpOVp77WL-iqKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.187.50]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 03:00:57
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Pannengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA5LzEwXSBody9pbnRjOiBSZW1vdmUgcmVkdW5kYW50
IHN0YXRlbWVudCBpbg0KPiBleHlub3M0MjEwX2NvbWJpbmVyX3JlYWQoKQ0KPiANCj4gT24gVHVl
LCAyNSBBdWcgMjAyMCBhdCAxMjoyNiwgQ2hlbiBRdW4gPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29t
PiB3cm90ZToNCj4gPg0KPiA+IENsYW5nIHN0YXRpYyBjb2RlIGFuYWx5emVyIHNob3cgd2Fybmlu
ZzoNCj4gPiBody9pbnRjL2V4eW5vczQyMTBfY29tYmluZXIuYzoyMzE6OTogd2FybmluZzogVmFs
dWUgc3RvcmVkIHRvICd2YWwnIGlzIG5ldmVyDQo+IHJlYWQNCj4gPiAgICAgICAgIHZhbCA9IHMt
PnJlZ19zZXRbb2Zmc2V0ID4+IDJdOw0KPiA+DQo+ID4gVGhlIGRlZmF1bHQgdmFsdWUgb2YgJ3Zh
bCcgaXMgJzAnLCBzbyB3ZSBjYW4gYnJlYWsgdGhlICdkZWZhdWx0JyBicmFuY2ggYW5kIHJldHVy
bg0KPiAndmFsJy4NCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBFdWxlciBSb2JvdCA8ZXVsZXIucm9i
b3RAaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8a3Vobi5jaGVucXVu
QGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gQ2M6IElnb3IgTWl0c3lhbmtvIDxpLm1pdHN5YW5r
b0BnbWFpbC5jb20+DQo+ID4gQ2M6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz4NCj4gPiAtLS0NCj4gPiAgaHcvaW50Yy9leHlub3M0MjEwX2NvbWJpbmVyLmMgfCAzICst
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaW50Yy9leHlub3M0MjEwX2NvbWJpbmVyLmMNCj4gPiBi
L2h3L2ludGMvZXh5bm9zNDIxMF9jb21iaW5lci5jIGluZGV4IGI4NTYxZTQxODAuLmUyZTc0NWJi
YWEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvaW50Yy9leHlub3M0MjEwX2NvbWJpbmVyLmMNCj4gPiAr
KysgYi9ody9pbnRjL2V4eW5vczQyMTBfY29tYmluZXIuYw0KPiA+IEBAIC0yMjgsOCArMjI4LDcg
QEAgZXh5bm9zNDIxMF9jb21iaW5lcl9yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyDQo+IG9mZnNl
dCwgdW5zaWduZWQgc2l6ZSkNCj4gPiAgICAgICAgICAgICAgaHdfZXJyb3IoImV4eW5vczQyMTAu
Y29tYmluZXI6IG92ZXJmbG93IG9mIHJlZ19zZXQgYnkgMHgiDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgVEFSR0VUX0ZNVF9wbHggIm9mZnNldFxuIiwgb2Zmc2V0KTsNCj4gPiAgICAgICAgICB9
DQo+ID4gLSAgICAgICAgdmFsID0gcy0+cmVnX3NldFtvZmZzZXQgPj4gMl07DQo+ID4gLSAgICAg
ICAgcmV0dXJuIDA7DQo+ID4gKyAgICAgICAgYnJlYWs7DQo+ID4gICAgICB9DQo+ID4gICAgICBy
ZXR1cm4gdmFsOw0KPiA+ICB9DQo+IA0KPiBUaGUgY29kZSBhcyBpdCBzdGFuZHMgaXMgZGVmaW5p
dGVseSB3cm9uZywgYnV0IEknbSBub3Qgc3VyZSB0aGlzIGlzIHRoZSBjb3JyZWN0IGZpeC4NCj4g
U3VyZWx5IHRoZSBpbnRlbnRpb24gbXVzdCBoYXZlIGJlZW4gdG8gcmV0dXJuIHRoZSBhY3R1YWwg
cmVnaXN0ZXIgdmFsdWUgZnJvbQ0KPiB0aGUgcmVnX3NldFtdIGFycmF5LCBub3QgdG8gcmV0dXJu
IDAgPw0KPiANCj4gSSBzdXNwZWN0IHRoZSBjb3JyZWN0IGZpeCBoZXJlIGlzIHNpbXBseSB0byBk
ZWxldGUgdGhlICJyZXR1cm4gMCIgbGluZSBhbmQgbGVhdmUNCj4gdGhlIGFzc2lnbm1lbnQgdG8g
dmFsIGFzIGl0IGlzLg0KDQpIaSBQZXRlciwNCiAgSSB0aGluayB5b3UncmUgcmlnaHQuDQoNCj4g
SWRlYWxseSB5b3Ugc2hvdWxkIGNoZWNrIHRoZSBoL3cgZGF0YXNoZWV0IHRvIGNvbmZpcm0uDQog
SSBjaGVja2VkIHRoZSBFeHlub3MgNDIxMCBkYXRhc2hlZXQgYW5kIGZvdW5kIHRoYXQgJ0ludGVy
cnVwdCBDb21iaW5lciBPcGVyYXRpb24nIGhhZCBvbmx5IGZpdmUgdHlwZXMgb2YgcmVnaXN0ZXJz
Lg0KDQpSZWdpc3RlciAgICAgICAgICAgICBEZXNjcmlwdGlvbiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBUeXBlDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpJ
RVNSKDAvMS8yLzMpICAgSW50ZXJydXB0IEVuYWJsZSBTZXQgUmVnaXN0ZXIgZm9yIEdyb3VwICgw
fjMvIDQgfjcvIDh+IDExLyAxMn4gMTUpICAgICAgICAgUlcNCklFQ1IoMC8xLzIvMykgICBJbnRl
cnJ1cHQgRW5hYmxlIENsZWFyIFJlZ2lzdGVyIGZvciBHcm91cCAoMH4zLyA0IH43LyA4fiAxMS8g
MTJ+IDE1KSAgICAgICBSVw0KSVNUUigwLzEvMi8zKSAgIEludGVycnVwdCBTdGF0dXMgUmVnaXN0
ZXIgZm9yIEdyb3VwICgwfjMvIDQgfjcvIDh+IDExLyAxMn4gMTUpICAgICAgICAgICAgIFINCklN
U1IoMC8xLzIvMykgIEludGVycnVwdCBNYXNrZWQgU3RhdHVzIFJlZ2lzdGVyIGZvciBHcm91cCgw
fjMvIDQgfjcvIDh+IDExLyAxMn4gMTUpICAgICAgIFINCkNJUFNSMCAgICAgICAgQ29tYmluZWQg
SW50ZXJydXB0IFBlbmRpbmcgU3RhdHVzMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBSDQoNClRoZSBleHlub3M0MjEwX2NvbWJpbmVyX3dyaXRlKCkgZnVuY3Rpb24gaGFzIHdyaXRl
IG9wZXJhdGlvbnMgZm9yIElFU1IgYW5kIElFQ1IuDQpUaGUgQ0lQU1IsIElTVFIsIGFuZCBJTVNS
IHJlYWQgb3BlcmF0aW9ucyBhcmUgc3BlY2lmaWVkIGluIHRoZSBleHlub3M0MjEwX2NvbWJpbmVy
X3JlYWQoKSBmdW5jdGlvbi4NCg0KU28sIFRoaXMgJ2RlZmF1bHQnIGJyYW5jaCBpbiBleHlub3M0
MjEwX2NvbWJpbmVyX3JlYWQoKSBmdW5jdGlvbiByZWFkIG9wZXJhdGlvbiBpcyBvbmx5IGZvciBJ
RVNSIGFuZCBJRUNSLg0KDQpBbmQsIGluIHRoZSBleHlub3M0MjEwX2NvbWJpbmVyX3dyaXRlIGZ1
bmN0aW9uLCB0aGUgZGVmYXVsdCBhc3NpZ25tZW50IHN0YXRlbWVudCBmb3IgSUVTUiBhbmQgSUVD
UiBpcyAiIHMtPnJlZ19zZXRbb2Zmc2V0ID4+IDJdID0gdmFsOyIuDQpUaGVyZWZvcmUsIGlmIHdl
IHJlYWQgdGhlIHR3byByZWdpc3RlcihJRVNSIGFuZCBJRUNSKSB2YWx1ZXMsIHdlIGNhbiBkaXJl
Y3RseSB1c2UgdGhpcyBhc3NpZ25tZW50IHN0YXRlbWVudCAidmFsID0gcy0+cmVnX3NldFtvZmZz
ZXQgPj4gMl07Ii4NCg0KUGxlYXNlIGNvbmZpcm0gdGhhdCBpZiB0aGVyZSBpcyBubyBwcm9ibGVt
LCBJIHdpbGwgbW9kaWZ5IGl0IGluIGxhdGVyIHZlcnNpb24uDQoNClRoYW5rcywNCkNoZW4gUXVu
DQoNCg0KDQoNCg==

