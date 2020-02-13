Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC5BC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F6C2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F6C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Nk1-0000TI-CX
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j2NjU-0008UC-05
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j2NjS-0002PV-9u
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:17:19 -0500
Resent-Date: Thu, 13 Feb 2020 18:17:19 -0500
Resent-Message-Id: <E1j2NjS-0002PV-9u@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j2NjS-0002Nm-2Y
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:17:18 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581635795; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=h4ytKTuKvMY1cerg2fvsdAoP+K+3Oo8r+ukRNp0CLeZK2KkdFdZvQGXVl+YYKVL4uralSs+T2kW6ofMT7PoHkNGGq9ElnItZTqi3H6QzFJuId6sq9tz2WblbDNbdU43k/r05tj12G1apSwtF0GvMZGtCkTezFoaFIgnS/fa2YcM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581635795;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=PioVlYYXokYIPf+rdMWAtuASV3PpCOIijjUN8XQrfV4=; 
 b=QDwN/od1GW0eyH2fL+ImNfY8HS3JK1Jwv37niH0T7tkcVYioWlRd6mlozCilqvIfzW8j+qDEJi+3axAM7zTQDmbmUSsOtqybDvFQF5w+h6VkepB6duk9313I/5MaQPM6ga7LvzDnzrxRKRAT32+4LIx1O+v4Sf/fMSCLm5pnsdk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581635792696716.2592488924191;
 Thu, 13 Feb 2020 15:16:32 -0800 (PST)
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
Subject: Re: [PATCH  v2 00/19] testing and plugin updates
Message-ID: <158163579054.29586.11974919948451964997@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Thu, 13 Feb 2020 15:16:32 -0800 (PST)
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 kuhn.chenqun@huawei.com, stefanb@linux.vnet.ibm.com, peter.puhov@linaro.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 f4bug@amsat.org, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxMzIyNTEwOS4xMzEy
MC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAgdjIgMDAvMTldIHRlc3RpbmcgYW5kIHBs
dWdpbiB1cGRhdGVzCk1lc3NhZ2UtaWQ6IDIwMjAwMjEzMjI1MTA5LjEzMTIwLTEtYWxleC5iZW5u
ZWVAbGluYXJvLm9yZwpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0
CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFn
XSAgICAgICAgIHBhdGNoZXcvMjAyMDAyMTMyMjUxMDkuMTMxMjAtMS1hbGV4LmJlbm5lZUBsaW5h
cm8ub3JnIC0+IHBhdGNoZXcvMjAyMDAyMTMyMjUxMDkuMTMxMjAtMS1hbGV4LmJlbm5lZUBsaW5h
cm8ub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMzEwOWEyNiB0ZXN0cy90Y2c6
IHRha2UgaW50byBhY2NvdW50IGV4cGVjdGVkIGNsYXNoZXMgcGF1dGgtNApiZDA4OGRhIHRlc3Rz
L3RjZzogZml4IHR5cG8gaW4gY29uZmlndXJlLnNoIHRlc3QgZm9yIHY4LjMKNDVlMDY2MSB0Y2c6
IHNhdmUgdmFkZHIgdGVtcCBmb3IgcGx1Z2luIHVzYWdlCjQ2NWU1NDUgdGVzdHMvdGNnOiBnaXZl
IGRlYnVnIGJ1aWxkcyBhIGxpdHRsZSBiaXQgbG9uZ2VyCjFkYzM1N2UgdGVzdHMvcGx1Z2luczog
bWFrZSBob3d2ZWMgY2xlYW4tdXAgYWZ0ZXIgaXRzZWxmLgpmY2I4NTYyIHRhcmdldC9yaXNjdjog
cHJvZ3Jlc3NpdmVseSBsb2FkIHRoZSBpbnN0cnVjdGlvbiBkdXJpbmcgZGVjb2RlCjJlNjczNGMg
cWVtdS9iaXRvcHMuaDogQWRkIGV4dHJhY3Q4IGFuZCBleHRyYWN0MTYKMjFmZjdlMyB0ZXN0cy9w
bHVnaW46IHByZXZlbnQgdW5pbml0aWFsaXplZCB3YXJuaW5nCjgxZjIwMzkgcGx1Z2lucy9jb3Jl
OiBhZGQgbWlzc2luZyBicmVhayBpbiBjYl90b190Y2dfZmxhZ3MKODA2NTFjZiBkb2NzL2RldmVs
OiBkb2N1bWVudCBxdWVyeSBoYW5kbGUgbGlmZXRpbWVzCjlkYzNkNmQgdHJhY2luZzogb25seSBh
bGxvdyAtdHJhY2UgdG8gb3ZlcnJpZGUgLUQgaWYgc2V0CmViMmUwYWQgdGVzdHMvaW90ZXN0czog
YmUgYSBsaXR0bGUgbW9yZSBmb3JnaXZpbmcgb24gdGhlIHNpemUgdGVzdAo0ZDkwZWUyIHRyYXZp
cy55bWw6IHNpbmdsZS10aHJlYWQgYnVpbGQtdGNnIHN0YWdlcwozNDI1ZGYyIHRyYXZpcy55bWw6
IEZpeCBUcmF2aXMgWUFNTCBjb25maWd1cmF0aW9uIHdhcm5pbmdzCjQ5YjUzMTAgdHJhdmlzLnlt
bDogVGVzdCB0aGUgczM5MC1jY3cgYnVpbGQsIHRvbwo0ZWYzMGI5IHRlc3RzL3JjdXRvcnR1cmU6
IG1pbGQgZG9jdW1lbnRpbmcgcmVmYWN0b3Igb2YgdXBkYXRlIHRocmVhZAoyMzkwNWExIHRlc3Rz
L3JjdXRvcnR1cmU6IGJldHRlciBkb2N1bWVudCBsb2NraW5nIG9mIHN0YXRzCmMzYTIwZmMgdGVz
dHMvcmN1dG9ydHVyZTogdXBkYXRlIHVzYWdlIGhpbnQKZTMxMjMzYiB0ZXN0cy90Y2c6IGluY2x1
ZGUgYSBza2lwIHJ1bm5lciBmb3IgcGF1dGgzIHdpdGggcGx1Z2lucwoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KMS8xOSBDaGVja2luZyBjb21taXQgZTMxMjMzYmE1Njc3ICh0ZXN0cy90Y2c6IGluY2x1
ZGUgYSBza2lwIHJ1bm5lciBmb3IgcGF1dGgzIHdpdGggcGx1Z2lucykKMi8xOSBDaGVja2luZyBj
b21taXQgYzNhMjBmYzM2MjM4ICh0ZXN0cy9yY3V0b3J0dXJlOiB1cGRhdGUgdXNhZ2UgaGludCkK
My8xOSBDaGVja2luZyBjb21taXQgMjM5MDVhMWI4ODUxICh0ZXN0cy9yY3V0b3J0dXJlOiBiZXR0
ZXIgZG9jdW1lbnQgbG9ja2luZyBvZiBzdGF0cykKNC8xOSBDaGVja2luZyBjb21taXQgNGVmMzBi
OTI1MGI5ICh0ZXN0cy9yY3V0b3J0dXJlOiBtaWxkIGRvY3VtZW50aW5nIHJlZmFjdG9yIG9mIHVw
ZGF0ZSB0aHJlYWQpCjUvMTkgQ2hlY2tpbmcgY29tbWl0IDQ5YjUzMTAwNDM5ZSAodHJhdmlzLnlt
bDogVGVzdCB0aGUgczM5MC1jY3cgYnVpbGQsIHRvbykKNi8xOSBDaGVja2luZyBjb21taXQgMzQy
NWRmMjQ0ZmNkICh0cmF2aXMueW1sOiBGaXggVHJhdmlzIFlBTUwgY29uZmlndXJhdGlvbiB3YXJu
aW5ncykKNy8xOSBDaGVja2luZyBjb21taXQgNGQ5MGVlMjYzOTZiICh0cmF2aXMueW1sOiBzaW5n
bGUtdGhyZWFkIGJ1aWxkLXRjZyBzdGFnZXMpCjgvMTkgQ2hlY2tpbmcgY29tbWl0IGViMmUwYWRk
YmY5NiAodGVzdHMvaW90ZXN0czogYmUgYSBsaXR0bGUgbW9yZSBmb3JnaXZpbmcgb24gdGhlIHNp
emUgdGVzdCkKOS8xOSBDaGVja2luZyBjb21taXQgOWRjM2Q2ZDg3N2JlICh0cmFjaW5nOiBvbmx5
IGFsbG93IC10cmFjZSB0byBvdmVycmlkZSAtRCBpZiBzZXQpCjEwLzE5IENoZWNraW5nIGNvbW1p
dCA4MDY1MWNmNGRkNmEgKGRvY3MvZGV2ZWw6IGRvY3VtZW50IHF1ZXJ5IGhhbmRsZSBsaWZldGlt
ZXMpCjExLzE5IENoZWNraW5nIGNvbW1pdCA4MWYyMDM5NDBhNDggKHBsdWdpbnMvY29yZTogYWRk
IG1pc3NpbmcgYnJlYWsgaW4gY2JfdG9fdGNnX2ZsYWdzKQoxMi8xOSBDaGVja2luZyBjb21taXQg
MjFmZjdlMzk2MjA3ICh0ZXN0cy9wbHVnaW46IHByZXZlbnQgdW5pbml0aWFsaXplZCB3YXJuaW5n
KQoxMy8xOSBDaGVja2luZyBjb21taXQgMmU2NzM0YzViMmIxIChxZW11L2JpdG9wcy5oOiBBZGQg
ZXh0cmFjdDggYW5kIGV4dHJhY3QxNikKMTQvMTkgQ2hlY2tpbmcgY29tbWl0IGZjYjg1NjI1Zjk2
YSAodGFyZ2V0L3Jpc2N2OiBwcm9ncmVzc2l2ZWx5IGxvYWQgdGhlIGluc3RydWN0aW9uIGR1cmlu
ZyBkZWNvZGUpCjE1LzE5IENoZWNraW5nIGNvbW1pdCAxZGMzNTdlOTk0NTcgKHRlc3RzL3BsdWdp
bnM6IG1ha2UgaG93dmVjIGNsZWFuLXVwIGFmdGVyIGl0c2VsZi4pCjE2LzE5IENoZWNraW5nIGNv
bW1pdCA0NjVlNTQ1NDA3MGEgKHRlc3RzL3RjZzogZ2l2ZSBkZWJ1ZyBidWlsZHMgYSBsaXR0bGUg
Yml0IGxvbmdlcikKMTcvMTkgQ2hlY2tpbmcgY29tbWl0IDQ1ZTA2NjE4OWQ0ZSAodGNnOiBzYXZl
IHZhZGRyIHRlbXAgZm9yIHBsdWdpbiB1c2FnZSkKMTgvMTkgQ2hlY2tpbmcgY29tbWl0IGJkMDg4
ZGFjMDdjYyAodGVzdHMvdGNnOiBmaXggdHlwbyBpbiBjb25maWd1cmUuc2ggdGVzdCBmb3Igdjgu
MykKMTkvMTkgQ2hlY2tpbmcgY29tbWl0IDMxMDlhMjY4ZDVhZSAodGVzdHMvdGNnOiB0YWtlIGlu
dG8gYWNjb3VudCBleHBlY3RlZCBjbGFzaGVzIHBhdXRoLTQpCldBUk5JTkc6IEJsb2NrIGNvbW1l
bnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiM2MDogRklMRTogdGVzdHMv
dGNnL2FhcmNoNjQvcGF1dGgtNC5jOjI1OgorICAgICAgICAgICAgOiAvKiBvdXQgKi8gIj1yIih4
KSwgIj1yIih5KQoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBh
IHNlcGFyYXRlIGxpbmUKIzYxOiBGSUxFOiB0ZXN0cy90Y2cvYWFyY2g2NC9wYXV0aC00LmM6MjY6
CisgICAgICAgICAgICA6IC8qIGluICovIFtpbl0gInIiIChpbikKCkVSUk9SOiBzcGFjZSBwcm9o
aWJpdGVkIGJlZm9yZSBvcGVuIHNxdWFyZSBicmFja2V0ICdbJwojNjE6IEZJTEU6IHRlc3RzL3Rj
Zy9hYXJjaDY0L3BhdXRoLTQuYzoyNjoKKyAgICAgICAgICAgIDogLyogaW4gKi8gW2luXSAiciIg
KGluKQoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFy
YXRlIGxpbmUKIzYyOiBGSUxFOiB0ZXN0cy90Y2cvYWFyY2g2NC9wYXV0aC00LmM6Mjc6CisgICAg
ICAgICAgICA6IC8qIGNsb2JiZXJzICovKTsKCnRvdGFsOiAxIGVycm9ycywgMyB3YXJuaW5ncywg
NjIgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMTkvMTkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAw
MjEzMjI1MTA5LjEzMTIwLTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

