Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E0C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C648E20678
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C648E20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMahI-00006E-Qg
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jMagl-0007ph-9Q
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jMagj-000406-M0
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:10:02 -0400
Resent-Date: Thu, 09 Apr 2020 13:10:02 -0400
Resent-Message-Id: <E1jMagj-000406-M0@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jMagj-0003x8-Gk; Thu, 09 Apr 2020 13:10:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586452191; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ho5/si19jCChXve+6xal5oSSgjKqWUMu8nvk/yfq84N1jNGLb8ea9aZ9zHB6ioPuidZe8Ps6Yxx9HmPgBHfjPA0aDoBvISoih3XxrNK5Da1t0Ujj9OPMMQJ58LQjgsrkT9ZY0ys4k6sGidJb5nlsW7eUSVkXRV5mGjq4T1nxJJs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586452191;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Rc30tqVbV7xXE6q5gXa8yeUKsXp6Forqg/Q6uDUbxoU=; 
 b=EHikUpld+NhnqJIjYXk2f6axCBY4+ERvL9zSOzcaW7XuOhiQ17nUu2I/wlnH8I7dBXakDpLg4XskpB9nKzcEZ6RTYrrxLTGHpZginLn8KnSiFnaACYI/s6JQYAwMF3Kzs/Hmarw8YoJdSlWsbo5Or8a7Vsghg5xjowf9SXZ/aYI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586452189230942.7614654889163;
 Thu, 9 Apr 2020 10:09:49 -0700 (PDT)
In-Reply-To: <20200409153041.17576-1-armbru@redhat.com>
Subject: Re: [PATCH for-5.1 0/8] qemu-option: Fix corner cases and clean up
Message-ID: <158645218790.18042.4891276831001916938@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Thu, 9 Apr 2020 10:09:49 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwOTE1MzA0MS4xNzU3
Ni0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggZm9yLTUuMSAwLzhdIHFlbXUtb3B0aW9uOiBGaXgg
Y29ybmVyIGNhc2VzIGFuZCBjbGVhbiB1cApNZXNzYWdlLWlkOiAyMDIwMDQwOTE1MzA0MS4xNzU3
Ni0xLWFybWJydUByZWRoYXQuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICog
W25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDQwOTE2NDk1NC4zNjkwMi0xLXBldGVyeEBy
ZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDA0MDkxNjQ5NTQuMzY5MDItMS1wZXRlcnhAcmVkaGF0
LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjUwNWY1ZjMgcWVtdS1vcHRpb246
IE1vdmUgaXNfdmFsaWRfb3B0aW9uX2xpc3QoKSB0byBxZW11LWltZy5jIGFuZCByZXdyaXRlCmIx
NjQ5MzAgcWVtdS1pbWc6IEZhY3RvciBvdXQgYWNjdW11bGF0ZV9vcHRpb25zKCkgaGVscGVyCmI3
ZmNhYWUgdGVzdC1xZW11LW9wdHM6IFNpbXBsaWZ5IHRlc3RfaGFzX2hlbHBfb3B0aW9uKCkgYWZ0
ZXIgYnVnIGZpeAo2ODQ1YzI5IHFlbXUtb3B0aW9uOiBGaXggaGFzX2hlbHBfb3B0aW9uKCkncyBz
bG9wcHkgcGFyc2luZwo1YzFiMmRiIHFlbXUtb3B0aW9uOiBBdm9pZCBoYXNfaGVscF9vcHRpb24o
KSBpbiBxZW11X29wdHNfcGFyc2Vfbm9pc2lseSgpCmIzNjMwYTMgcWVtdS1vcHRpb246IEZpeCBz
bG9wcHkgcmVjb2duaXRpb24gb2YgImlkPS4uLiIgYWZ0ZXIgIiwgLCAiCjhiYjgwNWQgcWVtdS1v
cHRpb25zOiBGYWN0b3Igb3V0IGdldF9vcHRfbmFtZV92YWx1ZSgpIGhlbHBlcgoyZTAwMzEwIHRl
c3RzLXFlbXUtb3B0czogQ292ZXIgaGFzX2hlbHBfb3B0aW9uKCksIHFlbXVfb3B0X2hhc19oZWxw
X29wdCgpCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzggQ2hlY2tpbmcgY29tbWl0IDJlMDAzMTA5
MjczYiAodGVzdHMtcWVtdS1vcHRzOiBDb3ZlciBoYXNfaGVscF9vcHRpb24oKSwgcWVtdV9vcHRf
aGFzX2hlbHBfb3B0KCkpCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyog
b24gYSBzZXBhcmF0ZSBsaW5lCiMzNzogRklMRTogdGVzdHMvdGVzdC1xZW11LW9wdHMuYzo3NDc6
CisgICAgICAgIHsgImEsYiwsaGVscCIsIGZhbHNlIC8qIEJVRyAqLywgdHJ1ZSwgdHJ1ZSB9LAoK
dG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1MCBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzgg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMi84IENoZWNraW5nIGNvbW1pdCA4YmI4MDVkZDM3
MzAgKHFlbXUtb3B0aW9uczogRmFjdG9yIG91dCBnZXRfb3B0X25hbWVfdmFsdWUoKSBoZWxwZXIp
CjMvOCBDaGVja2luZyBjb21taXQgYjM2MzBhMzQ2OTA2IChxZW11LW9wdGlvbjogRml4IHNsb3Bw
eSByZWNvZ25pdGlvbiBvZiAiaWQ9Li4uIiBhZnRlciAiLCAsICIpCjQvOCBDaGVja2luZyBjb21t
aXQgNWMxYjJkYjBiN2FkIChxZW11LW9wdGlvbjogQXZvaWQgaGFzX2hlbHBfb3B0aW9uKCkgaW4g
cWVtdV9vcHRzX3BhcnNlX25vaXNpbHkoKSkKNS84IENoZWNraW5nIGNvbW1pdCA2ODQ1YzI5YmVl
MTEgKHFlbXUtb3B0aW9uOiBGaXggaGFzX2hlbHBfb3B0aW9uKCkncyBzbG9wcHkgcGFyc2luZykK
Ni84IENoZWNraW5nIGNvbW1pdCBiN2ZjYWFlZWViNmYgKHRlc3QtcWVtdS1vcHRzOiBTaW1wbGlm
eSB0ZXN0X2hhc19oZWxwX29wdGlvbigpIGFmdGVyIGJ1ZyBmaXgpCjcvOCBDaGVja2luZyBjb21t
aXQgYjE2NDkzMGQ0YzhkIChxZW11LWltZzogRmFjdG9yIG91dCBhY2N1bXVsYXRlX29wdGlvbnMo
KSBoZWxwZXIpCjgvOCBDaGVja2luZyBjb21taXQgNTA1ZjVmMzg5ODU1IChxZW11LW9wdGlvbjog
TW92ZSBpc192YWxpZF9vcHRpb25fbGlzdCgpIHRvIHFlbXUtaW1nLmMgYW5kIHJld3JpdGUpCkVS
Uk9SOiBzdXNwZWN0IGNvZGUgaW5kZW50IGZvciBjb25kaXRpb25hbCBzdGF0ZW1lbnRzICg0LCA0
KQojNjE6IEZJTEU6IHFlbXUtaW1nLmM6MjQzOgorICAgIGZvciAoaSA9IGxlbjsgaSA+IDAgJiYg
b3B0YXJnW2kgLSAxXSA9PSAnLCc7IGktLSkgeworICAgIH0KCnRvdGFsOiAxIGVycm9ycywgMCB3
YXJuaW5ncywgNjcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC84IGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2Rl
OiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDIwMDQwOTE1MzA0MS4xNzU3Ni0xLWFybWJydUByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2tw
YXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

