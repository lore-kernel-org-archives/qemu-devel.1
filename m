Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DE4C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 07:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D94521BF6
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 07:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D94521BF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hppX8-0003ZU-Bd
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 03:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46706)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hppWr-00033u-UJ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hppWq-0004sA-OZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:48:09 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2420 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <oscar.zhangbo@huawei.com>)
 id 1hppWq-0004W9-DQ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 03:48:08 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id B20E0A244E4A19E8863C;
 Tue, 23 Jul 2019 15:47:57 +0800 (CST)
Received: from DGGEML509-MBX.china.huawei.com ([169.254.1.213]) by
 dggeml406-hub.china.huawei.com ([10.3.17.50]) with mapi id 14.03.0439.000;
 Tue, 23 Jul 2019 15:47:51 +0800
From: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] pcie: fix device hotplug failure at the meantime of VM
 boot
Thread-Index: AdVBKpt/7Hdh09K+Sm2XGmt+PVN0Sw==
Date: Tue, 23 Jul 2019 07:47:51 +0000
Message-ID: <0259E1C966E8C54AA93AA2B1240828E672DF1C92@dggeml509-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.17.158]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.187
Subject: [Qemu-devel] [PATCH] pcie: fix device hotplug failure at the
 meantime of VM boot
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
Cc: fangying <fangying1@huawei.com>, "dengkai \(A\)" <dengkai1@huawei.com>,
 "limingwang \(A\)" <limingwang@huawei.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SWYgdGhlIFBDSV9FWFBfTE5LU1RBX0RMTExBIGNhcGFiaWxpdHkgaXMgc2V0IGJ5IGRlZmF1bHQs
IGxpbnV4IGtlcm5lbCB3aWxsIHNlbmQgDQpQREMgZXZlbnQgdG8gZGV0ZWN0IHdoZXRoZXIgdGhl
cmUgaXMgYSBkZXZpY2UgaW4gcGNpZSBzbG90LiBJZiBhIGRldmljZSBpcyBwbHVnZWQNCmluIHRo
ZSBwY2llLXJvb3QtcG9ydCBhdCB0aGUgc2FtZSB0aW1lLCBob3QtcGx1ZyBkZXZpY2Ugd2lsbCBz
ZW5kIEFCUCArIFBEQw0KZXZlbnRzIHRvIHRoZSBrZXJuZWwuIFRoZSBWTSBrZXJuZWwgd2lsbCB3
cm9uZ2x5IHVucGx1ZyB0aGUgZGV2aWNlIGlmIHR3byBQREMNCmV2ZW50cyBnZXQgdG9vIGNsb3Nl
LiBUaHVzIHdlJ2QgYmV0dGVyIHNldCB0aGUgUENJX0VYUF9MTktTVEFfRExMTEENCmNhcGFiaWxp
dHkgb25seSBpbiBob3RwbHVnIGNhbGxiYWNrLg0KDQpCeSB0aGUgd2F5LCB3ZSBzaG91bGQgY2xl
YW4gdXAgdGhlIFBDSV9FWFBfTE5LU1RBX0RMTExBIGNhcGFiaWxpdHkgZHVyaW5nDQp1bnBsdWcg
dG8gYXZvaWQgVk0gcmVzdGFydCBvciBtaWdyYXRpb24gZmFpbHVyZSB3aGljaCB3aWxsIGVudGVy
IHRoZSBzYW1lDQphYm5vcm1hbCBzY2VuYXJpbyBhcyBhYm92ZS4NCg0KU2lnbmVkLW9mZi1ieTog
bGltaW5nd2FuZ0BodWF3ZWkuY29tDQpTaWduZWQtb2ZmLWJ5OiBmYW5neWluZzFAaHVhd2VpLmNv
bQ0KU2lnbmVkLW9mZi1ieTogb3NjYXIuemhhbmdib0BodWF3ZWkuY29tDQotLS0NCiBody9wY2kv
cGNpZS5jIHwgOSArKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaWUuYyBiL2h3L3BjaS9wY2ll
LmMNCmluZGV4IGE2YmViNTYuLjE3NGYzOTIgMTAwNjQ0DQotLS0gYS9ody9wY2kvcGNpZS5jDQor
KysgYi9ody9wY2kvcGNpZS5jDQpAQCAtNzUsMTAgKzc1LDYgQEAgcGNpZV9jYXBfdjFfZmlsbChQ
Q0lEZXZpY2UgKmRldiwgdWludDhfdCBwb3J0LCB1aW50OF90IHR5cGUsIHVpbnQ4X3QgdmVyc2lv
bikNCiAgICAgICAgICAgICAgICAgIFFFTVVfUENJX0VYUF9MTktTVEFfTkxXKFFFTVVfUENJX0VY
UF9MTktfWDEpIHwNCiAgICAgICAgICAgICAgICAgIFFFTVVfUENJX0VYUF9MTktTVEFfQ0xTKFFF
TVVfUENJX0VYUF9MTktfMl81R1QpKTsNCiANCi0gICAgaWYgKGRldi0+Y2FwX3ByZXNlbnQgJiBR
RU1VX1BDSUVfTE5LU1RBX0RMTExBKSB7DQotICAgICAgICBwY2lfd29yZF90ZXN0X2FuZF9zZXRf
bWFzayhleHBfY2FwICsgUENJX0VYUF9MTktTVEEsDQotICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBQQ0lfRVhQX0xOS1NUQV9ETExMQSk7DQotICAgIH0NCiANCiAgICAgLyogV2Ug
Y2hhbmdlZCBsaW5rIHN0YXR1cyBiaXRzIG92ZXIgdGltZSwgYW5kIGNoYW5naW5nIHRoZW0gYWNy
b3NzDQogICAgICAqIG1pZ3JhdGlvbnMgaXMgZ2VuZXJhbGx5IGZpbmUgYXMgaGFyZHdhcmUgY2hh
bmdlcyB0aGVtIHRvby4NCkBAIC00ODQsNiArNDgwLDExIEBAIHZvaWQgcGNpZV9jYXBfc2xvdF91
bnBsdWdfcmVxdWVzdF9jYihIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19kZXYsDQogICAgICAgICBy
ZXR1cm47DQogICAgIH0NCiANCisgICAgaWYgKHBjaV9kZXYtPmNhcF9wcmVzZW50ICYgUUVNVV9Q
Q0lFX0xOS1NUQV9ETExMQSkgew0KKyAgICAgICAgcGNpX3dvcmRfdGVzdF9hbmRfY2xlYXJfbWFz
ayhleHBfY2FwICsgUENJX0VYUF9MTktTVEEsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFBDSV9FWFBfTE5LU1RBX0RMTExBKTsNCisgICAgfQ0KKw0KICAgICBwY2llX2Nh
cF9zbG90X3B1c2hfYXR0ZW50aW9uX2J1dHRvbihQQ0lfREVWSUNFKGhvdHBsdWdfZGV2KSk7DQog
fQ0KIA0KLS0gDQoxLjguMy4xDQo=

