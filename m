Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97781C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8C723787
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8C723787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLM4f-0005XQ-QB
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLM3x-000588-7D
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:53:09 -0400
Resent-Date: Thu, 24 Sep 2020 03:53:09 -0400
Resent-Message-Id: <E1kLM3x-000588-7D@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLM3u-0002lR-NC
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:53:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600933960; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fU9Y74mQIL8fIRhROEJgsDIxEqR/I7xksglj6qq4TR6TP0oqEnKYZuXP0sQFB8nHyn+YnaZRa8KDN/SYtJeRtsG7RIXs3yq4PyWUkKchfft9faAF59IVuxUZwiVAXdusbtzfD4QnT92xgEx2Tf0cXZdq3xkjLmu99mBSkG8hpG4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600933960;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=igdRy2wAPnjrb81Sgx2A4/eFE5aQoaULzTc6R7QDEMI=; 
 b=WPgcNpAdIy1DAnBstYE/1KJnJD0Q9thz5XRT7+ekEO3C8A/oqc80lBlDs6IfUoxFnBDonYzV/tU9W2qkVK63bO19SEbxTRIGA6QKQX3qKPylZJfRkICKfxXnUUuLKs5sXRZ3sXl4f4W/KyLlfgWFrRkrRjGKz1wL0g1Gh5MiqG0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600933958956227.32781953999233;
 Thu, 24 Sep 2020 00:52:38 -0700 (PDT)
Subject: Re: [PATCH V11 0/8] mips: Add Loongson-3 machine support
Message-ID: <160093395734.759.7835793690531285472@66eaa9a8a123>
In-Reply-To: <1600932956-11642-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: zltjiangshi@gmail.com
Date: Thu, 24 Sep 2020 00:52:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 03:53:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: aleksandar.rikalo@syrmia.com, chenhuacai@gmail.com, f4bug@amsat.org,
 qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com, chenhc@lemote.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAwOTMyOTU2LTExNjQyLTEt
Z2l0LXNlbmQtZW1haWwtY2hlbmhjQGxlbW90ZS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAxNjAwOTMyOTU2
LTExNjQyLTEtZ2l0LXNlbmQtZW1haWwtY2hlbmhjQGxlbW90ZS5jb20KU3ViamVjdDogW1BBVENI
IFYxMSAwLzhdIG1pcHM6IEFkZCBMb29uZ3Nvbi0zIG1hY2hpbmUgc3VwcG9ydAoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNo
ZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMTYwMDkzMjk1Ni0x
MTY0Mi0xLWdpdC1zZW5kLWVtYWlsLWNoZW5oY0BsZW1vdGUuY29tIC0+IHBhdGNoZXcvMTYwMDkz
Mjk1Ni0xMTY0Mi0xLWdpdC1zZW5kLWVtYWlsLWNoZW5oY0BsZW1vdGUuY29tClN3aXRjaGVkIHRv
IGEgbmV3IGJyYW5jaCAndGVzdCcKY2Y4OTcxNCBkb2NzL3N5c3RlbTogVXBkYXRlIE1JUFMgbWFj
aGluZSBkb2N1bWVudGF0aW9uCmNhYmY1MWEgaHcvbWlwczogQWRkIExvb25nc29uLTMgbWFjaGlu
ZSBzdXBwb3J0CmZkNjc3NTcgaHcvbWlwczogSW1wbGVtZW50IGZ3X2NmZ19hcmNoX2tleV9uYW1l
KCkKZGNhMThjMiB0YXJnZXQvbWlwczogQWRkIGxvb25nc29uLWV4dCBsc2RjMiBncm91cCBvZiBp
bnN0cnVjdGlvbnMKZDZkOWEzNCB0YXJnZXQvbWlwczogQWRkIGxvb25nc29uLWV4dCBsc3djMiBn
cm91cCBvZiBpbnN0cnVjdGlvbnMgKFBhcnQgMikKNzgzMjE5MSB0YXJnZXQvbWlwczogQWRkIGxv
b25nc29uLWV4dCBsc3djMiBncm91cCBvZiBpbnN0cnVjdGlvbnMgKFBhcnQgMSkKNDBhNTM2YSB0
YXJnZXQvbWlwczogRml4IFBhZ2VNYXNrIHdpdGggdmFyaWFibGUgcGFnZSBzaXplCjVmZTg1ZmEg
bGludXgtaGVhZGVyczogVXBkYXRlIE1JUFMgS1ZNIHR5cGUgZGVmaW50aXRpb24KCj09PSBPVVRQ
VVQgQkVHSU4gPT09CjEvOCBDaGVja2luZyBjb21taXQgNWZlODVmYTAyZTk2IChsaW51eC1oZWFk
ZXJzOiBVcGRhdGUgTUlQUyBLVk0gdHlwZSBkZWZpbnRpdGlvbikKMi84IENoZWNraW5nIGNvbW1p
dCA0MGE1MzZhZmRhYWYgKHRhcmdldC9taXBzOiBGaXggUGFnZU1hc2sgd2l0aCB2YXJpYWJsZSBw
YWdlIHNpemUpCjMvOCBDaGVja2luZyBjb21taXQgNzgzMjE5MWM0ZDM3ICh0YXJnZXQvbWlwczog
QWRkIGxvb25nc29uLWV4dCBsc3djMiBncm91cCBvZiBpbnN0cnVjdGlvbnMgKFBhcnQgMSkpCjQv
OCBDaGVja2luZyBjb21taXQgZDZkOWEzNDRiMDBhICh0YXJnZXQvbWlwczogQWRkIGxvb25nc29u
LWV4dCBsc3djMiBncm91cCBvZiBpbnN0cnVjdGlvbnMgKFBhcnQgMikpCjUvOCBDaGVja2luZyBj
b21taXQgZGNhMThjMmU5Y2JlICh0YXJnZXQvbWlwczogQWRkIGxvb25nc29uLWV4dCBsc2RjMiBn
cm91cCBvZiBpbnN0cnVjdGlvbnMpCjYvOCBDaGVja2luZyBjb21taXQgZmQ2Nzc1N2Q3MDE2ICho
dy9taXBzOiBJbXBsZW1lbnQgZndfY2ZnX2FyY2hfa2V5X25hbWUoKSkKV0FSTklORzogYWRkZWQs
IG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5n
PwojMTY6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdz
LCA2MCBsaW5lcyBjaGVja2VkCgpQYXRjaCA2LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
Ny84IENoZWNraW5nIGNvbW1pdCBjYWJmNTFhZTEyMjQgKGh3L21pcHM6IEFkZCBMb29uZ3Nvbi0z
IG1hY2hpbmUgc3VwcG9ydCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShz
KSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojODA6IApuZXcgZmlsZSBtb2RlIDEw
MDY0NAoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzIyNjogRklMRTogaHcvbWlw
cy9sb29uZ3NvbjNfdmlydC5jOjE0MjoKK3N0YXRpYyB2b2lkIGxvb25nc29uM19wbV93cml0ZSh2
b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1aW50NjRfdCB2YWwsIHVuc2lnbmVkIHNpemUpCgpF
UlJPUjogcmV0dXJuIGlzIG5vdCBhIGZ1bmN0aW9uLCBwYXJlbnRoZXNlcyBhcmUgbm90IHJlcXVp
cmVkCiMyODg6IEZJTEU6IGh3L21pcHMvbG9vbmdzb24zX3ZpcnQuYzoyMDQ6CisgICAgICAgIHJl
dHVybiAoZnJlcSAqIDIpOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzM5NDog
RklMRTogaHcvbWlwcy9sb29uZ3NvbjNfdmlydC5jOjMxMDoKKyAgICBscC0+Ym9hcmRkZXZfdGFi
bGVfb2Zmc2V0ID0gKHVpbnRwdHJfdClib2FyZF9kZXZpY2VzX2luZm8ocCkgLSAodWludHB0cl90
KWxwOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzUxMDogRklMRTogaHcvbWlw
cy9sb29uZ3NvbjNfdmlydC5jOjQyNjoKKyAgICBmd19jZmdfYWRkX2kxNihmd19jZmcsIEZXX0NG
R19NQVhfQ1BVUywgKHVpbnQxNl90KWN1cnJlbnRfbWFjaGluZS0+c21wLm1heF9jcHVzKTsKCldB
Uk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM1NTg6IEZJTEU6IGh3L21pcHMvbG9vbmdz
b24zX3ZpcnQuYzo0NzQ6CisgICAgc3ByaW50ZihoaWdobWVtZW52LCAiJWxkIiwgKHVuc2lnbmVk
IGxvbmcpKGxvYWRlcnBhcmFtcy5yYW1fc2l6ZSAvIE1pQikgLSAyNTYpOwoKV0FSTklORzogbGlu
ZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzY0NDogRklMRTogaHcvbWlwcy9sb29uZ3NvbjNfdmlydC5j
OjU2MDoKK3N0YXRpYyBpbmxpbmUgdm9pZCBsb29uZ3NvbjNfdmlydF9kZXZpY2VzX2luaXQoTWFj
aGluZVN0YXRlICptYWNoaW5lLCBEZXZpY2VTdGF0ZSAqcGljKQoKV0FSTklORzogbGluZSBvdmVy
IDgwIGNoYXJhY3RlcnMKIzY3NTogRklMRTogaHcvbWlwcy9sb29uZ3NvbjNfdmlydC5jOjU5MToK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2V0X3N5c3RlbV9pbygpLCAwLCB2aXJ0X21l
bW1hcFtWSVJUX1BDSUVfUElPXS5zaXplKTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0
ZXJzCiM3ODE6IEZJTEU6IGh3L21pcHMvbG9vbmdzb24zX3ZpcnQuYzo2OTc6CisgICAgLyogQWxs
b2NhdGUgUkFNL0JJT1MsIDB4MDAwMDAwMDB+MHgxMDAwMDAwMCBpcyBhbGlhcyBvZiAweDgwMDAw
MDAwfjB4OTAwMDAwMDAgKi8KCnRvdGFsOiAxIGVycm9ycywgOCB3YXJuaW5ncywgOTk0IGxpbmVz
IGNoZWNrZWQKClBhdGNoIDcvOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKOC84IENoZWNr
aW5nIGNvbW1pdCBjZjg5NzE0NGJmOTYgKGRvY3Mvc3lzdGVtOiBVcGRhdGUgTUlQUyBtYWNoaW5l
IGRvY3VtZW50YXRpb24pCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzE2MDA5MzI5NTYtMTE2NDItMS1naXQtc2VuZC1lbWFpbC1jaGVuaGNAbGVtb3Rl
LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

