Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE3FCA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 21:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9697320856
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 21:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9697320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPvJT-0006KQ-AA
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 17:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iPvIN-0005Vw-0o
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 17:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iPvIL-0007JF-9X
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 17:14:22 -0400
Resent-Date: Wed, 30 Oct 2019 17:14:22 -0400
Resent-Message-Id: <E1iPvIL-0007JF-9X@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iPvIK-0007FU-W6
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 17:14:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572470052; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W9Jt9H1/kCxCR/vT7RmTEYmIhTHe+LTAFigRTa6k0pn+0hQ6EsQLXrkD6rqYWHbxcyt4C8297w9jNcZvpZ46ZYDsDGXsXhCvhmHJCmiD/sBe4Cgup50Tjl0kCgZG+z3Tf9APK9ZkRMhcxviVqjIt7ZAYJT9qSJHgACGekHUjRuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572470052;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vEBMRdr4fTVNSrNUei/SaBKXvCTXBKe7QoHms4WJJww=; 
 b=W0uAPxNMh7dn/EHGKFPPRm8klgXtqrfyUbGWRouhZuJfJ5JDDh1KMwhtYd3M9R6jDHGZhWw0GugWQuRYhsMy1Dp7HjUcLc34yMnxNv6X+CFJ0pFYQP4RH3CxR6VNtH66ScbZewpMHlUP1DqNnOj1ht2iUYzAPrZ7CLv51iueHQo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572470051598610.7854659570803;
 Wed, 30 Oct 2019 14:14:11 -0700 (PDT)
In-Reply-To: <20191030180953.24180-1-richard.henderson@linaro.org>
Subject: Re: [PULL for-4.2 0/1] softfp patch queue
Message-ID: <157247005058.32191.18374118663755793102@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Wed, 30 Oct 2019 14:14:11 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAzMDE4MDk1My4yNDE4
MC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQVUxMIGZvci00LjIgMC8xXSBzb2Z0ZnAg
cGF0Y2ggcXVldWUKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkxMDMwMTgwOTUzLjI0MTgw
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNzU2Y2YzNCBzb2Z0
ZnA6IEFkZGVkIGhhcmRmbG9hdCBjb252ZXJzaW9uIGZyb20gZmxvYXQzMiB0byBmbG9hdDY0Cgo9
PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcq
JyAoY3R4Old4VikKIzMxOiBGSUxFOiBmcHUvc29mdGZsb2F0LmM6MTkyNDoKK3NvZnRfZmxvYXQz
Ml90b19mbG9hdDY0KGZsb2F0MzIgYSwgZmxvYXRfc3RhdHVzICpzKQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJl
ZCBhcm91bmQgdGhhdCAnKicgKGN0eDpXeFYpCiMzODogRklMRTogZnB1L3NvZnRmbG9hdC5jOjE5
MzE6CitmbG9hdDY0IGZsb2F0MzJfdG9fZmxvYXQ2NChmbG9hdDMyIGEsIGZsb2F0X3N0YXR1cyAq
cykKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4K
CnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgMzEgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDc1
NmNmMzRjMTNkMCAoc29mdGZwOiBBZGRlZCBoYXJkZmxvYXQgY29udmVyc2lvbiBmcm9tIGZsb2F0
MzIgdG8gZmxvYXQ2NCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMzAxODA5NTMuMjQxODAt
MS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==


