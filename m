Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BBCC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 17:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F672080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 17:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F672080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn4Ny-0002sP-6D
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 13:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39659)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hn4Nk-0002To-O8
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hn4Nj-0002Hz-9I
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:03:20 -0400
Resent-Date: Mon, 15 Jul 2019 13:03:20 -0400
Resent-Message-Id: <E1hn4Nj-0002Hz-9I@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hn4Nj-0002Ew-3F
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 13:03:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563210191; cv=none; d=zoho.com; s=zohoarc; 
 b=UKUg4n3ov4QhPwbZ2meuy8GHHOKqoy3QrKYiiKSWbvURfLxKSXpa5d70QKFYTbXSnADiLgrIxRmHVBiTOiMJmm8dVskw0fECZoCXvKUiHZk2NRXWIPEaGmnLOhizbSuR6m+KCVsS0zIPLZvXbw+pTvnOITDfztIJltkLCLmb9b0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1563210191;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=h7nBi0GcM/vo+haoRHI7jCjm+75csRHV5NGyIl4450Y=; 
 b=ON1HxD5aj4qOS5lAWsALfoPvTqUOFOeQTvOA2EvLbM4egOKAQb56LK0dI9xxpyk/4vkoJsTRa84rl+ZIomqM1ih/M5qQgvcySv9apTgzcfH/Wui2kkSmAza/dM9H6W3Me5v3U6wj82S7GBuYrmTW06KZB28sgo71/IMM7hK9SrQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1563210189228330.5234500038224;
 Mon, 15 Jul 2019 10:03:09 -0700 (PDT)
Message-ID: <156321018841.3080.5007760449569935702@c4a48874b076>
In-Reply-To: <20190715134211.23063-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Mon, 15 Jul 2019 10:03:09 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
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
b3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA3MTUxMzQyMTEuMjMwNjMtMS1wZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmcKVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRldmVsXSBb
UFVMTCAwMC8xMF0gdGFyZ2V0LWFybSBxdWV1ZQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAq
IFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA3MTUxMzQyMTEuMjMwNjMtMS1w
ZXRlci5tYXlkZWxsQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDE5MDcxNTEzNDIxMS4yMzA2My0x
LXBldGVyLm1heWRlbGxAbGluYXJvLm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CjM3NGZkYjkzNmUgdGFyZ2V0L2FybTogTlMgQnVzRmF1bHQgb24gdmVjdG9yIHRhYmxlIGZldGNo
IGVzY2FsYXRlcyB0byBOUyBIYXJkRmF1bHQKYTMwYjFkYWQ4MSB0YXJnZXQvYXJtOiBTZXQgVkZQ
LXJlbGF0ZWQgTVZGUjAgZmllbGRzIGZvciBhcm05MjYgYW5kIGFybTEwMjYKNmQ3MDUxNzczZiBw
bDAzMTogQ29ycmVjdGx5IG1pZ3JhdGUgc3RhdGUgd2hlbiB1c2luZyAtcnRjIGNsb2NrPWhvc3QK
OTNkNTg0NTViYSBody9hcm0vdmlydDogRml4IG5vbi1zZWN1cmUgZmxhc2ggbW9kZQowODU5NGQ5
ODMxIGh3L2Rpc3BsYXkveGxueF9kcDogQXZvaWQgY3Jhc2ggd2hlbiByZWFkaW5nIGVtcHR5IFJY
IEZJRk8KZDRiZmVlNjQwMyBody9zc2kvbXNzLXNwaTogQXZvaWQgY3Jhc2ggd2hlbiByZWFkaW5n
IGVtcHR5IFJYIEZJRk8KNTIxZGNmYzYyMSBody9zc2kveGlsaW54X3NwaXBzOiBBdm9pZCBvdXQt
b2YtYm91bmQgYWNjZXNzIHRvIGxxc3BpX2J1ZltdCjI4ZGM5OTRhODcgaHcvc3NpL3hpbGlueF9z
cGlwczogQXZvaWQgQVhJIHdyaXRlcyB0byB0aGUgTFFTUEkgbGluZWFyIG1lbW9yeQozM2QxMGQz
OWJkIGh3L3NzaS94aWxpbnhfc3BpcHM6IENvbnZlcnQgbHFzcGlfcmVhZCgpIHRvIHJlYWRfd2l0
aF9hdHRycwo0YWQ1NDBjYjAwIHRhcmdldC9hcm06IHJlcG9ydCBBUk12OC1BIEZQIHN1cHBvcnQg
Zm9yIEFBcmNoMzIgLWNwdSBtYXgKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTAgQ2hlY2tpbmcg
Y29tbWl0IDRhZDU0MGNiMDAzZiAodGFyZ2V0L2FybTogcmVwb3J0IEFSTXY4LUEgRlAgc3VwcG9y
dCBmb3IgQUFyY2gzMiAtY3B1IG1heCkKMi8xMCBDaGVja2luZyBjb21taXQgMzNkMTBkMzliZDFl
IChody9zc2kveGlsaW54X3NwaXBzOiBDb252ZXJ0IGxxc3BpX3JlYWQoKSB0byByZWFkX3dpdGhf
YXR0cnMpCjMvMTAgQ2hlY2tpbmcgY29tbWl0IDI4ZGM5OTRhODc3MSAoaHcvc3NpL3hpbGlueF9z
cGlwczogQXZvaWQgQVhJIHdyaXRlcyB0byB0aGUgTFFTUEkgbGluZWFyIG1lbW9yeSkKNC8xMCBD
aGVja2luZyBjb21taXQgNTIxZGNmYzYyMTMxIChody9zc2kveGlsaW54X3NwaXBzOiBBdm9pZCBv
dXQtb2YtYm91bmQgYWNjZXNzIHRvIGxxc3BpX2J1ZltdKQo1LzEwIENoZWNraW5nIGNvbW1pdCBk
NGJmZWU2NDAzYTYgKGh3L3NzaS9tc3Mtc3BpOiBBdm9pZCBjcmFzaCB3aGVuIHJlYWRpbmcgZW1w
dHkgUlggRklGTykKNi8xMCBDaGVja2luZyBjb21taXQgMDg1OTRkOTgzMWI0IChody9kaXNwbGF5
L3hsbnhfZHA6IEF2b2lkIGNyYXNoIHdoZW4gcmVhZGluZyBlbXB0eSBSWCBGSUZPKQo3LzEwIENo
ZWNraW5nIGNvbW1pdCA5M2Q1ODQ1NWJhZjYgKGh3L2FybS92aXJ0OiBGaXggbm9uLXNlY3VyZSBm
bGFzaCBtb2RlKQo4LzEwIENoZWNraW5nIGNvbW1pdCA2ZDcwNTE3NzNmMjcgKHBsMDMxOiBDb3Jy
ZWN0bHkgbWlncmF0ZSBzdGF0ZSB3aGVuIHVzaW5nIC1ydGMgY2xvY2s9aG9zdCkKRVJST1I6IHNw
YWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpWeFYpCiMxNTg6IEZJTEU6IGh3L3Rp
bWVyL3BsMDMxLmM6MzAwOgorICAgIC5zdWJzZWN0aW9ucyA9IChjb25zdCBWTVN0YXRlRGVzY3Jp
cHRpb24qW10pIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNDYgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
OC8xMCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2Ug
ZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIs
IHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKOS8xMCBDaGVja2luZyBjb21taXQgYTMw
YjFkYWQ4MTVjICh0YXJnZXQvYXJtOiBTZXQgVkZQLXJlbGF0ZWQgTVZGUjAgZmllbGRzIGZvciBh
cm05MjYgYW5kIGFybTEwMjYpCjEwLzEwIENoZWNraW5nIGNvbW1pdCAzNzRmZGI5MzZlZTkgKHRh
cmdldC9hcm06IE5TIEJ1c0ZhdWx0IG9uIHZlY3RvciB0YWJsZSBmZXRjaCBlc2NhbGF0ZXMgdG8g
TlMgSGFyZEZhdWx0KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDE5MDcxNTEzNDIxMS4yMzA2My0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


