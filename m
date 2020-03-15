Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C50C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAD1206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAD1206B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDb6N-0003RZ-1r
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 17:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jDayR-00017C-59
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jDayP-0006qi-MC
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:39:06 -0400
Resent-Date: Sun, 15 Mar 2020 17:39:06 -0400
Resent-Message-Id: <E1jDayP-0006qi-MC@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jDayP-0006aa-Df
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:39:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584308337; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Lvk+E4wVT2LBEaJLeqjhIxHSiz1cy00DYhVEpeBcLr2YxyQv1EjBiWf6+P4V9DA+Ldc6SAA/knW1sboXN7DbeyW/2GXm7uAjJuz9behU4xtaQSx8WpnfGkAeJrRTfEA5onUmsCInRDc6s/ZPSlFh1zg3PRgXGMbORoMTONvHCtk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584308337;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=sK/OC2xZmHhC7OIAk80RIrhBzCCsBrp0BN/tprRJRus=; 
 b=jxSU0PPJyXEWlZ4Dwh6ee9VAVPB2EWuJNyXcPuWD6WJT60fPLiIf4U1U6N+n9Z1sdVL3i11fMM8SoterITbz0pTJ2WIeI6vazuUVIAcKJ1cHNMjNbUpg5wNwyo2YNldjbiGetJeZxMyA5jPHlfmI0VwEUZnNqAheNIxBQUcJ07k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584308335615282.3592061085843;
 Sun, 15 Mar 2020 14:38:55 -0700 (PDT)
In-Reply-To: <20200313184607.11792-1-philmd@redhat.com>
Subject: Re: [PATCH 0/9] user-mode: Prune build dependencies (part 3)
Message-ID: <158430833392.6054.8869416470900156865@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Sun, 15 Mar 2020 14:38:55 -0700 (PDT)
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com, armbru@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMzE4NDYwNy4xMTc5
Mi0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNh
biBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIg
b3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2Jh
Ymx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14
ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBD
QyAgICAgIHg4Nl82NC1zb2Z0bW11L2NwdXMubwogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvZ2Ri
c3R1Yi5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9iYWxsb29uLm8KY2xhbmctODogZXJyb3I6
IGxpbmtlciBjb21tYW5kIGZhaWxlZCB3aXRoIGV4aXQgY29kZSAxICh1c2UgLXYgdG8gc2VlIGlu
dm9jYXRpb24pCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazoxMjQ6IHFl
bXUtc3RvcmFnZS1kYWVtb25dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNo
ZWQgam9icy4uLi4KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2lvcG9ydC5vCiAgQ0MgICAgICB4
ODZfNjQtc29mdG1tdS9xdGVzdC5vCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJl
dGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vk
bycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD0yYmZmYTJhM2FlOWY0YzVhYmNhYzQ5OWE4NDE1MjAxNScsICctdScsICcxMDAxJywgJy0t
c2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdF
VF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICct
ZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0n
LCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hl
dy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1kYW9qdzliZS9zcmMvZG9ja2VyLXNyYy4yMDIwLTAz
LTE1LTE3LjM0LjIwLjE4Mzc2Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcv
dmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LWRlYnVnJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQg
c3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTJi
ZmZhMmEzYWU5ZjRjNWFiY2FjNDk5YTg0MTUyMDE1Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0g
RXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLWRhb2p3OWJlL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtZGVidWdAZmVk
b3JhXSBFcnJvciAyCgpyZWFsICAgIDRtMzQuMzU5cwp1c2VyICAgIDBtOC41NjZzCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDMxMzE4
NDYwNy4xMTc5Mi0xLXBoaWxtZEByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

