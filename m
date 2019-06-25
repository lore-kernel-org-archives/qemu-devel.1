Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE82C4646C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 01:15:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E80720663
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 01:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E80720663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55802 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfa3m-0002oZ-Eh
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 21:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hfa33-0002HK-KE
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 21:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hfa32-0003t3-6k
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 21:15:01 -0400
Resent-Date: Mon, 24 Jun 2019 21:15:01 -0400
Resent-Message-Id: <E1hfa32-0003t3-6k@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hfa31-0003sY-UM; Mon, 24 Jun 2019 21:15:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561425283; cv=none; d=zoho.com; s=zohoarc; 
 b=LndH36GWcNK1tCg7lhs6yhJsZqeppj/G52jBlsmEhtC6hPug7mglMFeXXeQeQgbYX5SXKm74bx7J1K90M4G4y2R/ONRUc0yhJJLC+UQyjp9Au3uWs95rY8oQwO6aHIdQg14A1FO6rM1p7dVR1Afiqma3v53uRxww6b6acQJ8LPo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561425283;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=5hDykxSWcFB0H9wFvGyjzT8nmfFPFFKuJsO3DE+Ond0=; 
 b=YyWbf2EA2//gVyUK66CRbdyNpSxF67+UCBcAf2ZF0gAgMpu9lCoYusJHyj8rJiNcUQ0R+RB1jD0gKIBsxXFb/+6iISel+DWfuzZ7QBuRSGAYsUKWzBl2a/yiro+17BUocc5wsq6oOMW2gtvLc8HMbXPlsnrq0h19LsqYhrHIBlw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561425282630963.4045046630614;
 Mon, 24 Jun 2019 18:14:42 -0700 (PDT)
Message-ID: <156142528155.24.5943661374750609897@c4a48874b076>
In-Reply-To: <cover.1561419713.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alistair.francis@wdc.com
Date: Mon, 24 Jun 2019 18:14:42 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Miscellaneous patches from the
 RISC-V fork
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com, palmer@sifive.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTYxNDE5NzEzLmdp
dC5hbGlzdGFpci5mcmFuY2lzQHdkYy5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IGNvdmVyLjE1NjE0MTk3MTMuZ2l0LmFsaXN0YWly
LmZyYW5jaXNAd2RjLmNvbQpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRD
SCB2MiAwLzRdIE1pc2NlbGxhbmVvdXMgcGF0Y2hlcyBmcm9tIHRoZSBSSVNDLVYgZm9yawoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAv
ZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFj
ayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29t
L3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvY292ZXIu
MTU2MTQxOTcxMy5naXQuYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tIC0+IHBhdGNoZXcvY292ZXIu
MTU2MTQxOTcxMy5naXQuYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tClN3aXRjaGVkIHRvIGEgbmV3
IGJyYW5jaCAndGVzdCcKZWEzOTUwOSB0YXJnZXQvcmlzY3Y6IEltcGxlbWVudCByaXNjdl9jcHVf
dW5hc3NpZ25lZF9hY2Nlc3MKZTFjYTI2NCBkaXNhcy9yaXNjdjogRml4IGByZGluc3RyZXRoYCBj
b25zdHJhaW50CjZlMTE5YTUgZGlzYXMvcmlzY3Y6IERpc2Fzc2VtYmxlIHJlc2VydmVkIGNvbXBy
ZXNzZWQgZW5jb2RpbmdzIGFzIGlsbGVnYWwKZWI0YjgwNCB0YXJnZXQvcmlzY3Y6IEZpeCBQTVAg
cmFuZ2UgYm91bmRhcnkgYWRkcmVzcyBidWcKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNCBDaGVj
a2luZyBjb21taXQgZWI0YjgwNDgxYjFhICh0YXJnZXQvcmlzY3Y6IEZpeCBQTVAgcmFuZ2UgYm91
bmRhcnkgYWRkcmVzcyBidWcpCjIvNCBDaGVja2luZyBjb21taXQgNmUxMTlhNTYyYjM1IChkaXNh
cy9yaXNjdjogRGlzYXNzZW1ibGUgcmVzZXJ2ZWQgY29tcHJlc3NlZCBlbmNvZGluZ3MgYXMgaWxs
ZWdhbCkKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM1NDogRklMRTogZGlzYXMvcmlz
Y3YuYzoxMDE5OgorICAgIHsgImMuYWRkaTRzcG4iLCBydl9jb2RlY19jaXdfNHNwbiwgcnZfZm10
X3JkX3JzMV9pbW0sIE5VTEwsIHJ2X29wX2FkZGksIHJ2X29wX2FkZGksIHJ2X29wX2FkZGksIHJ2
Y2RfaW1tX256IH0sCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzYzOiBGSUxFOiBk
aXNhcy9yaXNjdi5jOjEwMjc6CisgICAgeyAiYy5hZGRpIiwgcnZfY29kZWNfY2ksIHJ2X2ZtdF9y
ZF9yczFfaW1tLCBOVUxMLCBydl9vcF9hZGRpLCBydl9vcF9hZGRpLCBydl9vcF9hZGRpLCBydmNk
X2ltbV9ueiB9LAoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM3MTogRklMRTogZGlz
YXMvcmlzY3YuYzoxMDMwOgorICAgIHsgImMuYWRkaTE2c3AiLCBydl9jb2RlY19jaV8xNnNwLCBy
dl9mbXRfcmRfcnMxX2ltbSwgTlVMTCwgcnZfb3BfYWRkaSwgcnZfb3BfYWRkaSwgcnZfb3BfYWRk
aSwgcnZjZF9pbW1fbnogfSwKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNzI6IEZJ
TEU6IGRpc2FzL3Jpc2N2LmM6MTAzMToKKyAgICB7ICJjLmx1aSIsIHJ2X2NvZGVjX2NpX2x1aSwg
cnZfZm10X3JkX2ltbSwgTlVMTCwgcnZfb3BfbHVpLCBydl9vcF9sdWksIHJ2X29wX2x1aSwgcnZj
ZF9pbW1fbnogfSwKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNzM6IEZJTEU6IGRp
c2FzL3Jpc2N2LmM6MTAzMjoKKyAgICB7ICJjLnNybGkiLCBydl9jb2RlY19jYl9zaDYsIHJ2X2Zt
dF9yZF9yczFfaW1tLCBOVUxMLCBydl9vcF9zcmxpLCBydl9vcF9zcmxpLCBydl9vcF9zcmxpLCBy
dmNkX2ltbV9ueiB9LAoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM3NDogRklMRTog
ZGlzYXMvcmlzY3YuYzoxMDMzOgorICAgIHsgImMuc3JhaSIsIHJ2X2NvZGVjX2NiX3NoNiwgcnZf
Zm10X3JkX3JzMV9pbW0sIE5VTEwsIHJ2X29wX3NyYWksIHJ2X29wX3NyYWksIHJ2X29wX3NyYWks
IHJ2Y2RfaW1tX256IH0sCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzc1OiBGSUxF
OiBkaXNhcy9yaXNjdi5jOjEwMzQ6CisgICAgeyAiYy5hbmRpIiwgcnZfY29kZWNfY2JfaW1tLCBy
dl9mbXRfcmRfcnMxX2ltbSwgTlVMTCwgcnZfb3BfYW5kaSwgcnZfb3BfYW5kaSwgcnZfb3BfYW5k
aSwgcnZjZF9pbW1fbnogfSwKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojODQ6IEZJ
TEU6IGRpc2FzL3Jpc2N2LmM6MTA0NDoKKyAgICB7ICJjLnNsbGkiLCBydl9jb2RlY19jaV9zaDYs
IHJ2X2ZtdF9yZF9yczFfaW1tLCBOVUxMLCBydl9vcF9zbGxpLCBydl9vcF9zbGxpLCBydl9vcF9z
bGxpLCBydmNkX2ltbV9ueiB9LAoKdG90YWw6IDggZXJyb3JzLCAwIHdhcm5pbmdzLCAxMDAgbGlu
ZXMgY2hlY2tlZAoKUGF0Y2ggMi80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzQgQ2hl
Y2tpbmcgY29tbWl0IGUxY2EyNjQ4MWNhOSAoZGlzYXMvcmlzY3Y6IEZpeCBgcmRpbnN0cmV0aGAg
Y29uc3RyYWludCkKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMyNDogRklMRTogZGlz
YXMvcmlzY3YuYzo2MTc6CitzdGF0aWMgY29uc3QgcnZjX2NvbnN0cmFpbnQgcnZjY19yZGluc3Ry
ZXRoW10gPSB7IHJ2Y19yczFfZXFfeDAsIHJ2Y19jc3JfZXFfMHhjODIsIHJ2Y19lbmQgfTsKCkVS
Uk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMzM6IEZJTEU6IGRpc2FzL3Jpc2N2LmM6MTAz
NDoKKyAgICB7ICJjLmFuZGkiLCBydl9jb2RlY19jYl9pbW0sIHJ2X2ZtdF9yZF9yczFfaW1tLCBO
VUxMLCBydl9vcF9hbmRpLCBydl9vcF9hbmRpLCBydl9vcF9hbmRpIH0sCgp0b3RhbDogMiBlcnJv
cnMsIDAgd2FybmluZ3MsIDE2IGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvNCBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoKNC80IENoZWNraW5nIGNvbW1pdCBlYTM5NTA5ZTkxNGMgKHRhcmdldC9y
aXNjdjogSW1wbGVtZW50IHJpc2N2X2NwdV91bmFzc2lnbmVkX2FjY2VzcykKPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292ZXIuMTU2MTQxOTcxMy5n
aXQuYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


