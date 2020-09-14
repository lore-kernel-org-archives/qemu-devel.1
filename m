Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F10C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A97A208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A97A208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmTg-0001AF-Lz
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kHmSt-0000UZ-0k
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:16:08 -0400
Resent-Date: Mon, 14 Sep 2020 07:16:07 -0400
Resent-Message-Id: <E1kHmSt-0000UZ-0k@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kHmSo-0007Dm-OW
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:16:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600082152; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EVRcRUQ7ZoVPJOOZzkZ6kHWKLSgtXizBcBDcRJ89B6KubIR7TUavPPDYn3K97mmzXUJ/wA/3u10MjCxY9/tMEXYR2kK3w/BtgCIae+SsZln9yf2E9vcRyul6ylo20jvS49MV/hxVnmnvQgfwPk4pYZVdycLm925N4Imak5/jYq0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600082152;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=wc2MTdHaAEwsf55GBQOJ5nVVa7S8buxZbQgV9uOyFC0=; 
 b=hoFgQodIL32wJOeosClI0ypUdf7T4WERMpTr8CMLcFYHLJLuyFttqw4qoix4VBDXEihQ8pmrjcEzxYfuGTPqIGW7877bAEfZSdutBU0tUng1o+Y/R0t1Ru2NHS/NRqQ/hOqJ/Vx6ptOd5VRNTjHpss/bM/OWMz0qDWjaxqisFPw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600082150618585.9845701818848;
 Mon, 14 Sep 2020 04:15:50 -0700 (PDT)
Subject: Re: [PATCH] scripts: display how long each test takes to execute
Message-ID: <160008214942.3982.8922679778463355102@66eaa9a8a123>
In-Reply-To: <20200914110948.1425082-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Mon, 14 Sep 2020 04:15:50 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 07:15:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: pbonzini@redhat.com, thuth@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkxNDExMDk0OC4xNDI1
MDgyLTEtYmVycmFuZ2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwOTE0MTEwOTQ4LjE0
MjUwODItMS1iZXJyYW5nZUByZWRoYXQuY29tClN1YmplY3Q6IFtQQVRDSF0gc2NyaXB0czogZGlz
cGxheSBob3cgbG9uZyBlYWNoIHRlc3QgdGFrZXMgdG8gZXhlY3V0ZQoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwg
ZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRo
bSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJv
amVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA5MTQxMTA5NDguMTQy
NTA4Mi0xLWJlcnJhbmdlQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDkxNDExMDk0OC4xNDI1
MDgyLTEtYmVycmFuZ2VAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CjAxMDA5ZTYgc2NyaXB0czogZGlzcGxheSBob3cgbG9uZyBlYWNoIHRlc3QgdGFrZXMgdG8gZXhl
Y3V0ZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJz
CiM0OTogRklMRTogc2NyaXB0cy9tdGVzdDJtYWtlLnB5OjIzOgorLnRlc3QtaHVtYW4tdGFwID0g
ZXhwb3J0IHRoZW49YGRhdGUgKyVzYCA7ICQxICQoaWYgJDQsKGNkICQ0ICYmICQyKSwkMikgPCAv
ZGV2L251bGwgfCAuL3NjcmlwdHMvdGFwLWRyaXZlci5wbCAtLXRlc3QtbmFtZT0iJDMiICQoaWYg
JChWKSwsLS1zaG93LWZhaWx1cmVzLW9ubHkpIDsgZXhwb3J0IG5vdz1gZGF0ZSArJXNgIDsgZGVs
dGE9YGV4cHIgJCRub3cgLSAkJHRoZW5gIDsgJChpZiAkKFYpLGVjaG8gIlRJTUUgJCRkZWx0YSBz
ZWNvbmRzIix0cnVlKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA4IGxpbmVzIGNoZWNr
ZWQKCkNvbW1pdCAwMTAwOWU2ZTIzZTAgKHNjcmlwdHM6IGRpc3BsYXkgaG93IGxvbmcgZWFjaCB0
ZXN0IHRha2VzIHRvIGV4ZWN1dGUpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTE0MTEwOTQ4
LjE0MjUwODItMS1iZXJyYW5nZUByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==

