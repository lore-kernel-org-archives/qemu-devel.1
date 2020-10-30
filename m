Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D62C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD43A206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD43A206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKPB-0003Bz-Na
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kYKOF-0002fI-Qw
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:43:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kYKOB-0001J3-CF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 22:43:43 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CMmpD48CQzQlpq;
 Fri, 30 Oct 2020 10:43:32 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0487.000;
 Fri, 30 Oct 2020 10:43:27 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: RE: [PATCH] tcg/optimize: Add fallthrough annotations
Thread-Topic: [PATCH] tcg/optimize: Add fallthrough annotations
Thread-Index: AQHWre8Vraw8sTLInUaP5k71cY9i1amufCyAgADsDrA=
Date: Fri, 30 Oct 2020 02:43:26 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA174B6@dggemm531-mbx.china.huawei.com>
References: <20201029122833.195420-1-thuth@redhat.com>
 <24b2a36c-d94d-e5f6-57c0-a9e6c4970b53@linaro.org>
In-Reply-To: <24b2a36c-d94d-e5f6-57c0-a9e6c4970b53@linaro.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga02-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 22:43:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIEhlbmRlcnNvbiBb
bWFpbHRvOnJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmddDQo+IFNlbnQ6IEZyaWRheSwgT2N0
b2JlciAzMCwgMjAyMCA0OjA3IEFNDQo+IFRvOiBUaG9tYXMgSHV0aCA8dGh1dGhAcmVkaGF0LmNv
bT47IFJpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+Ow0KPiBxZW11LWRldmVsQG5v
bmdudS5vcmcNCj4gQ2M6IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdGNnL29wdGltaXplOiBBZGQgZmFsbHRocm91Z2ggYW5u
b3RhdGlvbnMNCj4gDQo+IE9uIDEwLzI5LzIwIDU6MjggQU0sIFRob21hcyBIdXRoIHdyb3RlOg0K
PiA+IFRvIGJlIGFibGUgdG8gY29tcGlsZSB0aGlzIGZpbGUgd2l0aCAtV2Vycm9yPWltcGxpY2l0
LWZhbGx0aHJvdWdoLCB3ZQ0KPiA+IG5lZWQgdG8gYWRkIHNvbWUgZmFsbHRocm91Z2ggYW5ub3Rh
dGlvbnMgdG8gdGhlIGNhc2Ugc3RhdGVtZW50cyB0aGF0DQo+ID4gbWlnaHQgZmFsbCB0aHJvdWdo
LiBVbmZvcnR1bmF0ZWx5LCB0aGUgdHlwaWNhbCAiLyogZmFsbHRocm91Z2ggKi8iDQo+ID4gY29t
bWVudHMgZG8gbm90IHdvcmsgaGVyZSBhcyBleHBlY3RlZCBzaW5jZSBzb21lIGNhc2UgbGFiZWxz
IGFyZQ0KPiA+IHdyYXBwZWQgaW4gbWFjcm9zIGFuZCB0aGUgY29tcGlsZXIgZmFpbHMgdG8gbWF0
Y2ggdGhlIGNvbW1lbnRzIGluIHRoaXMNCj4gPiBjYXNlLiBCdXQgdXNpbmcgX19hdHRyaWJ1dGVf
XygoZmFsbHRocm91Z2gpKSBzZWVtcyB0byB3b3JrIGZpbmUsIHNvDQo+ID4gbGV0J3MgdXNlIHRo
YXQgaW5zdGVhZC4NCj4gDQo+IFdoeSB3b3VsZCB0aGUgbWFjcm8gbWF0dGVyPyAgSXQgZXhwYW5k
cyB0byB0d28gY2FzZSBzdGF0ZW1lbnRzIHdpdGgNCj4gbm90aGluZyBpbiBiZXR3ZWVuIHRoZW0u
DQo+IA0KPiBUaGlzIHNvdW5kcyBsaWtlIGEgY29tcGlsZXIgYnVnIHRoYXQgc2hvdWxkIGJlIHJl
cG9ydGVkLg0KPiANCkhpIGFsbCwNCiAgSSBoYXZlIHF1ZXJpZWQgdGhlIEdDQyBvcHRpb25zIGRl
c2NyaXB0aW9uIGFib3V0IHRoZSBXaW1wbGljaXQtZmFsbHRocm91Z2ggYW5kIHZlcmlmaWVkIGl0
Lg0KVGhlIHZhbHVlIG9mIFdpbXBsaWNpdC1mYWxsdGhyb3VnaCByYW5nZXMgZnJvbSAwIHRvIDUu
IA0KVGhlIHZhbHVlIDAgaXMgdG8gaWdub3JlIGFsbCB3YXJuaW5ncywgd2hpY2ggaXMgY2VydGFp
bmx5IG5vdCB3aGF0IHdlIG5lZWQuDQpJZiB0aGUgdmFsdWUgaXMgc2V0IHRvIDEgb3IgMiwgbW9z
dCBmYWxsIHRocm91Z2ggb24gdGhlIFFFTVUgY2FuIHRha2UgZWZmZWN0Lg0KICAgRWfvvJovKiBG
QUxMVEhSVSAqL+OAgS8qIGZhbGx0aHJ1ICov44CBLyogZmFsbC10aHJvdWdoICov44CBLyogRkFM
TFRIT1VHSCAqL+OAgS8qIGZhbGwgdGhyb3VnaCAqL+OAgS8qIGZhbGx0aHJvdWdoICovLi4NCg0K
V2hlbiB0aGUgdmFsdWUgcmFuZ2VzIGZyb20gMyB0byA1LCBtb3JlIGZhbGx0aHJvdWdoIGNvbW1l
bnRzIGJlY29tZSBpbnZhbGlkIGFzIHRoZSB2YWx1ZSBpbmNyZWFzZXMuDQoNClNvLCBJIGFncmVl
IHdpdGggUGhpbGlwcGUncyBzdWdnZXN0aW9uIHRvIGFkZCBhIFFFTVVfRkFMTFRIUk9VR0ggdG8g
dW5pZnkgdGhpcyBjb21waWxlciBwcm9wZXJ0eS4NCg0KVGhhbmtzLA0KQ2hlbiBRdW4NCg0KQWRk
aXRpb25hbCBnY2MgaW5mb3JtYXRpb24gaXMgYXMgZm9sbG93czoNCmh0dHBzOi8vZ2NjLmdudS5v
cmcvb25saW5lZG9jcy9nY2MvV2FybmluZy1PcHRpb25zLmh0bWwNCi1XaW1wbGljaXQtZmFsbHRo
cm91Z2ggaXMgdGhlIHNhbWUgYXMgLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD0zIGFuZCAtV25vLWlt
cGxpY2l0LWZhbGx0aHJvdWdoIGlzIHRoZSBzYW1lIGFzIC1XaW1wbGljaXQtZmFsbHRocm91Z2g9
MC4NCg0KVGhlIG9wdGlvbiBhcmd1bWVudCBuIHNwZWNpZmllcyB3aGF0IGtpbmQgb2YgY29tbWVu
dHMgYXJlIGFjY2VwdGVkOg0KLVdpbXBsaWNpdC1mYWxsdGhyb3VnaD0wIGRpc2FibGVzIHRoZSB3
YXJuaW5nIGFsdG9nZXRoZXIuDQotV2ltcGxpY2l0LWZhbGx0aHJvdWdoPTEgbWF0Y2hlcyAuKiBy
ZWd1bGFyIGV4cHJlc3Npb24sIGFueSBjb21tZW50IGlzIHVzZWQgYXMgZmFsbHRocm91Z2ggY29t
bWVudC4NCi1XaW1wbGljaXQtZmFsbHRocm91Z2g9MiBjYXNlIGluc2Vuc2l0aXZlbHkgbWF0Y2hl
cyAuKmZhbGxzP1sgXHQtXSp0aHIob3VnaHx1KS4qIHJlZ3VsYXIgZXhwcmVzc2lvbi4NCi1XaW1w
bGljaXQtZmFsbHRocm91Z2g9MyBjYXNlIHNlbnNpdGl2ZWx5IG1hdGNoZXMgb25lIG9mIHRoZSBm
b2xsb3dpbmcgcmVndWxhciBleHByZXNzaW9uczoNCiAgIC1mYWxsdGhyb3VnaA0KICAgQGZhbGx0
aHJvdWdoQA0KICAgbGludCAtZmFsbHRocm91Z2hbIFx0XSoNCiAgIFsgXHQuIV0qKEVMU0UsPyB8
SU5URU5USU9OQUwoTFkpPyApPw0KICAgRkFMTChTIHwgfC0pP1RIUihPVUdIfFUpWyBcdC4hXSoo
LVteXG5ccl0qKT8NCiAgIFsgXHQuIV0qKEVsc2UsPyB8SW50ZW50aW9uYWwobHkpPyApPw0KICAg
RmFsbCgocyB8IHwtKVtUdF18dClocihvdWdofHUpWyBcdC4hXSooLVteXG5ccl0qKT8NCiAgIFsg
XHQuIV0qKFtFZV1sc2UsPyB8W0lpXW50ZW50aW9uYWwobHkpPyApPw0KICAgZmFsbChzIHwgfC0p
P3RocihvdWdofHUpWyBcdC4hXSooLVteXG5ccl0qKT8NCi1XaW1wbGljaXQtZmFsbHRocm91Z2g9
NCBjYXNlIHNlbnNpdGl2ZWx5IG1hdGNoZXMgb25lIG9mIHRoZSBmb2xsb3dpbmcgcmVndWxhciBl
eHByZXNzaW9uczoNCiAgICAtZmFsbHRocm91Z2gNCiAgICBAZmFsbHRocm91Z2hADQogICAgbGlu
dCAtZmFsbHRocm91Z2hbIFx0XSoNCiAgICBbIFx0XSpGQUxMVEhSKE9VR0h8VSlbIFx0XSoNCi1X
aW1wbGljaXQtZmFsbHRocm91Z2g9NSBkb2VzbuKAmXQgcmVjb2duaXplIGFueSBjb21tZW50cyBh
cyBmYWxsdGhyb3VnaCBjb21tZW50cywgb25seSBhdHRyaWJ1dGVzIGRpc2FibGUgdGhlIHdhcm5p
bmcuDQo=

