Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B45AC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23807206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23807206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnJFg-0005gY-Ds
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46054)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hnJFW-0005Ht-1G
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hnJFU-0001Ev-Lh
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:55:49 -0400
Resent-Date: Tue, 16 Jul 2019 04:55:49 -0400
Resent-Message-Id: <E1hnJFU-0001Ev-Lh@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hnJFU-00019I-2m
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:55:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563267339; cv=none; d=zoho.com; s=zohoarc; 
 b=Vs/hAHk1/13xodAFSUMf/vcz7oISycktZTOwroe+UHIBAIXrTtaqv/NWspDX2WRQA/f6Yb1s9W6HkAVPhoWrzLZt7NqpdIE1mxJyjfO0jzY4+QLXq1hVAE261bRE3085Xu5jP4LfpPcW7UdCCP6pEQLkRsodO7VSX/IRRZB7os4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1563267339;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=/7NxRJ6aCm7Q1HitfsOXGbBKgZNyAramnMSLXc5cr6A=; 
 b=EHw6lhz+205IQG6ULvfJD3xxDh8w6wYxk7GUe144331I3cYTNdBwsQk0c+k7WRCnQ+nyl/82QsPOoxaFhMyVHoPACd5hwSL5zjyz08GOqd5ED9qDX1/jRBCKj2yJj8cmCjJK6xAkcjcJK1BQo/3qcFWpkPo4J/Ahz4whUHrZge0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1563267337896778.2158463289884;
 Tue, 16 Jul 2019 01:55:37 -0700 (PDT)
Message-ID: <156326733708.3080.10406062385941007342@c4a48874b076>
In-Reply-To: <20190715134211.23063-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Tue, 16 Jul 2019 01:55:37 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PULL 00/10] target-arm queue
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxNTEzNDIxMS4yMzA2
My0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUFVM
TCAwMC8xMF0gdGFyZ2V0LWFybSBxdWV1ZQpNZXNzYWdlLWlkOiAyMDE5MDcxNTEzNDIxMS4yMzA2
My0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAq
IFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxOTA3MTUxMzQyMTEuMjMwNjMtMS1wZXRlci5t
YXlkZWxsQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDE5MDcxNTEzNDIxMS4yMzA2My0xLXBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjM3NGZk
YjkgdGFyZ2V0L2FybTogTlMgQnVzRmF1bHQgb24gdmVjdG9yIHRhYmxlIGZldGNoIGVzY2FsYXRl
cyB0byBOUyBIYXJkRmF1bHQKYTMwYjFkYSB0YXJnZXQvYXJtOiBTZXQgVkZQLXJlbGF0ZWQgTVZG
UjAgZmllbGRzIGZvciBhcm05MjYgYW5kIGFybTEwMjYKNmQ3MDUxNyBwbDAzMTogQ29ycmVjdGx5
IG1pZ3JhdGUgc3RhdGUgd2hlbiB1c2luZyAtcnRjIGNsb2NrPWhvc3QKOTNkNTg0NSBody9hcm0v
dmlydDogRml4IG5vbi1zZWN1cmUgZmxhc2ggbW9kZQowODU5NGQ5IGh3L2Rpc3BsYXkveGxueF9k
cDogQXZvaWQgY3Jhc2ggd2hlbiByZWFkaW5nIGVtcHR5IFJYIEZJRk8KZDRiZmVlNiBody9zc2kv
bXNzLXNwaTogQXZvaWQgY3Jhc2ggd2hlbiByZWFkaW5nIGVtcHR5IFJYIEZJRk8KNTIxZGNmYyBo
dy9zc2kveGlsaW54X3NwaXBzOiBBdm9pZCBvdXQtb2YtYm91bmQgYWNjZXNzIHRvIGxxc3BpX2J1
ZltdCjI4ZGM5OTQgaHcvc3NpL3hpbGlueF9zcGlwczogQXZvaWQgQVhJIHdyaXRlcyB0byB0aGUg
TFFTUEkgbGluZWFyIG1lbW9yeQozM2QxMGQzIGh3L3NzaS94aWxpbnhfc3BpcHM6IENvbnZlcnQg
bHFzcGlfcmVhZCgpIHRvIHJlYWRfd2l0aF9hdHRycwo0YWQ1NDBjIHRhcmdldC9hcm06IHJlcG9y
dCBBUk12OC1BIEZQIHN1cHBvcnQgZm9yIEFBcmNoMzIgLWNwdSBtYXgKCj09PSBPVVRQVVQgQkVH
SU4gPT09CjEvMTAgQ2hlY2tpbmcgY29tbWl0IDRhZDU0MGNiMDAzZiAodGFyZ2V0L2FybTogcmVw
b3J0IEFSTXY4LUEgRlAgc3VwcG9ydCBmb3IgQUFyY2gzMiAtY3B1IG1heCkKMi8xMCBDaGVja2lu
ZyBjb21taXQgMzNkMTBkMzliZDFlIChody9zc2kveGlsaW54X3NwaXBzOiBDb252ZXJ0IGxxc3Bp
X3JlYWQoKSB0byByZWFkX3dpdGhfYXR0cnMpCjMvMTAgQ2hlY2tpbmcgY29tbWl0IDI4ZGM5OTRh
ODc3MSAoaHcvc3NpL3hpbGlueF9zcGlwczogQXZvaWQgQVhJIHdyaXRlcyB0byB0aGUgTFFTUEkg
bGluZWFyIG1lbW9yeSkKNC8xMCBDaGVja2luZyBjb21taXQgNTIxZGNmYzYyMTMxIChody9zc2kv
eGlsaW54X3NwaXBzOiBBdm9pZCBvdXQtb2YtYm91bmQgYWNjZXNzIHRvIGxxc3BpX2J1ZltdKQo1
LzEwIENoZWNraW5nIGNvbW1pdCBkNGJmZWU2NDAzYTYgKGh3L3NzaS9tc3Mtc3BpOiBBdm9pZCBj
cmFzaCB3aGVuIHJlYWRpbmcgZW1wdHkgUlggRklGTykKNi8xMCBDaGVja2luZyBjb21taXQgMDg1
OTRkOTgzMWI0IChody9kaXNwbGF5L3hsbnhfZHA6IEF2b2lkIGNyYXNoIHdoZW4gcmVhZGluZyBl
bXB0eSBSWCBGSUZPKQo3LzEwIENoZWNraW5nIGNvbW1pdCA5M2Q1ODQ1NWJhZjYgKGh3L2FybS92
aXJ0OiBGaXggbm9uLXNlY3VyZSBmbGFzaCBtb2RlKQo4LzEwIENoZWNraW5nIGNvbW1pdCA2ZDcw
NTE3NzNmMjcgKHBsMDMxOiBDb3JyZWN0bHkgbWlncmF0ZSBzdGF0ZSB3aGVuIHVzaW5nIC1ydGMg
Y2xvY2s9aG9zdCkKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpW
eFYpCiMxNTg6IEZJTEU6IGh3L3RpbWVyL3BsMDMxLmM6MzAwOgorICAgIC5zdWJzZWN0aW9ucyA9
IChjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24qW10pIHsKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNDYg
bGluZXMgY2hlY2tlZAoKUGF0Y2ggOC8xMCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKOS8x
MCBDaGVja2luZyBjb21taXQgYTMwYjFkYWQ4MTVjICh0YXJnZXQvYXJtOiBTZXQgVkZQLXJlbGF0
ZWQgTVZGUjAgZmllbGRzIGZvciBhcm05MjYgYW5kIGFybTEwMjYpCjEwLzEwIENoZWNraW5nIGNv
bW1pdCAzNzRmZGI5MzZlZTkgKHRhcmdldC9hcm06IE5TIEJ1c0ZhdWx0IG9uIHZlY3RvciB0YWJs
ZSBmZXRjaCBlc2NhbGF0ZXMgdG8gTlMgSGFyZEZhdWx0KQo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcxNTEzNDIxMS4yMzA2My0xLXBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=


