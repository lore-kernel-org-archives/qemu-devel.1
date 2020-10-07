Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACFFC4727E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E1120872
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E1120872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQFV4-0004m2-8C
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQFTl-0003ly-H4; Wed, 07 Oct 2020 15:52:01 -0400
Resent-Date: Wed, 07 Oct 2020 15:52:01 -0400
Resent-Message-Id: <E1kQFTl-0003ly-H4@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQFTi-0002mB-Q7; Wed, 07 Oct 2020 15:52:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602100304; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QAo3LofllLQTI9KKgYoGMFHTJP9Z1rG+/inzaKPXSVPn52UUfT92nPbh5QWSPrWfLhSEuTum+UwuIFlXnkj57SCmrEkFe1FmE9YJJXkPWxiDArB8FBngrP37WKvn5a9CdUzvjkOWR90DhNbHxlgi1NY0eeDrgtxmlZAeSSxm7GI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602100304;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=uOFKHfboKe2Sq0a8DxPnJLFG6h6aem4avFMcGrmriAQ=; 
 b=KPphti01OsVbReQEl73NCzqus2C0TUZxEzDplDc8M5HP/Qm8FaIZ0OJdfNJXQIxELyQkZPqTgrmtY1CY5CMalgzF3CoDbMA/dym6wmB9KEEKfeGiSPZ9wEkVmcQgiM2XBCiKrIyY7jdK6rZFIbxTNjHAH5zPJaoquPum1ycxpTg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602100301901347.32368104405873;
 Wed, 7 Oct 2020 12:51:41 -0700 (PDT)
Subject: Re: [PATCH v8] scripts: Convert qemu-version.sh to qemu-version.py
Message-ID: <160210030021.3664.1462361095891786135@66eaa9a8a123>
In-Reply-To: <20201007194526.1778-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: luoyonggang@gmail.com
Date: Wed, 7 Oct 2020 12:51:41 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 15:33:55
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, luoyonggang@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAwNzE5NDUyNi4xNzc4
LTEtbHVveW9uZ2dhbmdAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDEwMDcxOTQ1MjYuMTc3
OC0xLWx1b3lvbmdnYW5nQGdtYWlsLmNvbQpTdWJqZWN0OiBbUEFUQ0ggdjhdIHNjcmlwdHM6IENv
bnZlcnQgcWVtdS12ZXJzaW9uLnNoIHRvIHFlbXUtdmVyc2lvbi5weQoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwg
ZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRo
bSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3Fl
bXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMTAwNzE5NDUyNi4xNzc4LTEtbHVv
eW9uZ2dhbmdAZ21haWwuY29tIC0+IHBhdGNoZXcvMjAyMDEwMDcxOTQ1MjYuMTc3OC0xLWx1b3lv
bmdnYW5nQGdtYWlsLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmY0MmI5OGQg
c2NyaXB0czogQ29udmVydCBxZW11LXZlcnNpb24uc2ggdG8gcWVtdS12ZXJzaW9uLnB5Cgo9PT0g
T1VUUFVUIEJFR0lOID09PQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMp
LCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMzNDogCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzU5OiBGSUxFOiBzY3JpcHRzL3Fl
bXUtdmVyc2lvbi5weToyMToKKyAgICAgICAgbWF0Y2hfZXhwcmVzc2lvbiA9ICctLW1hdGNoPXZc
XConIGlmIHBsYXRmb3JtLnN5c3RlbSgpID09ICdXaW5kb3dzJyBlbHNlICctLW1hdGNoPXYqJwoK
RVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM2MTogRklMRTogc2NyaXB0cy9xZW11LXZl
cnNpb24ucHk6MjM6CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Rkb3V0PXN1YnByb2Nl
c3MuUElQRSwgc3RkZXJyPXN1YnByb2Nlc3MuREVWTlVMTCwgZW5jb2Rpbmc9J3V0ZjgnLCBzaGVs
bD1GYWxzZSkKCnRvdGFsOiAyIGVycm9ycywgMSB3YXJuaW5ncywgNDMgbGluZXMgY2hlY2tlZAoK
Q29tbWl0IGY0MmI5OGRmN2NhMCAoc2NyaXB0czogQ29udmVydCBxZW11LXZlcnNpb24uc2ggdG8g
cWVtdS12ZXJzaW9uLnB5KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMTAwNzE5NDUyNi4xNzc4
LTEtbHVveW9uZ2dhbmdAZ21haWwuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

