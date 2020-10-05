Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC44C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F3820757
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F3820757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPRPh-0001rW-Ll
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaiwen@baidu.com>) id 1kPRMY-0000SL-H5
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:21:15 -0400
Received: from mx20.baidu.com ([111.202.115.85]:38152 helo=baidu.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chaiwen@baidu.com>) id 1kPRMR-0003la-SR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:21:11 -0400
Received: from BC-Mail-Ex05.internal.baidu.com (unknown [172.31.51.45])
 by Forcepoint Email with ESMTPS id 8ABD4F66A62D48F185F0;
 Mon,  5 Oct 2020 22:20:53 +0800 (CST)
Received: from BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) by
 BC-Mail-Ex05.internal.baidu.com (172.31.51.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1979.3; Mon, 5 Oct 2020 22:20:53 +0800
Received: from BJHW-Mail-Ex11.internal.baidu.com ([100.100.100.34]) by
 BJHW-Mail-Ex11.internal.baidu.com ([100.100.100.34]) with mapi id
 15.01.1979.006; Mon, 5 Oct 2020 22:20:53 +0800
From: "Chai,Wen" <chaiwen@baidu.com>
To: =?gb2312?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkqKY=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 03/21] contrib/gitdm: Add Baidu to the domain map
Thread-Topic: [RFC PATCH 03/21] contrib/gitdm: Add Baidu to the domain map
Thread-Index: AQHWmnjdkI6E4xbThU6L7W0TeSZjaqmJEIKA
Date: Mon, 5 Oct 2020 14:20:53 +0000
Message-ID: <DBA14C9E.497F1%chaiwen@baidu.com>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-4-f4bug@amsat.org>
In-Reply-To: <20201004180443.2035359-4-f4bug@amsat.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.238.67]
Content-Type: text/plain; charset="gb2312"
Content-ID: <5772DFF4B49F9D40A7FB74D7C6518DBD@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=111.202.115.85; envelope-from=chaiwen@baidu.com;
 helo=baidu.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 10:20:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Cc: Xie Yongji <xieyongji@baidu.com>, "Li, Hangjing" <lihangjing@baidu.com>,
 Zhang Yu <zhangyu31@baidu.com>, "Jia, Lina" <jialina01@baidu.com>,
 Ni Xun <nixun@baidu.com>,
 =?gb2312?B?QWxleCBCZW5uqKZl?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UmV2aWV3ZWQtYnkgY2hhaXdlbkBiYWlkdS5jb20NCg0KDQpUaGFua3MNCkNoYWkgV2VuDQoNCtTa
IDIwMjAvMTAvNSDJz87nMjowNKOsICJQaGlsaXBwZSBNYXRoaWV1LURhdWSopiINCjxwaGlsaXBw
ZS5tYXRoaWV1LmRhdWRlQGdtYWlsLmNvbSBvbiBiZWhhbGYgb2YgZjRidWdAYW1zYXQub3JnPiDQ
tMjrOg0KDQo+VGhlcmUgaXMgYSBudW1iZXIgb2YgY29udHJpYnV0b3JzIGZyb20gdGhpcyBkb21h
aW4sDQo+YWRkIGl0cyBvd24gZW50cnkgdG8gdGhlIGdpdGRtIGRvbWFpbiBtYXAuDQo+DQo+Q2M6
IEppYSBMaW5hIDxqaWFsaW5hMDFAYmFpZHUuY29tPg0KPkNjOiBMaSBIYW5namluZyA8bGloYW5n
amluZ0BiYWlkdS5jb20+DQo+Q2M6IFhpZSBZb25namkgPHhpZXlvbmdqaUBiYWlkdS5jb20+DQo+
Q2M6IENoYWkgV2VuIDxjaGFpd2VuQGJhaWR1LmNvbT4NCj5DYzogTmkgWHVuIDxuaXh1bkBiYWlk
dS5jb20+DQo+Q2M6IFpoYW5nIFl1IDx6aGFuZ3l1MzFAYmFpZHUuY29tPg0KPlNpZ25lZC1vZmYt
Ynk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZKimIDxmNGJ1Z0BhbXNhdC5vcmc+DQo+LS0tDQo+T25l
IFJldmlld2VkLWJ5L0Fjay1ieSBmcm9tIHNvbWVvbmUgZnJvbSB0aGlzIGRvbWFpbg0KPnNob3Vs
ZCBiZSBzdWZmaWNpZW50IHRvIGdldCB0aGlzIHBhdGNoIG1lcmdlZC4NCj4tLS0NCj5jb250cmli
L2dpdGRtL2RvbWFpbi1tYXAgfCAxICsNCj4xIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykN
Cj4NCj5kaWZmIC0tZ2l0IGEvY29udHJpYi9naXRkbS9kb21haW4tbWFwIGIvY29udHJpYi9naXRk
bS9kb21haW4tbWFwDQo+aW5kZXggMjk1NmY5ZTRkZS4uMGVhYTRlYzA1MSAxMDA2NDQNCj4tLS0g
YS9jb250cmliL2dpdGRtL2RvbWFpbi1tYXANCj4rKysgYi9jb250cmliL2dpdGRtL2RvbWFpbi1t
YXANCj5AQCAtOCw2ICs4LDcgQEAgbGludXguYWxpYmFiYS5jb20gQWxpYmFiYQ0KPmFtYXpvbi5j
b20gICAgICBBbWF6b24NCj5hbWF6b24uZGUgICAgICAgQW1hem9uDQo+YW1kLmNvbSAgICAgICAg
IEFNRA0KPitiYWlkdS5jb20gICAgICAgQmFpZHUNCj5jbXNzLmNoaW5hbW9iaWxlLmNvbSBDaGlu
YSBNb2JpbGUNCj5jaXRyaXguY29tICAgICAgQ2l0cml4DQo+Z3JlZW5zb2NzLmNvbSAgIEdyZWVu
U29jcw0KPi0tIA0KPjIuMjYuMg0KPg0KPg0KDQo=

