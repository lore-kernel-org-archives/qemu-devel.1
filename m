Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FD7C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A9321BE6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A9321BE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvI6k-0004Oa-Cp
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53924)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hvI6D-0003ic-Br
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hvI6C-0008BA-3q
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:19:13 -0400
Resent-Date: Wed, 07 Aug 2019 05:19:13 -0400
Resent-Message-Id: <E1hvI6C-0008BA-3q@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hvI6B-00088g-SI
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:19:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565169533; cv=none; d=zoho.com; s=zohoarc; 
 b=XaZyBVfhK40PxqoTEiEEZfUsxSHASKid6PGgfcKi73cqgWix0iVTWuWW1p25CLbZbv36qDknmfQdkHaY76Bjx0pa2rK49niORqomU8iZJyc/tXtITXOn8IaYK45HcV6IRDuBAzOXio54h27QpziYoMsvo7p7mTdGv90LRnN1MhI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1565169533;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=3OeqBh9puinqwe5E9Le6SR9V+uIDCBcsnE+CwpIor1Y=; 
 b=KKKS5uzlOop5y1Y9P9FIWZZUFzElT3Z+52rcmfC8FqI5mS4t+lg12bFlmknwY4qKq3XONkbkjV/DaC41IBhHPcaIQQRhPhfM6U5LoU0QwYGfLuklByEriGpLBkAL0TBukkzrCbHBV00Ue/W/cGaLh/yZM9Iagefqwko+sDkYLrM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1565169530593850.8146374808339;
 Wed, 7 Aug 2019 02:18:50 -0700 (PDT)
In-Reply-To: <20190807071445.4109-1-bala24@linux.ibm.com>
Message-ID: <156516952904.4245.10432537201729642128@b08f24806b7e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: bala24@linux.ibm.com
Date: Wed, 7 Aug 2019 02:18:50 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Enhancing Qemu MMIO emulation with
 scripting interface
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
Cc: maddy@linux.vnet.ibm.com, qemu-devel@nongnu.org, bala24@linux.ibm.com,
 anju@linux.vnet.ibm.com, clg@kaod.org, hari@linux.vnet.ibm.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgwNzA3MTQ0NS40MTA5
LTEtYmFsYTI0QGxpbnV4LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBh
c2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVp
ciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJv
YmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFr
ZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBhY2NlbC90Y2cv
dHJhY2UubwogIENDICAgICAgY3J5cHRvL3RyYWNlLm8KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90
bXAvcWVtdS10ZXN0L3NyYy91dGlsL3B5dGhvbl9hcGkuYzoxOgovdG1wL3FlbXUtdGVzdC9zcmMv
aW5jbHVkZS9zeXNlbXUvcHl0aG9uX2FwaS5oOjU6MTA6IGZhdGFsIGVycm9yOiAnUHl0aG9uLmgn
IGZpbGUgbm90IGZvdW5kCiNpbmNsdWRlIDxQeXRob24uaD4KICAgICAgICAgXn5+fn5+fn5+fgog
IENDICAgICAgbW9uaXRvci90cmFjZS5vCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDgwNzA3MTQ0NS40MTA5LTEtYmFsYTI0QGxpbnV4
LmlibS5jb20vdGVzdGluZy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


