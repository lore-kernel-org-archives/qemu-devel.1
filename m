Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0D9C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 22:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37BB2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 22:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37BB2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv7N5-0004I9-Vb
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 17:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iv7M8-0003St-HQ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iv7M7-0003Oq-9U
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:23:12 -0500
Resent-Date: Fri, 24 Jan 2020 17:23:12 -0500
Resent-Message-Id: <E1iv7M7-0003Oq-9U@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iv7M4-0003GH-5p; Fri, 24 Jan 2020 17:23:08 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579904570258141.05250948820458;
 Fri, 24 Jan 2020 14:22:50 -0800 (PST)
In-Reply-To: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
Subject: Re: [PATCH v6 0/2] Use DIAG318 to set Control Program Name & Version
 Codes
Message-ID: <157990456907.23531.2021083132985220689@f6d1ed32ca6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: walling@linux.ibm.com
Date: Fri, 24 Jan 2020 14:22:50 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc5OTA0MDQ0LTIwNzkwLTEt
Z2l0LXNlbmQtZW1haWwtd2FsbGluZ0BsaW51eC5pYm0uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVs
b3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMTU3OTkw
NDA0NC0yMDc5MC0xLWdpdC1zZW5kLWVtYWlsLXdhbGxpbmdAbGludXguaWJtLmNvbQpTdWJqZWN0
OiBbUEFUQ0ggdjYgMC8yXSBVc2UgRElBRzMxOCB0byBzZXQgQ29udHJvbCBQcm9ncmFtIE5hbWUg
JiBWZXJzaW9uIENvZGVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdp
dCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBk
YXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBz
Oi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBw
YXRjaGV3LzE1Nzk5MDQwNDQtMjA3OTAtMS1naXQtc2VuZC1lbWFpbC13YWxsaW5nQGxpbnV4Lmli
bS5jb20gLT4gcGF0Y2hldy8xNTc5OTA0MDQ0LTIwNzkwLTEtZ2l0LXNlbmQtZW1haWwtd2FsbGlu
Z0BsaW51eC5pYm0uY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYmYzOWM4MiBz
MzkwOiBkaWFnbm9zZSAzMTggaW5mbyByZXNldCBhbmQgbWlncmF0aW9uIHN1cHBvcnQKN2E1ZmYz
NCBzMzkwL2t2bTogaGVhZGVyIHN5bmMgZm9yIGRpYWczMTgKCj09PSBPVVRQVVQgQkVHSU4gPT09
CjEvMiBDaGVja2luZyBjb21taXQgN2E1ZmYzNGQ5M2MxIChzMzkwL2t2bTogaGVhZGVyIHN5bmMg
Zm9yIGRpYWczMTgpCjIvMiBDaGVja2luZyBjb21taXQgYmYzOWM4MjExZjgzIChzMzkwOiBkaWFn
bm9zZSAzMTggaW5mbyByZXNldCBhbmQgbWlncmF0aW9uIHN1cHBvcnQpCldBUk5JTkc6IGFkZGVk
LCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGlu
Zz8KIzM4OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vz
c2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzY0OiBGSUxFOiBody9zMzkweC9k
aWFnMzE4LmM6MjI6CisgICAgaWYgKGt2bV9lbmFibGVkKCkpClsuLi5dCgpFUlJPUjogYnJhY2Vz
IHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiM3NDogRklM
RTogaHcvczM5MHgvZGlhZzMxOC5jOjMyOgorICAgIGlmIChrdm1fZW5hYmxlZCgpKQpbLi4uXQoK
RVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRl
bWVudAojMTAwOiBGSUxFOiBody9zMzkweC9kaWFnMzE4LmM6NTg6CisgICAgaWYgKGt2bV9lbmFi
bGVkKCkpClsuLi5dCgpFUlJPUjogYWRkaW5nIGEgbGluZSB3aXRob3V0IG5ld2xpbmUgYXQgZW5k
IG9mIGZpbGUKIzE3MzogRklMRTogaHcvczM5MHgvZGlhZzMxOC5oOjQwOgorI2VuZGlmIC8qIEhX
X0RJQUczMThfSCAqLwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzMxNDogRklM
RTogdGFyZ2V0L3MzOTB4L2NwdV9mZWF0dXJlc19kZWYuaW5jLmg6MTI0OgorREVGX0ZFQVQoRElB
RzMxOCwgImRpYWczMTgiLCBTQ0xQX0JZVEVfMTM0LCAwLCAiQ29udHJvbCBwcm9ncmFtIG5hbWUg
YW5kIHZlcnNpb24gY29kZXMiKQoKdG90YWw6IDQgZXJyb3JzLCAyIHdhcm5pbmdzLCAzMTAgbGlu
ZXMgY2hlY2tlZAoKUGF0Y2ggMi8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VU
UFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTc5OTA0MDQ0LTIw
NzkwLTEtZ2l0LXNlbmQtZW1haWwtd2FsbGluZ0BsaW51eC5pYm0uY29tL3Rlc3RpbmcuY2hlY2tw
YXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

