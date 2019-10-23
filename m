Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF7CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DFAA2173B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFAA2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNP5I-0008Fr-Gz
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iNO5n-0008UE-LY
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 17:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iNO5l-00079l-Sc
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 17:22:55 -0400
Resent-Date: Wed, 23 Oct 2019 17:22:55 -0400
Resent-Message-Id: <E1iNO5l-00079l-Sc@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iNO5l-000784-Kq
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 17:22:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571865757; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VpY+GhMrOOuLbMIVqhpzA8z9jSmlLsC1GXrCYp2atyFGZCIp4AXGE8fAR+cbgjbdJELE3f7wEU/0Gsiuye8Lgtvd0cv+HQEK1I3iricLYDjZHY5sZvaQeLa2GlQGVClssjdYxlqGFCxvZsU+Ydx1GqoI/0LG7Q7UGksnGWgqRCg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571865757;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=EY3i98XPxARDD7ZxepumW8KLk+6N6yJ8ntxshh2hyWI=; 
 b=Zo27870ie0fsUan10OF2PXtMXT321BtqvYM2umkEO2naBEdw9JvM3HTd4cMNU1jWMpPxdmZku/F/ehPyEi5nLx7AeO/bkb26jelFYgoPVXrGcVcNEaNy6KgubJ2Nb7MfapZ4dUrkQunSO7VPeKfWx5oszdQf5yZVti8R4oniHDY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571865756544135.1307362761629;
 Wed, 23 Oct 2019 14:22:36 -0700 (PDT)
In-Reply-To: <1571826227-10583-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH v7 00/14] target/mips: Misc cleanups for September/October
 2019
Message-ID: <157186575545.24565.16008527882963623808@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Wed, 23 Oct 2019 14:22:36 -0700 (PDT)
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
Cc: aleksandar.rikalo@rt-rk.com, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcxODI2MjI3LTEwNTgzLTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2NyAwMC8x
NF0gdGFyZ2V0L21pcHM6IE1pc2MgY2xlYW51cHMgZm9yIFNlcHRlbWJlci9PY3RvYmVyIDIwMTkK
VHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE1NzE4MjYyMjctMTA1ODMtMS1naXQtc2VuZC1lbWFp
bC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3
MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo3ZWM3YzNhIHRhcmdldC9taXBz
OiBEZW1hY3JvIExNSSBkZWNvZGVyCjRmYzE3ZTMgdGFyZ2V0L21pcHM6IEFkZCBzdXBwb3J0IGZv
ciBlbXVsYXRpb24gb2YgQ1JDMzIgZ3JvdXAgb2YgaW5zdHJ1Y3Rpb25zCmU5NjkxOGUgdGFyZ2V0
L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgQVNVQl88U3xVPi48QnxIfFd8RD4KZDdmN2Jk
NiB0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBIU1VCXzxTfFU+LjxIfFd8RD4K
NzI0OWNiNyB0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBQQ0s8RVZ8T0Q+LjxC
fEh8V3xEPgowN2U3MWJhIHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIFM8TEx8
UkF8UkFSfFJMfFJMUj4uPEJ8SHxXfEQ+CjU2ZTM5NzggdGFyZ2V0L21pcHM6IG1zYTogU3BsaXQg
aGVscGVycyBmb3IgSEFERF88U3xVPi48SHxXfEQ+CjFlNGU2MTQgdGFyZ2V0L21pcHM6IG1zYTog
U3BsaXQgaGVscGVycyBmb3IgQUREPF9BfFNfQXxTX1N8U19VfFY+LjxCfEh8V3xEPgoyZTdiNmI5
IHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIElMVjxFVnxPRHxMfFI+LjxCfEh8
V3xEPgo1YzdjNTYwIHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIDxNQVh8TUlO
Pl88U3xVPi48QnxIfFd8RD4KMGE3M2RlMSB0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJz
IGZvciA8TUFYfE1JTj5fQS48QnxIfFd8RD4KY2RlY2I0ZCBNQUlOVEFJTkVSUzogVXBkYXRlIG1h
aWwgYWRkcmVzcyBvZiBBbGVrc2FuZGFyIFJpa2FsbwoyZTE1OGNjIHRhcmdldC9taXBzOiBDbGVh
biB1cCBvcF9oZWxwZXIuYwo4ZjQ4Y2RkIHRhcmdldC9taXBzOiBDbGVhbiB1cCBoZWxwZXIuYwoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xNCBDaGVja2luZyBjb21taXQgOGY0OGNkZDVlZWZmICh0
YXJnZXQvbWlwczogQ2xlYW4gdXAgaGVscGVyLmMpCjIvMTQgQ2hlY2tpbmcgY29tbWl0IDJlMTU4
Y2MyMDFiMCAodGFyZ2V0L21pcHM6IENsZWFuIHVwIG9wX2hlbHBlci5jKQpFUlJPUjogc3BhY2Vz
IHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4Old4VikKIzEwNTk6IEZJTEU6IHRhcmdldC9t
aXBzL29wX2hlbHBlci5jOjM4NzE6CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZmxvYXRfc3RhdHVzICpzdGF0dXMpICAgICAgICAgICAgICBcCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5n
cywgMTY4MSBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzE0IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgozLzE0IENoZWNraW5nIGNvbW1pdCBjZGVjYjRkMmI5MzkgKE1BSU5UQUlORVJTOiBVcGRh
dGUgbWFpbCBhZGRyZXNzIG9mIEFsZWtzYW5kYXIgUmlrYWxvKQo0LzE0IENoZWNraW5nIGNvbW1p
dCAwYTczZGUxNWUxZGEgKHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIDxNQVh8
TUlOPl9BLjxCfEh8V3xEPikKNS8xNCBDaGVja2luZyBjb21taXQgNWM3YzU2MDRhZjVhICh0YXJn
ZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciA8TUFYfE1JTj5fPFN8VT4uPEJ8SHxXfEQ+
KQo2LzE0IENoZWNraW5nIGNvbW1pdCAyZTdiNmI5NzU2MTkgKHRhcmdldC9taXBzOiBtc2E6IFNw
bGl0IGhlbHBlcnMgZm9yIElMVjxFVnxPRHxMfFI+LjxCfEh8V3xEPikKNy8xNCBDaGVja2luZyBj
b21taXQgMWU0ZTYxNGE3MTQwICh0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBB
REQ8X0F8U19BfFNfU3xTX1V8Vj4uPEJ8SHxXfEQ+KQo4LzE0IENoZWNraW5nIGNvbW1pdCA1NmUz
OTc4MTFkMWMgKHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIEhBRERfPFN8VT4u
PEh8V3xEPikKOS8xNCBDaGVja2luZyBjb21taXQgMDdlNzFiYTYxMjUyICh0YXJnZXQvbWlwczog
bXNhOiBTcGxpdCBoZWxwZXJzIGZvciBTPExMfFJBfFJBUnxSTHxSTFI+LjxCfEh8V3xEPikKMTAv
MTQgQ2hlY2tpbmcgY29tbWl0IDcyNDljYjdlYTMyZSAodGFyZ2V0L21pcHM6IG1zYTogU3BsaXQg
aGVscGVycyBmb3IgUENLPEVWfE9EPi48QnxIfFd8RD4pCjExLzE0IENoZWNraW5nIGNvbW1pdCBk
N2Y3YmQ2ZTc0ZDIgKHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIEhTVUJfPFN8
VT4uPEh8V3xEPikKMTIvMTQgQ2hlY2tpbmcgY29tbWl0IGU5NjkxOGU2MGFhMiAodGFyZ2V0L21p
cHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgQVNVQl88U3xVPi48QnxIfFd8RD4pCjEzLzE0IENo
ZWNraW5nIGNvbW1pdCA0ZmMxN2UzZDM0NTAgKHRhcmdldC9taXBzOiBBZGQgc3VwcG9ydCBmb3Ig
ZW11bGF0aW9uIG9mIENSQzMyIGdyb3VwIG9mIGluc3RydWN0aW9ucykKMTQvMTQgQ2hlY2tpbmcg
Y29tbWl0IDdlYzdjM2EyOWM4ZCAodGFyZ2V0L21pcHM6IERlbWFjcm8gTE1JIGRlY29kZXIpCkVS
Uk9SOiB0cmFpbGluZyBzdGF0ZW1lbnRzIHNob3VsZCBiZSBvbiBuZXh0IGxpbmUKIzY0OiBGSUxF
OiB0YXJnZXQvbWlwcy90cmFuc2xhdGUuYzo1NTc0OgorICAgIGNhc2UgT1BDX1BTVUJTSDogZ2Vu
X2hlbHBlcl9wc3Vic2godDAsIHQwLCB0MSk7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3Ms
IDI1MSBsaW5lcyBjaGVja2VkCgpQYXRjaCAxNC8xNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU3
MTgyNjIyNy0xMDU4My0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsu
Y29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


