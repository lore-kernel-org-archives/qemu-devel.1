Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC423C352BE
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 18:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982E520724
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 18:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982E520724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPrzc-0004rm-OY
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 14:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jPryy-0004L6-Fk
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 14:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jPryw-0003Ft-Hy
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 14:14:23 -0400
Resent-Date: Sat, 18 Apr 2020 14:14:23 -0400
Resent-Message-Id: <E1jPryw-0003Ft-Hy@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jPryw-0003Ev-AB
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 14:14:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587233654; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Rg1yjjnuZu0m/sOK8eLts7jb4RyoMWJgWpGbx5WFKE21CAjwbQGgBx+b3Ftedjlo68uzcKgqjhshkCGaPnImxxY5gU8OcnFoQJ/zid1RGQwjgqGf5q5Tk74fA4zyx4qhbXEYgmHatjjQCohWAK01o7We9MLfbviMc8QJ+15rHxo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587233654;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=SWaMQMtI01F7GLKJaWhCiQsZYwNSkfGdP2Fav9YaifI=; 
 b=SlCkxFy2VnE1LRT3VaCl5yLFWSnTK315YpymjnHYxcULIjBMKlU5ksTPTmBE19vFgkuhKV6NpjjYBb1RmHfLh+PuA4RXws1PBZtTdAeUdRb13mAmKIAfYev+Idq/r31kQgR3V643LSd9eaIVtXO51qB5NXO2hDrj3/1jB4zFLBs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587233653169333.2782638521262;
 Sat, 18 Apr 2020 11:14:13 -0700 (PDT)
In-Reply-To: <20200418162808.4680-1-richard.henderson@linaro.org>
Subject: Re: [PATCH] target/arm: Vectorize integer comparison vs zero
Message-ID: <158723365210.22793.10614489992953160553@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Sat, 18 Apr 2020 11:14:13 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxODE2MjgwOC40Njgw
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSB0YXJnZXQvYXJtOiBWZWN0b3Jp
emUgaW50ZWdlciBjb21wYXJpc29uIHZzIHplcm8KTWVzc2FnZS1pZDogMjAyMDA0MTgxNjI4MDgu
NDY4MC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKVHlwZTogc2VyaWVzCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYv
bnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIx
NjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmVj
YWVlMjQgdGFyZ2V0L2FybTogVmVjdG9yaXplIGludGVnZXIgY29tcGFyaXNvbiB2cyB6ZXJvCgo9
PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc9
PScgKGN0eDpXeEIpCiM1MjY6IEZJTEU6IHRhcmdldC9hcm0vdmVjX2hlbHBlci5jOjEyNzI6CitE
T19DTVAwKGd2ZWNfY2VxMF9iLCBpbnQ4X3QsID09KQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc8JyAoY3R4Old4QikK
IzUyNzogRklMRTogdGFyZ2V0L2FybS92ZWNfaGVscGVyLmM6MTI3MzoKK0RPX0NNUDAoZ3ZlY19j
bHQwX2IsIGludDhfdCwgPCkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6
IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnPD0nIChjdHg6V3hCKQojNTI4OiBGSUxFOiB0
YXJnZXQvYXJtL3ZlY19oZWxwZXIuYzoxMjc0OgorRE9fQ01QMChndmVjX2NsZTBfYiwgaW50OF90
LCA8PSkKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1
aXJlZCBhcm91bmQgdGhhdCAnPicgKGN0eDpXeEIpCiM1Mjk6IEZJTEU6IHRhcmdldC9hcm0vdmVj
X2hlbHBlci5jOjEyNzU6CitET19DTVAwKGd2ZWNfY2d0MF9iLCBpbnQ4X3QsID4pCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRo
YXQgJz49JyAoY3R4Old4QikKIzUzMDogRklMRTogdGFyZ2V0L2FybS92ZWNfaGVscGVyLmM6MTI3
NjoKK0RPX0NNUDAoZ3ZlY19jZ2UwX2IsIGludDhfdCwgPj0pCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJz09JyAoY3R4
Old4QikKIzUzMjogRklMRTogdGFyZ2V0L2FybS92ZWNfaGVscGVyLmM6MTI3ODoKK0RPX0NNUDAo
Z3ZlY19jZXEwX2gsIGludDE2X3QsID09KQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnPCcgKGN0eDpXeEIpCiM1MzM6
IEZJTEU6IHRhcmdldC9hcm0vdmVjX2hlbHBlci5jOjEyNzk6CitET19DTVAwKGd2ZWNfY2x0MF9o
LCBpbnQxNl90LCA8KQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNw
YWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnPD0nIChjdHg6V3hCKQojNTM0OiBGSUxFOiB0YXJn
ZXQvYXJtL3ZlY19oZWxwZXIuYzoxMjgwOgorRE9fQ01QMChndmVjX2NsZTBfaCwgaW50MTZfdCwg
PD0pCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVp
cmVkIGFyb3VuZCB0aGF0ICc+JyAoY3R4Old4QikKIzUzNTogRklMRTogdGFyZ2V0L2FybS92ZWNf
aGVscGVyLmM6MTI4MToKK0RPX0NNUDAoZ3ZlY19jZ3QwX2gsIGludDE2X3QsID4pCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0
aGF0ICc+PScgKGN0eDpXeEIpCiM1MzY6IEZJTEU6IHRhcmdldC9hcm0vdmVjX2hlbHBlci5jOjEy
ODI6CitET19DTVAwKGd2ZWNfY2dlMF9oLCBpbnQxNl90LCA+PSkKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4KCnRvdGFsOiAxMCBlcnJvcnMsIDAgd2FybmluZ3MsIDQ4OCBsaW5lcyBj
aGVja2VkCgpDb21taXQgZWNhZWUyNGVjYjc3ICh0YXJnZXQvYXJtOiBWZWN0b3JpemUgaW50ZWdl
ciBjb21wYXJpc29uIHZzIHplcm8pIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDE4MTYyODA4
LjQ2ODAtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

