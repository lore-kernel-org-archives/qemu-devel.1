Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBD0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BF2206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 13:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BF2206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k81sc-0007AG-1j
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 09:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k81rY-0005Dg-8f
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:41:16 -0400
Resent-Date: Tue, 18 Aug 2020 09:41:16 -0400
Resent-Message-Id: <E1k81rY-0005Dg-8f@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k81rW-0003fw-Ch
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 09:41:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597758064; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IZ2N/mOzGBI2EVPRe2LsL4dpmjO+bbVNO/Ex+tFYoyb2Y5fqzTc2fr5VsaYVOvbdp1RxDO+WypxUGmJGrml8Rrqim5IixcEaTfewUcb0ccxJ2UQ5Ta5TYsEDCW7ed3QiM9a4bGshIStSaUQyNsaAzIRKqeyXCUtOOHdhfWn7+mY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597758064;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=9COKslc5XAa/8FOQ2VK9qGgZWjx83ZiGLbw/CdYGjKk=; 
 b=JM2Oo188Yb+BIO7S24/ngKdJDusnX5dqJkUjvV2I1BFwlkBxvtwYfWAtQkkg8ktdBoUSqRe/QayuJ+V3DsZRbJRhnUHsQAOw7dKLv7nuDzlSj5eLt0IIgPTH464PRvrHPboms3X1TLFOT6wyykfrLL5J8pj9Bw9xlbdlsNe3GsU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597758061552211.66524336279235;
 Tue, 18 Aug 2020 06:41:01 -0700 (PDT)
Subject: Re: [PATCH] audio/jack: fix use after free segfault
Message-ID: <159775806110.19075.15009674619306182388@66eaa9a8a123>
In-Reply-To: <20200818131206.BB75F3A0B9F@moya.office.hostfission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: geoff@hostfission.com
Date: Tue, 18 Aug 2020 06:41:01 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:56:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxODEzMTIwNi5CQjc1
RjNBMEI5RkBtb3lhLm9mZmljZS5ob3N0Zmlzc2lvbi5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDgx
ODEzMTIwNi5CQjc1RjNBMEI5RkBtb3lhLm9mZmljZS5ob3N0Zmlzc2lvbi5jb20KU3ViamVjdDog
W1BBVENIXSBhdWRpby9qYWNrOiBmaXggdXNlIGFmdGVyIGZyZWUgc2VnZmF1bHQKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2
NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKOGVj
NDAwZSBhdWRpby9qYWNrOiBmaXggdXNlIGFmdGVyIGZyZWUgc2VnZmF1bHQKCj09PSBPVVRQVVQg
QkVHSU4gPT09CldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM0MDogRklMRTogYXVk
aW8vamFja2F1ZGlvLmM6NTczOgorICAgICAgICAgKiBUaGlzIHdpbGwgbm90IGNhdXNlIGEgbWVt
b3J5IGxlYWsgYXMgdGhlIHJlY292ZXJ5IHJvdXRpbmUgd2lsbCB0cmlnZ2VyCgpFUlJPUjogZG8g
bm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzQ2OiBGSUxFOiBhdWRpby9qYWNrYXVkaW8uYzo1Nzk6
CisgICAgICAgIC8vamFja19jbGllbnRfY2xvc2UoYy0+Y2xpZW50KTsKCnRvdGFsOiAxIGVycm9y
cywgMSB3YXJuaW5ncywgMjMgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDhlYzQwMGVjMDg2YSAoYXVk
aW8vamFjazogZml4IHVzZSBhZnRlciBmcmVlIHNlZ2ZhdWx0KSBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2Rl
OiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8yMDIwMDgxODEzMTIwNi5CQjc1RjNBMEI5RkBtb3lhLm9mZmljZS5ob3N0Zmlzc2lvbi5jb20v
dGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

