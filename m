Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D4AC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 05:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67FC2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 05:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67FC2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaZDE-0003iK-UQ
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 00:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iaYz4-0005Fn-Pq
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 00:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iaYyz-0007J2-HL
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 00:38:23 -0500
Resent-Date: Fri, 29 Nov 2019 00:38:22 -0500
Resent-Message-Id: <E1iaYyz-0007J2-HL@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iaYyz-000759-4h
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 00:38:21 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575005699; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RH4b1LVMr33IEambYAnaiV44/AyARSESdWAPPT1pARDhL/VOwLTZvfYkHpH/GJOA4ESGyhSXLPX3Q7NhD5RWVr0odhmKgJoOr1sUpxf5lR5oRQym5OEk7j0FtwTJrXtil7aiE+LKudVJHZ84KTBiOR0n9rFJZqCZ2Z5/m1pnEME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575005699;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=JzMwrCibrqf+WP1NqDjagy3DJz3LE0wNpKto0FMBjts=; 
 b=D/RU/3D6rgbSLsjxmYek0n8JuvmVgx5JOs3bXRsB4KF+AxyvQaQGScYSfNTtHE3oeEpGk/L0+8ySWa/vRNjaEtbeQeA7TMr6VkzFWXoyUiW7M+XrMuNmLKUgPN8x2uIqEtFRITkWwas6XpvuJdwnPEHvmZQLMJ+ndvVykTDY/KQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575005697887233.08838934653045;
 Thu, 28 Nov 2019 21:34:57 -0800 (PST)
In-Reply-To: <20191128141518.628245-1-marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <157500569655.16987.1064228686679092901@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Thu, 28 Nov 2019 21:34:57 -0800 (PST)
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyODE0MTUxOC42Mjgy
NDUtMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAwLzJdIFJGQzogYWRkIC1tZW0t
c2hhcmVkIG9wdGlvbgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTExMjgxNDE1MTguNjI4
MjQ1LTEtbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmUyNTM3ZGEgQWRkIC1tZW0t
c2hhcmVkIG9wdGlvbgo2MjNkMDQ0IG1lbWZkOiBhZGQgcWVtdV9tZW1mZF9vcGVuKCkKCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvMiBDaGVja2luZyBjb21taXQgNjIzZDA0NDAyM2QxIChtZW1mZDog
YWRkIHFlbXVfbWVtZmRfb3BlbigpKQoyLzIgQ2hlY2tpbmcgY29tbWl0IGUyNTM3ZGEzNDY2MyAo
QWRkIC1tZW0tc2hhcmVkIG9wdGlvbikKRVJST1I6IGRvIG5vdCBpbml0aWFsaXNlIGdsb2JhbHMg
dG8gMCBvciBOVUxMCiMxMjM6IEZJTEU6IHZsLmM6MTQ2OgoraW50IG1lbV9zaGFyZWQgPSAwOwoK
dG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA5MCBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzIg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTI4MTQxNTE4LjYyODI0NS0xLW1hcmNhbmRyZS5s
dXJlYXVAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


