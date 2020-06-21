Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B1C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 13:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBEA12490E
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 13:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBEA12490E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ruijie.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn0Kk-00010j-6B
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 09:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lichun@ruijie.com.cn>)
 id 1jn0Jy-0000Yf-R1
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 09:47:42 -0400
Received: from mxfz.ruijie.com.cn ([120.35.11.201]:47215
 helo=FZEX4.ruijie.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lichun@ruijie.com.cn>)
 id 1jn0Jt-0001y4-Nk
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 09:47:39 -0400
Received: from FZEX3.ruijie.com.cn ([fe80::9480:e49e:2190:b001]) by
 FZEX4.ruijie.com.cn ([fe80::4814:fd0d:3b:861c%16]) with mapi id
 14.03.0123.003; Sun, 21 Jun 2020 21:47:26 +0800
From: <lichun@ruijie.com.cn>
To: <marcandre.lureau@redhat.com>
Subject: Re: Re: [PATCH] chardev/tcp: fix error message double free error
Thread-Topic: Re: [PATCH] chardev/tcp: fix error message double free error
Thread-Index: AQHWR9IeNn5gKrlackyB+w75trlbjw==
Date: Sun, 21 Jun 2020 13:47:25 +0000
Message-ID: <EEB2AE3E67807845A92E2350C6F5E02E0131DC1830@FZEX3.ruijie.com.cn>
References: <20200621145303.13068-1-lichun@ruijie.com.cn>,
 <CAMxuvaxiUtxSMK+93OYfUg-6RuzZkeZtzXxFvb_L=MNDGa-owA@mail.gmail.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/21 09:30:25
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, 706701795@qq.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PkhpCj4KPk9uIFN1biwgSnVuIDIxLCAyMDIwIGF0IDEwOjU0IEFNIGxpY2h1biA8bGljaHVuQHJ1
aWppZS5jb20uY24+IHdyb3RlOgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBsaWNodW4gPGxpY2h1bkBy
dWlqaWUuY29tLmNuPgo+PiAtLS0KPj7CoCBjaGFyZGV2L2NoYXItc29ja2V0LmMgfCA1ICsrKyst
Cj4+wqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvY2hhcmRldi9jaGFyLXNvY2tldC5jIGIvY2hhcmRldi9jaGFyLXNvY2tl
dC5jCj4+IGluZGV4IGFmZWJlZWM1YzMuLjNiNmMxYzU4NDggMTAwNjQ0Cj4+IC0tLSBhL2NoYXJk
ZXYvY2hhci1zb2NrZXQuYwo+PiArKysgYi9jaGFyZGV2L2NoYXItc29ja2V0LmMKPj4gQEAgLTEw
ODYsNyArMTA4NiwxMCBAQCBzdGF0aWMgdm9pZCBxZW11X2Nocl9zb2NrZXRfY29ubmVjdGVkKFFJ
T1Rhc2sgKnRhc2ssIHZvaWQgKm9wYXF1ZSkKPj7CoMKgwqDCoMKgIGlmIChxaW9fdGFza19wcm9w
YWdhdGVfZXJyb3IodGFzaywgJmVycikpIHsKPj7CoMKgwqDCoMKgwqDCoMKgwqAgdGNwX2Nocl9j
aGFuZ2Vfc3RhdGUocywgVENQX0NIQVJERVZfU1RBVEVfRElTQ09OTkVDVEVEKTsKPj7CoMKgwqDC
oMKgwqDCoMKgwqAgY2hlY2tfcmVwb3J0X2Nvbm5lY3RfZXJyb3IoY2hyLCBlcnIpOwo+PiAtwqDC
oMKgwqDCoMKgwqAgZXJyb3JfZnJlZShlcnIpOwo+PiArwqDCoMKgwqDCoMKgwqAgLyogSWYgY29u
bmVjdF9lcnJfcmVwb3J0ZWQgaXMgdHJ1ZSwgaXQgbWVhbnMgZXJyIGlzIGFscmVhZHkgZnJlZWQg
Ki8KPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghcy0+Y29ubmVjdF9lcnJfcmVwb3J0ZWQpIHsKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyb3JfZnJlZShlcnIpOwo+PiArwqDCoMKgwqDCoMKg
wqAgfQo+Cj5Hb29kIGNhdGNoIChkaWQgeW91IGZpbmQgaXQgd2l0aCBhIHN0YXRpYyBhbmFseXNp
cyB0b29sPykuIApZZWFoLCBJwqBmaW5kIGl0IHdpdGggZ2RiLgoKPgo+SW5zdGVhZCBvZiBjaGVj
a2luZyBjb25uZWN0X2Vycl9yZXBvcnRlZCBoZXJlLCBJIHdvdWxkIHJhdGhlciBsZXQKPmNoZWNr
X3JlcG9ydF9jb25uZWN0X2Vycm9yKCkgaGFuZGxlIGVycm9yX2ZyZWUoKS4gQ2FuIHlvdSB1cGRh
dGUgdGhlCj5wYXRjaD8gCk9mIGNvdXJzZSwgSSB3aWxsLgo+Cj50aGFua3MKPgo+PsKgwqDCoMKg
wqDCoMKgwqDCoCBnb3RvIGNsZWFudXA7Cj4+wqDCoMKgwqDCoCB9Cj4+Cj4+IC0tCj4+IDIuMTgu
NAo+Pgo+

