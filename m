Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21B4C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B55A5205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55A5205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipB2q-0000NN-RK
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ipAcy-0005zo-KT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ipAcx-0008RK-4S
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:40:00 -0500
Resent-Date: Wed, 08 Jan 2020 07:40:00 -0500
Resent-Message-Id: <E1ipAcx-0008RK-4S@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ipAcw-0008Pp-Sy
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:39:59 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578487190; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TeBWs24pB78SDVDC8rLkvyajD4PS+Z6aktrJcjQ99Fv7R6y05dQNyN/s/nsKblRE53+9Hl8VfvqZAbEw3LuEfx4NmUWg29fudcU6UxkCBK1CNk0JWYITVME9X7GCXNXuhi1WkE18lJ9ExMfDEc0623V6z1CVQYSkVDqKHMtCZ0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1578487190;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=H0pZ+M1JJobE4npVqewmDYagq7tcsrkAD569JB3SuRY=; 
 b=TYIMZNyS+Ib4luL439q9kBN1K0b8Tb9rid9DpT2GfRXDYPvcvsB5JQuVDyNm4MTFtzLa+/5v+dKt6iMV22BKNRXcGZHgMx7Q9HnQYH4kMaTB9ye3AOO4RQQMayJVgyiLbc+mR/v17J6ctSD6xdBIZlXUm0mnCiT/uyeN+8udpHU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578487185517538.1974490469212;
 Wed, 8 Jan 2020 04:39:45 -0800 (PST)
In-Reply-To: <5245e15fbb05c85112b6c818b0de8c66c8f8b6b3.1578482882.git.tgolembi@redhat.com>
Subject: Re: [PATCH v7] qga: add command guest-get-devices for reporting
 VirtIO devices
Message-ID: <157848718447.3775.5293911452580417209@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tgolembi@redhat.com
Date: Wed, 8 Jan 2020 04:39:45 -0800 (PST)
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
Cc: marcandre.lureau@redhat.com, tgolembi@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS81MjQ1ZTE1ZmJiMDVjODUxMTJi
NmM4MThiMGRlOGM2NmM4ZjhiNmIzLjE1Nzg0ODI4ODIuZ2l0LnRnb2xlbWJpQHJlZGhhdC5jb20v
CgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9i
bGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQ
QVRDSCB2N10gcWdhOiBhZGQgY29tbWFuZCBndWVzdC1nZXQtZGV2aWNlcyBmb3IgcmVwb3J0aW5n
IFZpcnRJTyBkZXZpY2VzClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiA1MjQ1ZTE1ZmJiMDVjODUx
MTJiNmM4MThiMGRlOGM2NmM4ZjhiNmIzLjE1Nzg0ODI4ODIuZ2l0LnRnb2xlbWJpQHJlZGhhdC5j
b20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0
aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3
LzUyNDVlMTVmYmIwNWM4NTExMmI2YzgxOGIwZGU4YzY2YzhmOGI2YjMuMTU3ODQ4Mjg4Mi5naXQu
dGdvbGVtYmlAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzUyNDVlMTVmYmIwNWM4NTExMmI2YzgxOGIw
ZGU4YzY2YzhmOGI2YjMuMTU3ODQ4Mjg4Mi5naXQudGdvbGVtYmlAcmVkaGF0LmNvbQpTd2l0Y2hl
ZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmY4MTFjZTUgcWdhOiBhZGQgY29tbWFuZCBndWVzdC1n
ZXQtZGV2aWNlcyBmb3IgcmVwb3J0aW5nIFZpcnRJTyBkZXZpY2VzCgo9PT0gT1VUUFVUIEJFR0lO
ID09PQpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCiMyNTA6
IEZJTEU6IHFnYS9jb21tYW5kcy13aW4zMi5jOjIzOTU6CisgICAgICAgICAgICBkZXZpY2UtPmFk
ZHJlc3MgPSBnX25ldzAoR3Vlc3REZXZpY2VBZGRyZXNzLDEpOwogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAxIGVycm9ycywg
MCB3YXJuaW5ncywgMzEyIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBmODExY2U1YTMyZDMgKHFnYTog
YWRkIGNvbW1hbmQgZ3Vlc3QtZ2V0LWRldmljZXMgZm9yIHJlcG9ydGluZyBWaXJ0SU8gZGV2aWNl
cykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvNTI0NWUxNWZiYjA1Yzg1MTEyYjZjODE4YjBkZThjNjZj
OGY4YjZiMy4xNTc4NDgyODgyLmdpdC50Z29sZW1iaUByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2tw
YXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


