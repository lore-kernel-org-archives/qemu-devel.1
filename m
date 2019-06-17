Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38C8C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78432085A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78432085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcxGq-0004fl-Vq
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45508)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hcwz9-0003Xp-NI
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hcwz8-0007Au-8g
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:08:07 -0400
Resent-Date: Mon, 17 Jun 2019 15:08:07 -0400
Resent-Message-Id: <E1hcwz8-0007Au-8g@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hcwz6-00077Y-7v
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:08:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560798471; cv=none; d=zoho.com; s=zohoarc; 
 b=Mmkt6u8rjL+B9EdPLQMafIO5EvKAvf5pkEjTNLIxqANyXleMedjwLGwfNT63mFTe9aS3RKfKWbdtL5tdxVusabQcuGTww1tooInLQ5JLVqjpsVsO0F1s4GwIB7xxE3hcEPbRpaqOmmJC4FflAZVQZTpQsvndFxGWgeCF2jzpQNA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560798471;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=PkTnQlGa8NpI0sqgYmvsixi3EV61HCjD31a4O0plhMk=; 
 b=G/QZVEN8rZN8omeQazNNnRTnJ6TypKQ6YYjZ5hGF0V0cXNX1/stL4M0rOrIgJxolXWOfGOT4zztdCFPdx3z1SaBmvGMEFo5APn5C572ZkYQMd7Ago/iKrx/ZJGqflDJwqvLLq87clSkrsPxDAJGtBM6XiSbXg0Q0ROuOsYPN8HU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560798470971506.700161314076;
 Mon, 17 Jun 2019 12:07:50 -0700 (PDT)
In-Reply-To: <20190617143533.15013-1-kbastian@mail.uni-paderborn.de>
Message-ID: <156079847002.13573.4992501560769954306@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kbastian@mail.uni-paderborn.de
Date: Mon, 17 Jun 2019 12:07:50 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/3] tricore: Convert to translate_loop
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
Cc: kbastian@mail.uni-paderborn.de, david.brenken@efs-auto.de,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxNzE0MzUzMy4xNTAx
My0xLWtiYXN0aWFuQG1haWwudW5pLXBhZGVyYm9ybi5kZS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA2MTcxNDM1MzMuMTUwMTMt
MS1rYmFzdGlhbkBtYWlsLnVuaS1wYWRlcmJvcm4uZGUKVHlwZTogc2VyaWVzClN1YmplY3Q6IFtR
ZW11LWRldmVsXSBbUEFUQ0ggMC8zXSB0cmljb3JlOiBDb252ZXJ0IHRvIHRyYW5zbGF0ZV9sb29w
Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFz
ZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGlt
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1h
aWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1
Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8y
MDE5MDYxNzE0MzUzMy4xNTAxMy0xLWtiYXN0aWFuQG1haWwudW5pLXBhZGVyYm9ybi5kZSAtPiBw
YXRjaGV3LzIwMTkwNjE3MTQzNTMzLjE1MDEzLTEta2Jhc3RpYW5AbWFpbC51bmktcGFkZXJib3Ju
LmRlClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMzc5NWNlZiB0YXJnZXQvdHJpY29y
ZTogVXNlIHRyYW5zbGF0ZV9sb29wCmQ1MGRjZTkgdGFyZ2V0LXRyaWNvcmU6IE1ha2UgZW52IGEg
bWVtYmVyIG9mIERpc2FzQ29udGV4dAo2ZDMwZmQxIHRhcmdldC90cmljb3JlOiBVc2UgRGlzYXND
b250ZXh0QmFzZSBBUEkKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMyBDaGVja2luZyBjb21taXQg
NmQzMGZkMTRkNmM4ICh0YXJnZXQvdHJpY29yZTogVXNlIERpc2FzQ29udGV4dEJhc2UgQVBJKQoy
LzMgQ2hlY2tpbmcgY29tbWl0IGQ1MGRjZTkyOGMyNiAodGFyZ2V0LXRyaWNvcmU6IE1ha2UgZW52
IGEgbWVtYmVyIG9mIERpc2FzQ29udGV4dCkKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQg
dGhhdCAnKycgKGN0eDpWeFYpCiM2NjA6IEZJTEU6IHRhcmdldC90cmljb3JlL3RyYW5zbGF0ZS5j
OjY1ODY6CisgICAgICAgIGdlbl9kdmluaXRfYihjdHgsIGNwdV9ncHJfZFtyM10sIGNwdV9ncHJf
ZFtyMysxXSwgY3B1X2dwcl9kW3IxXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhh
dCAnKycgKGN0eDpWeFYpCiM2Nzg6IEZJTEU6IHRhcmdldC90cmljb3JlL3RyYW5zbGF0ZS5jOjY2
MTk6CisgICAgICAgIGdlbl9kdmluaXRfaChjdHgsIGNwdV9ncHJfZFtyM10sIGNwdV9ncHJfZFty
MysxXSwgY3B1X2dwcl9kW3IxXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMTU0IGxp
bmVzIGNoZWNrZWQKClBhdGNoIDIvMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy8zIENo
ZWNraW5nIGNvbW1pdCAzNzk1Y2VmYjllZDAgKHRhcmdldC90cmljb3JlOiBVc2UgdHJhbnNsYXRl
X2xvb3ApCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMTkwNjE3MTQzNTMzLjE1MDEzLTEta2Jhc3RpYW5AbWFpbC51bmktcGFkZXJib3JuLmRlL3Rl
c3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


