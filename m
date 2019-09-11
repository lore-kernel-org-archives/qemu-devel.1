Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2430C4740A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 04:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9594D21A4C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 04:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9594D21A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7u7A-0002Xa-Q8
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 00:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7u6T-00021d-IO
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 00:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7u6R-0003De-Qh
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 00:19:37 -0400
Resent-Date: Wed, 11 Sep 2019 00:19:37 -0400
Resent-Message-Id: <E1i7u6R-0003De-Qh@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7u6R-0003D4-JI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 00:19:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568175528; cv=none; d=zoho.com; s=zohoarc; 
 b=KEpcH/juPneVqiSzLnj/yG9AHqIAzYc1O8RU/HFKhdYI04f3nX8Xbsc07AMl8G0ImArYufDH+0PbyPGc/P7uyYLfd4kpj/vfASfU9m006jqbdOnisRg11H0a9QhBOzAbJgb0nn1CCuhaXHedyDMpOwITCk1pNthjGJwYFZusQGY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568175528;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=VupMcCHW4frebyIJ/8emva2a+4LGCIJRF/BsEYR/mLc=; 
 b=Fp7LAbtS+3aHaoAW1fDukQ58jHdAxRwHxlk480pFxHZ1vy0tuhVJHa8yafIjPLOnxWfTss7y9PHiDbV/MZycLjYoYPGK7Pl7AWjjm2uHIs0drnKNuofxgRsAtRiEUavdWuCsevP79YtQRSw8ZBYHRIMDAo9RcJ+HhH0chaTBCcI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568175526720248.16919787877157;
 Tue, 10 Sep 2019 21:18:46 -0700 (PDT)
In-Reply-To: <20190910193347.16000-1-laurent@vivier.eu>
Message-ID: <156817552448.15929.332993068977473511@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Tue, 10 Sep 2019 21:18:46 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [PATCH v11 0/9] hw/m68k: add Apple Machintosh
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, huth@tuxfamily.org,
 jasowang@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 dgilbert@redhat.com, hpoussin@reactos.org, kraxel@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com,
 aurelien@aurel32.net, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMDE5MzM0Ny4xNjAw
MC0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYxMSAwLzldIGh3L202OGs6
IGFkZCBBcHBsZSBNYWNoaW50b3NoIFF1YWRyYSA4MDAgbWFjaGluZQpNZXNzYWdlLWlkOiAyMDE5
MDkxMDE5MzM0Ny4xNjAwMC0xLWxhdXJlbnRAdml2aWVyLmV1ClR5cGU6IHNlcmllcwoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE5MDkxMTAzNDMwMi4y
OTEwOC0xLWFuZHJld0Bhai5pZC5hdSAtPiBwYXRjaGV3LzIwMTkwOTExMDM0MzAyLjI5MTA4LTEt
YW5kcmV3QGFqLmlkLmF1ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYmEwNDk1NyBo
dy9tNjhrOiBkZWZpbmUgTWFjaW50b3NoIFF1YWRyYSA4MDAKOTkwNjBjZiBody9tNjhrOiBhZGQg
YSBkdW1teSBTV0lNIGZsb3BweSBjb250cm9sbGVyCmQxMDEyYmQgaHcvbTY4azogYWRkIE51YnVz
IHN1cHBvcnQgZm9yIG1hY2ZiIHZpZGVvIGNhcmQKNzcxZGU2NCBody9tNjhrOiBhZGQgTnVidXMg
c3VwcG9ydAo2NjRhMGQ0IGh3L202OGs6IGFkZCBtYWNmYiB2aWRlbyBjYXJkCmQ3NjNhNWUgaHcv
bTY4azogaW1wbGVtZW50IEFEQiBidXMgc3VwcG9ydCBmb3IgdmlhCmM0MDA1YjggaHcvbTY4azog
YWRkIHZpYSBzdXBwb3J0CjcwMzI3MDYgZHA4MzkzeDogbWFuYWdlIGJpZyBlbmRpYW4gYnVzCjlh
ZDA5M2IgZXNwOiBhZGQgcHNldWRvLURNQSBhcyB1c2VkIGJ5IE1hY2ludG9zaAoKPT09IE9VVFBV
VCBCRUdJTiA9PT0KMS85IENoZWNraW5nIGNvbW1pdCA5YWQwOTNiNmFiMTggKGVzcDogYWRkIHBz
ZXVkby1ETUEgYXMgdXNlZCBieSBNYWNpbnRvc2gpCjIvOSBDaGVja2luZyBjb21taXQgNzAzMjcw
Njg5YmFiIChkcDgzOTN4OiBtYW5hZ2UgYmlnIGVuZGlhbiBidXMpCjMvOSBDaGVja2luZyBjb21t
aXQgYzQwMDViODkwOTVjIChody9tNjhrOiBhZGQgdmlhIHN1cHBvcnQpCldBUk5JTkc6IGFkZGVk
LCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGlu
Zz8KIzc3OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGFm
dGVyIHRoYXQgJyYmJyAoY3R4Old4VykKIzQyNjogRklMRTogaHcvbWlzYy9tYWNfdmlhLmM6MzQ1
OgorICAgICAgICBpZiAoISh2MXMtPmxhc3RfYiAmIFZJQTFCX3ZSVENDbGspICYmIChzLT5iICYg
VklBMUJfdlJUQ0NsaykpIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBeCgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDg2NyBsaW5lcyBjaGVja2VkCgpQ
YXRjaCAzLzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQvOSBDaGVja2luZyBjb21taXQg
ZDc2M2E1ZWUwNjc2IChody9tNjhrOiBpbXBsZW1lbnQgQURCIGJ1cyBzdXBwb3J0IGZvciB2aWEp
CjUvOSBDaGVja2luZyBjb21taXQgNjY0YTBkNDczYWZkIChody9tNjhrOiBhZGQgbWFjZmIgdmlk
ZW8gY2FyZCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBN
QUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNjg6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90
YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1MTggbGluZXMgY2hlY2tlZAoKUGF0Y2ggNS85IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjYvOSBDaGVja2luZyBjb21taXQgNzcxZGU2NGY0YWEy
IChody9tNjhrOiBhZGQgTnVidXMgc3VwcG9ydCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRl
bGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNjI6IApuZXcg
ZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1MzIgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggNi85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjcvOSBDaGVja2lu
ZyBjb21taXQgZDEwMTJiZDNmMTExIChody9tNjhrOiBhZGQgTnVidXMgc3VwcG9ydCBmb3IgbWFj
ZmIgdmlkZW8gY2FyZCkKOC85IENoZWNraW5nIGNvbW1pdCA5OTA2MGNmMGJiMWIgKGh3L202OGs6
IGFkZCBhIGR1bW15IFNXSU0gZmxvcHB5IGNvbnRyb2xsZXIpCldBUk5JTkc6IGFkZGVkLCBtb3Zl
ZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzUz
OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNTkx
IGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo5Lzkg
Q2hlY2tpbmcgY29tbWl0IGJhMDQ5NTdmNDJkZCAoaHcvbTY4azogZGVmaW5lIE1hY2ludG9zaCBR
dWFkcmEgODAwKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2Vz
IE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM3MDogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0
b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDUxOCBsaW5lcyBjaGVja2VkCgpQYXRjaCA5Lzkg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MTAxOTMzNDcuMTYwMDAtMS1sYXVyZW50QHZpdmll
ci5ldS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


