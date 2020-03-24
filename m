Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC2C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC2D2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC2D2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGijq-0006xV-5p
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jGijI-0006Z5-Gu
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jGijG-0004kt-Sd
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:32:24 -0400
Resent-Date: Tue, 24 Mar 2020 08:32:24 -0400
Resent-Message-Id: <E1jGijG-0004kt-Sd@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jGijG-0004km-JX
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:32:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585053131; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IZFDiVzOWpk5+k/wWe56DRgea2vf+MjQlC4e/6D0tdcE8WQkl6v7lpFwY/iJ1eq/vFEgDXw/Kih8wnMBXWD2TedvQdS6eaDcLHq+z/AoSdW12l726vEUMl0cPEmX8YLmnO4rbd43T4CTB7sdTnjhLy3rhD40nq5pAsTHcBj4EFQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585053131;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=QfWD/g1mUgIesJ8PzH9600YLD2gXif50GQtI5J7D5/8=; 
 b=LdCvXzX6KpaukZKJQDyw/wMEaw657faGVy+Sj1MuuBNA0eng9fkweg4R1AX3+FEd4mUlIPAqW5LVJhgLkbY4od3z0B0MnfIO/9EQxHont3KG7XEzjQJm4P7TdUsAQoCG+Qr++fsBtJk24w0FXRVA3g/S/NXD04jDtL9wzLuCLAE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585053128703991.3444434635248;
 Tue, 24 Mar 2020 05:32:08 -0700 (PDT)
In-Reply-To: <20200324100311.588288-1-laurent@vivier.eu>
Subject: Re: [PULL 0/5] Linux user for 5.0 patches
Message-ID: <158505312761.13426.2849041117100898162@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Tue, 24 Mar 2020 05:32:08 -0700 (PDT)
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyNDEwMDMxMS41ODgy
ODgtMS1sYXVyZW50QHZpdmllci5ldS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BVTEwgMC81XSBMaW51eCB1c2VyIGZvciA1LjAgcGF0Y2hl
cwpNZXNzYWdlLWlkOiAyMDIwMDMyNDEwMDMxMS41ODgyODgtMS1sYXVyZW50QHZpdmllci5ldQpU
eXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJl
di1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGlu
ZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9n
aXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNo
ZXcvMjAyMDAzMjQxMjEyMTYuMjM4OTktMS1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcgLT4gcGF0
Y2hldy8yMDIwMDMyNDEyMTIxNi4yMzg5OS0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZwogKiBb
bmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwMzI0MTIxNjM2LjI0MTM2LTEtYmVydG9AaWdh
bGlhLmNvbSAtPiBwYXRjaGV3LzIwMjAwMzI0MTIxNjM2LjI0MTM2LTEtYmVydG9AaWdhbGlhLmNv
bQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwMzI0MTIyMDQ0LjExMzEzMjYtMS1t
cmVpdHpAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwMzI0MTIyMDQ0LjExMzEzMjYtMS1tcmVp
dHpAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmNkOTlkYTYgbGlu
dXgtdXNlcjogRmx1c2ggb3V0IGltcGxlbWVudGF0aW9uIG9mIGdldHRpbWVvZmRheQo5NGFlYWNk
IGxpbnV4LXVzZXI6IEFkZCB4ODZfNjQgdnN5c2NhbGwgcGFnZSB0byAvcHJvYy9zZWxmL21hcHMK
NDU1NWIyOSBsaW51eC11c2VyL2kzODY6IEVtdWxhdGUgeDg2XzY0IHZzeXNjYWxscwpiNDY1MmVk
IGxpbnV4LXVzZXIvaTM4NjogU3BsaXQgb3V0IGdlbl9zaWduYWwKNzkxNWExZCB0YXJnZXQvaTM4
NjogUmVudW1iZXIgRVhDUF9TWVNDQUxMCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzUgQ2hlY2tp
bmcgY29tbWl0IDc5MTVhMWQ2OWQwOSAodGFyZ2V0L2kzODY6IFJlbnVtYmVyIEVYQ1BfU1lTQ0FM
TCkKMi81IENoZWNraW5nIGNvbW1pdCBiNDY1MmVkYjMzZTkgKGxpbnV4LXVzZXIvaTM4NjogU3Bs
aXQgb3V0IGdlbl9zaWduYWwpCjMvNSBDaGVja2luZyBjb21taXQgNDU1NWIyOTcwMDVkIChsaW51
eC11c2VyL2kzODY6IEVtdWxhdGUgeDg2XzY0IHZzeXNjYWxscykKNC81IENoZWNraW5nIGNvbW1p
dCA5NGFlYWNkNzZlODMgKGxpbnV4LXVzZXI6IEFkZCB4ODZfNjQgdnN5c2NhbGwgcGFnZSB0byAv
cHJvYy9zZWxmL21hcHMpCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMzMjogRklMRTogbGlu
dXgtdXNlci9zeXNjYWxsLmM6NzE1MjoKKyAgICBkcHJpbnRmKGZkLCBUQVJHRVRfRk1UX2x4ICIt
IiBUQVJHRVRfRk1UX2x4ICQKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTYgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggNC81IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo1LzUgQ2hlY2tp
bmcgY29tbWl0IGNkOTlkYTY4MDEzNyAobGludXgtdXNlcjogRmx1c2ggb3V0IGltcGxlbWVudGF0
aW9uIG9mIGdldHRpbWVvZmRheSkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhp
dGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAyMDAzMjQxMDAzMTEuNTg4Mjg4LTEtbGF1cmVudEB2aXZpZXIuZXUv
dGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

