Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96EAC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 07:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9212468A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 07:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="b8gH4KBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9212468A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBYzl-00033c-L4
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 03:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bauerchen@tencent.com>) id 1jBYz1-0002cA-4G
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 03:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bauerchen@tencent.com>) id 1jBYyr-0001LR-JK
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 03:07:10 -0400
Received: from mail4.tencent.com ([183.57.53.109]:41249)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bauerchen@tencent.com>)
 id 1jBYyo-0000ub-9y; Tue, 10 Mar 2020 03:07:09 -0400
Received: from EX-SZ022.tencent.com (unknown [10.28.6.88])
 by mail4.tencent.com (Postfix) with ESMTP id C6898722EF;
 Tue, 10 Mar 2020 15:06:57 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
 s=s202002; t=1583824017;
 bh=Z5qN9vkeOS1XYS7YcAZmLLzvgP9OEZLTKBJuMIQBLqg=;
 h=From:To:CC:Subject:Date:References;
 b=b8gH4KBCHjE28m7k24iox30A/L2XlklMsf0TrqLzeIyZ3qnWH53d9ZxP94k7grJfi
 pfi1t3U05PokOBi9BSNVrombt0hd3N0UAPDV6jQoPjrM8ytpgdxnLtNWhL1PIWOaxe
 i6eSVpyNeuABfmBkSCG+aASRr3Sy0aUPQumqp9PI=
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ022.tencent.com
 (10.28.6.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 10 Mar
 2020 15:06:57 +0800
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ005.tencent.com
 (10.28.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 10 Mar
 2020 15:06:57 +0800
Received: from EX-SZ005.tencent.com ([fe80::a42c:28db:54ef:6adf]) by
 EX-SZ005.tencent.com ([fe80::a42c:28db:54ef:6adf%4]) with mapi id
 15.01.1847.007; Tue, 10 Mar 2020 15:06:57 +0800
From: =?utf-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: Re: [PATCH] mem-prealloc: initialize cond and mutex(Internet mail)
Thread-Topic: Re: [PATCH] mem-prealloc: initialize cond and mutex(Internet
 mail)
Thread-Index: AQHV9hVi+23h3n9d6Ua6AtHf0uF2VQ==
Date: Tue, 10 Mar 2020 07:06:57 +0000
Message-ID: <d656861cb19e4f468da5fe2db80e060e@tencent.com>
References: <20200306085014.120669-1-borntraeger@de.ibm.com>,
 <20200309110331.3ef650a9@redhat.com>,
 <13a05c3e-e374-8411-952d-05f4312ad6c0@redhat.com>,
 <d37b122a-1980-32f3-6c06-89e5ef2a4807@de.ibm.com>,
 <4976eaee60934e458e105bebe20d4d18@tencent.com>,
 <20200309141914.0b9ad42f@Igors-MacBook-Pro>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.14.87.247]
Content-Type: multipart/alternative;
 boundary="_000_d656861cb19e4f468da5fe2db80e060etencentcom_"
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
 mhartmay <mhartmay@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 pbonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_d656861cb19e4f468da5fe2db80e060etencentcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

b2ggLHllcy5UaGFua3MNCkkgd2FudCB0byBrbm93IGlmIEkgc3VibWl0IGEgbmV3IGZpeGVkIHBh
dGNoIG9yIGp1c3QgYSBwYXRjaCBmaXhlZCBjdXJyZW50IHByb2JsZW0/Pw0KaWYgYSBuZXcgZml4
ZWQgcGF0Y2gsIG1heWJlIG5lZWQgYSByZXZlcnQgPw0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCmJhdWVyY2hlbijpmYjokpnokpkpDQoNCkZyb206IElnb3IgTWFtbWVkb3Y8bWFp
bHRvOmltYW1tZWRvQHJlZGhhdC5jb20+DQpEYXRlOiAyMDIwLTAzLTA5IDIxOjE5DQpUbzogYmF1
ZXJjaGVuKOmZiOiSmeiSmSk8bWFpbHRvOmJhdWVyY2hlbkB0ZW5jZW50LmNvbT4NCkNDOiBib3Ju
dHJhZWdlcjxtYWlsdG86Ym9ybnRyYWVnZXJAZGUuaWJtLmNvbT47IHBib256aW5pPG1haWx0bzpw
Ym9uemluaUByZWRoYXQuY29tPjsgcWVtdS1kZXZlbDxtYWlsdG86cWVtdS1kZXZlbEBub25nbnUu
b3JnPjsgcWVtdS1zMzkweDxtYWlsdG86cWVtdS1zMzkweEBub25nbnUub3JnPjsgbWhhcnRtYXk8
bWFpbHRvOm1oYXJ0bWF5QGxpbnV4LmlibS5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBtZW0t
cHJlYWxsb2M6IGluaXRpYWxpemUgY29uZCBhbmQgbXV0ZXgoSW50ZXJuZXQgbWFpbCkNCk9uIE1v
biwgOSBNYXIgMjAyMCAxMToxNjoxMCArMDAwMA0KYmF1ZXJjaGVuKOmZiOiSmeiSmSkgPGJhdWVy
Y2hlbkB0ZW5jZW50LmNvbT4gd3JvdGU6DQoNCj4gVGhhbmtzLCAgaW4gZmFjdCxkb190b3VjaF9w
YWdlcyBpcyBjYWxsZWQganVzdCB3aGVuIHZtIHN0YXJ0cyB1cCwgYnV0IHVzaW5nIGluaXQgZmxh
ZyBhbmQgR29uY2UgbWF5YmUgbW9yZSBlbGVnYW50ICENCj4gaWYgbmVlZGVkLEkgY2FuIHN1Ym1p
dCBhIG5ldyBwYXRjaCAhDQo+IHRoYW5rcyB2ZXJ5IG11Y2ghDQoNCml0J3MgY2FsbGVkIGZyb20g
b3NfbWVtX3ByZWFsbG9jKCkgLT4gdG91Y2hfYWxsX3BhZ2VzKCkgd2hpY2ggaXMgY2FsbGVkDQph
dCBsZWFzdCBvbmNlIHBlciBhbiBpbnN0YW5jZSBvZiBob3RzbWVtIGJhY2tlbmQuIFNvIGlmIHNl
dmVyYWwgYmFja2VuZHMNCmFyZSB1c2VkIHRoZW4gaXQgc2hvdWxkIGJlIGNhbGxlZCBzZXZlcmFs
IHRpbWVzLg0KVGhlIHNhbWUgYXBwbGllcyB3aGVuIGEgaG9zdG1lbSBiYWNrZW5kIGlzIGFkZGVk
IGR1cmluZyBydW50aW1lIChob3RwbHVnKQ0KDQoNCg==

--_000_d656861cb19e4f468da5fe2db80e060etencentcom_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZT5ib2R5IHsgbGluZS1oZWlnaHQ6IDEu
NTsgfWJsb2NrcXVvdGUgeyBtYXJnaW4tdG9wOiAwcHg7IG1hcmdpbi1ib3R0b206IDBweDsgbWFy
Z2luLWxlZnQ6IDAuNWVtOyB9Ym9keSB7IGZvbnQtc2l6ZTogMTAuNXB0OyBmb250LWZhbWlseTog
J01pY3Jvc29mdCBZYUhlaSBVSSc7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGxpbmUtaGVpZ2h0OiAx
LjU7IH08L3N0eWxlPg0KPC9oZWFkPg0KPGJvZHk+DQo8ZGl2PjxzcGFuPjwvc3Bhbj5vaCAseWVz
LlRoYW5rczwvZGl2Pg0KPGRpdj5JIHdhbnQgdG8ga25vdyBpZiBJIHN1Ym1pdCBhIG5ldyBmaXhl
ZCBwYXRjaCBvciBqdXN0IGEgcGF0Y2ggZml4ZWQgY3VycmVudCBwcm9ibGVtPz8mbmJzcDs8L2Rp
dj4NCjxkaXY+aWYgYSBuZXcgZml4ZWQgcGF0Y2gsIG1heWJlIG5lZWQgYSByZXZlcnQgPzwvZGl2
Pg0KPGhyIHN0eWxlPSJ3aWR0aDogMjEwcHg7IGhlaWdodDogMXB4OyIgY29sb3I9IiNiNWM0ZGYi
IHNpemU9IjEiIGFsaWduPSJsZWZ0Ij4NCjxkaXY+PHNwYW4+DQo8ZGl2IHN0eWxlPSJNQVJHSU46
IDEwcHg7IEZPTlQtRkFNSUxZOiB2ZXJkYW5hOyBGT05ULVNJWkU6IDEwcHQiPg0KPGRpdj5iYXVl
cmNoZW4o6ZmI6JKZ6JKZKTwvZGl2Pg0KPC9kaXY+DQo8L3NwYW4+PC9kaXY+DQo8YmxvY2txdW90
ZSBzdHlsZT0ibWFyZ2luLVRvcDogMHB4OyBtYXJnaW4tQm90dG9tOiAwcHg7IG1hcmdpbi1MZWZ0
OiAwLjVlbSI+DQo8ZGl2PiZuYnNwOzwvZGl2Pg0KPGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9y
ZGVyLXRvcDpzb2xpZCAjQjVDNERGIDEuMHB0O3BhZGRpbmc6My4wcHQgMGNtIDBjbSAwY20iPg0K
PGRpdiBzdHlsZT0iUEFERElORy1SSUdIVDogOHB4OyBQQURESU5HLUxFRlQ6IDhweDsgRk9OVC1T
SVpFOiAxMnB4O0ZPTlQtRkFNSUxZOnRhaG9tYTtDT0xPUjojMDAwMDAwOyBCQUNLR1JPVU5EOiAj
ZWZlZmVmOyBQQURESU5HLUJPVFRPTTogOHB4OyBQQURESU5HLVRPUDogOHB4Ij4NCjxkaXY+PGI+
RnJvbTo8L2I+Jm5ic3A7PGEgaHJlZj0ibWFpbHRvOmltYW1tZWRvQHJlZGhhdC5jb20iPklnb3Ig
TWFtbWVkb3Y8L2E+PC9kaXY+DQo8ZGl2PjxiPkRhdGU6PC9iPiZuYnNwOzIwMjAtMDMtMDkmbmJz
cDsyMToxOTwvZGl2Pg0KPGRpdj48Yj5Ubzo8L2I+Jm5ic3A7PGEgaHJlZj0ibWFpbHRvOmJhdWVy
Y2hlbkB0ZW5jZW50LmNvbSI+YmF1ZXJjaGVuKOmZiOiSmeiSmSk8L2E+PC9kaXY+DQo8ZGl2Pjxi
PkNDOjwvYj4mbmJzcDs8YSBocmVmPSJtYWlsdG86Ym9ybnRyYWVnZXJAZGUuaWJtLmNvbSI+Ym9y
bnRyYWVnZXI8L2E+OyA8YSBocmVmPSJtYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbSI+DQpwYm9u
emluaTwvYT47IDxhIGhyZWY9Im1haWx0bzpxZW11LWRldmVsQG5vbmdudS5vcmciPnFlbXUtZGV2
ZWw8L2E+OyA8YSBocmVmPSJtYWlsdG86cWVtdS1zMzkweEBub25nbnUub3JnIj4NCnFlbXUtczM5
MHg8L2E+OyA8YSBocmVmPSJtYWlsdG86bWhhcnRtYXlAbGludXguaWJtLmNvbSI+bWhhcnRtYXk8
L2E+PC9kaXY+DQo8ZGl2PjxiPlN1YmplY3Q6PC9iPiZuYnNwO1JlOiBbUEFUQ0hdIG1lbS1wcmVh
bGxvYzogaW5pdGlhbGl6ZSBjb25kIGFuZCBtdXRleChJbnRlcm5ldCBtYWlsKTwvZGl2Pg0KPC9k
aXY+DQo8L2Rpdj4NCjxkaXY+DQo8ZGl2Pk9uIE1vbiwgOSBNYXIgMjAyMCAxMToxNjoxMCAmIzQz
OzAwMDA8L2Rpdj4NCjxkaXY+YmF1ZXJjaGVuKOmZiOiSmeiSmSkgJmx0O2JhdWVyY2hlbkB0ZW5j
ZW50LmNvbSZndDsgd3JvdGU6PC9kaXY+DQo8ZGl2PiZuYnNwOzwvZGl2Pg0KPGRpdj4mZ3Q7IFRo
YW5rcywgJm5ic3A7aW4gZmFjdCxkb190b3VjaF9wYWdlcyBpcyBjYWxsZWQganVzdCB3aGVuIHZt
IHN0YXJ0cyB1cCwgYnV0IHVzaW5nIGluaXQgZmxhZyBhbmQgR29uY2UgbWF5YmUgbW9yZSBlbGVn
YW50ICE8L2Rpdj4NCjxkaXY+Jmd0OyBpZiBuZWVkZWQsSSBjYW4gc3VibWl0IGEgbmV3IHBhdGNo
ICEgPC9kaXY+DQo8ZGl2PiZndDsgdGhhbmtzIHZlcnkgbXVjaCE8L2Rpdj4NCjxkaXY+Jm5ic3A7
PC9kaXY+DQo8ZGl2Pml0J3MgY2FsbGVkIGZyb20gb3NfbWVtX3ByZWFsbG9jKCkgLSZndDsgdG91
Y2hfYWxsX3BhZ2VzKCkgd2hpY2ggaXMgY2FsbGVkPC9kaXY+DQo8ZGl2PmF0IGxlYXN0IG9uY2Ug
cGVyIGFuIGluc3RhbmNlIG9mIGhvdHNtZW0gYmFja2VuZC4gU28gaWYgc2V2ZXJhbCBiYWNrZW5k
czwvZGl2Pg0KPGRpdj5hcmUgdXNlZCB0aGVuIGl0IHNob3VsZCBiZSBjYWxsZWQgc2V2ZXJhbCB0
aW1lcy48L2Rpdj4NCjxkaXY+VGhlIHNhbWUgYXBwbGllcyB3aGVuIGEgaG9zdG1lbSBiYWNrZW5k
IGlzIGFkZGVkIGR1cmluZyBydW50aW1lIChob3RwbHVnKTwvZGl2Pg0KPGRpdj4mbmJzcDs8L2Rp
dj4NCjxkaXY+Jm5ic3A7PC9kaXY+DQo8L2Rpdj4NCjwvYmxvY2txdW90ZT4NCjwvYm9keT4NCjwv
aHRtbD4NCg==

--_000_d656861cb19e4f468da5fe2db80e060etencentcom_--

