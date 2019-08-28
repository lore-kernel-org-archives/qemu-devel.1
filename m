Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5630C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A798C2077B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 13:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A798C2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2xyt-00044t-MT
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 09:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i2xxq-0003Y0-3I
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i2xxn-00069a-9s
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 09:26:16 -0400
Resent-Date: Wed, 28 Aug 2019 09:26:16 -0400
Resent-Message-Id: <E1i2xxn-00069a-9s@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i2xxn-00065J-0m; Wed, 28 Aug 2019 09:26:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566998758; cv=none; d=zoho.com; s=zohoarc; 
 b=KfiW6tiELhSenqNPVZR/VaSnVB3ofdRSSb+AmeL9+Kt0ify7ld0PzZ6qf6WeWzjkOq5b+/ZFppbSbwQWfLXC5WJXkk/1gUHdVaHvithxFb3VMSkwjfx1KqvWkAXgvpQ0FvSyvLEuBC3tFag1Y1frC+wu/ug66IKUWRv81DQa04c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1566998758;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=8zDujl1LhS8s7J1IoVITnAytqwtRxjcEaEVoeMB93is=; 
 b=LY6XzP/KYvxbDjFGAQuar+8ExyqU8TzIMPTIzOY+T2AGlyHnTFeX9W4yrlxIwLxAEX/G+U2jYWscaGP0Z3XcF8kYrvlblv8nWdLegmj20Cbt5IiKk5m/UewT/CiL2sX1wpI1jQJ+Ur2z52SCt0vI84j+XRhEalQAYwbSTjxWSpc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1566998757186127.57169888269539;
 Wed, 28 Aug 2019 06:25:57 -0700 (PDT)
In-Reply-To: <20190828125654.10544-1-dplotnikov@virtuozzo.com>
Message-ID: <156699875569.24670.5599069659331362449@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dplotnikov@virtuozzo.com
Date: Wed, 28 Aug 2019 06:25:57 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v4 0/3] qcow2: add zstd cluster compression
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgyODEyNTY1NC4xMDU0
NC0xLWRwbG90bmlrb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA4MjgxMjU2NTQuMTA1NDQtMS1kcGxv
dG5pa292QHZpcnR1b3p6by5jb20KVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRldmVsXSBb
UEFUQ0ggdjQgMC8zXSBxY293MjogYWRkIHpzdGQgY2x1c3RlciBjb21wcmVzc2lvbgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo5
ZjdjNWQ3IHFjb3cyOiBhZGQgenN0ZCBjbHVzdGVyIGNvbXByZXNzaW9uCjY5ZGQ1NzIgcWNvdzI6
IHJld29yayB0aGUgY2x1c3RlciBjb21wcmVzc2lvbiByb3V0aW5lCjE1ODMxZjIgcWNvdzI6IGlu
dHJvZHVjZSBjb21wcmVzc2lvbiB0eXBlIGZlYXR1cmUKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEv
MyBDaGVja2luZyBjb21taXQgMTU4MzFmMjk4YWUyIChxY293MjogaW50cm9kdWNlIGNvbXByZXNz
aW9uIHR5cGUgZmVhdHVyZSkKMi8zIENoZWNraW5nIGNvbW1pdCA2OWRkNTcyODk1N2MgKHFjb3cy
OiByZXdvcmsgdGhlIGNsdXN0ZXIgY29tcHJlc3Npb24gcm91dGluZSkKMy8zIENoZWNraW5nIGNv
bW1pdCA5ZjdjNWQ3ZGFiNmUgKHFjb3cyOiBhZGQgenN0ZCBjbHVzdGVyIGNvbXByZXNzaW9uKQpF
UlJPUjogc3BhY2UgcHJvaGliaXRlZCBhZnRlciB0aGF0IG9wZW4gcGFyZW50aGVzaXMgJygnCiMx
Mzc6IEZJTEU6IGJsb2NrL3Fjb3cyLXRocmVhZHMuYzoyNDg6CisgICAgc19zaXplID0gYmUzMl90
b19jcHUoICooY29uc3QgdWludDMyX3QgKikgc3JjKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgMjY4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAxOTA4MjgxMjU2NTQuMTA1NDQtMS1kcGxvdG5pa292QHZpcnR1b3p6by5jb20vdGVzdGluZy5j
aGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


