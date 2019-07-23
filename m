Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DC6C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505BF21921
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505BF21921
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprD1-000080-KO
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48178)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hprCq-0008As-4V
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hprCm-0000ZE-L7
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:35:36 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:37766 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <oscar.zhangbo@huawei.com>)
 id 1hprCm-0000Y5-90
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:35:32 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 8124231DDECE37FD4185;
 Tue, 23 Jul 2019 17:35:28 +0800 (CST)
Received: from DGGEML509-MBX.china.huawei.com ([169.254.1.213]) by
 DGGEML401-HUB.china.huawei.com ([fe80::89ed:853e:30a9:2a79%31]) with mapi id
 14.03.0439.000; Tue, 23 Jul 2019 17:35:13 +0800
From: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] pcie: fix device hotplug failure at the
 meantime of VM boot
Thread-Index: AdVBKpt/7Hdh09K+Sm2XGmt+PVN0S///k7uA//91ZPA=
Date: Tue, 23 Jul 2019 09:35:12 +0000
Message-ID: <0259E1C966E8C54AA93AA2B1240828E672DF3D5C@dggeml509-mbx.china.huawei.com>
References: <0259E1C966E8C54AA93AA2B1240828E672DF1C92@dggeml509-mbx.china.huawei.com>
 <79415991-ec1a-fac3-801d-2cfc446e8e11@redhat.com>
In-Reply-To: <79415991-ec1a-fac3-801d-2cfc446e8e11@redhat.com>
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
X-Received-From: 45.249.212.255
Subject: Re: [Qemu-devel] [PATCH] pcie: fix device hotplug failure at the
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
Cc: fangying <fangying1@huawei.com>, "mst@redhat.com" <mst@redhat.com>,
 "limingwang \(A\)" <limingwang@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIFttYWlsdG86cGhpbG1kQHJlZGhhdC5jb21dDQo+U2VudDogVHVlc2RheSwgSnVseSAy
MywgMjAxOSA1OjE4IFBNDQo+VG86IFpoYW5nYm8gKE9zY2FyKSA8b3NjYXIuemhhbmdib0BodWF3
ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+Q2M6IGZhbmd5aW5nIDxmYW5neWluZzFA
aHVhd2VpLmNvbT47IGRlbmdrYWkgKEEpIDxkZW5na2FpMUBodWF3ZWkuY29tPjsNCj5saW1pbmd3
YW5nIChBKSA8bGltaW5nd2FuZ0BodWF3ZWkuY29tPjsgbXN0QHJlZGhhdC5jb20NCj5TdWJqZWN0
OiBSZTogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gcGNpZTogZml4IGRldmljZSBob3RwbHVnIGZhaWx1
cmUgYXQgdGhlDQo+bWVhbnRpbWUgb2YgVk0gYm9vdA0KPg0KPkhpIE9zY2FyLA0KPg0KPk9uIDcv
MjMvMTkgOTo0NyBBTSwgWmhhbmdibyAoT3NjYXIpIHdyb3RlOg0KPj4gSWYgdGhlIFBDSV9FWFBf
TE5LU1RBX0RMTExBIGNhcGFiaWxpdHkgaXMgc2V0IGJ5IGRlZmF1bHQsIGxpbnV4IGtlcm5lbCB3
aWxsIHNlbmQNCj4+IFBEQyBldmVudCB0byBkZXRlY3Qgd2hldGhlciB0aGVyZSBpcyBhIGRldmlj
ZSBpbiBwY2llIHNsb3QuIElmIGEgZGV2aWNlIGlzIHBsdWdlZA0KPj4gaW4gdGhlIHBjaWUtcm9v
dC1wb3J0IGF0IHRoZSBzYW1lIHRpbWUsIGhvdC1wbHVnIGRldmljZSB3aWxsIHNlbmQgQUJQICsg
UERDDQo+PiBldmVudHMgdG8gdGhlIGtlcm5lbC4gVGhlIFZNIGtlcm5lbCB3aWxsIHdyb25nbHkg
dW5wbHVnIHRoZSBkZXZpY2UgaWYgdHdvIFBEQw0KPj4gZXZlbnRzIGdldCB0b28gY2xvc2UuIFRo
dXMgd2UnZCBiZXR0ZXIgc2V0IHRoZSBQQ0lfRVhQX0xOS1NUQV9ETExMQQ0KPj4gY2FwYWJpbGl0
eSBvbmx5IGluIGhvdHBsdWcgY2FsbGJhY2suDQo+Pg0KPj4gQnkgdGhlIHdheSwgd2Ugc2hvdWxk
IGNsZWFuIHVwIHRoZSBQQ0lfRVhQX0xOS1NUQV9ETExMQSBjYXBhYmlsaXR5IGR1cmluZw0KPj4g
dW5wbHVnIHRvIGF2b2lkIFZNIHJlc3RhcnQgb3IgbWlncmF0aW9uIGZhaWx1cmUgd2hpY2ggd2ls
bCBlbnRlciB0aGUgc2FtZQ0KPj4gYWJub3JtYWwgc2NlbmFyaW8gYXMgYWJvdmUuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogbGltaW5nd2FuZ0BodWF3ZWkuY29tDQo+PiBTaWduZWQtb2ZmLWJ5OiBm
YW5neWluZzFAaHVhd2VpLmNvbQ0KPg0KPlFFTVUgY29udHJpYnV0aW9uIGd1aWRlbGluZSBzYXlz
Og0KPg0KPiAgUGxlYXNlIHVzZSB5b3VyIHJlYWwgbmFtZSB0byBzaWduIGEgcGF0Y2ggKG5vdCBh
biBhbGlhcyBvciBhY3JvbnltKS4NCj4NClRoYW5rcyBmb3IgcmVtaW5kaW5nLCBJJ3ZlIHNlbnQg
YSBwYXRjaCBWMiBqdXN0IG5vdywgcGx6IGNoZWNrIHRoZXJlLg0KDQo+U2VlOg0KPmh0dHBzOi8v
d2lraS5xZW11Lm9yZy9Db250cmlidXRlL1N1Ym1pdEFQYXRjaCNQYXRjaF9lbWFpbHNfbXVzdF9p
bmNsdWRlX2ENCj5fU2lnbmVkLW9mZi1ieTpfbGluZQ0KPg0KPldlIGNhbiBpbmZlciBsaW1pbmd3
YW5nQCByZWFsIG5hbWUgaXMgTGltaW5nIFdhbmcsIG9zY2FyLnpoYW5nYm9AIGlzDQo+T3NjYXIg
WmhhbmdibywgYnV0IGZvciBmYW5neWluZzFAIGl0IGlzIHRvbyBoYXJkLg0KPkNhbiB5b3UgcHJv
dmlkZSBoaXMgcmVhbCBuYW1lPw0KPg0KPlRoYW5rcywNCj4NCj5QaGlsLg0KPg0KPj4gU2lnbmVk
LW9mZi1ieTogb3NjYXIuemhhbmdib0BodWF3ZWkuY29tDQo+PiAtLS0NCj4+ICBody9wY2kvcGNp
ZS5jIHwgOSArKysrKy0tLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9wY2kvcGNpZS5jIGIvaHcvcGNp
L3BjaWUuYw0KPj4gaW5kZXggYTZiZWI1Ni4uMTc0ZjM5MiAxMDA2NDQNCj4+IC0tLSBhL2h3L3Bj
aS9wY2llLmMNCj4+ICsrKyBiL2h3L3BjaS9wY2llLmMNCj4+IEBAIC03NSwxMCArNzUsNiBAQCBw
Y2llX2NhcF92MV9maWxsKFBDSURldmljZSAqZGV2LCB1aW50OF90IHBvcnQsIHVpbnQ4X3QNCj50
eXBlLCB1aW50OF90IHZlcnNpb24pDQo+Pg0KPlFFTVVfUENJX0VYUF9MTktTVEFfTkxXKFFFTVVf
UENJX0VYUF9MTktfWDEpIHwNCj4+DQo+UUVNVV9QQ0lfRVhQX0xOS1NUQV9DTFMoUUVNVV9QQ0lf
RVhQX0xOS18yXzVHVCkpOw0KPj4NCj4+IC0gICAgaWYgKGRldi0+Y2FwX3ByZXNlbnQgJiBRRU1V
X1BDSUVfTE5LU1RBX0RMTExBKSB7DQo+PiAtICAgICAgICBwY2lfd29yZF90ZXN0X2FuZF9zZXRf
bWFzayhleHBfY2FwICsgUENJX0VYUF9MTktTVEEsDQo+PiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBQQ0lfRVhQX0xOS1NUQV9ETExMQSk7DQo+PiAtICAgIH0NCj4+DQo+PiAg
ICAgIC8qIFdlIGNoYW5nZWQgbGluayBzdGF0dXMgYml0cyBvdmVyIHRpbWUsIGFuZCBjaGFuZ2lu
ZyB0aGVtIGFjcm9zcw0KPj4gICAgICAgKiBtaWdyYXRpb25zIGlzIGdlbmVyYWxseSBmaW5lIGFz
IGhhcmR3YXJlIGNoYW5nZXMgdGhlbSB0b28uDQo+PiBAQCAtNDg0LDYgKzQ4MCwxMSBAQCB2b2lk
DQo+cGNpZV9jYXBfc2xvdF91bnBsdWdfcmVxdWVzdF9jYihIb3RwbHVnSGFuZGxlciAqaG90cGx1
Z19kZXYsDQo+PiAgICAgICAgICByZXR1cm47DQo+PiAgICAgIH0NCj4+DQo+PiArICAgIGlmIChw
Y2lfZGV2LT5jYXBfcHJlc2VudCAmIFFFTVVfUENJRV9MTktTVEFfRExMTEEpIHsNCj4+ICsgICAg
ICAgIHBjaV93b3JkX3Rlc3RfYW5kX2NsZWFyX21hc2soZXhwX2NhcCArIFBDSV9FWFBfTE5LU1RB
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0lfRVhQX0xOS1NU
QV9ETExMQSk7DQo+PiArICAgIH0NCj4+ICsNCj4+ICAgICAgcGNpZV9jYXBfc2xvdF9wdXNoX2F0
dGVudGlvbl9idXR0b24oUENJX0RFVklDRShob3RwbHVnX2RldikpOw0KPj4gIH0NCj4+DQo+Pg0K

