Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4852AC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190E1213F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190E1213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52937 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDU3Z-0003nS-5b
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 09:11:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDU2j-0003SG-Sr
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDU2h-0002Wc-2w
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:10:33 -0400
Resent-Date: Mon, 08 Apr 2019 09:10:32 -0400
Resent-Message-Id: <E1hDU2h-0002Wc-2w@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hDU2g-0002Sj-Bm
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1554729002; cv=none; d=zoho.com; s=zohoarc; 
	b=HeWr1wzrjP1to0PhWDdqiQYdnwaoe0MYKmc6wtH1x2KN6H1o10mq2QT2FM3XVfQC9hNJ/o6pVkULTyTCEXb71xgAuBPZaSdGaxdjWKOXRVgiwV3IDmdQpITWtDIuX2Pu713XT9b+U2hGqAQw8+DCTJCbHA+w/3YjQ6qTC+HcMgQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1554729002;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=O2bPryJAiSx//tQhh0IdwC63XJneOpjKm5Om/XGGwo0=; 
	b=RlqybAavGcbFtsc6Oqb5zGsR+yN5YWx/T5cKZQy+6pkICn+EH+lAwnAwZEDzXP3zUmc3z5pN7KpdB7zwJTGk0AdNs5vdQyTsCqZaBDNu2mYr2T+7m/CILCsBPG8t1IlCxzOHNqI02n4B4NjhjfTx7ufUlTxAuCV8xil4ovXDVYg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1554728999154419.9399308915862;
	Mon, 8 Apr 2019 06:09:59 -0700 (PDT)
Message-ID: <155472899779.12882.1060697470938678321@76452e4e88f2>
In-Reply-To: <20190408130450.12233-1-ghorges@xiyoulinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ghorges@xiyoulinux.org
Date: Mon, 8 Apr 2019 06:09:59 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] Wshadow in qemu/linux-user/syscall.c:Changed some
 variable names
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
Cc: fam@euphon.net, riku.voipio@iki.fi, ghorges@xiyoulinux.org,
	qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408130959.E0aSPxfCUiINW3E7RHspAChaPNCpRI7A8snmEgZgFJ8@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwODEzMDQ1MC4xMjIz
My0xLWdob3JnZXNAeGl5b3VsaW51eC5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNDA4MTMwNDUwLjEyMjMzLTEtZ2hvcmdl
c0B4aXlvdWxpbnV4Lm9yZwpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFdzaGFk
b3cgaW4gcWVtdS9saW51eC11c2VyL3N5c2NhbGwuYzpDaGFuZ2VkIHNvbWUgdmFyaWFibGUgbmFt
ZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVh
OWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29t
L3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxOTA0
MDgxMzA0NTAuMTIyMzMtMS1naG9yZ2VzQHhpeW91bGludXgub3JnIC0+IHBhdGNoZXcvMjAxOTA0
MDgxMzA0NTAuMTIyMzMtMS1naG9yZ2VzQHhpeW91bGludXgub3JnClN3aXRjaGVkIHRvIGEgbmV3
IGJyYW5jaCAndGVzdCcKODg2NGE1NSBXc2hhZG93IGluIHFlbXUvbGludXgtdXNlci9zeXNjYWxs
LmM6Q2hhbmdlZCBzb21lIHZhcmlhYmxlIG5hbWVzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJP
UjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fy
bmluZ3MsIDE2MCBsaW5lcyBjaGVja2VkCgpDb21taXQgODg2NGE1NTIwZTljIChXc2hhZG93IGlu
IHFlbXUvbGludXgtdXNlci9zeXNjYWxsLmM6Q2hhbmdlZCBzb21lIHZhcmlhYmxlIG5hbWVzKSBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDQwODEzMDQ1MC4xMjIzMy0xLWdob3JnZXNAeGl5b3Vs
aW51eC5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


