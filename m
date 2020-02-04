Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC2BC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:15:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AD820661
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AD820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyx6d-0000gK-Uz
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 07:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iyx5a-0007rG-9y
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iyx5Y-0006ji-CG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:13:57 -0500
Resent-Date: Tue, 04 Feb 2020 07:13:57 -0500
Resent-Message-Id: <E1iyx5Y-0006ji-CG@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iyx5Y-0006gf-6L
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:13:56 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580818424825496.7261893450981;
 Tue, 4 Feb 2020 04:13:44 -0800 (PST)
In-Reply-To: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
Subject: Re: [RFC 0/9] Add an interVM memory sharing device
Message-ID: <158081842361.23546.14305636991137403098@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: i.kotrasinsk@partner.samsung.com
Date: Tue, 4 Feb 2020 04:13:44 -0800 (PST)
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
Cc: peter.maydell@linaro.org, i.kotrasinsk@partner.samsung.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTgwODE1ODUxLTI4ODg3LTEt
Z2l0LXNlbmQtZW1haWwtaS5rb3RyYXNpbnNrQHBhcnRuZXIuc2Ftc3VuZy5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2Vl
IG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtSRkMgMC85XSBB
ZGQgYW4gaW50ZXJWTSBtZW1vcnkgc2hhcmluZyBkZXZpY2UKTWVzc2FnZS1pZDogMTU4MDgxNTg1
MS0yODg4Ny0xLWdpdC1zZW5kLWVtYWlsLWkua290cmFzaW5za0BwYXJ0bmVyLnNhbXN1bmcuY29t
ClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQg
cmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0
aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczov
L2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0
Y2hldy8yMDIwMDIwNDEwNTE0Mi4yMTg0NS0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcgLT4gcGF0
Y2hldy8yMDIwMDIwNDEwNTE0Mi4yMTg0NS0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcKIC0gW3Rh
ZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDIwNDExMDUwMS4xMDczMS0xLWRnaWxiZXJ0QHJl
ZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDIwNDExMDUwMS4xMDczMS0xLWRnaWxiZXJ0QHJlZGhh
dC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0YjJmN2IxIGh3L2FybS92aXJ0
OiBIYWNrIGluIHN1cHBvcnQgZm9yIG1lbWV4cG9zZSBkZXZpY2UKYmVhNGZhZiBody9taXNjL21l
bWV4cG9zZTogQWRkIHNpbXBsZSB0ZXN0cwpiOWE1M2ZjIGh3L21pc2MvbWVtZXhwb3NlOiBBZGQg
bWVtZXhwb3NlIG1lbW9yeSByZWdpb24gZGV2aWNlCjhkMmM2NGYgaHcvbWlzYy9tZW1leHBvc2U6
IEFkZCBtZW1leHBvc2UgcGNpIGRldmljZQo2YTZkNDVhIGh3L21pc2MvbWVtZXhwb3NlOiBBZGQg
Y29yZSBtZW1leHBvc2UgZmlsZXMKYzM1YWVmNyBody9taXNjL21lbWV4cG9zZTogQWRkIGRvY3Vt
ZW50YXRpb24KZDZlNzE2OSBtZW1vcnk6IEhhY2sgLSB1c2Ugc2hhcmVkIG1lbW9yeSB3aGVuIHBv
c3NpYmxlCjZmNmEzMzcgbWVtb3J5OiBTdXBwb3J0IG1tYXAgb2Zmc2V0IGZvciBmZC1iYWNrZWQg
bWVtb3J5IHJlZ2lvbnMKZmU1MTVhOSBtZW1vcnk6IEFkZCBmdW5jdGlvbiBmb3IgZmluZGluZyBm
bGF0IG1lbW9yeSByYW5nZXMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvOSBDaGVja2luZyBjb21t
aXQgZmU1MTVhOTM3Zjg5IChtZW1vcnk6IEFkZCBmdW5jdGlvbiBmb3IgZmluZGluZyBmbGF0IG1l
bW9yeSByYW5nZXMpCjIvOSBDaGVja2luZyBjb21taXQgNmY2YTMzN2I4ZTk0IChtZW1vcnk6IFN1
cHBvcnQgbW1hcCBvZmZzZXQgZm9yIGZkLWJhY2tlZCBtZW1vcnkgcmVnaW9ucykKMy85IENoZWNr
aW5nIGNvbW1pdCBkNmU3MTY5OTNiZTggKG1lbW9yeTogSGFjayAtIHVzZSBzaGFyZWQgbWVtb3J5
IHdoZW4gcG9zc2libGUpCjQvOSBDaGVja2luZyBjb21taXQgYzM1YWVmNzdlYzcxIChody9taXNj
L21lbWV4cG9zZTogQWRkIGRvY3VtZW50YXRpb24pCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBk
ZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzExOiAKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiBjb2RlIGJsb2NrcyBpbiBkb2N1bWVudGF0aW9uIHNo
b3VsZCBoYXZlIGVtcHR5IGxpbmVzIHdpdGggZXhhY3RseSA0IGNvbHVtbnMgb2Ygd2hpdGVzcGFj
ZQojNDU6IEZJTEU6IGRvY3Mvc3BlY3MvbWVtZXhwb3NlLXNwZWMudHh0OjMwOgorICQKCnRvdGFs
OiAxIGVycm9ycywgMSB3YXJuaW5ncywgMTY4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvOSBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoKNS85IENoZWNraW5nIGNvbW1pdCA2YTZkNDVhMTViNDMg
KGh3L21pc2MvbWVtZXhwb3NlOiBBZGQgY29yZSBtZW1leHBvc2UgZmlsZXMpCldBUk5JTkc6IGFk
ZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRh
dGluZz8KIzExNTogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2Fy
bmluZ3MsIDEyMzUgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNS85IGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCjYvOSBDaGVja2luZyBjb21taXQgOGQyYzY0ZjI3M2EzIChody9taXNjL21lbWV4cG9z
ZTogQWRkIG1lbWV4cG9zZSBwY2kgZGV2aWNlKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVs
ZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMzMTogCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDIyOCBsaW5lcyBj
aGVja2VkCgpQYXRjaCA2LzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KNy85IENoZWNraW5n
IGNvbW1pdCBiOWE1M2ZjMWVmOGIgKGh3L21pc2MvbWVtZXhwb3NlOiBBZGQgbWVtZXhwb3NlIG1l
bW9yeSByZWdpb24gZGV2aWNlKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxl
KHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMzMzogCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDE5NSBsaW5lcyBjaGVja2VkCgpQ
YXRjaCA3LzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KOC85IENoZWNraW5nIGNvbW1pdCBi
ZWE0ZmFmZjRkYTUgKGh3L21pc2MvbWVtZXhwb3NlOiBBZGQgc2ltcGxlIHRlc3RzKQpXQVJOSU5H
OiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQg
dXBkYXRpbmc/CiM0MzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEg
d2FybmluZ3MsIDM4NSBsaW5lcyBjaGVja2VkCgpQYXRjaCA4LzkgaGFzIHN0eWxlIHByb2JsZW1z
LCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRp
dmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlO
VEFJTkVSUy4KOS85IENoZWNraW5nIGNvbW1pdCA0YjJmN2IxNjU4MDAgKGh3L2FybS92aXJ0OiBI
YWNrIGluIHN1cHBvcnQgZm9yIG1lbWV4cG9zZSBkZXZpY2UpCj09PSBPVVRQVVQgRU5EID09PQoK
VGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1ODA4MTU4NTEtMjg4ODctMS1naXQtc2Vu
ZC1lbWFpbC1pLmtvdHJhc2luc2tAcGFydG5lci5zYW1zdW5nLmNvbS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

