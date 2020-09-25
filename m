Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B499BC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8F9208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8F9208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLhHl-0004AQ-F1
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 02:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLhH1-0003gH-Ig
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 02:32:03 -0400
Resent-Date: Fri, 25 Sep 2020 02:32:03 -0400
Resent-Message-Id: <E1kLhH1-0003gH-Ig@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLhGy-0005eV-Sg
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 02:32:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601015513; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kVnC8BLmw9kCoEP5yDK/RH12MPnvmbUSaGhiMkD8mDcfIGPAdZNn39yGHkQNiOoycMT2WNDkCdhyVQzY9Is0K4HM+BpYNgdEq6qwlt2Hu84guWum3g5D0JvYfvYn80qiupae0hybG3CgUIpGlbSNPzwhbPt770waL7eM6Kx0u9g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601015513;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=H0AgpsZzh6DpZEye894mwkdAI+Jv0oQs5ios2dq6aRQ=; 
 b=f3s81+UaFyuN5kG2TSrPRo2C+q7LtE5IwJGcsi6hWawZ9Fpq2x/HFzLG4zLkysumWPf+I84mpG9h4tGpBgXKYYf+fJUNkPf1p378hSkbb8SIAYHJkO+pa9tdFcIHX2oEqPhUCaQ8qL9Xtb9eedudJQfKKugFMLTBuKmxKea+Tn8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601015512750511.81197669841856;
 Thu, 24 Sep 2020 23:31:52 -0700 (PDT)
Subject: Re: [PATCH] build: Build and install the info manual.
Message-ID: <160101551113.12744.9174876092220033182@66eaa9a8a123>
In-Reply-To: <20200925024143.26492-1-maxim.cournoyer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: maxim.cournoyer@gmail.com
Date: Thu, 24 Sep 2020 23:31:52 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:31:58
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
Cc: qemu-devel@nongnu.org, maxim.cournoyer@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNTAyNDE0My4yNjQ5
Mi0xLW1heGltLmNvdXJub3llckBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMg
dG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IK
bW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDkyNTAyNDE0
My4yNjQ5Mi0xLW1heGltLmNvdXJub3llckBnbWFpbC5jb20KU3ViamVjdDogW1BBVENIXSBidWls
ZDogQnVpbGQgYW5kIGluc3RhbGwgdGhlIGluZm8gbWFudWFsLgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhp
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0
YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
IC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDkyNDE5NTA1OC4zNjI5ODQtMS1kYW5p
ZWxoYjQxM0BnbWFpbC5jb20gLT4gcGF0Y2hldy8yMDIwMDkyNDE5NTA1OC4zNjI5ODQtMS1kYW5p
ZWxoYjQxM0BnbWFpbC5jb20KIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDkyNTAy
MTgwOC4yNjQ3MS0xLWNvbGluLnh1QGludGVsLmNvbSAtPiBwYXRjaGV3LzIwMjAwOTI1MDIxODA4
LjI2NDcxLTEtY29saW4ueHVAaW50ZWwuY29tCiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcv
MjAyMDA5MjUwMjQxNDMuMjY0OTItMS1tYXhpbS5jb3Vybm95ZXJAZ21haWwuY29tIC0+IHBhdGNo
ZXcvMjAyMDA5MjUwMjQxNDMuMjY0OTItMS1tYXhpbS5jb3Vybm95ZXJAZ21haWwuY29tClN3aXRj
aGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNzZhMjUyYyBidWlsZDogQnVpbGQgYW5kIGluc3Rh
bGwgdGhlIGluZm8gbWFudWFsLgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IE1pc3Npbmcg
U2lnbmVkLW9mZi1ieTogbGluZShzKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA2OSBs
aW5lcyBjaGVja2VkCgpDb21taXQgNzZhMjUyYzI2YjI5IChidWlsZDogQnVpbGQgYW5kIGluc3Rh
bGwgdGhlIGluZm8gbWFudWFsLikgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA5MjUwMjQxNDMu
MjY0OTItMS1tYXhpbS5jb3Vybm95ZXJAZ21haWwuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==

