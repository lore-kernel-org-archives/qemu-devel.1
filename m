Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F857C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DF322CF8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DF322CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i35iv-0008Qq-Ec
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 17:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i35i5-0007xR-UZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i35i4-0003pX-AO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:42:33 -0400
Resent-Date: Wed, 28 Aug 2019 17:42:33 -0400
Resent-Message-Id: <E1i35i4-0003pX-AO@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i35i4-0003pN-5O
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:42:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1567028546; cv=none; d=zoho.com; s=zohoarc; 
 b=Dh0Hwms7mec7ZBxg+bUJE+hUS2Hq7Q3qNwZcoajBbkj4xid1sVJq1XH2WA3swMyiYjm6NCeGQobazojNWGAPIxYdLFtAM1rBogH8nz7j9AxUzJ4X/kHrbds1gEvFa2+LVdtzndZ2IudEGOSlQuXpHdyYA3Jj5R/vOR94m4eXgfc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1567028546;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=/RBVGpqS2D5B8rbpTqD4mEkGZYsdJS4oCr43z3B1hcM=; 
 b=WgWBQD5Pqf50wgVdh0BzuxbuH7N/sgALWhD0pcRQW3Id+p9IgMg56q6EpFA/RrZJ3VeoEEOMA65sq2ZLFjDVZrdM1Vy/A/0178lxCeQxf+mWvNEVZ/MFf4iOHt+rbaAorbuGQTwpai/KauJNxON4e4CRjX1g5MrSvjQKpSE+yek=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1567028545329832.4630157284366;
 Wed, 28 Aug 2019 14:42:25 -0700 (PDT)
In-Reply-To: <20190828202641.24752-1-armbru@redhat.com>
Message-ID: <156702854444.27053.5959737036943166523@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Wed, 28 Aug 2019 14:42:25 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH 0/9] qapi: Schema language cleanups & doc
 improvements
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgyODIwMjY0MS4yNDc1
Mi0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIDAvOV0gcWFwaTogU2NoZW1h
IGxhbmd1YWdlIGNsZWFudXBzICYgZG9jIGltcHJvdmVtZW50cwpNZXNzYWdlLWlkOiAyMDE5MDgy
ODIwMjY0MS4yNDc1Mi0xLWFybWJydUByZWRoYXQuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0
ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpkMjdj
YzI5IGRvY3MvZGV2ZWwvcWFwaS1jb2RlLWdlbjogSW1wcm92ZSBRQVBJIHNjaGVtYSBsYW5ndWFn
ZSBkb2MKNzIzOTdmNiBkb2NzL2RldmVsL3FhcGktY29kZS1nZW46IFJld3JpdGUgaW50cm9kdWN0
aW9uIHRvIHNjaGVtYQo2MmIwMmZiIGRvY3MvZGV2ZWwvcWFwaS1jb2RlLWdlbjogUmV3cml0ZSBj
b21wYXRpYmlsaXR5IGNvbnNpZGVyYXRpb25zCjk3YmYyM2YgZG9jcy9kZXZlbC9xYXBpLWNvZGUt
Z2VuOiBSZW9yZGVyIHNlY3Rpb25zIGZvciByZWFkYWJpbGl0eQpkZmQxM2UyIHRlc3RzL3FhcGkt
c2NoZW1hOiBDb25zaXN0ZW50bHkgbmFtZSBzdHJpbmcgdGVzdHMgc3RyaW5nLUZPTwo1ZTIxYzNi
IHFhcGk6IE91dGxhdyBjb250cm9sIGNoYXJhY3RlcnMgaW4gc3RyaW5ncwoxY2QzNGY4IGRvY3Mv
ZGV2ZWwvcWFwaS1jb2RlLWdlbjogTWlub3Igc3BlY2lmaWNhdGlvbiBmaXhlcwphYjZhYjI5IHFh
cGk6IERyb3Agc3VwcG9ydCBmb3IgYm94ZWQgYWx0ZXJuYXRlIGZvciBjb21tYW5kcywgZXZlbnRz
CjI5ZGYzYTUgcWFwaTogRHJvcCBjaGVja190eXBlKCkncyByZWR1bmRhbnQgcGFyYW1ldGVyIEBh
bGxvd19vcHRpb25hbAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS85IENoZWNraW5nIGNvbW1pdCAy
OWRmM2E1NGU1M2UgKHFhcGk6IERyb3AgY2hlY2tfdHlwZSgpJ3MgcmVkdW5kYW50IHBhcmFtZXRl
ciBAYWxsb3dfb3B0aW9uYWwpCjIvOSBDaGVja2luZyBjb21taXQgYWI2YWIyOWQ4MGUwIChxYXBp
OiBEcm9wIHN1cHBvcnQgZm9yIGJveGVkIGFsdGVybmF0ZSBmb3IgY29tbWFuZHMsIGV2ZW50cykK
My85IENoZWNraW5nIGNvbW1pdCAxY2QzNGY4Y2JkMGUgKGRvY3MvZGV2ZWwvcWFwaS1jb2RlLWdl
bjogTWlub3Igc3BlY2lmaWNhdGlvbiBmaXhlcykKNC85IENoZWNraW5nIGNvbW1pdCA1ZTIxYzNi
YmM2ZDMgKHFhcGk6IE91dGxhdyBjb250cm9sIGNoYXJhY3RlcnMgaW4gc3RyaW5ncykKV0FSTklO
RzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVk
IHVwZGF0aW5nPwojNTI6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IEludmFsaWQgVVRG
LTgsIHBhdGNoIGFuZCBjb21taXQgbWVzc2FnZSBzaG91bGQgYmUgZW5jb2RlZCBpbiBVVEYtOAoj
NzI6IEZJTEU6IHRlc3RzL3FhcGktc2NoZW1hL3N0cmluZy1jb250cm9sLmpzb246MjoKK3sgJ2Nv
bW1hbmQnOiAn4oymCuKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gAonIH0KICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCAyMCBs
aW5lcyBjaGVja2VkCgpQYXRjaCA0LzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjUvOSBD
aGVja2luZyBjb21taXQgZGZkMTNlMmIzZGVjICh0ZXN0cy9xYXBpLXNjaGVtYTogQ29uc2lzdGVu
dGx5IG5hbWUgc3RyaW5nIHRlc3RzIHN0cmluZy1GT08pCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBv
ciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzMzOiAK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMTggbGlu
ZXMgY2hlY2tlZAoKUGF0Y2ggNS85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjYvOSBDaGVj
a2luZyBjb21taXQgOTdiZjIzZmQ5YTBkIChkb2NzL2RldmVsL3FhcGktY29kZS1nZW46IFJlb3Jk
ZXIgc2VjdGlvbnMgZm9yIHJlYWRhYmlsaXR5KQo3LzkgQ2hlY2tpbmcgY29tbWl0IDYyYjAyZmI3
YTY3NSAoZG9jcy9kZXZlbC9xYXBpLWNvZGUtZ2VuOiBSZXdyaXRlIGNvbXBhdGliaWxpdHkgY29u
c2lkZXJhdGlvbnMpCjgvOSBDaGVja2luZyBjb21taXQgNzIzOTdmNjMzNWQ4IChkb2NzL2RldmVs
L3FhcGktY29kZS1nZW46IFJld3JpdGUgaW50cm9kdWN0aW9uIHRvIHNjaGVtYSkKOS85IENoZWNr
aW5nIGNvbW1pdCBkMjdjYzI5MjgyNmUgKGRvY3MvZGV2ZWwvcWFwaS1jb2RlLWdlbjogSW1wcm92
ZSBRQVBJIHNjaGVtYSBsYW5ndWFnZSBkb2MpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwODI4MjAyNjQxLjI0NzUyLTEtYXJtYnJ1QHJlZGhh
dC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


