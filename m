Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D950FC388F9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 05:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2F721D7F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 05:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2F721D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaY2L-0004mE-V2
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 00:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tu.guoyi@h3c.com>)
 id 1kaY1N-00040W-R7; Thu, 05 Nov 2020 00:41:17 -0500
Received: from smtp.h3c.com ([60.191.123.56]:56580 helo=h3cspam01-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tu.guoyi@h3c.com>)
 id 1kaY1K-0002Fx-4L; Thu, 05 Nov 2020 00:41:17 -0500
Received: from DAG2EX09-IDC.srv.huawei-3com.com ([10.8.0.72])
 by h3cspam01-ex.h3c.com with ESMTPS id 0A55ex02052459
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Nov 2020 13:40:59 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX09-IDC.srv.huawei-3com.com (10.8.0.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 5 Nov 2020 13:41:01 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.2106.002; Thu, 5 Nov 2020 13:41:01 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: RE: [PATCH] block: Return the real error code in bdrv_getlength
Thread-Topic: [PATCH] block: Return the real error code in bdrv_getlength
Thread-Index: AdazIT2D4zpMc6pIQHiDry0tmEuvDwAFD66w
Date: Thu, 5 Nov 2020 05:41:00 +0000
Message-ID: <62817854003b4a6398d7560fa8dad39c@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.131]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0A55ex02052459
Received-SPF: pass client-ip=60.191.123.56; envelope-from=tu.guoyi@h3c.com;
 helo=h3cspam01-ex.h3c.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 00:40:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U29ycnksIHBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaCwgaXQncyBub3QgYSByaWdodCBmaXgNCg0K
LS0NCkJlc3QgcmVnYXJkcywNCkd1b3lpDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiB0dWd1b3lpIChDbG91ZCkNCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDA1
LCAyMDIwIDExOjExIEFNDQo+IFRvOiAnS2V2aW4gV29sZicgPGt3b2xmQHJlZGhhdC5jb20+OyAn
TWF4IFJlaXR6JyA8bXJlaXR6QHJlZGhhdC5jb20+Ow0KPiAncWVtdS1ibG9ja0Bub25nbnUub3Jn
JyA8cWVtdS1ibG9ja0Bub25nbnUub3JnPg0KPiBDYzogJ3FlbXUtZGV2ZWxAbm9uZ251Lm9yZycg
PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gU3ViamVjdDogW1BBVENIXSBibG9jazogUmV0dXJu
IHRoZSByZWFsIGVycm9yIGNvZGUgaW4gYmRydl9nZXRsZW5ndGgNCj4gDQo+IFRoZSByZXR1cm4g
Y29kZSBmcm9tICBiZHJ2X25iX3NlY3RvcnMoKSBzaG91bGQgYmUgY2hlY2tlZCBiZWZvcmUgZG9p
bmcNCj4gdGhlIGZvbGxvd2luZyBzYW5pdHkgY2hlY2suDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBH
dW95aSBUdSA8dHUuZ3VveWlAaDNjLmNvbT4NCj4gLS0tDQo+ICBibG9jay5jIHwgNCArKysrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxv
Y2suYyBiL2Jsb2NrLmMNCj4gaW5kZXggNDMwZWRmNy4uMTllYmJjMCAxMDA2NDQNCj4gLS0tIGEv
YmxvY2suYw0KPiArKysgYi9ibG9jay5jDQo+IEBAIC01MDgyLDYgKzUwODIsMTAgQEAgaW50NjRf
dCBiZHJ2X2dldGxlbmd0aChCbG9ja0RyaXZlclN0YXRlICpicykNCj4gIHsNCj4gICAgICBpbnQ2
NF90IHJldCA9IGJkcnZfbmJfc2VjdG9ycyhicyk7DQo+IA0KPiArICAgIGlmIChyZXQgPCAwKSB7
DQo+ICsgICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAgfQ0KPiArDQo+ICAgICAgcmV0ID0gcmV0
ID4gSU5UNjRfTUFYIC8gQkRSVl9TRUNUT1JfU0laRSA/IC1FRkJJRyA6IHJldDsNCj4gICAgICBy
ZXR1cm4gcmV0IDwgMCA/IHJldCA6IHJldCAqIEJEUlZfU0VDVE9SX1NJWkU7DQo+ICB9DQo+IC0t
DQo+IDIuNy40DQo+IA0KPiANCj4gLS0NCj4gQmVzdCByZWdhcmRzLA0KPiBHdW95aQ0KPiANCg0K

