Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7B4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8539A2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8539A2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOtJ-0001JK-Sg
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joOsg-0000RH-Vr
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:13:18 -0400
Resent-Date: Thu, 25 Jun 2020 06:13:18 -0400
Resent-Message-Id: <E1joOsg-0000RH-Vr@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joOse-0003X9-8e
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:13:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593079983; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dnIM8fmqEUQ2O21Dxpl9Cx4+O7KRzRqS9eEJSzGam9CTQ2/zrmIVgnnX+yCPJXzYKgdP3xdZEr+HyYQzs0utByxXArHSrS+1VrO2/Gs2ziGGhe0YJFUrhz5LMJ76d5noGbLIa3/79lxFvWc/p4Ndd/UeUJ3iZCjsNsISgQkW9HA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593079983;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=U6Xo7VE1ectGPKSONX7G9FyGlRmW/nckK/wKgPJloHw=; 
 b=DUyP3xE/XrlH1akVqAnRSiUmmQvY4Pj5P31v/up7q3CAOAK5n2iuazloaCr1C4bJB6rM3oh8H36pBmumIYl7eVM/PSNjJMusQnnZA6DtHv7J4MNoGBQ5UXTsX5ReVbY5C/GAOdieOFoJDAS7OwoJmHo6S9R1M+Ne3VUXJBJ2T4o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593079980904671.2143910798958;
 Thu, 25 Jun 2020 03:13:00 -0700 (PDT)
Message-ID: <159307997945.21628.15474632752104060786@d1fd068a5071>
Subject: Re: [RFC 0/4] Enable virtio-fs on s390x
In-Reply-To: <20200625100430.22407-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mhartmay@linux.ibm.com
Date: Thu, 25 Jun 2020 03:13:00 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 06:13:13
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
Cc: berrange@redhat.com, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, stefanha@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyNTEwMDQzMC4yMjQw
Ny0xLW1oYXJ0bWF5QGxpbnV4LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtSRkMgMC80XSBFbmFibGUgdmlydGlvLWZzIG9uIHMz
OTB4ClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDYyNTEwMDQzMC4yMjQwNy0xLW1oYXJ0
bWF5QGxpbnV4LmlibS5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gK
Z2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1
ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9j
aGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpV
cGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0
cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAg
IHBhdGNoZXcvMjAyMDA2MjIxNTMzMTguNzUxMTA3LTEtYmVycmFuZ2VAcmVkaGF0LmNvbSAtPiBw
YXRjaGV3LzIwMjAwNjIyMTUzMzE4Ljc1MTEwNy0xLWJlcnJhbmdlQHJlZGhhdC5jb20KICogW25l
dyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDYyNTEwMDQzMC4yMjQwNy0xLW1oYXJ0bWF5QGxp
bnV4LmlibS5jb20gLT4gcGF0Y2hldy8yMDIwMDYyNTEwMDQzMC4yMjQwNy0xLW1oYXJ0bWF5QGxp
bnV4LmlibS5jb20KICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDYyNTEwMDgxMS4x
MjY5MC0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZyAtPiBwYXRjaGV3LzIwMjAwNjI1MTAwODEx
LjEyNjkwLTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKYjJjZDcxOSBIQUNLOiBIYXJkLWNvZGUgdGhlIGxpYnZob3N0LXVzZXIuby1jZmxh
Z3MgZm9yIHMzOTB4CmYwYmE2ZDUgbGlidmhvc3QtdXNlcjogaGFuZGxlIGVuZGlhbm5lc3MgYXMg
bWFuZGF0ZWQgYnkgdGhlIHNwZWMKNWYyZmViYSBsaWJ2aG9zdC11c2VyOiBwcmludCBpbnZhbGlk
IGFkZHJlc3Mgb24gdnVfcGFuaWMKMTk5OTRlMCB2aXJ0aW86IGFkZCB2aG9zdC11c2VyLWZzLWNj
dyBkZXZpY2UKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNCBDaGVja2luZyBjb21taXQgMTk5OTRl
MDFhNjdjICh2aXJ0aW86IGFkZCB2aG9zdC11c2VyLWZzLWNjdyBkZXZpY2UpCldBUk5JTkc6IGFk
ZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRh
dGluZz8KIzI1OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBh
ZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikKIzg2OiBGSUxFOiBody9zMzkweC92aG9zdC11c2VyLWZz
LWNjdy5jOjU3OgorICAgIGRldmljZV9jbGFzc19zZXRfcHJvcHMoZGMsdmhvc3RfdXNlcl9mc19j
Y3dfcHJvcGVydGllcyk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAx
IGVycm9ycywgMSB3YXJuaW5ncywgODEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS80IGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZh
bHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFU
Q0ggaW4gTUFJTlRBSU5FUlMuCgoyLzQgQ2hlY2tpbmcgY29tbWl0IDVmMmZlYmExZTNjNSAobGli
dmhvc3QtdXNlcjogcHJpbnQgaW52YWxpZCBhZGRyZXNzIG9uIHZ1X3BhbmljKQozLzQgQ2hlY2tp
bmcgY29tbWl0IGYwYmE2ZDUzMjVjMSAobGlidmhvc3QtdXNlcjogaGFuZGxlIGVuZGlhbm5lc3Mg
YXMgbWFuZGF0ZWQgYnkgdGhlIHNwZWMpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVk
IGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzI3OiAKbmV3IGZpbGUg
bW9kZSAxMDA2NDQKCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMg
b2YgdGhpcyBzdGF0ZW1lbnQKIzEwMDogRklMRTogY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZo
b3N0LWFjY2Vzcy5oOjY5OgorICAgIGlmICh2dV9hY2Nlc3NfaXNfYmlnX2VuZGlhbih2ZGV2KSkK
Wy4uLl0KCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhp
cyBzdGF0ZW1lbnQKIzEwNzogRklMRTogY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LWFj
Y2Vzcy5oOjc2OgorICAgIGlmICh2dV9hY2Nlc3NfaXNfYmlnX2VuZGlhbih2ZGV2KSkKWy4uLl0K
CkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0
ZW1lbnQKIzExNDogRklMRTogY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LWFjY2Vzcy5o
OjgzOgorICAgIGlmICh2dV9hY2Nlc3NfaXNfYmlnX2VuZGlhbih2ZGV2KSkKWy4uLl0KCldBUk5J
Tkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMzNzU6IEZJTEU6IGNvbnRyaWIvbGlidmhvc3Qt
dXNlci9saWJ2aG9zdC11c2VyLmM6MjUxNToKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB2dV9sZHFfcChkZXYsICZkZXNjW2ldLmFkZHIpLCB2dV9sZGxfcChkZXYsICZkZXNjW2ldLmxl
bikpOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzM4NDogRklMRTogY29udHJp
Yi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYzoyNTIzOgorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZ1X2xkcV9wKGRldiwgJmRlc2NbaV0uYWRkciksIHZ1X2xkbF9wKGRldiwg
JmRlc2NbaV0ubGVuKSk7Cgp0b3RhbDogMyBlcnJvcnMsIDMgd2FybmluZ3MsIDM5MiBsaW5lcyBj
aGVja2VkCgpQYXRjaCAzLzQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQvNCBDaGVja2lu
ZyBjb21taXQgYjJjZDcxOTk3ODI4IChIQUNLOiBIYXJkLWNvZGUgdGhlIGxpYnZob3N0LXVzZXIu
by1jZmxhZ3MgZm9yIHMzOTB4KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8yMDIwMDYyNTEwMDQzMC4yMjQwNy0xLW1oYXJ0bWF5QGxpbnV4LmlibS5j
b20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

