Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F484C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167BE205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167BE205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42783 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHw3-00072y-6F
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBHuM-0003oV-RW
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBHuI-0001tx-Ey
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:53:19 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2077 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jBHuI-0001dr-1y; Mon, 09 Mar 2020 08:53:18 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 52B14C3EC12D070EDEAF;
 Mon,  9 Mar 2020 20:53:04 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 9 Mar 2020 20:53:04 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.115]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0439.000;
 Mon, 9 Mar 2020 20:52:54 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH v3 11/12] usb/hcd-ehci: Remove redundant statements
Thread-Topic: [PATCH v3 11/12] usb/hcd-ehci: Remove redundant statements
Thread-Index: AQHV8JOYVs182Y/nSkSavNbMm6f4Lag/uUIAgACHROA=
Date: Mon, 9 Mar 2020 12:52:53 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B67D5D6@dggemm511-mbx.china.huawei.com>
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
 <20200302130715.29440-13-kuhn.chenqun@huawei.com>
 <e786f342-7ba6-1c25-dea7-a34372a4ff81@vivier.eu>
In-Reply-To: <e786f342-7ba6-1c25-dea7-a34372a4ff81@vivier.eu>
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
X-Received-From: 45.249.212.189
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Euler
 Robot <euler.robot@huawei.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBMYXVyZW50IFZpdmllciBbbWFp
bHRvOmxhdXJlbnRAdml2aWVyLmV1XQ0KPlNlbnQ6IE1vbmRheSwgTWFyY2ggOSwgMjAyMCA4OjQz
IFBNDQo+VG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT47IHFlbXUt
DQo+ZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS10cml2aWFsQG5vbmdudS5vcmcNCj5DYzogcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnOyBaaGFuZ2hhaWxpYW5nDQo+PHpoYW5nLnpoYW5naGFpbGlhbmdA
aHVhd2VpLmNvbT47IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPjsNCj5FdWxlciBS
b2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT47IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQo+
PHBoaWxtZEByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTEvMTJdIHVzYi9o
Y2QtZWhjaTogUmVtb3ZlIHJlZHVuZGFudCBzdGF0ZW1lbnRzDQo+DQo+TGUgMDIvMDMvMjAyMCDD
oCAxNDowNywgQ2hlbiBRdW4gYSDDqWNyaXTCoDoNCj4+IFRoZSAiYWdhaW4iIGFzc2lnbm1lbnQg
aXMgbWVhbmluZ2xlc3MgYmVmb3JlIGdfYXNzZXJ0X25vdF9yZWFjaGVkLg0KPj4gSW4gYWRkaXRp
b24sIHRoZSBicmVhayBzdGF0ZW1lbnRzIG5vIGxvbmdlciBuZWVkcyB0byBiZSBhZnRlcg0KPj4g
Z19hc3NlcnRfbm90X3JlYWNoZWQuDQo+Pg0KPj4gQ2xhbmcgc3RhdGljIGNvZGUgYW5hbHl6ZXIg
c2hvdyB3YXJuaW5nOg0KPj4gaHcvdXNiL2hjZC1laGNpLmM6MjEwODoxMzogd2FybmluZzogVmFs
dWUgc3RvcmVkIHRvICdhZ2FpbicgaXMgbmV2ZXIgcmVhZA0KPj4gICAgICAgICAgICAgYWdhaW4g
PSAtMTsNCj4+ICAgICAgICAgICAgIF4gICAgICAgfn4NCj4+DQo+PiBSZXBvcnRlZC1ieTogRXVs
ZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGVu
IFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+PiBSZXZpZXdlZC1ieTogUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPj4gLS0tDQo+PiBDYzogR2VyZCBI
b2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+DQo+PiBDYzogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPj4gLS0tDQo+PiAgaHcvdXNiL2hjZC1laGNpLmMgfCAz
IC0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9ody91c2IvaGNkLWVoY2kuYyBiL2h3L3VzYi9oY2QtZWhjaS5jIGluZGV4DQo+PiA1NmFi
MmY0NTdmLi4yOWQ0OWMyZDdlIDEwMDY0NA0KPj4gLS0tIGEvaHcvdXNiL2hjZC1laGNpLmMNCj4+
ICsrKyBiL2h3L3VzYi9oY2QtZWhjaS5jDQo+PiBAQCAtMTMwMSw3ICsxMzAxLDYgQEAgc3RhdGlj
IHZvaWQgZWhjaV9leGVjdXRlX2NvbXBsZXRlKEVIQ0lRdWV1ZSAqcSkNCj4+ICAgICAgICAgIC8q
IHNob3VsZCBub3QgYmUgdHJpZ2dlcmFibGUgKi8NCj4+ICAgICAgICAgIGZwcmludGYoc3RkZXJy
LCAiVVNCIGludmFsaWQgcmVzcG9uc2UgJWRcbiIsIHAtPnBhY2tldC5zdGF0dXMpOw0KPj4gICAg
ICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4+IC0gICAgICAgIGJyZWFrOw0KPj4gICAg
ICB9DQo+Pg0KPj4gICAgICAvKiBUT0RPIGNoZWNrIDQuMTIgZm9yIHNwbGl0cyAqLw0KPj4gQEAg
LTIxMDUsOSArMjEwNCw3IEBAIHN0YXRpYyB2b2lkIGVoY2lfYWR2YW5jZV9zdGF0ZShFSENJU3Rh
dGUgKmVoY2ksDQo+PiBpbnQgYXN5bmMpDQo+Pg0KPj4gICAgICAgICAgZGVmYXVsdDoNCj4+ICAg
ICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIkJhZCBzdGF0ZSFcbiIpOw0KPj4gLSAgICAgICAg
ICAgIGFnYWluID0gLTE7DQo+PiAgICAgICAgICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsN
Cj4+IC0gICAgICAgICAgICBicmVhazsNCj4+ICAgICAgICAgIH0NCj4+DQo+PiAgICAgICAgICBp
ZiAoYWdhaW4gPCAwIHx8IGl0ZF9jb3VudCA+IDE2KSB7DQo+Pg0KPg0KPkFwcGxpZWQgdG8gbXkg
dHJpdmlhbC1wYXRjaGVzIGJyYW5jaC4NCj4NCkhpLCBMYXVyZW50DQoNCkdlcmQgaGFzIGFkZGVk
IGEgcGF0Y2ggdG8gdGhlIFVTQiBxdWV1ZSB0b2RheS4NCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wYXRjaC8xMTQwNTYxNS8NCg0KPlRoYW5rcywNCj5MYXVyZW50DQoNCg==

