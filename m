Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HEXHASH_WORD,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551DCC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C12B208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C12B208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdW3M-0006R8-AO
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 04:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45494)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdW2J-0005zR-S2
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdW2I-0000jN-J6
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:33:43 -0400
Resent-Date: Wed, 19 Jun 2019 04:33:43 -0400
Resent-Message-Id: <E1hdW2I-0000jN-J6@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdW2I-0000bC-AU
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:33:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560933191; cv=none; d=zoho.com; s=zohoarc; 
 b=UV1i32YY5B8BV6yWmP1fQQKaxeHhkgyZmciIqGpBy9Y1nmXa/yTbgjctPnyzKE4i4WBkVxjuTvDvdb/R9QuJKWAEDyMPVJmKyJAVUm1tBFOt8HQ4g/DNX+LnNGsg8GVv0bnYoaTLe3z7VoVd25Qe+49rsms9H0LIs4Cw++5LfdI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560933191;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=J9Srm0GuMfYyYsFoPP4JTdmaD4AvVUMhg6wusYdd9Y4=; 
 b=JqdipeWhFP965+xNaHf0XUN4DPUJS4A7EEQQ7OkG1+JjoKeH+twwaqGumxy5YgvhfMO6HKM2t4A5TUipQgrvHxZrdfP4dFVzwjmsnIg6U1U/0mMEB1MR0jgTQjtKyMu+NWBAK2f4Q9amfwhzgQKcEY7hILrgSG1cA2lx1QUeAyg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560933190626189.61806370743113;
 Wed, 19 Jun 2019 01:33:10 -0700 (PDT)
In-Reply-To: <20190619075643.10048-1-david.brenken@efs-auto.org>
Message-ID: <156093318970.22612.14507276231180976214@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david.brenken@efs-auto.org
Date: Wed, 19 Jun 2019 01:33:10 -0700 (PDT)
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
dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogdCBbdGFnIHVwZGF0ZV0gICAg
ICAgICAgICBwYXRjaGV3LzIwMTkwNjE5MDc1NjQzLjEwMDQ4LTEtZGF2aWQuYnJlbmtlbkBlZnMt
YXV0by5vcmcgLT4gcGF0Y2hldy8yMDE5MDYxOTA3NTY0My4xMDA0OC0xLWRhdmlkLmJyZW5rZW5A
ZWZzLWF1dG8ub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKY2VmMGNjOWEyMyB0
cmljb3JlOiByZXNldCBEaXNhc0NvbnRleHQgYmVmb3JlIGdlbmVyYXRpbmcgY29kZQo3OTYxNzIx
YjYxIHRyaWNvcmU6IGFkZCBRU0VFRCBpbnN0cnVjdGlvbgpjMTE3M2E5NDkyIHRyaWNvcmU6IGZp
eCBSUlBXX0lOU0VSVCBpbnN0cnVjdGlvbgoyOWQ2YWViNjRjIHRyaWNvcmU6IGFkZCBVVE9GIGlu
c3RydWN0aW9uCmYwYjc1M2E2YzIgdHJpY29yZTogYWRkIEZUT0laIGluc3RydWN0aW9uCgo9PT0g
T1VUUFVUIEJFR0lOID09PQoxLzUgQ2hlY2tpbmcgY29tbWl0IGYwYjc1M2E2YzJkYSAodHJpY29y
ZTogYWRkIEZUT0laIGluc3RydWN0aW9uKQoyLzUgQ2hlY2tpbmcgY29tbWl0IDI5ZDZhZWI2NGM5
YiAodHJpY29yZTogYWRkIFVUT0YgaW5zdHJ1Y3Rpb24pCjMvNSBDaGVja2luZyBjb21taXQgYzEx
NzNhOTQ5MjMwICh0cmljb3JlOiBmaXggUlJQV19JTlNFUlQgaW5zdHJ1Y3Rpb24pCjQvNSBDaGVj
a2luZyBjb21taXQgNzk2MTcyMWI2MTMzICh0cmljb3JlOiBhZGQgUVNFRUQgaW5zdHJ1Y3Rpb24p
CkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMxNDY6IEZJTEU6IHRhcmdldC90cmljb3JlL3Ry
YW5zbGF0ZS5jOjY3NTU6CisgICAgICAgIGJyZWFrO15JXkleSV5JJAoKRVJST1I6IGNvZGUgaW5k
ZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTQ2OiBGSUxFOiB0YXJnZXQvdHJpY29yZS90cmFu
c2xhdGUuYzo2NzU1OgorICAgICAgICBicmVhazteSV5JXkleSSQKCnRvdGFsOiAyIGVycm9ycywg
MCB3YXJuaW5ncywgMTE5IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKNS81IENoZWNraW5nIGNvbW1pdCBjZWYwY2M5YTIzMjcgKHRyaWNvcmU6IHJl
c2V0IERpc2FzQ29udGV4dCBiZWZvcmUgZ2VuZXJhdGluZyBjb2RlKQo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDYxOTA3NTY0My4xMDA0OC0x
LWRhdmlkLmJyZW5rZW5AZWZzLWF1dG8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


