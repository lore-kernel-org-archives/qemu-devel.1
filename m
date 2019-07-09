Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8082DC73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A772087F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A772087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hktwr-0003CT-L7
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 13:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hktpJ-0005TJ-2p
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 13:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hktpH-0002Dq-2G
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 13:22:48 -0400
Resent-Date: Tue, 09 Jul 2019 13:22:48 -0400
Resent-Message-Id: <E1hktpH-0002Dq-2G@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hktp6-0001yC-48; Tue, 09 Jul 2019 13:22:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562692884; cv=none; d=zoho.com; s=zohoarc; 
 b=on9nZFddQx02pSm86QQBC4CHTXa/G4MlgEuLe3D/Jw1ai/4QJF/648i6WJEe0+AwTGPRO89xcC62wUpw/wCt1cXJgplzWgeL0OnQylS9i2X+5e7IIBrNPWitlXguOY/4a036On3jVcS4SMcIP/qqOexcgYNoPsYi1d1IrJ6GFZ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562692884;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=JSiVlmJEnG7VBVJWtPV6JYYiYa2HqhL6ZL6CYDRA6sE=; 
 b=h6Mh+9X6siLHWS292xskf/RR3sJWvDa+nXgVi3Lf5GIzkftBtFGOGZQ/337HZRKioc/T/e2zCFw+9Y/tgMPFKok6E9LtFtmRpiVtZY+6Q7m6mowTkJgXOgX3IL9ESG2lZfehtiXCSbTKgxHvx4tjAxa3iq3zMAsBrlaQDzPLdOs=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562692882213140.32137335983214;
 Tue, 9 Jul 2019 10:21:22 -0700 (PDT)
Message-ID: <156269288106.29610.6890288216464036573@c4a48874b076>
In-Reply-To: <20190709143912.28905-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Tue, 9 Jul 2019 10:21:22 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH for-4.1] pl031: Correctly migrate state
 when using -rtc clock=host
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
Cc: pbonzini@redhat.com, rmk@armlinux.org.uk, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwOTE0MzkxMi4yODkw
NS0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA3MDkxNDM5MTIuMjg5MDUtMS1wZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmcKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCBmb3ItNC4x
XSBwbDAzMTogQ29ycmVjdGx5IG1pZ3JhdGUgc3RhdGUgd2hlbiB1c2luZyAtcnRjIGNsb2NrPWhv
c3QKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdp
dCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwozYzc2NTc4IHBsMDMxOiBDb3JyZWN0bHkgbWln
cmF0ZSBzdGF0ZSB3aGVuIHVzaW5nIC1ydGMgY2xvY2s9aG9zdAoKPT09IE9VVFBVVCBCRUdJTiA9
PT0KRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpWeFYpCiMxNTY6
IEZJTEU6IGh3L3RpbWVyL3BsMDMxLmM6MzAwOgorICAgIC5zdWJzZWN0aW9ucyA9IChjb25zdCBW
TVN0YXRlRGVzY3JpcHRpb24qW10pIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNDYgbGluZXMgY2hl
Y2tlZAoKQ29tbWl0IDNjNzY1NzgzODRlMyAocGwwMzE6IENvcnJlY3RseSBtaWdyYXRlIHN0YXRl
IHdoZW4gdXNpbmcgLXJ0YyBjbG9jaz1ob3N0KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcw
OTE0MzkxMi4yODkwNS0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


