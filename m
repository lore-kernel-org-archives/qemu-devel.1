Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73A0C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 06:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FDC206C0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 06:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FDC206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM4Kh-0004gP-SM
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 02:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jM4K3-0004Fq-Lb
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jM4K2-0000Rj-6q
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:36:27 -0400
Resent-Date: Wed, 08 Apr 2020 02:36:27 -0400
Resent-Message-Id: <E1jM4K2-0000Rj-6q@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jM4K1-0000RC-Vn
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:36:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586327777; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=N9k76jOgM3hfAVt0bV9eppyxk/uQpUhecmqIRdr7vBnxEu5AX6SNAuFjNQ2pFMDG4/mE+Kl3UgQ+JZi27H6d5rKU0YFiklaqhyzZwSFKt1tFHblIQizzNHn2gKclPtcGqE/mAQRpDQjTE4qNQSvpPT15/O6GurzYGvp3Be2hh3c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586327777;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=G9c8k2GmYfvIDtAQDlSyzA5arOGYwzmg5ckalm9d2nc=; 
 b=aK3dS2BECyCncDVo6azR4lwgT21+oW156mOAIs7evdwiSRTBkDmrmOnBUvYS7BUQ0luuGwbi4DmfjRhGh/d6wZFE4rdloxHWxCYx9p8GU00l4X1y0BVOnY0zdlgz/mbAj4RNUUHKxb1stEp+7UfJUAqZ0+QyLtwwRf+puyfkXvM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586327775893597.4286643570914;
 Tue, 7 Apr 2020 23:36:15 -0700 (PDT)
In-Reply-To: <20200408003552.58095-1-mansourweb@gmail.com>
Subject: Re: [PATCH] When updating the PFLASH file contents,
 we should check for a possible failure of blk_pwrite(). Similar to
 3a68829 commit
Message-ID: <158632777484.16886.8863170245355826794@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mansourweb@gmail.com
Date: Tue, 7 Apr 2020 23:36:15 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.57
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
Cc: mansourweb@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwODAwMzU1Mi41ODA5
NS0xLW1hbnNvdXJ3ZWJAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIFdoZW4gdXBkYXRpbmcgdGhlIFBGTEFTSCBm
aWxlIGNvbnRlbnRzLCB3ZSBzaG91bGQgY2hlY2sgZm9yIGEgcG9zc2libGUgZmFpbHVyZSBvZiBi
bGtfcHdyaXRlKCkuIFNpbWlsYXIgdG8gM2E2ODgyOSBjb21taXQKTWVzc2FnZS1pZDogMjAyMDA0
MDgwMDM1NTIuNTgwOTUtMS1tYW5zb3Vyd2ViQGdtYWlsLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rl
di9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
YmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2gg
J3Rlc3QnCmUyZDZkNmUgV2hlbiB1cGRhdGluZyB0aGUgUEZMQVNIIGZpbGUgY29udGVudHMsIHdl
IHNob3VsZCBjaGVjayBmb3IgYSBwb3NzaWJsZSBmYWlsdXJlIG9mIGJsa19wd3JpdGUoKS4gU2lt
aWxhciB0byAzYTY4ODI5IGNvbW1pdAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGNvZGUg
aW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMjc6IEZJTEU6IGh3L2Jsb2NrL3BmbGFzaF9j
ZmkwMS5jOjQxMDoKK15JaWYgKHJldCA8IDApIHskCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxk
IG5ldmVyIHVzZSB0YWJzCiM1MDogRklMRTogaHcvYmxvY2svcGZsYXNoX2NmaTAyLmM6NDA0Ogor
XklpZiAocmV0IDwgMCkgeyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRh
YnMKIzUxOiBGSUxFOiBody9ibG9jay9wZmxhc2hfY2ZpMDIuYzo0MDU6CiteSSAgICBlcnJvcl9y
ZXBvcnQoIkNvdWxkIG5vdCB1cGRhdGUgUEZMQVNIOiAlcyIsIHN0cmVycm9yKC1yZXQpKTskCgp0
b3RhbDogMyBlcnJvcnMsIDAgd2FybmluZ3MsIDM2IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBlMmQ2
ZDZlMjhkYWYgKFdoZW4gdXBkYXRpbmcgdGhlIFBGTEFTSCBmaWxlIGNvbnRlbnRzLCB3ZSBzaG91
bGQgY2hlY2sgZm9yIGEgcG9zc2libGUgZmFpbHVyZSBvZiBibGtfcHdyaXRlKCkuIFNpbWlsYXIg
dG8gM2E2ODgyOSBjb21taXQpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDA4MDAzNTUyLjU4
MDk1LTEtbWFuc291cndlYkBnbWFpbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t

