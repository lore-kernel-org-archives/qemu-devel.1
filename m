Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3497C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 03:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D3020739
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 03:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D3020739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkfSN-0007zY-S0
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 23:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jkfRn-0007ZH-O1
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 23:06:07 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:51706 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jkfRk-0002um-9T
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 23:06:07 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 6228DDE2D727F828EF69;
 Mon, 15 Jun 2020 11:05:57 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 15 Jun 2020 11:05:57 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 15 Jun 2020 11:05:57 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Mon, 15 Jun 2020 11:05:56 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Like Xu <like.xu@linux.intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/2] migration/colo: fix typo in the COLO Framework module
Thread-Topic: [PATCH 1/2] migration/colo: fix typo in the COLO Framework module
Thread-Index: AQHWQihESQ1QHSyBjUOMZYAPEejPW6jY5YMw//+IFwCAAI/TwA==
Date: Mon, 15 Jun 2020 03:05:56 +0000
Message-ID: <39e096702ae54e109ae7599525161739@huawei.com>
References: <20200614084510.7917-1-like.xu@linux.intel.com>
 <17a0016f32fb471fa57e4f0c21ecb19d@huawei.com>
 <0d30a6ce-6641-dc82-10e5-cd748dbf104a@linux.intel.com>
In-Reply-To: <0d30a6ce-6641-dc82-10e5-cd748dbf104a@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 23:05:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpJIGhhdmUgY2hlY2tlZCB0aGlzIHBhdGNoIGluIG1haWwgYXJjaGl2ZSwgaXQgaGFzIG5vIHBy
b2JsZW0sDQpJdCBzZWVtcyB0aGF0IG15IGVtYWlsIHNldHVwIGhhcyBzb21lIHByb2JsZW0uIEl0
IGRpZG4ndCBzaG93IHRoZSByaWdodCBuZXdsaW5lDQpJbiB0aGlzIHBhdGNoLg0KDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGlrZSBYdSBbbWFpbHRvOmxpa2UueHVA
bGludXguaW50ZWwuY29tXQ0KPiBTZW50OiBNb25kYXksIEp1bmUgMTUsIDIwMjAgMTA6MjQgQU0N
Cj4gVG86IFpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47DQo+
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gbWlncmF0
aW9uL2NvbG86IGZpeCB0eXBvIGluIHRoZSBDT0xPIEZyYW1ld29yaw0KPiBtb2R1bGUNCj4gDQo+
IE9uIDIwMjAvNi8xNSA5OjM2LCBaaGFuZ2hhaWxpYW5nIHdyb3RlOg0KPiA+IEhpIExpa2UsDQo+
ID4NCj4gPiBQbGVhc2UgY2hlY2sgdGhpcyBwYXRjaCwgSXQgc2VlbXMgdGhhdCB5b3UgZGlkbid0
IHVzZSBnaXQgZm9ybWF0LXBhdGNoDQo+ID4gY29tbWFuZCB0byBnZW5lcmF0ZSB0aGlzIHBhdGNo
LCBJdCBpcyBpbiB3cm9uZyBmb3JtYXQuDQo+IA0KPiBJIHJlYmFzZSB0aGUgcGF0Y2ggb24gdGhl
IHRvcCBjb21taXQgb2YNCj4gN2QzNjYwZTc5ODMwYTA2OWYxODQ4YmI0ZmExY2RmOGY2NjY0MjRm
YiwNCj4gYW5kIGhvcGUgaXQgaGVscHMgeW91Lg0KPiANCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBI
YWlsaWFuZw0KPiANCj4gIEZyb20gMTVjMTliZTliZTA3NTk4ZDQyNjRhNGE4NGI4NWQ0ZWZhNzli
ZmY5ZCBNb24gU2VwIDE3DQo+IDAwOjAwOjAwIDIwMDENCj4gRnJvbTogTGlrZSBYdSA8bGlrZS54
dUBsaW51eC5pbnRlbC5jb20+DQo+IERhdGU6IE1vbiwgMTUgSnVuIDIwMjAgMTA6MTA6NTcgKzA4
MDANCj4gU3ViamVjdDogW1BBVENIIDEvMl0gbWlncmF0aW9uL2NvbG86IGZpeCB0eXBvIGluIHRo
ZSBDT0xPIEZyYW1ld29yaw0KPiBtb2R1bGUNCj4gDQo+IENjOiBIYWlsaWFuZyBaaGFuZyA8emhh
bmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaWtlIFh1IDxs
aWtlLnh1QGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICAgZG9jcy9DT0xPLUZULnR4dCB8IDgg
KysrKy0tLS0NCj4gICBtaWdyYXRpb24vY29sby5jIHwgMiArLQ0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Rv
Y3MvQ09MTy1GVC50eHQgYi9kb2NzL0NPTE8tRlQudHh0IGluZGV4DQo+IGM4ZTE3NDA5MzUuLmZk
YzAyMDdjZmYgMTAwNjQ0DQo+IC0tLSBhL2RvY3MvQ09MTy1GVC50eHQNCj4gKysrIGIvZG9jcy9D
T0xPLUZULnR4dA0KPiBAQCAtMTAsNyArMTAsNyBAQCBTZWUgdGhlIENPUFlJTkcgZmlsZSBpbiB0
aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4NCj4gICBUaGlzIGRvY3VtZW50IGdpdmVzIGFuIG92ZXJ2
aWV3IG9mIENPTE8ncyBkZXNpZ24gYW5kIGhvdyB0byB1c2UgaXQuDQo+IA0KPiAgID09IEJhY2tn
cm91bmQgPT0NCj4gLVZpcnR1YWwgbWFjaGluZSAoVk0pIHJlcGxpY2F0aW9uIGlzIGEgd2VsbCBr
bm93biB0ZWNobmlxdWUgZm9yIHByb3ZpZGluZw0KPiArVmlydHVhbCBtYWNoaW5lIChWTSkgcmVw
bGljYXRpb24gaXMgYSB3ZWxsLWtub3duIHRlY2huaXF1ZSBmb3INCj4gK3Byb3ZpZGluZw0KPiAg
IGFwcGxpY2F0aW9uLWFnbm9zdGljIHNvZnR3YXJlLWltcGxlbWVudGVkIGhhcmR3YXJlIGZhdWx0
IHRvbGVyYW5jZSwNCj4gICBhbHNvIGtub3duIGFzICJub24tc3RvcCBzZXJ2aWNlIi4NCj4gDQo+
IEBAIC0xMDMsNyArMTAzLDcgQEAgUHJpbWFyeSBzaWRlLg0KPiANCj4gICBDT0xPIFByb3h5Og0K
PiAgIERlbGl2ZXJzIHBhY2tldHMgdG8gUHJpbWFyeSBhbmQgU2Vjb25kYXJ5LCBhbmQgdGhlbiBj
b21wYXJlIHRoZQ0KPiByZXNwb25zZXMgZnJvbSAtYm90aCBzaWRlLiBUaGVuIGRlY2lkZSB3aGV0
aGVyIHRvIHN0YXJ0IGEgY2hlY2twb2ludA0KPiBhY2NvcmRpbmcgdG8gc29tZSBydWxlcy4NCj4g
K2JvdGggc2lkZXMuIFRoZW4gZGVjaWRlIHdoZXRoZXIgdG8gc3RhcnQgYSBjaGVja3BvaW50IGFj
Y29yZGluZyB0byBzb21lDQo+IHJ1bGVzLg0KPiAgIFBsZWFzZSByZWZlciB0byBkb2NzL2NvbG8t
cHJveHkudHh0IGZvciBtb3JlIGluZm9ybWF0aW9uLg0KPiANCj4gICBOb3RlOg0KPiBAQCAtMTQ2
LDEyICsxNDYsMTIgQEAgaW4gdGVzdCBwcm9jZWR1cmUuDQo+IA0KPiAgID09IFRlc3QgcHJvY2Vk
dXJlID09DQo+ICAgTm90ZTogSGVyZSB3ZSBhcmUgcnVubmluZyBib3RoIGluc3RhbmNlcyBvbiB0
aGUgc2FtZSBob3N0IGZvciB0ZXN0aW5nLA0KPiAtY2hhbmdlIHRoZSBJUCBBZGRyZXNzZXMgaWYg
eW91IHdhbnQgdG8gcnVuIGl0IG9uIHR3byBob3N0cy4gSW5pdGFsbHkNCj4gK2NoYW5nZSB0aGUg
SVAgQWRkcmVzc2VzIGlmIHlvdSB3YW50IHRvIHJ1biBpdCBvbiB0d28gaG9zdHMuIEluaXRpYWxs
eQ0KPiAgIDEyNy4wLjAuMSBpcyB0aGUgUHJpbWFyeSBIb3N0IGFuZCAxMjcuMC4wLjIgaXMgdGhl
IFNlY29uZGFyeSBIb3N0Lg0KPiANCj4gICA9PSBTdGFydHVwIHFlbXUgPT0NCj4gICAxLiBQcmlt
YXJ5Og0KPiAtTm90ZTogSW5pdGFsbHksICRpbWFnZWZvbGRlci9wcmltYXJ5LnFjb3cyIG5lZWRz
IHRvIGJlIGNvcGllZCB0byBhbGwgaG9zdHMuDQo+ICtOb3RlOiBJbml0aWFsbHksICRpbWFnZWZv
bGRlci9wcmltYXJ5LnFjb3cyIG5lZWRzIHRvIGJlIGNvcGllZCB0byBhbGwgaG9zdHMuDQo+ICAg
WW91IGRvbid0IG5lZWQgdG8gY2hhbmdlIGFueSBJUCdzIGhlcmUsIGJlY2F1c2UgMC4wLjAuMCBs
aXN0ZW5zIG9uIGFueQ0KPiAgIGludGVyZmFjZS4gVGhlIGNoYXJkZXYncyB3aXRoIDEyNy4wLjAu
MSBJUCdzIGxvb3BiYWNrIHRvIHRoZSBsb2NhbCBxZW11DQo+ICAgaW5zdGFuY2UuDQo+IGRpZmYg
LS1naXQgYS9taWdyYXRpb24vY29sby5jIGIvbWlncmF0aW9uL2NvbG8uYyBpbmRleA0KPiBlYTdk
MWU5ZDRlLi44MDc4OGQ0NmI1IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vY29sby5jDQo+ICsr
KyBiL21pZ3JhdGlvbi9jb2xvLmMNCj4gQEAgLTYzMiw3ICs2MzIsNyBAQCBvdXQ6DQo+ICAgICAg
IC8qDQo+ICAgICAgICAqIEl0IGlzIHNhZmUgdG8gdW5yZWdpc3RlciBub3RpZmllciBhZnRlciBm
YWlsb3ZlciBmaW5pc2hlZC4NCj4gICAgICAgICogQmVzaWRlcywgY29sb19kZWxheV90aW1lciBh
bmQgY29sb19jaGVja3BvaW50X3NlbSBjYW4ndCBiZQ0KPiAtICAgICAqIHJlbGVhc2VkIGJlZm9y
IHVucmVnaXN0ZXIgbm90aWZpZXIsIG9yIHRoZXJlIHdpbGwgYmUgdXNlLWFmdGVyLWZyZWUNCj4g
KyAgICAgKiByZWxlYXNlZCBiZWZvcmUgdW5yZWdpc3RlciBub3RpZmllciwgb3IgdGhlcmUgd2ls
bCBiZQ0KPiArIHVzZS1hZnRlci1mcmVlDQo+ICAgICAgICAqIGVycm9yLg0KPiAgICAgICAgKi8N
Cj4gICAgICAgY29sb19jb21wYXJlX3VucmVnaXN0ZXJfbm90aWZpZXIoJnBhY2tldHNfY29tcGFy
ZV9ub3RpZmllcik7DQo+IC0tDQo+IDIuMjEuMw0KPiANCg0K

