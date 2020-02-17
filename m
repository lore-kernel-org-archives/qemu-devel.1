Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55A0C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8306C2064C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8306C2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mC1-0003hK-MV
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j3m71-000335-8Y
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j3m6z-0004AG-FS
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:31:22 -0500
Resent-Date: Mon, 17 Feb 2020 14:31:22 -0500
Resent-Message-Id: <E1j3m6z-0004AG-FS@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j3m6z-00048k-7U; Mon, 17 Feb 2020 14:31:21 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581967862; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=g8wLkRIptXx/LhlIcWxRe6FiHhdQh7XmmtXvjpUAe8Win+QAt6DKn4wECqVTaIOITZtI+G3hKU0o46HNHlHnjR4VwD8tQ3ISHjT8v7Egwhwoh5E7Ex0QRzbAc74utsKWjSe9sNXa6l2mcwV3iNDO1a6Xdvln/xR05Qksd7evzO8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581967862;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=z3lUIvAdnNmYH3TVVuu+4iaVutqqW/O+35tNj6G4BeY=; 
 b=STfEM5GL3/zKcYpvza8AGPwTTO3MDgsg8WyThDZDYFH64/kzKx0dra5WEZk2Q5DaNb965R+7IzyqM8AfbrPNtQz7jQGf5qnMOLVd4LH668dqZYx5KpwcMZG7TJvA0Qqmt3QR0dcZCvHtcYLlSo9agtcOvhvm/LsGUlFwyoEFLqg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158196786032577.55054764102533;
 Mon, 17 Feb 2020 11:31:00 -0800 (PST)
In-Reply-To: <20200217150246.29180-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 00/22] Fix error handling during bitmap postcopy
Message-ID: <158196785831.4691.4320620594865587471@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Mon, 17 Feb 2020 11:31:00 -0800 (PST)
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, quintela@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, stefanha@redhat.com,
 crosa@redhat.com, andrey.shinkevich@virtuozzo.com, mreitz@redhat.com,
 jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxNzE1MDI0Ni4yOTE4
MC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYyIDAwLzIyXSBGaXggZXJyb3IgaGFu
ZGxpbmcgZHVyaW5nIGJpdG1hcCBwb3N0Y29weQpNZXNzYWdlLWlkOiAyMDIwMDIxNzE1MDI0Ni4y
OTE4MC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CmZhdGFsOiBnaXQgZmV0Y2hfcGFjazogZXhwZWN0ZWQgQUNLL05B
SywgZ290ICdFUlIgdXBsb2FkLXBhY2s6IG5vdCBvdXIgcmVmIDI0N2I1ODhjMzU3Njk0Yzg5NmQw
NTY4MzZkYTIzNDFkNzU0NTFjNGYnCmZhdGFsOiBUaGUgcmVtb3RlIGVuZCBodW5nIHVwIHVuZXhw
ZWN0ZWRseQplcnJvcjogQ291bGQgbm90IGZldGNoIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
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
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMjE3MTUw
MjQ2LjI5MTgwLTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

