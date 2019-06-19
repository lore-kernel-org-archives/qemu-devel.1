Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HEXHASH_WORD,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB9CC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB1120B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB1120B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35850 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdVy0-0004jx-LT
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 04:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44264)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdVwM-0003ar-KR
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdVwJ-0005Uw-QO
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:27:34 -0400
Resent-Date: Wed, 19 Jun 2019 04:27:34 -0400
Resent-Message-Id: <E1hdVwJ-0005Uw-QO@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdVwJ-0005Se-I6
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:27:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560932833; cv=none; d=zoho.com; s=zohoarc; 
 b=kB3vK1ZyH30baRFnGYsAtco2cOv7zKRWmpeoJmAwJBzM/jTjFhoUP4b/LppTGNmR3luPkiYYAU89zSa07eHgTKRRL/jCaAuVFdyHpzvxwDHNgpgZMzNIYeTygaUSWV/DQj+Gq8gzELrUMZDmU5A+bhDLBOmPPddBFtg133tI+ZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560932833;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=Fl/ps4rfBPjjt1i5XZKDj9TtpIEoOyZV1m+OCfO5pM8=; 
 b=a+HH70un4z6N1tSfNHlsliBJUP0L4+Nf2F73J1ehBF4aoLMQEbQTA5uf/M7d/FsZKV7kC0Sm100X+yUiA9ZzabFkAz2y3xnMUS8NeA05Spz4tPRqyGedAyDVX4n2nzcHHaxSEgiias1xI1T7rHAqkYR2lXCm9TYQyg4n5gRlngI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560932832853164.89248384764585;
 Wed, 19 Jun 2019 01:27:12 -0700 (PDT)
In-Reply-To: <20190619075643.10048-1-david.brenken@efs-auto.org>
Message-ID: <156093283184.22612.18121749537139433640@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david.brenken@efs-auto.org
Date: Wed, 19 Jun 2019 01:27:12 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v2 0/5] tricore: adding new instructions
 and fixing issues
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
Cc: kbastian@mail.uni-paderborn.de, david.brenken@efs-auto.de,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxOTA3NTY0My4xMDA0
OC0xLWRhdmlkLmJyZW5rZW5AZWZzLWF1dG8ub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1z
IHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9y
Cm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYyIDAvNV0g
dHJpY29yZTogYWRkaW5nIG5ldyBpbnN0cnVjdGlvbnMgYW5kIGZpeGluZyBpc3N1ZXMKVHlwZTog
c2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwNjE5MDc1NjQzLjEwMDQ4LTEtZGF2aWQuYnJlbmtlbkBl
ZnMtYXV0by5vcmcKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJl
di1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0
dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAg
ICAgICAgICBwYXRjaGV3LzIwMTkwNjE5MDc1NjQzLjEwMDQ4LTEtZGF2aWQuYnJlbmtlbkBlZnMt
YXV0by5vcmcgLT4gcGF0Y2hldy8yMDE5MDYxOTA3NTY0My4xMDA0OC0xLWRhdmlkLmJyZW5rZW5A
ZWZzLWF1dG8ub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYjQzMTVlMGI2NCB0
cmljb3JlOiByZXNldCBEaXNhc0NvbnRleHQgYmVmb3JlIGdlbmVyYXRpbmcgY29kZQo5MTVmOTY1
NzhkIHRyaWNvcmU6IGFkZCBRU0VFRCBpbnN0cnVjdGlvbgpjZjk3YjgyMTg5IHRyaWNvcmU6IGZp
eCBSUlBXX0lOU0VSVCBpbnN0cnVjdGlvbgphMzE3MGE2YzQxIHRyaWNvcmU6IGFkZCBVVE9GIGlu
c3RydWN0aW9uCjczNjY1NDJjYzYgdHJpY29yZTogYWRkIEZUT0laIGluc3RydWN0aW9uCgo9PT0g
T1VUUFVUIEJFR0lOID09PQoxLzUgQ2hlY2tpbmcgY29tbWl0IDczNjY1NDJjYzYzOSAodHJpY29y
ZTogYWRkIEZUT0laIGluc3RydWN0aW9uKQoyLzUgQ2hlY2tpbmcgY29tbWl0IGEzMTcwYTZjNDFi
OCAodHJpY29yZTogYWRkIFVUT0YgaW5zdHJ1Y3Rpb24pCjMvNSBDaGVja2luZyBjb21taXQgY2Y5
N2I4MjE4OTE4ICh0cmljb3JlOiBmaXggUlJQV19JTlNFUlQgaW5zdHJ1Y3Rpb24pCjQvNSBDaGVj
a2luZyBjb21taXQgOTE1Zjk2NTc4ZGI2ICh0cmljb3JlOiBhZGQgUVNFRUQgaW5zdHJ1Y3Rpb24p
CkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMxNDY6IEZJTEU6IHRhcmdldC90cmljb3JlL3Ry
YW5zbGF0ZS5jOjY3NTU6CisgICAgICAgIGJyZWFrO15JXkleSV5JJAoKRVJST1I6IGNvZGUgaW5k
ZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTQ2OiBGSUxFOiB0YXJnZXQvdHJpY29yZS90cmFu
c2xhdGUuYzo2NzU1OgorICAgICAgICBicmVhazteSV5JXkleSSQKCnRvdGFsOiAyIGVycm9ycywg
MCB3YXJuaW5ncywgMTE5IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKNS81IENoZWNraW5nIGNvbW1pdCBiNDMxNWUwYjY0ZWQgKHRyaWNvcmU6IHJl
c2V0IERpc2FzQ29udGV4dCBiZWZvcmUgZ2VuZXJhdGluZyBjb2RlKQo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDYxOTA3NTY0My4xMDA0OC0x
LWRhdmlkLmJyZW5rZW5AZWZzLWF1dG8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


