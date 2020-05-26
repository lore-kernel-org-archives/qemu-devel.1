Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2277EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 02:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB7A207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 02:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB7A207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdPFG-00017j-8m
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 22:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdPD4-0007jF-DC
 for qemu-devel@nongnu.org; Mon, 25 May 2020 22:20:54 -0400
Resent-Date: Mon, 25 May 2020 22:20:54 -0400
Resent-Message-Id: <E1jdPD4-0007jF-DC@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdPD2-0005CI-Oa
 for qemu-devel@nongnu.org; Mon, 25 May 2020 22:20:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590459642; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FNJ5xbjgLKxmmt31rofhQOHiuDGD7+EtA+OJMDvcMKGg3aoFw1FyJI/lt+S5Ve+lUE1hWyZe6YxoDmN3RVNwj9fb9ooW2tTwPnkbJq9lxv7u7rnIH0r0V/ekQuFXqyRfOfzHVL6Q+pVBUOh6FugvqaTLZU3d2N74DA2fRw+/VtA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590459642;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=zegIwipOgg/WBZPiq/9F4GpJeMX5llWXGcORwgZzupY=; 
 b=hcCov+x21mjuHtlf9XeYWbxl94+TUziCs42HHJNMZ69KObILvSA2lhlIkKtnpBAZgXDCah9xXwZZE7crVK8aRfTBVV3ZKzsaSsYK6QJP/Q+Uckmbo9enTjN5uz1O/0pySC6EhWOkaHFlAh01jJ4LDtHE1leE2pxLR/6nvVVPlZc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590459641011872.5016078482716;
 Mon, 25 May 2020 19:20:41 -0700 (PDT)
Message-ID: <159045963940.6628.11787238104403003017@45ef0f9c86ae>
In-Reply-To: <20200525172704.32142-1-f4bug@amsat.org>
Subject: Re: [RFC PATCH] tests/qtest/fuzz: Add direct MemoryRegion fuzzer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Mon, 25 May 2020 19:20:41 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 21:48:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: lvivier@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org,
 f4bug@amsat.org, alxndr@bu.edu, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyNTE3MjcwNC4zMjE0
Mi0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MjUxNzI3MDQuMzIxNDItMS1mNGJ1Z0BhbXNhdC5v
cmcKU3ViamVjdDogW1JGQyBQQVRDSF0gdGVzdHMvcXRlc3QvZnV6ejogQWRkIGRpcmVjdCBNZW1v
cnlSZWdpb24gZnV6emVyClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKOTFmMzRjMyB0ZXN0cy9x
dGVzdC9mdXp6OiBBZGQgZGlyZWN0IE1lbW9yeVJlZ2lvbiBmdXp6ZXIKCj09PSBPVVRQVVQgQkVH
SU4gPT09CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJ
TlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzExODogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJP
UjogTWFjcm9zIHdpdGggbXVsdGlwbGUgc3RhdGVtZW50cyBzaG91bGQgYmUgZW5jbG9zZWQgaW4g
YSBkbyAtIHdoaWxlIGxvb3AKIzI1MDogRklMRTogdGVzdHMvcXRlc3QvZnV6ei9tZW1vcnlfcmVn
aW9uX2Z1enouYzoxMjg6CisjZGVmaW5lIENBU0VfT1BfUkVBRChPUCwgT1BUWVBFLCBBRERSVywg
REFUQVcsIE1SKSBcCisgICAgICAgIGNhc2UgT1AjI0FERFJXIyNSRUFEIyNEQVRBVzpcCisgICAg
ICAgICAgICBzeiA9IHNpemVvZihhLT5vcGNvZGUpXAorICAgICAgICAgICAgICAgKyBzaXplb2Yo
YS0+T1BUWVBFIyNBRERSVy5hZGRyKVwKKyAgICAgICAgICAgICAgICsgc2l6ZW9mKHVpbnQjI0RB
VEFXIyNfdCk7XAorICAgICAgICAgICAgaWYgKFNpemUgPCBzeikge1wKKyAgICAgICAgICAgICAg
ICByZXR1cm47XAorICAgICAgICAgICAgfVwKKyAgICAgICAgICAgIGFkZHIgPSBhLT5PUFRZUEUj
I0FERFJXLmFkZHIgJiBpb21hc2s7XAorICAgICAgICAgICAgbWVtb3J5X3JlZ2lvbl9kaXNwYXRj
aF9yZWFkKE1SLCBhZGRyLCAmcmR2YWwsXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpemVfbWVtb3Aoc2l6ZW9mKHVpbnQjI0RBVEFXIyNfdCkpLFwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVEKTtc
CisgICAgICAgICAgICBicmVhawoKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIHRoYXQgY2xv
c2UgYnJhY2UgJ30nCiMyNTc6IEZJTEU6IHRlc3RzL3F0ZXN0L2Z1enovbWVtb3J5X3JlZ2lvbl9m
dXp6LmM6MTM1OgorICAgICAgICAgICAgfVwKCkVSUk9SOiBNYWNyb3Mgd2l0aCBtdWx0aXBsZSBz
dGF0ZW1lbnRzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBhIGRvIC0gd2hpbGUgbG9vcAojMjYzOiBG
SUxFOiB0ZXN0cy9xdGVzdC9mdXp6L21lbW9yeV9yZWdpb25fZnV6ei5jOjE0MToKKyNkZWZpbmUg
Q0FTRV9PUF9XUklURShPUCwgT1BUWVBFLCBBRERSVywgREFUQVcsIE1SKSBcCisgICAgICAgIGNh
c2UgT1AjI0FERFJXIyNXUklURSMjREFUQVc6XAorICAgICAgICAgICAgc3ogPSBzaXplb2YoYS0+
b3Bjb2RlKVwKKyAgICAgICAgICAgICAgICsgc2l6ZW9mKGEtPk9QVFlQRSMjQUREUlcuYWRkcilc
CisgICAgICAgICAgICAgICArIHNpemVvZih1aW50IyNEQVRBVyMjX3QpO1wKKyAgICAgICAgICAg
IGlmIChTaXplIDwgc3opIHtcCisgICAgICAgICAgICAgICAgcmV0dXJuO1wKKyAgICAgICAgICAg
IH1cCisgICAgICAgICAgICBhZGRyID0gYS0+T1BUWVBFIyNBRERSVy5hZGRyICYgaW9tYXNrO1wK
KyAgICAgICAgICAgIG1lbW9yeV9yZWdpb25fZGlzcGF0Y2hfd3JpdGUoTVIsIGFkZHIsXAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhLT5PUFRZUEUjI0FERFJXLnZh
bCMjREFUQVdbMF0sXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
aXplX21lbW9wKHNpemVvZih1aW50IyNEQVRBVyMjX3QpKSxcCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQpO1wKKyAgICAgICAg
ICAgIGJyZWFrCgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCBjbG9zZSBicmFjZSAn
fScKIzI3MDogRklMRTogdGVzdHMvcXRlc3QvZnV6ei9tZW1vcnlfcmVnaW9uX2Z1enouYzoxNDg6
CisgICAgICAgICAgICB9XAoKRVJST1I6IE1hY3JvcyB3aXRoIG11bHRpcGxlIHN0YXRlbWVudHMg
c2hvdWxkIGJlIGVuY2xvc2VkIGluIGEgZG8gLSB3aGlsZSBsb29wCiMyNzk6IEZJTEU6IHRlc3Rz
L3F0ZXN0L2Z1enovbWVtb3J5X3JlZ2lvbl9mdXp6LmM6MTU3OgorI2RlZmluZSBDQVNFX01FTU9Q
KEFERFJXLCBEQVRBVykgXAorICAgICAgICBDQVNFX09QX1JFQUQoTUVNLCBtZW0sIEFERFJXLCBE
QVRBVywgbXIpO1wKKyAgICAgICAgQ0FTRV9PUF9XUklURShNRU0sIG1lbSwgQUREUlcsIERBVEFX
LCBtcikKCnRvdGFsOiA1IGVycm9ycywgMSB3YXJuaW5ncywgMjM3IGxpbmVzIGNoZWNrZWQKCkNv
bW1pdCA5MWYzNGMzMWZlMWQgKHRlc3RzL3F0ZXN0L2Z1eno6IEFkZCBkaXJlY3QgTWVtb3J5UmVn
aW9uIGZ1enplcikgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09
CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MjUxNzI3MDQuMzIxNDItMS1m
NGJ1Z0BhbXNhdC5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

