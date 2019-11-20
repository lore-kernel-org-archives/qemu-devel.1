Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7857CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:01:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7282251D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7282251D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPc7-0004xo-Ah
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 08:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iXPaK-0003Qj-HD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iXPaI-00009I-T8
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:59:52 -0500
Resent-Date: Wed, 20 Nov 2019 07:59:52 -0500
Resent-Message-Id: <E1iXPaI-00009I-T8@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iXPaI-00008R-LT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:59:50 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574254781; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XO24UyfyFC9wuy5SWijjD4pmYgj+9S04/hmpTTSFYEbolyrEtJOIn+QOGdJmE7IliMHZx7zZo0MP3TnC4O2UQQ2ZxquQGS0jtp1sUujXenCmt+fRolz9iCcFHRm3ZQjkoqEdPm8Nsw0smwY82njAegfiLh8fDm5Rofv51ldBbTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574254781;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=kzUkcNAdtPPrOjnqKuPQC9MysbhQ25R1Ult2RvcFiKw=; 
 b=NrLkVNoh/SXCGdFt+LrmwF5XDrrBhKOJSf/nTE0AXn4z4v/J4PQOWIBgheBazEqPhBU3j6oT8GCcGqj8gtgMO/4IfhQ0G1lacFoXWyxAgtCLX5z1zGT8HyuVdTi4NCN9/I6QGKrNWUl/BHi0w8KMqkjrowLXCKDCP/KWYr+zFQ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157425477941343.10145444515774;
 Wed, 20 Nov 2019 04:59:39 -0800 (PST)
In-Reply-To: <20191120121922.6082-1-pbonzini@redhat.com>
Subject: Re: [PATCH] target/i386: add support for MSR_IA32_TSX_CTRL
Message-ID: <157425477840.6277.13439344416661102188@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Wed, 20 Nov 2019 04:59:39 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyMDEyMTkyMi42MDgy
LTEtcGJvbnppbmlAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSB0YXJnZXQvaTM4NjogYWRkIHN1cHBvcnQgZm9y
IE1TUl9JQTMyX1RTWF9DVFJMClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTEyMDEyMTky
Mi42MDgyLTEtcGJvbnppbmlAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKOTk1Njk0ZSB0YXJnZXQv
aTM4NjogYWRkIHN1cHBvcnQgZm9yIE1TUl9JQTMyX1RTWF9DVFJMCgo9PT0gT1VUUFVUIEJFR0lO
ID09PQpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMzODogRklMRTog
dGFyZ2V0L2kzODYvY3B1Lmg6MzU0OgorI2RlZmluZSBBUkNIX0NBUF9UU1hfQ1RSTF9NU1JeSV5J
KDE8PDcpJAoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnPDwnIChjdHg6VnhW
KQojMzg6IEZJTEU6IHRhcmdldC9pMzg2L2NwdS5oOjM1NDoKKyNkZWZpbmUgQVJDSF9DQVBfVFNY
X0NUUkxfTVNSICAgICAgICAgICgxPDw3KQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBeCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0
MDogRklMRTogdGFyZ2V0L2kzODYvY3B1Lmg6MzU2OgorI2RlZmluZSBNU1JfSUEzMl9UU1hfQ1RS
TF5JXkkweDEyMiQKCnRvdGFsOiAzIGVycm9ycywgMCB3YXJuaW5ncywgMTAxIGxpbmVzIGNoZWNr
ZWQKCkNvbW1pdCA5OTU2OTRlYTQzZjkgKHRhcmdldC9pMzg2OiBhZGQgc3VwcG9ydCBmb3IgTVNS
X0lBMzJfVFNYX0NUUkwpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5E
ID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTIwMTIxOTIyLjYwODIt
MS1wYm9uemluaUByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==


