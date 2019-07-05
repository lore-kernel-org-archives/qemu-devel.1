Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A310C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 08:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCD1218BA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 08:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCD1218BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjK3C-0004uW-71
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 04:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33701)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hjK1i-0003yL-F7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 04:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hjK1c-0007hM-0T
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 04:57:02 -0400
Resent-Date: Fri, 05 Jul 2019 04:57:01 -0400
Resent-Message-Id: <E1hjK1c-0007hM-0T@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hjK1T-0007YM-D0; Fri, 05 Jul 2019 04:56:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562316971; cv=none; d=zoho.com; s=zohoarc; 
 b=ZfszsWUfnXCVtXaSIaql4ghET2CS1ANkQTcwrH42e8zp6V2Pq1sYpxqBvGfwrWXVlOwdvszgGszwvVD/R9T9zsgW/CJREYmBm456iH86bZlOEn3mCASIm6hJ31R4IlQXbw6k+2qlVo6kLP4nZxefbOYJ9zipIs+J/9Wzza97VFM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562316971;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=RicTqFJAQXdNW3nyWL5a8Jo6psVcU6usJ4YFk+VRuE4=; 
 b=BOkKRw8WWMoYGf6H4O3BxB+4ZW/NLK3voqko34RX0Vp4ahKnUpeYWokxSBUHKNnTRive/xJajr+9owgffdqhr4VtgEY0rlHxTZVb1twcMYehQCtCZGSIU1W7MafxmjwExG0uswwZvkWgNOf25DEnedqXtmmwvRpU29pIor7ecP4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562316970204954.057136241254;
 Fri, 5 Jul 2019 01:56:10 -0700 (PDT)
Message-ID: <156231696891.2067.8881453516176970028@c4a48874b076>
In-Reply-To: <20190705072333.17171-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: klaus@birkelund.eu
Date: Fri, 5 Jul 2019 01:56:10 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH 00/16] nvme: support NVMe v1.3d,
 SGLs and multiple namespaces
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, matt.fitzpatrick@oakgatetech.com,
 qemu-devel@nongnu.org, armbru@redhat.com, keith.busch@intel.com,
 mreitz@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwNTA3MjMzMy4xNzE3
MS0xLWtsYXVzQGJpcmtlbHVuZC5ldS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggMDAv
MTZdIG52bWU6IHN1cHBvcnQgTlZNZSB2MS4zZCwgU0dMcyBhbmQgbXVsdGlwbGUgbmFtZXNwYWNl
cwpNZXNzYWdlLWlkOiAyMDE5MDcwNTA3MjMzMy4xNzE3MS0xLWtsYXVzQGJpcmtlbHVuZC5ldQoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2Ug
PiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWls
YmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKYWVkODJlNiBudm1lOiBzdXBwb3J0IG11bHRpcGxlIG5hbWVzcGFjZXMKMTI0
YWJhNSBudm1lOiBzdXBwb3J0IHNjYXR0ZXIgZ2F0aGVyIGxpc3RzCjg3ZWQ0ODUgbnZtZTogc3Vw
cG9ydCBtdWx0aXBsZSBibG9jayByZXF1ZXN0cyBwZXIgcmVxdWVzdAphMDkzNzI5IG52bWU6IHNp
bXBsaWZ5IGRtYS9jbWIgbWFwcGluZ3MKNDc2OTExZiBudm1lOiBidW1wIHN1cHBvcnRlZCBOVk1l
IHJldmlzaW9uIHRvIDEuM2QKNTg1NmUyOCBudm1lOiBhZGQgbWlzc2luZyBtYW5kYXRvcnkgRmVh
dHVyZXMKYzE1NTVlMSBudm1lOiBzdXBwb3J0IEdldCBMb2cgUGFnZSBjb21tYW5kCjM2NDExZmMg
bnZtZTogc3VwcG9ydCBBc3luY2hyb25vdXMgRXZlbnQgUmVxdWVzdCBjb21tYW5kCmMyNzI5NWYg
bnZtZTogcmVmYWN0b3IgZGV2aWNlIHJlYWxpemF0aW9uCjliODUyOTcgbnZtZTogc3VwcG9ydCBB
Ym9ydCBjb21tYW5kCmI0NzUyZWUgbnZtZTogc3VwcG9ydCBjb21wbGV0aW9uIHF1ZXVlIGluIGNt
YgpjZWNiNTAyIG52bWU6IHBvcHVsYXRlIHRoZSBtYW5kYXRvcnkgc3VibnFuIGFuZCB2ZXIgZmll
bGRzCjAxMjgzYTMgbnZtZTogYWRkIG1pc3NpbmcgZmllbGRzIGluIGlkZW50aWZ5IGNvbnRyb2xs
ZXIKYzhkY2IzZiBudm1lOiBmaXggbHBhIGZpZWxkCjQ1MTU0NDYgbnZtZTogbW92ZSBkZXZpY2Ug
cGFyYW1ldGVycyB0byBzZXBhcmF0ZSBzdHJ1Y3QKOWYxYTE0MCBudm1lOiBzaW1wbGlmeSBuYW1l
c3BhY2UgY29kZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xNiBDaGVja2luZyBjb21taXQgOWYx
YTE0MDhjYzM4IChudm1lOiBzaW1wbGlmeSBuYW1lc3BhY2UgY29kZSkKMi8xNiBDaGVja2luZyBj
b21taXQgNDUxNTQ0NjY3ZmM4IChudm1lOiBtb3ZlIGRldmljZSBwYXJhbWV0ZXJzIHRvIHNlcGFy
YXRlIHN0cnVjdCkKRVJST1I6IE1hY3JvcyB3aXRoIGNvbXBsZXggdmFsdWVzIHNob3VsZCBiZSBl
bmNsb3NlZCBpbiBwYXJlbnRoZXNpcwojMjA0OiBGSUxFOiBody9ibG9jay9udm1lLmg6NjoKKyNk
ZWZpbmUgREVGSU5FX05WTUVfUFJPUEVSVElFUyhfc3RhdGUsIF9wcm9wcykgXAorICAgIERFRklO
RV9QUk9QX1NUUklORygic2VyaWFsIiwgX3N0YXRlLCBfcHJvcHMuc2VyaWFsKSwgXAorICAgIERF
RklORV9QUk9QX1VJTlQzMigiY21iX3NpemVfbWIiLCBfc3RhdGUsIF9wcm9wcy5jbWJfc2l6ZV9t
YiwgMCksIFwKKyAgICBERUZJTkVfUFJPUF9VSU5UMzIoIm51bV9xdWV1ZXMiLCBfc3RhdGUsIF9w
cm9wcy5udW1fcXVldWVzLCA2NCkKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMjA1IGxp
bmVzIGNoZWNrZWQKClBhdGNoIDIvMTYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvMTYg
Q2hlY2tpbmcgY29tbWl0IGM4ZGNiM2Y2M2ZiNyAobnZtZTogZml4IGxwYSBmaWVsZCkKNC8xNiBD
aGVja2luZyBjb21taXQgMDEyODNhMzk3NWQ3IChudm1lOiBhZGQgbWlzc2luZyBmaWVsZHMgaW4g
aWRlbnRpZnkgY29udHJvbGxlcikKNS8xNiBDaGVja2luZyBjb21taXQgY2VjYjUwMjk4ZjlmIChu
dm1lOiBwb3B1bGF0ZSB0aGUgbWFuZGF0b3J5IHN1Ym5xbiBhbmQgdmVyIGZpZWxkcykKNi8xNiBD
aGVja2luZyBjb21taXQgYjQ3NTJlZWNmOWUxIChudm1lOiBzdXBwb3J0IGNvbXBsZXRpb24gcXVl
dWUgaW4gY21iKQo3LzE2IENoZWNraW5nIGNvbW1pdCA5Yjg1Mjk3MzYyOTQgKG52bWU6IHN1cHBv
cnQgQWJvcnQgY29tbWFuZCkKOC8xNiBDaGVja2luZyBjb21taXQgYzI3Mjk1ZjFlYTU1IChudm1l
OiByZWZhY3RvciBkZXZpY2UgcmVhbGl6YXRpb24pCjkvMTYgQ2hlY2tpbmcgY29tbWl0IDM2NDEx
ZmNkMWE2NyAobnZtZTogc3VwcG9ydCBBc3luY2hyb25vdXMgRXZlbnQgUmVxdWVzdCBjb21tYW5k
KQoxMC8xNiBDaGVja2luZyBjb21taXQgYzE1NTVlMTgzNWRhIChudm1lOiBzdXBwb3J0IEdldCBM
b2cgUGFnZSBjb21tYW5kKQoxMS8xNiBDaGVja2luZyBjb21taXQgNTg1NmUyODc2ZTNjIChudm1l
OiBhZGQgbWlzc2luZyBtYW5kYXRvcnkgRmVhdHVyZXMpCjEyLzE2IENoZWNraW5nIGNvbW1pdCA0
NzY5MTFmNmNhNDIgKG52bWU6IGJ1bXAgc3VwcG9ydGVkIE5WTWUgcmV2aXNpb24gdG8gMS4zZCkK
MTMvMTYgQ2hlY2tpbmcgY29tbWl0IGEwOTM3MjlhZjA4MCAobnZtZTogc2ltcGxpZnkgZG1hL2Nt
YiBtYXBwaW5ncykKMTQvMTYgQ2hlY2tpbmcgY29tbWl0IDg3ZWQ0ODU2OWY2ZiAobnZtZTogc3Vw
cG9ydCBtdWx0aXBsZSBibG9jayByZXF1ZXN0cyBwZXIgcmVxdWVzdCkKMTUvMTYgQ2hlY2tpbmcg
Y29tbWl0IDEyNGFiYTU1ODI3NyAobnZtZTogc3VwcG9ydCBzY2F0dGVyIGdhdGhlciBsaXN0cykK
MTYvMTYgQ2hlY2tpbmcgY29tbWl0IGFlZDgyZTZlOGY2MiAobnZtZTogc3VwcG9ydCBtdWx0aXBs
ZSBuYW1lc3BhY2VzKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBk
b2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMzOTogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDYzMSBsaW5lcyBjaGVja2VkCgpQYXRjaCAx
Ni8xNiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2Ug
ZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIs
IHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcwNTA3MjMzMy4xNzE3MS0xLWtsYXVzQGJp
cmtlbHVuZC5ldS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


