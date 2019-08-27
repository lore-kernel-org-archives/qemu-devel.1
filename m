Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ED2C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9172077B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 20:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9172077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2i1W-0006Se-Ka
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 16:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i2hvV-0007TP-6G
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i2hvT-0001Io-Bt
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:18:48 -0400
Resent-Date: Tue, 27 Aug 2019 16:18:48 -0400
Resent-Message-Id: <E1i2hvT-0001Io-Bt@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i2hvT-0001IU-4N
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 16:18:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566937114; cv=none; d=zoho.com; s=zohoarc; 
 b=LHudhouFyQbEtY4v/WwMWjCt+VngRzjTaCXCuzzZQEPICdfBP028gpMKIuyoLBeKVEgG0SJI5R8GT212IRo0drYXia6nD/34xcnaUJ17VH0LM6m0hYoBcxY5RswJe7N+oxtmIj/OIAjRnLc54r61pwDBjlA82+5AkoU3v/Xmjec=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1566937114;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=xoTIpnxovAd01fK+2+0ElNZaTL3CN3qiE5d7ZbRraIQ=; 
 b=jvmmfieyELfjYYH9799KdiE6YsqYdikzAgrFAc9RNemt+PrFxgwUXPIECn/9L+vgK6TGMYtCMVmJwU00BAoX1xB4GzSzYdskaca4jzmYejbcFjkFs+pkobgge9g4kJACy8/JYDwy8AToWGEaxschFWBgUNflpNIdNELX2BbRPkY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1566937113789321.95494974541054;
 Tue, 27 Aug 2019 13:18:33 -0700 (PDT)
In-Reply-To: <20190827194849.7076-1-sandra@codesourcery.com>
Message-ID: <156693711258.19632.14897118875137435674@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: sandra@codesourcery.com
Date: Tue, 27 Aug 2019 13:18:33 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] gdbstub: Fix handler for 'F' packet
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
Cc: alex.bennee@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org,
 arilou@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgyNzE5NDg0OS43MDc2
LTEtc2FuZHJhQGNvZGVzb3VyY2VyeS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwODI3MTk0ODQ5LjcwNzYtMS1zYW5kcmFA
Y29kZXNvdXJjZXJ5LmNvbQpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRD
SF0gZ2Ric3R1YjogRml4IGhhbmRsZXIgZm9yICdGJyBwYWNrZXQKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMDc0NGI0YiBnZGJz
dHViOiBGaXggaGFuZGxlciBmb3IgJ0YnIHBhY2tldAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJS
T1I6IHNwYWNlIHByb2hpYml0ZWQgYmVmb3JlIHRoYXQgY2xvc2UgcGFyZW50aGVzaXMgJyknCiMz
NzogRklMRTogZ2Ric3R1Yi5jOjE4Mjc6CisgICAgICAgIGlmIChnZGJfY3R4LT5udW1fcGFyYW1z
ID49IDIgKSB7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE3IGxpbmVzIGNoZWNrZWQK
CkNvbW1pdCAwNzQ0YjRiNGIwNmIgKGdkYnN0dWI6IEZpeCBoYW5kbGVyIGZvciAnRicgcGFja2V0
KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDgyNzE5NDg0OS43MDc2LTEtc2FuZHJhQGNvZGVz
b3VyY2VyeS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


