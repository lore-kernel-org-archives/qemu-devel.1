Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0646CC17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3FB21783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 06:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3FB21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUQ1T-0004Rf-Iq
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 01:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iUPwP-0007Ss-Tm
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iUPwO-00038I-C4
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:46:17 -0500
Resent-Date: Tue, 12 Nov 2019 01:46:17 -0500
Resent-Message-Id: <E1iUPwO-00038I-C4@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iUPwM-00032P-Hf
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 01:46:15 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573541167; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Zqfhw4EQ6yq/ruU3iRoYLO9f72OH+c3b8hrVhaEotOnNHB1Uf1fuGtzS15mCBQ2BjbKIHvSdyCUUjFinu1Gg1FDBB/eL3+swclGI73jkPZk9qR4+sbvhBcDL7/dEKpy5qPgrTYJbpYAUgp/I7vy+BJjLxj41bivDhF5SI0nBc/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573541167;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7uPYc+DQ8UngTAhkcv1JHQzjv0RbyFXOkqLFzelfyNA=; 
 b=JLMcRj/NrleN0VzKz0I9BjNn++ukmdW+GC9L8762zYhsR4JfiWvJidTKc1aZZYItYQNrgYEOz4xNDTMXQENIfrTPn0xv7M8fXH9FpG0zZL7bdwc7FBf5tWQRHoUcaZem/vhWaXFz7u2sXVJ+ABLrferqEOGYbtT7eW4JBqmPCpQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157354116495997.61063772422119;
 Mon, 11 Nov 2019 22:46:04 -0800 (PST)
In-Reply-To: <20191111135803.14414-1-peter.maydell@linaro.org>
Subject: Re: [PULL 0/3] target-arm queue
Message-ID: <157354116405.9707.7884495097199774252@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Mon, 11 Nov 2019 22:46:04 -0800 (PST)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTExMTEzNTgwMy4xNDQx
NC0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BVTEwgMC8zXSB0YXJnZXQtYXJtIHF1ZXVlClR5
cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTExMTEzNTgwMy4xNDQxNC0xLXBldGVyLm1heWRl
bGxAbGluYXJvLm9yZwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQg
cmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRj
aGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKCj09PSBPVVRQVVQgQkVHSU4gPT09CmNoZWNrcGF0
Y2gucGw6IG5vIHJldmlzaW9ucyByZXR1cm5lZCBmb3IgcmV2bGlzdCAnMScKPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMjU1CgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTExMTEzNTgwMy4x
NDQxNC0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=

