Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDABC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E6920760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E6920760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ruijie.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqecV-000725-Fi
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lichun@ruijie.com.cn>)
 id 1jqeQB-0008Ss-5G
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:13:12 -0400
Received: from mxfz.ruijie.com.cn ([120.35.11.201]:43347
 helo=FZEX4.ruijie.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lichun@ruijie.com.cn>)
 id 1jqeQ6-0002Ry-0j
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:13:09 -0400
Received: from FZEX3.ruijie.com.cn ([fe80::9480:e49e:2190:b001]) by
 FZEX4.ruijie.com.cn ([fe80::4814:fd0d:3b:861c%16]) with mapi id
 14.03.0123.003; Wed, 1 Jul 2020 23:12:09 +0800
From: <lichun@ruijie.com.cn>
To: <pbonzini@redhat.com>, <armbru@redhat.com>
Subject: Re: Re: [PATCH v2] chardev/tcp: fix error message double free error
Thread-Topic: Re: [PATCH v2] chardev/tcp: fix error message double free error
Thread-Index: AQHWT7nr/0maSnhpJUOTWzv85EGtgg==
Date: Wed, 1 Jul 2020 15:12:08 +0000
Message-ID: <EEB2AE3E67807845A92E2350C6F5E02E0131DC6F73@FZEX3.ruijie.com.cn>
References: <20200621213017.17978-1-lichun@ruijie.com.cn>,
 <87zh8jbtpd.fsf@dusky.pond.sub.org>,
 <309b915a-9ddc-95a7-f579-7cf66a7c0253@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.20.101.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=120.35.11.201; envelope-from=lichun@ruijie.com.cn;
 helo=FZEX4.ruijie.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 11:12:09
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 706701795@qq.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pk9uIDAxLzA3LzIwIDA5OjA2LCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToKPj4gbGljaHVuIDxs
aWNodW5AcnVpamllLmNvbS5jbj4gd3JpdGVzOgo+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogbGljaHVu
IDxsaWNodW5AcnVpamllLmNvbS5jbj4KPj4+IC0tLQo+Pj7CoCBjaGFyZGV2L2NoYXItc29ja2V0
LmMgfCAzICsrLQo+Pj7CoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2NoYXJkZXYvY2hhci1zb2NrZXQuYyBiL2NoYXJk
ZXYvY2hhci1zb2NrZXQuYwo+Pj4gaW5kZXggYWZlYmVlYzVjMy4uNTY5ZDU0YzE0NCAxMDA2NDQK
Pj4+IC0tLSBhL2NoYXJkZXYvY2hhci1zb2NrZXQuYwo+Pj4gKysrIGIvY2hhcmRldi9jaGFyLXNv
Y2tldC5jCj4+PiBAQCAtMTQyLDYgKzE0Miw4IEBAIHN0YXRpYyB2b2lkIGNoZWNrX3JlcG9ydF9j
b25uZWN0X2Vycm9yKENoYXJkZXYgKmNociwKPj4+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJVbmFibGUgdG8gY29ubmVjdCBjaGFyYWN0ZXIg
ZGV2aWNlICVzOiAiLAo+Pj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY2hyLT5sYWJlbCk7Cj4+PsKgwqDCoMKgwqDCoMKgwqDCoCBzLT5jb25u
ZWN0X2Vycl9yZXBvcnRlZCA9IHRydWU7Cj4+PiArwqDCoMKgIH0gZWxzZSB7Cj4+PiArwqDCoMKg
wqDCoMKgwqAgZXJyb3JfZnJlZShlcnIpOwo+Pj7CoMKgwqDCoMKgIH0KPj4+wqDCoMKgwqDCoCBx
ZW11X2Nocl9zb2NrZXRfcmVzdGFydF90aW1lcihjaHIpOwo+Pj7CoCB9Cj4+PiBAQCAtMTA4Niw3
ICsxMDg4LDYgQEAgc3RhdGljIHZvaWQgcWVtdV9jaHJfc29ja2V0X2Nvbm5lY3RlZChRSU9UYXNr
ICp0YXNrLCB2b2lkICpvcGFxdWUpCj4+PsKgwqDCoMKgwqAgaWYgKHFpb190YXNrX3Byb3BhZ2F0
ZV9lcnJvcih0YXNrLCAmZXJyKSkgewo+Pj7CoMKgwqDCoMKgwqDCoMKgwqAgdGNwX2Nocl9jaGFu
Z2Vfc3RhdGUocywgVENQX0NIQVJERVZfU1RBVEVfRElTQ09OTkVDVEVEKTsKPj4+wqDCoMKgwqDC
oMKgwqDCoMKgIGNoZWNrX3JlcG9ydF9jb25uZWN0X2Vycm9yKGNociwgZXJyKTsKPj4+IC3CoMKg
wqDCoMKgwqDCoCBlcnJvcl9mcmVlKGVycik7Cj4+PsKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGNs
ZWFudXA7Cj4+PsKgwqDCoMKgwqAgfQo+Pgo+PiBSZXZpZXdlZC1ieTogTWFya3VzIEFybWJydXN0
ZXIgPGFybWJydUByZWRoYXQuY29tPgo+Pgo+PiBhbmQgcXVldWVkLCB0aGFua3MhCj4+Cj4KPkNh
biB5b3UgcGxlYXNlIGFkZCBhIG5vdGUgdG8gdGhlIGNvbW1pdCBtZXNzYWdlPwo+Cj7CoMKgwqAg
RXJyb3JzIGFyZSBhbHJlYWR5IGZyZWVkIGJ5IGVycm9yX3JlcG9ydF9lcnIsIHNvIHdlIG9ubHkg
bmVlZCB0byBjYWxsCj7CoMKgwqAgZXJyb3JfZnJlZSB3aGVuIHRoYXQgZnVuY3Rpb24gaXMgbm90
IGNhbGxlZC4KPsKgwqAKPmFuZCBDYyBxZW11LXN0YWJsZT/CoCBPciBJIGNhbiBxdWV1ZSBpdCB0
b28gc2luY2UgaXQncyBjaGFyZGV2IHN0dWZmLiAKT2sswqDCoEknbGwgcG9zdCB2My4KPg==

