Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2BAC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A8C2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A8C2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieO8T-0002gy-Pp
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ieNcU-0001Hk-MC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ieNcT-0008PE-3P
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:18:54 -0500
Resent-Date: Mon, 09 Dec 2019 13:18:54 -0500
Resent-Message-Id: <E1ieNcT-0008PE-3P@eggs.gnu.org>
Received: from sender4-of-o50.zoho.com ([136.143.188.50]:21040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ieNcS-0008Oj-SK
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:18:53 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575915524; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HCS+AKT6u4CMdb/17OC0HnRWG1P7YQ6PAC9bWdhNcUH9NWf5o1NsLclzU1HSYXYal9uyCUxplwiC8SbqSbUt7rZ7Uhc/Hkr/71w+6XoevIhl6K0CXuazZo5vkbzdZXntjn3GC49X7VaOU/AbRIOrXZljmgkodPDvBOpiHseF/FY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575915524;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=mvdRq1vIMN/a7UZmc+BeY4Z8b4PGB06K2qveCyZF2Co=; 
 b=RUG+ME0TSbhyH/bxI9HS2aHySdtBBnnhjUj4XrBcg/BJHXJlTiFBENV1gf25ciHPkWHAda/VUXOKf3AbLRmZxBZz2V+OqzK3gLJJrKlL2qZ/my9wsy1x/Gm5UWrOTnsvJQ6uaUCr1OhVWmaN7PUK64eOdEfR1r7dQejBsoiDN4E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575915522711655.6558440913589;
 Mon, 9 Dec 2019 10:18:42 -0800 (PST)
In-Reply-To: <20191209125248.5849-1-thuth@redhat.com>
Subject: Re: [libvirt] [PATCH v2 0/4] Remove deprecated pc-0.x machine types
 and related hacks
Message-ID: <157591552130.7675.1004391530900578576@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Mon, 9 Dec 2019 10:18:42 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.50
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
Cc: ehabkost@redhat.com, mst@redhat.com, libvir-list@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTIwOTEyNTI0OC41ODQ5
LTEtdGh1dGhAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTdWJtb2R1bGUgJ2R0YycgKGh0dHBz
Oi8vZ2l0LnFlbXUub3JnL2dpdC9kdGMuZ2l0KSByZWdpc3RlcmVkIGZvciBwYXRoICdkdGMnCkNs
b25pbmcgaW50byAnZHRjJy4uLgpyZW1vdGU6IENvdW50aW5nIG9iamVjdHM6IDUyODAsIGRvbmUu
ICAgICAgICAKZXJyb3I6IFJQQyBmYWlsZWQ7IHJlc3VsdD0xOCwgSFRUUCBjb2RlID0gMjAwCmZh
dGFsOiBUaGUgcmVtb3RlIGVuZCBodW5nIHVwIHVuZXhwZWN0ZWRseQpmYXRhbDogcHJvdG9jb2wg
ZXJyb3I6IGJhZCBwYWNrIGhlYWRlcgpDbG9uZSBvZiAnaHR0cHM6Ly9naXQucWVtdS5vcmcvZ2l0
L2R0Yy5naXQnIGludG8gc3VibW9kdWxlIHBhdGggJ2R0YycgZmFpbGVkCmZhaWxlZCB0byB1cGRh
dGUgc3VibW9kdWxlIGR0YwpTdWJtb2R1bGUgJ2R0YycgKGh0dHBzOi8vZ2l0LnFlbXUub3JnL2dp
dC9kdGMuZ2l0KSB1bnJlZ2lzdGVyZWQgZm9yIHBhdGggJ2R0YycKbWFrZVsxXTogKioqIFsvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAteF9mbnFjbzEvc3JjL2RvY2tlci1zcmMuMjAxOS0xMi0w
OS0xMy4xMy41NC4xMzk2NF0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXhfZm5xY28xL3NyYycKbWFrZTogKioqIFtkb2NrZXIt
cnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICA0bTQ4LjUwN3MKdXNlciAg
ICAwbTIuNDU3cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAxOTEyMDkxMjUyNDguNTg0OS0xLXRodXRoQHJlZGhhdC5jb20vdGVzdGluZy5k
b2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


