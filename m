Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADBBC432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 12:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAE72075E
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 12:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAE72075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYrBT-0000mD-5L
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 07:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iYrAN-0000Bd-H6
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 07:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iYrAM-0006Iu-0s
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 07:39:03 -0500
Resent-Date: Sun, 24 Nov 2019 07:39:03 -0500
Resent-Message-Id: <E1iYrAM-0006Iu-0s@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iYrAL-0006Gr-PS
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 07:39:01 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574599134; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ghqmHUIs6hWdvYPV5S/ZNAiZNOcpkGz4N4PBBsyzGa/SdevOKZMO3FqZUAcASo/9D7tvFWgGTh9yiqeQGfakZPthpvMetO6zE5u73u7S63TK2K50Cb9FdkXbiqijjGhaOmjA991jC6UXsZoqlvwWvvLDT1V4EQmnqf37gBnZEyw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574599134;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=aQIxVP8kUAjVplZx57BKNR5ykySWkVyaq7IPqnESZgs=; 
 b=Z/W/+BGArO2Ys5Znwy7va1S0UItKBAZzjmU/nbjL7St2uCWp0NwNyw+5XmtAayVcczg1QYVA3qQGfiX5IeIQAOrFYOFjnanYrdc/oWgZDC++IUNwrb4cRtR+Aqa2KY8X2CD5NxSXLSBQti6PVVLp7yyMkKnuGA1aWaiXyJ8aSTk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574599132554231.2276230428795;
 Sun, 24 Nov 2019 04:38:52 -0800 (PST)
In-Reply-To: <20191124115656.GA23850@ls3530.fritz.box>
Subject: Re: [PATCH v2] linux-user/strace: Improve strace output for read()
 and getcwd()
Message-ID: <157459913141.7001.1861884858484439323@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: deller@gmx.de
Date: Sun, 24 Nov 2019 04:38:52 -0800 (PST)
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
Cc: qemu-devel@nongnu.org, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyNDExNTY1Ni5HQTIz
ODUwQGxzMzUzMC5mcml0ei5ib3gvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2Ml0gbGludXgtdXNlci9zdHJhY2U6IEltcHJvdmUg
c3RyYWNlIG91dHB1dCBmb3IgcmVhZCgpIGFuZCBnZXRjd2QoKQpUeXBlOiBzZXJpZXMKTWVzc2Fn
ZS1pZDogMjAxOTExMjQxMTU2NTYuR0EyMzg1MEBsczM1MzAuZnJpdHouYm94Cgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVs
bCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxn
b3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2Uu
Lgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRk
MWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjVkNmI2
OWUgbGludXgtdXNlci9zdHJhY2U6IEltcHJvdmUgc3RyYWNlIG91dHB1dCBmb3IgcmVhZCgpIGFu
ZCBnZXRjd2QoKQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KV0FSTklORzogbGluZSBvdmVyIDgwIGNo
YXJhY3RlcnMKIzUxOiBGSUxFOiBsaW51eC11c2VyL3N0cmFjZS5jOjY0OgorVU5VU0VEIHN0YXRp
YyB2b2lkIHByaW50X2VuY29kZWRfc3RyaW5nKGFiaV9sb25nIGFkZHIsIHVuc2lnbmVkIGludCBt
YXhsZW4sIGludCBsYXN0KTsKCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUg
YmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojNTE6IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNl
LmM6NjQ6CitVTlVTRUQgc3RhdGljIHZvaWQgcHJpbnRfZW5jb2RlZF9zdHJpbmcoYWJpX2xvbmcg
YWRkciwgdW5zaWduZWQgaW50IG1heGxlbiwgaW50IGxhc3QpOwoKdG90YWw6IDEgZXJyb3JzLCAx
IHdhcm5pbmdzLCAxOTcgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDVkNmI2OWUwZTA3YiAobGludXgt
dXNlci9zdHJhY2U6IEltcHJvdmUgc3RyYWNlIG91dHB1dCBmb3IgcmVhZCgpIGFuZCBnZXRjd2Qo
KSkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTExMjQxMTU2NTYuR0EyMzg1MEBsczM1MzAuZnJp
dHouYm94L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


