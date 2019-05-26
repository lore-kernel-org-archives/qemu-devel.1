Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E0EC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 21:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E315720859
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 21:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E315720859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50655 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVMj1-0000bc-0P
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 17:00:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hVMi8-0000CA-V8
	for qemu-devel@nongnu.org; Mon, 27 May 2019 16:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hVMi5-0000RS-BZ
	for qemu-devel@nongnu.org; Mon, 27 May 2019 16:59:10 -0400
Resent-Date: Mon, 27 May 2019 16:59:10 -0400
Resent-Message-Id: <E1hVMi5-0000RS-BZ@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hVMi5-0000Qx-4m
	for qemu-devel@nongnu.org; Mon, 27 May 2019 16:59:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558861845; cv=none; d=zoho.com; s=zohoarc; 
	b=VvAhqijS7eivf6mlotWSmuS46IvU4H9yoVyTeET25nX1pQN2+BjD5pLbd+12B2EHGu0snRUPLja1ba/4Y9pU7rJLLRg+tGkWPEMC+1/cB8ncqAnSxWtjoxugoQsYSwF1r+mxvtpXowIjjUkMjqm7yOc4DBLUWUvVsn1PyfC8kUw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1558861845;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=JHxjaUI13Ux7CnaQlG9saQJw59k1apaprKrfc6ZOq/s=; 
	b=ECC91hk+zKiF25Qymj6F2h0A1Jc+36JnaBPXRMMXvwoEJtepGDE4F345c3C502a2GwZQfA5+d1aQg62RZ3tayzrozhl9XAkVQjt9hd0r+51VILQcLq3221aZTn8fkKdw6sktpca0zRMBAneiRv6F7IHPWl9aPGGfTaB+Qo7PHKw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1558861844085304.1883723062268;
	Sun, 26 May 2019 02:10:44 -0700 (PDT)
In-Reply-To: <20190526074527.33632-1-lucienmp_antispam@yahoo.com>
Message-ID: <155886184272.24.4090970039813556278@549697c9ad12>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 02:10:44 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] The m68k gdbstub SR reg request doesnt
 include Condition-Codes
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
Cc: huth@tuxfamily.org, richard.henderson@linaro.org, qemu-devel@nongnu.org,
	laurent@vivier.eu, cota@braap.org, lucienmp_antispam@yahoo.com,
	alex.bennee@linaro.org, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUyNjA3NDUyNy4zMzYz
Mi0xLWx1Y2llbm1wX2FudGlzcGFtQHlhaG9vLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gVGhlIG02
OGsgZ2Ric3R1YiBTUiByZWcgcmVxdWVzdCBkb2VzbnQgaW5jbHVkZSBDb25kaXRpb24tQ29kZXMK
TWVzc2FnZS1pZDogMjAxOTA1MjYwNzQ1MjcuMzM2MzItMS1sdWNpZW5tcF9hbnRpc3BhbUB5YWhv
by5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
VXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hl
ZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmQxMmNiNTIgVGhlIG02OGsgZ2Ric3R1YiBTUiByZWcg
cmVxdWVzdCBkb2VzbnQgaW5jbHVkZSBDb25kaXRpb24tQ29kZXMKCj09PSBPVVRQVVQgQkVHSU4g
PT09CkVSUk9SOiBBdXRob3IgZW1haWwgYWRkcmVzcyBpcyBtYW5nbGVkIGJ5IHRoZSBtYWlsaW5n
IGxpc3QKIzI6IApBdXRob3I6IEx1Y2llbiBNdXJyYXktUGl0dHMgdmlhIFFlbXUtZGV2ZWwgPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTIgbGlu
ZXMgY2hlY2tlZAoKQ29tbWl0IGQxMmNiNTJkNmM3ZiAoVGhlIG02OGsgZ2Ric3R1YiBTUiByZWcg
cmVxdWVzdCBkb2VzbnQgaW5jbHVkZSBDb25kaXRpb24tQ29kZXMpIGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNv
ZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzIwMTkwNTI2MDc0NTI3LjMzNjMyLTEtbHVjaWVubXBfYW50aXNwYW1AeWFob28uY29tL3Rl
c3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


