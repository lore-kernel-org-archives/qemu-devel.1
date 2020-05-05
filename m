Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68904C4725A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E054206CC
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E054206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVtpZ-0004x6-E4
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 05:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jVtot-0004HU-Gm; Tue, 05 May 2020 05:24:55 -0400
Resent-Date: Tue, 05 May 2020 05:24:55 -0400
Resent-Message-Id: <E1jVtot-0004HU-Gm@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jVtoq-0001SA-Bb; Tue, 05 May 2020 05:24:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588670681; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Wm2uQQQkvPn1rzPCGz3mKaYrvG0V5x3v+g8odMGQ5zeY+o97wEl3p71LoY6tYrHXh7p3SIIx1ogSAzaf9bOAcSTVio3bjPydWwPc5tJUdpS0jmCT/x5nghudXjeMLbDEokED+rPfCB22O7G76d5H+f8PO91hx4c7cOwuhyFaxBY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588670681;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=M2+qVBI994rvijMPurSNQ1iK1Lt+3BChHqLJI5frr0I=; 
 b=BCweWcbPOa6gR29IHGpV226yAOyomgaeOfK5QOdqlpx7KhQm7Y+5G8lM79vF/CRKlMbzfiGkF9fnpQgnWoJPHRFwj9Xk8g96SGi0CkNoENkd0IwdXLigHNOBnamu4hf74OG/+NtfBZ2LtKEiUeFtZdroTds5qFkpo16nZ6Qo4Cg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588670678982549.4287905633315;
 Tue, 5 May 2020 02:24:38 -0700 (PDT)
Message-ID: <158867067770.24779.1984605556267794794@45ef0f9c86ae>
In-Reply-To: <20200504142125.31180-1-edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 0/1] target/arm: Remove access_el3_aa32ns()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: edgar.iglesias@gmail.com
Date: Tue, 5 May 2020 02:24:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 04:16:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 laurent.desnogues@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNDE0MjEyNS4zMTE4
MC0xLWVkZ2FyLmlnbGVzaWFzQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MDQxNDIxMjUuMzExODAtMS1lZGdh
ci5pZ2xlc2lhc0BnbWFpbC5jb20KU3ViamVjdDogW1BBVENIIHYyIDAvMV0gdGFyZ2V0L2FybTog
UmVtb3ZlIGFjY2Vzc19lbDNfYWEzMm5zKCkKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBl
eGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGht
IGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NApmYXRhbDogdW5hYmxlIHRvIHdyaXRlIG5ldyBpbmRleCBmaWxlCndhcm5p
bmc6IENsb25lIHN1Y2NlZWRlZCwgYnV0IGNoZWNrb3V0IGZhaWxlZC4KWW91IGNhbiBpbnNwZWN0
IHdoYXQgd2FzIGNoZWNrZWQgb3V0IHdpdGggJ2dpdCBzdGF0dXMnCmFuZCByZXRyeSB0aGUgY2hl
Y2tvdXQgd2l0aCAnZ2l0IGNoZWNrb3V0IC1mIEhFQUQnCgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50
IGNhbGwgbGFzdCk6CiAgRmlsZSAicGF0Y2hldy10ZXN0ZXIvc3JjL3BhdGNoZXctY2xpIiwgbGlu
ZSA1MjEsIGluIHRlc3Rfb25lCiAgICBnaXRfY2xvbmVfcmVwbyhjbG9uZSwgclsicmVwbyJdLCBy
WyJoZWFkIl0sIGxvZ2YsIFRydWUpCiAgRmlsZSAicGF0Y2hldy10ZXN0ZXIvc3JjL3BhdGNoZXct
Y2xpIiwgbGluZSA1MywgaW4gZ2l0X2Nsb25lX3JlcG8KICAgIHN1YnByb2Nlc3MuY2hlY2tfY2Fs
bChjbG9uZV9jbWQsIHN0ZGVycj1sb2dmLCBzdGRvdXQ9bG9nZikKICBGaWxlICIvb3B0L3JoL3Jo
LXB5dGhvbjM2L3Jvb3QvdXNyL2xpYjY0L3B5dGhvbjMuNi9zdWJwcm9jZXNzLnB5IiwgbGluZSAy
OTEsIGluIGNoZWNrX2NhbGwKICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBj
bWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ2dpdCcsICdjbG9u
ZScsICctcScsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9wYXRjaGV3LWdpdC1jYWNoZS9odHRwc2dp
dGh1YmNvbXBhdGNoZXdwcm9qZWN0cWVtdS0zYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1qdHM3ZTM1ai9zcmMnXScg
cmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMTI4LgoKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTA0MTQyMTI1LjMxMTgwLTEt
ZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

