Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B8CC742C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65D62206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D62206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlxE6-0001Hn-KR
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hlxDv-0000r4-3n
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hlxDt-0000fn-Sx
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:12:35 -0400
Resent-Date: Fri, 12 Jul 2019 11:12:35 -0400
Resent-Message-Id: <E1hlxDt-0000fn-Sx@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hlxDt-0000fK-JF
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:12:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562944332; cv=none; d=zoho.com; s=zohoarc; 
 b=RHqNkmtFZ2fwIBn9A5/4sEwykxLz3wlhBXkTcoLRAQdp51stQlC/RbD9eUzRhWwLwCQ2PH1PR6fAkbbxqGXm1i0LYVa5n+mHNMbcrEX0y/iXBzpHvpcTRCa57cNAjmPwPoddc3I/ph0j3hYHaHVKEQesonWAGhVZhqbemIpi3B4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562944332;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=IRmwV0sh07MULSkL2AX4A6IAramj5QchJiPNhRzG7U4=; 
 b=CrFaFj737Vl3O8jhIlXJ5THPZOFB2elWfivDDg3V3kEDleOwVEq4GEXL1M+PNtB57UtmHqBsE9AGSesCE20kZldal5AcgQzKYvnWYaHd/ctAi4bfLqhxJQCQNpWoMZI+gGXs7/FKUKUAWGDrJkaV4eULLM7kkfk9ndCKgDil9xM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15629443317781002.4789933134052;
 Fri, 12 Jul 2019 08:12:11 -0700 (PDT)
Message-ID: <156294433034.12463.15876028607010843246@c4a48874b076>
In-Reply-To: <20190711173131.6347-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Fri, 12 Jul 2019 08:12:11 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH v4] linux-user: fix to handle variably
 sized SIOCGSTAMP with new kernels
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
Cc: berrange@redhat.com, arnd@arndb.de, gerhard.stenzel@de.ibm.com,
 riku.voipio@iki.fi, qemu-devel@nongnu.org, christian.ehrhardt@canonical.com,
 laurent@vivier.eu, borntraeger@de.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxMTE3MzEzMS42MzQ3
LTEtbGF1cmVudEB2aXZpZXIuZXUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNzExMTczMTMxLjYzNDctMS1sYXVyZW50QHZpdmll
ci5ldQpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2NF0gbGludXgt
dXNlcjogZml4IHRvIGhhbmRsZSB2YXJpYWJseSBzaXplZCBTSU9DR1NUQU1QIHdpdGggbmV3IGtl
cm5lbHMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJz
ZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBs
IC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBh
IG5ldyBicmFuY2ggJ3Rlc3QnCmFkYjM0MDVhMDYgbGludXgtdXNlcjogZml4IHRvIGhhbmRsZSB2
YXJpYWJseSBzaXplZCBTSU9DR1NUQU1QIHdpdGggbmV3IGtlcm5lbHMKCj09PSBPVVRQVVQgQkVH
SU4gPT09CkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNzk6IEZJTEU6IGxpbnV4LXVz
ZXIvc3lzY2FsbF9kZWZzLmg6NzU2OgorI2RlZmluZSBUQVJHRVRfU0lPQ0dTVEFNUF9ORVcgICBU
QVJHRVRfSU9SKDB4ODksIDB4MDYsIGFiaV9sbG9uZ1syXSkgLyogR2V0IHN0YW1wICh0aW1ldmFs
NjQpICovCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzgwOiBGSUxFOiBsaW51eC11
c2VyL3N5c2NhbGxfZGVmcy5oOjc1NzoKKyNkZWZpbmUgVEFSR0VUX1NJT0NHU1RBTVBOU19ORVcg
VEFSR0VUX0lPUigweDg5LCAweDA3LCBhYmlfbGxvbmdbMl0pIC8qIEdldCBzdGFtcCAodGltZXNw
ZWM2NCkgKi8KCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgNTAgbGluZXMgY2hlY2tlZAoK
Q29tbWl0IGFkYjM0MDVhMDZhNCAobGludXgtdXNlcjogZml4IHRvIGhhbmRsZSB2YXJpYWJseSBz
aXplZCBTSU9DR1NUQU1QIHdpdGggbmV3IGtlcm5lbHMpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MTkwNzExMTczMTMxLjYzNDctMS1sYXVyZW50QHZpdmllci5ldS90ZXN0aW5nLmNoZWNrcGF0Y2gv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


