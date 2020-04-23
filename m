Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078FFC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 03:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C1620747
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 03:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C1620747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRSW7-0007jH-2b
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 23:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRSVV-0006bC-KC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 23:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRSVV-00047V-1A
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 23:26:33 -0400
Resent-Date: Wed, 22 Apr 2020 23:26:33 -0400
Resent-Message-Id: <E1jRSVV-00047V-1A@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRSVU-00045s-Hb
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 23:26:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587612382; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WOy0DGFJoawDXHAUgDhBQ1gjsZLXRvKgXjA4q/BUNuRN0dbcjb2QPQ9PgmNfGR2pomyJHLJz3MESReJUhNW4V8zTLISxtSkSp4S0QFPiewaxSFyhvs7I5PYTGBdb8p5b+x9trYcqHzSANCt4p5cUhcSnVVqKtmqGJkVKHsyJkx4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587612382;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=rxKnGrN0i4D15YuI4LIg41M6+zIobsd2WwOYy0gxaz4=; 
 b=nxlhsbCOpqE2+/YHah5JB0GgmVQBvsgid7HPAst8+IH+gBvalJ47Qbc+rZjvz7Oe2K9DTrwLqHKl0XBH2gNjM/cfKS487KLpeXJXSvSbVV9DlB2x88R31uZ1VvyKVk3lmNH3KYChkLiYLHw4z3BWNzJNHYxZoyuKdDEFcloW1tE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587612380740450.3706725849262;
 Wed, 22 Apr 2020 20:26:20 -0700 (PDT)
In-Reply-To: <20200423023212.20968-1-zxq_yx_007@163.com>
Subject: Re: [PATCH] qemu-sockets: add abstract UNIX domain socket support
Message-ID: <158761237948.4520.6707669437809528888@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: zxq_yx_007@163.com
Date: Wed, 22 Apr 2020 20:26:20 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 23:25:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: zxq_yx_007@163.com, berrange@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMzAyMzIxMi4yMDk2
OC0xLXp4cV95eF8wMDdAMTYzLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSBxZW11LXNvY2tldHM6IGFkZCBhYnN0cmFjdCBV
TklYIGRvbWFpbiBzb2NrZXQgc3VwcG9ydApNZXNzYWdlLWlkOiAyMDIwMDQyMzAyMzIxMi4yMDk2
OC0xLXp4cV95eF8wMDdAMTYzLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKOGNiZTdiMSBxZW11LXNv
Y2tldHM6IGFkZCBhYnN0cmFjdCBVTklYIGRvbWFpbiBzb2NrZXQgc3VwcG9ydAoKPT09IE9VVFBV
VCBCRUdJTiA9PT0KV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzM1OiBGSUxFOiB1
dGlsL3FlbXUtc29ja2V0cy5jOjk2OToKKyAgICAgICAgc2VydmVybGVuID0gc3RybGVuKHNhZGRy
LT5wYXRoKSArIG9mZnNldG9mKHN0cnVjdCBzb2NrYWRkcl91biwgc3VuX3BhdGgpOwoKRVJST1I6
IGVsc2Ugc2hvdWxkIGZvbGxvdyBjbG9zZSBicmFjZSAnfScKIzM3OiBGSUxFOiB1dGlsL3FlbXUt
c29ja2V0cy5jOjk3MToKKyAgICB9CisgICAgZWxzZSB7Cgp0b3RhbDogMSBlcnJvcnMsIDEgd2Fy
bmluZ3MsIDI2IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA4Y2JlN2IxZjc3MzYgKHFlbXUtc29ja2V0
czogYWRkIGFic3RyYWN0IFVOSVggZG9tYWluIHNvY2tldCBzdXBwb3J0KSBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDIwMDQyMzAyMzIxMi4yMDk2OC0xLXp4cV95eF8wMDdAMTYzLmNvbS90ZXN0aW5n
LmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

