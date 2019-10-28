Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C063CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CC620862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CC620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP9Ri-000116-D5
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 14:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iP8go-00053x-38
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 13:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iP8gm-000590-8a
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 13:20:21 -0400
Resent-Date: Mon, 28 Oct 2019 13:20:21 -0400
Resent-Message-Id: <E1iP8gm-000590-8a@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iP8gm-00057U-33
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 13:20:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572283210; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=a6RybmWlA2lTkNB/FBGFJ/l6FZyq+Ohi1xuSkAFweBu8V4prEhHGyMw+tWmEIrSWG8kwFXGhV+UT+lA2W6JmmsG/loM4CZ34B3T+v07gG6O3P9XyKDKhwBszBugTihxw5MZIKpMgIVtedaDBDMDH5HO30hUVJsHekeHDk8D1/Hk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572283210;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=PWbqq1QW97Kqnw/05gbmQVJqI81FSGx0fwy4snsUZYg=; 
 b=FkCO4k3/tszGXUVdrWMpXX9JIAc0sW/JHQ1Gg0nH0KA/XbZmJJU74BZk6Zi0gC6iR9GwLGHuuwnUQeX65c6gNmI2u7L2EnGAoq943XrFgtp5cvSAnhikLiRuYc3Ap4VXn+AEzgFCGKj7sMHgJoBFK4i8giYh3xBfnE4CUDXIVCE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572283207706455.88131633162334;
 Mon, 28 Oct 2019 10:20:07 -0700 (PDT)
In-Reply-To: <20191028145937.10914-1-richard.henderson@linaro.org>
Subject: Re: [PULL v2 00/12] tcg patch queue
Message-ID: <157228320657.12254.17072121178679193653@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Mon, 28 Oct 2019 10:20:07 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Reply-To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyODE0NTkzNy4xMDkx
NC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQVUxMIHYyIDAwLzEyXSB0Y2cgcGF0Y2gg
cXVldWUKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkxMDI4MTQ1OTM3LjEwOTE0LTEtcmlj
aGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9z
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVO
RCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQK
U3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpkZGRkMmM5IHRyYW5zbGF0ZS1hbGw6IFJl
bW92ZSB0Yl9hbGxvYwpjZTY2M2IyIHRyYW5zbGF0ZS1hbGw6IGZpeCB1bmluaXRpYWxpemVkIHRi
LT5vcmlnX3RiCjkwYzNlYmEgY3B1dGxiOiBGaXggdGxiX3ZhZGRyX3RvX2hvc3QKZDJiOGNiZCBl
eGVjOiBDYWNoZSBUQVJHRVRfUEFHRV9NQVNLIGZvciBUQVJHRVRfUEFHRV9CSVRTX1ZBUlkKNGNl
MjNkMCBleGVjOiBQcm9tb3RlIFRBUkdFVF9QQUdFX01BU0sgdG8gdGFyZ2V0X2xvbmcKN2QyNjk5
ZiBleGVjOiBSZXN0cmljdCBUQVJHRVRfUEFHRV9CSVRTX1ZBUlkgYXNzZXJ0IHRvIENPTkZJR19E
RUJVR19UQ0cKYjVmNzEyZCBleGVjOiBVc2UgY29uc3QgYWxpYXMgZm9yIFRBUkdFVF9QQUdFX0JJ
VFNfVkFSWQo4ZDFlOWQwIGNvbmZpZ3VyZTogRGV0ZWN0IGNvbXBpbGVyIHN1cHBvcnQgZm9yIF9f
YXR0cmlidXRlX18oKGFsaWFzKSkKY2FkOTAyNSBleGVjOiBTcGxpdCBvdXQgdmFyaWFibGUgcGFn
ZSBzaXplIHN1cHBvcnQgdG8gZXhlYy12YXJ5LmMKYjI5MGRiNCBjcHU6IHVzZSBST1VORF9VUCgp
IHRvIGRlZmluZSB4eHhfUEFHRV9BTElHTgo2MGRiZjE0IGNwdXRsYjogZW5zdXJlIF9jbW11IGhl
bHBlciBmdW5jdGlvbnMgZm9sbG93IHRoZSBuYW1pbmcgc3RhbmRhcmQKY2RhZWVhZiB0Y2k6IEFk
ZCBpbXBsZW1lbnRhdGlvbiBmb3IgSU5ERVhfb3BfbGQxNnVfaTY0Cgo9PT0gT1VUUFVUIEJFR0lO
ID09PQoxLzEyIENoZWNraW5nIGNvbW1pdCBjZGFlZWFmNDAxZDIgKHRjaTogQWRkIGltcGxlbWVu
dGF0aW9uIGZvciBJTkRFWF9vcF9sZDE2dV9pNjQpCjIvMTIgQ2hlY2tpbmcgY29tbWl0IDYwZGJm
MTQwYTlhYiAoY3B1dGxiOiBlbnN1cmUgX2NtbXUgaGVscGVyIGZ1bmN0aW9ucyBmb2xsb3cgdGhl
IG5hbWluZyBzdGFuZGFyZCkKMy8xMiBDaGVja2luZyBjb21taXQgYjI5MGRiNDQ2Mjk4IChjcHU6
IHVzZSBST1VORF9VUCgpIHRvIGRlZmluZSB4eHhfUEFHRV9BTElHTikKNC8xMiBDaGVja2luZyBj
b21taXQgY2FkOTAyNWQ4OWNiIChleGVjOiBTcGxpdCBvdXQgdmFyaWFibGUgcGFnZSBzaXplIHN1
cHBvcnQgdG8gZXhlYy12YXJ5LmMpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZp
bGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzM0OiAKbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMTI1IGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDQvMTIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KNS8xMiBDaGVja2luZyBjb21t
aXQgOGQxZTlkMDdjMjk2IChjb25maWd1cmU6IERldGVjdCBjb21waWxlciBzdXBwb3J0IGZvciBf
X2F0dHJpYnV0ZV9fKChhbGlhcykpKQo2LzEyIENoZWNraW5nIGNvbW1pdCBiNWY3MTJkMDJlNGYg
KGV4ZWM6IFVzZSBjb25zdCBhbGlhcyBmb3IgVEFSR0VUX1BBR0VfQklUU19WQVJZKQpFUlJPUjog
ZXh0ZXJucyBzaG91bGQgYmUgYXZvaWRlZCBpbiAuYyBmaWxlcwojNjY6IEZJTEU6IGV4ZWMtdmFy
eS5jOjU3OgorZXh0ZXJuIGNvbnN0IFRhcmdldFBhZ2VCaXRzIHRhcmdldF9wYWdlCgp0b3RhbDog
MSBlcnJvcnMsIDAgd2FybmluZ3MsIDEwOSBsaW5lcyBjaGVja2VkCgpQYXRjaCA2LzEyIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo3LzEyIENoZWNraW5nIGNvbW1pdCA3ZDI2OTlmNTVkZDIg
KGV4ZWM6IFJlc3RyaWN0IFRBUkdFVF9QQUdFX0JJVFNfVkFSWSBhc3NlcnQgdG8gQ09ORklHX0RF
QlVHX1RDRykKOC8xMiBDaGVja2luZyBjb21taXQgNGNlMjNkMDJhMjM4IChleGVjOiBQcm9tb3Rl
IFRBUkdFVF9QQUdFX01BU0sgdG8gdGFyZ2V0X2xvbmcpCjkvMTIgQ2hlY2tpbmcgY29tbWl0IGQy
YjhjYmQ5MTU3MiAoZXhlYzogQ2FjaGUgVEFSR0VUX1BBR0VfTUFTSyBmb3IgVEFSR0VUX1BBR0Vf
QklUU19WQVJZKQoxMC8xMiBDaGVja2luZyBjb21taXQgOTBjM2ViYTM0ZjVmIChjcHV0bGI6IEZp
eCB0bGJfdmFkZHJfdG9faG9zdCkKMTEvMTIgQ2hlY2tpbmcgY29tbWl0IGNlNjYzYjI4MWM3OCAo
dHJhbnNsYXRlLWFsbDogZml4IHVuaW5pdGlhbGl6ZWQgdGItPm9yaWdfdGIpCjEyLzEyIENoZWNr
aW5nIGNvbW1pdCBkZGRkMmM5NDJkZDUgKHRyYW5zbGF0ZS1hbGw6IFJlbW92ZSB0Yl9hbGxvYykK
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEw
MjgxNDU5MzcuMTA5MTQtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hl
Y2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


