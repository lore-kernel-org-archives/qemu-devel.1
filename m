Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F692C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 22:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59EEA2078C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 22:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59EEA2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKV8J-0002r5-GE
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 18:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jKV7k-0002PG-61
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 18:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jKV7h-0004Nk-5F
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 18:49:14 -0400
Resent-Date: Fri, 03 Apr 2020 18:49:14 -0400
Resent-Message-Id: <E1jKV7h-0004Nk-5F@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jKV7g-0003zs-Vb
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 18:49:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585954142; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LbrtLXHJ/sZYP97HQpYrJuID7CuxuHtWIalcqD+KrqWFsKerdeP9C7Io96Q/RlUHG3bFVus8ikRavx8KacW5MUNChgBH5tKI/XCwyD7tI8Dl9s/xRKNUN0koTIoW8eAva2XeKxEuRF5CqfT1xxgi2tSwDdF3jcdbeUoF9nU8WrI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585954142;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qcBsVP3jzt3oudHCT1HsGmGbUpry42BGPKuXqTVxsq0=; 
 b=lx2eUgEpPyxLBdPQ8X5IySwADYJgUUvVhSWmrkYr0Hg6N+wbzqn/d2Qs0JzuU9Jr68h4ATPgg7LW53kNWH4BUxy5pF5+rf6+PzNHA/4GZs6uks4/ETXoA+B5ZbQIvSmACuz+E/xsmrfIfibH+Y2DrcMS+CWH7y2i4d7qRdLXOmQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585954139132774.3629249410648;
 Fri, 3 Apr 2020 15:48:59 -0700 (PDT)
In-Reply-To: <20200403142308.82990-1-arilou@gmail.com>
Subject: Re: [PATCH v1 0/5] hyperv: VMBus implementation
Message-ID: <158595413758.23425.5732769419120477971@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: arilou@gmail.com
Date: Fri, 3 Apr 2020 15:48:59 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: pbonzini@redhat.com, vkuznets@redhat.com, arilou@gmail.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwMzE0MjMwOC44Mjk5
MC0xLWFyaWxvdUBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MSAwLzVdIGh5cGVydjogVk1CdXMgaW1wbGVtZW50
YXRpb24KTWVzc2FnZS1pZDogMjAyMDA0MDMxNDIzMDguODI5OTAtMS1hcmlsb3VAZ21haWwuY29t
ClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQg
cmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0
aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0JwpmNzljYTJlIGkzODY6IEh5cGVyLVYgVk1CdXMgQUNQSSBEU0RU
IGVudHJ5CmQyNzE1Yjcgdm1idXM6IHZtYnVzIGltcGxlbWVudGF0aW9uCjAwZjMyOGUgdm1idXM6
IGFkZCB2bWJ1cyBwcm90b2NvbCBkZWZpbml0aW9ucwo4YTA5N2VjIGh5cGVydjogU0NvbnRyb2wg
aXMgb3B0aW9uYWwgdG8gZW5hYmxlIFN5bkljCjJkZmU0YjAgaHlwZXJ2OiBleHBvc2UgQVBJIHRv
IGRldGVybWluZSBpZiBzeW5pYyBpcyBlbmFibGVkCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzUg
Q2hlY2tpbmcgY29tbWl0IDJkZmU0YjAwOTBiZSAoaHlwZXJ2OiBleHBvc2UgQVBJIHRvIGRldGVy
bWluZSBpZiBzeW5pYyBpcyBlbmFibGVkKQoyLzUgQ2hlY2tpbmcgY29tbWl0IDhhMDk3ZWMzNjY3
ZiAoaHlwZXJ2OiBTQ29udHJvbCBpcyBvcHRpb25hbCB0byBlbmFibGUgU3luSWMpCjMvNSBDaGVj
a2luZyBjb21taXQgMDBmMzI4ZWI0MjU0ICh2bWJ1czogYWRkIHZtYnVzIHByb3RvY29sIGRlZmlu
aXRpb25zKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1B
SU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxNzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJP
UjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzEzNTogRklMRTogaW5jbHVkZS9ody92bWJ1
cy92bWJ1cy1wcm90by5oOjExNDoKKyAgICB1aW50OF90ICBtb25pdG9yX2ZsYWdzOyAgICAgIC8v
IFZNQlVTX09GRkVSX01PTklUT1JfKgoKRVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRz
CiMxMzY6IEZJTEU6IGluY2x1ZGUvaHcvdm1idXMvdm1idXMtcHJvdG8uaDoxMTU6CisgICAgdWlu
dDE2X3QgaW50ZXJydXB0X2ZsYWdzOyAgICAvLyBWTUJVU19PRkZFUl9JTlRFUlJVUFRfKgoKRVJS
T1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiMyMTM6IEZJTEU6IGluY2x1ZGUvaHcvdm1i
dXMvdm1idXMtcHJvdG8uaDoxOTI6CisgICAgdWludDMyX3QgZmVhdHVyZV9iaXRzOyAgICAgLy8g
Vk1CVVNfUklOR19CVUZGRVJfRkVBVF8qCgp0b3RhbDogMyBlcnJvcnMsIDEgd2FybmluZ3MsIDIy
MiBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2
aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0
aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQv
NSBDaGVja2luZyBjb21taXQgZDI3MTViNzg5ODIxICh2bWJ1czogdm1idXMgaW1wbGVtZW50YXRp
b24pCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRB
SU5FUlMgbmVlZCB1cGRhdGluZz8KIzEwNjogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjog
bWVtb3J5IGJhcnJpZXIgd2l0aG91dCBjb21tZW50CiM2NDU6IEZJTEU6IGh3L3ZtYnVzL3ZtYnVz
LmM6NTA1OgorICAgIHNtcF9tYigpOwoKRVJST1I6IG1lbW9yeSBiYXJyaWVyIHdpdGhvdXQgY29t
bWVudAojNzA2OiBGSUxFOiBody92bWJ1cy92bWJ1cy5jOjU2NjoKKyAgICBzbXBfbWIoKTsKCkVS
Uk9SOiAiKGZvbyopIiBzaG91bGQgYmUgIihmb28gKikiCiMxNTQ3OiBGSUxFOiBody92bWJ1cy92
bWJ1cy5jOjE0MDc6CisgICAgdm1idXNfbXNnID0gKHN0cnVjdCB2bWJ1c19tZXNzYWdlX2hlYWRl
ciopbXNnLT5wYXlsb2FkOwoKRVJST1I6ICIoZm9vKikiIHNob3VsZCBiZSAiKGZvbyAqKSIKIzIw
MzY6IEZJTEU6IGh3L3ZtYnVzL3ZtYnVzLmM6MTg5NjoKKyAgICBtc2cgPSAoc3RydWN0IHZtYnVz
X21lc3NhZ2VfaGVhZGVyKiltc2dkYXRhOwoKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGJlZm9yZSB0
aGUgb3BlbiBwYXJlbnRoZXNpcyAnKCcKIzIwODg6IEZJTEU6IGh3L3ZtYnVzL3ZtYnVzLmM6MTk0
ODoKKyAgICBzd2l0Y2godm1idXMtPnN0YXRlKSB7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hh
cmFjdGVycwojMjMyNTogRklMRTogaHcvdm1idXMvdm1idXMuYzoyMTg1OgorICAgICAgICBWTVNU
QVRFX1NUUlVDVF9WQVJSQVlfUE9JTlRFUl9VSU5UMTYoY2hhbm5lbHMsIFZNQnVzRGV2aWNlLCBu
dW1fY2hhbm5lbHMsCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4
OlZ4VikKIzI1MzI6IEZJTEU6IGh3L3ZtYnVzL3ZtYnVzLmM6MjM5MjoKKyAgICAuc3Vic2VjdGlv
bnMgPSAoY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uKltdKSB7CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiA2IGVycm9ycywgMiB3YXJuaW5ncywg
MjU4NSBsaW5lcyBjaGVja2VkCgpQYXRjaCA0LzUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
CjUvNSBDaGVja2luZyBjb21taXQgZjc5Y2EyZTQ3Y2NhIChpMzg2OiBIeXBlci1WIFZNQnVzIEFD
UEkgRFNEVCBlbnRyeSkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAyMDA0MDMxNDIzMDguODI5OTAtMS1hcmlsb3VAZ21haWwuY29tL3Rlc3Rpbmcu
Y2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

