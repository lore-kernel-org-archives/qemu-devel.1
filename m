Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF0AC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33BE20828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33BE20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2aoQ-0007Xn-Td
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i2anX-000764-UC
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i2anW-0005h0-85
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:42:07 -0400
Resent-Date: Tue, 27 Aug 2019 08:42:07 -0400
Resent-Message-Id: <E1i2anW-0005h0-85@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i2anW-0005et-0h
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:42:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566909710; cv=none; d=zoho.com; s=zohoarc; 
 b=auK11OA8CdksHLV1kSXMv/DVESrJsI+QLpz/M/cV/pWiDQ8hfJZo+O595DV9w3i8z16vkDQniPsgROMHatoc58m20FmJQxVplLtR+IWQ5zVzykSi7R4JNNYRJurTN93TwJnTc7IbAbyZazdPXoDwXjegLhtLs4s9YrD0KiL3ylo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1566909710;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=lP6eZjZ0dm0uL9WMM1+8INXdxoHeYIE+6ydEI8gp8CI=; 
 b=RHyWFjWQ/90QH7U9stkSikKVkw1pDuw8QDlrsDtv1dFsG/+GvjFXh/o9ufbfRIlwCii3OtfLHh7ghf94BFF3d8FrfBjox+FNkMGZFTt7sA0YVT/rapKlZ5auf7+rGaYSHjyhlXlo0vulgyXgN8FlO6M9kQJ2CoYWB1uLDihkOrU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1566909707951183.06626194914588;
 Tue, 27 Aug 2019 05:41:47 -0700 (PDT)
In-Reply-To: <20190827121339.15815-1-johannes@sipsolutions.net>
Message-ID: <156690970685.15196.10082634235049405155@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: johannes@sipsolutions.net
Date: Tue, 27 Aug 2019 05:41:47 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v2] libvhost-user-glib: fix VugDev main fd
 cleanup
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, johannes.berg@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgyNzEyMTMzOS4xNTgx
NS0xLWpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMg
dG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IK
bW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwODI3MTIxMzM5LjE1ODE1LTEtam9o
YW5uZXNAc2lwc29sdXRpb25zLm5ldApTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYyXSBs
aWJ2aG9zdC11c2VyLWdsaWI6IGZpeCBWdWdEZXYgbWFpbiBmZCBjbGVhbnVwClR5cGU6IHNlcmll
cwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJh
c2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1t
YWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5
YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNo
ICd0ZXN0JwozZjk3YzU2IGxpYnZob3N0LXVzZXItZ2xpYjogZml4IFZ1Z0RldiBtYWluIGZkIGNs
ZWFudXAKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2Fy
eSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzQzOiBGSUxFOiBjb250cmliL2xpYnZo
b3N0LXVzZXIvbGlidmhvc3QtdXNlci1nbGliLmM6MTM1OgorICAgIGlmICghc3JjKQpbLi4uXQoK
dG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA2MCBsaW5lcyBjaGVja2VkCgpDb21taXQgM2Y5
N2M1NjZkMTBmIChsaWJ2aG9zdC11c2VyLWdsaWI6IGZpeCBWdWdEZXYgbWFpbiBmZCBjbGVhbnVw
KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDgyNzEyMTMzOS4xNTgxNS0xLWpvaGFubmVzQHNp
cHNvbHV0aW9ucy5uZXQvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


