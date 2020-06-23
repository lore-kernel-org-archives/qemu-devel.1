Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A1BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2B920768
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2B920768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jniaH-00017d-5b
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 09:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jniZW-0000he-I4
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:02:42 -0400
Resent-Date: Tue, 23 Jun 2020 09:02:42 -0400
Resent-Message-Id: <E1jniZW-0000he-I4@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jniZT-0003Db-Pa
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:02:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592917329; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EWw8Qj9CdFeGkWzAtPW534tbf4wYpxEgtDrDHxO4B3GxTYVJmXXukE/+FQIRwh1LQQe9gotiWonBl/HsAdMbFMZMAo/oI9PZcIyq+5uCBU4eUHkMd6RURb1Zi58fQJl0FJop4QCIlUwyeDavfi2Z+aJRW0RFZYFPz0hwdhab8B0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592917329;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=LzU9EBItZhgXA3tBSD9VCJ5YdRlXkLArQPm1owTf+Bg=; 
 b=GNhsYjRFOS++zXBylOQLPPshRIWfcgZtncB1xgjn6qHxH3RJBJ8Z9lAqVy+khwZ13Wl5XbAqnOMJ/1P682I1ptAfMYj+ZybsDwgumuL4KHWGZpi6gB8pEZ6vOdc0AEku+wZCCEG7MqKRGlAp5A4O66R2ugOABWOYsZAc083KtuM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592917327207227.38698159534988;
 Tue, 23 Jun 2020 06:02:07 -0700 (PDT)
Message-ID: <159291732571.6029.8642408239343726657@d1fd068a5071>
Subject: Re: [PATCH for-5.1 V5 0/4] mips: Add Loongson-3 machine support (with
 KVM)
In-Reply-To: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: zltjiangshi@gmail.com
Date: Tue, 23 Jun 2020 06:02:07 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 08:25:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTkyOTE0NDM4LTMwMzE3LTEt
Z2l0LXNlbmQtZW1haWwtY2hlbmhjQGxlbW90ZS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCBmb3ItNS4xIFY1IDAvNF0gbWlw
czogQWRkIExvb25nc29uLTMgbWFjaGluZSBzdXBwb3J0ICh3aXRoIEtWTSkKVHlwZTogc2VyaWVz
Ck1lc3NhZ2UtaWQ6IDE1OTI5MTQ0MzgtMzAzMTctMS1naXQtc2VuZC1lbWFpbC1jaGVuaGNAbGVt
b3RlLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBh
cnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6
Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBh
dGNoZXcvMTU5MjkxNDQzOC0zMDMxNy0xLWdpdC1zZW5kLWVtYWlsLWNoZW5oY0BsZW1vdGUuY29t
IC0+IHBhdGNoZXcvMTU5MjkxNDQzOC0zMDMxNy0xLWdpdC1zZW5kLWVtYWlsLWNoZW5oY0BsZW1v
dGUuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNjNlMTNhMiBNQUlOVEFJTkVS
UzogQWRkIExvb25nc29uLTMgbWFpbnRhaW5lciBhbmQgcmV2aWV3ZXIKNzI3ZmExNCBody9taXBz
OiBBZGQgTG9vbmdzb24tMyBtYWNoaW5lIHN1cHBvcnQgKHdpdGggS1ZNKQo1ZmQyMWEwIGh3L2lu
dGM6IEFkZCBMb29uZ3NvbiBsaW9pbnRjIHN1cHBvcnQKNjk5NmQ0OSBody9taXBzOiBJbXBsZW1l
bnQgdGhlIGt2bV90eXBlKCkgaG9vayBpbiBNYWNoaW5lQ2xhc3MKCj09PSBPVVRQVVQgQkVHSU4g
PT09CjEvNCBDaGVja2luZyBjb21taXQgNjk5NmQ0OTJlYzcxIChody9taXBzOiBJbXBsZW1lbnQg
dGhlIGt2bV90eXBlKCkgaG9vayBpbiBNYWNoaW5lQ2xhc3MpCjIvNCBDaGVja2luZyBjb21taXQg
NWZkMjFhMGJjZDgzIChody9pbnRjOiBBZGQgTG9vbmdzb24gbGlvaW50YyBzdXBwb3J0KQpXQVJO
SU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5l
ZWQgdXBkYXRpbmc/CiMzNjogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogbGluZSBvdmVy
IDkwIGNoYXJhY3RlcnMKIzkwOiBGSUxFOiBody9pbnRjL2xvb25nc29uX2xpb2ludGMuYzo1MDoK
KyNkZWZpbmUgTE9PTkdTT05fTElPSU5UQyhvYmopIE9CSkVDVF9DSEVDSyhzdHJ1Y3QgbG9vbmdz
b25fbGlvaW50YywgKG9iaiksIFRZUEVfTE9PTkdTT05fTElPSU5UQykKCkVSUk9SOiBvcGVuIGJy
YWNlICd7JyBmb2xsb3dpbmcgc3RydWN0IGdvIG9uIHRoZSBzYW1lIGxpbmUKIzkzOiBGSUxFOiBo
dy9pbnRjL2xvb25nc29uX2xpb2ludGMuYzo1MzoKK3N0cnVjdCBsb29uZ3Nvbl9saW9pbnRjCit7
CgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMxNDg6IEZJTEU6IGh3
L2ludGMvbG9vbmdzb25fbGlvaW50Yy5jOjEwODoKK15JICAgIGlmIChwLT5wYXJlbnRfc3RhdGVb
cGFyZW50XSAhPSQKCnRvdGFsOiAzIGVycm9ycywgMSB3YXJuaW5ncywgMjU2IGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDIvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy80IENoZWNraW5nIGNv
bW1pdCA3MjdmYTE0MmFiZWQgKGh3L21pcHM6IEFkZCBMb29uZ3Nvbi0zIG1hY2hpbmUgc3VwcG9y
dCAod2l0aCBLVk0pKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBk
b2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM4NDogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojNDA0OiBGSUxFOiBody9taXBzL2xv
b25nc29uM192aXJ0LmM6MzE2Ogorc3RhdGljIHZvaWQgbG9vbmdzb24zX3BtX3dyaXRlKHZvaWQg
Km9wYXF1ZSwgaHdhZGRyIGFkZHIsIHVpbnQ2NF90IHZhbCwgdW5zaWduZWQgc2l6ZSkKCldBUk5J
Tkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM3MDQ6IEZJTEU6IGh3L21pcHMvbG9vbmdzb24z
X3ZpcnQuYzo2MTY6CisgICAgZndfY2ZnX2FkZF9pMTYoZndfY2ZnLCBGV19DRkdfTUFYX0NQVVMs
ICh1aW50MTZfdCljdXJyZW50X21hY2hpbmUtPnNtcC5tYXhfY3B1cyk7CgpXQVJOSU5HOiBsaW5l
IG92ZXIgODAgY2hhcmFjdGVycwojODQwOiBGSUxFOiBody9taXBzL2xvb25nc29uM192aXJ0LmM6
NzUyOgorc3RhdGljIGlubGluZSB2b2lkIGxvb25nc29uM192aXJ0X2RldmljZXNfaW5pdChNYWNo
aW5lU3RhdGUgKm1hY2hpbmUsIERldmljZVN0YXRlICpwaWMpCgpXQVJOSU5HOiBsaW5lIG92ZXIg
ODAgY2hhcmFjdGVycwojODcxOiBGSUxFOiBody9taXBzL2xvb25nc29uM192aXJ0LmM6NzgzOgor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnZXRfc3lzdGVtX2lvKCksIDAsIHZpcnRfbWVt
bWFwW1ZJUlRfUENJRV9QSU9dLnNpemUpOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3Rl
cnMKIzk3NzogRklMRTogaHcvbWlwcy9sb29uZ3NvbjNfdmlydC5jOjg4OToKKyAgICAvKiBBbGxv
Y2F0ZSBSQU0vQklPUywgMHgwMDAwMDAwMH4weDEwMDAwMDAwIGlzIGFsaWFzIG9mIDB4ODAwMDAw
MDB+MHg5MDAwMDAwMCAqLwoKdG90YWw6IDAgZXJyb3JzLCA2IHdhcm5pbmdzLCA5OTkgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggMy80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjQvNCBDaGVja2lu
ZyBjb21taXQgNjNlMTNhMjk3MjkwIChNQUlOVEFJTkVSUzogQWRkIExvb25nc29uLTMgbWFpbnRh
aW5lciBhbmQgcmV2aWV3ZXIpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzE1OTI5MTQ0MzgtMzAzMTctMS1naXQtc2VuZC1lbWFpbC1jaGVuaGNAbGVt
b3RlLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

