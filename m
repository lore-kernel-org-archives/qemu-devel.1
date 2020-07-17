Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21199C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66072070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66072070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwNay-00030n-2K
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 06:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jwNa4-0002KF-Qf
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:27:04 -0400
Resent-Date: Fri, 17 Jul 2020 06:27:04 -0400
Resent-Message-Id: <E1jwNa4-0002KF-Qf@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jwNa1-00077G-TD
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 06:27:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594981609; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TgJT6VEXyKMnhEGqNaL+OKtAixydA/tR2sKXobOapHzqGFYb9IEDbbKm9W5WB1htfca0Le52cvkg7s3LAcrN48IbFeYE8QAEeLPi2wETQaKJJmShjrNbJITYKwNoiwGxaNt5Mq76wN0kolsVjPzqEwvzsBoIjO8rAAZWkHrcIwA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594981609;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=QWBqNkF3jq5OhqY4+4ES/IPMS3/U93wZ+7oWJNtZE48=; 
 b=CYu03OVV1DzEaL8FW+h8g580+O/cG/3UjmpHEz6/SFt8DkF8M5Vz0JkoqIj0RHIM5kL5e1uM+hGQgAqJQY2yUdsZgpg9teRkVywzcjVPWDbpq9S0EytVcuIG/ViacZzQbfDgN3F7D/qtlyAk5GaArXykYCyTThzdf0WOS9j5cCA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594981605776814.6722179310952;
 Fri, 17 Jul 2020 03:26:45 -0700 (PDT)
Subject: Re: [RFC v2 0/3] Enable virtio-fs on s390x
Message-ID: <159498160510.17162.14939030906063593858@07a7f0d89f7d>
In-Reply-To: <20200717092929.19453-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mhartmay@linux.ibm.com
Date: Fri, 17 Jul 2020 03:26:45 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 06:26:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com,
 stefanha@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNzA5MjkyOS4xOTQ1
My0xLW1oYXJ0bWF5QGxpbnV4LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDcxNzA5MjkyOS4x
OTQ1My0xLW1oYXJ0bWF5QGxpbnV4LmlibS5jb20KU3ViamVjdDogW1JGQyB2MiAwLzNdIEVuYWJs
ZSB2aXJ0aW8tZnMgb24gczM5MHgKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jh
c2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMg
VHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmE2ZDFiNmQgbGlidmhvc3QtdXNlcjog
ZmVuY2UgbGVnYWN5IHZpcnRpbyBkZXZpY2VzCjk2ODg1N2MgbGlidmhvc3QtdXNlcjogaGFuZGxl
IGVuZGlhbm5lc3MgYXMgbWFuZGF0ZWQgYnkgdGhlIHNwZWMKMmM3YmQ0YiB2aXJ0aW86IGFkZCB2
aG9zdC11c2VyLWZzLWNjdyBkZXZpY2UKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMyBDaGVja2lu
ZyBjb21taXQgMmM3YmQ0YmM1MjE2ICh2aXJ0aW86IGFkZCB2aG9zdC11c2VyLWZzLWNjdyBkZXZp
Y2UpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRB
SU5FUlMgbmVlZCB1cGRhdGluZz8KIzI1OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiBz
cGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikKIzg1OiBGSUxFOiBody9zMzkw
eC92aG9zdC11c2VyLWZzLWNjdy5jOjU2OgorICAgIGRldmljZV9jbGFzc19zZXRfcHJvcHMoZGMs
dmhvc3RfdXNlcl9mc19jY3dfcHJvcGVydGllcyk7CiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF4KCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgODAgbGluZXMgY2hlY2tlZAoKUGF0
Y2ggMS8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVz
ZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5l
ciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzMgQ2hlY2tpbmcgY29tbWl0IDk2
ODg1N2NmZDliZSAobGlidmhvc3QtdXNlcjogaGFuZGxlIGVuZGlhbm5lc3MgYXMgbWFuZGF0ZWQg
YnkgdGhlIHNwZWMpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRv
ZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzI5OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
CkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0
ZW1lbnQKIzc1OiBGSUxFOiBjb250cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtYWNjZXNzLmg6
NDI6CisgICAgaWYgKHZ1X2FjY2Vzc19pc19iaWdfZW5kaWFuKHZkZXYpKQpbLi4uXQoKRVJST1I6
IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAoj
ODI6IEZJTEU6IGNvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC1hY2Nlc3MuaDo0OToKKyAg
ICBpZiAodnVfYWNjZXNzX2lzX2JpZ19lbmRpYW4odmRldikpClsuLi5dCgpFUlJPUjogYnJhY2Vz
IHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiM4OTogRklM
RTogY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LWFjY2Vzcy5oOjU2OgorICAgIGlmICh2
dV9hY2Nlc3NfaXNfYmlnX2VuZGlhbih2ZGV2KSkKWy4uLl0KCldBUk5JTkc6IGxpbmUgb3ZlciA4
MCBjaGFyYWN0ZXJzCiMzNDc6IEZJTEU6IGNvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11
c2VyLmM6MjUxMjoKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2dV9sZHFfcChkZXYs
ICZkZXNjW2ldLmFkZHIpLCB2dV9sZGxfcChkZXYsICZkZXNjW2ldLmxlbikpOwoKV0FSTklORzog
bGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzM1NjogRklMRTogY29udHJpYi9saWJ2aG9zdC11c2Vy
L2xpYnZob3N0LXVzZXIuYzoyNTIwOgorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ1
X2xkcV9wKGRldiwgJmRlc2NbaV0uYWRkciksIHZ1X2xkbF9wKGRldiwgJmRlc2NbaV0ubGVuKSk7
Cgp0b3RhbDogMyBlcnJvcnMsIDMgd2FybmluZ3MsIDM2MiBsaW5lcyBjaGVja2VkCgpQYXRjaCAy
LzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvMyBDaGVja2luZyBjb21taXQgYTZkMWI2
ZGFjYWM4IChsaWJ2aG9zdC11c2VyOiBmZW5jZSBsZWdhY3kgdmlydGlvIGRldmljZXMpCldBUk5J
Tkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiM0
ODogRklMRTogY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYzo1NDQ6CisgICAg
ICAgIC8qIFdlIG9ubHkgc3VwcG9ydCBkZXZpY2VzIGNvbmZvcm1pbmcgdG8gVklSVElPIDEuMCBv
cgoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgdHJhaWxpbmcgKi8gb24gYSBzZXBhcmF0
ZSBsaW5lCiM0OTogRklMRTogY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYzo1
NDU6CisgICAgICAgICAqIGxhdGVyICovCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVy
cwojNTA6IEZJTEU6IGNvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmM6NTQ2Ogor
ICAgICAgICB2dV9wYW5pYyhkZXYsICJ2aXJ0aW8gbGVnYWN5IGRldmljZXMgYXJlbid0IHN1cHBv
cnRlZCBieSBsaWJ2aG9zdC11c2VyIik7Cgp0b3RhbDogMCBlcnJvcnMsIDMgd2FybmluZ3MsIDMz
IGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0g
T1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDcxNzA5
MjkyOS4xOTQ1My0xLW1oYXJ0bWF5QGxpbnV4LmlibS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t

