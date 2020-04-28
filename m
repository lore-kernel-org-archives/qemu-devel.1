Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADD6C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEE020661
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEE020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTSZI-0001OM-Gf
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 11:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTSUe-0005zI-JT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTSUG-0006nr-Em
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:49:56 -0400
Resent-Date: Tue, 28 Apr 2020 11:49:56 -0400
Resent-Message-Id: <E1jTSUG-0006nr-Em@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTSUF-0006nP-TP; Tue, 28 Apr 2020 11:49:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588088931; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bka41M9lq5woRZIcSv9DcH8+kSw8RsZpHNhh83XD0/PJfdTAl28HWU91nhwGER8sQGKr86A12ni1vbX4LdVf0pAZ6UTNCIE1pmY8Vq8SEGLe1HSP86ydvxZgrVqJVh4BYCyRDVGKlNCPpn3s09uqrIGkFW2Mo4voGFbdycNNNMs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588088931;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=RVtKDHUqay8BxrPWIu7r8vn65MqSI4hTp+cIGkVNk5E=; 
 b=YgITlu/VI+Rn/mhHsXAyKpCaZ3rye3gt/2I8jWa6OuJGESHQ4mXJ0IEezaDS+q5CPn9Dxm3JTi+h4j9lxHtAfWwdHmEAm79t94e1fOmXoBqCNcI9wFuSgne93mN2Vj/1XOimrwVbiv6CDD1lQUNew2k8LVJjeVv+JOBhYwrXWCQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588088929952728.5077625829002;
 Tue, 28 Apr 2020 08:48:49 -0700 (PDT)
In-Reply-To: <20200428133407.10657-1-dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v21 0/4] implement zstd cluster compression method
Message-ID: <158808892834.30407.8647999371199630661@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dplotnikov@virtuozzo.com
Date: Tue, 28 Apr 2020 08:48:49 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 09:39:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.57
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyODEzMzQwNy4xMDY1
Ny0xLWRwbG90bmlrb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYyMSAwLzRdIGltcGxlbWVudCB6c3Rk
IGNsdXN0ZXIgY29tcHJlc3Npb24gbWV0aG9kCk1lc3NhZ2UtaWQ6IDIwMjAwNDI4MTMzNDA3LjEw
NjU3LTEtZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwg
fHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29y
aXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4K
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFk
ZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0
L3FlbXUKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDQyODEzMjYyOS43OTY3NTMt
MS1tcmVpdHpAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwNDI4MTMyNjI5Ljc5Njc1My0xLW1y
ZWl0ekByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNzIwMWM3ZSBp
b3Rlc3RzOiAyODc6IGFkZCBxY293MiBjb21wcmVzc2lvbiB0eXBlIHRlc3QKN2Y0NGNlNyBxY293
MjogYWRkIHpzdGQgY2x1c3RlciBjb21wcmVzc2lvbgowNTA0MzEwIHFjb3cyOiByZXdvcmsgdGhl
IGNsdXN0ZXIgY29tcHJlc3Npb24gcm91dGluZQowMTA0OWI3IHFjb3cyOiBpbnRyb2R1Y2UgY29t
cHJlc3Npb24gdHlwZSBmZWF0dXJlCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzQgQ2hlY2tpbmcg
Y29tbWl0IDAxMDQ5YjdlMjhlOSAocWNvdzI6IGludHJvZHVjZSBjb21wcmVzc2lvbiB0eXBlIGZl
YXR1cmUpCjIvNCBDaGVja2luZyBjb21taXQgMDUwNDMxMDYxMWJjIChxY293MjogcmV3b3JrIHRo
ZSBjbHVzdGVyIGNvbXByZXNzaW9uIHJvdXRpbmUpCjMvNCBDaGVja2luZyBjb21taXQgN2Y0NGNl
N2Q3MzJiIChxY293MjogYWRkIHpzdGQgY2x1c3RlciBjb21wcmVzc2lvbikKRVJST1I6IGRvIG5v
dCB1c2UgYXNzaWdubWVudCBpbiBpZiBjb25kaXRpb24KIzExNTogRklMRTogYmxvY2svcWNvdzIt
dGhyZWFkcy5jOjIyNToKKyAgICBpZiAoKHpzdGRfcmV0ID0gWlNURF9jb21wcmVzc1N0cmVhbTIo
Y2N0eCwgJm91dHB1dCwgJmlucHV0LCBaU1REX2VfZW5kKSkpIHsKCnRvdGFsOiAxIGVycm9ycywg
MCB3YXJuaW5ncywgMjM4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvNCBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKNC80IENoZWNraW5nIGNvbW1pdCA3MjAxYzdlNzNjZTQgKGlvdGVzdHM6IDI4
NzogYWRkIHFjb3cyIGNvbXByZXNzaW9uIHR5cGUgdGVzdCkKV0FSTklORzogYWRkZWQsIG1vdmVk
IG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMjM6
IApuZXcgZmlsZSBtb2RlIDEwMDc1NQoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAyMjgg
bGluZXMgY2hlY2tlZAoKUGF0Y2ggNC80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmll
dy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhl
bSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDI4MTMz
NDA3LjEwNjU3LTEtZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

