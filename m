Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C70C2BB1D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 03:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9762074E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 03:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9762074E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCxHl-0001pl-Mq
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 23:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jCxH5-0001Mg-56
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 23:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jCxH3-00048m-UB
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 23:15:42 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:43652 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jCxH3-0003Xl-J0; Fri, 13 Mar 2020 23:15:41 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 2CCC092F9FF0D7CA7710;
 Sat, 14 Mar 2020 11:15:29 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.221]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0439.000;
 Sat, 14 Mar 2020 11:15:19 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH v4] hw/net/imx_fec: write TGSR and TCSR3 in
 imx_enet_write()
Thread-Topic: [PATCH v4] hw/net/imx_fec: write TGSR and TCSR3 in
 imx_enet_write()
Thread-Index: AQHV+TONXyYnlfPgi0u4ROr0/Jb8xahGDvKAgAFZnlA=
Date: Sat, 14 Mar 2020 03:15:18 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B694CD0@dggemm531-mbx.china.huawei.com>
References: <20200313123242.13236-1-kuhn.chenqun@huawei.com>
 <CAFEAcA9kM_=52JT=XyhjDLA3CUSpeKwCB2nhLRrjY+MaBLw1yg@mail.gmail.com>
In-Reply-To: <CAFEAcA9kM_=52JT=XyhjDLA3CUSpeKwCB2nhLRrjY+MaBLw1yg@mail.gmail.com>
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGV0ZXIgTWF5ZGVsbCBbbWFpbHRv
OnBldGVyLm1heWRlbGxAbGluYXJvLm9yZ10NCj5TZW50OiBGcmlkYXksIE1hcmNoIDEzLCAyMDIw
IDEwOjI5IFBNDQo+VG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4N
Cj5DYzogUUVNVSBEZXZlbG9wZXJzIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBRRU1VIFRyaXZp
YWwgPHFlbXUtDQo+dHJpdmlhbEBub25nbnUub3JnPjsgWmhhbmdoYWlsaWFuZyA8emhhbmcuemhh
bmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsNCj5FdWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2Vp
LmNvbT47IEphc29uIFdhbmcNCj48amFzb3dhbmdAcmVkaGF0LmNvbT47IFBldGVyIENodWJiIDxw
ZXRlci5jaHViYkBuaWN0YS5jb20uYXU+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NF0gaHcvbmV0
L2lteF9mZWM6IHdyaXRlIFRHU1IgYW5kIFRDU1IzIGluDQo+aW14X2VuZXRfd3JpdGUoKQ0KPg0K
Pk9uIEZyaSwgMTMgTWFyIDIwMjAgYXQgMTI6MzMsIENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVh
d2VpLmNvbT4gd3JvdGU6DQo+Pg0KPj4gVGhlIGN1cnJlbnQgY29kZSBjYXVzZXMgY2xhbmcgc3Rh
dGljIGNvZGUgYW5hbHl6ZXIgZ2VuZXJhdGUgd2FybmluZzoNCj4+IGh3L25ldC9pbXhfZmVjLmM6
ODU4Ojk6IHdhcm5pbmc6IFZhbHVlIHN0b3JlZCB0byAndmFsdWUnIGlzIG5ldmVyIHJlYWQNCj4+
ICAgICAgICAgdmFsdWUgPSB2YWx1ZSAmIDB4MDAwMDAwMGY7DQo+PiAgICAgICAgIF4gICAgICAg
fn5+fn5+fn5+fn5+fn5+fn5+DQo+PiBody9uZXQvaW14X2ZlYy5jOjg2NDo5OiB3YXJuaW5nOiBW
YWx1ZSBzdG9yZWQgdG8gJ3ZhbHVlJyBpcyBuZXZlciByZWFkDQo+PiAgICAgICAgIHZhbHVlID0g
dmFsdWUgJiAweDAwMDAwMGZkOw0KPj4gICAgICAgICBeICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+
fg0KPj4NCj4+IEFjY29yZGluZyB0byB0aGUgZGVmaW5pdGlvbiBvZiB0aGUgZnVuY3Rpb24sIHRo
ZSB0d28g4oCcdmFsdWXigJ0NCj4+IGFzc2lnbm1lbnRzICBzaG91bGQgYmUgd3JpdHRlbiB0byBy
ZWdpc3RlcnMuDQo+Pg0KPj4gUmVwb3J0ZWQtYnk6IEV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBo
dWF3ZWkuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hlbiBRdW4gPGt1aG4uY2hlbnF1bkBodWF3
ZWkuY29tPg0KPg0KPg0KPkFwcGxpZWQgdG8gdGFyZ2V0LWFybS5uZXh0OyB0aGFua3MgZm9yIHdv
cmtpbmcgdGhyb3VnaCB0aGUgY29kZSByZXZpZXcNCj5wcm9jZXNzLg0KPg0KDQpUaGFuayB5b3Ug
Zm9yIHlvdXIgZGV0YWlsZWQgcmV2aWV3IGFuZCBlZmZlY3RpdmUgc3VnZ2VzdGlvbnMsIHRvby4N
Cg0K

