Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FC6C4CECC
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 15:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099E4214AF
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 15:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099E4214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9Wte-0007xh-7q
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 11:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i9Wsq-0007Ng-4o
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 11:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i9Wso-0000o7-AX
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 11:56:15 -0400
Resent-Date: Sun, 15 Sep 2019 11:56:15 -0400
Resent-Message-Id: <E1i9Wso-0000o7-AX@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i9Wso-0000mM-26; Sun, 15 Sep 2019 11:56:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568562936; cv=none; d=zoho.com; s=zohoarc; 
 b=O3i2oREvcXKsOUQ7ZOqKUt6wiTtGf4WBY3bMqCXcwv3yuNAmKJBMBDGSkCFffEXMhcjSMT/B0lFxXkFkQmPvR8kMyycVwUlagESEOM10N3fhOCZy0MML4Cg7enlLD6HGrj/hKS1ZZa2CWr+sO7AZVtbPWy2Sm3GYBlrDfRfxAUw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568562936;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=w+JlEdSlfERxUjsEgkIjQM7rk9acr/lZAjhskEameZs=; 
 b=hE1gdNo0XYvcD2Fnp+9OxaiXfLhkks/KS0VRa1O2iWlSCgdV601Y6pSZQrfZQbupQlBgA2M0nUo6VFJRikwullJloIJGx3nwokBWFGF1GgJeFj2QzFhDxbjBoeUlpALnGKNibX1+DMarrcSZTvi/wOp3s2vgIAESD8WpYdQeSfE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568562934521898.2932253658304;
 Sun, 15 Sep 2019 08:55:34 -0700 (PDT)
In-Reply-To: <20190915153751.11333-1-laurent@vivier.eu>
Message-ID: <156856293238.3060.806906487490327324@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Sun, 15 Sep 2019 08:55:34 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v12 0/9] hw/m68k: add Apple Machintosh
 Quadra 800 machine
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, huth@tuxfamily.org,
 jasowang@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 laurent@vivier.eu, hpoussin@reactos.org, aurelien@aurel32.net,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com,
 dgilbert@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxNTE1Mzc1MS4xMTMz
My0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYxMiAwLzldIGh3L202OGs6
IGFkZCBBcHBsZSBNYWNoaW50b3NoIFF1YWRyYSA4MDAgbWFjaGluZQpNZXNzYWdlLWlkOiAyMDE5
MDkxNTE1Mzc1MS4xMTMzMy0xLWxhdXJlbnRAdml2aWVyLmV1ClR5cGU6IHNlcmllcwoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE5MDkxNTE1Mzc1MS4x
MTMzMy0xLWxhdXJlbnRAdml2aWVyLmV1IC0+IHBhdGNoZXcvMjAxOTA5MTUxNTM3NTEuMTEzMzMt
MS1sYXVyZW50QHZpdmllci5ldQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjA4MTcz
NjQgQm9vdExpbnV4Q29uc29sZVRlc3Q6IFRlc3QgdGhlIFF1YWRyYSA4MDAKZTNhZTc1ZCBody9t
NjhrOiBkZWZpbmUgTWFjaW50b3NoIFF1YWRyYSA4MDAKNjdhNTNjMiBody9tNjhrOiBhZGQgYSBk
dW1teSBTV0lNIGZsb3BweSBjb250cm9sbGVyCjNmZDQwMjcgaHcvbTY4azogYWRkIE51YnVzIG1h
Y2ZiIHZpZGVvIGNhcmQKNDFjMGMyZCBody9tNjhrOiBhZGQgTnVidXMgc3VwcG9ydAo4Y2VmM2Fi
IGh3L202OGs6IGltcGxlbWVudCBBREIgYnVzIHN1cHBvcnQgZm9yIHZpYQo4ODY2MTk1IGh3L202
OGs6IGFkZCBWSUEgc3VwcG9ydAo3Y2I0YmM5IGRwODM5M3g6IG1hbmFnZSBiaWcgZW5kaWFuIGJ1
cwpjZjgwOWFhIGVzcDogYWRkIHBzZXVkby1ETUEgYXMgdXNlZCBieSBNYWNpbnRvc2gKCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvOSBDaGVja2luZyBjb21taXQgY2Y4MDlhYWRiMzMyIChlc3A6IGFk
ZCBwc2V1ZG8tRE1BIGFzIHVzZWQgYnkgTWFjaW50b3NoKQoyLzkgQ2hlY2tpbmcgY29tbWl0IDdj
YjRiYzkxMmEyYSAoZHA4MzkzeDogbWFuYWdlIGJpZyBlbmRpYW4gYnVzKQozLzkgQ2hlY2tpbmcg
Y29tbWl0IDg4NjYxOTUxNjYzNiAoaHcvbTY4azogYWRkIFZJQSBzdXBwb3J0KQpXQVJOSU5HOiBh
ZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBk
YXRpbmc/CiM4MzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogc3BhY2UgcHJvaGliaXRl
ZCBhZnRlciB0aGF0ICcmJicgKGN0eDpXeFcpCiM0MzI6IEZJTEU6IGh3L21pc2MvbWFjX3ZpYS5j
OjM0NToKKyAgICAgICAgaWYgKCEodjFzLT5sYXN0X2IgJiBWSUExQl92UlRDQ2xrKSAmJiAocy0+
YiAmIFZJQTFCX3ZSVENDbGspKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCA4NjYgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMy85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo0LzkgQ2hlY2tpbmcgY29t
bWl0IDhjZWYzYWJlYTM3NSAoaHcvbTY4azogaW1wbGVtZW50IEFEQiBidXMgc3VwcG9ydCBmb3Ig
dmlhKQo1LzkgQ2hlY2tpbmcgY29tbWl0IDQxYzBjMmQ2MzA0NCAoaHcvbTY4azogYWRkIE51YnVz
IHN1cHBvcnQpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMg
TUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzY0OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRv
dGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNTMxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDUvOSBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo2LzkgQ2hlY2tpbmcgY29tbWl0IDNmZDQwMjdhNmEy
MiAoaHcvbTY4azogYWRkIE51YnVzIG1hY2ZiIHZpZGVvIGNhcmQpCldBUk5JTkc6IGFkZGVkLCBt
b3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8K
Izc1OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywg
NTk3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDYvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo3
LzkgQ2hlY2tpbmcgY29tbWl0IDY3YTUzYzI0MGUwNyAoaHcvbTY4azogYWRkIGEgZHVtbXkgU1dJ
TSBmbG9wcHkgY29udHJvbGxlcikKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmls
ZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNjI6IApuZXcgZmlsZSBtb2Rl
IDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1OTEgbGluZXMgY2hlY2tlZAoK
UGF0Y2ggNy85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjgvOSBDaGVja2luZyBjb21taXQg
ZTNhZTc1ZDYzMjY0IChody9tNjhrOiBkZWZpbmUgTWFjaW50b3NoIFF1YWRyYSA4MDApCldBUk5J
Tkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVl
ZCB1cGRhdGluZz8KIzcwOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywg
MSB3YXJuaW5ncywgNTMwIGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvOSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgo5LzkgQ2hlY2tpbmcgY29tbWl0IDA4MTczNjQzZGQ5MyAoQm9vdExpbnV4Q29u
c29sZVRlc3Q6IFRlc3QgdGhlIFF1YWRyYSA4MDApCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTE1MTUzNzUxLjExMzMzLTEtbGF1cmVudEB2
aXZpZXIuZXUvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


