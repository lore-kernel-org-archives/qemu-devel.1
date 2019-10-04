Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817C0C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571122133F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571122133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMo0-0003Sc-Fs
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iGMmc-0002DO-Fs
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iGMma-0007fR-Ox
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 08:34:06 -0400
Resent-Date: Fri, 04 Oct 2019 08:34:06 -0400
Resent-Message-Id: <E1iGMma-0007fR-Ox@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iGMma-0007ep-HI; Fri, 04 Oct 2019 08:34:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570192429; cv=none; d=zoho.com; s=zohoarc; 
 b=c9/7zvWpoDEv5S/XtWllt1EZzObjeP/mQs3hr64T6bmDQn8U89yWqyDC7M/ecxfDpem4MFdXC5O5YWLMDrUYqax1R9xSU4AvTG66bSW17HG7r2wUtChDXJiQdrfrxWTYPVSQ0bQKy0mPGfsAXM7F2E4xjV7tA9GCXza6uLJCwEg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570192429;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=hEVN6udGnfCzMkihJamvvJMBpBUVt8mv9YyqAX6lIKU=; 
 b=i+LY3PbCm2hDyL/p4yBfPg1c4vNQZODB5z3h5RqT578dSM4eB4ogg2ghZHXUU0cvURJEHtcLMZzSuWbl3m5YpdJiDaQIfF0QGl1QUwl57l5skLUTfjCFQKSxlG9Ck0Dnl66m+FHgW/rZbNQkQj71IZtEQt2ZgEiWuEvyuJv/Vvw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570192427193158.62611076049393;
 Fri, 4 Oct 2019 05:33:47 -0700 (PDT)
Subject: Re: [PATCH] target/arm/arch_dump: Add SVE notes
In-Reply-To: <20191004094609.32714-1-drjones@redhat.com>
Message-ID: <157019242552.28767.8910946686226374673@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: drjones@redhat.com
Date: Fri, 4 Oct 2019 05:33:47 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, eric.auger@redhat.com, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwNDA5NDYwOS4zMjcx
NC0xLWRyam9uZXNAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkxMDA0MDk0NjA5LjMyNzE0
LTEtZHJqb25lc0ByZWRoYXQuY29tClN1YmplY3Q6IFtQQVRDSF0gdGFyZ2V0L2FybS9hcmNoX2R1
bXA6IEFkZCBTVkUgbm90ZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gK
Z2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1
ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9j
aGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpV
cGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0
cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAg
IHBhdGNoZXcvMjAxOTEwMDQxMjAzMTMuNTM0Ny0xLWRyam9uZXNAcmVkaGF0LmNvbSAtPiBwYXRj
aGV3LzIwMTkxMDA0MTIwMzEzLjUzNDctMS1kcmpvbmVzQHJlZGhhdC5jb20KU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0JwpkMDQxNDk3IHRhcmdldC9hcm0vYXJjaF9kdW1wOiBBZGQgU1ZF
IG5vdGVzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5l
dmVyIHVzZSB0YWJzCiMyMTogRklMRTogaW5jbHVkZS9lbGYuaDoxNjUzOgorI2RlZmluZSBOVF9B
Uk1fU1ZFXkkweDQwNV5JXkkvKiBBUk0gU2NhbGFibGUgVmVjdG9yIEV4dGVuc2lvbiQKCldBUk5J
Tkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiMy
MTogRklMRTogaW5jbHVkZS9lbGYuaDoxNjUzOgorI2RlZmluZSBOVF9BUk1fU1ZFICAgICAweDQw
NSAgICAgICAgICAgLyogQVJNIFNjYWxhYmxlIFZlY3RvciBFeHRlbnNpb24KCkVSUk9SOiBjb2Rl
IGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzIyOiBGSUxFOiBpbmNsdWRlL2VsZi5oOjE2
NTQ6CiteSV5JXkleSV5JICAgcmVnaXN0ZXJzICovJAoKV0FSTklORzogQmxvY2sgY29tbWVudHMg
dXNlICogb24gc3Vic2VxdWVudCBsaW5lcwojMjI6IEZJTEU6IGluY2x1ZGUvZWxmLmg6MTY1NDoK
KyNkZWZpbmUgTlRfQVJNX1NWRSAgICAgMHg0MDUgICAgICAgICAgIC8qIEFSTSBTY2FsYWJsZSBW
ZWN0b3IgRXh0ZW5zaW9uCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZWdpc3RlcnMgKi8KCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIHRyYWlsaW5nICov
IG9uIGEgc2VwYXJhdGUgbGluZQojMjI6IEZJTEU6IGluY2x1ZGUvZWxmLmg6MTY1NDoKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ2lzdGVycyAqLwoKdG90YWw6
IDIgZXJyb3JzLCAzIHdhcm5pbmdzLCAxODEgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGQwNDE0OTc0
ZGFiNiAodGFyZ2V0L2FybS9hcmNoX2R1bXA6IEFkZCBTVkUgbm90ZXMpIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMTkxMDA0MDk0NjA5LjMyNzE0LTEtZHJqb25lc0ByZWRoYXQuY29tL3Rlc3Rpbmcu
Y2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


