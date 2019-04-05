Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848B9C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 19:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5252175B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 19:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5252175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45866 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCUF2-0007lQ-Ca
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 15:11:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hCUE2-00071p-Uu
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 15:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hCUDs-0008RH-PT
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 15:10:00 -0400
Resent-Date: Fri, 05 Apr 2019 15:09:57 -0400
Resent-Message-Id: <E1hCUDs-0008RH-PT@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hCUDR-0005zl-Ew
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 15:09:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1554491315; cv=none; d=zoho.com; s=zohoarc; 
	b=FRqhMAFzd72Bd/nZck0EK2yaQx3gaVkybCM+gwl4Suquoyij8oOod/hAf9cSE9m6PRpyXEXTROL/lEiqQ0ecwGy/nYG4EarK+3g2kouZwGKiA1fdPUi2ONEqjIlD4WHR6ZIilpU15YbvrmEB6HNGGWs+yUsrykYFmoZTGtfBz5c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1554491315;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=IjrYLoj/v0lmRzNP/Lkt//Ra6+KIzOngBXj64GteKE0=; 
	b=FXn83hn+s/KhFLzffvsPXZTHhQIUBeLN25h0rcveoh/eJZ5hXJYYS+3d5E++sP2hKpT2vKfzcnW0Out8L7asDPkgdGkdWdADQgiTY26GMY2Je0/FAoyH9GS9MfFbJDY6ZEbLgHHkIS9TtkgoQigr3etEeA4an+2MKoqEK+yQwRA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 155449131396055.07226538435191;
	Fri, 5 Apr 2019 12:08:33 -0700 (PDT)
Message-ID: <155449131270.12882.4943932009756547608@76452e4e88f2>
In-Reply-To: <20190405184648.17029-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dgilbert@redhat.com
Date: Fri, 5 Apr 2019 12:08:33 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] slirp: Gcc 9 -O3 fix
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
Cc: fam@euphon.net, samuel.thibault@ens-lyon.org, qemu-devel@nongnu.org,
	jan.kiszka@siemens.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405190833.4TpSvbdTdJ2DxUUk8AZ1PzQqcQIipCSHbnX11YZtxOo@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwNTE4NDY0OC4xNzAy
OS0xLWRnaWxiZXJ0QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNDA1MTg0NjQ4LjE3MDI5LTEtZGdpbGJlcnRA
cmVkaGF0LmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBzbGlycDogR2NjIDkgLU8z
IGZpeApUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gK
Z2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1
ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9j
aGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpV
cGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0
cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAg
ICAgICAgIHBhdGNoZXcvMjAxOTA0MDUxODQ2NDguMTcwMjktMS1kZ2lsYmVydEByZWRoYXQuY29t
IC0+IHBhdGNoZXcvMjAxOTA0MDUxODQ2NDguMTcwMjktMS1kZ2lsYmVydEByZWRoYXQuY29tClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYzAyZWNjZGViMyBzbGlycDogR2NjIDkgLU8z
IGZpeAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZl
ciB1c2UgdGFicwojMjI6IEZJTEU6IHNsaXJwL3NyYy9zb2NrZXQuYzoxMTY6CiteSWlvdlswXS5p
b3ZfYmFzZSA9IHNiLT5zYl93cHRyOyQKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTcg
bGluZXMgY2hlY2tlZAoKQ29tbWl0IGMwMmVjY2RlYjNlNiAoc2xpcnA6IEdjYyA5IC1PMyBmaXgp
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNDA1MTg0NjQ4LjE3MDI5LTEtZGdpbGJlcnRAcmVk
aGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


