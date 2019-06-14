Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA2CC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1154E21841
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1154E21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53292 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbp2q-0004wn-2B
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 12:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34528)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hboec-0002Dp-Oc
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hboeb-0000nX-2w
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:02:14 -0400
Resent-Date: Fri, 14 Jun 2019 12:02:14 -0400
Resent-Message-Id: <E1hboeb-0000nX-2w@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hboea-0000l5-QN
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:02:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560528117; cv=none; d=zoho.com; s=zohoarc; 
 b=GeBWEH5EBN5AuTso3VTHFgRiz9qNupcvsk34qiC+O8PWdV5HPYizUJeMQTkp2Jb8cbQfeM4WuquWu0xx0loY/pYMcECbrnTRD5emGwrZO6805YKJGcUtfWB7h2g1O4h0dlW0MMm+Dh7grW10jXsO83aX6JYNEYXeo2wJKe1duSg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560528117;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=EkgdUK0YZ+a72KheBNp24F9xQdtwpNihfwpwhsrIYVo=; 
 b=dT1cbHfdwRnF6riETBHPo/lRgjsPxBd4YNZ2MuaGfCWxpqNRFFJh+ejJiCWhPxUbxs3R9bUo/VNpOC1Kk85BS6rODK5/2SKA9P2uOOw28lE2FVtW0nWIRXCR7JA/iNCsxSBkAtlRVz4mZfczpdGtWS1vtS/ZgSGHPpWlLevUJBM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560528115021709.1258138890714;
 Fri, 14 Jun 2019 09:01:55 -0700 (PDT)
In-Reply-To: <20190614135332.12777-1-vandersonmr2@gmail.com>
Message-ID: <156052811424.13573.5259552275497724156@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vandersonmr2@gmail.com
Date: Fri, 14 Jun 2019 09:01:55 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/3] Collecting TB Execution Frequency
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxNDEzNTMzMi4xMjc3
Ny0xLXZhbmRlcnNvbm1yMkBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggMC8zXSBDb2xsZWN0
aW5nIFRCIEV4ZWN1dGlvbiBGcmVxdWVuY3kKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkw
NjE0MTM1MzMyLjEyNzc3LTEtdmFuZGVyc29ubXIyQGdtYWlsLmNvbQoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwg
ZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRo
bSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3Fl
bXUKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8xNTU5MTI1NDg0NjMuMjAxOTAwNC4zNTE1
ODMwMzA1Mjk5ODA5OTAyLnN0Z2l0QGJhaGlhLmxhbiAtPiBwYXRjaGV3LzE1NTkxMjU0ODQ2My4y
MDE5MDA0LjM1MTU4MzAzMDUyOTk4MDk5MDIuc3RnaXRAYmFoaWEubGFuCiAtIFt0YWcgdXBkYXRl
XSAgICAgIHBhdGNoZXcvMTU2MDUxNzc0Mjc2LjI0NDg5MC44NjYwMjc3MjgwMTQ1NDY2Mzk2LnN0
Z2l0QGJhaGlhLmxhbiAtPiBwYXRjaGV3LzE1NjA1MTc3NDI3Ni4yNDQ4OTAuODY2MDI3NzI4MDE0
NTQ2NjM5Ni5zdGdpdEBiYWhpYS5sYW4KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2
NTEyMzg3IEFkZGluZyBjb21tYW5kIGxpbmUgb3B0aW9uIHRvIGxpbnV4LXVzZXIuCmFmNTJlZmQg
U2F2aW5nIGNvdW50ZXJzIGJldHdlZW4gdGJfZmx1c2ggZXZlbnRzLgo5MDZjOGVmIEFkZGluZyBh
biBvcHRpb25hbCB0YiBleGVjdXRpb24gY291bnRlci4KCj09PSBPVVRQVVQgQkVHSU4gPT09CjEv
MyBDaGVja2luZyBjb21taXQgOTA2YzhlZjkyYWFjIChBZGRpbmcgYW4gb3B0aW9uYWwgdGIgZXhl
Y3V0aW9uIGNvdW50ZXIuKQpFUlJPUjogIihmb28qKSIgc2hvdWxkIGJlICIoZm9vICopIgojMjQ6
IEZJTEU6IGFjY2VsL3RjZy90Y2ctcnVudGltZS5jOjE3MzoKKyAgICBUcmFuc2xhdGlvbkJsb2Nr
KiB0YiA9IChUcmFuc2xhdGlvbkJsb2NrKikgcHRyOwoKRVJST1I6IGRvIG5vdCBpbml0aWFsaXNl
IGdsb2JhbHMgdG8gMCBvciBOVUxMCiM4MzogRklMRTogbGludXgtdXNlci9tYWluLmM6NjE6Citi
b29sIGVuYWJsZV9mcmVxX2NvdW50ID0gZmFsc2U7CgpFUlJPUjogZG8gbm90IGluaXRpYWxpc2Ug
Z2xvYmFscyB0byAwIG9yIE5VTEwKIzk1OiBGSUxFOiB2bC5jOjE5MzoKK2Jvb2wgZW5hYmxlX2Zy
ZXFfY291bnQgPSBmYWxzZTsKCnRvdGFsOiAzIGVycm9ycywgMCB3YXJuaW5ncywgNTYgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggMS8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzMgQ2hlY2tp
bmcgY29tbWl0IGFmNTJlZmQ3ODQyZCAoU2F2aW5nIGNvdW50ZXJzIGJldHdlZW4gdGJfZmx1c2gg
ZXZlbnRzLikKRVJST1I6ICJmb28qIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKIzIyOiBGSUxF
OiBhY2NlbC90Y2cvdHJhbnNsYXRlLWFsbC5jOjExMjE6CitzdGF0aWMgYm9vbCBzdGF0aXN0aWNz
X2NtcChjb25zdCB2b2lkKiBhcCwgY29uc3Qgdm9pZCAqYnApIHsKCkVSUk9SOiBvcGVuIGJyYWNl
ICd7JyBmb2xsb3dpbmcgZnVuY3Rpb24gZGVjbGFyYXRpb25zIGdvIG9uIHRoZSBuZXh0IGxpbmUK
IzIyOiBGSUxFOiBhY2NlbC90Y2cvdHJhbnNsYXRlLWFsbC5jOjExMjE6CitzdGF0aWMgYm9vbCBz
dGF0aXN0aWNzX2NtcChjb25zdCB2b2lkKiBhcCwgY29uc3Qgdm9pZCAqYnApIHsKCkVSUk9SOiBs
aW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMzU6IEZJTEU6IGFjY2VsL3RjZy90cmFuc2xhdGUtYWxs
LmM6MTE0NjoKKyAgICBxaHRfaW5pdCgmdGJfY3R4LnRiX3N0YXRpc3RpY3MsIHN0YXRpc3RpY3Nf
Y21wLCBDT0RFX0dFTl9IVEFCTEVfU0laRSwgUUhUX01PREVfQVVUT19SRVNJWkUpOwoKRVJST1I6
ICIoZm9vKikiIHNob3VsZCBiZSAiKGZvbyAqKSIKIzcwOiBGSUxFOiBhY2NlbC90Y2cvdHJhbnNs
YXRlLWFsbC5jOjEyNjU6CisgICAgdWludDY0X3QgZXhlY19mcmVxID0gdGJfZ2V0X2FuZF9yZXNl
dF9leGVjX2ZyZXEoKFRyYW5zbGF0aW9uQmxvY2sqKSBwKTsKCkVSUk9SOiAiKGZvbyopIiBzaG91
bGQgYmUgIihmb28gKikiCiMxOTA6IEZJTEU6IGluY2x1ZGUvcW9tL2NwdS5oOjQ3NzoKK3VpbnQ2
NF90IHRiX2dldF9hbmRfcmVzZXRfZXhlY19mcmVxKHN0cnVjdCBUcmFuc2xhdGlvbkJsb2NrKik7
Cgp0b3RhbDogNSBlcnJvcnMsIDAgd2FybmluZ3MsIDE0NiBsaW5lcyBjaGVja2VkCgpQYXRjaCAy
LzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvMyBDaGVja2luZyBjb21taXQgNjUxMjM4
NzkzNDczIChBZGRpbmcgY29tbWFuZCBsaW5lIG9wdGlvbiB0byBsaW51eC11c2VyLikKRVJST1I6
IGV4dGVybnMgc2hvdWxkIGJlIGF2b2lkZWQgaW4gLmMgZmlsZXMKIzIyOiBGSUxFOiBsaW51eC11
c2VyL2V4aXQuYzoyOToKK2V4dGVybiBib29sIGVuYWJsZV9mcmVxX2NvdW50OwoKdG90YWw6IDEg
ZXJyb3JzLCAwIHdhcm5pbmdzLCAzMiBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzMgaGFzIHN0eWxl
IHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFs
c2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRD
SCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTkwNjE0MTM1MzMyLjEyNzc3LTEtdmFuZGVyc29ubXIyQGdtYWlsLmNv
bS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


