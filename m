Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C673C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 04:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5125A217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 04:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5125A217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j25of-0008Ci-N7
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 23:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j25o3-0007n5-5e
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 23:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j25o1-0003P3-P0
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 23:08:50 -0500
Resent-Date: Wed, 12 Feb 2020 23:08:50 -0500
Resent-Message-Id: <E1j25o1-0003P3-P0@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j25o1-0003OA-Hi
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 23:08:49 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581566925; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Te5/AE036M0Dv9TDX2IMESlhJullkYltjEBpPZT3JSnH9WhSjeVOg6lrWadv8W0kRDqjbDvBHfhQ+J+Lh5hejbH7/XWHPDz6G2fquqasuUF8fnZ9V0Eyb79YEkzN42H8ADi2mpzQeE1A9QQ5ShZRGzw4voQLz5iqf5tv4eeEu3w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581566925;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=NI+E9nBY0D9M9cgxbBn+COnJCF0YwDOCEVXr++2QWro=; 
 b=QqASEk/SstyMsDHUn3h1P3tUkl1QbLkKFatBpxhgKI0eCm18R/UFLSgvZegy7ZzUl65/Ey3Dn1hWXw5h8fBN9N54Ler3OF8VsAB30cIw4xrHN2PKoS9bzTyGRBre9TyNk+Y/PSZg0cyjOq46leqEtz9TTdh9lSju6OBGf3rSUpI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581566923234492.4647295961855;
 Wed, 12 Feb 2020 20:08:43 -0800 (PST)
In-Reply-To: <20200213032223.14643-1-richard.henderson@linaro.org>
Subject: Re: [PATCH v3 0/5] linux-user: Implement x86_64 vsyscalls
Message-ID: <158156692223.23372.13090254777346141971@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Wed, 12 Feb 2020 20:08:43 -0800 (PST)
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxMzAzMjIyMy4xNDY0
My0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MyAwLzVdIGxpbnV4LXVzZXI6
IEltcGxlbWVudCB4ODZfNjQgdnN5c2NhbGxzCk1lc3NhZ2UtaWQ6IDIwMjAwMjEzMDMyMjIzLjE0
NjQzLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpUeXBlOiBzZXJpZXMKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2
NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNGY4
YzMyNiBsaW51eC11c2VyOiBGbHVzaCBvdXQgaW1wbGVtZW50YXRpb24gb2YgZ2V0dGltZW9mZGF5
CjAzMzc2OTUgbGludXgtdXNlcjogQWRkIHg4Nl82NCB2c3lzY2FsbCBwYWdlIHRvIC9wcm9jL3Nl
bGYvbWFwcwoxMDM1ZDk0IGxpbnV4LXVzZXIvaTM4NjogRW11bGF0ZSB4ODZfNjQgdnN5c2NhbGxz
CmEwNmU4MmIgbGludXgtdXNlci9pMzg2OiBTcGxpdCBvdXQgZ2VuX3NpZ25hbAo3MDc5N2ZmIHRh
cmdldC9pMzg2OiBSZW51bWJlciBFWENQX1NZU0NBTEwKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEv
NSBDaGVja2luZyBjb21taXQgNzA3OTdmZmE3ODU3ICh0YXJnZXQvaTM4NjogUmVudW1iZXIgRVhD
UF9TWVNDQUxMKQoyLzUgQ2hlY2tpbmcgY29tbWl0IGEwNmU4MmIxZDNlMCAobGludXgtdXNlci9p
Mzg2OiBTcGxpdCBvdXQgZ2VuX3NpZ25hbCkKMy81IENoZWNraW5nIGNvbW1pdCAxMDM1ZDk0MzYw
YTggKGxpbnV4LXVzZXIvaTM4NjogRW11bGF0ZSB4ODZfNjQgdnN5c2NhbGxzKQo0LzUgQ2hlY2tp
bmcgY29tbWl0IDAzMzc2OTViOWE5MSAobGludXgtdXNlcjogQWRkIHg4Nl82NCB2c3lzY2FsbCBw
YWdlIHRvIC9wcm9jL3NlbGYvbWFwcykKRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzMwOiBG
SUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzo3MDIwOgorICAgIGRwcmludGYoZmQsIFRBUkdFVF9G
TVRfbHggIi0iIFRBUkdFVF9GTVRfbHggJAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAx
NiBsaW5lcyBjaGVja2VkCgpQYXRjaCA0LzUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2
aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0
aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjUv
NSBDaGVja2luZyBjb21taXQgNGY4YzMyNjg4ZjgyIChsaW51eC11c2VyOiBGbHVzaCBvdXQgaW1w
bGVtZW50YXRpb24gb2YgZ2V0dGltZW9mZGF5KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDIxMzAzMjIyMy4xNDY0My0xLXJpY2hhcmQuaGVu
ZGVyc29uQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t

