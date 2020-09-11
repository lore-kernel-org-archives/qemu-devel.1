Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054B6C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B87C22276
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B87C22276
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjUz-0004i1-E2
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 09:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kGjTS-0003KV-8H; Fri, 11 Sep 2020 09:52:22 -0400
Resent-Date: Fri, 11 Sep 2020 09:52:22 -0400
Resent-Message-Id: <E1kGjTS-0003KV-8H@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kGjTP-0005Ma-Pi; Fri, 11 Sep 2020 09:52:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1599832316; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RcK7tjKclORmAywO+Tus3wie/ZuC5uLanOcI0FNKwogkh010+li9QcZESRTBVfsXeth8ibDDSt1qxfoCuqeC8+OQa5cRtrlNzZRx3O/0a6UvvqIWWIqULOAsHRCrFjyCmq3WAnbCiDki6yvzF2e+s5G0cLYDcyM1GMUYSsxr9ss=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1599832316;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=6Su1RGHqB6Te+EtzZIdOxqW+747CL7Xz3gfOGusUy/c=; 
 b=BLC5EIDMUX0NGFemLmuP+3nvu8FL7gufNW6PxqH/Zud50q7Id7im9oDVj8JwaCb+J83e3COdf4ETRhi5dKLXvlbNZDTPW+PFLJHZwHUUgF2QBWRbakqUFEQgAsnz7178cmYKp/cexg8QuN39cAg/JPDmK2lBQmi9I31EK70UiX8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1599832315343294.6325585562721;
 Fri, 11 Sep 2020 06:51:55 -0700 (PDT)
Subject: Re: [PATCH] target/i386/kvm: Add missing fallthrough comment
Message-ID: <159983231403.4426.3570736825698577006@66eaa9a8a123>
In-Reply-To: <20200911125301.413081-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Fri, 11 Sep 2020 06:51:55 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 09:52:15
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
Cc: ehabkost@redhat.com, qemu-trivial@nongnu.org, mtosatti@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkxMTEyNTMwMS40MTMw
ODEtMS10aHV0aEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
ZXN0IG9uIEZyZWVCU0QgaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMgYmVsb3cuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBzY3JpcHQgd2lsbCBi
ZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQgcG9pbnRpbmcgdG8g
YSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJhc2UiCiMg
YnJhbmNoCmlmIHFlbXUtc3lzdGVtLXg4Nl82NCAtLWhlbHAgPi9kZXYvbnVsbCAyPiYxOyB0aGVu
CiAgUUVNVT1xZW11LXN5c3RlbS14ODZfNjQKZWxpZiAvdXNyL2xpYmV4ZWMvcWVtdS1rdm0gLS1o
ZWxwID4vZGV2L251bGwgMj4mMTsgdGhlbgogIFFFTVU9L3Vzci9saWJleGVjL3FlbXUta3ZtCmVs
c2UKICBleGl0IDEKZmkKbWFrZSB2bS1idWlsZC1mcmVlYnNkIEo9MjEgUUVNVT0kUUVNVQpleGl0
IDAKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA5MTExMjUzMDEuNDEzMDgxLTEtdGh1dGhA
cmVkaGF0LmNvbS90ZXN0aW5nLkZyZWVCU0QvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

