Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15069C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7E92080C
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7E92080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42846 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccJi-00069v-Jb
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hccIP-0004vy-Ae
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hccAd-0002p5-B5
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 16:54:36 -0400
Resent-Date: Sun, 16 Jun 2019 16:54:36 -0400
Resent-Message-Id: <E1hccAd-0002p5-B5@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hccAd-0002oT-2U; Sun, 16 Jun 2019 16:54:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560718456; cv=none; d=zoho.com; s=zohoarc; 
 b=hqR5vx7k6gV7D4DRVj8ZXk5k9K5HufVIClFJUqZZHbygrbuCG+gGY8rLL2nylNwNmE/AXnxk/VKfYb/b6RO4sDGEPdy/sj2S7Elk+iHoBEwH529GER3sf7xniGJTMmGjEn3EeyO0gEWjOKrojuIxvYFcsl31u50skWUDP7Lh06c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560718456;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=5dcQFLSNVmib8ftv14hVHKYkvxX3AmkFKNGHgB9n7XY=; 
 b=QeQf6+PbWgRU+J8dINd+ynAJnxN/cnlChzpcmtJtTLEtu3jFEJC2vawvZPUixKA5WaUkD5KG7aGHU4Vj6NGwgp0TO5sjCrgks2vfUbEgZMDRc2fBeXpeagcVmyvtRGDcTljYdcth8Uo7vieP/ERtI90TcOf8XIJg3aPZe3wpYa8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560718453821905.7702011182475;
 Sun, 16 Jun 2019 13:54:13 -0700 (PDT)
In-Reply-To: <20190616191900.GH61734@hippo.sing.id.au>
Message-ID: <156071845265.13573.2864992103449076842@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: joel@sing.id.au
Date: Sun, 16 Jun 2019 13:54:13 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
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
Cc: me@carlosedp.com, qemu-riscv@nongnu.org, palmer@sifive.com,
 qemu-devel@nongnu.org, Alistair.Francis@wdc.com, marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxNjE5MTkwMC5HSDYx
NzM0QGhpcHBvLnNpbmcuaWQuYXUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGF0b21pYyBmYWlsdXJlcyBv
biBxZW11LXN5c3RlbS1yaXNjdjY0ClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDYxNjE5
MTkwMC5HSDYxNzM0QGhpcHBvLnNpbmcuaWQuYXUKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFt
Ci4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQ
VCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQog
KiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTkwNjE2MTkxOTAwLkdINjE3MzRA
aGlwcG8uc2luZy5pZC5hdSAtPiBwYXRjaGV3LzIwMTkwNjE2MTkxOTAwLkdINjE3MzRAaGlwcG8u
c2luZy5pZC5hdQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmI1ODJjNmY4ZmMgYXRv
bWljIGZhaWx1cmVzIG9uIHFlbXUtc3lzdGVtLXJpc2N2NjQKCj09PSBPVVRQVVQgQkVHSU4gPT09
CldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBs
aW5lCiM4MTogRklMRTogdGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuYzoxMzY6CisgICAgLyogQ2xl
YXIgdGhlIGxvYWQgcmVzZXJ2YXRpb24gLSBvdGhlcndpc2UgYSByZXNlcnZhdGlvbiBwbGFjZWQg
aW4gb25lCgpFUlJPUjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBl
cnJvcnMsIDEgd2FybmluZ3MsIDM1IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBiNTgyYzZmOGZjY2Mg
KGF0b21pYyBmYWlsdXJlcyBvbiBxZW11LXN5c3RlbS1yaXNjdjY0KSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBj
b2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDE5MDYxNjE5MTkwMC5HSDYxNzM0QGhpcHBvLnNpbmcuaWQuYXUvdGVzdGluZy5jaGVj
a3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


