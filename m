Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92260C388F3
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B9F520872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9F520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDuUV-0003NW-L9
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iDtdn-0000sK-Lc
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iDtdl-0007FJ-PJ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:02:47 -0400
Resent-Date: Fri, 27 Sep 2019 13:02:47 -0400
Resent-Message-Id: <E1iDtdl-0007FJ-PJ@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iDtdl-00074n-H5; Fri, 27 Sep 2019 13:02:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569603741; cv=none; d=zoho.com; s=zohoarc; 
 b=KmjFRo9MXJhW+Jl/Tih4WXHGvRKhDoG4hOgjp7/6CSdlXY3B9bgXfQBpLXxfcjzD61dO6X/tAQy+TYcW4XAduxlIBbML/JyDcewTLMgBsHVbjHkmuTxgYXQNz55aH8i5ce7MM85Jg5NK3prvXBa1ltLvYnos0D/4NBXoeIslTUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569603741;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=MkLk8+DURsFutMBZAkN1FLjLzFPx233//shT2IJQmoQ=; 
 b=V2YJ6U+kncD+yjDZNM16EBh3O9mqwF+JTggLvPKiNPeFcgkzQUxJBmZdu+rbQsdpIESMHlhnc8wuSYv9jHByGSDpP3kMHF9rNKwgVl6XEdFfFdnbd1X8gUKOMRaF3QTyWYcyI+Qx/AyHG7kNTPCKKcybQBuq1nIyn4MAYarl0+s=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569603741217255.17655725360407;
 Fri, 27 Sep 2019 10:02:21 -0700 (PDT)
Subject: Re: [PATCH v7 0/8] Add Qemu to SeaBIOS LCHS interface
In-Reply-To: <20190925110639.100699-1-sameid@google.com>
Message-ID: <156960373939.27524.14138440651133153520@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Fri, 27 Sep 2019 10:02:21 -0700 (PDT)
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, kevin@koconnor.net,
 liran.alon@oracle.com, kraxel@redhat.com, sameid@google.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkyNTExMDYzOS4xMDA2
OTktMS1zYW1laWRAZ29vZ2xlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwOTI1MTEwNjM5LjEwMDY5
OS0xLXNhbWVpZEBnb29nbGUuY29tClN1YmplY3Q6IFtQQVRDSCB2NyAwLzhdIEFkZCBRZW11IHRv
IFNlYUJJT1MgTENIUyBpbnRlcmZhY2UKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZy
b20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAgIGRlZWU2ZmYuLmM2
ZjUwMTIgIG1hc3RlciAgICAgLT4gbWFzdGVyCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcv
MTU2OTU5MDQ2MS0xMjU2Mi0xLWdpdC1zZW5kLWVtYWlsLW1qcm9zYXRvQGxpbnV4LmlibS5jb20g
LT4gcGF0Y2hldy8xNTY5NTkwNDYxLTEyNTYyLTEtZ2l0LXNlbmQtZW1haWwtbWpyb3NhdG9AbGlu
dXguaWJtLmNvbQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzE1Njk1OTEyMDMtMTUyNTgt
MS1naXQtc2VuZC1lbWFpbC1pbWJyZW5kYUBsaW51eC5pYm0uY29tIC0+IHBhdGNoZXcvMTU2OTU5
MTIwMy0xNTI1OC0xLWdpdC1zZW5kLWVtYWlsLWltYnJlbmRhQGxpbnV4LmlibS5jb20KICogW25l
dyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE5MDkyNzEwMTExMC4yNTU4MS0xLWJlcnJhbmdlQHJl
ZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDkyNzEwMTExMC4yNTU4MS0xLWJlcnJhbmdlQHJlZGhh
dC5jb20KICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE5MDkyNzEzNDIyNC4xNDU1MC0x
LW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTkwOTI3MTM0MjI0LjE0
NTUwLTEtbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tCiAqIFtuZXcgdGFnXSAgICAgICAgIHBh
dGNoZXcvMjAxOTA5MjcxMzQ2MzkuNDI4NC0xLWFybWJydUByZWRoYXQuY29tIC0+IHBhdGNoZXcv
MjAxOTA5MjcxMzQ2MzkuNDI4NC0xLWFybWJydUByZWRoYXQuY29tCiAqIFtuZXcgdGFnXSAgICAg
ICAgIHBhdGNoZXcvMjAxOTA5MjcxNDE3MjguNzEzNy0xLWNyb3NhQHJlZGhhdC5jb20gLT4gcGF0
Y2hldy8yMDE5MDkyNzE0MTcyOC43MTM3LTEtY3Jvc2FAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBh
IG5ldyBicmFuY2ggJ3Rlc3QnCjNkMTQ4OTAgaGQtZ2VvLXRlc3Q6IEFkZCB0ZXN0cyBmb3IgbGNo
cyBvdmVycmlkZQo4ZGI5NzBmIGJvb3RkZXZpY2U6IEZXX0NGRyBpbnRlcmZhY2UgZm9yIExDSFMg
dmFsdWVzCmY3M2U2NWE4IGJvb3RkZXZpY2U6IFJlZmFjdG9yIGdldF9ib290X2RldmljZXNfbGlz
dApkMWQ5N2VjIGJvb3RkZXZpY2U6IEdhdGhlciBMQ0hTIGZyb20gYWxsIHJlbGV2YW50IGRldmlj
ZXMKMzEyMjFmNSBzY3NpOiBQcm9wYWdhdGUgdW5yZWFsaXplKCkgY2FsbGJhY2sgdG8gc2NzaS1o
ZAo2NDIyYzZhIGJvb3RkZXZpY2U6IEFkZCBpbnRlcmZhY2UgdG8gZ2F0aGVyIExDSFMKYjIzNjBm
NyBibG9jazogU3VwcG9ydCBwcm92aWRpbmcgTENIUyBmcm9tIHVzZXIKMWM0M2JlNiBibG9jazog
UmVmYWN0b3IgbWFjcm9zIC0gZml4IHRhYmJpbmcKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvOCBD
aGVja2luZyBjb21taXQgMWM0M2JlNmRlMTVkIChibG9jazogUmVmYWN0b3IgbWFjcm9zIC0gZml4
IHRhYmJpbmcpCkVSUk9SOiBNYWNyb3Mgd2l0aCBjb21wbGV4IHZhbHVlcyBzaG91bGQgYmUgZW5j
bG9zZWQgaW4gcGFyZW50aGVzaXMKIzU1OiBGSUxFOiBpbmNsdWRlL2h3L2Jsb2NrL2Jsb2NrLmg6
NjU6CisjZGVmaW5lIERFRklORV9CTE9DS19DSFNfUFJPUEVSVElFUyhfc3RhdGUsIF9jb25mKSAg
ICAgICAgICAgICAgICAgICAgICBcCisgICAgREVGSU5FX1BST1BfVUlOVDMyKCJjeWxzIiwgX3N0
YXRlLCBfY29uZi5jeWxzLCAwKSwgICAgICAgICAgICAgICAgICBcCisgICAgREVGSU5FX1BST1Bf
VUlOVDMyKCJoZWFkcyIsIF9zdGF0ZSwgX2NvbmYuaGVhZHMsIDApLCAgICAgICAgICAgICAgICBc
CiAgICAgREVGSU5FX1BST1BfVUlOVDMyKCJzZWNzIiwgX3N0YXRlLCBfY29uZi5zZWNzLCAwKQoK
dG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAzNyBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzgg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjIvOCBDaGVja2luZyBjb21taXQgYjIzNjBmNzE4
ODA3IChibG9jazogU3VwcG9ydCBwcm92aWRpbmcgTENIUyBmcm9tIHVzZXIpCjMvOCBDaGVja2lu
ZyBjb21taXQgNjQyMmM2YWNjNDJhIChib290ZGV2aWNlOiBBZGQgaW50ZXJmYWNlIHRvIGdhdGhl
ciBMQ0hTKQo0LzggQ2hlY2tpbmcgY29tbWl0IDMxMjIxZjVhMGQ0ZCAoc2NzaTogUHJvcGFnYXRl
IHVucmVhbGl6ZSgpIGNhbGxiYWNrIHRvIHNjc2ktaGQpCjUvOCBDaGVja2luZyBjb21taXQgZDFk
OTdlY2E3ZGUyIChib290ZGV2aWNlOiBHYXRoZXIgTENIUyBmcm9tIGFsbCByZWxldmFudCBkZXZp
Y2VzKQo2LzggQ2hlY2tpbmcgY29tbWl0IGY3M2U2NWE4NzljOCAoYm9vdGRldmljZTogUmVmYWN0
b3IgZ2V0X2Jvb3RfZGV2aWNlc19saXN0KQo3LzggQ2hlY2tpbmcgY29tbWl0IDhkYjk3MGY3Mzlh
ZCAoYm9vdGRldmljZTogRldfQ0ZHIGludGVyZmFjZSBmb3IgTENIUyB2YWx1ZXMpCjgvOCBDaGVj
a2luZyBjb21taXQgM2QxNDg5MDIxMzZhIChoZC1nZW8tdGVzdDogQWRkIHRlc3RzIGZvciBsY2hz
IG92ZXJyaWRlKQpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEg
c2VwYXJhdGUgbGluZQojNjQ4OiBGSUxFOiB0ZXN0cy9oZC1nZW8tdGVzdC5jOjEwMDM6CisgICAg
ICAgICAgICAgICAgICAgICAgICJza2lwcGluZyBoZC1nZW8vb3ZlcnJpZGUvKiB0ZXN0cyIpOwoK
dG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA2MTYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC84
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTI1MTEwNjM5LjEwMDY5OS0xLXNhbWVpZEBnb29n
bGUuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


