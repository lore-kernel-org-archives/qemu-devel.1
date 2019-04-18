Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C958EC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 13:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929FE217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 13:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929FE217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41507 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH6zj-0003mQ-BN
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 09:22:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hH6ys-0003T1-Oi
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hH6yp-00045R-5G
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:21:34 -0400
Resent-Date: Thu, 18 Apr 2019 09:21:34 -0400
Resent-Message-Id: <E1hH6yp-00045R-5G@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hH6yo-00043m-WF
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 09:21:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555593617; cv=none; d=zoho.com; s=zohoarc; 
	b=b1gleAFHO3NNdoi6aIw07qKbUYUkTbW0oul/vma5k7KLk1ZT2Q3hDSxW7Z4uq7OiiJ/0KiMBBS/EnWRPdZE6Hk+slByCSQZYo+HuLjgqJcOHUzP4nDR2BmhW0qiYG1gmj/3xU+0kmZdMTn8F7OeffzxBX9bOS2FIS2iDhPFHxEA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555593617;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=YSOV/fdNC0KeiFlooTvdqI4/0RDFXhWjhYxAo/vPwEE=; 
	b=gG+1nUY3cvMgCiml0pa2E1+ImV/fr3Whoxl0C14OofvUB9gvKac7AQu5c197Iaqnncnb3lKpFtxC/fIRz7OFC0iuKhLM1KhpTCWt8JOld9ECyKGWrMUFIBOjiC0jkfr9eZSZTex2xfzClPIs3GrfibyIOaRfNPJK1AiH+KwAE5A=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555593614413269.4287260903302;
	Thu, 18 Apr 2019 06:20:14 -0700 (PDT)
In-Reply-To: <20190418125908.11928-1-marcandre.lureau@redhat.com>
Message-ID: <155559361280.24.11295918513603991002@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Thu, 18 Apr 2019 06:20:14 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH 0/2] Memory fixes for slirp tcp_emu()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, jan.kiszka@siemens.com, qemu-devel@nongnu.org,
	samuel.thibault@ens-lyon.org, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418132014.wXwXc5H3CtoXQzLWT1BbL_922qL-snZOVVmT21LtocI@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxODEyNTkwOC4xMTky
OC0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzJdIE1l
bW9yeSBmaXhlcyBmb3Igc2xpcnAgdGNwX2VtdSgpClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAy
MDE5MDQxODEyNTkwOC4xMTkyOC0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbQoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo3
YzZkNmQwIHNsaXJwOiBkb24ndCBtYW5pcHVsYXRlIHNvX3JjdiBpbiB0Y3BfZW11KCkKODRkOGUz
ZSBzbGlycDogZW5zdXJlIHRoZXJlIGlzIGVub3VnaCBzcGFjZSBpbiBtYnVmIHRvIG51bGwtdGVy
bWluYXRlCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzIgQ2hlY2tpbmcgY29tbWl0IDg0ZDhlM2Vh
Njg3ZCAoc2xpcnA6IGVuc3VyZSB0aGVyZSBpcyBlbm91Z2ggc3BhY2UgaW4gbWJ1ZiB0byBudWxs
LXRlcm1pbmF0ZSkKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMjI6
IEZJTEU6IHNsaXJwL3NyYy90Y3Bfc3Vici5jOjY0NzoKK15JXkleSW1faW5jKG0sIG0tPm1fbGVu
ICsgMSk7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMzg6IEZJ
TEU6IHNsaXJwL3NyYy90Y3Bfc3Vici5jOjc3OToKK15JXkltX2luYyhtLCBtLT5tX2xlbiArIDEp
OyQKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgMjEgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
MS8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzIgQ2hlY2tpbmcgY29tbWl0IDdjNmQ2
ZDBlOGM2OCAoc2xpcnA6IGRvbid0IG1hbmlwdWxhdGUgc29fcmN2IGluIHRjcF9lbXUoKSkKRVJS
T1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNDc6IEZJTEU6IHNsaXJwL3Ny
Yy90Y3Bfc3Vici5jOjYzODoKK15JXkleSWlmIChnX3N0cnN0cl9sZW4obS0+bV9kYXRhLCBtLT5t
X2xlbiwgIlxyXG4iKSQKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM0ODogRklM
RTogc2xpcnAvc3JjL3RjcF9zdWJyLmM6NjM5OgorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICYmIHNzY2FuZihtLT5tX2RhdGEsICIldSUqWyAsXSV1XHJcbiIsICZuMSwgJm4yKSA9PSAy
KSB7CgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0ODogRklMRTog
c2xpcnAvc3JjL3RjcF9zdWJyLmM6NjM5OgorXkleSV5JXkkmJiBzc2NhbmYobS0+bV9kYXRhLCAi
JXUlKlsgLF0ldVxyXG4iLCAmbjEsICZuMikgPT0gMikgeyQKCldBUk5JTkc6IGxpbmUgb3ZlciA4
MCBjaGFyYWN0ZXJzCiM2MTogRklMRTogc2xpcnAvc3JjL3RjcF9zdWJyLmM6NjU4OgorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbS0+bV9sZW4gPSBzbnByaW50ZihtLT5t
X2RhdGEsIG0tPm1fc2l6ZSwKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRh
YnMKIzYxOiBGSUxFOiBzbGlycC9zcmMvdGNwX3N1YnIuYzo2NTg6CiteSV5JXkleSV5JbS0+bV9s
ZW4gPSBzbnByaW50ZihtLT5tX2RhdGEsIG0tPm1fc2l6ZSwkCgpFUlJPUjogbGluZSBvdmVyIDkw
IGNoYXJhY3RlcnMKIzYyOiBGSUxFOiBzbGlycC9zcmMvdGNwX3N1YnIuYzo2NTk6CisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIiVkLCVkXHJcbiIsIG4xLCBuMik7CgpFUlJPUjogY29kZSBpbmRlbnQg
c2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM2MjogRklMRTogc2xpcnAvc3JjL3RjcF9zdWJyLmM6NjU5
OgorXkleSV5JXkleSV5JXkleSV5JXkkiJWQsJWRcclxuIiwgbjEsIG4yKTskCgpFUlJPUjogY29k
ZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM2NzogRklMRTogc2xpcnAvc3JjL3RjcF9z
dWJyLmM6NjYxOgorXkleSV5JcmV0dXJuIDE7JAoKdG90YWw6IDYgZXJyb3JzLCAyIHdhcm5pbmdz
LCA0MCBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkw
NDE4MTI1OTA4LjExOTI4LTEtbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tL3Rlc3RpbmcuY2hl
Y2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


