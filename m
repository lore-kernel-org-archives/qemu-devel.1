Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9DBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 06:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1951C206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 06:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1951C206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAodE-0007z2-DS
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 02:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kAoch-0007Rb-Og; Wed, 26 Aug 2020 02:09:27 -0400
Resent-Date: Wed, 26 Aug 2020 02:09:27 -0400
Resent-Message-Id: <E1kAoch-0007Rb-Og@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kAocd-0007Rl-Gi; Wed, 26 Aug 2020 02:09:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1598422033; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AMAuYM0bY7BoLxOqNyUD5U5W4Md/FZcJUmjTusjzoPctQmSZxO6MCNCHHnLozxjTD6afk5C8yGq/NQ+qQa8szHMao5F9cydSRrSAb8jpYbTqON9NXDRw8AMYE4MxnMRiBJkaiVgZZmyDvSfdsZmN1O17LW/5sRkhKwnUoV3BfNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1598422033;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Mkw0Espv1W9A1fvTXS0GtYgfMxDCNqMD663iR6Xrajs=; 
 b=L72/H55bSpdNGtgSX+B4JbSaw5kDpNusyVf8Y2jBockJ2UnKyOC30+HEGhSYOwPcjDXNt8Dr/853QtYB4ClhoCxp29uFXEq0M64UF80I09cz0gQuh6gW75GgTQhWFP08VlnKR2iTMRbBGoJWzL8kZUu5OTetBH4ayX7hRTqVaFE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1598422030634388.40134953587085;
 Tue, 25 Aug 2020 23:07:10 -0700 (PDT)
Subject: Re: [PATCH] disas/libvixl: Fix fall-through annotation for GCC >= 7
Message-ID: <159842202999.420.7038258941573202105@66eaa9a8a123>
In-Reply-To: <20200824130114.41368-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Tue, 25 Aug 2020 23:07:10 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 02:09:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgyNDEzMDExNC40MTM2
OC0xLXRodXRoQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDgyNDEzMDExNC40MTM2OC0x
LXRodXRoQHJlZGhhdC5jb20KU3ViamVjdDogW1BBVENIXSBkaXNhcy9saWJ2aXhsOiBGaXggZmFs
bC10aHJvdWdoIGFubm90YXRpb24gZm9yIEdDQyA+PSA3Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3Fl
bXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDgyNDEzMDExNC40MTM2OC0xLXRo
dXRoQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDgyNDEzMDExNC40MTM2OC0xLXRodXRoQHJl
ZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwplYjhlZDYzIGRpc2FzL2xp
YnZpeGw6IEZpeCBmYWxsLXRocm91Z2ggYW5ub3RhdGlvbiBmb3IgR0NDID49IDcKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojNDY6IEZJTEU6
IGRpc2FzL2xpYnZpeGwvdml4bC9nbG9iYWxzLmg6MTExOgorLy8gRmFsbHRocm91Z2ggYW5ub3Rh
dGlvbiBmb3IgQ2xhbmcgYW5kIEMrKzExKDIwMTEwM0wpLgoKRVJST1I6IGRvIG5vdCB1c2UgQzk5
IC8vIGNvbW1lbnRzCiM0OTogRklMRTogZGlzYXMvbGlidml4bC92aXhsL2dsb2JhbHMuaDoxMTQ6
CisvLyBGYWxsdGhyb3VnaCBhbm5vdGF0aW9uIGZvciBHQ0MgPj0gNy4KCnRvdGFsOiAyIGVycm9y
cywgMCB3YXJuaW5ncywgMjQgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGViOGVkNjNjMGNjMyAoZGlz
YXMvbGlidml4bDogRml4IGZhbGwtdGhyb3VnaCBhbm5vdGF0aW9uIGZvciBHQ0MgPj0gNykgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQg
ZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA4MjQxMzAxMTQuNDEzNjgtMS10aHV0aEByZWRoYXQuY29t
L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

