Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF51C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A53922210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A53922210
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5zd-0001QW-AT
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kT5v1-00076s-EZ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:15:55 -0400
Resent-Date: Thu, 15 Oct 2020 12:15:55 -0400
Resent-Message-Id: <E1kT5v1-00076s-EZ@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kT5uw-000586-QV
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:15:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602778542; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Rvy3Nup0MKOxrpxI0rE+xejgvcAx/nqio9TeKtEAvJpTh94iPi/4VY/ZXsNVhULzhr9um4h4nUSNIt61nfvuuDB5pA8POfjQ47gQUcrBFq/c8MbFGQjlfsLLxqziDquQjEiBJxH9/mzSt56IuXz/hRM0aQtIxRn0dTfI3xH4xfY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602778542;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=bG5PG3+uJY23doB842HFQH/3ve09RGM7VGwyY8p228k=; 
 b=aAAIEf74KOQyoKPP7yMcTB6ZwpGqyVKUw1oJq5UlzUGVA1SOXZ+zwJLUPSNTtL9Kpx7ByivffC92dX7zoRxMRFgtL1MF1RuoQwOOaRYVh5TOZDmmwyBh9hKFWPuUSskZVxmnkIXyydOhRZCqM5b+0OASc5l9NxoQ/EYXqgbm1ZY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602778540877417.1418112221162;
 Thu, 15 Oct 2020 09:15:40 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] qemu-ga: add ssh-{add,remove}-authorized-keys
Message-ID: <160277853958.26906.7670279254947017966@66eaa9a8a123>
In-Reply-To: <20201015160819.1471144-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Thu, 15 Oct 2020 09:15:40 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 12:15:48
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
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAxNTE2MDgxOS4xNDcx
MTQ0LTEtbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDEwMTUx
NjA4MTkuMTQ3MTE0NC0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUEFU
Q0ggdjIgMC8yXSBxZW11LWdhOiBhZGQgc3NoLXthZGQscmVtb3ZlfS1hdXRob3JpemVkLWtleXMK
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNl
ID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMy
MWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3Bh
dGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDEwMTUx
NjA4MTkuMTQ3MTE0NC0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIw
MjAxMDE1MTYwODE5LjE0NzExNDQtMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20KU3dpdGNo
ZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwozY2FiZjRiIHFnYTogYWRkIHNzaC17YWRkLHJlbW92
ZX0tYXV0aG9yaXplZC1rZXlzCmJlZjdkNjggZ2xpYi1jb21wYXQ6IGFkZCBnX3VuaXhfZ2V0X3Bh
c3N3ZF9lbnRyeV9xZW11KCkKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMiBDaGVja2luZyBjb21t
aXQgYmVmN2Q2ODg4YjBiIChnbGliLWNvbXBhdDogYWRkIGdfdW5peF9nZXRfcGFzc3dkX2VudHJ5
X3FlbXUoKSkKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNl
cGFyYXRlIGxpbmUKIzQxOiBGSUxFOiBpbmNsdWRlL2dsaWItY29tcGF0Lmg6ODE6CisvKiBOb3Rl
OiBUaGUgZmFsbGJhY2sgaW1wbGVtZW50YXRpb24gaXMgbm90IE1ULXNhZmUsIGFuZCBpdCByZXR1
cm5zIGEgY29weSBvZgoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgdHJhaWxpbmcgKi8g
b24gYSBzZXBhcmF0ZSBsaW5lCiM0NDogRklMRTogaW5jbHVkZS9nbGliLWNvbXBhdC5oOjg0Ogor
ICogR0xpYiBBUEkgc3Vic3RpdHV0aW9uLiAqLwoKdG90YWw6IDAgZXJyb3JzLCAyIHdhcm5pbmdz
LCAzOCBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
Mi8yIENoZWNraW5nIGNvbW1pdCAzY2FiZjRiMTNiY2MgKHFnYTogYWRkIHNzaC17YWRkLHJlbW92
ZX0tYXV0aG9yaXplZC1rZXlzKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxl
KHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMyNzogCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0CgpFUlJPUjogVXNlIGdfYXNzZXJ0IG9yIGdfYXNzZXJ0X25vdF9yZWFjaGVkCiM2NDog
RklMRTogcWdhL2NvbW1hbmRzLXBvc2l4LXNzaC5jOjMzOgorICAgIGdfYXNzZXJ0X2NtcGludChy
ZXQsID09LCAwKTsKCkVSUk9SOiBVc2UgZ19hc3NlcnQgb3IgZ19hc3NlcnRfbm90X3JlYWNoZWQK
IzMxODogRklMRTogcWdhL2NvbW1hbmRzLXBvc2l4LXNzaC5jOjI4NzoKKyAgICBnX2Fzc2VydF9j
bXBpbnQocmV0LCA9PSwgMCk7CgpFUlJPUjogVXNlIGdfYXNzZXJ0IG9yIGdfYXNzZXJ0X25vdF9y
ZWFjaGVkCiMzMjM6IEZJTEU6IHFnYS9jb21tYW5kcy1wb3NpeC1zc2guYzoyOTI6CisgICAgZ19h
c3NlcnRfbm9fZXJyb3IoZXJyKTsKCkVSUk9SOiBVc2UgZ19hc3NlcnQgb3IgZ19hc3NlcnRfbm90
X3JlYWNoZWQKIzMzNTogRklMRTogcWdhL2NvbW1hbmRzLXBvc2l4LXNzaC5jOjMwNDoKKyAgICBn
X2Fzc2VydF9ub19lcnJvcihlcnIpOwoKRVJST1I6IFVzZSBnX2Fzc2VydCBvciBnX2Fzc2VydF9u
b3RfcmVhY2hlZAojMzM3OiBGSUxFOiBxZ2EvY29tbWFuZHMtcG9zaXgtc3NoLmM6MzA2OgorICAg
IGdfYXNzZXJ0X2NtcHN0cihjb250ZW50cywgPT0sIGV4cGVjdGVkKTsKCkVSUk9SOiBVc2UgZ19h
c3NlcnQgb3IgZ19hc3NlcnRfbm90X3JlYWNoZWQKIzM3NDogRklMRTogcWdhL2NvbW1hbmRzLXBv
c2l4LXNzaC5jOjM0MzoKKyAgICBnX2Fzc2VydF9udWxsKGVycik7CgpFUlJPUjogVXNlIGdfYXNz
ZXJ0IG9yIGdfYXNzZXJ0X25vdF9yZWFjaGVkCiMzODA6IEZJTEU6IHFnYS9jb21tYW5kcy1wb3Np
eC1zc2guYzozNDk6CisgICAgZ19hc3NlcnRfbnVsbChlcnIpOwoKRVJST1I6IFVzZSBnX2Fzc2Vy
dCBvciBnX2Fzc2VydF9ub3RfcmVhY2hlZAojNDAxOiBGSUxFOiBxZ2EvY29tbWFuZHMtcG9zaXgt
c3NoLmM6MzcwOgorICAgIGdfYXNzZXJ0X251bGwoZXJyKTsKCkVSUk9SOiBVc2UgZ19hc3NlcnQg
b3IgZ19hc3NlcnRfbm90X3JlYWNoZWQKIzQwNjogRklMRTogcWdhL2NvbW1hbmRzLXBvc2l4LXNz
aC5jOjM3NToKKyAgICBnX2Fzc2VydF9udWxsKGVycik7Cgp0b3RhbDogOSBlcnJvcnMsIDEgd2Fy
bmluZ3MsIDQ4MCBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzIgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMjAxMDE1MTYwODE5LjE0NzExNDQtMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vdGVz
dGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

