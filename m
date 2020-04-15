Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6610AC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 09:03:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3BF206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 09:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3BF206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdwj-0001uH-Cr
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 05:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jOdvr-0001Or-SM
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jOdvp-0005OG-P8
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 05:02:07 -0400
Resent-Date: Wed, 15 Apr 2020 05:02:07 -0400
Resent-Message-Id: <E1jOdvp-0005OG-P8@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jOdvp-0005NQ-Hm; Wed, 15 Apr 2020 05:02:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586941318; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cw5gpo7nNX1Mg52Amuxxj7j+xSv+/yc05Fhr45us/wQACIgoBEJX0vFo0BMlCsm3Ms9zOAO177LSeWdWDueRQc7hVYg8D2ORJLNYWuL2uWM2zvp1Jc5upBiFTDNkW79PYFZ/JOTAXt3BlvWDN3OpCUurMWYSH50h6b63e+hHhAw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586941318;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=trvOEByBsTtXlKdpEscPCK54k2GE4OVcfSF9HvzF+Dc=; 
 b=jg/cPbPYNm4Il3F4Vt/T+QWYnLTPH5cXdVb4CPqrVejYMo/ruftaEx+EdDcrXO4bW3GMu7Vtj3LAbOFxi90vongcXTwFVu3Ui+NZqHt4e0zqWz26qKzbMkvQAl1cIJCsF2udYoHvlF1gUSKD5L5vbxPtLUC+9+ZzKUbKPYisFIg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586941316079273.1897624643367;
 Wed, 15 Apr 2020 02:01:56 -0700 (PDT)
In-Reply-To: <20200415074927.19897-1-armbru@redhat.com>
Subject: Re: [PATCH v2 for-5.1 0/9] qemu-option: Fix corner cases and clean up
Message-ID: <158694131488.27250.3474237517193157270@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Wed, 15 Apr 2020 02:01:56 -0700 (PDT)
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxNTA3NDkyNy4xOTg5
Ny0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjIgZm9yLTUuMSAwLzldIHFlbXUtb3B0aW9uOiBG
aXggY29ybmVyIGNhc2VzIGFuZCBjbGVhbiB1cApNZXNzYWdlLWlkOiAyMDIwMDQxNTA3NDkyNy4x
OTg5Ny0xLWFybWJydUByZWRoYXQuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhp
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0
YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
ICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDQxNTA4MzA0OC4xNDMzOS0xLWFybWJy
dUByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDA0MTUwODMwNDguMTQzMzktMS1hcm1icnVAcmVk
aGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjNiMzNiZTUgcWVtdS1pbWc6
IFJlamVjdCBicm9rZW4gLW8gIiIKN2I1ZGFkZCBxZW11LWltZzogTW92ZSBpc192YWxpZF9vcHRp
b25fbGlzdCgpIHRvIHFlbXUtaW1nLmMgYW5kIHJld3JpdGUKMzBiYmUzNCBxZW11LWltZzogRmFj
dG9yIG91dCBhY2N1bXVsYXRlX29wdGlvbnMoKSBoZWxwZXIKYzI5OTBlOSBxZW11LW9wdGlvbjog
QXZvaWQgaGFzX2hlbHBfb3B0aW9uKCkgaW4gcWVtdV9vcHRzX3BhcnNlX25vaXNpbHkoKQoyZjZk
MGU0IHRlc3QtcWVtdS1vcHRzOiBTaW1wbGlmeSB0ZXN0X2hhc19oZWxwX29wdGlvbigpIGFmdGVy
IGJ1ZyBmaXgKNjI2OGQzNCBxZW11LW9wdGlvbjogRml4IGhhc19oZWxwX29wdGlvbigpJ3Mgc2xv
cHB5IHBhcnNpbmcKOTY5OGJjYyBxZW11LW9wdGlvbjogRml4IHNsb3BweSByZWNvZ25pdGlvbiBv
ZiAiaWQ9Li4uIiBhZnRlciAiLCAsICIKOTUzN2QyMyBxZW11LW9wdGlvbnM6IEZhY3RvciBvdXQg
Z2V0X29wdF9uYW1lX3ZhbHVlKCkgaGVscGVyCjBmNjgzOWMgdGVzdHMtcWVtdS1vcHRzOiBDb3Zl
ciBoYXNfaGVscF9vcHRpb24oKSwgcWVtdV9vcHRfaGFzX2hlbHBfb3B0KCkKCj09PSBPVVRQVVQg
QkVHSU4gPT09CjEvOSBDaGVja2luZyBjb21taXQgMGY2ODM5Y2RmNzU0ICh0ZXN0cy1xZW11LW9w
dHM6IENvdmVyIGhhc19oZWxwX29wdGlvbigpLCBxZW11X29wdF9oYXNfaGVscF9vcHQoKSkKV0FS
TklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUK
IzQyOiBGSUxFOiB0ZXN0cy90ZXN0LXFlbXUtb3B0cy5jOjc1MjoKKyAgICAgICAgeyAiYSxiLCxo
ZWxwIiwgZmFsc2UgLyogQlVHICovLCB0cnVlLCB0cnVlIH0sCgpXQVJOSU5HOiBCbG9jayBjb21t
ZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojNDM6IEZJTEU6IHRlc3Rz
L3Rlc3QtcWVtdS1vcHRzLmM6NzUzOgorICAgICAgICB7ICJhLGIsLD8iLCBmYWxzZSAvKiBCVUcg
Ki8sIHRydWUsIHRydWUgfSwKCnRvdGFsOiAwIGVycm9ycywgMiB3YXJuaW5ncywgNTYgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggMS85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjIvOSBDaGVja2lu
ZyBjb21taXQgOTUzN2QyMzA5NmE3IChxZW11LW9wdGlvbnM6IEZhY3RvciBvdXQgZ2V0X29wdF9u
YW1lX3ZhbHVlKCkgaGVscGVyKQozLzkgQ2hlY2tpbmcgY29tbWl0IDk2OThiY2MxYzFmZSAocWVt
dS1vcHRpb246IEZpeCBzbG9wcHkgcmVjb2duaXRpb24gb2YgImlkPS4uLiIgYWZ0ZXIgIiwgLCAi
KQo0LzkgQ2hlY2tpbmcgY29tbWl0IDYyNjhkMzQ1NTQxMCAocWVtdS1vcHRpb246IEZpeCBoYXNf
aGVscF9vcHRpb24oKSdzIHNsb3BweSBwYXJzaW5nKQo1LzkgQ2hlY2tpbmcgY29tbWl0IDJmNmQw
ZTQ4NjdiNiAodGVzdC1xZW11LW9wdHM6IFNpbXBsaWZ5IHRlc3RfaGFzX2hlbHBfb3B0aW9uKCkg
YWZ0ZXIgYnVnIGZpeCkKNi85IENoZWNraW5nIGNvbW1pdCBjMjk5MGU5M2ViNTYgKHFlbXUtb3B0
aW9uOiBBdm9pZCBoYXNfaGVscF9vcHRpb24oKSBpbiBxZW11X29wdHNfcGFyc2Vfbm9pc2lseSgp
KQo3LzkgQ2hlY2tpbmcgY29tbWl0IDMwYmJlMzRjOGI2ZiAocWVtdS1pbWc6IEZhY3RvciBvdXQg
YWNjdW11bGF0ZV9vcHRpb25zKCkgaGVscGVyKQo4LzkgQ2hlY2tpbmcgY29tbWl0IDdiNWRhZGRh
ZWMxNyAocWVtdS1pbWc6IE1vdmUgaXNfdmFsaWRfb3B0aW9uX2xpc3QoKSB0byBxZW11LWltZy5j
IGFuZCByZXdyaXRlKQpFUlJPUjogc3VzcGVjdCBjb2RlIGluZGVudCBmb3IgY29uZGl0aW9uYWwg
c3RhdGVtZW50cyAoNCwgNCkKIzYyOiBGSUxFOiBxZW11LWltZy5jOjI0MzoKKyAgICBmb3IgKGkg
PSBsZW47IGkgPiAwICYmIG9wdGFyZ1tpIC0gMV0gPT0gJywnOyBpLS0pIHsKKyAgICB9Cgp0b3Rh
bDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDY3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvOSBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoKOS85IENoZWNraW5nIGNvbW1pdCAzYjMzYmU1NjAyM2Yg
KHFlbXUtaW1nOiBSZWplY3QgYnJva2VuIC1vICIiKQpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFj
ZQojNDk6IEZJTEU6IHFlbXUtaW1nLmM6MjM0OgorICogJAoKdG90YWw6IDEgZXJyb3JzLCAwIHdh
cm5pbmdzLCAxOCBsaW5lcyBjaGVja2VkCgpQYXRjaCA5LzkgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMjAwNDE1MDc0OTI3LjE5ODk3LTEtYXJtYnJ1QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3Bh
dGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

