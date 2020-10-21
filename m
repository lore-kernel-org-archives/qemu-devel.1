Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D742FC56201
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33469222E9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33469222E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHpS-0007Lg-0X
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kVHlT-00042L-Fz
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:19:08 -0400
Resent-Date: Wed, 21 Oct 2020 13:19:07 -0400
Resent-Message-Id: <E1kVHlT-00042L-Fz@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kVHlQ-0003js-4g
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:19:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603300724; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=idN14pEnZxKtEBwYEy7GDUBFZbe7zICAZwErmXy8Nw+FS2sR7+NFYmHnI9TBk2DoGMbad9+WD0vwUQ0voR+Z8hydo+JOE6mod+gc33I7Y9b0WRmTVWEKPlij7McDHdvWqwQKxmrrZFSikKlmHZyPYQf1UJgI+xuxASN9gxpivtg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603300724;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=aHobGU9BHRiX/Q5ahNq+wg4HAAh8o4/kwsPr74k9ank=; 
 b=nvkGOKGK48jdscjvLSpkud3Dwr+GPNSegO+6A8H9D6O17eSwjCXmIBAViV2T1GMk8NFEFJEufQ8elMcr+Cat91t2JEOk0n6co/dOivs/hueaHdEI3fFBBDc6p/NEjG5k3/xi9BcJrFB6j5yFFIRL07LGRJ3/afA4YttOM8DytYA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603300722588586.3346353607009;
 Wed, 21 Oct 2020 10:18:42 -0700 (PDT)
Subject: Re: [PATCH  v1 0/4] add guest-loader (for direct Xen boot)
Message-ID: <160330072063.17333.1946978052817091932@66eaa9a8a123>
In-Reply-To: <20201021170842.25762-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Wed, 21 Oct 2020 10:18:42 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 13:18:56
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, qemu-devel@nongnu.org,
 takahiro.akashi@linaro.org, stefano.stabellini@xilinx.com,
 alex.bennee@linaro.org, stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAyMTE3MDg0Mi4yNTc2
Mi0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMTAyMTE3MDg0Mi4y
NTc2Mi0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcKU3ViamVjdDogW1BBVENIICB2MSAwLzRdIGFk
ZCBndWVzdC1sb2FkZXIgKGZvciBkaXJlY3QgWGVuIGJvb3QpCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQog
LSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAxMDIwMTUzOTM1LjU0MzE1LTEtdGh1dGhA
cmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAxMDIwMTUzOTM1LjU0MzE1LTEtdGh1dGhAcmVkaGF0
LmNvbQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAxMDIxMDQ1MTQ5LjE1ODIyMDMt
MS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAyMDEwMjEwNDUxNDku
MTU4MjIwMy0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKICogW25ldyB0YWddICAgICAg
ICAgcGF0Y2hldy8yMDIwMTAyMTE3MDg0Mi4yNTc2Mi0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcg
LT4gcGF0Y2hldy8yMDIwMTAyMTE3MDg0Mi4yNTc2Mi0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcK
U3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwphNTQxNWE5IGh3L2NvcmU6IGltcGxlbWVu
dCBhIGd1ZXN0LWxvYWRlciB0byBzdXBwb3J0IHN0YXRpYyBoeXBlcnZpc29yIGd1ZXN0cwo3YmIw
M2Y0IGRldmljZV90cmVlOiBhZGQgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmdfYXJyYXkgaGVscGVy
CjAxN2VlNjMgaHcvcmlzY3Y6IG1pZ3JhdGUgZmR0IGZpZWxkIHRvIGdlbmVyaWMgTWFjaGluZVN0
YXRlCjcyZTk0MTcgaHcvYm9hcmQ6IHByb21vdGUgZmR0IGZyb20gQVJNIFZpcnRNYWNoaW5lU3Rh
dGUgdG8gTWFjaGluZVN0YXRlCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzQgQ2hlY2tpbmcgY29t
bWl0IDcyZTk0MTczNWE2ZCAoaHcvYm9hcmQ6IHByb21vdGUgZmR0IGZyb20gQVJNIFZpcnRNYWNo
aW5lU3RhdGUgdG8gTWFjaGluZVN0YXRlKQoyLzQgQ2hlY2tpbmcgY29tbWl0IDAxN2VlNjNkZTI2
NyAoaHcvcmlzY3Y6IG1pZ3JhdGUgZmR0IGZpZWxkIHRvIGdlbmVyaWMgTWFjaGluZVN0YXRlKQoz
LzQgQ2hlY2tpbmcgY29tbWl0IDdiYjAzZjRkMWZhZiAoZGV2aWNlX3RyZWU6IGFkZCBxZW11X2Zk
dF9zZXRwcm9wX3N0cmluZ19hcnJheSBoZWxwZXIpCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFy
YWN0ZXJzCiM2MzogRklMRTogc29mdG1tdS9kZXZpY2VfdHJlZS5jOjQwNjoKK2ludCBxZW11X2Zk
dF9zZXRwcm9wX3N0cmluZ19hcnJheSh2b2lkICpmZHQsIGNvbnN0IGNoYXIgKm5vZGVfcGF0aCwg
Y29uc3QgY2hhciAqcHJvcCwKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNjEgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggMy80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjQvNCBDaGVja2lu
ZyBjb21taXQgYTU0MTVhOTZmNzdmIChody9jb3JlOiBpbXBsZW1lbnQgYSBndWVzdC1sb2FkZXIg
dG8gc3VwcG9ydCBzdGF0aWMgaHlwZXJ2aXNvciBndWVzdHMpCldBUk5JTkc6IGFkZGVkLCBtb3Zl
ZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzIx
OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJz
CiM2NzogRklMRTogaHcvY29yZS9ndWVzdC1sb2FkZXIuYzo0MjoKK3N0YXRpYyB2b2lkIGxvYWRl
cl9pbnNlcnRfcGxhdGZvcm1fZGF0YShHdWVzdExvYWRlclN0YXRlICpzLCBpbnQgc2l6ZSwgRXJy
b3IgKiplcnJwKQoKRVJST1I6IERvbid0IHVzZSAnIycgZmxhZyBvZiBwcmludGYgZm9ybWF0ICgn
JSMnKSBpbiBmb3JtYXQgc3RyaW5ncywgdXNlICcweCcgcHJlZml4IGluc3RlYWQKIzcxOiBGSUxF
OiBody9jb3JlL2d1ZXN0LWxvYWRlci5jOjQ2OgorICAgIGdfYXV0b2ZyZWUgY2hhciAqbm9kZSA9
IGdfc3RyZHVwX3ByaW50ZigiL2Nob3Nlbi9tb2R1bGVAJSMwOGx4Iiwgcy0+YWRkcik7CgpXQVJO
SU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojODU6IEZJTEU6IGh3L2NvcmUvZ3Vlc3QtbG9h
ZGVyLmM6NjA6CisgICAgICAgICAgICAoZmR0LCBub2RlLCAiY29tcGF0aWJsZSIsIChjaGFyICoq
KSAmY29tcGF0LCBBUlJBWV9TSVpFKGNvbXBhdCkpIDwgMCkgewoKRVJST1I6ICJmb28gKiBiYXIi
IHNob3VsZCBiZSAiZm9vICpiYXIiCiM5NTogRklMRTogaHcvY29yZS9ndWVzdC1sb2FkZXIuYzo3
MDoKKyAgICAgICAgY29uc3QgY2hhciAqIGNvbXBhdFsyXSA9IHsgIm11bHRpYm9vdCxtb2R1bGUi
LCAibXVsdGlib290LHJhbWRpc2siIH07CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVy
cwojOTc6IEZJTEU6IGh3L2NvcmUvZ3Vlc3QtbG9hZGVyLmM6NzI6CisgICAgICAgICAgICAoZmR0
LCBub2RlLCAiY29tcGF0aWJsZSIsIChjaGFyICoqKSAmY29tcGF0LCBBUlJBWV9TSVpFKGNvbXBh
dCkpIDwgMCkgewoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzExMjogRklMRTog
aHcvY29yZS9ndWVzdC1sb2FkZXIuYzo4NzoKKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiQ2Fu
bm90IHNwZWNpZnkgYSBrZXJuZWwgYW5kIGluaXRyZCBpbiB0aGUgc2FtZSBzdGFuemEiKTsKCnRv
dGFsOiAyIGVycm9ycywgNSB3YXJuaW5ncywgMTgyIGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNCBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDEwMjExNzA4NDIuMjU3NjItMS1hbGV4LmJlbm5lZUBs
aW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

