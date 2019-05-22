Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E87C072B5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF44B21773
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 00:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF44B21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTEqn-00076u-3T
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 20:11:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hTEpv-0006j5-1L
	for qemu-devel@nongnu.org; Tue, 21 May 2019 20:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hTEpt-0005d7-Sw
	for qemu-devel@nongnu.org; Tue, 21 May 2019 20:10:27 -0400
Resent-Date: Tue, 21 May 2019 20:10:27 -0400
Resent-Message-Id: <E1hTEpt-0005d7-Sw@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hTEpt-0005bj-Mx
	for qemu-devel@nongnu.org; Tue, 21 May 2019 20:10:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558483759; cv=none; d=zoho.com; s=zohoarc; 
	b=fhiNTs0E67tzM656tkAT6pOBk+ZGkeQsbYHbaBBSLeheFPJtwrDjL2Shius2cG/G3MDEY8vwSmYxqPg62tVJghLw4W3ogPIGcfJ9DSfj8Xt1bONQDjVozNtXaA6NYNoZ0ytFzusIA0qi2EsfHe49ST3AFBefaYgloHEYEYvhRr8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1558483759;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=ZcBElR9ZQzqmCed0PkPBFU/ey39ejxVALmR74rWnYdA=; 
	b=oSeF23urMHk/ukCLfogD0bd7gAH6/kouh48Td2jA7Ja1ydVZxBIgo3+Vi5yJE/019c+golzx+/Ur/qoyZS9i0QQqsmUhxRc08oTFG1I5jLMAa+f1VJcJif2u1mAth4z/mNoE5cDGrpWlxKTvlQ1SNqhI9xL0ifXuR9zfMAZ8pPc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1558483757619694.6541046698838;
	Tue, 21 May 2019 17:09:17 -0700 (PDT)
Message-ID: <155848375624.22.17399747037195093597@5d2e01a8a801>
In-Reply-To: <20190521235215.31341-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mehta.aaru20@gmail.com
Date: Tue, 21 May 2019 17:09:17 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [RFC PATCH 0/9] Add support for io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	saket.sinha89@gmail.com, stefanha@redhat.com, jusual@mail.ru,
	mehta.aaru20@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUyMTIzNTIxNS4zMTM0
MS0xLW1laHRhLmFhcnUyMEBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUkZDIFBBVENIIDAvOV0gQWRk
IHN1cHBvcnQgZm9yIGlvX3VyaW5nCk1lc3NhZ2UtaWQ6IDIwMTkwNTIxMjM1MjE1LjMxMzQxLTEt
bWVodGEuYWFydTIwQGdtYWlsLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3Qv
cWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTkwNTIxMjM1MjE1LjMx
MzQxLTEtbWVodGEuYWFydTIwQGdtYWlsLmNvbSAtPiBwYXRjaGV3LzIwMTkwNTIxMjM1MjE1LjMx
MzQxLTEtbWVodGEuYWFydTIwQGdtYWlsLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rl
c3QnCjY3OGYxMmJlODggY29uZmlndXJlOiBwZXJtaXRzIHVzZSBvZiBpb191cmluZyB3aXRoIHBy
b2JlCmU3NjY4NDIwNDggYmxvY2svZmlsZS1wb3NpeDogZXh0ZW5kcyB0byB1c2Ugd2l0aCBpb191
cmluZwowM2YwODBiMjA1IGJsb2NrZGV2OiBhY2NlcHQgaW9fdXJpbmcgYXMgb3B0aW9uCjcyMDhh
MDliNTYgYmxvY2svaW9fdXJpbmc6IGltcGxlbWVudHMgaW50ZXJmYWNlcyBmb3IgaW9fdXJpbmcK
OGQ2ODFmMDUyZCB1dGlsL2FzeW46IGFkZCBhaW8gaW50ZXJmYWNlcyBmb3IgaW9fdXJpbmcKMjdm
N2IwYzk1MSBzdHViczogYWRkIGFpbyBpbnRlcmZhY2Ugc3R1YnMgZm9yIGlvX3VyaW5nCjljMjA2
NGYyZjUgaW5jbHVkZS9ibG9jazogZGVjbGFyZSBpbnRlcmZhY2VzIGZvciBpb191cmluZwo1NGUz
YzUzOTdjIGJsb2NrL2Jsb2NrOiBhZGQgQkRSViBmbGFnIGZvciBpb191cmluZwoyNTE2MmQ2YzFm
IHFhcGkvYmxvY2stY29yZTogYWRkIG9wdGlvbiBmb3IgaW9fdXJpbmcKCj09PSBPVVRQVVQgQkVH
SU4gPT09CjEvOSBDaGVja2luZyBjb21taXQgMjUxNjJkNmMxZmM5IChxYXBpL2Jsb2NrLWNvcmU6
IGFkZCBvcHRpb24gZm9yIGlvX3VyaW5nKQoyLzkgQ2hlY2tpbmcgY29tbWl0IDU0ZTNjNTM5N2Ni
NCAoYmxvY2svYmxvY2s6IGFkZCBCRFJWIGZsYWcgZm9yIGlvX3VyaW5nKQozLzkgQ2hlY2tpbmcg
Y29tbWl0IDljMjA2NGYyZjVkYiAoaW5jbHVkZS9ibG9jazogZGVjbGFyZSBpbnRlcmZhY2VzIGZv
ciBpb191cmluZykKNC85IENoZWNraW5nIGNvbW1pdCAyN2Y3YjBjOTUxNjIgKHN0dWJzOiBhZGQg
YWlvIGludGVyZmFjZSBzdHVicyBmb3IgaW9fdXJpbmcpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBv
ciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzIzOiAK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMzkgbGlu
ZXMgY2hlY2tlZAoKUGF0Y2ggNC85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjUvOSBDaGVj
a2luZyBjb21taXQgOGQ2ODFmMDUyZDAyICh1dGlsL2FzeW46IGFkZCBhaW8gaW50ZXJmYWNlcyBm
b3IgaW9fdXJpbmcpCjYvOSBDaGVja2luZyBjb21taXQgNzIwOGEwOWI1NjQ1IChibG9jay9pb191
cmluZzogaW1wbGVtZW50cyBpbnRlcmZhY2VzIGZvciBpb191cmluZykKV0FSTklORzogYWRkZWQs
IG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5n
PwojMzA6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IGVsc2Ugc2hvdWxkIGZvbGxvdyBj
bG9zZSBicmFjZSAnfScKIzI0MDogRklMRTogYmxvY2svaW9fdXJpbmcuYzoyMDY6CisgICAgICAg
ICAgICAgICAgfQorICAgICAgICAgICAgICAgIGVsc2UgewoKdG90YWw6IDEgZXJyb3JzLCAxIHdh
cm5pbmdzLCAzOTggbGluZXMgY2hlY2tlZAoKUGF0Y2ggNi85IGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgo3LzkgQ2hlY2tpbmcgY29tbWl0IDAzZjA4MGIyMDUwYiAoYmxvY2tkZXY6IGFjY2Vw
dCBpb191cmluZyBhcyBvcHRpb24pCjgvOSBDaGVja2luZyBjb21taXQgZTc2Njg0MjA0OGViIChi
bG9jay9maWxlLXBvc2l4OiBleHRlbmRzIHRvIHVzZSB3aXRoIGlvX3VyaW5nKQo5LzkgQ2hlY2tp
bmcgY29tbWl0IDY3OGYxMmJlODhhMyAoY29uZmlndXJlOiBwZXJtaXRzIHVzZSBvZiBpb191cmlu
ZyB3aXRoIHByb2JlKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDE5MDUyMTIzNTIxNS4zMTM0MS0xLW1laHRhLmFhcnUyMEBnbWFpbC5jb20vdGVz
dGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


