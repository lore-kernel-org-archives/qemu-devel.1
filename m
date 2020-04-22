Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82135C38A30
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 05:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512E12072D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 05:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512E12072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR863-0003AR-GP
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 01:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jR85K-0002X6-0w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 01:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jR85I-0002EI-I3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 01:38:09 -0400
Resent-Date: Wed, 22 Apr 2020 01:38:09 -0400
Resent-Message-Id: <E1jR85I-0002EI-I3@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jR85I-00020d-0m; Wed, 22 Apr 2020 01:38:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587533878; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bKC8l2knYOKKsg9s0XMBc//1KcHtVp6D6HOHkh5kKRj2f5EhOrU72AqsDQijpVcq4kl5UYL/ASR9qZ+l1B2DmzrqIfDCXFUOep1IoP04hO1xPMFTJQqAejTRwnQYBOx1KGGNK5qPGqOekYPU0bB8x3bWe/TDn8vW2wHQCaTcv3E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587533878;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Pj5jV0Fa7yt5+jh050mLrcvIp6ucv9onP4I0pe6Ic8k=; 
 b=YcnmaiZb19EPOlUAZAEk9msaPkuKyvT81OO3ugm0ejavtgHiM2oK28gITO64D+Rd+TB/qA24D37GMkutZGFvanH54mNI6eg1Ps1ISO5CayyT2hD1vcSgzOHGbwx6SEyRQ+7u4VvFYONZwaQpfVS4p7VOJtW3iVnB8TDMQlFtysA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587533877905811.3139344006929;
 Tue, 21 Apr 2020 22:37:57 -0700 (PDT)
In-Reply-To: <20200422043309.18430-1-richard.henderson@linaro.org>
Subject: Re: [PATCH v3 00/18] target/arm: sve load/store improvements
Message-ID: <158753387679.29038.14932262571468049196@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Tue, 21 Apr 2020 22:37:57 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 01:38:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMjA0MzMwOS4xODQz
MC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MyAwMC8xOF0gdGFyZ2V0L2Fy
bTogc3ZlIGxvYWQvc3RvcmUgaW1wcm92ZW1lbnRzCk1lc3NhZ2UtaWQ6IDIwMjAwNDIyMDQzMzA5
LjE4NDMwLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpUeXBlOiBzZXJpZXMKCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rl
di9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
YmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2gg
J3Rlc3QnCjRjYzQ0OWYgdGFyZ2V0L2FybTogUmVtb3ZlIHN2ZV9tZW1vcGlkeApjZWNiOGU4IHRh
cmdldC9hcm06IFJldXNlIHN2ZV9wcm9iZV9wYWdlIGZvciBnYXRoZXIgbG9hZHMKOWMyYmJmMyB0
YXJnZXQvYXJtOiBSZXVzZSBzdmVfcHJvYmVfcGFnZSBmb3Igc2NhdHRlciBzdG9yZXMKMWYyMzBl
NSB0YXJnZXQvYXJtOiBSZXVzZSBzdmVfcHJvYmVfcGFnZSBmb3IgZ2F0aGVyIGZpcnN0LWZhdWx0
IGxvYWRzCjA3MmU2NjUgdGFyZ2V0L2FybTogVXNlIFNWRUNvbnRMZFN0IGZvciBjb250aWd1b3Vz
IHN0b3Jlcwo2NGRjOGJkIHRhcmdldC9hcm06IFVwZGF0ZSBjb250aWd1b3VzIGZpcnN0LWZhdWx0
IGFuZCBuby1mYXVsdCBsb2FkcwpmYTVhMjQyIHRhcmdldC9hcm06IFVzZSBTVkVDb250TGRTdCBm
b3IgbXVsdGktcmVnaXN0ZXIgY29udGlndW91cyBsb2FkcwpiMGUyMmVjIHRhcmdldC9hcm06IEhh
bmRsZSB3YXRjaHBvaW50cyBpbiBzdmVfbGQxX3IKMzM2MzUzZSB0YXJnZXQvYXJtOiBVc2UgU1ZF
Q29udExkU3QgaW4gc3ZlX2xkMV9yCjVkMTAzZWEgdGFyZ2V0L2FybTogQWRqdXN0IGludGVyZmFj
ZSBvZiBzdmVfbGQxX2hvc3RfZm4KY2Y1YTU0MSB0YXJnZXQvYXJtOiBBZGQgc3ZlIGluZnJhc3Ry
dWN0dXJlIGZvciBwYWdlIGxvb2t1cAo2N2U1NTBkIHRhcmdldC9hcm06IERyb3AgbWFudWFsIGhh
bmRsaW5nIG9mIHNldC9jbGVhcl9oZWxwZXJfcmV0YWRkcgpjMTQyOGJmIHRhcmdldC9hcm06IFVz
ZSBjcHVfKl9kYXRhX3JhIGZvciBzdmVfbGRzdF90bGJfZm4KZTYyNWQxYSBhY2NlbC90Y2c6IEFk
ZCBlbmRpYW4tc3BlY2lmaWMgY3B1X3tsZCwgc3R9KiBvcGVyYXRpb25zCmM0YTFhN2MgYWNjZWwv
dGNnOiBBZGQgcHJvYmVfYWNjZXNzX2ZsYWdzCjdmMzMzYmYgYWNjZWwvdGNnOiBBZGQgYmxvY2sg
Y29tbWVudCBmb3IgcHJvYmVfYWNjZXNzCmM0MzQwNWIgZXhlYzogRml4IGNwdV93YXRjaHBvaW50
X2FkZHJlc3NfbWF0Y2hlcyBhZGRyZXNzIGxlbmd0aAo1NDNkYWEzIGV4ZWM6IEFkZCBibG9jayBj
b21tZW50cyBmb3Igd2F0Y2hwb2ludCByb3V0aW5lcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8x
OCBDaGVja2luZyBjb21taXQgNTQzZGFhM2U1MDRkIChleGVjOiBBZGQgYmxvY2sgY29tbWVudHMg
Zm9yIHdhdGNocG9pbnQgcm91dGluZXMpCjIvMTggQ2hlY2tpbmcgY29tbWl0IGM0MzQwNWI4MmVl
YSAoZXhlYzogRml4IGNwdV93YXRjaHBvaW50X2FkZHJlc3NfbWF0Y2hlcyBhZGRyZXNzIGxlbmd0
aCkKMy8xOCBDaGVja2luZyBjb21taXQgN2YzMzNiZjFhOTk4IChhY2NlbC90Y2c6IEFkZCBibG9j
ayBjb21tZW50IGZvciBwcm9iZV9hY2Nlc3MpCjQvMTggQ2hlY2tpbmcgY29tbWl0IGM0YTFhN2Mw
NDFlNyAoYWNjZWwvdGNnOiBBZGQgcHJvYmVfYWNjZXNzX2ZsYWdzKQo1LzE4IENoZWNraW5nIGNv
bW1pdCBlNjI1ZDFhZjQwNzAgKGFjY2VsL3RjZzogQWRkIGVuZGlhbi1zcGVjaWZpYyBjcHVfe2xk
LCBzdH0qIG9wZXJhdGlvbnMpCjYvMTggQ2hlY2tpbmcgY29tbWl0IGMxNDI4YmZjNmJhOCAodGFy
Z2V0L2FybTogVXNlIGNwdV8qX2RhdGFfcmEgZm9yIHN2ZV9sZHN0X3RsYl9mbikKRVJST1I6IHNw
YWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpWeFYpCiM2MjogRklMRTogdGFyZ2V0
L2FybS9zdmVfaGVscGVyLmM6NDAyOToKKyAgICBUTEIoZW52LCBhZGRyLCAoVFlQRU0pKihUWVBF
RSAqKSh2ZCArIEgocmVnX29mZikpLCByYSk7ICAgICAgICAgICAgICAgICBcCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJyon
IChjdHg6V3hWKQojMTUyOiBGSUxFOiB0YXJnZXQvYXJtL3N2ZV9oZWxwZXIuYzo0MTYyOgorICAg
ICAgICAgICAgICAgICAgICAgIHN2ZV9sZHN0MV90bGJfZm4gKnRsYl9mbikKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5n
cywgNDU1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDYvMTggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCjcvMTggQ2hlY2tpbmcgY29tbWl0IDY3ZTU1MGRmZWYyNCAodGFyZ2V0L2FybTogRHJvcCBt
YW51YWwgaGFuZGxpbmcgb2Ygc2V0L2NsZWFyX2hlbHBlcl9yZXRhZGRyKQo4LzE4IENoZWNraW5n
IGNvbW1pdCBjZjVhNTQxMTMyY2EgKHRhcmdldC9hcm06IEFkZCBzdmUgaW5mcmFzdHJ1Y3R1cmUg
Zm9yIHBhZ2UgbG9va3VwKQpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8q
IG9uIGEgc2VwYXJhdGUgbGluZQojMzE6IEZJTEU6IHRhcmdldC9hcm0vc3ZlX2hlbHBlci5jOjE2
MzM6CisvKiBCaWctZW5kaWFuIGhvc3RzIG5lZWQgdG8gZnJvYiB0aGUgYnl0ZSBpbmRpY2VzLiAg
SWYgdGhlIGNvcHkKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMjgxIGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDgvMTggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KOS8xOCBDaGVja2luZyBj
b21taXQgNWQxMDNlYTZiYjVmICh0YXJnZXQvYXJtOiBBZGp1c3QgaW50ZXJmYWNlIG9mIHN2ZV9s
ZDFfaG9zdF9mbikKMTAvMTggQ2hlY2tpbmcgY29tbWl0IDMzNjM1M2UxZWVhZSAodGFyZ2V0L2Fy
bTogVXNlIFNWRUNvbnRMZFN0IGluIHN2ZV9sZDFfcikKMTEvMTggQ2hlY2tpbmcgY29tbWl0IGIw
ZTIyZWMyZTU0ZSAodGFyZ2V0L2FybTogSGFuZGxlIHdhdGNocG9pbnRzIGluIHN2ZV9sZDFfcikK
MTIvMTggQ2hlY2tpbmcgY29tbWl0IGZhNWEyNDJlMjVkMiAodGFyZ2V0L2FybTogVXNlIFNWRUNv
bnRMZFN0IGZvciBtdWx0aS1yZWdpc3RlciBjb250aWd1b3VzIGxvYWRzKQoxMy8xOCBDaGVja2lu
ZyBjb21taXQgNjRkYzhiZDhjMTNkICh0YXJnZXQvYXJtOiBVcGRhdGUgY29udGlndW91cyBmaXJz
dC1mYXVsdCBhbmQgbm8tZmF1bHQgbG9hZHMpCjE0LzE4IENoZWNraW5nIGNvbW1pdCAwNzJlNjY1
NjYzYjUgKHRhcmdldC9hcm06IFVzZSBTVkVDb250TGRTdCBmb3IgY29udGlndW91cyBzdG9yZXMp
CjE1LzE4IENoZWNraW5nIGNvbW1pdCAxZjIzMGU1MjFhMWQgKHRhcmdldC9hcm06IFJldXNlIHN2
ZV9wcm9iZV9wYWdlIGZvciBnYXRoZXIgZmlyc3QtZmF1bHQgbG9hZHMpCjE2LzE4IENoZWNraW5n
IGNvbW1pdCA5YzJiYmYzMTJmNmMgKHRhcmdldC9hcm06IFJldXNlIHN2ZV9wcm9iZV9wYWdlIGZv
ciBzY2F0dGVyIHN0b3JlcykKMTcvMTggQ2hlY2tpbmcgY29tbWl0IGNlY2I4ZTg3MTQ4NSAodGFy
Z2V0L2FybTogUmV1c2Ugc3ZlX3Byb2JlX3BhZ2UgZm9yIGdhdGhlciBsb2FkcykKMTgvMTggQ2hl
Y2tpbmcgY29tbWl0IDRjYzQ0OWZhMDdjMCAodGFyZ2V0L2FybTogUmVtb3ZlIHN2ZV9tZW1vcGlk
eCkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDA0MjIwNDMzMDkuMTg0MzAtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3Rpbmcu
Y2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

