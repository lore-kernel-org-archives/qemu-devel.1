Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1A7C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 22:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A9D20706
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 22:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A9D20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igGHD-0005vQ-8q
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 17:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1igGGf-0005JG-8u
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 17:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1igGGc-0003Yf-Gb
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 17:52:08 -0500
Resent-Date: Sat, 14 Dec 2019 17:52:07 -0500
Resent-Message-Id: <E1igGGc-0003Yf-Gb@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1igGGb-0003Wj-BL
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 17:52:06 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1576363920; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SDd7fBCTuZYmFB5ZdpXvVQCqB4wEONgRIzdGdXVrkm2vdCStyYX5RuryotnBcj5huNEBPD43aQKQicnjYHu0X/j3DBOYIsirEEUiNpniRUTgkzbPje6bX1j1fYAKMovjvUCQKxqftaNEQ4o1rpqr2TJCXSMuQ5gaBzeRUOGm2Xc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1576363920;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=aqqGk0a10/rPZl05aGrsHiHsIaZuHQfvOwH7mr0MIMQ=; 
 b=i9qkSTi1FWqZztkZEZyE7XPULTUjfGC2Ieo4Xzrqy/8iq1lDMU6HxPXdW3qR6+4lJbDmwDoWV+tMwQwG3/RFoR12jBfz7ReQtzS8dUI71156z/PMupxqP8abu80tH1vCoAmSvOg7TGtly9RWkiTFfjMXM7pwlSPij/iww8uDD6k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1576363919350906.9678499416525;
 Sat, 14 Dec 2019 14:51:59 -0800 (PST)
In-Reply-To: <20191214121347.17071-1-joakim.tjernlund@infinera.com>
Subject: Re: [PATCH] ppc: remove excessive logging
Message-ID: <157636391850.20418.3375562763974198993@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: joakim.tjernlund@infinera.com
Date: Sat, 14 Dec 2019 14:51:59 -0800 (PST)
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
Cc: Joakim.Tjernlund@infinera.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTIxNDEyMTM0Ny4xNzA3
MS0xLWpvYWtpbS50amVybmx1bmRAaW5maW5lcmEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIHBwYzogcmVtb3ZlIGV4Y2Vz
c2l2ZSBsb2dnaW5nClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTIxNDEyMTM0Ny4xNzA3
MS0xLWpvYWtpbS50amVybmx1bmRAaW5maW5lcmEuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKZmF0YWw6IGZhaWxlZCB0byB3cml0ZSByZWYtcGFjayBmaWxlCmZhdGFs
OiBUaGUgcmVtb3RlIGVuZCBodW5nIHVwIHVuZXhwZWN0ZWRseQpUcmFjZWJhY2sgKG1vc3QgcmVj
ZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAicGF0Y2hldy10ZXN0ZXIyL3NyYy9wYXRjaGV3LWNsaSIs
IGxpbmUgNTMxLCBpbiB0ZXN0X29uZQogICAgZ2l0X2Nsb25lX3JlcG8oY2xvbmUsIHJbInJlcG8i
XSwgclsiaGVhZCJdLCBsb2dmLCBUcnVlKQogIEZpbGUgInBhdGNoZXctdGVzdGVyMi9zcmMvcGF0
Y2hldy1jbGkiLCBsaW5lIDYyLCBpbiBnaXRfY2xvbmVfcmVwbwogICAgc3VicHJvY2Vzcy5jaGVj
a19jYWxsKGNsb25lX2NtZCwgc3RkZXJyPWxvZ2YsIHN0ZG91dD1sb2dmKQogIEZpbGUgIi9vcHQv
cmgvcmgtcHl0aG9uMzYvcm9vdC91c3IvbGliNjQvcHl0aG9uMy42L3N1YnByb2Nlc3MucHkiLCBs
aW5lIDI5MSwgaW4gY2hlY2tfY2FsbAogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snZ2l0Jywg
J2Nsb25lJywgJy1xJywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9wYXRjaGV3LWdpdC1jYWNoZS9o
dHRwc2dpdGh1YmNvbXBhdGNoZXdwcm9qZWN0cWVtdS0zYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1ycDF4c2VpeC9z
cmMnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMTI4LgoKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMjE0MTIxMzQ3LjE3
MDcxLTEtam9ha2ltLnRqZXJubHVuZEBpbmZpbmVyYS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t


