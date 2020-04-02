Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C031C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F0E20678
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F0E20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK6Jw-0003v2-7W
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 16:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jK6H1-0007e3-Ee
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jK6H0-0003Jm-5S
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:17:11 -0400
Resent-Date: Thu, 02 Apr 2020 16:17:11 -0400
Resent-Message-Id: <E1jK6H0-0003Jm-5S@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jK6Gz-0003J7-UA
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:17:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585858626; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dYADNDNGqfd4N6Sqxf5k5bCtVUfzXoaug12HHV30ISf6Jh291zhUEamu9UrfLl3ZP8z/0KoXg4/qcN8fb1E1oVaEHclx5iq/cwtLglkGWDZnIHLrcegUoQxS9N277heFx5WODgVLEk5NYOyP03TQgVsD73x+VvCL2tsGx1in9aM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585858626;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vN2I6Tm0ahvjD12ANSGSj0VQ8HuyG8Hr4jXtWQ8DVic=; 
 b=F0l5ns4Wvr8aYXN6gNsz8JIiU7HqZTCY/34cHQ6M4UgstK/Ri7DjT9/KMsEkF89t1n3F970RvZZ9TvcJxdHhQvNb7PEbX35K/eappmhAgcfPb1JzUxN8lMm6D2/gfyERRtzRfoxZDHAXPx/MbnB3G2WYDWVhMoRBLRze4WeWdnk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158585862310753.021744121395955;
 Thu, 2 Apr 2020 13:17:03 -0700 (PDT)
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
Subject: Re: [PULL 00/15] Misc patches for 5.0-rc2
Message-ID: <158585862262.23425.11429239346277286637@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Thu, 2 Apr 2020 13:17:03 -0700 (PDT)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwMjE5MDY0MC4xNjkz
LTEtcGJvbnppbmlAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BVTEwgMDAvMTVdIE1pc2MgcGF0Y2hlcyBmb3IgNS4wLXJj
MgpNZXNzYWdlLWlkOiAyMDIwMDQwMjE5MDY0MC4xNjkzLTEtcGJvbnppbmlAcmVkaGF0LmNvbQpU
eXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJl
di1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpmYXRhbDog
dW5hYmxlIHRvIGFjY2VzcyAnaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11
Lyc6IFRoZSByZXF1ZXN0ZWQgVVJMIHJldHVybmVkIGVycm9yOiA1MDQKVHJhY2ViYWNrIChtb3N0
IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgInBhdGNoZXctdGVzdGVyMi9zcmMvcGF0Y2hldy1j
bGkiLCBsaW5lIDUzMSwgaW4gdGVzdF9vbmUKICAgIGdpdF9jbG9uZV9yZXBvKGNsb25lLCByWyJy
ZXBvIl0sIHJbImhlYWQiXSwgbG9nZiwgVHJ1ZSkKICBGaWxlICJwYXRjaGV3LXRlc3RlcjIvc3Jj
L3BhdGNoZXctY2xpIiwgbGluZSA1NCwgaW4gZ2l0X2Nsb25lX3JlcG8KICAgIHN0ZG91dD1sb2dm
LCBzdGRlcnI9bG9nZikKICBGaWxlICIvb3B0L3JoL3JoLXB5dGhvbjM2L3Jvb3QvdXNyL2xpYjY0
L3B5dGhvbjMuNi9zdWJwcm9jZXNzLnB5IiwgbGluZSAyOTEsIGluIGNoZWNrX2NhbGwKICAgIHJh
aXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJv
Y2Vzc0Vycm9yOiBDb21tYW5kICdbJ2dpdCcsICdmZXRjaCcsICczYzhjZjVhOWMyMWZmODc4MjE2
NGQxZGVmN2Y0NGJkODg4NzEzMzg0J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDEy
OC4KCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDIwMDQwMjE5MDY0MC4xNjkzLTEtcGJvbnppbmlAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNr
cGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

