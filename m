Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8D6C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BAD207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BAD207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84TU-0003RP-50
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i848I-0001U0-AV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i848G-0004HH-Fk
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:02:09 -0400
Resent-Date: Wed, 11 Sep 2019 11:02:09 -0400
Resent-Message-Id: <E1i848G-0004HH-Fk@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i848G-0004G9-8Y
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:02:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568214118; cv=none; d=zoho.com; s=zohoarc; 
 b=hY+XZYCfBPXiJeJAl258DR1/Lu6i5x5IoGbUqbDs2nw7bJyPOP1rEpmVgXaQ7O4ofKk3Lj3hhg9WaOmtf3fFiIbEB/Z9d9QH7HfrkJOv9BhwlhbJuCEA49my12aXj0oHc65aMfRl/b+F4dHHUyGsH+BepVIhregrpa320JlB1VA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568214118;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=939m4os3hUtk6LyxNQsjC4rs8sWjjMF24QH1UtpvWKY=; 
 b=PEyy4xZRTDSMDt2t4zmIqM/VtTDy2bd/UXczYGFIZjxgQ5RMrPo8Nu7q7LS5fOwacbB5V9oJ4mwI3YvLGszg6xAFUxflnYdL8O6s22ql3mmlJIrVE2TcaHZZSzu9n1TIxo3wJkQ5HoTzFJ7MmMeuvYVxh8kqZpLtcDuCskV62zc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568214116226408.8394710323356;
 Wed, 11 Sep 2019 08:01:56 -0700 (PDT)
In-Reply-To: <20190911134539.25650-1-johannes@sipsolutions.net>
Message-ID: <156821411517.20024.16615563012612024015@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: johannes@sipsolutions.net
Date: Wed, 11 Sep 2019 08:01:56 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.58
Subject: Re: [Qemu-devel] [RFC v2 0/2] vhost-user: in-band notifications
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMTEzNDUzOS4yNTY1
MC0xLWpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMg
dG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IK
bW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUkZDIHYyIDAvMl0gdmhv
c3QtdXNlcjogaW4tYmFuZCBub3RpZmljYXRpb25zCk1lc3NhZ2UtaWQ6IDIwMTkwOTExMTM0NTM5
LjI1NjUwLTEtam9oYW5uZXNAc2lwc29sdXRpb25zLm5ldApUeXBlOiBzZXJpZXMKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rl
c3QnCjlmMzRmNjEgbGlidmhvc3QtdXNlcjogaW1wbGVtZW50IGluLWJhbmQgbm90aWZpY2F0aW9u
cwo4ZjRiMDEzIGRvY3M6IHZob3N0LXVzZXI6IGFkZCBpbi1iYW5kIGtpY2svY2FsbCBtZXNzYWdl
cwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8yIENoZWNraW5nIGNvbW1pdCA4ZjRiMDEzODYwOGMg
KGRvY3M6IHZob3N0LXVzZXI6IGFkZCBpbi1iYW5kIGtpY2svY2FsbCBtZXNzYWdlcykKMi8yIENo
ZWNraW5nIGNvbW1pdCA5ZjM0ZjYxYzIwNDQgKGxpYnZob3N0LXVzZXI6IGltcGxlbWVudCBpbi1i
YW5kIG5vdGlmaWNhdGlvbnMpCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRh
YnMKIzE4MzogRklMRTogY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYzoxNTA4
OgorXkkgICBkZXYtPnZxW2luZGV4XS5oYW5kbGVyLCBpbmRleCk7JAoKdG90YWw6IDEgZXJyb3Jz
LCAwIHdhcm5pbmdzLCAyMTEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8yIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDE5MDkxMTEzNDUzOS4yNTY1MC0xLWpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQv
dGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


