Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62929C3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 22:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3182084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 22:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3182084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3SID-0002mX-DM
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 17:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j3SHZ-0002DI-Ok
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 17:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j3SHX-0006sF-Tn
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 17:20:57 -0500
Resent-Date: Sun, 16 Feb 2020 17:20:57 -0500
Resent-Message-Id: <E1j3SHX-0006sF-Tn@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j3SHX-0006ou-M8; Sun, 16 Feb 2020 17:20:55 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581891648; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Cgii2xOYd0lJIP00L1ijLp8GKowUG8dmUM1XZZuWVOjaJ7jg6d5sBLSB/QK+mKitNDW5zPyz/dolvufh6gzOQb3nFWDBumVmSSM0f7nj9yvjn5xe8IolnY16ikmbl0VfLdQmycCxgzamqMEvi81v0HrtFvoDde7uYAgc+wjU1MU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581891648;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=h45rM+Q+EHCgOZqedzhRYrOel5Gd8HkFC8A0GWQudq0=; 
 b=a2qIIcMZwAq5GsUDmE6QflGFIHvxDtkd1i32+TMyiXpLrOrr9SlMTUyBkNYopDXOwrH4/VJi7hbaIhb9d+KSbrNypPT4lzl55mcZBjnOtNqOGqd8aSozG9F9B5P6ZS/YQGBPZYZ8h/CAlCIfHPofgFpJsSa/ZcGLfvl5zkDsI3I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581891644481257.05944383701956;
 Sun, 16 Feb 2020 14:20:44 -0800 (PST)
In-Reply-To: <20200216214232.4230-1-richard.henderson@linaro.org>
Subject: Re: [PATCH v2 0/4] target/arm vector improvements
Message-ID: <158189164315.22563.16471888088547791729@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Sun, 16 Feb 2020 14:20:44 -0800 (PST)
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxNjIxNDIzMi40MjMw
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYyIDAvNF0gdGFyZ2V0L2FybSB2
ZWN0b3IgaW1wcm92ZW1lbnRzCk1lc3NhZ2UtaWQ6IDIwMjAwMjE2MjE0MjMyLjQyMzAtMS1yaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhp
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVj
dC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDAyMTYyMTQyMzIuNDIzMC0x
LXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDIwMDIxNjIxNDIzMi40
MjMwLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBicmFu
Y2ggJ3Rlc3QnCjIyMzY1NTIgdGFyZ2V0L2FybTogQ29udmVydCBQTVVMTC44IHRvIGd2ZWMKODg5
MjUyNCB0YXJnZXQvYXJtOiBDb252ZXJ0IFBNVUxMLjY0IHRvIGd2ZWMKYTQzOGQ0MCB0YXJnZXQv
YXJtOiBDb252ZXJ0IFBNVUwuOCB0byBndmVjCjM5MTY0ZGUgdGFyZ2V0L2FybTogVmVjdG9yaXpl
IFVTSEwgYW5kIFNTSEwKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNCBDaGVja2luZyBjb21taXQg
MzkxNjRkZTk0NGQ1ICh0YXJnZXQvYXJtOiBWZWN0b3JpemUgVVNITCBhbmQgU1NITCkKRVJST1I6
IHRyYWlsaW5nIHN0YXRlbWVudHMgc2hvdWxkIGJlIG9uIG5leHQgbGluZQojMTYxOiBGSUxFOiB0
YXJnZXQvYXJtL3RyYW5zbGF0ZS5jOjM1Nzg6CisgICAgICAgICAgICBjYXNlIDI6IGdlbl91c2hs
X2kzMih2YXIsIHZhciwgc2hpZnQpOyBicmVhazsKCkVSUk9SOiB0cmFpbGluZyBzdGF0ZW1lbnRz
IHNob3VsZCBiZSBvbiBuZXh0IGxpbmUKIzE2ODogRklMRTogdGFyZ2V0L2FybS90cmFuc2xhdGUu
YzozNTg0OgorICAgICAgICAgICAgY2FzZSAyOiBnZW5fc3NobF9pMzIodmFyLCB2YXIsIHNoaWZ0
KTsgYnJlYWs7Cgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDU2OSBsaW5lcyBjaGVja2Vk
CgpQYXRjaCAxLzQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjIvNCBDaGVja2luZyBjb21t
aXQgYTQzOGQ0MDEyYjcwICh0YXJnZXQvYXJtOiBDb252ZXJ0IFBNVUwuOCB0byBndmVjKQozLzQg
Q2hlY2tpbmcgY29tbWl0IDg4OTI1MjQxMDI1NCAodGFyZ2V0L2FybTogQ29udmVydCBQTVVMTC42
NCB0byBndmVjKQo0LzQgQ2hlY2tpbmcgY29tbWl0IDIyMzY1NTJhNGI0NCAodGFyZ2V0L2FybTog
Q29udmVydCBQTVVMTC44IHRvIGd2ZWMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5k
IGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMjE2MjE0MjMyLjQyMzAtMS1yaWNoYXJkLmhlbmRlcnNv
bkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

