Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6751DC10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 02:40:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BE9218D3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 02:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BE9218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34627 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ7pn-0004xo-C6
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 22:40:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <oscar.zhangbo@huawei.com>) id 1hJ7nM-0003WE-Hq
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <oscar.zhangbo@huawei.com>) id 1hJ7nL-0002ih-IH
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:38:00 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2493 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <oscar.zhangbo@huawei.com>)
	id 1hJ7nD-0002Oy-T0; Tue, 23 Apr 2019 22:37:52 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.57])
	by Forcepoint Email with ESMTP id B814F47A8198B879D3A3;
	Wed, 24 Apr 2019 10:37:42 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
	DGGEML401-HUB.china.huawei.com (10.3.17.32) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Wed, 24 Apr 2019 10:37:42 +0800
Received: from DGGEML529-MBS.china.huawei.com ([169.254.5.207]) by
	dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id
	14.03.0439.000; Wed, 24 Apr 2019 10:37:36 +0800
From: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, "wangjie (P)"
	<wangjie88@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: =?utf-8?B?W1FlbXUtYmxvY2tdIHF1ZXN0aW9u77yaIERvZXMgcWVtdS1wci1oZWxwZXIg?=
	=?utf-8?B?aGF2ZSBpdHMgb3duIGxvZyBmaWxlc++8nw==?=
Thread-Index: AQHU+YJvbuIuosAbgE6Pz+QfP7tbKaZJP5iAgAFVrQA=
Date: Wed, 24 Apr 2019 02:37:36 +0000
Message-ID:
 <0259E1C966E8C54AA93AA2B1240828E65D0BE6FB@DGGEML529-MBS.china.huawei.com>
References: <c47aea74-cec7-0369-591e-e1b1fdddc3e6@huawei.com>
	<20190423135635.GL32465@stefanha-x1.localdomain>
In-Reply-To: <20190423135635.GL32465@stefanha-x1.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.17.158]
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.188
Subject: Re: [Qemu-devel] 
 =?utf-8?q?=5BQemu-block=5D_question=EF=BC=9A_Does_q?=
 =?utf-8?q?emu-pr-helper_have_its_own_log_files=EF=BC=9F?=
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Wangjing \(King\)" <king.wang@huawei.com>,
	"Fangyi \(C\)" <eric.fangyi@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424023736.iAvOGS-RiZ4jVGVqYnmVb0dj7N5HE3kCGVQGKt9ot5o@z>

PkZyb206IFN0ZWZhbiBIYWpub2N6aSBbbWFpbHRvOnN0ZWZhbmhhQGdtYWlsLmNvbV0NCj5TZW50
OiBUdWVzZGF5LCBBcHJpbCAyMywgMjAxOSA5OjU3IFBNDQo+T24gVHVlLCBBcHIgMjMsIDIwMTkg
YXQgMTE6MTI6NDBBTSArMDgwMCwgSmllIFdhbmcgd3JvdGU6DQo+PiDCoERvZXMgcWVtdS1wci1o
ZWxwZXIgaGF2ZSBpdHMgb3duIGxvZyBmaWxlc++8nw0KPg0KPk5vLCBpdCBkb2VzIG5vdC4gIHFl
bXUtcHItaGVscGVyIHVzZXMgc3RkZXJyIGZvciBlcnJvcnMgYW5kIHRoZXJlIGlzIG5vdA0KPm11
Y2ggb3V0cHV0IGR1cmluZyBub3JtYWwgb3BlcmF0aW9uLg0KPg0KPkNoZWNrIGpvdXJuYWxjdGwo
MSkgZm9yIGVycm9ycyBpZiB5b3UgYXJlIGxhdW5jaGluZyBpdCBhcyBhIHN5c3RlbWQNCj5zZXJ2
aWNlLg0KPg0KPlN0ZWZhbg0KDQpUaGUgZXJyb3IgbWVzc2FnZXMgdGhhdCBzZW50IHRvICpzdGRl
cnIqIGFyZSAqbm90KiBjYXB0dXJlZCBieSBhbnlvbmUsIHRoZW4NCnRoZXNlIGVycm9yIG1lc3Nh
Z2VzIHNlZW1zIGhlbHBsZXNzLg0KSXQncyBkaWZmZXJlbnQgZm9ybSBxZW11J3MgbG9nLCAgcWVt
dSdzIHN0ZGVyciBsb2dzIGFyZSB0cmFuc2ZlcnJlZCB0byB2aXJ0bG9nZCwNCnRoYXQgbWVhbnMg
dGhlc2UgbG9ncyBhcmUgZmluYWxseSB3cml0dGVuIGludG8gZGlzay4NCkFueSBmdXJ0aGVyIGRl
dmVsb3BtZW50IHBsYW4/DQoNCldlIHRob3VnaHQgb2Y6DQoxIGxvZ2dpbmcgaW50byBzeXNsb2cs
IGJ1dCB0aGUgbWFsaWNpb3VzIGd1ZXN0IG1heSBjYXVzZSBsYXJnZSBhbW91bnQgb2YgZXJyb3IN
CiAgbWVzc2FnZXMgdG8gb3ZlcmZsb3cgdGhlIG1lc3NhZ2UgbG9nLg0KMiBvciwgbGV0IHZpcnRs
b2dkIHRvIHJlZGlyZWN0IGl0cyBsb2dzLiBCdXQgaWYgdmlydGxvZ2QgZ2V0IHJlc3RhcnRlZCwg
dGhlIGhlbHBlcidzIGxvZyB3b3VsZA0KICBubyBsb25nZXIgYmUgbG9nZ2VkLCBiZWNhdXNlLCB1
bmxpa2UgcWVtdSwgdGhlcmUncyBubyBxbXAgc29ja2V0IGJldHdlZW4gDQogIGxpYnZpcnRkIGFu
ZCB0aGUgaGVscGVyLCB0aGUgY2hhbm5lbCBiZXR3ZWVuIHRoZSBoZWxwZXIgYW5kIHZpcnRsb2dk
IGNvdWxkIG5vdCBiZQ0KICByZS1lc3RhYmxpc2hlZC4NCjMgb3IsIGxldCBxZW11IHRvIGxvZyB0
aGUgaGVscGVyJ3MgbG9nLCBzZWVtcyBhIGxpdHRsZSBvZGQgYW5kIGNvbXBsZXguDQo0IG9yLCBs
ZXQgdGhlIGhlbHBlciByZWFsaXplIGl0cyBvd24gbG9nZ2luZyBzY2hlbWUgYW5kIGxvZyBpbnRv
IGl0c2VsZidzIGxvZ2ZpbGUgPw0KDQpXaGF0J3MgeW91ciBzdWdnZXN0aW9uPyBUaGFua3MhDQo=

