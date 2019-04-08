Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C31C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519A220880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519A220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQfg-0008NY-JS
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:34:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDQbb-0005YK-Qy
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDQba-00018P-K2
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:30:19 -0400
Resent-Date: Mon, 08 Apr 2019 05:30:19 -0400
Resent-Message-Id: <E1hDQba-00018P-K2@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hDQba-0000vF-95; Mon, 08 Apr 2019 05:30:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1554715793; cv=none; d=zoho.com; s=zohoarc; 
	b=dCY4QQsSpZBe60pgbidm+xomPdCpvjAhoOzIhbQT9ImKOB9FK7ourfEDN+bZ627LYzqXq0yDyfxAonB/gag71bYt8f3cwV/4IRFz3TADENqRhkLHfZ761pDvhTQTuIdJvS0pNIVDpSlDUbL9VaISkpxt4sZjB7E9kFLZb6UleG0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1554715793;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=15+wKlQV5KK2KfIAUoPIQqtBMTcScfQ6o71ad25O53c=; 
	b=PjjY7Osrl8n42NG407KTSKEJDaGflX2qy0ZrQZyXlNpxnT1Ggz/YVTzyHLqyA2FP3qk9xVv2fPexoeHUvCj2KSjzO+m6aiuoyZb3Z+wIAuuRgTYAbmeoUc+u1wFFEuue8RoBO+O/LfNt0W1AHcJHSnBfZVLjGKEtIim/sazIjdk=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1554715790876892.5429034653301;
	Mon, 8 Apr 2019 02:29:50 -0700 (PDT)
Message-ID: <155471578957.12882.15898285010752314117@76452e4e88f2>
In-Reply-To: <20190408084056.26212-1-ghorges@xiyoulinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ghorges@xiyoulinux.org
Date: Mon, 8 Apr 2019 02:29:50 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] Wshadow in qemu/linux-user/syscall.c
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
Cc: fam@euphon.net, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	ghorges@xiyoulinux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408092950.DuFdPy-Qn6bS9MUNPGptOBPptfeOC7NXG1oi1HuMZEM@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwODA4NDA1Ni4yNjIx
Mi0xLWdob3JnZXNAeGl5b3VsaW51eC5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNDA4MDg0MDU2LjI2MjEyLTEtZ2hvcmdl
c0B4aXlvdWxpbnV4Lm9yZwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gV3NoYWRvdyBpbiBxZW11L2xp
bnV4LXVzZXIvc3lzY2FsbC5jClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3
MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIHQgW3Rh
ZyB1cGRhdGVdICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDQwNTA2NDEyMS4yMzY2Mi0xLXJpY2hh
cmR3LnlhbmdAbGludXguaW50ZWwuY29tIC0+IHBhdGNoZXcvMjAxOTA0MDUwNjQxMjEuMjM2NjIt
MS1yaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNvbQogdCBbdGFnIHVwZGF0ZV0gICAgICAgICAg
ICBwYXRjaGV3LzIwMTkwNDA1MTUzMzE0LjIwNjgtMS1waGlsbWRAcmVkaGF0LmNvbSAtPiBwYXRj
aGV3LzIwMTkwNDA1MTUzMzE0LjIwNjgtMS1waGlsbWRAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10g
ICAgICAgICAgICAgICBwYXRjaGV3LzIwMTkwNDA4MDg0MDU2LjI2MjEyLTEtZ2hvcmdlc0B4aXlv
dWxpbnV4Lm9yZyAtPiBwYXRjaGV3LzIwMTkwNDA4MDg0MDU2LjI2MjEyLTEtZ2hvcmdlc0B4aXlv
dWxpbnV4Lm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmM3NmFmMTQyY2QgV3No
YWRvdyBpbiBxZW11L2xpbnV4LXVzZXIvc3lzY2FsbC5jCgo9PT0gT1VUUFVUIEJFR0lOID09PQpF
UlJPUjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJvcnMsIDAg
d2FybmluZ3MsIDE2MCBsaW5lcyBjaGVja2VkCgpDb21taXQgYzc2YWYxNDJjZDAyIChXc2hhZG93
IGluIHFlbXUvbGludXgtdXNlci9zeXNjYWxsLmMpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkw
NDA4MDg0MDU2LjI2MjEyLTEtZ2hvcmdlc0B4aXlvdWxpbnV4Lm9yZy90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


