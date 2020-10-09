Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E7CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F2B22282
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F2B22282
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQwAZ-0005Jl-S7
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQw8h-0004KP-Qu
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:25:07 -0400
Resent-Date: Fri, 09 Oct 2020 13:25:07 -0400
Resent-Message-Id: <E1kQw8h-0004KP-Qu@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQw8Z-0003cz-PM
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:25:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602264286; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MKmbK/1QNtlzo5ruGJgXxe0ZHdwoMWMn/Gy1FJb6eikn4mIK8CsoslRdrGr01WeekuovKQNq5tew2a8dDjcLAIOlf1zhHyHYEqfcgCj83GnuhfWzKJQb78x7dw6iUSBrvMNTWneSMYC5wCG8D6qbisTUu4gw6KiSxIqKvqQC0eU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602264286;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=HT5yyVhmlCGXyEtoGA0BDR5xufCEOF4yb/7ulvjfAUM=; 
 b=fMnE4WsLEDF0vrbEXr+zJca2P+zdwwveeBcHBtU4Pl/zJ2Hyc+8PnGrw+qoyAb5o2XIFeEDs7UfDA3CTKMkKGpYTPeSm8FEBkuY11Ex6j3pc5m0geCj4YY/v4iQZQEu/GelHN+aRf14fAYjX2HWZBr5AYpi0M5CSLPOw1ss7QAI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602264284877215.53485288076422;
 Fri, 9 Oct 2020 10:24:44 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] generic loader FDT support (for direct Xen boot)
Message-ID: <160226428305.28248.1939040069586599654@66eaa9a8a123>
In-Reply-To: <20201009170742.23695-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Fri, 9 Oct 2020 10:24:44 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 11:31:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, qemu-devel@nongnu.org,
 takahiro.akashi@linaro.org, stefano.stabellini@xilinx.com,
 alex.bennee@linaro.org, stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAwOTE3MDc0Mi4yMzY5
NS0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMTAwOTE3MDc0Mi4y
MzY5NS0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcKU3ViamVjdDogW1JGQyBQQVRDSCAgMC80XSBn
ZW5lcmljIGxvYWRlciBGRFQgc3VwcG9ydCAoZm9yIGRpcmVjdCBYZW4gYm9vdCkKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2
NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJv
amVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDEwMDkxNzA3NDIuMjM2
OTUtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAyMDEwMDkxNzA3NDIuMjM2
OTUtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVz
dCcKOGZiY2NiZSBnZW5lcmljX2xvYWRlcjogYWxsb3cgdGhlIGluc2VydGlvbiBvZiAvY2hvc2Vu
L21vZHVsZSBzdGFuemFzCjJiYWYwN2EgZGV2aWNlX3RyZWU6IGFkZCBxZW11X2ZkdF9zZXRwcm9w
X3N0cmluZ19hcnJheSBoZWxwZXIKZGQ2ZWVhMyBody9yaXNjdjogbWlncmF0ZSBmZHQgZmllbGQg
dG8gZ2VuZXJpYyBNYWNoaW5lU3RhdGUKZGQ4ZWU4NiBody9ib2FyZDogcHJvbW90ZSBmZHQgZnJv
bSBBUk0gVmlydE1hY2hpbmVTdGF0ZSB0byBNYWNoaW5lU3RhdGUKCj09PSBPVVRQVVQgQkVHSU4g
PT09CjEvNCBDaGVja2luZyBjb21taXQgZGQ4ZWU4NmY1Y2RmIChody9ib2FyZDogcHJvbW90ZSBm
ZHQgZnJvbSBBUk0gVmlydE1hY2hpbmVTdGF0ZSB0byBNYWNoaW5lU3RhdGUpCjIvNCBDaGVja2lu
ZyBjb21taXQgZGQ2ZWVhM2U2ZTM0IChody9yaXNjdjogbWlncmF0ZSBmZHQgZmllbGQgdG8gZ2Vu
ZXJpYyBNYWNoaW5lU3RhdGUpCjMvNCBDaGVja2luZyBjb21taXQgMmJhZjA3YTdhYmZjIChkZXZp
Y2VfdHJlZTogYWRkIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nX2FycmF5IGhlbHBlcikKV0FSTklO
RzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzM1OiBGSUxFOiBkZXZpY2VfdHJlZS5jOjQwNjoK
K2ludCBxZW11X2ZkdF9zZXRwcm9wX3N0cmluZ19hcnJheSh2b2lkICpmZHQsIGNvbnN0IGNoYXIg
Km5vZGVfcGF0aCwgY29uc3QgY2hhciAqcHJvcCwKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5n
cywgNjEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
CjQvNCBDaGVja2luZyBjb21taXQgOGZiY2NiZWM5NjI4IChnZW5lcmljX2xvYWRlcjogYWxsb3cg
dGhlIGluc2VydGlvbiBvZiAvY2hvc2VuL21vZHVsZSBzdGFuemFzKQpFUlJPUjogRG9uJ3QgdXNl
ICcjJyBmbGFnIG9mIHByaW50ZiBmb3JtYXQgKCclIycpIGluIGZvcm1hdCBzdHJpbmdzLCB1c2Ug
JzB4JyBwcmVmaXggaW5zdGVhZAojNTE6IEZJTEU6IGh3L2NvcmUvZ2VuZXJpYy1sb2FkZXIuYzo3
MzoKKyAgICBnX2F1dG9mcmVlIGNoYXIgKm5vZGUgPSBnX3N0cmR1cF9wcmludGYoIi9jaG9zZW4v
bW9kdWxlQCUjMDhseCIsIHMtPmFkZHIpOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3Rl
cnMKIzcxOiBGSUxFOiBody9jb3JlL2dlbmVyaWMtbG9hZGVyLmM6OTM6CisgICAgICAgIGlmIChx
ZW11X2ZkdF9zZXRwcm9wX3N0cmluZyhmZHQsIG5vZGUsICJib290YXJncyIsIHMtPmZkdF9ib290
YXJncykgPCAwKSB7Cgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDc2IGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDQvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDEwMDkxNzA3NDIuMjM2OTUt
MS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

