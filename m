Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14610C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 02:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06E920724
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 02:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06E920724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ruijie.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpMwO-0003xO-48
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 22:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lichun@ruijie.com.cn>)
 id 1jpMvm-0003Wt-ON
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 22:20:30 -0400
Received: from mxfz.ruijie.com.cn ([120.35.11.201]:8682
 helo=FZEX4.ruijie.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lichun@ruijie.com.cn>)
 id 1jpMvi-000769-Qz
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 22:20:28 -0400
Received: from FZEX3.ruijie.com.cn ([fe80::9480:e49e:2190:b001]) by
 FZEX4.ruijie.com.cn ([fe80::4814:fd0d:3b:861c%16]) with mapi id
 14.03.0123.003; Sun, 28 Jun 2020 10:19:43 +0800
From: <lichun@ruijie.com.cn>
To: <marcandre.lureau@redhat.com>, <armbru@redhat.com>
Subject: Re: Re: [PATCH v2] chardev/tcp: fix error message double free error
Thread-Topic: Re: [PATCH v2] chardev/tcp: fix error message double free error
Thread-Index: AQHWTPKVppZYxh0MakK5s2V06kqolw==
Date: Sun, 28 Jun 2020 02:19:43 +0000
Message-ID: <EEB2AE3E67807845A92E2350C6F5E02E0131DC4D34@FZEX3.ruijie.com.cn>
References: <20200621213017.17978-1-lichun@ruijie.com.cn>,
 <87pn9n3alv.fsf@dusky.pond.sub.org>,
 <CAMxuvay1DnoogVOCxffYe4aA7sX8vZi6CoEa_j2kjWN22n3xAQ@mail.gmail.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 22:19:46
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

PkhpCj4KPk9uIFRodSwgSnVuIDI1LCAyMDIwIGF0IDEwOjQ3IEFNIE1hcmt1cyBBcm1icnVzdGVy
IDxhcm1icnVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IGxpY2h1biA8bGljaHVuQHJ1aWppZS5j
b20uY24+IHdyaXRlczoKPj4KPj4gPiBTaWduZWQtb2ZmLWJ5OiBsaWNodW4gPGxpY2h1bkBydWlq
aWUuY29tLmNuPgo+PiA+IC0tLQo+PiA+wqAgY2hhcmRldi9jaGFyLXNvY2tldC5jIHwgMyArKy0K
Pj4gPsKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4g
Pgo+PiA+IGRpZmYgLS1naXQgYS9jaGFyZGV2L2NoYXItc29ja2V0LmMgYi9jaGFyZGV2L2NoYXIt
c29ja2V0LmMKPj4gPiBpbmRleCBhZmViZWVjNWMzLi41NjlkNTRjMTQ0IDEwMDY0NAo+PiA+IC0t
LSBhL2NoYXJkZXYvY2hhci1zb2NrZXQuYwo+PiA+ICsrKyBiL2NoYXJkZXYvY2hhci1zb2NrZXQu
Ywo+PiA+IEBAIC0xNDIsNiArMTQyLDggQEAgc3RhdGljIHZvaWQgY2hlY2tfcmVwb3J0X2Nvbm5l
Y3RfZXJyb3IoQ2hhcmRldiAqY2hyLAo+PiA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJVbmFibGUgdG8gY29ubmVjdCBjaGFyYWN0ZXIgZGV2
aWNlICVzOiAiLAo+PiA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNoci0+bGFiZWwpOwo+PiA+wqDCoMKgwqDCoMKgwqDCoMKgIHMtPmNvbm5l
Y3RfZXJyX3JlcG9ydGVkID0gdHJ1ZTsKPj4gPiArwqDCoMKgIH0gZWxzZSB7Cj4+ID4gK8KgwqDC
oMKgwqDCoMKgIGVycm9yX2ZyZWUoZXJyKTsKPj4gPsKgwqDCoMKgwqAgfQo+PiA+wqDCoMKgwqDC
oCBxZW11X2Nocl9zb2NrZXRfcmVzdGFydF90aW1lcihjaHIpOwo+PiA+wqAgfQo+PiA+IEBAIC0x
MDg2LDcgKzEwODgsNiBAQCBzdGF0aWMgdm9pZCBxZW11X2Nocl9zb2NrZXRfY29ubmVjdGVkKFFJ
T1Rhc2sgKnRhc2ssIHZvaWQgKm9wYXF1ZSkKPj4gPsKgwqDCoMKgwqAgaWYgKHFpb190YXNrX3By
b3BhZ2F0ZV9lcnJvcih0YXNrLCAmZXJyKSkgewo+PiA+wqDCoMKgwqDCoMKgwqDCoMKgIHRjcF9j
aHJfY2hhbmdlX3N0YXRlKHMsIFRDUF9DSEFSREVWX1NUQVRFX0RJU0NPTk5FQ1RFRCk7Cj4+ID7C
oMKgwqDCoMKgwqDCoMKgwqAgY2hlY2tfcmVwb3J0X2Nvbm5lY3RfZXJyb3IoY2hyLCBlcnIpOwo+
PiA+IC3CoMKgwqDCoMKgwqDCoCBlcnJvcl9mcmVlKGVycik7Cj4+ID7CoMKgwqDCoMKgwqDCoMKg
wqAgZ290byBjbGVhbnVwOwo+PiA+wqDCoMKgwqDCoCB9Cj4+Cj4+IFNpbmNlIG15ICJFcnJvciBo
YW5kbGluZyBmaXhlcyAmIGNsZWFudXBzIiBzZXJpZXMgZml4ZXMgc2ltaWxhciBlcnJvcnMuCj4+
IEknbSBoYXBweSB0byBtZXJnZSB0aGlzIHBhdGNoIGFsb25nIHdpdGggaXQuwqAgVXAgdG8gTWFy
Yy1BbmRyw6kuCj4KPlRoYXQgd291bGQgYmUgZ3JlYXQsIHRoYW5rcyEgClRoYW5rIHlvdSEKPg==

