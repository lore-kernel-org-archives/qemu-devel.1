Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3540C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B849121479
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B849121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7N1W-0007K1-ON
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7N0r-0006sH-LK
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7N0q-0007qf-0Z
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:59:37 -0400
Resent-Date: Mon, 09 Sep 2019 12:59:37 -0400
Resent-Message-Id: <E1i7N0q-0007qf-0Z@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7N0p-0007pW-P0; Mon, 09 Sep 2019 12:59:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568048344; cv=none; d=zoho.com; s=zohoarc; 
 b=YMsSmXGagq9FsOxpDkzCtg6MXjHhFxpkzgAYCdFyJK8veFzCufAUkW0vZ6HbmhCNvawenRwFjBi9svGfvlu5neXxE6IRwmBOse8H7vkq/dbvYvoc9QGkdvVWaokDF0K4AxKX7XLPD3EPHPS2nC1n2Ce2syRNy+pJxmN0jtK18dc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568048344;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=CUJ4kCHzXUBJ4VxnmMMdskOB2iA24iN3923ixoN95zQ=; 
 b=eAoLz20BcVBb82SEtB9/Jpvk95R/1bzLGxLofRJ2d0CoTGmrh8YkBNIEAfzzOrZoSCLbDFOC9PfnBvtWWEEVlWS8IuM0YdNpmd2sBnPMVq44PI36W8oevslLTTi3iqhRQhxAZ966lXY81TIcrLI5jnf2Xmhr4WXWvaU4eAXZ1IE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568048341663807.2956444599296;
 Mon, 9 Sep 2019 09:59:01 -0700 (PDT)
In-Reply-To: <20190909155813.27760-1-laurent@vivier.eu>
Message-ID: <156804833939.9541.13868273102848513200@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Mon, 9 Sep 2019 09:59:01 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [PATCH v9 0/9] hw/m68k: add Apple Machintosh
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
 dgilbert@redhat.com, hpoussin@reactos.org, kraxel@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com,
 aurelien@aurel32.net, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkwOTE1NTgxMy4yNzc2
MC0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY5IDAvOV0gaHcvbTY4azog
YWRkIEFwcGxlIE1hY2hpbnRvc2ggUXVhZHJhIDgwMCBtYWNoaW5lCk1lc3NhZ2UtaWQ6IDIwMTkw
OTA5MTU1ODEzLjI3NzYwLTEtbGF1cmVudEB2aXZpZXIuZXUKVHlwZTogc2VyaWVzCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYv
bnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIx
NjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXBy
b2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMTkwOTA2MTEzNTM0LjEw
OTA3LTEtdGh1dGhAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTkwOTA2MTEzNTM0LjEwOTA3LTEt
dGh1dGhAcmVkaGF0LmNvbQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMTkwOTA2MTEz
OTIwLjExMjcxLTEtdGh1dGhAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTkwOTA2MTEzOTIwLjEx
MjcxLTEtdGh1dGhAcmVkaGF0LmNvbQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMTkw
OTA2MTUyNjI0LjE0Nzg0LTEtdGh1dGhAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTkwOTA2MTUy
NjI0LjE0Nzg0LTEtdGh1dGhAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3
LzIwMTkwOTA5MTU1ODEzLjI3NzYwLTEtbGF1cmVudEB2aXZpZXIuZXUgLT4gcGF0Y2hldy8yMDE5
MDkwOTE1NTgxMy4yNzc2MC0xLWxhdXJlbnRAdml2aWVyLmV1ClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKMGQ4YTgwNSBody9tNjhrOiBkZWZpbmUgTWFjaW50b3NoIFF1YWRyYSA4MDAK
MmU4MDlmOCBody9tNjhrOiBhZGQgYSBkdW1teSBTV0lNIGZsb3BweSBjb250cm9sbGVyCjlkYjFh
ODMgaHcvbTY4azogYWRkIE51YnVzIHN1cHBvcnQgZm9yIG1hY2ZiIHZpZGVvIGNhcmQKOWQ4MjE0
OCBody9tNjhrOiBhZGQgTnVidXMgc3VwcG9ydAphYmUzNGY1IGh3L202OGs6IGFkZCBtYWNmYiB2
aWRlbyBjYXJkCjM1NWU5YWIgaHcvbTY4azogaW1wbGVtZW50IEFEQiBidXMgc3VwcG9ydCBmb3Ig
dmlhCjFkMThiYTYgaHcvbTY4azogYWRkIHZpYSBzdXBwb3J0CmZiYjFlY2YgZHA4MzkzeDogbWFu
YWdlIGJpZyBlbmRpYW4gYnVzCmQ2MGU2YTkgZXNwOiBhZGQgcHNldWRvLURNQSBhcyB1c2VkIGJ5
IE1hY2ludG9zaAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS85IENoZWNraW5nIGNvbW1pdCBkNjBl
NmE5NGFjMGIgKGVzcDogYWRkIHBzZXVkby1ETUEgYXMgdXNlZCBieSBNYWNpbnRvc2gpCjIvOSBD
aGVja2luZyBjb21taXQgZmJiMWVjZmU2NjFmIChkcDgzOTN4OiBtYW5hZ2UgYmlnIGVuZGlhbiBi
dXMpCjMvOSBDaGVja2luZyBjb21taXQgMWQxOGJhNjdhOGZmIChody9tNjhrOiBhZGQgdmlhIHN1
cHBvcnQpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJ
TlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzM5OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9S
OiBzcGFjZSBwcm9oaWJpdGVkIGFmdGVyIHRoYXQgJyYmJyAoY3R4Old4VykKIzM4NzogRklMRTog
aHcvbWlzYy9tYWNfdmlhLmM6MzQ0OgorICAgICAgICBpZiAoISh2MXMtPmxhc3RfYiAmIFZJQTFC
X3ZSVENDbGspICYmIChzLT5iICYgVklBMUJfdlJUQ0NsaykpIHsKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3Ms
IDgxNCBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
CjQvOSBDaGVja2luZyBjb21taXQgMzU1ZTlhYjg0MTNlIChody9tNjhrOiBpbXBsZW1lbnQgQURC
IGJ1cyBzdXBwb3J0IGZvciB2aWEpCjUvOSBDaGVja2luZyBjb21taXQgYWJlMzRmNTM2NjdiICho
dy9tNjhrOiBhZGQgbWFjZmIgdmlkZW8gY2FyZCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRl
bGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNTM6IApuZXcg
ZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1MDQgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggNS85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjYvOSBDaGVja2lu
ZyBjb21taXQgOWQ4MjE0ODBkOGQ5IChody9tNjhrOiBhZGQgTnVidXMgc3VwcG9ydCkKV0FSTklO
RzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVk
IHVwZGF0aW5nPwojMzg6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAx
IHdhcm5pbmdzLCA1MTggbGluZXMgY2hlY2tlZAoKUGF0Y2ggNi85IGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCjcvOSBDaGVja2luZyBjb21taXQgOWRiMWE4Mzk5MTljIChody9tNjhrOiBhZGQg
TnVidXMgc3VwcG9ydCBmb3IgbWFjZmIgdmlkZW8gY2FyZCkKOC85IENoZWNraW5nIGNvbW1pdCAy
ZTgwOWY4MDA2MDkgKGh3L202OGs6IGFkZCBhIGR1bW15IFNXSU0gZmxvcHB5IGNvbnRyb2xsZXIp
CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5F
UlMgbmVlZCB1cGRhdGluZz8KIzM3OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVy
cm9ycywgMSB3YXJuaW5ncywgNTEwIGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvOSBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgo5LzkgQ2hlY2tpbmcgY29tbWl0IDBkOGE4MDUzODk2OCAoaHcvbTY4
azogZGVmaW5lIE1hY2ludG9zaCBRdWFkcmEgODAwKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3Ig
ZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM5NjogCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDUzOSBsaW5l
cyBjaGVja2VkCgpQYXRjaCA5LzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MDkxNTU4MTMu
Mjc3NjAtMS1sYXVyZW50QHZpdmllci5ldS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=


