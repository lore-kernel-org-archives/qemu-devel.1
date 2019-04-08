Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E6DC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C18321473
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 13:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C18321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDUPm-0001Sp-5u
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 09:34:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDUP1-00019n-OY
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDUOx-00056J-Qz
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:33:35 -0400
Resent-Date: Mon, 08 Apr 2019 09:33:32 -0400
Resent-Message-Id: <E1hDUOx-00056J-Qz@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hDUOu-00054l-Fj
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 09:33:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1554730375; cv=none; d=zoho.com; s=zohoarc; 
	b=CW06T42hW6wb+oGBT8priO0VaYfEi+HSbWNrG3FN+nKGzff2KwcNrOKdyq+MsDoOibgz2j0fIWSYemfAzqo1TQs+qhyVqQHcM3U+JCFCwjj6M1AtukvruiEwvdFL7HgYs0nzYYM/RNlvzmz0DJoh7VpHF0A7n3DKCliUfx0PKXg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1554730375;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=+Z2UCvqoFCbH6+PKIQdPI6xCZ/nivPbBHXwFuBq8Elc=; 
	b=X9gHGRXgmLQcR23rGyRiR/vM8vznrY0dY75H+rpkf0dVJZ2guBh4sLeL8kvMWow5OGFZbOd5MCpSBHlUGL1Mdcpp4oK305vL1hjGziLBVweDOcuCN7FxpqJ2ajoas+GU9uXMkXGMHE9JAKBj47jFY99xcPK7jR5wdDoSOMFyAII=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1554730373768532.7922261594754;
	Mon, 8 Apr 2019 06:32:53 -0700 (PDT)
Message-ID: <155473037250.12882.14942933281894625587@76452e4e88f2>
In-Reply-To: <20190408131519.15527-1-ghorges@xiyoulinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ghorges@xiyoulinux.org
Date: Mon, 8 Apr 2019 06:32:53 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
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
Cc: fam@euphon.net, riku.voipio@iki.fi, qemu-devel@nongnu.org,
	laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408133253.SDIS6yOeGWoFR-hSIono3UVvnvBIbKUwwMMhxSUj8sM@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwODEzMTUxOS4xNTUy
Ny0xLWdob3JnZXNAeGl5b3VsaW51eC5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNDA4MTMxNTE5LjE1NTI3LTEtZ2hvcmdl
c0B4aXlvdWxpbnV4Lm9yZwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gV3NoYWRvdyBpbiBxZW11L2xp
bnV4LXVzZXIvc3lzY2FsbC5jOkNoYW5nZWQgc29tZSB2YXJpYWJsZSBuYW1lcwpUeXBlOiBzZXJp
ZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVh
OWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29t
L3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcv
MjAxOTA0MDgxMzA0NTAuMTIyMzMtMS1naG9yZ2VzQHhpeW91bGludXgub3JnIC0+IHBhdGNoZXcv
MjAxOTA0MDgxMzA0NTAuMTIyMzMtMS1naG9yZ2VzQHhpeW91bGludXgub3JnCiAqIFtuZXcgdGFn
XSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA0MDgxMzE1MTkuMTU1MjctMS1naG9yZ2VzQHhp
eW91bGludXgub3JnIC0+IHBhdGNoZXcvMjAxOTA0MDgxMzE1MTkuMTU1MjctMS1naG9yZ2VzQHhp
eW91bGludXgub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKN2NkYTU3ZmUyZSBX
c2hhZG93IGluIHFlbXUvbGludXgtdXNlci9zeXNjYWxsLmM6Q2hhbmdlZCBzb21lIHZhcmlhYmxl
IG5hbWVzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5
OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE2MCBsaW5lcyBjaGVja2Vk
CgpDb21taXQgN2NkYTU3ZmUyZTFlIChXc2hhZG93IGluIHFlbXUvbGludXgtdXNlci9zeXNjYWxs
LmM6Q2hhbmdlZCBzb21lIHZhcmlhYmxlIG5hbWVzKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
Lgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5
MDQwODEzMTUxOS4xNTUyNy0xLWdob3JnZXNAeGl5b3VsaW51eC5vcmcvdGVzdGluZy5jaGVja3Bh
dGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


