Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07DEC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 20:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FEC2075B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 20:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FEC2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50395 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVMGY-0002P2-PE
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 16:30:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hVMFf-0001yP-DE
	for qemu-devel@nongnu.org; Mon, 27 May 2019 16:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hVMFe-0000dw-5B
	for qemu-devel@nongnu.org; Mon, 27 May 2019 16:29:47 -0400
Resent-Date: Mon, 27 May 2019 16:29:47 -0400
Resent-Message-Id: <E1hVMFe-0000dw-5B@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hVMFd-0000aq-UT
	for qemu-devel@nongnu.org; Mon, 27 May 2019 16:29:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558946593; cv=none; d=zoho.com; s=zohoarc; 
	b=ehhIBuP3FKSiyYGJg7ZYsCBX3CBbuH728J6BTlFsJSrM0+NaoKFwt/TLehiVOD1jS5wUyEE7dlqVPfCBwFsHWaNZYn0SDQ6FT4cEIseyff/c3PhZYtRNJN3qUmmM97YopKFqudQSweWTIldumjwzO2alhhyTdL8HQsoSrkN+wDk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1558946593;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=GPdXmYTh0VexcDsXAY8F9yMDmkZZ/DNByNCUqYWz9Ts=; 
	b=AlM0uIfK4piys75FXCLDxz+X7rG4+sdUph7KUYSz1u9QRYnt3S5xXxQhfPDt0c3QI/hsj3+cvERkEgBLAvF+mtUtr/hzlua0PpIrZBlTsydlItJ+YR/bw5qWcNx1pNxdrg4KIQ8RoaJSXMdRwLwy2yamYkPgUaGafZwgrUurHqA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1558946591653988.6810850674003;
	Mon, 27 May 2019 01:43:11 -0700 (PDT)
Message-ID: <155894659023.3183.17516300990819449117@d1b27de2824c>
In-Reply-To: <20190527080327.10780-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mehta.aaru20@gmail.com
Date: Mon, 27 May 2019 01:43:11 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH v3 0/8] Add support for io_uring
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	mreitz@redhat.com, saket.sinha89@gmail.com, stefanha@redhat.com,
	jusual@mail.ru, mehta.aaru20@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUyNzA4MDMyNy4xMDc4
MC0xLW1laHRhLmFhcnUyMEBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNTI3MDgwMzI3LjEwNzgwLTEtbWVodGEu
YWFydTIwQGdtYWlsLmNvbQpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRD
SCB2MyAwLzhdIEFkZCBzdXBwb3J0IGZvciBpb191cmluZwoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNjI1Njk3ZSBi
bG9jay9maWxlcG9zaXg6IGV4dGVuZCB0byB1c2UgaW9fdXJpbmcKMzNjZjhhOCBibG9ja2Rldjog
YWNjZXB0IGlvX3VyaW5nIGFzIG9wdGlvbgoxYjdlOGMwIHV0aWwvYXN5bmM6IGFkZCBhaW8gaW50
ZXJmYWNlcyBmb3IgaW9fdXJpbmcKNTY1NjAzOCBzdHViczogYWRkIHN0dWJzIGZvciBpb191cmlu
ZyBpbnRlcmZhY2UKNzQyNTJkNCBibG9jay9pb191cmluZzogaW1wbGVtZW50cyBpbnRlcmZhY2Vz
IGZvciBpb191cmluZwoyMDljY2MxIGJsb2NrL2Jsb2NrOiBhZGQgQkRSViBmbGFnIGZvciBpb191
cmluZwpjNTc3MjE3IHFhcGkvYmxvY2stY29yZTogYWRkIG9wdGlvbiBmb3IgaW9fdXJpbmcKZjRk
MDUwMSBjb25maWd1cmU6IHBlcm1pdCB1c2Ugb2YgaW9fdXJpbmcKCj09PSBPVVRQVVQgQkVHSU4g
PT09CjEvOCBDaGVja2luZyBjb21taXQgZjRkMDUwMWYwMTY1IChjb25maWd1cmU6IHBlcm1pdCB1
c2Ugb2YgaW9fdXJpbmcpCjIvOCBDaGVja2luZyBjb21taXQgYzU3NzIxNzFkZGFkIChxYXBpL2Js
b2NrLWNvcmU6IGFkZCBvcHRpb24gZm9yIGlvX3VyaW5nKQozLzggQ2hlY2tpbmcgY29tbWl0IDIw
OWNjYzFhY2E1NCAoYmxvY2svYmxvY2s6IGFkZCBCRFJWIGZsYWcgZm9yIGlvX3VyaW5nKQo0Lzgg
Q2hlY2tpbmcgY29tbWl0IDc0MjUyZDRmNDg0OSAoYmxvY2svaW9fdXJpbmc6IGltcGxlbWVudHMg
aW50ZXJmYWNlcyBmb3IgaW9fdXJpbmcpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVk
IGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzQ5OiAKbmV3IGZpbGUg
bW9kZSAxMDA2NDQKCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUgdGhlIG9wZW4gcGFyZW50
aGVzaXMgJygnCiMxOTY6IEZJTEU6IGJsb2NrL2lvX3VyaW5nLmM6MTQzOgorICAgIHdoaWxlKCFz
LT5pb19xLmluX3F1ZXVlKSB7CgpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFjZQojMjA5OiBGSUxF
OiBibG9jay9pb191cmluZy5jOjE1NjoKKyAgICAgICAgaWYgKHJldCA8PSAwKSB7ICQKCnRvdGFs
OiAyIGVycm9ycywgMSB3YXJuaW5ncywgMzg3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvOCBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoKNS84IENoZWNraW5nIGNvbW1pdCA1NjU2MDM4NDAzNjIg
KHN0dWJzOiBhZGQgc3R1YnMgZm9yIGlvX3VyaW5nIGludGVyZmFjZSkKV0FSTklORzogYWRkZWQs
IG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5n
PwojMzU6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdz
LCA0NiBsaW5lcyBjaGVja2VkCgpQYXRjaCA1LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
Ni84IENoZWNraW5nIGNvbW1pdCAxYjdlOGMwYjk4MjYgKHV0aWwvYXN5bmM6IGFkZCBhaW8gaW50
ZXJmYWNlcyBmb3IgaW9fdXJpbmcpCjcvOCBDaGVja2luZyBjb21taXQgMzNjZjhhOGQ0YTBkIChi
bG9ja2RldjogYWNjZXB0IGlvX3VyaW5nIGFzIG9wdGlvbikKOC84IENoZWNraW5nIGNvbW1pdCA2
MjU2OTdlZDI4OTEgKGJsb2NrL2ZpbGVwb3NpeDogZXh0ZW5kIHRvIHVzZSBpb191cmluZykKPT09
IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA1Mjcw
ODAzMjcuMTA3ODAtMS1tZWh0YS5hYXJ1MjBAZ21haWwuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


