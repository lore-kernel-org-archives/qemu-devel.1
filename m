Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB3FC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0790120863
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0790120863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdOBC-00064S-VN
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 20:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdOAJ-0005eD-46
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdOAH-0003SJ-Tz
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:09:27 -0400
Resent-Date: Tue, 18 Jun 2019 20:09:27 -0400
Resent-Message-Id: <E1hdOAH-0003SJ-Tz@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdOAH-0003QS-M5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:09:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560902957; cv=none; d=zoho.com; s=zohoarc; 
 b=A1ufSEpHVx05sq06NZtEv6EGuZjgTp1RUEabd8Pid4HbHw4Gl9R3OfpAApwTQiKIer0OhmB96M7ioV5i9Q/Ujj14jlVbUVU9x57CLJd+hco29/vSU1cHxQ4ukt3fg3790Dh/Y1Pf3jK+Qa+QZL5L9rQzqxmOLcVipJenwHxebJM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560902957;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=COrlX7C8VALM3nX6ljW3r/qhbNnCWf16u5t40Fvlhrc=; 
 b=Z+4HKD/bsYewmUsXATp9AUJf/Lsm3dGNaGh+XK0AERiRbjBQk+VTJYGSpzjheBArRGJfNVStRkd1NYHXsFgzle802e3InrhrYQZ6U/o6Hlc62fAJBo2GAmc8/DSUM4CbLYjK0SS3sxDc1A/3o+5RoHci6+i8wV9l7By5l7PDPl4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560902956697198.7830642566397;
 Tue, 18 Jun 2019 17:09:16 -0700 (PDT)
In-Reply-To: <20190618235313.13223-1-jimw@sifive.com>
Message-ID: <156090295559.22612.10119919154946823431@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jimw@sifive.com
Date: Tue, 18 Jun 2019 17:09:16 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add strace support for statx.
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org, jimw@sifive.com,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxODIzNTMxMy4xMzIy
My0xLWppbXdAc2lmaXZlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gbGludXgtdXNlcjogQWRkIHN0
cmFjZSBzdXBwb3J0IGZvciBzdGF0eC4KVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwNjE4
MjM1MzEzLjEzMjIzLTEtamltd0BzaWZpdmUuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
ICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDYxODIzNTMxMy4xMzIyMy0x
LWppbXdAc2lmaXZlLmNvbSAtPiBwYXRjaGV3LzIwMTkwNjE4MjM1MzEzLjEzMjIzLTEtamltd0Bz
aWZpdmUuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZGRlNDQ2Zjk1ZiBsaW51
eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHN0YXR4LgoKPT09IE9VVFBVVCBCRUdJTiA9
PT0KRVJST1I6IHN0b3JhZ2UgY2xhc3Mgc2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhl
IGRlY2xhcmF0aW9uCiMyNTogRklMRTogbGludXgtdXNlci9zdHJhY2UuYzo5Nzk6CitVTlVTRUQg
c3RhdGljIHN0cnVjdCBmbGFncyBzdGF0eF9mbGFnc1tdID0gewoKRVJST1I6IHN0b3JhZ2UgY2xh
c3Mgc2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiM0NzogRklM
RTogbGludXgtdXNlci9zdHJhY2UuYzoxMDAxOgorVU5VU0VEIHN0YXRpYyBzdHJ1Y3QgZmxhZ3Mg
c3RhdHhfbWFza1tdID0gewoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMDQgbGluZXMg
Y2hlY2tlZAoKQ29tbWl0IGRkZTQ0NmY5NWZiMiAobGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBw
b3J0IGZvciBzdGF0eC4pIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5E
ID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNjE4MjM1MzEzLjEzMjIz
LTEtamltd0BzaWZpdmUuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==


