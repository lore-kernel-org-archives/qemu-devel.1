Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD67C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 05:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAABD20739
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 05:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="mxRFgsCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAABD20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCG2v-0001fg-Of
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 01:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bauerchen@tencent.com>) id 1jCG2C-0000RB-FF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 01:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bauerchen@tencent.com>) id 1jCG28-0005CH-7Q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 01:05:25 -0400
Received: from mail4.tencent.com ([183.57.53.109]:39273)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bauerchen@tencent.com>)
 id 1jCG21-0004qu-Am; Thu, 12 Mar 2020 01:05:20 -0400
Received: from EX-SZ019.tencent.com (unknown [10.28.6.74])
 by mail4.tencent.com (Postfix) with ESMTP id 274E872602;
 Thu, 12 Mar 2020 13:05:04 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
 s=s202002; t=1583989504;
 bh=uhzdmdvKT8dKVTv96B3/EZ+4HseNLifcAYKWkg+YkrA=;
 h=From:To:CC:Subject:Date:References;
 b=mxRFgsCW0z4ii38/Am+y5wAahAfe0j1Cz+QBKY5zPclOj0UFEtVFOSJLi3bwjXhZG
 vVeNKceqWHuC+ZVk4KEeW1pGUm+q/6HDO3VDwRuzJoGSGZAEdyecubCmL93QBdhqVU
 Kf6yl4NuHC2LNfv+5JP+NjOtjIS4JPzmr22pghFM=
Received: from EX-SZ008.tencent.com (10.28.6.32) by EX-SZ019.tencent.com
 (10.28.6.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 12 Mar
 2020 13:05:04 +0800
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ008.tencent.com
 (10.28.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 12 Mar
 2020 13:05:03 +0800
Received: from EX-SZ005.tencent.com ([fe80::a42c:28db:54ef:6adf]) by
 EX-SZ005.tencent.com ([fe80::a42c:28db:54ef:6adf%4]) with mapi id
 15.01.1847.007; Thu, 12 Mar 2020 13:05:03 +0800
From: =?utf-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>
To: pbonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: Re: [PATCH] mem-prealloc: initialize cond and mutex(Internet mail)
Thread-Topic: Re: [PATCH] mem-prealloc: initialize cond and mutex(Internet
 mail)
Thread-Index: AQHV99O0uevKFo4oKEOufcaFp2Pr5A==
Date: Thu, 12 Mar 2020 05:05:03 +0000
Message-ID: <b25c127443a8448eb453cd439fd3821e@tencent.com>
References: <20200306085014.120669-1-borntraeger@de.ibm.com>,
 <20200309110331.3ef650a9@redhat.com>,
 <13a05c3e-e374-8411-952d-05f4312ad6c0@redhat.com>,
 <d37b122a-1980-32f3-6c06-89e5ef2a4807@de.ibm.com>,
 <4976eaee60934e458e105bebe20d4d18@tencent.com>,
 <20200309141914.0b9ad42f@Igors-MacBook-Pro>,
 <d656861cb19e4f468da5fe2db80e060e@tencent.com>,
 <a60b2bf8-5016-f0cc-217a-d9d0296e711b@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [10.28.2.14]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 183.57.53.109
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
Cc: borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 mhartmay <mhartmay@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

b2sgLHRoYW5rcyBQYW9sbwoKYmF1ZXIKwqAKRnJvbTrCoFBhb2xvIEJvbnppbmkKRGF0ZTrCoDIw
MjAtMDMtMTLCoDAyOjM0ClRvOsKgYmF1ZXJjaGVuKOmZiOiSmeiSmSk7IElnb3IgTWFtbWVkb3YK
Q0M6wqBib3JudHJhZWdlcjsgcWVtdS1kZXZlbDsgcWVtdS1zMzkweDsgbWhhcnRtYXkKU3ViamVj
dDrCoFJlOiBbUEFUQ0hdIG1lbS1wcmVhbGxvYzogaW5pdGlhbGl6ZSBjb25kIGFuZCBtdXRleChJ
bnRlcm5ldCBtYWlsKQpPbiAxMC8wMy8yMCAwODowNiwgYmF1ZXJjaGVuKOmZiOiSmeiSmSkgd3Jv
dGU6Cj4gb2ggLHllcy5UaGFua3MKPiBJIHdhbnQgdG8ga25vdyBpZiBJIHN1Ym1pdCBhIG5ldyBm
aXhlZCBwYXRjaCBvciBqdXN0IGEgcGF0Y2ggZml4ZWQKPiBjdXJyZW50IHByb2JsZW0/P8KgCj4g
aWYgYSBuZXcgZml4ZWQgcGF0Y2gsIG1heWJlIG5lZWQgYSByZXZlcnQgPwrCoApTb3JyeSBJIG1p
c3NlZCB0aGlzIG1lc3NhZ2UuwqAgSSBoYXZlIGFscmVhZHkgc2VudCBhIGZpeGVkIHBhdGNoLCB0
aGFua3MhCsKgClBhb2xvCsKgCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gYmF1ZXJjaGVuKOmZiOiSmeiS
mSkKPgo+wqDCoMKgwqAgwqAKPsKgwqDCoMKgICpGcm9tOirCoElnb3IgTWFtbWVkb3YgPG1haWx0
bzppbWFtbWVkb0ByZWRoYXQuY29tPgo+wqDCoMKgwqAgKkRhdGU6KsKgMjAyMC0wMy0wOcKgMjE6
MTkKPsKgwqDCoMKgICpUbzoqwqBiYXVlcmNoZW4o6ZmI6JKZ6JKZKSA8bWFpbHRvOmJhdWVyY2hl
bkB0ZW5jZW50LmNvbT4KPsKgwqDCoMKgICpDQzoqwqBib3JudHJhZWdlciA8bWFpbHRvOmJvcm50
cmFlZ2VyQGRlLmlibS5jb20+OyBwYm9uemluaQo+wqDCoMKgwqAgPG1haWx0bzpwYm9uemluaUBy
ZWRoYXQuY29tPjsgcWVtdS1kZXZlbAo+wqDCoMKgwqAgPG1haWx0bzpxZW11LWRldmVsQG5vbmdu
dS5vcmc+OyBxZW11LXMzOTB4Cj7CoMKgwqDCoCA8bWFpbHRvOnFlbXUtczM5MHhAbm9uZ251Lm9y
Zz47IG1oYXJ0bWF5IDxtYWlsdG86bWhhcnRtYXlAbGludXguaWJtLmNvbT4KPsKgwqDCoMKgICpT
dWJqZWN0OirCoFJlOiBbUEFUQ0hdIG1lbS1wcmVhbGxvYzogaW5pdGlhbGl6ZSBjb25kIGFuZAo+
wqDCoMKgwqAgbXV0ZXgoSW50ZXJuZXQgbWFpbCkKPsKgwqDCoMKgIE9uIE1vbiwgOSBNYXIgMjAy
MCAxMToxNjoxMCArMDAwMAo+wqDCoMKgwqAgYmF1ZXJjaGVuKOmZiOiSmeiSmSkgPGJhdWVyY2hl
bkB0ZW5jZW50LmNvbT4gd3JvdGU6Cj7CoMKgwqDCoCDCoAo+wqDCoMKgwqAgPiBUaGFua3MsIMKg
aW4gZmFjdCxkb190b3VjaF9wYWdlcyBpcyBjYWxsZWQganVzdCB3aGVuIHZtIHN0YXJ0cyB1cCwK
PsKgwqDCoMKgIGJ1dCB1c2luZyBpbml0IGZsYWcgYW5kIEdvbmNlIG1heWJlIG1vcmUgZWxlZ2Fu
dCAhCj7CoMKgwqDCoCA+IGlmIG5lZWRlZCxJIGNhbiBzdWJtaXQgYSBuZXcgcGF0Y2ggIQo+wqDC
oMKgwqAgPiB0aGFua3MgdmVyeSBtdWNoIQo+wqDCoMKgwqAgwqAKPsKgwqDCoMKgIGl0J3MgY2Fs
bGVkIGZyb20gb3NfbWVtX3ByZWFsbG9jKCkgLT4gdG91Y2hfYWxsX3BhZ2VzKCkgd2hpY2ggaXMg
Y2FsbGVkCj7CoMKgwqDCoCBhdCBsZWFzdCBvbmNlIHBlciBhbiBpbnN0YW5jZSBvZiBob3RzbWVt
IGJhY2tlbmQuIFNvIGlmIHNldmVyYWwgYmFja2VuZHMKPsKgwqDCoMKgIGFyZSB1c2VkIHRoZW4g
aXQgc2hvdWxkIGJlIGNhbGxlZCBzZXZlcmFsIHRpbWVzLgo+wqDCoMKgwqAgVGhlIHNhbWUgYXBw
bGllcyB3aGVuIGEgaG9zdG1lbSBiYWNrZW5kIGlzIGFkZGVkIGR1cmluZyBydW50aW1lCj7CoMKg
wqDCoCAoaG90cGx1ZykKPsKgwqDCoMKgIMKgCj7CoMKgwqDCoCDCoAo+CsKgCsKg

