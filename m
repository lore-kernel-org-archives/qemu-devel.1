Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE018C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EB921726
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EB921726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3P3z-0001ZL-OI
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 14:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i3P1O-0007kL-6b
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i3P1L-0000Iw-HQ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:19:45 -0400
Resent-Date: Thu, 29 Aug 2019 14:19:45 -0400
Resent-Message-Id: <E1i3P1L-0000Iw-HQ@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i3P1L-0000H7-9a
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:19:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1567102770; cv=none; d=zoho.com; s=zohoarc; 
 b=bZM0zxtYbGyqWz9w9u0V2v/JxaUpByV6CMMn2MNSGpbvD6oimmDiJCWUVp6+DlmtWbDHjxZYkAe/P7E5RXnHs9R67EM4FP1vsElR0eQsGOpJavjs1kUkTjKCXEC38Ym2qH6geqbk39VTW8vj7TFo0cqHS9+qWPNLwLx/phR2x58=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1567102770;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=wU0SXgd5dFvqSUkZvSkKdHXVGfiXOa4gJVOR5m3rfCI=; 
 b=U9nQTDoGReqRXJ+Vk1pLBZBYk8sqL2AAr767ggOw13jUI/sHXzBRgzodk9SwtfvrTNLbbbt3qwNHI6BKznc6c+Lx3C0EoZAO0BHlT/UY8SpljxS4LdRp/OFFYzWlxik/K+liBFAtydk1YgseyHI8fPm2A6A7w6PKIn2Gyp+JDRc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1567102768344873.2175394580285;
 Thu, 29 Aug 2019 11:19:28 -0700 (PDT)
In-Reply-To: <20190829160710.8792-1-berrange@redhat.com>
Message-ID: <156710276704.32188.4207123858994214872@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Thu, 29 Aug 2019 11:19:28 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v2 0/4] docs: add docs about use of
 automatic cleanup functions
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
Cc: stefanha@gmail.com, berrange@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, marcandre.lureau@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgyOTE2MDcxMC44Nzky
LTEtYmVycmFuZ2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjIg
MC80XSBkb2NzOiBhZGQgZG9jcyBhYm91dCB1c2Ugb2YgYXV0b21hdGljIGNsZWFudXAgZnVuY3Rp
b25zCk1lc3NhZ2UtaWQ6IDIwMTkwODI5MTYwNzEwLjg3OTItMS1iZXJyYW5nZUByZWRoYXQuY29t
Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFz
ZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGlt
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1h
aWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTlj
MjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2gg
J3Rlc3QnCjg4MDAwMTkgZG9jczogc3BsaXQgdGhlIENPRElOR19TVFlMRSBkb2MgaW50byBkaXN0
aW5jdCBncm91cHMKNWE3OGNlNSBkb2NzOiBkb2N1bWVudCB1c2Ugb2YgYXV0b21hdGljIGNsZWFu
dXAgZnVuY3Rpb25zIGluIGdsaWIKYzk0YWM4NiBkb2NzOiBtZXJnZSBIQUNLSU5HLnJzdCBjb250
ZW50cyBpbnRvIENPRElOR19TVFlMRS5yc3QKZTZhZWNhMSBkb2NzOiBjb252ZXJ0IFJFQURNRSwg
Q09ESU5HX1NUWUxFIGFuZCBIQUNLSU5HIHRvIFJTVCBzeW50YXgKCj09PSBPVVRQVVQgQkVHSU4g
PT09Ck11c3QgYmUgcnVuIGZyb20gdGhlIHRvcC1sZXZlbCBkaXIuIG9mIGEga2VybmVsIHRyZWUK
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMgoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA4
MjkxNjA3MTAuODc5Mi0xLWJlcnJhbmdlQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t


