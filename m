Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC1BC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D9B208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D9B208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXbo-0003ox-Pg
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:29:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jUXZx-0002he-3w
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jUXYn-0004ul-KH
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:27:52 -0400
Resent-Date: Fri, 01 May 2020 11:27:52 -0400
Resent-Message-Id: <E1jUXYn-0004ul-KH@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jUXYn-0004hG-3Q; Fri, 01 May 2020 11:26:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588346772; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DHVaeJdBkJtX9IazBRARY9/r4T3aOlqNReYw5hGSOg7Ak3P5u+vRLT6T/Uj98xeD7mn1fPOfDJYaNB+IVcfxT+wuINgjq+sGsIY2/S6+9ZU+eGv2FLdOPIl5n9lo7EpZnyC0WMcX1AetJhRkmIjAG45ouTfhay0qC6W+op3sup0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588346772;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=RdAznY4HlhUIea9kZFkNWEQfRHZCuq4eZ2TuDXCiefE=; 
 b=a8FVSsFr7GZCzY8Qm3g921fqvB4GDD58NVHtvHQ7EoMoZMMP1/8Cz/cqaJLDq5QotcRxhBk/f7ndcx7gVuApXymbYUnl6hnxCUvn9kh80gNPMvfxiyNo/7oL3w0r3G4ffeiqFu81jEKQuJEVmVJvMB8AgRy7GC9FRKri9HhSRg0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588346769928627.7136470441474;
 Fri, 1 May 2020 08:26:09 -0700 (PDT)
Message-ID: <158834676829.4471.4515101300306376465@45ef0f9c86ae>
In-Reply-To: <20200501113704.2240698-1-patrick@stwcx.xyz>
Subject: Re: [PATCH] aspeed: Add support for the sonorapass-bmc board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: patrick@stwcx.xyz
Date: Fri, 1 May 2020 08:26:09 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 11:26:38
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
Cc: peter.maydell@linaro.org, andrew@aj.id.au, amithash@fb.com,
 qemu-devel@nongnu.org, patrick@stwcx.xyz, qemu-arm@nongnu.org, clg@kaod.org,
 vijaykhemka@fb.com, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwMTExMzcwNC4yMjQw
Njk4LTEtcGF0cmlja0BzdHdjeC54eXovCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTAxMTEzNzA0LjIyNDA2OTgtMS1wYXRyaWNr
QHN0d2N4Lnh5egpTdWJqZWN0OiBbUEFUQ0hdIGFzcGVlZDogQWRkIHN1cHBvcnQgZm9yIHRoZSBz
b25vcmFwYXNzLWJtYyBib2FyZApUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwNTAxMTEzNzA0LjIyNDA2OTgtMS1w
YXRyaWNrQHN0d2N4Lnh5eiAtPiBwYXRjaGV3LzIwMjAwNTAxMTEzNzA0LjIyNDA2OTgtMS1wYXRy
aWNrQHN0d2N4Lnh5egpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmFhYjU0MGQgYXNw
ZWVkOiBBZGQgc3VwcG9ydCBmb3IgdGhlIHNvbm9yYXBhc3MtYm1jIGJvYXJkCgo9PT0gT1VUUFVU
IEJFR0lOID09PQpFUlJPUjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzUzOiBGSUxFOiBo
dy9hcm0vYXNwZWVkLmM6Mzk0OgorICAgIC8vIGJ1cyAyIDoKCkVSUk9SOiBkbyBub3QgdXNlIEM5
OSAvLyBjb21tZW50cwojNTY6IEZJTEU6IGh3L2FybS9hc3BlZWQuYzozOTc6CisgICAgLy8gYnVz
IDIgOiBwY2E5NTQ2IEAgMHg3MwoKRVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiM1
ODogRklMRTogaHcvYXJtL2FzcGVlZC5jOjM5OToKKyAgICAvLyBidXMgMyA6IHBjYTk1NDggQCAw
eDcwCgpFUlJPUjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzYwOiBGSUxFOiBody9hcm0v
YXNwZWVkLmM6NDAxOgorICAgIC8vIGJ1cyA0IDoKCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGFm
dGVyIHRoYXQgb3BlbiBwYXJlbnRoZXNpcyAnKCcKIzYxOiBGSUxFOiBody9hcm0vYXNwZWVkLmM6
NDAyOgorICAgIHVpbnQ4X3QgKmVlcHJvbTRfNTQgPSBnX21hbGxvYzAoIDggKiAxMDI0ICk7CgpF
UlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZWZvcmUgdGhhdCBjbG9zZSBwYXJlbnRoZXNpcyAnKScK
IzYxOiBGSUxFOiBody9hcm0vYXNwZWVkLmM6NDAyOgorICAgIHVpbnQ4X3QgKmVlcHJvbTRfNTQg
PSBnX21hbGxvYzAoIDggKiAxMDI0ICk7CgpFUlJPUjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVu
dHMKIzY5OiBGSUxFOiBody9hcm0vYXNwZWVkLmM6NDEwOgorICAgIC8vIGJ1cyA2IDoKCkVSUk9S
OiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojNzI6IEZJTEU6IGh3L2FybS9hc3BlZWQuYzo0
MTM6CisgICAgLy8gYnVzIDYgOiBwY2E5NTQ2IEAgMHg3MwoKRVJST1I6IGRvIG5vdCB1c2UgQzk5
IC8vIGNvbW1lbnRzCiM3NDogRklMRTogaHcvYXJtL2FzcGVlZC5jOjQxNToKKyAgICAvLyBidXMg
OCA6CgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBhZnRlciB0aGF0IG9wZW4gcGFyZW50aGVzaXMg
JygnCiM3NTogRklMRTogaHcvYXJtL2FzcGVlZC5jOjQxNjoKKyAgICB1aW50OF90ICplZXByb204
XzU2ID0gZ19tYWxsb2MwKCA4ICogMTAyNCApOwoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmVm
b3JlIHRoYXQgY2xvc2UgcGFyZW50aGVzaXMgJyknCiM3NTogRklMRTogaHcvYXJtL2FzcGVlZC5j
OjQxNjoKKyAgICB1aW50OF90ICplZXByb204XzU2ID0gZ19tYWxsb2MwKCA4ICogMTAyNCApOwoK
RVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiM4MDogRklMRTogaHcvYXJtL2FzcGVl
ZC5jOjQyMToKKyAgICAvLyBidXMgOCA6IGFkYzEyOGQ4MTggQCAweDFkCgpFUlJPUjogZG8gbm90
IHVzZSBDOTkgLy8gY29tbWVudHMKIzgxOiBGSUxFOiBody9hcm0vYXNwZWVkLmM6NDIyOgorICAg
IC8vIGJ1cyA4IDogYWRjMTI4ZDgxOCBAIDB4MWYKCkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBj
b21tZW50cwojODM6IEZJTEU6IGh3L2FybS9hc3BlZWQuYzo0MjQ6CisgICAgLy8gYnVzIDEzIDog
cGNhOTU0OCBAIDB4NzEKCkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojODQ6IEZJ
TEU6IGh3L2FybS9hc3BlZWQuYzo0MjU6CisgICAgLy8gICAgICAtIGNoYW5uZWwgMzoKCkVSUk9S
OiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojODU6IEZJTEU6IGh3L2FybS9hc3BlZWQuYzo0
MjY6CisgICAgLy8gICAgICAgICAgLSB0bW00MjEgQCAweDRjCgpFUlJPUjogZG8gbm90IHVzZSBD
OTkgLy8gY29tbWVudHMKIzg2OiBGSUxFOiBody9hcm0vYXNwZWVkLmM6NDI3OgorICAgIC8vICAg
ICAgICAgIC0gdG1wNDIxIEAgMHg0ZQoKRVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRz
CiM4NzogRklMRTogaHcvYXJtL2FzcGVlZC5jOjQyODoKKyAgICAvLyAgICAgICAgICAtIHRtcDQy
MSBAIDB4NGYKCnRvdGFsOiAxOCBlcnJvcnMsIDAgd2FybmluZ3MsIDEwMCBsaW5lcyBjaGVja2Vk
CgpDb21taXQgYWFiNTQwZDk2MWNkIChhc3BlZWQ6IEFkZCBzdXBwb3J0IGZvciB0aGUgc29ub3Jh
cGFzcy1ibWMgYm9hcmQpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5E
ID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTAxMTEzNzA0LjIyNDA2
OTgtMS1wYXRyaWNrQHN0d2N4Lnh5ei90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=

