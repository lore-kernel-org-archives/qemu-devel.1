Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C703C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 10:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B780B2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 10:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B780B2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kacOt-0006ve-NQ
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 05:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangxinhao1@huawei.com>)
 id 1kacOH-0006IE-5g; Thu, 05 Nov 2020 05:21:14 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangxinhao1@huawei.com>)
 id 1kacOD-0000ty-Hx; Thu, 05 Nov 2020 05:21:12 -0500
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CRfg31rcVz13MHC;
 Thu,  5 Nov 2020 18:20:47 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.57]) by
 DGGEML401-HUB.china.huawei.com ([fe80::89ed:853e:30a9:2a79%31]) with mapi id
 14.03.0487.000; Thu, 5 Nov 2020 18:20:51 +0800
From: zhangxinhao <zhangxinhao1@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggMS8zXSB0YXJnZXQvYXJtOiBhZGQgc3BhY2VzIGFy?=
 =?utf-8?Q?ound_operator?=
Thread-Topic: [PATCH 1/3] target/arm: add spaces around operator
Thread-Index: AQHWstUOGWV9G+sfy0aP7wHas2aSuKm5UmJQ
Date: Thu, 5 Nov 2020 10:20:51 +0000
Message-ID: <1B402B07BB975145B1A42DB3F40A115D013F94DB@DGGEML522-MBX.china.huawei.com>
References: <20201103114529.638233-1-zhangxinhao1@huawei.com>
 <CAFEAcA-EXS2czmGNePYcTPT+qJSp7jjHjECdaVRbwSda-zQOcg@mail.gmail.com>
In-Reply-To: <CAFEAcA-EXS2czmGNePYcTPT+qJSp7jjHjECdaVRbwSda-zQOcg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.187.250]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=zhangxinhao1@huawei.com; helo=szxga08-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 05:21:03
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Chenzhendong \(alex\)" <alex.chen@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhbmtzIGZvciBhZHZpc2UuIEkgd2lsbCBzdHVkeSB0aGUgZG9jdW1lbnRzIGFuZCBpbmNsdWRl
IGEgY292ZXIgbGV0dGVyIGluIG5leHQgcGF0Y2ggc2VyaWVzIHN1Ym1pc3Npb25zIDopDQoNCi0t
LS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogUGV0ZXIgTWF5ZGVsbCBbbWFpbHRvOnBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZ10gDQrlj5HpgIHml7bpl7Q6IDIwMjDlubQxMeaciDXml6Ug
MjowNQ0K5pS25Lu25Lq6OiB6aGFuZ3hpbmhhbyA8emhhbmd4aW5oYW8xQGh1YXdlaS5jb20+DQrm
ioTpgIE6IFFFTVUgRGV2ZWxvcGVycyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgcWVtdS1hcm0g
PHFlbXUtYXJtQG5vbmdudS5vcmc+OyBkZW5na2FpIChBKSA8ZGVuZ2thaTFAaHVhd2VpLmNvbT47
IENoZW56aGVuZG9uZyAoYWxleCkgPGFsZXguY2hlbkBodWF3ZWkuY29tPjsgUUVNVSBUcml2aWFs
IDxxZW11LXRyaXZpYWxAbm9uZ251Lm9yZz4NCuS4u+mimDogUmU6IFtQQVRDSCAxLzNdIHRhcmdl
dC9hcm06IGFkZCBzcGFjZXMgYXJvdW5kIG9wZXJhdG9yDQoNCk9uIFR1ZSwgMyBOb3YgMjAyMCBh
dCAxMTo0NywgWGluaGFvIFpoYW5nIDx6aGFuZ3hpbmhhbzFAaHVhd2VpLmNvbT4gd3JvdGU6DQo+
DQo+IEZpeCBjb2RlIHN0eWxlLiBPcGVyYXRvciBuZWVkcyBzcGFjZXMgYm90aCBzaWRlcy4NCg0K
VGhhbmtzOyBJIGhhdmUgYXBwbGllZCB0aGlzIHNlcmllcyB0byB0YXJnZXQtYXJtLm5leHQuDQoN
CkZvciBmdXR1cmUgcGF0Y2ggc3VibWlzc2lvbnMsIHBsZWFzZSBjb3VsZCB5b3UgaW5jbHVkZSBh
IGNvdmVyIGxldHRlciBpZiB5b3UncmUgc3VibWl0dGluZyBhIHNlcmllcyB3aXRoIG1vcmUgdGhh
biBvbmUgcGF0Y2ggaW4gaXQ/IChTaW5nbGUgcGF0Y2hlcyBkb24ndCBuZWVkIGEgY292ZXIgbGV0
dGVyKS4gVGhlIGluZGl2aWR1YWwgcGF0Y2hlcyBzaG91bGQgYWxsIHRoZW4gYmUgZm9sbG93LXVw
cyB0byB0aGUgY292ZXIgbGV0dGVyIChpbiB0aGUgdXN1YWwgd2F5IHRoYXQgZ2l0IGZvcm1hdC1w
YXRjaCAtLWNvdmVyLWxldHRlciBzZXRzIHVwKS4NCg0KKFdlIGRvY3VtZW50IHRoaXMgYW5kIG90
aGVyIGNvbnZlbnRpb25zIGZvciBvdXIgY29kZSBzdWJtaXNzaW9uIHByb2Nlc3MgYXQ6DQpodHRw
czovL3dpa2kucWVtdS5vcmcvQ29udHJpYnV0ZS9TdWJtaXRBUGF0Y2ggKQ0KDQp0aGFua3MNCi0t
IFBNTQ0K

