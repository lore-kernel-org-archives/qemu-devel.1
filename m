Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EEFC55186
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E532073A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E532073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRbvX-0006ah-5u
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRbuZ-0005Gv-QT
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRbuY-0005rF-2j
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:29:03 -0400
Resent-Date: Thu, 23 Apr 2020 09:29:03 -0400
Resent-Message-Id: <E1jRbuY-0005rF-2j@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRbuX-0005nd-FV; Thu, 23 Apr 2020 09:29:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587648532; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fiSwNNGBt9Dr9Nh5xnH4Ko02G4AZsdYPR7Sqmn1ed/nFLtIV/ydbHwvTK3+6zt/WNmvVe37qsrdrtzMY8JpItzLkQ+tgKdKgJVCVV1DyrYJYmlvgvf0XJTB5YvyR3WIA06CRX/0MnI/YSly88VvISriXmMBtPWAjtIUq/mH41ZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587648532;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=zbSRhFpBGBH/9k0bzDfw8EnC7n7sCd0LsYtBEgFyySw=; 
 b=JHhqtHuUIYLUUsryNtJPbMSRigrgKwny0n8pDgIBY9R7rYbyAqYlA0F5l4qQtWBB0xzQCjIo1FjzFIDEgRBV8y+90s3vvaunvKX6pHjBj55wU2XNHyH+uoaXJd+otmBKJVquF6rbsCaLOOF3QcWm5P1DHMrqP3y/7Z/7ZcOd7dI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587648530442248.202634769925;
 Thu, 23 Apr 2020 06:28:50 -0700 (PDT)
In-Reply-To: <20200423124305.14718-1-f4bug@amsat.org>
Subject: Re: [PATCH] target/arm: Use correct variable for setting 'max' cpu's
 MIDR_EL1
Message-ID: <158764852938.10590.18035515087284220349@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Thu, 23 Apr 2020 06:28:50 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 09:27:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMzEyNDMwNS4xNDcx
OC0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSB0YXJnZXQvYXJtOiBVc2UgY29ycmVjdCB2YXJpYWJs
ZSBmb3Igc2V0dGluZyAnbWF4JyBjcHUncyBNSURSX0VMMQpNZXNzYWdlLWlkOiAyMDIwMDQyMzEy
NDMwNS4xNDcxOC0xLWY0YnVnQGFtc2F0Lm9yZwpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8
IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0
aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0CmZhdGFsOiB1bmFibGUgdG8gYWNjZXNzICdodHRwczovL2dpdGh1Yi5j
b20vcGF0Y2hldy1wcm9qZWN0L3FlbXUvJzogVGhlIHJlcXVlc3RlZCBVUkwgcmV0dXJuZWQgZXJy
b3I6IDUwNAplcnJvcjogQ291bGQgbm90IGZldGNoIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
ZjQ0YmQ4ODg3MTMzODQKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUg
InBhdGNoZXctdGVzdGVyL3NyYy9wYXRjaGV3LWNsaSIsIGxpbmUgNTIxLCBpbiB0ZXN0X29uZQog
ICAgZ2l0X2Nsb25lX3JlcG8oY2xvbmUsIHJbInJlcG8iXSwgclsiaGVhZCJdLCBsb2dmLCBUcnVl
KQogIEZpbGUgInBhdGNoZXctdGVzdGVyL3NyYy9wYXRjaGV3LWNsaSIsIGxpbmUgNDgsIGluIGdp
dF9jbG9uZV9yZXBvCiAgICBzdGRvdXQ9bG9nZiwgc3RkZXJyPWxvZ2YpCiAgRmlsZSAiL29wdC9y
aC9yaC1weXRob24zNi9yb290L3Vzci9saWI2NC9weXRob24zLjYvc3VicHJvY2Vzcy5weSIsIGxp
bmUgMjkxLCBpbiBjaGVja19jYWxsCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29k
ZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydnaXQnLCAn
cmVtb3RlJywgJ2FkZCcsICctZicsICctLW1pcnJvcj1mZXRjaCcsICczYzhjZjVhOWMyMWZmODc4
MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0JywgJ2h0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXBy
b2plY3QvcWVtdSddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAxLgoKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDIzMTI0
MzA1LjE0NzE4LTEtZjRidWdAYW1zYXQub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

