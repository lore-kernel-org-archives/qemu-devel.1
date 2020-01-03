Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A98C00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 21:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A3B21835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 21:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A3B21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inUb9-0002fz-5K
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 16:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1inUaV-0002Eu-CR
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1inUaT-0001i8-Qg
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:34:31 -0500
Resent-Date: Fri, 03 Jan 2020 16:34:30 -0500
Resent-Message-Id: <E1inUaT-0001i8-Qg@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1inUaT-0001Zf-IT
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:34:29 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578087262; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jR6N7YobUKwVVb0U5F7KWjmgy4dtLbhPnJRusVV5rt3nE1HiYETytQl4DUdF7ur0Kc57Sr+EDPOdnqU5o8R7AIZeWhglo0woBOjurmvBdRxZrUoRjgO3fELfPo4BgZnBVv6CmLjMa3+v3IHIlh4G5vu/pVjZRKFh9M3B+EqijNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1578087262;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=swjRjVFRP9b5OvYJ9ap8Z6WotD9MRSD6a7e2f+pzTvY=; 
 b=X1rcHy4qkR5gLHGILI/aocZ+vmsX64LIYIIGS8bm6OsRfTyXe1/vTn1psAxwF3D6GNieLqJtZ/YDGoKw2FbPy0rPWfAOB7SbxLcZoW6K9hdvzaAZ3WsjcVkKhxSEDtQeps7dZ00T30l2F8zHujKOvLOR8dsJdkm95+LNy15TJek=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578087260334742.3143895506244;
 Fri, 3 Jan 2020 13:34:20 -0800 (PST)
In-Reply-To: <20200103212500.14384-1-richard.henderson@linaro.org>
Subject: Re: [PATCH 0/3] capstone: update to next
Message-ID: <157808725991.18970.6654200309304888295@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Fri, 3 Jan 2020 13:34:20 -0800 (PST)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEwMzIxMjUwMC4xNDM4
NC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAwLzNdIGNhcHN0b25lOiB1cGRh
dGUgdG8gbmV4dApUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDAxMDMyMTI1MDAuMTQzODQt
MS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKZmF0YWw6IHVuYWJsZSB0byB3cml0ZSBuZXcgaW5kZXggZmlsZQp3YXJuaW5n
OiBDbG9uZSBzdWNjZWVkZWQsIGJ1dCBjaGVja291dCBmYWlsZWQuCllvdSBjYW4gaW5zcGVjdCB3
aGF0IHdhcyBjaGVja2VkIG91dCB3aXRoICdnaXQgc3RhdHVzJwphbmQgcmV0cnkgdGhlIGNoZWNr
b3V0IHdpdGggJ2dpdCBjaGVja291dCAtZiBIRUFEJwoKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBj
YWxsIGxhc3QpOgogIEZpbGUgInBhdGNoZXctdGVzdGVyMi9zcmMvcGF0Y2hldy1jbGkiLCBsaW5l
IDUzMSwgaW4gdGVzdF9vbmUKICAgIGdpdF9jbG9uZV9yZXBvKGNsb25lLCByWyJyZXBvIl0sIHJb
ImhlYWQiXSwgbG9nZiwgVHJ1ZSkKICBGaWxlICJwYXRjaGV3LXRlc3RlcjIvc3JjL3BhdGNoZXct
Y2xpIiwgbGluZSA2MiwgaW4gZ2l0X2Nsb25lX3JlcG8KICAgIHN1YnByb2Nlc3MuY2hlY2tfY2Fs
bChjbG9uZV9jbWQsIHN0ZGVycj1sb2dmLCBzdGRvdXQ9bG9nZikKICBGaWxlICIvb3B0L3JoL3Jo
LXB5dGhvbjM2L3Jvb3QvdXNyL2xpYjY0L3B5dGhvbjMuNi9zdWJwcm9jZXNzLnB5IiwgbGluZSAy
OTEsIGluIGNoZWNrX2NhbGwKICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBj
bWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ2dpdCcsICdjbG9u
ZScsICctcScsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcGF0Y2hldy1naXQtY2FjaGUvaHR0cHNn
aXRodWJjb21wYXRjaGV3cHJvamVjdHFlbXUtM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NCcsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtMXlhXzNyMngvc3JjJ10n
IHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDEyOC4KCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDEwMzIxMjUwMC4xNDM4NC0x
LXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t


