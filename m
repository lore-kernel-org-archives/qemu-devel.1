Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD779C3B1A2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DEF24696
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DEF24696
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2dv9-0000uP-L1
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 11:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j2dua-0000MU-FS
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j2duY-0005sy-KE
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:33:52 -0500
Resent-Date: Fri, 14 Feb 2020 11:33:52 -0500
Resent-Message-Id: <E1j2duY-0005sy-KE@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j2duY-0005ni-CB; Fri, 14 Feb 2020 11:33:50 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581698019; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Tt2vyVLUIXtpS3FrBXpQGvvBlO2yWW7KalbjCTZBbawzTbRi9Zyl82CPUmjAdhZ2YF7A5UmLBZR9BMq8jKR9oXXwo8vwX9wmbmgQbLp9E02zm6D8VeHbyJNJK8nvq1G0AEyWOm7L3qPfLJ0g+nEG07UdgSba3MMjNsqb6jQ223U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581698019;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7kvmQiWNzeoUrIDiNpSi4mqAg/9mJZC+gYcSgfSQgo0=; 
 b=N1FB2U7oUH8Ak7fFuUvfIRujDZdN5ztb9P2ZGWEOamshQ0DwU2nuaz6w0rZsH+uypvFFxlQzFKUk08cKPpNh80qe3LzaRobzcECrCP/bQdgDu6UEqPTAZMakkHtM0SSu2Y/r1rUgCKceOEifO847jxGc2N8MWdZB9Ue+nU9YuRo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581698016488263.16087247005714;
 Fri, 14 Feb 2020 08:33:36 -0800 (PST)
In-Reply-To: <20200214151636.8764-1-frankja@linux.ibm.com>
Subject: Re: [PATCH v3 00/17] s390x: Protected Virtualization support
Message-ID: <158169801500.6932.5276989327268907143@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: frankja@linux.ibm.com
Date: Fri, 14 Feb 2020 08:33:36 -0800 (PST)
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxNDE1MTYzNi44NzY0
LTEtZnJhbmtqYUBsaW51eC5pYm0uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjMgMDAvMTddIHMzOTB4OiBQcm90ZWN0ZWQg
VmlydHVhbGl6YXRpb24gc3VwcG9ydApNZXNzYWdlLWlkOiAyMDIwMDIxNDE1MTYzNi44NzY0LTEt
ZnJhbmtqYUBsaW51eC5pYm0uY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4ZmZiZWJiIHMzOTB4OiBG
b3Igbm93IGFkZCB1bnBhY2sgZmVhdHVyZSB0byBHQTEKYTQ4MGJiMCBzMzkweDogcHJvdHZpcnQ6
IEhhbmRsZSBTSUdQIHN0b3JlIHN0YXR1cyBjb3JyZWN0bHkKYzUxNTdhNyBzMzkweDogcHJvdHZp
cnQ6IE1vdmUgSU8gY29udHJvbCBzdHJ1Y3R1cmVzIG92ZXIgU0lEQQpjZmE3ZWNkIHMzOTB4OiBw
cm90dmlydDogRGlzYWJsZSBhZGRyZXNzIGNoZWNrcyBmb3IgUFYgZ3Vlc3QgSU8gZW11bGF0aW9u
CjI0ZThkZGEgczM5MHg6IHByb3R2aXJ0OiBNb3ZlIGRpYWcgMzA4IGRhdGEgb3ZlciBTSURBRAox
NzMwNjA1IHMzOTB4OiBwcm90dmlydDogU2V0IGd1ZXN0IElQTCBQU1cKNDc2YjRhNCBzMzkweDog
cHJvdHZpcnQ6IFNDTFAgaW50ZXJwcmV0YXRpb24KNGEwNDM0ZCBzMzkweDogQWRkIFNJREEgbWVt
b3J5IG9wcwpmMDc3ZTU4IHMzOTA6IHByb3R2aXJ0OiBNb3ZlIFNUU0kgZGF0YSBvdmVyIFNJREFE
CmI2M2Y5MDEgczM5MHg6IHByb3R2aXJ0OiBLVk0gaW50ZXJjZXB0IGNoYW5nZXMKMTk0YjU2YyBz
MzkweDogcHJvdHZpcnQ6IEhhbmRsZSBkaWFnIDMwOCBzdWJjb2RlcyAwLDEsMyw0CjY0MjRjMDEg
czM5MHg6IHByb3R2aXJ0OiBBZGQgbWlncmF0aW9uIGJsb2NrZXIKZWY2NWYxNiBzMzkweDogcHJv
dHZpcnQ6IFN1cHBvcnQgdW5wYWNrIGZhY2lsaXR5CjQzOWM0MzkgczM5MHg6IHByb3R2aXJ0OiBB
ZGQgZGlhZzMwOCBzdWJjb2RlcyA4IC0gMTAKNGM1MGE0ZCBTeW5jIHB2CmM1ZTkzOGQgczM5MHg6
IEFkZCBtaXNzaW5nIHZjcHUgcmVzZXQgZnVuY3Rpb25zCjgyMGExYTkgSGVhZGVyIHN5bmMKCj09
PSBPVVRQVVQgQkVHSU4gPT09CjEvMTcgQ2hlY2tpbmcgY29tbWl0IDgyMGExYTlmNWMyNSAoSGVh
ZGVyIHN5bmMpCkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFsOiAx
IGVycm9ycywgMCB3YXJuaW5ncywgMTYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS8xNyBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgoKMi8xNyBDaGVja2luZyBjb21taXQgYzVlOTM4ZDczZjUzIChz
MzkweDogQWRkIG1pc3NpbmcgdmNwdSByZXNldCBmdW5jdGlvbnMpCjMvMTcgQ2hlY2tpbmcgY29t
bWl0IDRjNTBhNGQ1ZGJiOSAoU3luYyBwdikKNC8xNyBDaGVja2luZyBjb21taXQgNDM5YzQzOTUy
NmFlIChzMzkweDogcHJvdHZpcnQ6IEFkZCBkaWFnMzA4IHN1YmNvZGVzIDggLSAxMCkKNS8xNyBD
aGVja2luZyBjb21taXQgZWY2NWYxNjdhMDY1IChzMzkweDogcHJvdHZpcnQ6IFN1cHBvcnQgdW5w
YWNrIGZhY2lsaXR5KQpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1z
IG9mIHRoaXMgc3RhdGVtZW50CiM3OTogRklMRTogaHcvczM5MHgvaXBsLmM6NzA2OgorICAgICAg
ICBpZiAocmMpClsuLi5dCgpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMp
LCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxMDI6IApuZXcgZmlsZSBtb2RlIDEw
MDY0NAoKRVJST1I6ICJmb28qIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKIzEyNzogRklMRTog
aHcvczM5MHgvcHYuYzoyMToKK2NvbnN0IGNoYXIqIGNtZF9uYW1lc1tdID0gewoKRVJST1I6IHNw
YWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnOicgKGN0eDpWeFcpCiMyOTg6IEZJTEU6IGh3L3Mz
OTB4L3B2Lmg6MzI6CitpbnQgczM5MF9wdl91bnBhY2sodWludDY0X3QgYWRkciwgdWludDY0X3Qg
c2l6ZSwgdWludDY0X3QgdHdlYWspIHsgcmV0dXJuIDA6IH0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4K
CnRvdGFsOiAzIGVycm9ycywgMSB3YXJuaW5ncywgNDEwIGxpbmVzIGNoZWNrZWQKClBhdGNoIDUv
MTcgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjYvMTcgQ2hlY2tpbmcgY29tbWl0IDY0MjRj
MDE5NWYzZSAoczM5MHg6IHByb3R2aXJ0OiBBZGQgbWlncmF0aW9uIGJsb2NrZXIpCjcvMTcgQ2hl
Y2tpbmcgY29tbWl0IDE5NGI1NmM1OWQxYSAoczM5MHg6IHByb3R2aXJ0OiBIYW5kbGUgZGlhZyAz
MDggc3ViY29kZXMgMCwxLDMsNCkKOC8xNyBDaGVja2luZyBjb21taXQgYjYzZjkwMTY3YzQ2IChz
MzkweDogcHJvdHZpcnQ6IEtWTSBpbnRlcmNlcHQgY2hhbmdlcykKRVJST1I6IHN3aXRjaCBhbmQg
Y2FzZSBzaG91bGQgYmUgYXQgdGhlIHNhbWUgaW5kZW50CiM0MjogRklMRTogdGFyZ2V0L3MzOTB4
L2t2bS5jOjE2OTY6CiAgICAgc3dpdGNoIChpY3B0X2NvZGUpIHsKWy4uLl0KKyAgICAgICAgY2Fz
ZSBJQ1BUX1BWX0lOU1RSOgorICAgICAgICBjYXNlIElDUFRfUFZfSU5TVFJfTk9USUZJQ0FUSU9O
OgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNiBsaW5lcyBjaGVja2VkCgpQYXRjaCA4
LzE3IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo5LzE3IENoZWNraW5nIGNvbW1pdCBmMDc3
ZTU4MmM0YjggKHMzOTA6IHByb3R2aXJ0OiBNb3ZlIFNUU0kgZGF0YSBvdmVyIFNJREFEKQoxMC8x
NyBDaGVja2luZyBjb21taXQgNGEwNDM0ZDBhNjZiIChzMzkweDogQWRkIFNJREEgbWVtb3J5IG9w
cykKMTEvMTcgQ2hlY2tpbmcgY29tbWl0IDQ3NmI0YTQwOTY2ZCAoczM5MHg6IHByb3R2aXJ0OiBT
Q0xQIGludGVycHJldGF0aW9uKQoxMi8xNyBDaGVja2luZyBjb21taXQgMTczMDYwNTdmMWU0IChz
MzkweDogcHJvdHZpcnQ6IFNldCBndWVzdCBJUEwgUFNXKQoxMy8xNyBDaGVja2luZyBjb21taXQg
MjRlOGRkYTJiNDIyIChzMzkweDogcHJvdHZpcnQ6IE1vdmUgZGlhZyAzMDggZGF0YSBvdmVyIFNJ
REFEKQoxNC8xNyBDaGVja2luZyBjb21taXQgY2ZhN2VjZDUzNGNkIChzMzkweDogcHJvdHZpcnQ6
IERpc2FibGUgYWRkcmVzcyBjaGVja3MgZm9yIFBWIGd1ZXN0IElPIGVtdWxhdGlvbikKMTUvMTcg
Q2hlY2tpbmcgY29tbWl0IGM1MTU3YTc5YzY3NCAoczM5MHg6IHByb3R2aXJ0OiBNb3ZlIElPIGNv
bnRyb2wgc3RydWN0dXJlcyBvdmVyIFNJREEpCjE2LzE3IENoZWNraW5nIGNvbW1pdCBhNDgwYmIw
NjJjNTcgKHMzOTB4OiBwcm90dmlydDogSGFuZGxlIFNJR1Agc3RvcmUgc3RhdHVzIGNvcnJlY3Rs
eSkKMTcvMTcgQ2hlY2tpbmcgY29tbWl0IDhmZmJlYmI0M2Q1MSAoczM5MHg6IEZvciBub3cgYWRk
IHVucGFjayBmZWF0dXJlIHRvIEdBMSkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQg
ZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAyMTQxNTE2MzYuODc2NC0xLWZyYW5ramFAbGludXguaWJt
LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

