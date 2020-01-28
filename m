Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53065C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 22:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A726207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 22:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A726207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwZeB-0005cY-7I
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 17:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iwZdI-00058l-2G
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 17:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iwZdG-00055S-N7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 17:46:55 -0500
Resent-Date: Tue, 28 Jan 2020 17:46:55 -0500
Resent-Message-Id: <E1iwZdG-00055S-N7@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iwZdG-0004wr-HQ; Tue, 28 Jan 2020 17:46:54 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580251594449591.4796643350552;
 Tue, 28 Jan 2020 14:46:34 -0800 (PST)
In-Reply-To: <20200128223955.464556-1-keithp@keithp.com>
Subject: Re: [PATCH] riscv: Separate FPU register size from core register size
 in gdbstub
Message-ID: <158025159282.18399.1270920230383164028@f6d1ed32ca6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Tue, 28 Jan 2020 14:46:34 -0800 (PST)
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
Cc: keithp@keithp.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 Alistair.Francis@wdc.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEyODIyMzk1NS40NjQ1
NTYtMS1rZWl0aHBAa2VpdGhwLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwMTI4MjIzOTU1LjQ2NDU1
Ni0xLWtlaXRocEBrZWl0aHAuY29tClN1YmplY3Q6IFtQQVRDSF0gcmlzY3Y6IFNlcGFyYXRlIEZQ
VSByZWdpc3RlciBzaXplIGZyb20gY29yZSByZWdpc3RlciBzaXplIGluIGdkYnN0dWIKCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rl
di9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
YmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4
MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXct
cHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDAxMjgyMjM5NTUu
NDY0NTU2LTEta2VpdGhwQGtlaXRocC5jb20gLT4gcGF0Y2hldy8yMDIwMDEyODIyMzk1NS40NjQ1
NTYtMS1rZWl0aHBAa2VpdGhwLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmY4
NzA0YTggcmlzY3Y6IFNlcGFyYXRlIEZQVSByZWdpc3RlciBzaXplIGZyb20gY29yZSByZWdpc3Rl
ciBzaXplIGluIGdkYnN0dWIKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBicmFjZXMge30g
YXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzQ0OiBGSUxFOiB0
YXJnZXQvcmlzY3YvZ2Ric3R1Yi5jOjMwNjoKKyAgICAgICAgaWYgKGVudi0+bWlzYSAmIFJWRCkK
Wy4uLl0KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNTQgbGluZXMgY2hlY2tlZAoKQ29t
bWl0IGY4NzA0YTg1ZjE3YSAocmlzY3Y6IFNlcGFyYXRlIEZQVSByZWdpc3RlciBzaXplIGZyb20g
Y29yZSByZWdpc3RlciBzaXplIGluIGdkYnN0dWIpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAw
MTI4MjIzOTU1LjQ2NDU1Ni0xLWtlaXRocEBrZWl0aHAuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

