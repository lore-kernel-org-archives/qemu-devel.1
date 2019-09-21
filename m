Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F61C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 00:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A06A217F5
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 00:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A06A217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBTL6-0001ND-DF
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 20:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iBTKM-0000mc-Un
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 20:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iBTKK-0005UW-Fm
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 20:32:42 -0400
Resent-Date: Fri, 20 Sep 2019 20:32:41 -0400
Resent-Message-Id: <E1iBTKK-0005UW-Fm@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iBTKI-0005S2-Rv
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 20:32:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569025934; cv=none; d=zoho.com; s=zohoarc; 
 b=l2MRQ4kcOdgkSsVv6KQjtBFO/geH+/zOccidzjMO0L3kRNDmpkpYGeT7Rm/t6YMR9IIhSa+XoMyHZTTL3AIeic2FjDqldbFPRplapQqn0e7bLelZexBqWq52Z1SeskJAMwUL7ZaIaDbs92JzD/XTGDJawKsziRDo5OZy+/hSzQg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569025934;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=YuQsxDU/dTJ0+ydeSr8QwFijWqhq5NgGeA8/x/CYSsQ=; 
 b=NqUwvhMkqosJ0tjsurT6hwo+o+D5ohiy52mx+4NphwOr+fJOhjWlafCrNc/3y3BwAo5b2k8N9pWYlWWdwdQM2WUlTSqEYUcuRj4BFa7NKKcEkeEdAIGqWcA79evh37bdxa7A4dfZeAI8mF6nfTDVA0w4MqRv5/sY7E1VbYXqIqY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569025934361700.822255519181;
 Fri, 20 Sep 2019 17:32:14 -0700 (PDT)
In-Reply-To: <20190919232952.6382-1-richard.henderson@linaro.org>
Subject: Re: [PATCH 0/7] exec: Improve code for TARGET_PAGE_BITS_VARY
Message-ID: <156902593306.6626.11430974802573169377@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Fri, 20 Sep 2019 17:32:14 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxOTIzMjk1Mi42Mzgy
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA5MTkyMzI5NTIuNjM4Mi0xLXJp
Y2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3ViamVjdDogW1BBVENIIDAvN10gZXhlYzogSW1w
cm92ZSBjb2RlIGZvciBUQVJHRVRfUEFHRV9CSVRTX1ZBUlkKVHlwZTogc2VyaWVzCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYv
bnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0
Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE5MDkxOTIz
Mjk1Mi42MzgyLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZyAtPiBwYXRjaGV3LzIwMTkw
OTE5MjMyOTUyLjYzODItMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnClN3aXRjaGVkIHRv
IGEgbmV3IGJyYW5jaCAndGVzdCcKMDJiNWRhMSBleGVjOiBDYWNoZSBUQVJHRVRfUEFHRV9NQVNL
IGZvciBUQVJHRVRfUEFHRV9CSVRTX1ZBUlkKYTdhY2E3OCBleGVjOiBUaWR5IFRBUkdFVF9QQUdF
X0FMSUdOCmRhZWNjYjAgZXhlYzogUHJvbW90ZSBUQVJHRVRfUEFHRV9NQVNLIHRvIHRhcmdldF9s
b25nCjI2NWVlYzcgZXhlYzogUmVzdHJpY3QgVEFSR0VUX1BBR0VfQklUU19WQVJZIGFzc2VydCB0
byBDT05GSUdfREVCVUdfVENHCjU4M2E3ZWQgZXhlYzogVXNlIGNvbnN0IGFsaWFzIGZvciBUQVJH
RVRfUEFHRV9CSVRTX1ZBUlkKYTJkZDc4OCBleGVjOiBTcGxpdCBvdXQgdmFyaWFibGUgcGFnZSBz
aXplIHN1cHBvcnQgdG8gZXhlYy12YXJ5LmMKY2M0OWM4NCBleGVjOiBVc2UgVEFSR0VUX1BBR0Vf
QklUU19NSU4gZm9yIFRMQiBmbGFncwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS83IENoZWNraW5n
IGNvbW1pdCBjYzQ5Yzg0N2ZmNDUgKGV4ZWM6IFVzZSBUQVJHRVRfUEFHRV9CSVRTX01JTiBmb3Ig
VExCIGZsYWdzKQoyLzcgQ2hlY2tpbmcgY29tbWl0IGEyZGQ3ODhkMDc0ZiAoZXhlYzogU3BsaXQg
b3V0IHZhcmlhYmxlIHBhZ2Ugc2l6ZSBzdXBwb3J0IHRvIGV4ZWMtdmFyeS5jKQpXQVJOSU5HOiBh
ZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBk
YXRpbmc/CiMzMjogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2Fy
bmluZ3MsIDEyNSBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzcgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KMy83IENoZWNraW5nIGNvbW1pdCA1ODNhN2VkYTRmOWUgKGV4ZWM6IFVzZSBjb25zdCBh
bGlhcyBmb3IgVEFSR0VUX1BBR0VfQklUU19WQVJZKQpFUlJPUjogZXh0ZXJucyBzaG91bGQgYmUg
YXZvaWRlZCBpbiAuYyBmaWxlcwojNTg6IEZJTEU6IGV4ZWMtdmFyeS5jOjUzOgorZXh0ZXJuIGNv
bnN0IFRhcmdldFBhZ2VCaXRzIHRhcmdldF9wYWdlCgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDgyIGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvNyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKNC83IENoZWNraW5nIGNvbW1pdCAyNjVlZWM3YTRmOTMgKGV4ZWM6IFJlc3RyaWN0IFRBUkdF
VF9QQUdFX0JJVFNfVkFSWSBhc3NlcnQgdG8gQ09ORklHX0RFQlVHX1RDRykKNS83IENoZWNraW5n
IGNvbW1pdCBkYWVjY2IwNTAwMzMgKGV4ZWM6IFByb21vdGUgVEFSR0VUX1BBR0VfTUFTSyB0byB0
YXJnZXRfbG9uZykKNi83IENoZWNraW5nIGNvbW1pdCBhN2FjYTc4YjIxYjcgKGV4ZWM6IFRpZHkg
VEFSR0VUX1BBR0VfQUxJR04pCjcvNyBDaGVja2luZyBjb21taXQgMDJiNWRhMTI1OTM3IChleGVj
OiBDYWNoZSBUQVJHRVRfUEFHRV9NQVNLIGZvciBUQVJHRVRfUEFHRV9CSVRTX1ZBUlkpCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTE5MjMy
OTUyLjYzODItMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRj
aC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


