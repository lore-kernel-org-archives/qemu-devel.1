Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D20FC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454C3206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454C3206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMgm-0001DY-GL
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jCMgF-0000nU-JX
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jCMgD-00063Q-7O
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:11:14 -0400
Resent-Date: Thu, 12 Mar 2020 08:11:14 -0400
Resent-Message-Id: <E1jCMgD-00063Q-7O@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21137)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jCMgC-000633-Vx
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:11:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584015063; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GhYGJP9qnnPk9FoRN7vWgIfsPXBAUSDG0bC3ENBMIPJFLJbws5Qfsm+h4ZjAzIYLmZAgRbeiL0S7Kf5NaAuc9iYiwl701kBsOfo6HkFrLvXogyNOq2fv+gCw6axS1cssY9X2Y99RcbHnhFLqub0NmdI8C5UlaqK93tlJX1ZAJxQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584015063;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=hhkoTIbVXw8Vz/q0rYWhSXQrnyqSNQv1jRv/XWnbcTc=; 
 b=JcALxo05PwR474LWvFo2zYkNzWs7X/1EXF+iYe2GAieMRXVgtU8PSOB49aOYJh0Di3+76IwyHQBtfuRVLP5TWHU4GhWXZ9N2TBZ+TJ/TlQ6KUyDS2gHX3igCRMRLS+YVtnOZLTd2LC7hQPxmm980oqTtOU6JRv7GfSuRgFRCI7Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158401506151687.78830822769066;
 Thu, 12 Mar 2020 05:11:01 -0700 (PDT)
In-Reply-To: <1584010572-10308-1-git-send-email-teawater@gmail.com>
Subject: Re: [PATCH] virtio_balloon: Add option mprotect to handle guest
 kernel cheat issue
Message-ID: <158401506048.15607.3483321028926526943@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: teawater@gmail.com
Date: Thu, 12 Mar 2020 05:11:01 -0700 (PDT)
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
Cc: qemu-devel@nongnu.org, teawater@gmail.com, teawaterz@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg0MDEwNTcyLTEwMzA4LTEt
Z2l0LXNlbmQtZW1haWwtdGVhd2F0ZXJAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIHZpcnRpb19iYWxsb29uOiBB
ZGQgb3B0aW9uIG1wcm90ZWN0IHRvIGhhbmRsZSBndWVzdCBrZXJuZWwgY2hlYXQgaXNzdWUKTWVz
c2FnZS1pZDogMTU4NDAxMDU3Mi0xMDMwOC0xLWdpdC1zZW5kLWVtYWlsLXRlYXdhdGVyQGdtYWls
LmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gK
Z2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1
ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9j
aGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpG
cm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogICA2ZThhNzNlLi41
OTMxZWQ1ICBtYXN0ZXIgICAgIC0+IG1hc3RlcgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rl
c3QnCjQ1MjgzMjYgdmlydGlvX2JhbGxvb246IEFkZCBvcHRpb24gbXByb3RlY3QgdG8gaGFuZGxl
IGd1ZXN0IGtlcm5lbCBjaGVhdCBpc3N1ZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KV0FSTklORzog
QmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzIyNDog
RklMRTogaHcvdmlydGlvL3ZpcnRpby1iYWxsb29uLmM6MTI2OgorICAgICAgICAvKiBXZSBpZ25v
cmUgZXJyb3JzIGZyb20gX19yYW1fYmxvY2tfZGlzY2FyZF9yYW5nZSgpLCBiZWNhdXNlIGl0CgpF
UlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVt
ZW50CiMyMzI6IEZJTEU6IGh3L3ZpcnRpby92aXJ0aW8tYmFsbG9vbi5jOjE1MDoKKyAgICBpZiAo
YmFsbG9vbi0+ZG9fbXByb3RlY3QpClsuLi5dCgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3Ms
IDE4MSBsaW5lcyBjaGVja2VkCgpDb21taXQgNDUyODMyNjQ1M2IxICh2aXJ0aW9fYmFsbG9vbjog
QWRkIG9wdGlvbiBtcHJvdGVjdCB0byBoYW5kbGUgZ3Vlc3Qga2VybmVsIGNoZWF0IGlzc3VlKSBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8xNTg0MDEwNTcyLTEwMzA4LTEtZ2l0LXNlbmQtZW1haWwtdGVh
d2F0ZXJAZ21haWwuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==

