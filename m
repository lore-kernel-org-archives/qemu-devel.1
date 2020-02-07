Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E01C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8BC217BA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8BC217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0AfX-0007yE-6s
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 15:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j0Aew-0007Rp-AH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j0Aeu-0008So-SK
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:55:30 -0500
Resent-Date: Fri, 07 Feb 2020 15:55:29 -0500
Resent-Message-Id: <E1j0Aeu-0008So-SK@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j0Aeu-0008BH-KQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:55:28 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581108908038457.03868509125925;
 Fri, 7 Feb 2020 12:55:08 -0800 (PST)
In-Reply-To: <20200207150118.23007-1-alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 0/5] plugins/next
Message-ID: <158110890691.591.17436168520005858248@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Fri, 7 Feb 2020 12:55:08 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: robert.foley@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIwNzE1MDExOC4yMzAw
Ny0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAgdjEgMC81XSBwbHVnaW5zL25leHQKTWVz
c2FnZS1pZDogMjAyMDAyMDcxNTAxMTguMjMwMDctMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnClR5
cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2
LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0
Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0
cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAg
IHBhdGNoZXcvMjAyMDAyMDcxNTAxMTguMjMwMDctMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnIC0+
IHBhdGNoZXcvMjAyMDAyMDcxNTAxMTguMjMwMDctMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNDFiMmMzZCB0ZXN0cy9wbHVnaW5zOiBtYWtl
IGhvd3ZlYyBjbGVhbi11cCBhZnRlciBpdHNlbGYuCjEwN2NhYzkgdGFyZ2V0L3Jpc2N2OiBwcm9n
cmVzc2l2ZWx5IGxvYWQgdGhlIGluc3RydWN0aW9uIGR1cmluZyBkZWNvZGUKZjRkOWMyYSB0ZXN0
cy9wbHVnaW46IHByZXZlbnQgdW5pbml0aWFsaXplZCB3YXJuaW5nCmYwYzYxNDEgcGx1Z2lucy9j
b3JlOiBhZGQgbWlzc2luZyBicmVhayBpbiBjYl90b190Y2dfZmxhZ3MKMWI3ZmNlNCBkb2NzL2Rl
dmVsOiBkb2N1bWVudCBxdWVyeSBoYW5kbGUgbGlmZXRpbWVzCgo9PT0gT1VUUFVUIEJFR0lOID09
PQoxLzUgQ2hlY2tpbmcgY29tbWl0IDFiN2ZjZTRkZmRlOCAoZG9jcy9kZXZlbDogZG9jdW1lbnQg
cXVlcnkgaGFuZGxlIGxpZmV0aW1lcykKMi81IENoZWNraW5nIGNvbW1pdCBmMGM2MTQxNjk0MjEg
KHBsdWdpbnMvY29yZTogYWRkIG1pc3NpbmcgYnJlYWsgaW4gY2JfdG9fdGNnX2ZsYWdzKQozLzUg
Q2hlY2tpbmcgY29tbWl0IGY0ZDljMmE4ZGFhYSAodGVzdHMvcGx1Z2luOiBwcmV2ZW50IHVuaW5p
dGlhbGl6ZWQgd2FybmluZykKNC81IENoZWNraW5nIGNvbW1pdCAxMDdjYWM5MGNjNzQgKHRhcmdl
dC9yaXNjdjogcHJvZ3Jlc3NpdmVseSBsb2FkIHRoZSBpbnN0cnVjdGlvbiBkdXJpbmcgZGVjb2Rl
KQpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzExMDogRklMRTogdGFyZ2V0L3Jpc2N2
L3RyYW5zbGF0ZS5jOjcyNjoKKyAgICAgICAgb3Bjb2RlMzIgPSBkZXBvc2l0MzIob3Bjb2RlMzIs
IDE2LCAxNiwgdHJhbnNsYXRvcl9sZHV3KGVudiwgY3R4LT5iYXNlLnBjX25leHQgKyAyKSk7Cgp0
b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDEwMyBsaW5lcyBjaGVja2VkCgpQYXRjaCA0LzUg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjUvNSBDaGVja2luZyBjb21taXQgNDFiMmMzZGM4
ZDc3ICh0ZXN0cy9wbHVnaW5zOiBtYWtlIGhvd3ZlYyBjbGVhbi11cCBhZnRlciBpdHNlbGYuKQo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDIw
NzE1MDExOC4yMzAwNy0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNo
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

