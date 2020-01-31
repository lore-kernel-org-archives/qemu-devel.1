Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C353C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 21:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DA820CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 21:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DA820CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixdvv-0003hE-36
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 16:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ixdvJ-00037m-0h
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 16:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ixdvH-0006b4-Q6
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 16:33:56 -0500
Resent-Date: Fri, 31 Jan 2020 16:33:56 -0500
Resent-Message-Id: <E1ixdvH-0006b4-Q6@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ixdvA-0006IO-Lm; Fri, 31 Jan 2020 16:33:48 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580506414270910.1412821761918;
 Fri, 31 Jan 2020 13:33:34 -0800 (PST)
In-Reply-To: <20200131212742.18579-1-lyan@suse.com>
Subject: Re: [PATCH] target/arm/monitor: query-cpu-model-expansion crashed
 qemu when using machine type none
Message-ID: <158050641310.22889.11030132008008695138@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: LYan@suse.com
Date: Fri, 31 Jan 2020 13:33:34 -0800 (PST)
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
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEzMTIxMjc0Mi4xODU3
OS0xLWx5YW5Ac3VzZS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21l
IGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1h
dGlvbjoKClN1YmplY3Q6IFtQQVRDSF0gdGFyZ2V0L2FybS9tb25pdG9yOiBxdWVyeS1jcHUtbW9k
ZWwtZXhwYW5zaW9uIGNyYXNoZWQgcWVtdSB3aGVuIHVzaW5nIG1hY2hpbmUgdHlwZSBub25lCk1l
c3NhZ2UtaWQ6IDIwMjAwMTMxMjEyNzQyLjE4NTc5LTEtbHlhbkBzdXNlLmNvbQpUeXBlOiBzZXJp
ZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0
aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogICBhZWFiOGU1Li4yOGRiNjRmICBtYXN0ZXIg
ICAgIC0+IG1hc3RlcgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwMTMxMjEyNzQyLjE4NTc5LTEtbHlh
bkBzdXNlLmNvbSAtPiBwYXRjaGV3LzIwMjAwMTMxMjEyNzQyLjE4NTc5LTEtbHlhbkBzdXNlLmNv
bQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjU0YmQzM2IgdGFyZ2V0L2FybS9tb25p
dG9yOiBxdWVyeS1jcHUtbW9kZWwtZXhwYW5zaW9uIGNyYXNoZWQgcWVtdSB3aGVuIHVzaW5nIG1h
Y2hpbmUgdHlwZSBub25lCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogY29kZSBpbmRlbnQg
c2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0MzogRklMRTogdGFyZ2V0L2FybS9tb25pdG9yLmM6MTQ5
OgorXkleSV5JICAgICFzdHJuY21wKG1vZGVsLT5uYW1lLCBjcHVfdHlwZSwgbGVuKSkgeyQKCkVS
Uk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzQ0OiBGSUxFOiB0YXJnZXQv
YXJtL21vbml0b3IuYzoxNTA6CiteSV5JICAgIC8qIEtWTSBpcyBlbmFibGVkIGFuZCB3ZSdyZSB1
c2luZyB0aGlzIHR5cGUsIHNvIGl0IHdvcmtzLiAqLyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91
bGQgbmV2ZXIgdXNlIHRhYnMKIzQ1OiBGSUxFOiB0YXJnZXQvYXJtL21vbml0b3IuYzoxNTE6Cite
SV5JICAgIHN1cHBvcnRlZCA9IHRydWU7JAoKdG90YWw6IDMgZXJyb3JzLCAwIHdhcm5pbmdzLCAy
NSBsaW5lcyBjaGVja2VkCgpDb21taXQgNTRiZDMzYjViZjAxICh0YXJnZXQvYXJtL21vbml0b3I6
IHF1ZXJ5LWNwdS1tb2RlbC1leHBhbnNpb24gY3Jhc2hlZCBxZW11IHdoZW4gdXNpbmcgbWFjaGlu
ZSB0eXBlIG5vbmUpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09
PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMTMxMjEyNzQyLjE4NTc5LTEt
bHlhbkBzdXNlLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

